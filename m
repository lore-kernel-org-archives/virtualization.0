From: "K. Y. Srinivasan" <kys@microsoft.com>
Subject: [PATCH 03/77] Staging: hv: storvsc: Increase the timeout value in the storvsc driver
Date: Thu, 16 Jun 2011 13:16:36 -0700
Message-ID: <1308255470-3826-3-git-send-email-kys@microsoft.com>
References: <1308255393-3785-1-git-send-email-kys@microsoft.com>
 <1308255470-3826-1-git-send-email-kys@microsoft.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1308255470-3826-1-git-send-email-kys@microsoft.com>
Sender: linux-kernel-owner@vger.kernel.org
To: gregkh@suse.de, linux-kernel@vger.kernel.org, devel@linuxdriverproject.org, virtualization@lists.osdl.org
Cc: "K. Y. Srinivasan" <kys@microsoft.com>, Haiyang Zhang <haiyangz@microsoft.com>, Hank Janssen <hjanssen@microsoft.com>, stable <stable@kernel.org>
List-Id: virtualization@lists.linuxfoundation.org

On some loaded windows hosts, we have discovered that the host may not
respond to guest requests within the specified time (one second)
as evidenced by the guest timing out. Fix this problem by increasing
the timeout to 5 seconds. 

It may be useful to apply this patch to the 3.0 kernel as well.
the 3.0 kernel as well.

Signed-off-by: K. Y. Srinivasan <kys@microsoft.com>
Signed-off-by: Haiyang Zhang <haiyangz@microsoft.com>
Signed-off-by: Hank Janssen <hjanssen@microsoft.com>
Cc: stable <stable@kernel.org>
---
 drivers/staging/hv/storvsc.c     |    8 ++++----
 drivers/staging/hv/storvsc_drv.c |    2 +-
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/staging/hv/storvsc.c b/drivers/staging/hv/storvsc.c
index 06cd327..3029786 100644
--- a/drivers/staging/hv/storvsc.c
+++ b/drivers/staging/hv/storvsc.c
@@ -135,7 +135,7 @@ static int storvsc_channel_init(struct hv_device *device)
 	if (ret != 0)
 		goto cleanup;
 
-	t = wait_for_completion_timeout(&request->wait_event, HZ);
+	t = wait_for_completion_timeout(&request->wait_event, 5*HZ);
 	if (t == 0) {
 		ret = -ETIMEDOUT;
 		goto cleanup;
@@ -163,7 +163,7 @@ static int storvsc_channel_init(struct hv_device *device)
 	if (ret != 0)
 		goto cleanup;
 
-	t = wait_for_completion_timeout(&request->wait_event, HZ);
+	t = wait_for_completion_timeout(&request->wait_event, 5*HZ);
 	if (t == 0) {
 		ret = -ETIMEDOUT;
 		goto cleanup;
@@ -192,7 +192,7 @@ static int storvsc_channel_init(struct hv_device *device)
 	if (ret != 0)
 		goto cleanup;
 
-	t = wait_for_completion_timeout(&request->wait_event, HZ);
+	t = wait_for_completion_timeout(&request->wait_event, 5*HZ);
 	if (t == 0) {
 		ret = -ETIMEDOUT;
 		goto cleanup;
@@ -222,7 +222,7 @@ static int storvsc_channel_init(struct hv_device *device)
 	if (ret != 0)
 		goto cleanup;
 
-	t = wait_for_completion_timeout(&request->wait_event, HZ);
+	t = wait_for_completion_timeout(&request->wait_event, 5*HZ);
 	if (t == 0) {
 		ret = -ETIMEDOUT;
 		goto cleanup;
diff --git a/drivers/staging/hv/storvsc_drv.c b/drivers/staging/hv/storvsc_drv.c
index 2c6d2f2..7effaf3 100644
--- a/drivers/staging/hv/storvsc_drv.c
+++ b/drivers/staging/hv/storvsc_drv.c
@@ -376,7 +376,7 @@ static int storvsc_host_reset(struct hv_device *device)
 	if (ret != 0)
 		goto cleanup;
 
-	t = wait_for_completion_timeout(&request->wait_event, HZ);
+	t = wait_for_completion_timeout(&request->wait_event, 5*HZ);
 	if (t == 0) {
 		ret = -ETIMEDOUT;
 		goto cleanup;
-- 
1.7.4.1
