From: Joerg Roedel <joro@8bytes.org>
Subject: [PATCH v3 09/75] x86/insn: Add insn_get_modrm_reg_off()
Date: Tue, 28 Apr 2020 17:16:19 +0200
Message-ID: <20200428151725.31091-10-joro@8bytes.org>
References: <20200428151725.31091-1-joro@8bytes.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20200428151725.31091-1-joro@8bytes.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
 <mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
 <mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>
To: x86@kernel.org
Cc: Juergen Gross <jgross@suse.com>, Tom Lendacky <thomas.lendacky@amd.com>, Thomas Hellstrom <thellstrom@vmware.com>, Joerg Roedel <jroedel@suse.de>, Mike Stunes <mstunes@vmware.com>, Kees Cook <keescook@chromium.org>, kvm@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>, Cfir Cohen <cfir@google.com>, Joerg Roedel <joro@8bytes.org>, Dave Hansen <dave.hansen@linux.intel.com>, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, Masami Hiramatsu <mhiramat@kernel.org>, Andy Lutomirski <luto@kernel.org>, hpa@zytor.com, Erdem Aktas <erdemaktas@google.com>, David Rientjes <rientjes@google.com>, Dan Williams <dan.j.williams@intel.com>, Jiri Slaby <jslaby@suse.cz>
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
index b4ff3e3316d1..1e343010129e 100644
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
index 0bbb814d4851..371da15f1343 100644
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
2.17.1
