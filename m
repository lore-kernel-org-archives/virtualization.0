From: Glauber de Oliveira Costa <gcosta@redhat.com>
Subject: [PATCH 9/10] make fixups wordsize agnostic
Date: Tue,  4 Dec 2007 14:03:59 -0200
Message-ID: <1196784287349-git-send-email-gcosta@redhat.com>
References: 20071204140939.GA16328@elte.hu
	<11967842402729-git-send-email-gcosta@redhat.com>
	<11967842482873-git-send-email-gcosta@redhat.com>
	<11967842531735-git-send-email-gcosta@redhat.com>
	<11967842573035-git-send-email-gcosta@redhat.com>
	<11967842622658-git-send-email-gcosta@redhat.com>
	<119678426719-git-send-email-gcosta@redhat.com>
	<11967842711043-git-send-email-gcosta@redhat.com>
	<11967842762820-git-send-email-gcosta@redhat.com>
	<11967842821886-git-send-email-gcosta@redhat.com>
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <11967842821886-git-send-email-gcosta@redhat.com>
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
Cc: ehabkost@redhat.com, ak@suse.de, virtualization@lists.linux-foundation.org, chrisw@sous-sol.org, tglx@linutronix.de, anthony@codemonkey.ws, hpa@zytor.com, akpm@linux-foundation.org, Glauber de Oliveira Costa <gcosta@redhat.com>, mingo@elte.hu
List-Id: virtualization@lists.linuxfoundation.org

This patch uses the _ASM_ALIGN and _ASM_PTR macros
to make the fixups in native_read/write_msr_safe look the same
for x86_64 and i386. Besides using this macros, we also have to
take the explicit instruction suffixes out. It's okay
because all this instructions uses registers, and can be sized by
them.

Signed-off-by: Glauber de Oliveira Costa <gcosta@redhat.com>
---
 include/asm-x86/msr.h |   17 +++++++++--------
 1 files changed, 9 insertions(+), 8 deletions(-)

diff --git a/include/asm-x86/msr.h b/include/asm-x86/msr.h
index 9c695c7..f3a01ca 100644
--- a/include/asm-x86/msr.h
+++ b/include/asm-x86/msr.h
@@ -29,6 +29,7 @@ static inline unsigned long long native_read_tscp(int *aux)
 #ifdef __KERNEL__
 #ifndef __ASSEMBLY__
 
+#include <asm/asm.h>
 #include <asm/errno.h>
 
 static inline unsigned long long native_read_msr(unsigned int msr)
@@ -44,14 +45,14 @@ static inline unsigned long long native_read_msr_safe(unsigned int msr,
 {
 	unsigned long long val;
 
-	asm volatile("2: rdmsr ; xorl %0,%0\n"
+	asm volatile("2: rdmsr ; xor %0,%0\n"
 		     "1:\n\t"
 		     ".section .fixup,\"ax\"\n\t"
-		     "3:  movl %3,%0 ; jmp 1b\n\t"
+		     "3:  mov %3,%0 ; jmp 1b\n\t"
 		     ".previous\n\t"
 		     ".section __ex_table,\"a\"\n"
-		     "   .align 4\n\t"
-		     "   .long	2b,3b\n\t"
+		     _ASM_ALIGN "\n\t"
+		     _ASM_PTR " 2b,3b\n\t"
 		     ".previous"
 		     : "=r" (*err), "=A" (val)
 		     : "c" (msr), "i" (-EFAULT));
@@ -69,14 +70,14 @@ static inline int native_write_msr_safe(unsigned int msr,
 					unsigned low, unsigned high)
 {
 	int err;
-	asm volatile("2: wrmsr ; xorl %0,%0\n"
+	asm volatile("2: wrmsr ; xor %0,%0\n"
 		     "1:\n\t"
 		     ".section .fixup,\"ax\"\n\t"
-		     "3:  movl %4,%0 ; jmp 1b\n\t"
+		     "3:  mov %4,%0 ; jmp 1b\n\t"
 		     ".previous\n\t"
 		     ".section __ex_table,\"a\"\n"
-		     "   .align 4\n\t"
-		     "   .long	2b,3b\n\t"
+		     _ASM_ALIGN "\n\t"
+		     _ASM_PTR " 2b,3b\n\t"
 		     ".previous"
 		     : "=a" (err)
 		     : "c" (msr), "0" (low), "d" (high),
-- 
1.4.4.2
