package udp.icibot.knx.knx_flutter;

import android.os.Build;

import androidx.annotation.NonNull;

import java.time.Duration;
import java.util.concurrent.ExecutionException;

import io.flutter.embedding.android.FlutterActivity;
import io.flutter.embedding.engine.FlutterEngine;
import io.flutter.plugin.common.MethodChannel;
import tuwien.auto.calimero.knxnetip.Discoverer;

public class MainActivity extends FlutterActivity {
    private static final String CHANNEL = "camilero.icibot.knx";

    @Override
    public void configureFlutterEngine(@NonNull FlutterEngine flutterEngine) {
        super.configureFlutterEngine(flutterEngine);
        new MethodChannel(flutterEngine.getDartExecutor().getBinaryMessenger(), CHANNEL).setMethodCallHandler((call, result) -> {
            if (call.method.equals("start")) {
                try {
                    // set true to be aware of Network Address Translation (NAT) during discovery
                    final boolean useNAT = false;
                    if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.O) {
                        Discoverer.udp(useNAT).timeout(Duration.ofSeconds(3)).search().get().forEach(r -> {
                            result.success(r.getResponse().toString());
                            System.out.format("%s %s <=> %s%n", r.getNetworkInterface().getName(), r.localEndpoint(), r.getResponse().toString().replace(", ", "\n\t")
                            );
                        });
                    }
                } catch (InterruptedException | ExecutionException e) {
                    result.error("UNAVAILABLE", "KNXnet/IP discovery failed", null);
                }
                return;
            } else {
                result.success("Hello from Java");
            }

        });
    }
}

