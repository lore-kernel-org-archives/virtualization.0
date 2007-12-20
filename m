From: Glauber de Oliveira Costa <gcosta@redhat.com>
Subject: [PATCH 08/15] add macro for privileged x86_64 operation
Date: Thu, 20 Dec 2007 18:04:03 -0200
Message-ID: <1198181309285-git-send-email-gcosta__4896.56516951999$1198181817$gmane$org@redhat.com>
References: <11981810504172-git-send-email-gcosta@redhat.com>
	<11981811293763-git-send-email-gcosta@redhat.com>
	<11981811852758-git-send-email-gcosta@redhat.com>
	<11981812041672-git-send-email-gcosta@redhat.com>
	<1198181215625-git-send-email-gcosta@redhat.com>
	<1198181224677-git-send-email-gcosta@redhat.com>
	<11981812412879-git-send-email-gcosta@redhat.com>
	<11981812771615-git-send-email-gcosta@redhat.com>
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <11981812771615-git-send-email-gcosta@redhat.com>
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

i386 has a macro GET_CR0_INTO_EAX, used in early trap handling code.
x86_64 has similar needs, only it needs to put cr2 into rcx. We provide
a macro for such task, in the same way

Signed-off-by: Glauber de Oliveira Costa <gcosta@redhat.com>
---
 include/asm-x86/paravirt.h |    6 ++++++
 1 files changed, 6 insertions(+), 0 deletions(-)

Index: linux-2.6-x86/include/asm-x86/paravirt.h
===================================================================
--- linux-2.6-x86.orig/include/asm-x86/paravirt.h	2007-12-20 19:07:28.000000000 -0800
+++ linux-2.6-x86/include/asm-x86/paravirt.h	2007-12-20 19:07:29.000000000 -0800
@@ -1227,6 +1227,12 @@
 	push %ecx; push %edx;			\
 	call *pv_cpu_ops+PV_CPU_read_cr0;	\
 	pop %edx; pop %ecx
+#else
+#define GET_CR2_INTO_RCX			\
+	call *pv_mmu_ops+PV_MMU_read_cr2;	\
+	movq %rax, %rcx;			\
+	xorq %rax, %rax;
+
 #endif
 
 #endif /* __ASSEMBLY__ */
