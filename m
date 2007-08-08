From: Glauber de Oliveira Costa <gcosta@redhat.com>
Subject: [PATCH 20/25] [PATCH] replace syscall_init
Date: Wed,  8 Aug 2007 01:19:07 -0300
Message-ID: <11865468321629-git-send-email-gcosta__31002.1997582682$1186559710$gmane$org@redhat.com>
References: <11865467522495-git-send-email-gcosta@redhat.com>
	<11865467592921-git-send-email-gcosta@redhat.com>
	<1186546763582-git-send-email-gcosta@redhat.com>
	<11865467662182-git-send-email-gcosta@redhat.com>
	<11865467702103-git-send-email-gcosta@redhat.com>
	<11865467741753-git-send-email-gcosta@redhat.com>
	<11865467773012-git-send-email-gcosta@redhat.com>
	<11865467812610-git-send-email-gcosta@redhat.com>
	<1186546785346-git-send-email-gcosta@redhat.com>
	<1186546789356-git-send-email-gcosta@redhat.com>
	<11865467931543-git-send-email-gcosta@redhat.com>
	<11865467973510-git-send-email-gcosta@redhat.com>
	<11865468003673-git-send-email-gcosta@redhat.com>
	<11865468043920-git-send-email-gcosta@redhat.com>
	<118654680831-git-send-email-gcosta@redhat.com>
	<11865468122642-git-send-email-gcosta@redhat.com>
	<11865468162812-git-send-email-gcosta@redhat.com>
	<1186546820708-git-send-email-gcosta@redhat.com>
	<11865468243612-git-send-email-gcosta@redhat.com>
	<11865468281860-git-send-email-gc! osta@redhat.com>
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <11865468281860-git-send-email-gcosta@redhat.com>
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
Cc: lguest@ozlabs.org, virtualization@lists.linux-foundation.org, chrisw@sous-sol.org, anthony@codemonkey.ws, akpm@linux-foundation.org, Glauber de Oliveira Costa <gcosta@redhat.com>, mingo@elte.hu
List-Id: virtualization@lists.linuxfoundation.org

This patch replaces syscall_init by x86_64_syscall_init.
The former will be later replaced by a paravirt replacement
in case paravirt is on

Signed-off-by: Glauber de Oliveira Costa <gcosta@redhat.com>
Signed-off-by: Steven Rostedt <rostedt@goodmis.org>
---
 arch/x86_64/kernel/setup64.c |    8 +++++++-
 include/asm-x86_64/proto.h   |    3 +++
 2 files changed, 10 insertions(+), 1 deletions(-)

diff --git a/arch/x86_64/kernel/setup64.c b/arch/x86_64/kernel/setup64.c
index 49f7342..723822c 100644
--- a/arch/x86_64/kernel/setup64.c
+++ b/arch/x86_64/kernel/setup64.c
@@ -153,7 +153,7 @@ __attribute__((section(".bss.page_aligned")));
 extern asmlinkage void ignore_sysret(void);
 
 /* May not be marked __init: used by software suspend */
-void syscall_init(void)
+void x86_64_syscall_init(void)
 {
 	/* 
 	 * LSTAR and STAR live in a bit strange symbiosis.
@@ -172,6 +172,12 @@ void syscall_init(void)
 	wrmsrl(MSR_SYSCALL_MASK, EF_TF|EF_DF|EF_IE|0x3000); 
 }
 
+/* Overriden in paravirt.c if CONFIG_PARAVIRT */
+void __attribute__((weak)) syscall_init(void)
+{
+	x86_64_syscall_init();
+}
+
 void __cpuinit check_efer(void)
 {
 	unsigned long efer;
diff --git a/include/asm-x86_64/proto.h b/include/asm-x86_64/proto.h
index 31f20ad..77ed2de 100644
--- a/include/asm-x86_64/proto.h
+++ b/include/asm-x86_64/proto.h
@@ -18,6 +18,9 @@ extern void init_memory_mapping(unsigned long start, unsigned long end);
 
 extern void system_call(void); 
 extern int kernel_syscall(void);
+#ifdef CONFIG_PARAVIRT
+extern void x86_64_syscall_init(void);
+#endif
 extern void syscall_init(void);
 
 extern void ia32_syscall(void);
-- 
1.4.4.2
