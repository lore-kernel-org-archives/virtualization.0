From: Glauber de Oliveira Costa <gcosta@redhat.com>
Subject: [PATCH 15/19] use the same data type for tls_array.
Date: Thu, 13 Dec 2007 00:01:48 -0200
Message-ID: <11975113873364-git-send-email-gcosta__44652.4903680713$1197523174$gmane$org@redhat.com>
References: <1196957800568-git-send-email-gcosta@redhat.com>
	<11975113122984-git-send-email-gcosta@redhat.com>
	<11975113194101-git-send-email-gcosta@redhat.com>
	<11975113243875-git-send-email-gcosta@redhat.com>
	<11975113291722-git-send-email-gcosta@redhat.com>
	<1197511334416-git-send-email-gcosta@redhat.com>
	<1197511338810-git-send-email-gcosta@redhat.com>
	<1197511343355-git-send-email-gcosta@redhat.com>
	<11975113484194-git-send-email-gcosta@redhat.com>
	<11975113532186-git-send-email-gcosta@redhat.com>
	<11975113583644-git-send-email-gcosta@redhat.com>
	<1197511363887-git-send-email-gcosta@redhat.com>
	<11975113672937-git-send-email-gcosta@redhat.com>
	<11975113721808-git-send-email-gcosta@redhat.com>
	<11975113771692-git-send-email-gcosta@redhat.com>
	<11975113821418-git-send-email-gcosta@redhat.com>
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <11975113821418-git-send-email-gcosta@redhat.com>
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
index 8efdf99..51f1970 100644
--- a/include/asm-x86/processor_64.h
+++ b/include/asm-x86/processor_64.h
@@ -19,6 +19,7 @@
 #include <linux/personality.h>
 #include <linux/cpumask.h>
 #include <asm/processor-flags.h>
+#include <asm/desc_defs.h>
 
 #define TF_MASK		0x00000100
 #define IF_MASK		0x00000200
@@ -244,7 +245,7 @@ struct thread_struct {
  *               goes into MSR_IA32_DS_AREA */
 	unsigned long	ds_area_msr;
 /* cached TLS descriptors. */
-	u64 tls_array[GDT_ENTRY_TLS_ENTRIES];
+	struct desc_struct tls_array[GDT_ENTRY_TLS_ENTRIES];
 } __attribute__((aligned(16)));
 
 #define INIT_THREAD  { \
-- 
1.5.0.6
