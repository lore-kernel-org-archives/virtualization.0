From: Isaku Yamahata <yamahata@valinux.co.jp>
Subject: [PATCH 08/17] ia64/pv_ops: preparation for paravirtulization of hand
	written assembly code.
Date: Mon, 19 May 2008 22:13:35 +0900
Message-ID: <12112028251525-git-send-email-yamahata__39264.4177227796$1211203775$gmane$org@valinux.co.jp>
References: <12112028241775-git-send-email-yamahata@valinux.co.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <12112028241775-git-send-email-yamahata@valinux.co.jp>
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
Cc: eddie.dong@intel.com, virtualization@lists.linux-foundation.org, tgingold@free.fr, yamahata@valinux.co.jp, Keith Owens <kaos@ocs.com.au>, xen-ia64-devel@lists.xensource.com
List-Id: virtualization@lists.linuxfoundation.org

Preparation for paravirtualization of hand written assembly code.
They are paravirtualized by single source code and compiled multi times.
To tell those files for target (including native), add one defines.

Cc: "Dong, Eddie" <eddie.dong@intel.com>
Cc: Keith Owens <kaos@ocs.com.au>
Cc: tgingold@free.fr
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
