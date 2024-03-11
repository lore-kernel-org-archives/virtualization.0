Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3B0F56B91
	for <virtualization@lists.linux-foundation.org>; Mon, 11 Mar 2024 16:17:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710173869; cv=none; b=uty3X/jgfjhGcSP6PDHkh4mw2iW5Bq//UOn0bKiUH4yTaLTSvpC66dDLLZOuehQziIM3PvA7m1LZOaGBOfykulA8MNfi98MC3AQVFPxp5k2Obcx5NOgbD75yCTmCp/o9C/0d42SS39o9AIpkOp4nHLsHm9WNF9JiRO6J08/KNHQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710173869; c=relaxed/simple;
	bh=llvDKlG/ax7CEpz4qGsKLKsgPZfmj8Qxs/13kcLEhp8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=C+hQcWmm/f0Be5/chk+Qf/urLLErQxetzk5VY5UBIfiCu4nEMj0MxbxGNiC5RsI1gJE/OaKKvm4AquUFdEVagXhyCzEQbGeOS/GJojbkFOjcaCSryBTRDWCvaGQ34oVtz5+r0WEFerVET4XNVLNyfKbAPJLDQ0dnsHaQMRJ6F5s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Q/2edm79; arc=none smtp.client-ip=140.211.166.133
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q/2edm79"
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 7FF9540AFB
	for <virtualization@lists.linux-foundation.org>; Mon, 11 Mar 2024 16:17:47 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -1.849
X-Spam-Level:
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id BPztva-c9iRN
	for <virtualization@lists.linux-foundation.org>;
	Mon, 11 Mar 2024 16:17:47 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2a00:1450:4864:20::334; helo=mail-wm1-x334.google.com; envelope-from=vsntk18@gmail.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org 9125C40ACF
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=none dis=none) header.from=gmail.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 9125C40ACF
Authentication-Results: smtp2.osuosl.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=Q/2edm79
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 9125C40ACF
	for <virtualization@lists.linux-foundation.org>; Mon, 11 Mar 2024 16:17:46 +0000 (UTC)
Received: by mail-wm1-x334.google.com with SMTP id 5b1f17b1804b1-4133027fa88so2566105e9.1
        for <virtualization@lists.linux-foundation.org>; Mon, 11 Mar 2024 09:17:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710173864; x=1710778664; darn=lists.linux-foundation.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VD+5e2rjcMTAqm1lLiHG9HKUMBAWFA80T0od8hhMD6s=;
        b=Q/2edm79GgRZrPrFE3WT5NQkXxP/vc98ROF1YR2Ub1PA7SF3bLzm7JMj3U7fOa+/CB
         bz8j7GSTZQtK018jVAH96bjb2y3uAzhs1fnrLNDZ2fknAF2dvNTIJVM7PlXDTagBzclj
         jxKqreVsFwfLDCSA/RTSBcP0eO1zH361L8kKt6igg+ggshBGTorcScQAU2/mlEmN06KX
         U4lAbOmRLZAVwAQUmD6XlSDIOGVT8G6OIn5pqH2tKc/WA5xa02ycARr7qOyD2IQrJ3QH
         O06UknCK4OCGA+fjvSUhuMjzN4E1ycRuYCyUjJ9owHDDnGZvwZ7giFr+BCB/hdVgnJlV
         9xJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710173864; x=1710778664;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VD+5e2rjcMTAqm1lLiHG9HKUMBAWFA80T0od8hhMD6s=;
        b=hR8QgFxR9+FP9UGCM4fPJSNeEu0s5rEAOO6vN/v1ruheVBrNl08nxO0eEI45R7jRpg
         n3ZKXNH+uPNbVay3BhPCFwyD4gy1Aob/unLEPoaDz762cl86k/lAEYHEdHfPwt0dBAAU
         aaJw7lirbU/5O9FwSvg46zCPsn6jTLTy/QH9U9jI4qw04r/lOI31+M7wEvvn6g9YDImu
         cwRAhVTQkaWAHjIdIL3wMw8LO2ZwGkVQ8dhtdAOY1cN52UX2V+BbatF9vHu9GRL/tFAX
         dhT8EcxkfBNBwnOVBsZffZUecNumBS2kh26pT/2vwcdFKYCHSqJU07IbI0wn3r+kv+nJ
         Abcw==
X-Forwarded-Encrypted: i=1; AJvYcCVKN2wS01hR9nAiESTlyYKr97PKnofljlAetAaV71+NWwiDtZd0M+BGLHbJurSIXyE3e7TmApWczq+L4AfuZvxVPXd/prtzXBClVO+IQ3Tcep4pzYbr4FD/lQ==
X-Gm-Message-State: AOJu0Yz6YoEI1VOnl+/WVAmT1hn4X5EApy6MGe/3xiNwE8G8FeumLYyC
	KIOPMoEMR1iJLOPC1hCrMIEpD1DZ+wzq2s8RK27SzdrGEP0Dg2lN
X-Google-Smtp-Source: AGHT+IHYTDHzYrXzvp4OecC7PPYjSNE0zn/Q41wyIcFJBRWeQZQzaCiAotWHf7DRRVcFdGjRxY3S1Q==
X-Received: by 2002:a05:6000:cd2:b0:33e:82b9:5cc7 with SMTP id dq18-20020a0560000cd200b0033e82b95cc7mr603908wrb.6.1710173864253;
        Mon, 11 Mar 2024 09:17:44 -0700 (PDT)
Received: from vasant-suse.suse.cz ([2001:9e8:ab47:8200:c3b9:43af:f8e1:76f9])
        by smtp.gmail.com with ESMTPSA id ba14-20020a0560001c0e00b0033e96fe9479sm2823815wrb.89.2024.03.11.09.17.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Mar 2024 09:17:43 -0700 (PDT)
From: Vasant Karasulli <vsntk18@gmail.com>
To: x86@kernel.org
Cc: joro@8bytes.org,
	cfir@google.com,
	dan.j.williams@intel.com,
	dave.hansen@linux.intel.com,
	ebiederm@xmission.com,
	erdemaktas@google.com,
	hpa@zytor.com,
	jgross@suse.com,
	jslaby@suse.cz,
	keescook@chromium.org,
	kexec@lists.infradead.org,
	kvm@vger.kernel.org,
	linux-coco@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	luto@kernel.org,
	martin.b.radev@gmail.com,
	mhiramat@kernel.org,
	mstunes@vmware.com,
	nivedita@alum.mit.edu,
	peterz@infradead.org,
	rientjes@google.com,
	seanjc@google.com,
	stable@vger.kernel.org,
	thomas.lendacky@amd.com,
	virtualization@lists.linux-foundation.org,
	Joerg Roedel <jroedel@suse.de>,
	Vasant Karasulli <vkarasulli@suse.de>
Subject: [PATCH v4 8/9] x86/sev: Handle CLFLUSH MMIO events
Date: Mon, 11 Mar 2024 17:17:26 +0100
Message-Id: <20240311161727.14916-9-vsntk18@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240311161727.14916-1-vsntk18@gmail.com>
References: <20240311161727.14916-1-vsntk18@gmail.com>
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
index e9a959c1c11d..ac0704055d58 100644
--- a/arch/x86/kernel/sev-shared.c
+++ b/arch/x86/kernel/sev-shared.c
@@ -1164,6 +1164,9 @@ static enum es_result vc_handle_mmio(struct ghcb *ghcb, struct es_em_ctxt *ctxt)
 	if (mmio == INSN_MMIO_DECODE_FAILED)
 		return ES_DECODE_FAILED;

+	if (mmio == INSN_MMIO_IGNORE)
+		return ES_OK;
+
 	if (mmio != INSN_MMIO_WRITE_IMM && mmio != INSN_MMIO_MOVS) {
 		reg_data = insn_get_modrm_reg_ptr(insn, ctxt->regs);
 		if (!reg_data)
diff --git a/arch/x86/lib/insn-eval-shared.c b/arch/x86/lib/insn-eval-shared.c
index efc9755573db..3d71a947e562 100644
--- a/arch/x86/lib/insn-eval-shared.c
+++ b/arch/x86/lib/insn-eval-shared.c
@@ -897,6 +897,13 @@ enum insn_mmio_type insn_decode_mmio(struct insn *insn, int *bytes)
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

