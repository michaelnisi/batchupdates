P:=BatchUpdates.xcodeproj

XCODEBUILD:=xcodebuild
JAZZY:=jazzy

all: docs

$(P):
	swift package generate-xcodeproj --xcconfig-overrides ./Sources/ios.xcconfig

docs: $(P)
	$(JAZZY) --author "Michael Nisi" --author_url https://troubled.pro

.PHONY: clean
clean:
	rm -rf $(P) docs

