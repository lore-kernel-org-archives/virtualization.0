From: Isaku Yamahata <yamahata@valinux.co.jp>
Subject: [PATCH 01/50] xen: add missing __HYPERVISOR_arch_[0-7] definisions
	which ia64 needs.
Date: Thu,  6 Mar 2008 03:18:16 +0900
Message-ID: <12047411452300-git-send-email-yamahata__674.599959939037$1204741578$gmane$org@valinux.co.jp>
References: <12047411453864-git-send-email-yamahata@valinux.co.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <12047411453864-git-send-email-yamahata@valinux.co.jp>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: linux-ia64@vger.kernel.org
Cc: yamahata@valinux.co.jp, virtualization@lists.linux-foundation.org, kvm-ia64-devel@lists.sourceforge.net, xen-ia64-devel@lists.xensource.com
List-Id: virtualization@lists.linuxfoundation.org

Signed-off-by: Isaku Yamahata <yamahata@valinux.co.jp>
---
 include/xen/interface/xen.h |   10 ++++++++++
 1 files changed, 10 insertions(+), 0 deletions(-)

diff --git a/include/xen/interface/xen.h b/include/xen/interface/xen.h
index 518a5bf..87ad143 100644
--- a/include/xen/interface/xen.h
+++ b/include/xen/interface/xen.h
@@ -58,6 +58,16 @@
 #define __HYPERVISOR_physdev_op           33
 #define __HYPERVISOR_hvm_op               34
 
+/* Architecture-specific hypercall definitions. */
+#define __HYPERVISOR_arch_0               48
+#define __HYPERVISOR_arch_1               49
+#define __HYPERVISOR_arch_2               50
+#define __HYPERVISOR_arch_3               51
+#define __HYPERVISOR_arch_4               52
+#define __HYPERVISOR_arch_5               53
+#define __HYPERVISOR_arch_6               54
+#define __HYPERVISOR_arch_7               55
+
 /*
  * VIRTUAL INTERRUPTS
  *
-- 
1.5.3
