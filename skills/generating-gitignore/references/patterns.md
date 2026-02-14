# .gitignore Pattern Reference

> This file is a comprehensive pattern dictionary referenced by the generating-gitignore skill.
> Patterns are organized by category for selective assembly.

---

## OS

### macOS

```gitignore
.DS_Store
._*
.AppleDouble
.LSOverride
.Spotlight-V100
.Trashes
```

### Windows

```gitignore
Thumbs.db
Thumbs.db:encryptable
ehthumbs.db
ehthumbs_vista.db
Desktop.ini
$RECYCLE.BIN/
*.lnk
```

### Linux

```gitignore
*~
.fuse_hidden*
.directory
.Trash-*
.nfs*
```

---

## Editor / IDE

### VS Code

```gitignore
.vscode/*
!.vscode/settings.json
!.vscode/tasks.json
!.vscode/launch.json
!.vscode/extensions.json
!.vscode/*.code-snippets
*.vsix
```

### JetBrains (IntelliJ, WebStorm, PyCharm, etc.)

```gitignore
.idea/
*.iws
*.iml
*.ipr
```

### Vim / Neovim

```gitignore
*.swp
*.swo
*~
[._]*.s[a-v][a-z]
!*.svg
[._]*.sw[a-p]
[._]s[a-rt-v][a-z]
[._]ss[a-gi-z]
[._]sw[a-p]
Session.vim
Sessionx.vim
.netrwhist
tags
```

### Emacs

```gitignore
*~
\#*\#
/.emacs.desktop
/.emacs.desktop.lock
*.elc
auto-save-list
tramp
.\#*
```

### Cursor

```gitignore
.cursorindexingignore
.cursorignore
```

---

## Security (ALWAYS include)

```gitignore
# Environment variables
.env
.env.local
.env.*.local
.env.development
.env.staging
.env.production
.dev.vars

# Private keys & certificates
*.pem
*.key
*.p12
*.pfx
*.jks
*.p8
*.mobileprovision
id_rsa
id_rsa.pub
id_ed25519
id_ed25519.pub

# Credentials & tokens
credentials.json
serviceAccountKey.json
.gcp-credentials.json
.aws/
.azure/
token.json
secrets.yaml
secrets.yml
*.secret

# SSH
.ssh/

# GPG
secring.*
```

---

## Logs (common)

```gitignore
logs/
*.log
npm-debug.log*
yarn-debug.log*
yarn-error.log*
pnpm-debug.log*
lerna-debug.log*
```

---

## Language: Node.js

```gitignore
# Dependencies
node_modules/
.pnp
.pnp.js
.pnp.cjs
.pnp.loader.mjs
.yarn/cache
.yarn/unplugged
.yarn/build-state.yml
.yarn/install-state.gz

# Build
dist/
build/
.cache/
*.tsbuildinfo

# Coverage
coverage/
.nyc_output/

# Runtime
.node_repl_history
*.pid
*.seed
*.pid.lock

# Package manager stores
.pnpm-store/
```

## Language: Python

```gitignore
# Bytecode
__pycache__/
*.py[cod]
*$py.class

# Distribution / packaging
build/
dist/
eggs/
*.egg-info/
*.egg
wheels/
*.whl
MANIFEST

# Virtual environments
.venv/
venv/
env/
ENV/
.Python

# Testing & coverage
.pytest_cache/
.coverage
.coverage.*
htmlcov/
.tox/
.nox/
.hypothesis/

# Type checking & linting
.mypy_cache/
.pytype/
.ruff_cache/
.dmypy.json

# Packaging
pip-log.txt
pip-delete-this-directory.txt
.pypirc

# Jupyter
.ipynb_checkpoints/

# uv
.uv/

# PDM
.pdm-python
.pdm-build/
__pypackages__/
```

## Language: Go

```gitignore
# Binaries
*.exe
*.exe~
*.dll
*.so
*.dylib

# Test
*.test
*.out
coverage.out
coverage.html
*.coverprofile

# Go workspace
go.work
go.work.sum

# Vendor (optional)
# vendor/
```

## Language: Rust

### Application (binary) projects

```gitignore
# Build
/target/
debug/

# Debug symbols
*.pdb

# Rustfmt backup
**/*.rs.bk

# Cargo mutants
**/mutants.out*/
```

### Library projects

```gitignore
# Build
/target/
debug/

# Lock file (libraries should not commit Cargo.lock)
Cargo.lock

# Debug symbols
*.pdb

# Rustfmt backup
**/*.rs.bk

# Cargo mutants
**/mutants.out*/
```

## Language: Java

```gitignore
# Compiled
*.class

# Package archives
*.jar
*.war
*.nar
*.ear
*.zip
*.tar.gz
*.rar

# Build tools
target/
.gradle/
build/
!gradle/wrapper/gradle-wrapper.jar

# IDE
.settings/
.project
.classpath
.factorypath

# JVM crash logs
hs_err_pid*
replay_pid*

# Kotlin
.kotlin/
```

## Language: C# / .NET

```gitignore
# Build
[Dd]ebug/
[Rr]elease/
x64/
x86/
[Bb]in/
[Oo]bj/
[Oo]ut/

# User-specific
*.suo
*.user
*.userosscache
*.sln.docstates
.vs/

# Build logs
msbuild.log
msbuild.err
msbuild.wrn

# NuGet
**/[Pp]ackages/*
*.nupkg
project.lock.json
```

## Language: Ruby

```gitignore
# Gem & build
*.gem
*.rbc
/pkg/

# Dependencies
/.bundle/
/vendor/bundle

# Testing
/coverage/
/spec/reports/

# Runtime
/tmp/
.byebug_history
```

## Language: PHP

```gitignore
# Composer
/vendor/
composer.phar

# PHPUnit
.phpunit.result.cache
.phpunit.cache/

# PHPStan / Psalm
.phpstan-cache/
.psalm-cache/
```

## Language: Swift

```gitignore
# Xcode
DerivedData/
xcuserdata/
*.xccheckout
*.moved-aside
*.xcuserstate
*.xcscmblueprint
*.xcworkspace

# Swift Package Manager
.build/
.swiftpm/
Packages/
Package.pins
Package.resolved

# CocoaPods
Pods/

# Carthage
Carthage/Build/
Carthage/Checkouts/

# Fastlane
fastlane/report.xml
fastlane/Preview.html
fastlane/screenshots/**/*.png
fastlane/test_output

# App packaging
*.ipa
*.dSYM.zip
*.dSYM
```

---

## Framework: Next.js

```gitignore
.next/
out/
```

## Framework: Nuxt

```gitignore
.nuxt/
.output/
.nitro/
```

## Framework: SvelteKit

```gitignore
.svelte-kit/
```

## Framework: Astro

```gitignore
.astro/
```

## Framework: Remix

```gitignore
build/
.cache/
server-build/
```

## Framework: Vite (standalone)

```gitignore
.vite/
```

## Framework: Expo / React Native

```gitignore
# Expo
.expo/
.expo-shared/
expo-env.d.ts

# React Native
.bundle/
.metro/
ios/Pods/
android/.gradle/
android/app/build/
```

## Framework: Flutter

```gitignore
.flutter-plugins
.flutter-plugins-dependencies
.dart_tool/
.packages
build/
*.iml
```

## Framework: Android (Gradle)

```gitignore
.gradle/
.idea/
build/
local.properties
*.apk
*.aab
.cxx/
.externalNativeBuild/
```

## Framework: Django

```gitignore
staticfiles/
mediafiles/
*.sqlite3
db.sqlite3
```

## Framework: Rails

```gitignore
/log/*
/tmp/*
!/log/.keep
!/tmp/.keep
/storage/*
!/storage/.keep
/public/assets/
/public/packs/
.byebug_history
```

## Framework: Spring Boot

```gitignore
target/
.gradle/
build/
.springBeans
.sts4-cache/
!gradle/wrapper/gradle-wrapper.jar
```

## Framework: FastAPI

```gitignore
# (inherits Python patterns)
# Alembic
alembic/versions/__pycache__/
```

---

## Testing

### Playwright

```gitignore
test-results/
playwright-report/
playwright/.cache/
blob-report/
```

### Cypress

```gitignore
cypress/videos/
cypress/screenshots/
cypress/downloads/
```

### Vitest

```gitignore
.vitest/
```

### Storybook

```gitignore
storybook-static/
```

---

## Build / Monorepo Tools

### Turborepo

```gitignore
.turbo/
```

### Nx

```gitignore
.nx/cache/
.nx/workspace-data/
```

---

## Container / IaC

### Docker

```gitignore
.docker/
docker-compose.override.yml
```

### Terraform

```gitignore
.terraform/
*.tfstate
*.tfstate.*
crash.log
*.tfvars
!*.tfvars.example
override.tf
override.tf.json
*_override.tf
*_override.tf.json
.terraformrc
terraform.rc
```

### Pulumi

```gitignore
.pulumi/
```

### AWS CDK

```gitignore
cdk.out/
.cdk.staging/
```

### Kubernetes / Helm

```gitignore
charts/*/charts/
*.tgz
```

---

## Serverless / Edge

### Vercel

```gitignore
.vercel/
```

### Netlify

```gitignore
.netlify/
```

### Cloudflare Workers (Wrangler)

```gitignore
.wrangler/
.dev.vars
```

### AWS SAM

```gitignore
.aws-sam/
```

### Serverless Framework

```gitignore
.serverless/
```

---

## Database (dev)

### SQLite

```gitignore
*.sqlite
*.sqlite3
*.db
*.db-shm
*.db-wal
*.sqlite-journal
```

### Prisma

```gitignore
node_modules/.prisma/
```

### Drizzle

```gitignore
drizzle/meta/
```

---

## AI / ML

```gitignore
# Model weights & checkpoints
*.pt
*.pth
*.ckpt
*.safetensors
*.h5
*.pb
*.onnx
*.tflite

# Datasets (large files)
data/raw/
data/processed/
*.parquet
*.arrow

# Experiment tracking
mlruns/
mlartifacts/
wandb/
runs/
events.out.tfevents.*

# Hugging Face
.huggingface/
transformers_cache/
```

---

## Claude Code / AI Tools

```gitignore
# Claude Code
.claude/settings.local.json

# Cursor
.cursorindexingignore
.cursorignore
```
