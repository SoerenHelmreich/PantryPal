# Makefile for deploying the Flutter web projects to GitHub

BASE_HREF = /$(NAME)/
# Replace with your GitHub username
GITHUB_USER = bizz84
GITHUB_REPO = https://github.com/$(GITHUB_USER)/$(NAME)
BUILD_VERSION := $(if $(NAME),$(shell grep 'version:' $(NAME)/pubspec.yaml | awk '{print $$2}'))

# Deploy the Flutter web project to GitHub
deploy:
ifndef NAME
  $(error NAME is not set. Usage: make deploy NAME=<name>)
endif

  @echo "Clean existing repository"
  cd $(NAME) && flutter clean

  @echo "Getting packages..."
  cd $(NAME) && flutter pub get

  @echo "Generating the web folder..."
  cd $(NAME) && flutter create . --platform web

  @echo "Building for web..."
  cd $(NAME) && flutter build web --base-href $(BASE_HREF) --release

  @echo "Deploying to git repository"
  cd $(NAME)/build/web && \
  git init && \
  git add . && \
  git commit -m "Deploy Version $(BUILD_VERSION)" && \
  git branch -M main && \
  git remote add origin $(GITHUB_REPO) && \
  git push -u -f origin main

  @echo "✅ Finished deploy: $(GITHUB_REPO)"
  @echo "🚀 Flutter web URL: https://$(GITHUB_USER).github.io/$(NAME)/"

.PHONY: deploy