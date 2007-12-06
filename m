From: Glauber de Oliveira Costa <gcosta@redhat.com>
Subject: [PATCH 14/19] use the same data type for tls_array.
Date: Thu,  6 Dec 2007 14:16:35 -0200
Message-ID: <119695787262-git-send-email-gcosta__25672.5939958871$1196968505$gmane$org@redhat.com>
References: <1196957800568-git-send-email-gcosta@redhat.com>
	<11969578092869-git-send-email-gcosta@redhat.com>
	<11969578142514-git-send-email-gcosta@redhat.com>
	<11969578193406-git-send-email-gcosta@redhat.com>
	<11969578242463-git-send-email-gcosta@redhat.com>
	<11969578292944-git-send-email-gcosta@redhat.com>
	<11969578343061-git-send-email-gcosta@redhat.com>
	<11969578383955-git-send-email-gcosta@redhat.com>
	<11969578431489-git-send-email-gcosta@redhat.com>
	<11969578483552-git-send-email-gcosta@redhat.com>
	<11969578534185-git-send-email-gcosta@redhat.com>
	<11969578581299-git-send-email-gcosta@redhat.com>
	<1196957863723-git-send-email-gcosta@redhat.com>
	<11969578671479-git-send-email-gcosta@redhat.com>
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <11969578671479-git-send-email-gcosta@redhat.com>
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

This patch changes the type of tls_array in x86_64 to
a desc_struct. Now, both i386 and x86_64 tls_array have
the same type, and code accessing it can be shared.

Signed-off-by: Glauber de Oliveira Costa <gcosta@redhat.com>
---
 include/asm-x86/desc_64.h      |    2 +-
 include/asm-x86/processor_64.h |    3 ++-
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/include/asm-x86/desc_64.h b/include/asm-x86/desc_64.h
index 2dc19e2..7fd9876 100644
--- a/include/asm-x86/desc_64.h
+++ b/include/asm-x86/desc_64.h
@@ -150,7 +150,7 @@ static inline void set_ldt(void *addr, int entries)
 static inline void load_TLS(struct thread_struct *t, unsigned int cpu)
 {
 	unsigned int i;
-	u64 *gdt = (u64 *)(get_cpu_gdt_table(cpu) + GDT_ENTRY_TLS_MIN);
+	struct desc_struct *gdt = (get_cpu_gdt_table(cpu) + GDT_ENTRY_TLS_MIN);
 
 	for (i = 0; i < GDT_ENTRY_TLS_ENTRIES; i++)
 		gdt[i] = t->tls_array[i];
diff --git a/include/asm-x86/processor_64.h b/include/asm-x86/processor_64.h
index 5689a8a..742090f 100644
--- a/include/asm-x86/processor_64.h
+++ b/include/asm-x86/processor_64.h
@@ -19,6 +19,7 @@
 #include <linux/personality.h>
 #include <linux/cpumask.h>
 #include <asm/processor-flags.h>
+#include <asm/desc_defs.h>
 
 #define TF_MASK		0x00000100
 #define IF_MASK		0x00000200
@@ -241,7 +242,7 @@ struct thread_struct {
 /* MSR_IA32_DEBUGCTLMSR value to switch in if TIF_DEBUGCTLMSR is set.  */
 	unsigned long	debugctlmsr;
 /* cached TLS descriptors. */
-	u64 tls_array[GDT_ENTRY_TLS_ENTRIES];
+	struct desc_struct tls_array[GDT_ENTRY_TLS_ENTRIES];
 } __attribute__((aligned(16)));
 
 #define INIT_THREAD  { \
-- 
1.4.4.2
