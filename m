From: Haiyang Zhang <haiyangz@microsoft.com>
Subject: [PATCH 1/2] staging: hv: Remove unnecessary ASSERTs in
	netvsc_initialize()
Date: Fri, 18 Feb 2011 15:05:52 -0800
Message-ID: <1298070353-23534-1-git-send-email-haiyangz__21789.1095825054$1298069902$gmane$org@microsoft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: haiyangz@microsoft.com, hjanssen@microsoft.com, kys@microsoft.com, v-abkane@microsoft.com, gregkh@suse.de, linux-kernel@vger.kernel.org, devel@linuxdriverproject.org, vir
List-Id: virtualization@lists.linuxfoundation.org

These fields have been assigned in netvsc_drv_init() before calling
netvsc_initialize(), so there is no need to check them.
The ASSERTs were already commented out, and this patch removes
them.

Signed-off-by: Haiyang Zhang <haiyangz@microsoft.com>
Signed-off-by: K. Y. Srinivasan <kys@microsoft.com>
Signed-off-by: Hank Janssen <hjanssen@microsoft.com>

---
 drivers/staging/hv/netvsc.c |    5 -----
 1 files changed, 0 insertions(+), 5 deletions(-)

diff --git a/drivers/staging/hv/netvsc.c b/drivers/staging/hv/netvsc.c
index 8c6d4ae..f21a59d 100644
--- a/drivers/staging/hv/netvsc.c
+++ b/drivers/staging/hv/netvsc.c
@@ -188,11 +188,6 @@ int netvsc_initialize(struct hv_driver *drv)
 	drv->name = driver_name;
 	memcpy(&drv->dev_type, &netvsc_device_type, sizeof(struct hv_guid));
 
-	/* Make sure it is set by the caller */
-	/* FIXME: These probably should still be tested in some way */
-	/* ASSERT(driver->OnReceiveCallback); */
-	/* ASSERT(driver->OnLinkStatusChanged); */
-
 	/* Setup the dispatch table */
 	driver->base.dev_add	= netvsc_device_add;
 	driver->base.dev_rm	= netvsc_device_remove;
-- 
1.6.3.2
