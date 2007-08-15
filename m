From: Glauber de Oliveira Costa <gcosta@redhat.com>
Subject: [PATCH 16/25][V3] turn page operations into native versions
Date: Wed, 15 Aug 2007 09:49:36 -0300
Message-ID: <11871823782610-git-send-email-gcosta__45027.9848337688$1187182999$gmane$org@redhat.com>
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
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <11871823673236-git-send-email-gcosta@redhat.com>
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
