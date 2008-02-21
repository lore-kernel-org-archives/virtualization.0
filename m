From: yamahata@valinux.co.jp
Subject: [PATCH 03/28] ia64/xen: increase IA64_MAX_RSVD_REGIONS.
Date: Thu, 21 Feb 2008 18:17:34 +0900
Message-ID: <20080221091859.683388000__42668.3532576591$1203633370$gmane$org@ls.local.valinux.co.jp>
References: <20080221091731.641745000@ls.local.valinux.co.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Resent-Message-ID: <20080221223141.GD17530%yamahata@valinux.co.jp>
Resent-To: linux-ia64@vger.kernel.org,
        virtualization@lists.linux-foundation.org,
        kvm-ia64-devel@lists.sourceforge.net
Content-Disposition: inline;
	filename=0003-ia64-xen-increase-IA64_MAX_RSVD_REGIONS.patch
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
Cc: xen-ia64-devel@lists.xensource.com, kvm-ia64-devel@lists.sourceforge.net, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

Xenlinux/ia64 needs to reserve one more region passed from xen hypervisor
as start info.

Signed-off-by: Isaku Yamahata <yamahata@valinux.co.jp>
---
 include/asm-ia64/meminit.h |    7 +++++++
 1 files changed, 7 insertions(+), 0 deletions(-)

diff --git a/include/asm-ia64/meminit.h b/include/asm-ia64/meminit.h
index f93308f..7c12c08 100644
--- a/include/asm-ia64/meminit.h
+++ b/include/asm-ia64/meminit.h
@@ -18,10 +18,17 @@
  * 	- crash dumping code reserved region
  * 	- Kernel memory map built from EFI memory map
  * 	- ELF core header
+ * ifdef CONFIG_XEN
+ *	- xen start info
+ * endif
  *
  * More could be added if necessary
  */
+#ifdef CONFIG_XEN
 #define IA64_MAX_RSVD_REGIONS 8
+#else
+#define IA64_MAX_RSVD_REGIONS 9
+#endif
 
 struct rsvd_region {
 	unsigned long start;	/* virtual address of beginning of element */
-- 
1.5.3

-- 
yamahata
