package com.example.easy_peezy

import android.content.Intent
import android.os.Build
import android.os.Bundle
import android.speech.RecognitionListener
import android.speech.RecognizerIntent
import android.speech.SpeechRecognizer
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel

class MainActivity : FlutterActivity() {

    private val CHANNEL = "easy_peezy/multilingual_speech"
    private var speechRecognizer: SpeechRecognizer? = null
    private var speechResult: MethodChannel.Result? = null

    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)

        MethodChannel(
            flutterEngine.dartExecutor.binaryMessenger,
            CHANNEL
        ).setMethodCallHandler { call, result ->

            when (call.method) {
                "startListening" -> startMultilingualListening(result)

                "stopListening" -> {
                    speechRecognizer?.stopListening()
                    result.success(true)
                }

                else -> result.notImplemented()
            }
        }
    }

    private fun startMultilingualListening(result: MethodChannel.Result) {
        if (!SpeechRecognizer.isRecognitionAvailable(this)) {
            result.error("UNAVAILABLE", "Speech recognition is unavailable.", null)
            return
        }

        speechResult = result

        speechRecognizer?.destroy()
        speechRecognizer = SpeechRecognizer.createSpeechRecognizer(this)

        speechRecognizer?.setRecognitionListener(object : RecognitionListener {

            override fun onReadyForSpeech(params: Bundle?) {}

            override fun onBeginningOfSpeech() {}

            override fun onRmsChanged(rmsdB: Float) {}

            override fun onBufferReceived(buffer: ByteArray?) {}

            override fun onEndOfSpeech() {}

            override fun onError(error: Int) {
                speechResult?.error(
                    "SPEECH_ERROR",
                    "Speech recognition error: $error",
                    null
                )
                speechResult = null
            }

            override fun onResults(results: Bundle?) {
                val matches = results?.getStringArrayList(
                    SpeechRecognizer.RESULTS_RECOGNITION
                )

                val text = matches?.firstOrNull() ?: ""

                speechResult?.success(
                    mapOf(
                        "text" to text,
                        "language" to results?.getString("android.speech.extra.LANGUAGE")
                    )
                )
                speechResult = null
            }

            override fun onPartialResults(partialResults: Bundle?) {}

            override fun onEvent(eventType: Int, params: Bundle?) {}

        })

        val intent = Intent(RecognizerIntent.ACTION_RECOGNIZE_SPEECH).apply {
            putExtra(
                RecognizerIntent.EXTRA_LANGUAGE_MODEL,
                RecognizerIntent.LANGUAGE_MODEL_FREE_FORM
            )
            putExtra(
                RecognizerIntent.EXTRA_LANGUAGE_PREFERENCE,
                "en-IN"
            )
            putExtra(
                RecognizerIntent.EXTRA_LANGUAGE_DETECTION_ALLOWED_LANGUAGES,
                arrayListOf("en-IN", "hi-IN", "bn-IN")
            )

            if (Build.VERSION.SDK_INT >= 34) {
                putExtra(
                    RecognizerIntent.EXTRA_ENABLE_LANGUAGE_DETECTION,
                    true
                )
                putExtra(
                    RecognizerIntent.EXTRA_ENABLE_LANGUAGE_SWITCH,
                    true
                )
                putExtra(
                    RecognizerIntent.EXTRA_LANGUAGE_SWITCH_ALLOWED_LANGUAGES,
                    arrayListOf("en-IN", "hi-IN", "bn-IN")
                )
            }
        }

        speechRecognizer?.startListening(intent)
    }

    override fun onDestroy() {
        speechRecognizer?.destroy()
        speechRecognizer = null
        super.onDestroy()
    }
}