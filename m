From: "K. Y. Srinivasan" <kys@microsoft.com>
Subject: [PATCH 027/206] Staging: hv: Rename stor_vsc_on_receive
Date: Mon,  9 May 2011 14:55:09 -0700
Message-ID: <1304978288-22999-27-git-send-email-kys@microsoft.com>
References: <1304978242-22958-1-git-send-email-kys@microsoft.com>
	<1304978288-22999-1-git-send-email-kys@microsoft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <devel-bounces@linuxdriverproject.org>
In-Reply-To: <1304978288-22999-1-git-send-email-kys@microsoft.com>
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
Cc: Haiyang Zhang <haiyangz@microsoft.com>, Abhishek Kane <v-abkane@microsoft.com>
List-Id: virtualization@lists.linuxfoundation.org

The subject line says it all.

Signed-off-by: K. Y. Srinivasan <kys@microsoft.com>
Signed-off-by: Haiyang Zhang <haiyangz@microsoft.com>
Signed-off-by: Abhishek Kane <v-abkane@microsoft.com>
Signed-off-by: Hank Janssen <hjanssen@microsoft.com>
---
 drivers/staging/hv/storvsc.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/hv/storvsc.c b/drivers/staging/hv/storvsc.c
index ecc62e1..ab9da5c 100644
--- a/drivers/staging/hv/storvsc.c
+++ b/drivers/staging/hv/storvsc.c
@@ -341,7 +341,7 @@ static void storvsc_on_io_completion(struct hv_device *device,
 	put_stor_device(device);
 }
 
-static void stor_vsc_on_receive(struct hv_device *device,
+static void storvsc_on_receive(struct hv_device *device,
 			     struct vstor_packet *vstor_packet,
 			     struct hv_storvsc_request *request)
 {
@@ -399,7 +399,7 @@ static void stor_vsc_on_channel_callback(void *context)
 				       sizeof(struct vstor_packet));
 				complete(&request->wait_event);
 			} else {
-				stor_vsc_on_receive(device,
+				storvsc_on_receive(device,
 						(struct vstor_packet *)packet,
 						request);
 			}
-- 
1.7.4.1
