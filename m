From: Isaku Yamahata <yamahata@valinux.co.jp>
Subject: [PATCH 02/23] ia64/xen: increase IA64_MAX_RSVD_REGIONS.
Date: Tue, 20 May 2008 08:07:49 +0900
Message-ID: <1211238491830-git-send-email-yamahata__10758.0002899796$1211241026$gmane$org@valinux.co.jp>
References: <12112384902859-git-send-email-yamahata@valinux.co.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <12112384902859-git-send-email-yamahata@valinux.co.jp>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: tony.luck@intel.com, linux-ia64@vger.kernel.org
Cc: eddie.dong@intel.com, virtualization@lists.linux-foundation.org, yamahata@valinux.co.jp, Robin Holt <holt@sgi.com>, xen-ia64-devel@lists.xensource.com, Bjorn Helgaas <bjorn.helgaas@hp.com>
List-Id: virtualization@lists.linuxfoundation.org

Xenlinux/ia64 needs to reserve one more region passed from xen hypervisor
as start info.

Cc: Robin Holt <holt@sgi.com>
Cc: Bjorn Helgaas <bjorn.helgaas@hp.com>
Signed-off-by: Isaku Yamahata <yamahata@valinux.co.jp>
---
 include/asm-ia64/meminit.h |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/include/asm-ia64/meminit.h b/include/asm-ia64/meminit.h
index 7245a57..6bc96ee 100644
--- a/include/asm-ia64/meminit.h
+++ b/include/asm-ia64/meminit.h
@@ -18,10 +18,11 @@
  * 	- crash dumping code reserved region
  * 	- Kernel memory map built from EFI memory map
  * 	- ELF core header
+ *	- xen start info if CONFIG_XEN
  *
  * More could be added if necessary
  */
-#define IA64_MAX_RSVD_REGIONS 8
+#define IA64_MAX_RSVD_REGIONS 9
 
 struct rsvd_region {
 	unsigned long start;	/* virtual address of beginning of element */
-- 
1.5.3
