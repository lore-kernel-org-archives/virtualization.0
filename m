From: Joerg Roedel <joro@8bytes.org>
Subject: [PATCH 48/62] x86/sev-es: Handle MONITOR/MONITORX Events
Date: Tue, 11 Feb 2020 14:52:42 +0100
Message-ID: <20200211135256.24617-49-joro@8bytes.org>
References: <20200211135256.24617-1-joro@8bytes.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20200211135256.24617-1-joro@8bytes.org>
Sender: linux-kernel-owner@vger.kernel.org
To: x86@kernel.org
Cc: hpa@zytor.com, Andy Lutomirski <luto@kernel.org>, Dave Hansen <dave.hansen@linux.intel.com>, Peter Zijlstra <peterz@infradead.org>, Thomas Hellstrom <thellstrom@vmware.com>, Jiri Slaby <jslaby@suse.cz>, Dan Williams <dan.j.williams@intel.com>, Tom Lendacky <thomas.lendacky@amd.com>, Juergen Gross <jgross@suse.com>, Kees Cook <keescook@chromium.org>, linux-kernel@vger.kernel.org, kvm@vger.kernel.org, virtualization@lists.linux-foundation.org, Joerg Roedel <joro@8bytes.org>, Joerg Roedel <jroedel@suse.de>
List-Id: virtualization@lists.linuxfoundation.org

From: Tom Lendacky <thomas.lendacky@amd.com>

Implement a handler for #VC exceptions caused by MONITOR and MONITORX
instructions.

Signed-off-by: Tom Lendacky <thomas.lendacky@amd.com>
[ jroedel@suse.de: Adapt to #VC handling infrastructure ]
Co-developed-by: Joerg Roedel <jroedel@suse.de>
Signed-off-by: Joerg Roedel <jroedel@suse.de>
---
 arch/x86/kernel/sev-es.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/arch/x86/kernel/sev-es.c b/arch/x86/kernel/sev-es.c
index d5a14f277adb..865f510d11ba 100644
--- a/arch/x86/kernel/sev-es.c
+++ b/arch/x86/kernel/sev-es.c
@@ -318,6 +318,21 @@ static enum es_result handle_invd(struct ghcb *ghcb, struct es_em_ctxt *ctxt)
 	return ghcb_hv_call(ghcb, ctxt, SVM_EXIT_INVD, 0, 0);
 }
 
+static enum es_result handle_monitor(struct ghcb *ghcb, struct es_em_ctxt *ctxt)
+{
+	phys_addr_t monitor_pa;
+	pgd_t *pgd;
+
+	pgd = __va(read_cr3_pa());
+	monitor_pa = es_slow_virt_to_phys(ghcb, ctxt->regs->ax);
+
+	ghcb_set_rax(ghcb, monitor_pa);
+	ghcb_set_rcx(ghcb, ctxt->regs->cx);
+	ghcb_set_rdx(ghcb, ctxt->regs->dx);
+
+	return ghcb_hv_call(ghcb, ctxt, SVM_EXIT_MONITOR, 0, 0);
+}
+
 static enum es_result handle_vc_exception(struct es_em_ctxt *ctxt,
 					  struct ghcb *ghcb,
 					  unsigned long exit_code,
@@ -354,6 +369,9 @@ static enum es_result handle_vc_exception(struct es_em_ctxt *ctxt,
 	case SVM_EXIT_WBINVD:
 		result = handle_wbinvd(ghcb, ctxt);
 		break;
+	case SVM_EXIT_MONITOR:
+		result = handle_monitor(ghcb, ctxt);
+		break;
 	case SVM_EXIT_NPF:
 		result = handle_mmio(ghcb, ctxt);
 		break;
-- 
2.17.1
