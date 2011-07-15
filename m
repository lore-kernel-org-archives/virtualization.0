From: "K. Y. Srinivasan" <kys@microsoft.com>
Subject: [PATCH 076/117] Staging: hv: storvsc: Do not aquire an unnecessary
	reference on stor_device
Date: Fri, 15 Jul 2011 10:47:04 -0700
Message-ID: <1310752065-27895-76-git-send-email-kys@microsoft.com>
References: <1310752024-27854-1-git-send-email-kys@microsoft.com>
	<1310752065-27895-1-git-send-email-kys@microsoft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <devel-bounces@linuxdriverproject.org>
In-Reply-To: <1310752065-27895-1-git-send-email-kys@microsoft.com>
List-Unsubscribe: <http://driverdev.linuxdriverproject.org/mailman/options/devel>,
	<mailto:devel-request@linuxdriverproject.org?subject=unsubscribe>
List-Archive: <http://driverdev.linuxdriverproject.org/pipermail/devel>
List-Post: <mailto:devel@linuxdriverproject.org>
List-Help: <mailto:devel-request@linuxdriverproject.org?subject=help>
List-Subscribe: <http://driverdev.linuxdriverproject.org/mailman/listinfo/devel>,
	<mailto:devel-request@linuxdriverproject.org?subject=subscribe>
Sender: devel-bounces@linuxdriverproject.org
Errors-To: devel-bounces@linuxdriverproject.org
To: gregkh@suse.de, linux-kernel@vger.kernel.org, devel@linuxdriverproject.org, virtualization@lists.osdl.org
Cc: Haiyang Zhang <haiyangz@microsoft.com>
List-Id: virtualization@lists.linuxfoundation.org

On entry into storvsc_on_io_completion() we have already acquired a reference
on the stor_device; there is no need to acquire an additional reference here.

Signed-off-by: K. Y. Srinivasan <kys@microsoft.com>
Signed-off-by: Haiyang Zhang <haiyangz@microsoft.com>
---
 drivers/staging/hv/storvsc.c |    5 +----
 1 files changed, 1 insertions(+), 4 deletions(-)

diff --git a/drivers/staging/hv/storvsc.c b/drivers/staging/hv/storvsc.c
index 8c62829..cd38cd6 100644
--- a/drivers/staging/hv/storvsc.c
+++ b/drivers/staging/hv/storvsc.c
@@ -232,9 +232,7 @@ static void storvsc_on_io_completion(struct hv_device *device,
 	struct storvsc_device *stor_device;
 	struct vstor_packet *stor_pkt;
 
-	stor_device = must_get_stor_device(device);
-	if (!stor_device)
-		return;
+	stor_device = (struct storvsc_device *)device->ext;
 
 	stor_pkt = &request->vstor_packet;
 
@@ -279,7 +277,6 @@ static void storvsc_on_io_completion(struct hv_device *device,
 		wake_up(&stor_device->waiting_to_drain);
 
 
-	put_stor_device(device);
 }
 
 static void storvsc_on_receive(struct hv_device *device,
-- 
1.7.4.1
