Return-Path: <SRS0=nl1Y=CC=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32C57C433E3
	for <virtualization@archiver.kernel.org>; Mon, 24 Aug 2020 08:56:26 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0E8F2204FD
	for <virtualization@archiver.kernel.org>; Mon, 24 Aug 2020 08:56:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0E8F2204FD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=8bytes.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id DFF0E85D7D;
	Mon, 24 Aug 2020 08:56:25 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id MaChSdhO7oyY; Mon, 24 Aug 2020 08:56:24 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 95AEF85F9C;
	Mon, 24 Aug 2020 08:56:23 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 771D1C089E;
	Mon, 24 Aug 2020 08:56:23 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 732A3C0895
 for <virtualization@lists.linux-foundation.org>;
 Mon, 24 Aug 2020 08:56:21 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id 55834204B7
 for <virtualization@lists.linux-foundation.org>;
 Mon, 24 Aug 2020 08:56:21 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id BhDkKs0QqgBQ
 for <virtualization@lists.linux-foundation.org>;
 Mon, 24 Aug 2020 08:56:13 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from theia.8bytes.org (8bytes.org [81.169.241.247])
 by silver.osuosl.org (Postfix) with ESMTPS id 0E92220516
 for <virtualization@lists.linux-foundation.org>;
 Mon, 24 Aug 2020 08:56:05 +0000 (UTC)
Received: from cap.home.8bytes.org (p4ff2bb8d.dip0.t-ipconnect.de
 [79.242.187.141])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by theia.8bytes.org (Postfix) with ESMTPSA id 2F29AE46;
 Mon, 24 Aug 2020 10:56:00 +0200 (CEST)
From: Joerg Roedel <joro@8bytes.org>
To: x86@kernel.org
Subject: [PATCH v6 26/76] x86/fpu: Move xgetbv()/xsetbv() into separate header
Date: Mon, 24 Aug 2020 10:54:21 +0200
Message-Id: <20200824085511.7553-27-joro@8bytes.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200824085511.7553-1-joro@8bytes.org>
References: <20200824085511.7553-1-joro@8bytes.org>
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

The xgetbv() function is needed in pre-decompression boot code, but
asm/fpu/internal.h can't be included there directly. Doing so opens
the door to include-hell due to various include-magic in
boot/compressed/misc.h.

Avoid that by moving xgetbv()/xsetbv() to a separate header file and
include this instead.

Signed-off-by: Joerg Roedel <jroedel@suse.de>
Link: https://lore.kernel.org/r/20200724160336.5435-26-joro@8bytes.org
---
 arch/x86/include/asm/fpu/internal.h | 30 +------------------------
 arch/x86/include/asm/fpu/xcr.h      | 34 +++++++++++++++++++++++++++++
 2 files changed, 35 insertions(+), 29 deletions(-)
 create mode 100644 arch/x86/include/asm/fpu/xcr.h

diff --git a/arch/x86/include/asm/fpu/internal.h b/arch/x86/include/asm/fpu/internal.h
index 21a8b5259477..ceeba9f63172 100644
--- a/arch/x86/include/asm/fpu/internal.h
+++ b/arch/x86/include/asm/fpu/internal.h
@@ -19,6 +19,7 @@
 #include <asm/user.h>
 #include <asm/fpu/api.h>
 #include <asm/fpu/xstate.h>
+#include <asm/fpu/xcr.h>
 #include <asm/cpufeature.h>
 #include <asm/trace/fpu.h>
 
@@ -585,33 +586,4 @@ static inline void switch_fpu_finish(struct fpu *new_fpu)
 	__write_pkru(pkru_val);
 }
 
-/*
- * MXCSR and XCR definitions:
- */
-
-static inline void ldmxcsr(u32 mxcsr)
-{
-	asm volatile("ldmxcsr %0" :: "m" (mxcsr));
-}
-
-extern unsigned int mxcsr_feature_mask;
-
-#define XCR_XFEATURE_ENABLED_MASK	0x00000000
-
-static inline u64 xgetbv(u32 index)
-{
-	u32 eax, edx;
-
-	asm volatile("xgetbv" : "=a" (eax), "=d" (edx) : "c" (index));
-	return eax + ((u64)edx << 32);
-}
-
-static inline void xsetbv(u32 index, u64 value)
-{
-	u32 eax = value;
-	u32 edx = value >> 32;
-
-	asm volatile("xsetbv" :: "a" (eax), "d" (edx), "c" (index));
-}
-
 #endif /* _ASM_X86_FPU_INTERNAL_H */
diff --git a/arch/x86/include/asm/fpu/xcr.h b/arch/x86/include/asm/fpu/xcr.h
new file mode 100644
index 000000000000..1c7ab8d95da5
--- /dev/null
+++ b/arch/x86/include/asm/fpu/xcr.h
@@ -0,0 +1,34 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _ASM_X86_FPU_XCR_H
+#define _ASM_X86_FPU_XCR_H
+
+/*
+ * MXCSR and XCR definitions:
+ */
+
+static inline void ldmxcsr(u32 mxcsr)
+{
+	asm volatile("ldmxcsr %0" :: "m" (mxcsr));
+}
+
+extern unsigned int mxcsr_feature_mask;
+
+#define XCR_XFEATURE_ENABLED_MASK	0x00000000
+
+static inline u64 xgetbv(u32 index)
+{
+	u32 eax, edx;
+
+	asm volatile("xgetbv" : "=a" (eax), "=d" (edx) : "c" (index));
+	return eax + ((u64)edx << 32);
+}
+
+static inline void xsetbv(u32 index, u64 value)
+{
+	u32 eax = value;
+	u32 edx = value >> 32;
+
+	asm volatile("xsetbv" :: "a" (eax), "d" (edx), "c" (index));
+}
+
+#endif /* _ASM_X86_FPU_XCR_H */
-- 
2.28.0

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
