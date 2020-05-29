From: Guennadi Liakhovetski <guennadi.liakhovetski@linux.intel.com>
Subject: [RFC 02/12] ASoC: SOF: extract firmware-related operation into a function
Date: Fri, 29 May 2020 09:37:12 +0200
Message-ID: <20200529073722.8184-3-guennadi.liakhovetski@linux.intel.com>
References: <20200529073722.8184-1-guennadi.liakhovetski@linux.intel.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <20200529073722.8184-1-guennadi.liakhovetski@linux.intel.com>
Sender: kvm-owner@vger.kernel.org
To: kvm@vger.kernel.org
Cc: linux-remoteproc@vger.kernel.org, virtualization@lists.linux-foundation.org, sound-open-firmware@alsa-project.org, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, Liam Girdwood <liam.r.girdwood@linux.intel.com>, "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, Ohad Ben-Cohen <ohad@wizery.com>, Bjorn Andersson <bjorn.andersson@linaro.org>, Mathieu Poirier <mathieu.poirier@linaro.org>
List-Id: virtualization@lists.linuxfoundation.org

In the VirtIO guest case the SOF will not be dealing with the
firmware directly. Extract related functionality into a function to
make the separation easier.

Signed-off-by: Guennadi Liakhovetski <guennadi.liakhovetski@linux.intel.com>
---
 sound/soc/sof/core.c | 85 ++++++++++++++++++++++++++++++----------------------
 1 file changed, 49 insertions(+), 36 deletions(-)

diff --git a/sound/soc/sof/core.c b/sound/soc/sof/core.c
index 339c493..17f264f 100644
--- a/sound/soc/sof/core.c
+++ b/sound/soc/sof/core.c
@@ -135,6 +135,53 @@ void snd_sof_get_status(struct snd_sof_dev *sdev, u32 panic_code,
  *	(System Suspend/Runtime Suspend)
  */
 
+static int sof_load_and_run_firmware(struct snd_sof_dev *sdev)
+{
+	/* load the firmware */
+	int ret = snd_sof_load_firmware(sdev);
+	if (ret < 0) {
+		dev_err(sdev->dev, "error: failed to load DSP firmware %d\n",
+			ret);
+		return ret;
+	}
+
+	sdev->fw_state = SOF_FW_BOOT_IN_PROGRESS;
+
+	/*
+	 * Boot the firmware. The FW boot status will be modified
+	 * in snd_sof_run_firmware() depending on the outcome.
+	 */
+	ret = snd_sof_run_firmware(sdev);
+	if (ret < 0) {
+		dev_err(sdev->dev, "error: failed to boot DSP firmware %d\n",
+			ret);
+		goto fw_run_err;
+	}
+
+	if (IS_ENABLED(CONFIG_SND_SOC_SOF_DEBUG_ENABLE_FIRMWARE_TRACE) ||
+	    (sof_core_debug & SOF_DBG_ENABLE_TRACE)) {
+		sdev->dtrace_is_supported = true;
+
+		/* init DMA trace */
+		ret = snd_sof_init_trace(sdev);
+		if (ret < 0) {
+			/* non fatal */
+			dev_warn(sdev->dev,
+				 "warning: failed to initialize trace %d\n",
+				 ret);
+		}
+	} else {
+		dev_dbg(sdev->dev, "SOF firmware trace disabled\n");
+	}
+
+	return 0;
+
+fw_run_err:
+	snd_sof_fw_unload(sdev);
+
+	return ret;
+}
+
 static int sof_probe_continue(struct snd_sof_dev *sdev)
 {
 	struct snd_sof_pdata *plat_data = sdev->pdata;
@@ -181,42 +228,9 @@ static int sof_probe_continue(struct snd_sof_dev *sdev)
 		goto ipc_err;
 	}
 
-	/* load the firmware */
-	ret = snd_sof_load_firmware(sdev);
-	if (ret < 0) {
-		dev_err(sdev->dev, "error: failed to load DSP firmware %d\n",
-			ret);
+	ret = sof_load_and_run_firmware(sdev);
+	if (ret < 0)
 		goto fw_load_err;
-	}
-
-	sdev->fw_state = SOF_FW_BOOT_IN_PROGRESS;
-
-	/*
-	 * Boot the firmware. The FW boot status will be modified
-	 * in snd_sof_run_firmware() depending on the outcome.
-	 */
-	ret = snd_sof_run_firmware(sdev);
-	if (ret < 0) {
-		dev_err(sdev->dev, "error: failed to boot DSP firmware %d\n",
-			ret);
-		goto fw_run_err;
-	}
-
-	if (IS_ENABLED(CONFIG_SND_SOC_SOF_DEBUG_ENABLE_FIRMWARE_TRACE) ||
-	    (sof_core_debug & SOF_DBG_ENABLE_TRACE)) {
-		sdev->dtrace_is_supported = true;
-
-		/* init DMA trace */
-		ret = snd_sof_init_trace(sdev);
-		if (ret < 0) {
-			/* non fatal */
-			dev_warn(sdev->dev,
-				 "warning: failed to initialize trace %d\n",
-				 ret);
-		}
-	} else {
-		dev_dbg(sdev->dev, "SOF firmware trace disabled\n");
-	}
 
 	/* hereafter all FW boot flows are for PM reasons */
 	sdev->first_boot = false;
@@ -250,7 +264,6 @@ static int sof_probe_continue(struct snd_sof_dev *sdev)
 
 fw_trace_err:
 	snd_sof_free_trace(sdev);
-fw_run_err:
 	snd_sof_fw_unload(sdev);
 fw_load_err:
 	snd_sof_ipc_free(sdev);
-- 
1.9.3
