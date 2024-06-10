Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D322A80BE5
	for <virtualization@lists.linux-foundation.org>; Mon, 10 Jun 2024 10:21:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.137
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718014905; cv=none; b=lPV18pJ5k8dqsd3twu2i8Vx0Jnefw1rVN4Y3kUxSuxLkDwpu15O4FczBzrCz3tMEvXnFFf2OJpxX6b76e12cS3O0B0eu4lJDxuySZs1khcDzhFe1nIX/xvvAs3lOq1w0wAfdyUbF71PEnYC1Xxv19io+M6Yf2IfK5NVH9pAkbsg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718014905; c=relaxed/simple;
	bh=n/Kr224Se4bnUgaKv7FxbMglodNlFAhVuU9INti7pAw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=jr9Ina9+mPIb8ZtufhB7KFbhPiUNeR4sX9LFqBRRjh5ByP8F8guVTziN4k5csMPRfP+qYj12CJd6KiYe8JyqOubWJig/BW9gJVbSU/5azX2oPy79S31jppqMxIUJ5AJRwicROfx730kwdys0pZubtqPTXFxFdnqbck60+lSMlx4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LcDA8Rzz; arc=none smtp.client-ip=140.211.166.137
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LcDA8Rzz"
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 818B340693
	for <virtualization@lists.linux-foundation.org>; Mon, 10 Jun 2024 10:21:43 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -1.849
X-Spam-Level:
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id wDRzIT04TroU for <virtualization@lists.linux-foundation.org>;
 Mon, 10 Jun 2024 10:21:42 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2a00:1450:4864:20::62f; helo=mail-ej1-x62f.google.com; envelope-from=vsntk18@gmail.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org 641524067D
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=none dis=none) header.from=gmail.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 641524067D
Authentication-Results: smtp4.osuosl.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=LcDA8Rzz
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 641524067D
	for <virtualization@lists.linux-foundation.org>; Mon, 10 Jun 2024 10:21:42 +0000 (UTC)
Received: by mail-ej1-x62f.google.com with SMTP id a640c23a62f3a-a6ef46d25efso295167766b.0
        for <virtualization@lists.linux-foundation.org>; Mon, 10 Jun 2024 03:21:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718014900; x=1718619700; darn=lists.linux-foundation.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1h9f1jusJiCVXI0HUFRIPuyM0FJ2eMb2RD0DEq0ZSug=;
        b=LcDA8RzzFUi1d7M9wBeQQmd61BlJ8X7BiQ2TQhPV20WVdu4nC9tsQN5U8KCjgFaCbV
         SP05PLvrBu7TvjhGH3Nk110f2sew4Wa9yOHB6MquJHBggYxOJnS2eDTF01+zrxyoxGpv
         smu2DMWuvMP8U7AjvQ87SduHs8dwtnyHMHtubTjUhvb8iKL4ervhf/fS15PYCC9b6RBC
         YtAGaaV4m5FXHdVUX/Q+nGiuZuJM9C5DtdzgW7+NH8+cyUauS6SVN9CvX3ce+DnIrQKW
         /a8+HkOLeuHC7BIzzdH+iTd+4Mwr1hBsRpOKlGirTca3cEbl2mwF0JcNxbpGjae4xDUy
         SFeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718014900; x=1718619700;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1h9f1jusJiCVXI0HUFRIPuyM0FJ2eMb2RD0DEq0ZSug=;
        b=jcenIx+bPSrbK0XPWVd0IzFYTkB9OxOqiY6GBEiBqLSUxeGYVq31YCJ4xnJZjbYEb1
         /adPV4YAyCP8Zo9Sg7PdfEOAW77J8TwKK4+Dlrcz0xIXHQ1VMaWJDjf6ugH4dfsusZvT
         VaoacadtCo0jgw91Kho+dKC21cGgpp6H6+rCDMzfj2vJb6pf94IS0s7zDmU2mGwdyI4P
         g7bBeppR3vdl522yGSfmG15EuvCVjVtf55VtPwPZQ5V6/jlBjd4WO200n3HTTPaB3Li9
         IhfG07s3x/1LGnhTNBMYmavV7NtnMUs/B9mYoqApzvemt6C9BEmC/Q/XhEM4xLcKGbth
         VAUQ==
X-Forwarded-Encrypted: i=1; AJvYcCWCKAQAk82sJvmk7QetU67KJHNB0rEEaVCrgyp9nknEZd54v2fg5wTrQu4qTImjf3Zadcleyjzi753+of8MeJkVYNEF30n/NWjueVACCn8QrOUmnfR+rU4Y3g==
X-Gm-Message-State: AOJu0YwJi878+0A5OxJc9iUNOcLjddifuwCTJTI+Cr3VYjQkh95ZBZUk
	JJfuprvl2oKQYwSipqbUcHeI3Dc9ZlVhN269WknXr93ijTuP1K8B
X-Google-Smtp-Source: AGHT+IFJiw9+hjS8AaCE8xUhReVnHEw0PrrFH9cPzv9TZmB9phDv2ggpsMiBf14CXAFGLO+4Z9OVRQ==
X-Received: by 2002:a17:906:fe07:b0:a6d:b66f:7b21 with SMTP id a640c23a62f3a-a6db66f7e7emr709355566b.54.1718014899942;
        Mon, 10 Jun 2024 03:21:39 -0700 (PDT)
Received: from vasant-suse.fritz.box ([2001:9e8:ab68:af00:6f43:17ee:43bd:e0a9])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a6f0d7b35d5sm290887766b.192.2024.06.10.03.21.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Jun 2024 03:21:39 -0700 (PDT)
From: vsntk18@gmail.com
To: vsntk18@gmail.com
Cc: x86@kernel.org,
	Borislav.Petkov@amd.com,
	Dhaval.Giani@amd.com,
	ashish.kalra@amd.com,
	cfir@google.com,
	dan.j.williams@intel.com,
	dave.hansen@linux.intel.com,
	ebiederm@xmission.com,
	erdemaktas@google.com,
	hpa@zytor.com,
	jgross@suse.com,
	jroedel@suse.de,
	jslaby@suse.cz,
	keescook@chromium.org,
	kexec@lists.infradead.org,
	kvm@vger.kernel.org,
	linux-coco@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	luto@kernel.org,
	martin.b.radev@gmail.com,
	mhiramat@kernel.org,
	michael.roth@amd.com,
	mstunes@vmware.com,
	nivedita@alum.mit.edu,
	peterz@infradead.org,
	rientjes@google.com,
	seanjc@google.com,
	stable@vger.kernel.org,
	thomas.lendacky@amd.com,
	virtualization@lists.linux-foundation.org,
	vkarasulli@suse.de
Subject: [PATCH v6 08/10] x86/sev: Handle CLFLUSH MMIO events
Date: Mon, 10 Jun 2024 12:21:11 +0200
Message-Id: <20240610102113.20969-9-vsntk18@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240610102113.20969-1-vsntk18@gmail.com>
References: <20240610102113.20969-1-vsntk18@gmail.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Joerg Roedel <jroedel@suse.de>

Handle CLFLUSH instruction to MMIO memory in the #VC handler. The
instruction is ignored by the handler, as the Hypervisor is
responsible for cache management of emulated MMIO memory.

Signed-off-by: Joerg Roedel <jroedel@suse.de>
Signed-off-by: Vasant Karasulli <vkarasulli@suse.de>
---
 arch/x86/include/asm/insn-eval.h | 1 +
 arch/x86/kernel/sev-shared.c     | 3 +++
 arch/x86/lib/insn-eval-shared.c  | 7 +++++++
 3 files changed, 11 insertions(+)

diff --git a/arch/x86/include/asm/insn-eval.h b/arch/x86/include/asm/insn-eval.h
index 54368a43abf6..3bcea641913a 100644
--- a/arch/x86/include/asm/insn-eval.h
+++ b/arch/x86/include/asm/insn-eval.h
@@ -40,6 +40,7 @@ enum insn_mmio_type {
 	INSN_MMIO_READ_ZERO_EXTEND,
 	INSN_MMIO_READ_SIGN_EXTEND,
 	INSN_MMIO_MOVS,
+	INSN_MMIO_IGNORE,
 };
 
 enum insn_mmio_type insn_decode_mmio(struct insn *insn, int *bytes);
diff --git a/arch/x86/kernel/sev-shared.c b/arch/x86/kernel/sev-shared.c
index 1b25a6cacec7..2a963ad84f10 100644
--- a/arch/x86/kernel/sev-shared.c
+++ b/arch/x86/kernel/sev-shared.c
@@ -1171,6 +1171,9 @@ static enum es_result vc_handle_mmio(struct ghcb *ghcb, struct es_em_ctxt *ctxt)
 	if (mmio == INSN_MMIO_DECODE_FAILED)
 		return ES_DECODE_FAILED;
 
+	if (mmio == INSN_MMIO_IGNORE)
+		return ES_OK;
+
 	if (mmio != INSN_MMIO_WRITE_IMM && mmio != INSN_MMIO_MOVS) {
 		reg_data = insn_get_modrm_reg_ptr(insn, ctxt->regs);
 		if (!reg_data)
diff --git a/arch/x86/lib/insn-eval-shared.c b/arch/x86/lib/insn-eval-shared.c
index 02acdc2921ff..27fd347d84ae 100644
--- a/arch/x86/lib/insn-eval-shared.c
+++ b/arch/x86/lib/insn-eval-shared.c
@@ -906,6 +906,13 @@ enum insn_mmio_type insn_decode_mmio(struct insn *insn, int *bytes)
 				*bytes = 2;
 			type = INSN_MMIO_READ_SIGN_EXTEND;
 			break;
+		case 0xae: /* CLFLUSH */
+			/*
+			 * Ignore CLFLUSHes - those go to emulated MMIO anyway and the
+			 * hypervisor is responsible for cache management.
+			 */
+			type = INSN_MMIO_IGNORE;
+			break;
 		}
 		break;
 	}
-- 
2.34.1

