From: Joerg Roedel <joro@8bytes.org>
Subject: [PATCH v4 09/75] x86/insn: Add insn_get_modrm_reg_off()
Date: Tue, 14 Jul 2020 14:08:11 +0200
Message-ID: <20200714120917.11253-10-joro@8bytes.org>
References: <20200714120917.11253-1-joro@8bytes.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <20200714120917.11253-1-joro@8bytes.org>
Sender: kvm-owner@vger.kernel.org
To: x86@kernel.org
Cc: Joerg Roedel <joro@8bytes.org>, Joerg Roedel <jroedel@suse.de>, Masami Hiramatsu <mhiramat@kernel.org>, hpa@zytor.com, Andy Lutomirski <luto@kernel.org>, Dave Hansen <dave.hansen@linux.intel.com>, Peter Zijlstra <peterz@infradead.org>, Jiri Slaby <jslaby@suse.cz>, Dan Williams <dan.j.williams@intel.com>, Tom Lendacky <thomas.lendacky@amd.com>, Juergen Gross <jgross@suse.com>, Kees Cook <keescook@chromium.org>, David Rientjes <rientjes@google.com>, Cfir Cohen <cfir@google.com>, Erdem Aktas <erdemaktas@google.com>, Mike Stunes <mstunes@vmware.com>, Sean Christopherson <sean.j.christopherson@intel.com>, Martin Radev <martin.b.radev@gmail.com>, linux-kernel@vger.kernel.org, kvm@vger.kernel.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

From: Joerg Roedel <jroedel@suse.de>

Add a function to the instruction decoder which returns the pt_regs
offset of the register specified in the reg field of the modrm byte.

Signed-off-by: Joerg Roedel <jroedel@suse.de>
Acked-by: Masami Hiramatsu <mhiramat@kernel.org>
---
 arch/x86/include/asm/insn-eval.h |  1 +
 arch/x86/lib/insn-eval.c         | 23 +++++++++++++++++++++++
 2 files changed, 24 insertions(+)

diff --git a/arch/x86/include/asm/insn-eval.h b/arch/x86/include/asm/insn-eval.h
index 392b4fe377f9..f748f57f1491 100644
--- a/arch/x86/include/asm/insn-eval.h
+++ b/arch/x86/include/asm/insn-eval.h
@@ -17,6 +17,7 @@
 
 void __user *insn_get_addr_ref(struct insn *insn, struct pt_regs *regs);
 int insn_get_modrm_rm_off(struct insn *insn, struct pt_regs *regs);
+int insn_get_modrm_reg_off(struct insn *insn, struct pt_regs *regs);
 unsigned long insn_get_seg_base(struct pt_regs *regs, int seg_reg_idx);
 int insn_get_code_seg_params(struct pt_regs *regs);
 int insn_fetch_from_user(struct pt_regs *regs,
diff --git a/arch/x86/lib/insn-eval.c b/arch/x86/lib/insn-eval.c
index f52046f90dd3..a8ac5c5e94f0 100644
--- a/arch/x86/lib/insn-eval.c
+++ b/arch/x86/lib/insn-eval.c
@@ -20,6 +20,7 @@
 
 enum reg_type {
 	REG_TYPE_RM = 0,
+	REG_TYPE_REG,
 	REG_TYPE_INDEX,
 	REG_TYPE_BASE,
 };
@@ -441,6 +442,13 @@ static int get_reg_offset(struct insn *insn, struct pt_regs *regs,
 			regno += 8;
 		break;
 
+	case REG_TYPE_REG:
+		regno = X86_MODRM_REG(insn->modrm.value);
+
+		if (X86_REX_R(insn->rex_prefix.value))
+			regno += 8;
+		break;
+
 	case REG_TYPE_INDEX:
 		regno = X86_SIB_INDEX(insn->sib.value);
 		if (X86_REX_X(insn->rex_prefix.value))
@@ -809,6 +817,21 @@ int insn_get_modrm_rm_off(struct insn *insn, struct pt_regs *regs)
 	return get_reg_offset(insn, regs, REG_TYPE_RM);
 }
 
+/**
+ * insn_get_modrm_reg_off() - Obtain register in reg part of the ModRM byte
+ * @insn:	Instruction containing the ModRM byte
+ * @regs:	Register values as seen when entering kernel mode
+ *
+ * Returns:
+ *
+ * The register indicated by the reg part of the ModRM byte. The
+ * register is obtained as an offset from the base of pt_regs.
+ */
+int insn_get_modrm_reg_off(struct insn *insn, struct pt_regs *regs)
+{
+	return get_reg_offset(insn, regs, REG_TYPE_REG);
+}
+
 /**
  * get_seg_base_limit() - obtain base address and limit of a segment
  * @insn:	Instruction. Must be valid.
-- 
2.27.0
