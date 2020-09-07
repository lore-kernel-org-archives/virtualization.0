Return-Path: <SRS0=oNZg=CQ=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3482C2D0A7
	for <virtualization@archiver.kernel.org>; Mon,  7 Sep 2020 13:17:13 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 891EF20838
	for <virtualization@archiver.kernel.org>; Mon,  7 Sep 2020 13:17:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 891EF20838
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=8bytes.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id 4060C867C5;
	Mon,  7 Sep 2020 13:17:13 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id SbJbd5bYy9xd; Mon,  7 Sep 2020 13:17:07 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id 23C55867C6;
	Mon,  7 Sep 2020 13:17:03 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 06BE9C0895;
	Mon,  7 Sep 2020 13:17:03 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 5A088C0051
 for <virtualization@lists.linux-foundation.org>;
 Mon,  7 Sep 2020 13:17:02 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id 41CFA226FC
 for <virtualization@lists.linux-foundation.org>;
 Mon,  7 Sep 2020 13:17:02 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id BfFXj4NH6HFV
 for <virtualization@lists.linux-foundation.org>;
 Mon,  7 Sep 2020 13:16:52 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from theia.8bytes.org (8bytes.org [81.169.241.247])
 by silver.osuosl.org (Postfix) with ESMTPS id 6553920500
 for <virtualization@lists.linux-foundation.org>;
 Mon,  7 Sep 2020 13:16:49 +0000 (UTC)
Received: from cap.home.8bytes.org (p549add56.dip0.t-ipconnect.de
 [84.154.221.86])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by theia.8bytes.org (Postfix) with ESMTPSA id B8D8AC1C;
 Mon,  7 Sep 2020 15:16:45 +0200 (CEST)
From: Joerg Roedel <joro@8bytes.org>
To: x86@kernel.org
Subject: [PATCH v7 07/72] x86/insn: Make inat-tables.c suitable for
 pre-decompression code
Date: Mon,  7 Sep 2020 15:15:08 +0200
Message-Id: <20200907131613.12703-8-joro@8bytes.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200907131613.12703-1-joro@8bytes.org>
References: <20200907131613.12703-1-joro@8bytes.org>
MIME-Version: 1.0
Cc: Juergen Gross <jgross@suse.com>, Tom Lendacky <thomas.lendacky@amd.com>,
 Joerg Roedel <jroedel@suse.de>, Mike Stunes <mstunes@vmware.com>,
 Kees Cook <keescook@chromium.org>, kvm@vger.kernel.org,
 Peter Zijlstra <peterz@infradead.org>, Cfir Cohen <cfir@google.com>,
 Joerg Roedel <joro@8bytes.org>, Dave Hansen <dave.hansen@linux.intel.com>,
 linux-kernel@vger.kernel.org,
 Sean Christopherson <sean.j.christopherson@intel.com>,
 virtualization@lists.linux-foundation.org,
 Martin Radev <martin.b.radev@gmail.com>,
 Masami Hiramatsu <mhiramat@kernel.org>, Andy Lutomirski <luto@kernel.org>,
 hpa@zytor.com, Erdem Aktas <erdemaktas@google.com>,
 David Rientjes <rientjes@google.com>, Dan Williams <dan.j.williams@intel.com>,
 Jiri Slaby <jslaby@suse.cz>
X-BeenThere: virtualization@lists.linux-foundation.org
X-Mailman-Version: 2.1.15
Precedence: list
List-Id: Linux virtualization <virtualization.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>, 
 <mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>, 
 <mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

From: Joerg Roedel <jroedel@suse.de>

The inat-tables.c file has some arrays in it that contain pointers to
other arrays. These pointers need to be relocated when the kernel
image is moved to a different location.

The pre-decompression boot-code has no support for applying ELF
relocations, so initialize these arrays at runtime in the
pre-decompression code to make sure all pointers are correctly
initialized.

Signed-off-by: Joerg Roedel <jroedel@suse.de>
Acked-by: Masami Hiramatsu <mhiramat@kernel.org>
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
2.28.0

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
