From: Glauber de Oliveira Costa <gcosta@redhat.com>
Subject: [PATCH 12/19] move constants to desc_defs.h
Date: Thu,  6 Dec 2007 14:16:33 -0200
Message-ID: <1196957863723-git-send-email-gcosta__5745.51034155792$1196968504$gmane$org@redhat.com>
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
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <11969578581299-git-send-email-gcosta@redhat.com>
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

this patch moves constant definitions regarding descriptor types
from desc_32.h to desc_defs.h. The change from defines to enum
to comply with previous versions in desc_defs.h

Signed-off-by: Glauber de Oliveira Costa <gcosta@redhat.com>
---
 include/asm-x86/desc_32.h   |    8 --------
 include/asm-x86/desc_defs.h |    7 +++++++
 2 files changed, 7 insertions(+), 8 deletions(-)

diff --git a/include/asm-x86/desc_32.h b/include/asm-x86/desc_32.h
index 46fe80a..5d1e848 100644
--- a/include/asm-x86/desc_32.h
+++ b/include/asm-x86/desc_32.h
@@ -43,14 +43,6 @@ static inline void pack_gate(gate_desc *gate,
 	gate->b = (base & 0xffff0000) | ((type & 0xff) << 8) | (flags & 0xff);
 }
 
-#define DESCTYPE_LDT 	0x82	/* present, system, DPL-0, LDT */
-#define DESCTYPE_TSS 	0x89	/* present, system, DPL-0, 32-bit TSS */
-#define DESCTYPE_TASK	0x85	/* present, system, DPL-0, task gate */
-#define DESCTYPE_INT	0x8e	/* present, system, DPL-0, interrupt gate */
-#define DESCTYPE_TRAP	0x8f	/* present, system, DPL-0, trap gate */
-#define DESCTYPE_DPL3	0x60	/* DPL-3 */
-#define DESCTYPE_S	0x10	/* !system */
-
 #ifdef CONFIG_PARAVIRT
 #include <asm/paravirt.h>
 #else
diff --git a/include/asm-x86/desc_defs.h b/include/asm-x86/desc_defs.h
index 3a562d1..3bfb7d9 100644
--- a/include/asm-x86/desc_defs.h
+++ b/include/asm-x86/desc_defs.h
@@ -58,6 +58,13 @@ struct gate_struct64 {
 enum {
 	DESC_TSS = 0x9,
 	DESC_LDT = 0x2,
+	DESCTYPE_LDT =	0x82,	/* present, system, DPL-0, LDT */
+	DESCTYPE_TSS =	0x89,	/* present, system, DPL-0, 32-bit TSS */
+	DESCTYPE_TASK = 0x85,   /* present, system, DPL-0, task gate */
+	DESCTYPE_INT =  0x8e,   /* present, system, DPL-0, interrupt gate */
+	DESCTYPE_TRAP = 0x8f,   /* present, system, DPL-0, trap gate */
+	DESCTYPE_DPL3 = 0x60,   /* DPL-3 */
+	DESCTYPE_S =	0x10,	/* !system */
 };
 
 // LDT or TSS descriptor in the GDT. 16 bytes.
-- 
1.4.4.2
