From: Glauber de Oliveira Costa <gcosta@redhat.com>
Subject: [PATCH 15/15] replace x86_read/write_per_cpu with a common function.
Date: Thu, 20 Dec 2007 18:04:10 -0200
Message-ID: <11981813802836-git-send-email-gcosta__3178.02767172015$1198182089$gmane$org@redhat.com>
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
	<1198181348746-git-send-email-gcosta@redhat.com>
	<11981813592589-git-send-email-gcosta@redhat.com>
	<11981813691362-git-send-email-gcosta@redhat.com>
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <11981813691362-git-send-email-gcosta@redhat.com>
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

x86_read_per_cpu() and its writeish sister are not present in x86_64. So in
this patch, we replace them with __get_cpu_var(), which is present in both

Signed-off-by: Glauber de Oliveira Costa <gcosta@redhat.com>
---
 arch/x86/kernel/paravirt.c |   10 +++++-----
 1 files changed, 5 insertions(+), 5 deletions(-)

Index: linux-2.6-x86/arch/x86/kernel/paravirt.c
===================================================================
--- linux-2.6-x86.orig/arch/x86/kernel/paravirt.c	2007-12-20 19:08:11.000000000 -0800
+++ linux-2.6-x86/arch/x86/kernel/paravirt.c	2007-12-20 19:08:18.000000000 -0800
@@ -238,18 +238,18 @@
 
 static inline void enter_lazy(enum paravirt_lazy_mode mode)
 {
-	BUG_ON(x86_read_percpu(paravirt_lazy_mode) != PARAVIRT_LAZY_NONE);
+	BUG_ON(__get_cpu_var(paravirt_lazy_mode) != PARAVIRT_LAZY_NONE);
 	BUG_ON(preemptible());
 
-	x86_write_percpu(paravirt_lazy_mode, mode);
+	__get_cpu_var(paravirt_lazy_mode) = mode;
 }
 
 void paravirt_leave_lazy(enum paravirt_lazy_mode mode)
 {
-	BUG_ON(x86_read_percpu(paravirt_lazy_mode) != mode);
+	BUG_ON(__get_cpu_var(paravirt_lazy_mode) != mode);
 	BUG_ON(preemptible());
 
-	x86_write_percpu(paravirt_lazy_mode, PARAVIRT_LAZY_NONE);
+	__get_cpu_var(paravirt_lazy_mode) = PARAVIRT_LAZY_NONE;
 }
 
 void paravirt_enter_lazy_mmu(void)
@@ -274,7 +274,7 @@
 
 enum paravirt_lazy_mode paravirt_get_lazy_mode(void)
 {
-	return x86_read_percpu(paravirt_lazy_mode);
+	return __get_cpu_var(paravirt_lazy_mode);
 }
 
 struct pv_info pv_info = {
