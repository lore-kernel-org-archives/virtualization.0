From: "K. Y. Srinivasan" <kys@microsoft.com>
Subject: [PATCH 02/40] Staging: hv: storvsc: Rename must_get_stor_device()
Date: Wed, 29 Jun 2011 07:38:59 -0700
Message-ID: <1309358377-8537-2-git-send-email-kys@microsoft.com>
References: <1309358301-8488-1-git-send-email-kys@microsoft.com>
	<1309358377-8537-1-git-send-email-kys@microsoft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <devel-bounces@linuxdriverproject.org>
In-Reply-To: <1309358377-8537-1-git-send-email-kys@microsoft.com>
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

In preparation for cleaning up how we manage reference counts on the stor
device, clearly distinguish why we are attempting to acquire a reference.

Signed-off-by: K. Y. Srinivasan <kys@microsoft.com>
Signed-off-by: Haiyang Zhang <haiyangz@microsoft.com>
Signed-off-by: Abhishek Kane <v-abkane@microsoft.com>
Signed-off-by: Hank Janssen <hjanssen@microsoft.com>
---
 drivers/staging/hv/storvsc.c |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/staging/hv/storvsc.c b/drivers/staging/hv/storvsc.c
index cd38cd6..89708b1 100644
--- a/drivers/staging/hv/storvsc.c
+++ b/drivers/staging/hv/storvsc.c
@@ -41,7 +41,7 @@ static inline struct storvsc_device *alloc_stor_device(struct hv_device *device)
 		return NULL;
 
 	/* Set to 2 to allow both inbound and outbound traffics */
-	/* (ie get_stor_device() and must_get_stor_device()) to proceed. */
+	/* (ie get_stor_device() and get_in_stor_device()) to proceed. */
 	atomic_cmpxchg(&stor_device->ref_count, 0, 2);
 
 	init_waitqueue_head(&stor_device->waiting_to_drain);
@@ -53,7 +53,7 @@ static inline struct storvsc_device *alloc_stor_device(struct hv_device *device)
 
 
 /* Get the stordevice object iff exists and its refcount > 0 */
-static inline struct storvsc_device *must_get_stor_device(
+static inline struct storvsc_device *get_in_stor_device(
 					struct hv_device *device)
 {
 	struct storvsc_device *stor_device;
@@ -305,7 +305,7 @@ static void storvsc_on_channel_callback(void *context)
 	int ret;
 
 
-	stor_device = must_get_stor_device(device);
+	stor_device = get_in_stor_device(device);
 	if (!stor_device)
 		return;
 
-- 
1.7.4.1
