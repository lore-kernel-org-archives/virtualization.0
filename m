From: Andy King <acking@vmware.com>
Subject: [PATCH] VMCI: Check userland-provided datagram size
Date: Thu, 19 Feb 2015 10:33:56 -0800
Message-ID: <1424370836-22334-1-git-send-email-acking__49620.2762508348$1424370757$gmane$org@vmware.com>
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
Cc: pv-drivers@vmware.com, gregkh@linuxfoundation.org, Andy King <acking@vmware.com>, daramos@stanford.edu
List-Id: virtualization@lists.linuxfoundation.org

Ensure that the size filled in by userland in the datagram header
matches the size of the buffer passed down in the IOCTL. Note that we
account for the size of the header itself in the check.

Acked-by: Jorgen Hansen <jhansen@vmware.com>
Acked-by: Aditya Sarwade <asarwade@vmware.com>
Signed-off-by: Andy King <acking@vmware.com>
Reported-by: David Ramos <daramos@stanford.edu>
---
 drivers/misc/vmw_vmci/vmci_driver.c | 2 +-
 drivers/misc/vmw_vmci/vmci_host.c   | 6 ++++++
 2 files changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/misc/vmw_vmci/vmci_driver.c b/drivers/misc/vmw_vmci/vmci_driver.c
index 032d35c..cf264a1 100644
--- a/drivers/misc/vmw_vmci/vmci_driver.c
+++ b/drivers/misc/vmw_vmci/vmci_driver.c
@@ -113,5 +113,5 @@ module_exit(vmci_drv_exit);
 
 MODULE_AUTHOR("VMware, Inc.");
 MODULE_DESCRIPTION("VMware Virtual Machine Communication Interface.");
-MODULE_VERSION("1.1.1.0-k");
+MODULE_VERSION("1.1.2.0-k");
 MODULE_LICENSE("GPL v2");
diff --git a/drivers/misc/vmw_vmci/vmci_host.c b/drivers/misc/vmw_vmci/vmci_host.c
index 66fc992..a721b5d 100644
--- a/drivers/misc/vmw_vmci/vmci_host.c
+++ b/drivers/misc/vmw_vmci/vmci_host.c
@@ -395,6 +395,12 @@ static int vmci_host_do_send_datagram(struct vmci_host_dev *vmci_host_dev,
 		return -EFAULT;
 	}
 
+	if (VMCI_DG_SIZE(dg) != send_info.len) {
+		vmci_ioctl_err("datagram size mismatch\n");
+		kfree(dg);
+		return -EINVAL;
+	}
+
 	pr_devel("Datagram dst (handle=0x%x:0x%x) src (handle=0x%x:0x%x), payload (size=%llu bytes)\n",
 		 dg->dst.context, dg->dst.resource,
 		 dg->src.context, dg->src.resource,
-- 
1.8.5.6
