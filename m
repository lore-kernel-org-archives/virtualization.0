From: Glauber de Oliveira Costa <gcosta@redhat.com>
Subject: [PATCH 5/10] puts read and write cr8 into pv_cpu_ops
Date: Fri, 18 Jan 2008 15:20:20 -0200
Message-ID: <1200676857691-git-send-email-gcosta@redhat.com>
References: <12006768251548-git-send-email-gcosta@redhat.com>
	<12006768362108-git-send-email-gcosta@redhat.com>
	<1200676842822-git-send-email-gcosta@redhat.com>
	<12006768473571-git-send-email-gcosta@redhat.com>
	<12006768521391-git-send-email-gcosta@redhat.com>
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <12006768521391-git-send-email-gcosta@redhat.com>
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

This patch adds room for read and write_cr8 functions back in
pv_cpu_ops struct

Signed-off-by: Glauber de Oliveira Costa <gcosta@redhat.com>
---
 include/asm-x86/paravirt.h |   15 +++++++++++++++
 1 files changed, 15 insertions(+), 0 deletions(-)

diff --git a/include/asm-x86/paravirt.h b/include/asm-x86/paravirt.h
index 7ff25c2..3e7ca42 100644
--- a/include/asm-x86/paravirt.h
+++ b/include/asm-x86/paravirt.h
@@ -101,6 +101,11 @@ struct pv_cpu_ops {
 	unsigned long (*read_cr4)(void);
 	void (*write_cr4)(unsigned long);
 
+#ifdef CONFIG_X86_64
+	unsigned long (*read_cr8)(void);
+	void (*write_cr8)(unsigned long);
+#endif
+
 	/* Segment descriptor handling */
 	void (*load_tr_desc)(void);
 	void (*load_gdt)(const struct desc_ptr *);
@@ -614,6 +619,16 @@ static inline void write_cr4(unsigned long x)
 	PVOP_VCALL1(pv_cpu_ops.write_cr4, x);
 }
 
+static inline unsigned long read_cr8(void)
+{
+	return PVOP_CALL0(unsigned long, pv_cpu_ops.read_cr8);
+}
+
+static inline void write_cr8(unsigned long x)
+{
+	PVOP_VCALL1(pv_cpu_ops.write_cr8, x);
+}
+
 static inline void raw_safe_halt(void)
 {
 	PVOP_VCALL0(pv_irq_ops.safe_halt);
-- 
1.4.4.2
