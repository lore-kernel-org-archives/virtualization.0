From: Glauber de Oliveira Costa <gcosta@redhat.com>
Subject: [PATCH 20/25][V3] replace syscall_init
Date: Wed, 15 Aug 2007 09:49:40 -0300
Message-ID: <11871824192375-git-send-email-gcosta__14874.449131503$1187183016$gmane$org@redhat.com>
References: <11871821854176-git-send-email-gcosta@redhat.com>
	<1187182197314-git-send-email-gcosta@redhat.com>
	<11871822062386-git-send-email-gcosta@redhat.com>
	<11871822163867-git-send-email-gcosta@redhat.com>
	<11871822244170-git-send-email-gcosta@redhat.com>
	<11871822342754-git-send-email-gcosta@redhat.com>
	<11871822421713-git-send-email-gcosta@redhat.com>
	<1187182253740-git-send-email-gcosta@redhat.com>
	<1187182268408-git-send-email-gcosta@redhat.com>
	<1187182282913-git-send-email-gcosta@redhat.com>
	<11871822951747-git-send-email-gcosta@redhat.com>
	<11871823042011-git-send-email-gcosta@redhat.com>
	<11871823151789-git-send-email-gcosta@redhat.com>
	<11871823273810-git-send-email-gcosta@redhat.com>
	<11871823373106-git-send-email-gcosta@redhat.com>
	<11871823673236-git-send-email-gcosta@redhat.com>
	<11871823782610-git-send-email-gcosta@redhat.com>
	<11871823892519-git-send-email-gcosta@redhat.com>
	<11871823991803-git-send-email-gcosta@redhat.com>
	<11871824081337-git-send-email-! gcosta@redhat.com>
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <11871824081337-git-send-email-gcosta@redhat.com>
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
