From: Glauber de Oliveira Costa <gcosta@redhat.com>
Subject: [PATCH 8/10] add asm_offset PARAVIRT constants
Date: Fri, 18 Jan 2008 15:20:23 -0200
Message-ID: <12006768732175-git-send-email-gcosta@redhat.com>
References: <12006768251548-git-send-email-gcosta@redhat.com>
	<12006768362108-git-send-email-gcosta@redhat.com>
	<1200676842822-git-send-email-gcosta@redhat.com>
	<12006768473571-git-send-email-gcosta@redhat.com>
	<12006768521391-git-send-email-gcosta@redhat.com>
	<1200676857691-git-send-email-gcosta@redhat.com>
	<12006768631010-git-send-email-gcosta@redhat.com>
	<12006768683247-git-send-email-gcosta@redhat.com>
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <12006768683247-git-send-email-gcosta@redhat.com>
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

This patch adds the constant PARAVIRT needs in asm_offsets_64.c

Signed-off-by: Glauber de Oliveira Costa <gcosta@redhat.com>
---
 arch/x86/kernel/asm-offsets_64.c |   14 ++++++++++++++
 1 files changed, 14 insertions(+), 0 deletions(-)

diff --git a/arch/x86/kernel/asm-offsets_64.c b/arch/x86/kernel/asm-offsets_64.c
index 2b32719..494e1e0 100644
--- a/arch/x86/kernel/asm-offsets_64.c
+++ b/arch/x86/kernel/asm-offsets_64.c
@@ -61,6 +61,20 @@ int main(void)
 	ENTRY(data_offset);
 	BLANK();
 #undef ENTRY
+#ifdef CONFIG_PARAVIRT
+	BLANK();
+	OFFSET(PARAVIRT_enabled, pv_info, paravirt_enabled);
+	OFFSET(PARAVIRT_PATCH_pv_cpu_ops, paravirt_patch_template, pv_cpu_ops);
+	OFFSET(PARAVIRT_PATCH_pv_irq_ops, paravirt_patch_template, pv_irq_ops);
+	OFFSET(PV_IRQ_irq_disable, pv_irq_ops, irq_disable);
+	OFFSET(PV_IRQ_irq_enable, pv_irq_ops, irq_enable);
+	OFFSET(PV_CPU_iret, pv_cpu_ops, iret);
+	OFFSET(PV_CPU_irq_enable_syscall_ret, pv_cpu_ops, irq_enable_syscall_ret);
+	OFFSET(PV_CPU_swapgs, pv_cpu_ops, swapgs);
+	OFFSET(PV_MMU_read_cr2, pv_mmu_ops, read_cr2);
+#endif
+
+
 #ifdef CONFIG_IA32_EMULATION
 #define ENTRY(entry) DEFINE(IA32_SIGCONTEXT_ ## entry, offsetof(struct sigcontext_ia32, entry))
 	ENTRY(ax);
-- 
1.4.4.2
