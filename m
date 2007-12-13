From: Glauber de Oliveira Costa <gcosta@redhat.com>
Subject: [PATCH 13/19] move constants to desc_defs.h
Date: Thu, 13 Dec 2007 11:58:01 -0200
Message-ID: <11975543792334-git-send-email-gcosta__32924.0202940584$1197564731$gmane$org@redhat.com>
References: <11975113122984-git-send-email-gcosta@redhat.com>
	<1197554287294-git-send-email-gcosta@redhat.com>
	<11975542952896-git-send-email-gcosta@redhat.com>
	<11975543001070-git-send-email-gcosta@redhat.com>
	<1197554307167-git-send-email-gcosta@redhat.com>
	<11975543173017-git-send-email-gcosta@redhat.com>
	<11975543382698-git-send-email-gcosta@redhat.com>
	<11975543442801-git-send-email-gcosta@redhat.com>
	<11975543492215-git-send-email-gcosta@redhat.com>
	<11975543543850-git-send-email-gcosta@redhat.com>
	<11975543592701-git-send-email-gcosta@redhat.com>
	<11975543641360-git-send-email-gcosta@redhat.com>
	<11975543691134-git-send-email-gcosta@redhat.com>
	<11975543742848-git-send-email-gcosta@redhat.com>
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <11975543742848-git-send-email-gcosta@redhat.com>
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

this patch moves constant definitions regarding descriptor types
from desc_32.h to desc_defs.h. The change from defines to enum
to comply with previous versions in desc_defs.h

Signed-off-by: Glauber de Oliveira Costa <gcosta@redhat.com>
---
 include/asm-x86/desc_32.h   |    8 --------
 include/asm-x86/desc_defs.h |    5 +++++
 2 files changed, 5 insertions(+), 8 deletions(-)

diff --git a/include/asm-x86/desc_32.h b/include/asm-x86/desc_32.h
index 92a72b0..14238df 100644
--- a/include/asm-x86/desc_32.h
+++ b/include/asm-x86/desc_32.h
@@ -44,14 +44,6 @@ static inline void pack_gate(gate_desc *gate,
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
index c4d7874..5ca416d 100644
--- a/include/asm-x86/desc_defs.h
+++ b/include/asm-x86/desc_defs.h
@@ -55,6 +55,11 @@ struct gate_struct64 {
 enum {
 	DESC_TSS = 0x9,
 	DESC_LDT = 0x2,
+	DESCTYPE_TASK = 0x85,   /* present, system, DPL-0, task gate */
+	DESCTYPE_INT =  0x8e,   /* present, system, DPL-0, interrupt gate */
+	DESCTYPE_TRAP = 0x8f,   /* present, system, DPL-0, trap gate */
+	DESCTYPE_DPL3 = 0x60,   /* DPL-3 */
+	DESCTYPE_S =	0x10,	/* !system */
 };
 
 // LDT or TSS descriptor in the GDT. 16 bytes.
-- 
1.5.0.6
