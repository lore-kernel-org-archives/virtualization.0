From: Glauber de Oliveira Costa <gcosta@redhat.com>
Subject: [PATCH 12/15] add CLBR_ defines for x86_64.
Date: Thu, 20 Dec 2007 18:04:07 -0200
Message-ID: <1198181348746-git-send-email-gcosta__38165.4265489944$1198182032$gmane$org@redhat.com>
References: <11981810504172-git-send-email-gcosta@redhat.com>
	<11981811293763-git-send-email-gcosta@redhat.com>
	<11981811852758-git-send-email-gcosta@redhat.com>
	<11981812041672-git-send-email-gcosta@redhat.com>
	<1198181215625-git-send-email-gcosta@redhat.com>
	<1198181224677-git-send-email-gcosta@redhat.com>
	<11981812412879-git-send-email-gcosta@redhat.com>
	<11981812771615-git-send-email-gcosta@redhat.com>
	<1198181309285-git-send-email-gcosta@redhat.com>
	<11981813192341-git-send-email-gcosta@redhat.com>
	<11981813292926-git-send-email-gcosta@redhat.com>
	<11981813384090-git-send-email-gcosta@redhat.com>
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <11981813384090-git-send-email-gcosta@redhat.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: linux-kernel@vger.kernel.org
Cc: ehabkost@redhat.com, ak@suse.de, virtualization@lists.linux-foundation.org, chrisw@sous-sol.org, tglx@linutronix.de, anthony@codemonkey.ws, hpa@zytor.com, akpm@linux-foundation.org, Glauber de Oliveira Costa <gcosta@redhat.com>, mingo@elte.hu, roland@redhat.com
List-Id: virtualization@lists.linuxfoundation.org

x86_64 needs a potentially larger clobber list than i386, due to its calling
convention. So we add more CLBR_ defines for it.
Note that CLBR_ANY is different for each of the architectures, since it comprises
the notion of "All call clobbers in this architecture"

Signed-off-by: Glauber de Oliveira Costa <gcosta@redhat.com>
---
 include/asm-x86/paravirt.h |   23 ++++++++++++++++++-----
 1 files changed, 18 insertions(+), 5 deletions(-)

Index: linux-2.6-x86/include/asm-x86/paravirt.h
===================================================================
--- linux-2.6-x86.orig/include/asm-x86/paravirt.h	2007-12-20 19:08:06.000000000 -0800
+++ linux-2.6-x86/include/asm-x86/paravirt.h	2007-12-20 19:08:10.000000000 -0800
@@ -8,11 +8,24 @@
 #include <asm/asm.h>
 
 /* Bitmask of what can be clobbered: usually at least eax. */
-#define CLBR_NONE 0x0
-#define CLBR_EAX 0x1
-#define CLBR_ECX 0x2
-#define CLBR_EDX 0x4
-#define CLBR_ANY 0x7
+#define CLBR_NONE 0
+#define CLBR_EAX  (1 << 0)
+#define CLBR_ECX  (1 << 1)
+#define CLBR_EDX  (1 << 2)
+
+#ifdef CONFIG_X86_64
+#define CLBR_RSI  (1 << 3)
+#define CLBR_RDI  (1 << 4)
+#define CLBR_R8   (1 << 5)
+#define CLBR_R9   (1 << 6)
+#define CLBR_R10  (1 << 7)
+#define CLBR_R11  (1 << 8)
+#define CLBR_ANY  ((1 << 9) - 1)
+#include <asm/desc_defs.h>
+#else
+/* CLBR_ANY should match all regs platform has. For i386, that's just it */
+#define CLBR_ANY  ((1 << 3) - 1)
+#endif /* X86_64 */
 
 #ifndef __ASSEMBLY__
 #include <linux/types.h>
