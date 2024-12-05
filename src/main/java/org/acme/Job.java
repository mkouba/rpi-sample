package org.acme;

import java.io.BufferedReader;
import java.math.BigDecimal;
import java.math.RoundingMode;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

import org.eclipse.microprofile.config.inject.ConfigProperty;

import io.quarkus.logging.Log;
import io.quarkus.scheduler.Scheduled;

public class Job {

    @ConfigProperty(name = "rpi.read-command")
    String[] command;

    @Scheduled(every = "${rpi.read-interval}", delayed = "2s")
    void readValue() {
        ProcessBuilder builder = new ProcessBuilder(command);
        builder.redirectErrorStream(true);
        try {
            Process process = builder.start();
            List<String> lines = new ArrayList<>();
            try (BufferedReader reader = process.inputReader()) {
                String line;
                while ((line = reader.readLine()) != null) {
                    lines.add(line);
                }
            }
            int exitCode = process.waitFor();
            if (lines.size() == 1) {
                BigDecimal val = new BigDecimal(lines.get(0).trim());
                Log.infof("Temperature: %s [raw: %s]", val.divide(new BigDecimal(1000), 2, RoundingMode.HALF_UP), val);
            }
            if (exitCode != 0) {
                Log.errorf("Process exited with error code : %s", exitCode);
            }
        } catch (Exception e) {
            Log.errorf(e, "Unable to read the value with command: %s", Arrays.toString(command));
        }
    }

}
