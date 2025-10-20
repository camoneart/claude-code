#!/bin/bash

# Claude Code Plugin Manual Installer
# Usage: ./install-plugin-manually.sh <marketplace-name> <plugin-name> [--local]

set -e

# Color codes for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Print colored messages
print_error() {
    echo -e "${RED}✗ $1${NC}"
}

print_success() {
    echo -e "${GREEN}✓ $1${NC}"
}

print_warning() {
    echo -e "${YELLOW}⚠ $1${NC}"
}

print_info() {
    echo -e "${BLUE}ℹ $1${NC}"
}

# Show usage
show_usage() {
    cat << EOF
Usage: $0 <marketplace-name> <plugin-name> [options]

Options:
  --local         Install to project-local .claude/ instead of global ~/.claude/
  --dry-run       Show what would be installed without actually copying
  --help          Show this help message

Examples:
  # Install globally
  $0 claude-code-workflows javascript-typescript

  # Install to project-local
  $0 claude-code-workflows javascript-typescript --local

  # Dry run (preview only)
  $0 claude-code-workflows javascript-typescript --dry-run

EOF
    exit 1
}

# Parse arguments
MARKETPLACE=""
PLUGIN=""
INSTALL_LOCAL=false
DRY_RUN=false

while [[ $# -gt 0 ]]; do
    case $1 in
        --local)
            INSTALL_LOCAL=true
            shift
            ;;
        --dry-run)
            DRY_RUN=true
            shift
            ;;
        --help)
            show_usage
            ;;
        *)
            if [[ -z "$MARKETPLACE" ]]; then
                MARKETPLACE="$1"
            elif [[ -z "$PLUGIN" ]]; then
                PLUGIN="$1"
            else
                print_error "Unknown argument: $1"
                show_usage
            fi
            shift
            ;;
    esac
done

# Validate arguments
if [[ -z "$MARKETPLACE" ]] || [[ -z "$PLUGIN" ]]; then
    print_error "Both marketplace-name and plugin-name are required"
    show_usage
fi

# Set paths
MARKETPLACE_PATH="$HOME/.claude/plugins/marketplaces/$MARKETPLACE"
PLUGIN_PATH="$MARKETPLACE_PATH/plugins/$PLUGIN"

if [[ "$INSTALL_LOCAL" == true ]]; then
    INSTALL_BASE=".claude"
    print_info "Installing to project-local: $INSTALL_BASE"
else
    INSTALL_BASE="$HOME/.claude"
    print_info "Installing to global: $INSTALL_BASE"
fi

# Verify marketplace exists
if [[ ! -d "$MARKETPLACE_PATH" ]]; then
    print_error "Marketplace not found: $MARKETPLACE_PATH"
    print_info "Available marketplaces:"
    ls -1 "$HOME/.claude/plugins/marketplaces/" 2>/dev/null || echo "  (none)"
    exit 1
fi

# Verify plugin exists
if [[ ! -d "$PLUGIN_PATH" ]]; then
    print_error "Plugin not found: $PLUGIN_PATH"
    print_info "Available plugins in $MARKETPLACE:"
    ls -1 "$MARKETPLACE_PATH/plugins/" 2>/dev/null || echo "  (none)"
    exit 1
fi

# Create destination directories
if [[ "$DRY_RUN" == false ]]; then
    mkdir -p "$INSTALL_BASE/agents"
    mkdir -p "$INSTALL_BASE/commands"
    mkdir -p "$INSTALL_BASE/skills"
fi

print_info "Analyzing plugin: $PLUGIN"
echo ""

# Track what was installed
INSTALLED_AGENTS=0
INSTALLED_COMMANDS=0
INSTALLED_SKILLS=0

# Install agents
if [[ -d "$PLUGIN_PATH/agents" ]]; then
    AGENT_COUNT=$(find "$PLUGIN_PATH/agents" -name "*.md" | wc -l | tr -d ' ')
    if [[ $AGENT_COUNT -gt 0 ]]; then
        print_info "Found $AGENT_COUNT agent(s):"
        find "$PLUGIN_PATH/agents" -name "*.md" -exec basename {} \; | sed 's/^/  - /'

        if [[ "$DRY_RUN" == false ]]; then
            cp "$PLUGIN_PATH/agents"/*.md "$INSTALL_BASE/agents/" 2>/dev/null
            print_success "Installed $AGENT_COUNT agent(s)"
        else
            print_warning "[DRY RUN] Would install $AGENT_COUNT agent(s)"
        fi
        INSTALLED_AGENTS=$AGENT_COUNT
        echo ""
    fi
fi

# Install commands
if [[ -d "$PLUGIN_PATH/commands" ]]; then
    COMMAND_COUNT=$(find "$PLUGIN_PATH/commands" -name "*.md" | wc -l | tr -d ' ')
    if [[ $COMMAND_COUNT -gt 0 ]]; then
        print_info "Found $COMMAND_COUNT command(s):"
        find "$PLUGIN_PATH/commands" -name "*.md" -exec basename {} \; | sed 's/^/  - /' | sed 's/.md$//'

        if [[ "$DRY_RUN" == false ]]; then
            cp "$PLUGIN_PATH/commands"/*.md "$INSTALL_BASE/commands/" 2>/dev/null
            print_success "Installed $COMMAND_COUNT command(s)"
        else
            print_warning "[DRY RUN] Would install $COMMAND_COUNT command(s)"
        fi
        INSTALLED_COMMANDS=$COMMAND_COUNT
        echo ""
    fi
fi

# Install skills
if [[ -d "$PLUGIN_PATH/skills" ]]; then
    SKILL_COUNT=$(find "$PLUGIN_PATH/skills" -mindepth 1 -maxdepth 1 -type d | wc -l | tr -d ' ')
    if [[ $SKILL_COUNT -gt 0 ]]; then
        print_info "Found $SKILL_COUNT skill(s):"
        find "$PLUGIN_PATH/skills" -mindepth 1 -maxdepth 1 -type d -exec basename {} \; | sed 's/^/  - /'

        if [[ "$DRY_RUN" == false ]]; then
            cp -r "$PLUGIN_PATH/skills"/* "$INSTALL_BASE/skills/" 2>/dev/null
            print_success "Installed $SKILL_COUNT skill(s)"
        else
            print_warning "[DRY RUN] Would install $SKILL_COUNT skill(s)"
        fi
        INSTALLED_SKILLS=$SKILL_COUNT
        echo ""
    fi
fi

# Check for special components
SPECIAL_COMPONENTS=false

if [[ -f "$PLUGIN_PATH/.mcp.json" ]]; then
    print_warning "Plugin contains .mcp.json (MCP server configuration)"
    print_info "This requires manual merge into $INSTALL_BASE/settings.json"
    echo ""
    SPECIAL_COMPONENTS=true
fi

if [[ -f "$PLUGIN_PATH/hooks/hooks.json" ]]; then
    print_warning "Plugin contains hooks/hooks.json"
    print_info "This requires manual merge into $INSTALL_BASE/settings.json"
    echo ""
    SPECIAL_COMPONENTS=true
fi

# Summary
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
if [[ "$DRY_RUN" == true ]]; then
    print_warning "DRY RUN SUMMARY (no changes made)"
else
    print_success "INSTALLATION SUMMARY"
fi
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "  Plugin:     $PLUGIN"
echo "  From:       $MARKETPLACE"
echo "  Installed:"
echo "    - Agents:   $INSTALLED_AGENTS"
echo "    - Commands: $INSTALLED_COMMANDS"
echo "    - Skills:   $INSTALLED_SKILLS"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"

if [[ "$DRY_RUN" == false ]]; then
    if [[ $((INSTALLED_AGENTS + INSTALLED_COMMANDS + INSTALLED_SKILLS)) -eq 0 ]]; then
        print_warning "No components were installed"
        print_info "Plugin may be empty or use a different structure"
        exit 1
    fi

    echo ""
    print_success "Installation complete!"
    echo ""
    print_info "Next steps:"
    echo "  1. Restart Claude Code to load new components"
    echo "  2. Verify with /help (for commands) and /agents (for agents)"

    if [[ "$SPECIAL_COMPONENTS" == true ]]; then
        echo "  3. Manually merge MCP/hooks config into settings.json"
    fi
else
    echo ""
    print_info "Remove --dry-run to perform actual installation"
fi
