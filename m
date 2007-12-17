From: Glauber de Oliveira Costa <gcosta@redhat.com>
Subject: [PATCH 1/21] move tsc definitions to were they belong
Date: Mon, 17 Dec 2007 20:52:24 -0200
Message-ID: <1197931971748-git-send-email-gcosta@redhat.com>
References: <11979319641796-git-send-email-gcosta@redhat.com>
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <11979319641796-git-send-email-gcosta@redhat.com>
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

This patch wipes out the definitions of tsc_disable from processor_32.h 
and move it to tsc.h, were it belongs

Signed-off-by: Glauber de Oliveira Costa <gcosta@redhat.com>
---
 include/asm-x86/processor_32.h |    7 -------
 include/asm-x86/tsc.h          |    6 ++++++
 2 files changed, 6 insertions(+), 7 deletions(-)

Index: linux-2.6-x86/include/asm-x86/processor_32.h
===================================================================
--- linux-2.6-x86.orig/include/asm-x86/processor_32.h
+++ linux-2.6-x86/include/asm-x86/processor_32.h
@@ -22,9 +22,6 @@
 #include <asm/processor-flags.h>
 #include <asm/desc_defs.h>
 
-/* flag for disabling the tsc */
-extern int tsc_disable;
-
 static inline int desc_empty(const void *ptr)
 {
 	const u32 *desc = ptr;
@@ -206,8 +203,6 @@ extern int bootloader_type;
 
 #define HAVE_ARCH_PICK_MMAP_LAYOUT
 
-extern void disable_TSC(void);
-
 /*
  * Size of io_bitmap.
  */
Index: linux-2.6-x86/include/asm-x86/tsc.h
===================================================================
--- linux-2.6-x86.orig/include/asm-x86/tsc.h
+++ linux-2.6-x86/include/asm-x86/tsc.h
@@ -16,6 +16,10 @@ typedef unsigned long long cycles_t;
 
 extern unsigned int cpu_khz;
 extern unsigned int tsc_khz;
+/* flag for disabling the tsc */
+extern int tsc_disable;
+
+extern void disable_TSC(void);
 
 static inline cycles_t get_cycles(void)
 {
