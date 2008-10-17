From: Isaku Yamahata <yamahata@valinux.co.jp>
Subject: [PATCH 01/33] ia64/pv_ops: fix paraviatualization of ivt.S with
	CONFIG_SMP=n
Date: Fri, 17 Oct 2008 11:17:41 +0900
Message-ID: <1224209893-2032-2-git-send-email-yamahata__9722.65743553198$1224209976$gmane$org@valinux.co.jp>
References: <1224209893-2032-1-git-send-email-yamahata@valinux.co.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1224209893-2032-1-git-send-email-yamahata@valinux.co.jp>
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
Cc: yamahata@valinux.co.jp, xen-ia64-devel@lists.xensource.com, mingo@elte.hu, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

When CONFIG_SMP=n, three instruction in ivt.S were missed to paravirtualize.
paravirtualize them.

Cc: "Luck, Tony" <tony.luck@intel.com>
Signed-off-by: Isaku Yamahata <yamahata@valinux.co.jp>
---
 arch/ia64/kernel/ivt.S |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/ia64/kernel/ivt.S b/arch/ia64/kernel/ivt.S
index 416a952..f675d8e 100644
--- a/arch/ia64/kernel/ivt.S
+++ b/arch/ia64/kernel/ivt.S
@@ -580,7 +580,7 @@ ENTRY(dirty_bit)
 	mov b0=r29				// restore b0
 	;;
 	st8 [r17]=r18				// store back updated PTE
-	itc.d r18				// install updated PTE
+	ITC_D(p0, r18, r16)			// install updated PTE
 #endif
 	mov pr=r31,-1				// restore pr
 	RFI
@@ -646,7 +646,7 @@ ENTRY(iaccess_bit)
 	mov b0=r29				// restore b0
 	;;
 	st8 [r17]=r18				// store back updated PTE
-	itc.i r18				// install updated PTE
+	ITC_I(p0, r18, r16)			// install updated PTE
 #endif /* !CONFIG_SMP */
 	mov pr=r31,-1
 	RFI
@@ -698,7 +698,7 @@ ENTRY(daccess_bit)
 	or r18=_PAGE_A,r18			// set the accessed bit
 	;;
 	st8 [r17]=r18				// store back updated PTE
-	itc.d r18				// install updated PTE
+	ITC_D(p0, r18, r16)			// install updated PTE
 #endif
 	mov b0=r29				// restore b0
 	mov pr=r31,-1
-- 
1.6.0.2
