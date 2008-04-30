From: Isaku Yamahata <yamahata@valinux.co.jp>
Subject: [PATCH 06/15] ia64/pv_ops: preparation for paravirtulization of hand
	written assembly code.
Date: Wed, 30 Apr 2008 21:29:19 +0900
Message-ID: <12095585681382-git-send-email-yamahata__35832.255279138$1209560522$gmane$org@valinux.co.jp>
References: <12095585682308-git-send-email-yamahata@valinux.co.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <12095585682308-git-send-email-yamahata@valinux.co.jp>
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
Cc: yamahata@valinux.co.jp, xen-ia64-devel@lists.xensource.com, eddie.dong@intel.com, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

Preparation for paravirtualization of hand written assembly code.
They are paravirtualized by single source code and compiled multi times.
To tell those files for target (including native), add one defines.

Signed-off-by: Isaku Yamahata <yamahata@valinux.co.jp>
---
 arch/ia64/kernel/Makefile |    9 +++++++++
 1 files changed, 9 insertions(+), 0 deletions(-)

diff --git a/arch/ia64/kernel/Makefile b/arch/ia64/kernel/Makefile
index 10a4ddb..8b25242 100644
--- a/arch/ia64/kernel/Makefile
+++ b/arch/ia64/kernel/Makefile
@@ -72,3 +72,12 @@ $(obj)/gate-syms.o: $(obj)/gate.lds $(obj)/gate.o FORCE
 # We must build gate.so before we can assemble it.
 # Note: kbuild does not track this dependency due to usage of .incbin
 $(obj)/gate-data.o: $(obj)/gate.so
+
+#
+# native ivt.S and entry.S
+#
+ASM_PARAVIRT_OBJS = ivt.o entry.o
+define paravirtualized_native
+AFLAGS_$(1) += -D__IA64_ASM_PARAVIRTUALIZED_NATIVE
+endef
+$(foreach obj,$(ASM_PARAVIRT_OBJS),$(eval $(call paravirtualized_native,$(obj))))
-- 
1.5.3
