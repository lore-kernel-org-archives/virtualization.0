From: Juergen Gross <jgross@suse.com>
Subject: [PATCH v3 10/15] x86/paravirt: introduce new config option
	PARAVIRT_XXL
Date: Tue, 28 Aug 2018 09:40:21 +0200
Message-ID: <20180828074026.820-11-jgross__31142.4072985121$1535442683$gmane$org@suse.com>
References: <20180828074026.820-1-jgross@suse.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20180828074026.820-1-jgross@suse.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: linux-kernel@vger.kernel.org, xen-devel@lists.xenproject.org, x86@kernel.org, virtualization@lists.linux-foundation.org
Cc: Juergen Gross <jgross@suse.com>, boris.ostrovsky@oracle.com, rusty@rustcorp.com.au, mingo@redhat.com, hpa@zytor.com, akataria@vmware.com, tglx@linutronix.de
List-Id: virtualization@lists.linuxfoundation.org

A large amount of paravirt ops is used by Xen PV guests only. Add a new
config option PARAVIRT_XXL which is selected by XEN_PV. Later we can
put the Xen PV only paravirt ops under the PARAVIRT_XXL umbrella.

Since irq related paravirt ops are used only by VSMP and Xen PV, let
VSMP select PARAVIRT_XXL, too, in order to enable moving the irq ops
under PARAVIRT_XXL.

Signed-off-by: Juergen Gross <jgross@suse.com>
---
V3:
- let VSMP select PARAVIRT_XXL (Peter Zijlstra)
---
 arch/x86/Kconfig                   | 4 ++++
 arch/x86/boot/compressed/misc.h    | 1 +
 arch/x86/mm/mem_encrypt_identity.c | 1 +
 arch/x86/xen/Kconfig               | 1 +
 4 files changed, 7 insertions(+)

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index c5ff296bc5d1..61dfdb694483 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -523,6 +523,7 @@ config X86_VSMP
 	bool "ScaleMP vSMP"
 	select HYPERVISOR_GUEST
 	select PARAVIRT
+	select PARAVIRT_XXL
 	depends on X86_64 && PCI
 	depends on X86_EXTENDED_PLATFORM
 	depends on SMP
@@ -754,6 +755,9 @@ config PARAVIRT
 	  over full virtualization.  However, when run without a hypervisor
 	  the kernel is theoretically slower and slightly larger.
 
+config PARAVIRT_XXL
+	bool
+
 config PARAVIRT_DEBUG
 	bool "paravirt-ops debugging"
 	depends on PARAVIRT && DEBUG_KERNEL
diff --git a/arch/x86/boot/compressed/misc.h b/arch/x86/boot/compressed/misc.h
index a423bdb42686..a1d5918765f3 100644
--- a/arch/x86/boot/compressed/misc.h
+++ b/arch/x86/boot/compressed/misc.h
@@ -9,6 +9,7 @@
  * paravirt and debugging variants are added.)
  */
 #undef CONFIG_PARAVIRT
+#undef CONFIG_PARAVIRT_XXL
 #undef CONFIG_PARAVIRT_SPINLOCKS
 #undef CONFIG_KASAN
 
diff --git a/arch/x86/mm/mem_encrypt_identity.c b/arch/x86/mm/mem_encrypt_identity.c
index 7ae36868aed2..a19ef1a416ff 100644
--- a/arch/x86/mm/mem_encrypt_identity.c
+++ b/arch/x86/mm/mem_encrypt_identity.c
@@ -27,6 +27,7 @@
  * be extended when new paravirt and debugging variants are added.)
  */
 #undef CONFIG_PARAVIRT
+#undef CONFIG_PARAVIRT_XXL
 #undef CONFIG_PARAVIRT_SPINLOCKS
 
 #include <linux/kernel.h>
diff --git a/arch/x86/xen/Kconfig b/arch/x86/xen/Kconfig
index c1f98f32c45f..dd92d7bd3613 100644
--- a/arch/x86/xen/Kconfig
+++ b/arch/x86/xen/Kconfig
@@ -18,6 +18,7 @@ config XEN_PV
 	bool "Xen PV guest support"
 	default y
 	depends on XEN
+	select PARAVIRT_XXL
 	select XEN_HAVE_PVMMU
 	select XEN_HAVE_VPMU
 	help
-- 
2.16.4
