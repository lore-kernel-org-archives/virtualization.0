From: jhansen@vmware.com
Subject: [PATCH] VMCI: Guard against overflow in queue pair allocation
Date: Mon,  2 Mar 2015 08:19:11 -0800
Message-ID: <1425313151-9636-1-git-send-email-jhansen__38673.5055283227$1425313073$gmane$org@vmware.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org
Cc: pv-drivers@vmware.com, gregkh@linuxfoundation.org, Jorgen Hansen <jhansen@vmware.com>, dan.carpenter@oracle.com, keescook@google.com
List-Id: virtualization@lists.linuxfoundation.org

From: Jorgen Hansen <jhansen@vmware.com>

The current maximum size of a queue in a queue pair is 128 MB. If
we increase that in the future, the queue pair allocation routines
may run into overflow issues. This change adds additional checks
to guard against this.

Acked-by: Andy King <acking@vmware.com>
Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
Signed-off-by: Jorgen Hansen <jhansen@vmware.com>
---
 drivers/misc/vmw_vmci/vmci_driver.c     |    2 +-
 drivers/misc/vmw_vmci/vmci_queue_pair.c |   31 ++++++++++++++++++++++---------
 2 files changed, 23 insertions(+), 10 deletions(-)

diff --git a/drivers/misc/vmw_vmci/vmci_driver.c b/drivers/misc/vmw_vmci/vmci_driver.c
index cf264a1..b823f9a 100644
--- a/drivers/misc/vmw_vmci/vmci_driver.c
+++ b/drivers/misc/vmw_vmci/vmci_driver.c
@@ -113,5 +113,5 @@ module_exit(vmci_drv_exit);
 
 MODULE_AUTHOR("VMware, Inc.");
 MODULE_DESCRIPTION("VMware Virtual Machine Communication Interface.");
-MODULE_VERSION("1.1.2.0-k");
+MODULE_VERSION("1.1.3.0-k");
 MODULE_LICENSE("GPL v2");
diff --git a/drivers/misc/vmw_vmci/vmci_queue_pair.c b/drivers/misc/vmw_vmci/vmci_queue_pair.c
index 35f19a6..6d5144c 100644
--- a/drivers/misc/vmw_vmci/vmci_queue_pair.c
+++ b/drivers/misc/vmw_vmci/vmci_queue_pair.c
@@ -295,12 +295,20 @@ static void *qp_alloc_queue(u64 size, u32 flags)
 {
 	u64 i;
 	struct vmci_queue *queue;
-	const size_t num_pages = DIV_ROUND_UP(size, PAGE_SIZE) + 1;
-	const size_t pas_size = num_pages * sizeof(*queue->kernel_if->u.g.pas);
-	const size_t vas_size = num_pages * sizeof(*queue->kernel_if->u.g.vas);
-	const size_t queue_size =
-		sizeof(*queue) + sizeof(*queue->kernel_if) +
-		pas_size + vas_size;
+	size_t pas_size;
+	size_t vas_size;
+	size_t queue_size = sizeof(*queue) + sizeof(*queue->kernel_if);
+	const u64 num_pages = DIV_ROUND_UP(size, PAGE_SIZE) + 1;
+
+	if (num_pages >
+		 (SIZE_MAX - queue_size) /
+		 (sizeof(*queue->kernel_if->u.g.pas) +
+		  sizeof(*queue->kernel_if->u.g.vas)))
+		return NULL;
+
+	pas_size = num_pages * sizeof(*queue->kernel_if->u.g.pas);
+	vas_size = num_pages * sizeof(*queue->kernel_if->u.g.vas);
+	queue_size += pas_size + vas_size;
 
 	queue = vmalloc(queue_size);
 	if (!queue)
@@ -615,10 +623,15 @@ static int qp_memcpy_from_queue_iov(void *dest,
 static struct vmci_queue *qp_host_alloc_queue(u64 size)
 {
 	struct vmci_queue *queue;
-	const size_t num_pages = DIV_ROUND_UP(size, PAGE_SIZE) + 1;
+	size_t queue_page_size;
+	const u64 num_pages = DIV_ROUND_UP(size, PAGE_SIZE) + 1;
 	const size_t queue_size = sizeof(*queue) + sizeof(*(queue->kernel_if));
-	const size_t queue_page_size =
-	    num_pages * sizeof(*queue->kernel_if->u.h.page);
+
+	if (num_pages > (SIZE_MAX - queue_size) /
+		 sizeof(*queue->kernel_if->u.h.page))
+		return NULL;
+
+	queue_page_size = num_pages * sizeof(*queue->kernel_if->u.h.page);
 
 	queue = kzalloc(queue_size + queue_page_size, GFP_KERNEL);
 	if (queue) {
-- 
1.7.0
