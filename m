From: "K. Y. Srinivasan" <kys@microsoft.com>
Subject: [PATCH 022/206] Staging: hv: Use the newly introduced I/O drain synch
	method
Date: Mon,  9 May 2011 14:55:04 -0700
Message-ID: <1304978288-22999-22-git-send-email-kys@microsoft.com>
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

Use the newly introduced I/O drain synch method.

Signed-off-by: K. Y. Srinivasan <kys@microsoft.com>
Signed-off-by: Haiyang Zhang <haiyangz@microsoft.com>
Signed-off-by: Abhishek Kane <v-abkane@microsoft.com>
Signed-off-by: Hank Janssen <hjanssen@microsoft.com>
---
 drivers/staging/hv/storvsc.c |    7 ++-----
 1 files changed, 2 insertions(+), 5 deletions(-)

diff --git a/drivers/staging/hv/storvsc.c b/drivers/staging/hv/storvsc.c
index 36458b8..8e529d5 100644
--- a/drivers/staging/hv/storvsc.c
+++ b/drivers/staging/hv/storvsc.c
@@ -501,11 +501,8 @@ int storvsc_dev_remove(struct hv_device *device)
 	 * only allow inbound traffic (responses) to proceed so that
 	 * outstanding requests can be completed.
 	 */
-	while (atomic_read(&stor_device->num_outstanding_req)) {
-		DPRINT_INFO(STORVSC, "waiting for %d requests to complete...",
-			    atomic_read(&stor_device->num_outstanding_req));
-		udelay(100);
-	}
+
+	storvsc_wait_to_drain(stor_device);
 
 	DPRINT_INFO(STORVSC, "removing storage device (%p)...",
 		    device->ext);
-- 
1.7.4.1
