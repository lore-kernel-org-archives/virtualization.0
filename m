From: "K. Y. Srinivasan" <kys@microsoft.com>
Subject: [PATCH 14/40] Staging: hv: netvsc: Inline the code for
	free_net_device()
Date: Wed, 29 Jun 2011 07:39:11 -0700
Message-ID: <1309358377-8537-14-git-send-email-kys@microsoft.com>
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

Inline the code for free_net_device().

Signed-off-by: K. Y. Srinivasan <kys@microsoft.com>
Signed-off-by: Haiyang Zhang <haiyangz@microsoft.com>
Signed-off-by: Abhishek Kane <v-abkane@microsoft.com>
Signed-off-by: Hank Janssen <hjanssen@microsoft.com>
---
 drivers/staging/hv/netvsc.c |   12 ++----------
 1 files changed, 2 insertions(+), 10 deletions(-)

diff --git a/drivers/staging/hv/netvsc.c b/drivers/staging/hv/netvsc.c
index bdd5c2b..c3c934c 100644
--- a/drivers/staging/hv/netvsc.c
+++ b/drivers/staging/hv/netvsc.c
@@ -51,14 +51,6 @@ static struct netvsc_device *alloc_net_device(struct hv_device *device)
 	return net_device;
 }
 
-static void free_net_device(struct netvsc_device *device)
-{
-	WARN_ON(atomic_read(&device->refcnt) != 0);
-	device->dev->ext = NULL;
-	kfree(device);
-}
-
-
 /* Get the net device object iff exists and its refcount > 1 */
 static struct netvsc_device *get_outbound_net_device(struct hv_device *device)
 {
@@ -444,7 +436,7 @@ int netvsc_device_remove(struct hv_device *device)
 		kfree(netvsc_packet);
 	}
 
-	free_net_device(net_device);
+	kfree(net_device);
 	return 0;
 }
 
@@ -994,7 +986,7 @@ cleanup:
 		release_outbound_net_device(device);
 		release_inbound_net_device(device);
 
-		free_net_device(net_device);
+		kfree(net_device);
 	}
 
 	return ret;
-- 
1.7.4.1
