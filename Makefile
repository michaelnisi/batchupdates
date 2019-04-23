P:=BatchUpdates.xcodeproj

XCODEBUILD:=xcodebuild
JAZZY:=jazzy

all: docs

$(P):
	swift package generate-xcodeproj --xcconfig-overrides ./Sources/ios.xcconfig

docs: $(P)
	$(JAZZY)

.PHONY: clean
clean:
	rm -rf $(P) docs

