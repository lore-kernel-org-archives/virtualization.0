From: Glauber de Oliveira Costa <gcosta@redhat.com>
Subject: [PATCH 16/25 -v2] turn page operations into native versions
Date: Fri, 10 Aug 2007 16:12:28 -0300
Message-ID: <11867732373232-git-send-email-gcosta__31666.1789817319$1186784548$gmane$org@redhat.com>
References: <1186773157329-git-send-email-gcosta@redhat.com>
	<11867731633002-git-send-email-gcosta@redhat.com>
	<11867731681763-git-send-email-gcosta@redhat.com>
	<11867731732274-git-send-email-gcosta@redhat.com>
	<11867731781610-git-send-email-gcosta@redhat.com>
	<11867731831138-git-send-email-gcosta@redhat.com>
	<11867731882768-git-send-email-gcosta@redhat.com>
	<11867731932688-git-send-email-gcosta@redhat.com>
	<11867731981891-git-send-email-gcosta@redhat.com>
	<1186773203887-git-send-email-gcosta@redhat.com>
	<11867732082735-git-send-email-gcosta@redhat.com>
	<11867732121974-git-send-email-gcosta@redhat.com>
	<1186773217875-git-send-email-gcosta@redhat.com>
	<11867732221652-git-send-email-gcosta@redhat.com>
	<11867732273108-git-send-email-gcosta@redhat.com>
	<11867732323106-git-send-email-gcosta@redhat.com>
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <11867732323106-git-send-email-gcosta@redhat.com>
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

This patch turns the page operations (set and make a page table)
into native_ versions. The operations itself will be later
overriden by paravirt.

Signed-off-by: Glauber de Oliveira Costa <gcosta@redhat.com>
Signed-off-by: Steven Rostedt <rostedt@goodmis.org>
---
 include/asm-x86_64/page.h |   36 +++++++++++++++++++++++++++++++-----
 1 files changed, 31 insertions(+), 5 deletions(-)

diff --git a/include/asm-x86_64/page.h b/include/asm-x86_64/page.h
index 88adf1a..ec8b245 100644
--- a/include/asm-x86_64/page.h
+++ b/include/asm-x86_64/page.h
@@ -64,16 +64,42 @@ typedef struct { unsigned long pgprot; } pgprot_t;
 
 extern unsigned long phys_base;
 
-#define pte_val(x)	((x).pte)
-#define pmd_val(x)	((x).pmd)
-#define pud_val(x)	((x).pud)
-#define pgd_val(x)	((x).pgd)
-#define pgprot_val(x)	((x).pgprot)
+static inline unsigned long native_pte_val(pte_t pte)
+{
+	return pte.pte;
+}
+
+static inline unsigned long native_pud_val(pud_t pud)
+{
+	return pud.pud;
+}
+
+
+static inline unsigned long native_pmd_val(pmd_t pmd)
+{
+	return pmd.pmd;
+}
+
+static inline unsigned long native_pgd_val(pgd_t pgd)
+{
+	return pgd.pgd;
+}
+
+#ifdef CONFIG_PARAVIRT
+#include <asm/paravirt.h>
+#else
+#define pte_val(x)	native_pte_val(x)
+#define pmd_val(x)	native_pmd_val(x)
+#define pud_val(x)	native_pud_val(x)
+#define pgd_val(x)	native_pgd_val(x)
 
 #define __pte(x) ((pte_t) { (x) } )
 #define __pmd(x) ((pmd_t) { (x) } )
 #define __pud(x) ((pud_t) { (x) } )
 #define __pgd(x) ((pgd_t) { (x) } )
+#endif /* CONFIG_PARAVIRT */
+
+#define pgprot_val(x)	((x).pgprot)
 #define __pgprot(x)	((pgprot_t) { (x) } )
 
 #endif /* !__ASSEMBLY__ */
-- 
1.4.4.2
