#import <AVFoundation/AVFoundation.h>

static AVSpeechSynthesizer *synthesizer;

extern "C" void startSpeechSynthesis(const char *voice, const char *text)
{
	if (!synthesizer) {
		synthesizer = [[AVSpeechSynthesizer alloc] init];
	}

	NSString *nsText = [NSString stringWithUTF8String:text];
	NSString *nsVoice = [NSString stringWithUTF8String:voice];

	AVSpeechUtterance *utterance = [[AVSpeechUtterance alloc] initWithString:nsText];
	utterance.voice = [AVSpeechSynthesisVoice voiceWithIdentifier:nsVoice];
	utterance.rate = AVSpeechUtteranceDefaultSpeechRate;

	[synthesizer speakUtterance:utterance];
}

