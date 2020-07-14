From: Joerg Roedel <joro@8bytes.org>
Subject: [PATCH v4 06/75] x86/insn: Make inat-tables.c suitable for
 pre-decompression code
Date: Tue, 14 Jul 2020 14:08:08 +0200
Message-ID: <20200714120917.11253-7-joro@8bytes.org>
References: <20200714120917.11253-1-joro@8bytes.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20200714120917.11253-1-joro@8bytes.org>
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
Cc: Juergen Gross <jgross@suse.com>, Tom Lendacky <thomas.lendacky@amd.com>, Joerg Roedel <jroedel@suse.de>, Mike Stunes <mstunes@vmware.com>, Kees Cook <keescook@chromium.org>, kvm@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>, Cfir Cohen <cfir@google.com>, Joerg Roedel <joro@8bytes.org>, Dave Hansen <dave.hansen@linux.intel.com>, linux-kernel@vger.kernel.org, Sean Christopherson <sean.j.christopherson@intel.com>, virtualization@lists.linux-foundation.org, Martin Radev <martin.b.radev@gmail.com>, Masami Hiramatsu <mhiramat@kernel.org>, Andy Lutomirski <luto@kernel.org>, hpa@zytor.com, Erdem Aktas <erdemaktas@google.com>, David Rientjes <rientjes@google.com>, Dan Williams <dan.j.williams@intel.com>, Jiri Slaby <jslaby@suse.cz>
List-Id: virtualization@lists.linuxfoundation.org

From: Joerg Roedel <jroedel@suse.de>

The inat-tables.c file has some arrays in it that contain pointers to
other arrays. These pointers need to be relocated when the kernel
image is moved to a different location.

The pre-decompression boot-code has no support for applying ELF
relocations, so initialize these arrays at runtime in the
pre-decompression code to make sure all pointers are correctly
initialized.

Signed-off-by: Joerg Roedel <jroedel@suse.de>
---
 arch/x86/tools/gen-insn-attr-x86.awk       | 50 +++++++++++++++++++++-
 tools/arch/x86/tools/gen-insn-attr-x86.awk | 50 +++++++++++++++++++++-
 2 files changed, 98 insertions(+), 2 deletions(-)

diff --git a/arch/x86/tools/gen-insn-attr-x86.awk b/arch/x86/tools/gen-insn-attr-x86.awk
index a42015b305f4..af38469afd14 100644
--- a/arch/x86/tools/gen-insn-attr-x86.awk
+++ b/arch/x86/tools/gen-insn-attr-x86.awk
@@ -362,6 +362,9 @@ function convert_operands(count,opnd,       i,j,imm,mod)
 END {
 	if (awkchecked != "")
 		exit 1
+
+	print "#ifndef __BOOT_COMPRESSED\n"
+
 	# print escape opcode map's array
 	print "/* Escape opcode map array */"
 	print "const insn_attr_t * const inat_escape_tables[INAT_ESC_MAX + 1]" \
@@ -388,6 +391,51 @@ END {
 		for (j = 0; j < max_lprefix; j++)
 			if (atable[i,j])
 				print "	["i"]["j"] = "atable[i,j]","
-	print "};"
+	print "};\n"
+
+	print "#else /* !__BOOT_COMPRESSED */\n"
+
+	print "/* Escape opcode map array */"
+	print "static const insn_attr_t *inat_escape_tables[INAT_ESC_MAX + 1]" \
+	      "[INAT_LSTPFX_MAX + 1];"
+	print ""
+
+	print "/* Group opcode map array */"
+	print "static const insn_attr_t *inat_group_tables[INAT_GRP_MAX + 1]"\
+	      "[INAT_LSTPFX_MAX + 1];"
+	print ""
+
+	print "/* AVX opcode map array */"
+	print "static const insn_attr_t *inat_avx_tables[X86_VEX_M_MAX + 1]"\
+	      "[INAT_LSTPFX_MAX + 1];"
+	print ""
+
+	print "static void inat_init_tables(void)"
+	print "{"
+
+	# print escape opcode map's array
+	print "\t/* Print Escape opcode map array */"
+	for (i = 0; i < geid; i++)
+		for (j = 0; j < max_lprefix; j++)
+			if (etable[i,j])
+				print "\tinat_escape_tables["i"]["j"] = "etable[i,j]";"
+	print ""
+
+	# print group opcode map's array
+	print "\t/* Print Group opcode map array */"
+	for (i = 0; i < ggid; i++)
+		for (j = 0; j < max_lprefix; j++)
+			if (gtable[i,j])
+				print "\tinat_group_tables["i"]["j"] = "gtable[i,j]";"
+	print ""
+	# print AVX opcode map's array
+	print "\t/* Print AVX opcode map array */"
+	for (i = 0; i < gaid; i++)
+		for (j = 0; j < max_lprefix; j++)
+			if (atable[i,j])
+				print "\tinat_avx_tables["i"]["j"] = "atable[i,j]";"
+
+	print "}"
+	print "#endif"
 }
 
diff --git a/tools/arch/x86/tools/gen-insn-attr-x86.awk b/tools/arch/x86/tools/gen-insn-attr-x86.awk
index a42015b305f4..af38469afd14 100644
--- a/tools/arch/x86/tools/gen-insn-attr-x86.awk
+++ b/tools/arch/x86/tools/gen-insn-attr-x86.awk
@@ -362,6 +362,9 @@ function convert_operands(count,opnd,       i,j,imm,mod)
 END {
 	if (awkchecked != "")
 		exit 1
+
+	print "#ifndef __BOOT_COMPRESSED\n"
+
 	# print escape opcode map's array
 	print "/* Escape opcode map array */"
 	print "const insn_attr_t * const inat_escape_tables[INAT_ESC_MAX + 1]" \
@@ -388,6 +391,51 @@ END {
 		for (j = 0; j < max_lprefix; j++)
 			if (atable[i,j])
 				print "	["i"]["j"] = "atable[i,j]","
-	print "};"
+	print "};\n"
+
+	print "#else /* !__BOOT_COMPRESSED */\n"
+
+	print "/* Escape opcode map array */"
+	print "static const insn_attr_t *inat_escape_tables[INAT_ESC_MAX + 1]" \
+	      "[INAT_LSTPFX_MAX + 1];"
+	print ""
+
+	print "/* Group opcode map array */"
+	print "static const insn_attr_t *inat_group_tables[INAT_GRP_MAX + 1]"\
+	      "[INAT_LSTPFX_MAX + 1];"
+	print ""
+
+	print "/* AVX opcode map array */"
+	print "static const insn_attr_t *inat_avx_tables[X86_VEX_M_MAX + 1]"\
+	      "[INAT_LSTPFX_MAX + 1];"
+	print ""
+
+	print "static void inat_init_tables(void)"
+	print "{"
+
+	# print escape opcode map's array
+	print "\t/* Print Escape opcode map array */"
+	for (i = 0; i < geid; i++)
+		for (j = 0; j < max_lprefix; j++)
+			if (etable[i,j])
+				print "\tinat_escape_tables["i"]["j"] = "etable[i,j]";"
+	print ""
+
+	# print group opcode map's array
+	print "\t/* Print Group opcode map array */"
+	for (i = 0; i < ggid; i++)
+		for (j = 0; j < max_lprefix; j++)
+			if (gtable[i,j])
+				print "\tinat_group_tables["i"]["j"] = "gtable[i,j]";"
+	print ""
+	# print AVX opcode map's array
+	print "\t/* Print AVX opcode map array */"
+	for (i = 0; i < gaid; i++)
+		for (j = 0; j < max_lprefix; j++)
+			if (atable[i,j])
+				print "\tinat_avx_tables["i"]["j"] = "atable[i,j]";"
+
+	print "}"
+	print "#endif"
 }
 
-- 
2.27.0
