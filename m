Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6928629CEF
	for <virtualization@lists.linux-foundation.org>; Mon,  8 Apr 2024 07:41:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712562082; cv=none; b=BMShuw+cspV6NwwjosTB2SEmDoBQxDVVBbS7VjELgYK6dKOK0Y9tO4/Q4kNo9k8cwYq7CmARazHWRiZzTaAS3wN/iye2gClkrmS3OA98gt25C++iG0WIMiGdUbdgbr+lP9NEcMHLfQ7DR3vYDS2hQiE+p8HVwkp543djrORlxXw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712562082; c=relaxed/simple;
	bh=HH1sJn4b3V30rPMVBuHlYzoyuDIoo8e0e1oZipDtD1M=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ZY2w3vPYVgkuqiy4rRhdLdcLj0S066NxkYqnG5cL8Xa9SiOPNRVveTN7BIbIj32+PINBTWBhfe7MEvHEJcgPP0i/qr+vDTMDVTY1y0YvJFtE28RUDgT+lCZHRS6yREkZSeVAERg270lYYZ4nI53ODJO5mrGmxCprlkRH+y6G6DY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iiI06n4H; arc=none smtp.client-ip=140.211.166.136
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iiI06n4H"
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 1454660A77
	for <virtualization@lists.linux-foundation.org>; Mon,  8 Apr 2024 07:41:21 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -1.849
X-Spam-Level:
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id kImCl9w8sL4m for <virtualization@lists.linux-foundation.org>;
 Mon,  8 Apr 2024 07:41:20 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2a00:1450:4864:20::131; helo=mail-lf1-x131.google.com; envelope-from=vsntk18@gmail.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org 20A2160A53
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=none dis=none) header.from=gmail.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 20A2160A53
Authentication-Results: smtp3.osuosl.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=iiI06n4H
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 20A2160A53
	for <virtualization@lists.linux-foundation.org>; Mon,  8 Apr 2024 07:41:20 +0000 (UTC)
Received: by mail-lf1-x131.google.com with SMTP id 2adb3069b0e04-516cbf3fd3dso4735157e87.2
        for <virtualization@lists.linux-foundation.org>; Mon, 08 Apr 2024 00:41:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712562078; x=1713166878; darn=lists.linux-foundation.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AJPEklCzoS2DFb7f9ZXxyBC3nyK2AChPfFAIeZ8KZAI=;
        b=iiI06n4HVMMxp1R/kHYZb49cxfPHQATiehQc02/HGlYdno62WISRbsyYBChS7MbjMe
         WXVcyGOUIfj6ofg36bmbnZDXNjIDLHOebQwaMXH2I3o7YmzAcq53iJrJYFF+U08l1iqZ
         dtv+s/GH8JMIJJXt8264sHKUKS8dLD73KFcMpH89f9D4YtUYCMC/Um8IW4aKotwFjxjn
         kLhp/PScVX3tmEEElGoGAkXW8kFDRWVT/FwKfsAXVcZL6xUgSbMGil/wmVvvJApf+G+L
         1gkyTED/rBe8Y/lHVvxaRcw9qXM3yiMipYVZu6ojYyu8e+XkhPeqIocSwu4bNHamKXpO
         Cojw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712562078; x=1713166878;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AJPEklCzoS2DFb7f9ZXxyBC3nyK2AChPfFAIeZ8KZAI=;
        b=Mf/E2FVkXfyQBeqJ+hxkJWkZefaYwPTqObBElUjwkk31/4oXkHhJM7qyOcmHl1Gzia
         XU2cJT6UvzjAoaBsI8DohbiK8mgKdi5G7sl6ps1ApMWxeppS5fIMb6Z44oO8Gyy+L7RF
         JFvTBtSfk9tRTxcocdFKhP09dQVAF2MIW4ODfD2uVbGFY7oTfrqaJIdZATEpdf7NvGAd
         id4bzVN2W6sbKMRgJ0J57Ljr2+OVb5gjVD9t9NcKGfEIN59R/iM+Gvux6b0+gXt5HeYb
         c6b7O5eIMOaRF5+CwFSHfvFWPQMmW9QTairodQvl2w//AsSPzEiYKWyskL+GIYUb3gux
         xWvg==
X-Forwarded-Encrypted: i=1; AJvYcCVwoaAyW0iS5+tfPNK44N25JQyk/ecIo//Mudd5j9/op+I7uwRsBFuiYQ7+ofMj9Mk34h4tUz42E04Tn+3IpTONw0EDgnFyJVl0w7JggHJnem2uk2IvedIV7g==
X-Gm-Message-State: AOJu0YwBna8qYF3gGDONbcjIfO5dE7ZMhnP2qHSOIezcjQc178ccKuGc
	ac5E3KLlzf2522TCV1lyKJPXDwp+7lZo/BU5+njP153FIU492Cit
X-Google-Smtp-Source: AGHT+IHpElUIChuykMsasXSoM3TJVl6Wfcb1bXJa6Q9tVjHiJv6DKDaFlFEqFX6ZTMlgVGGqgWRrag==
X-Received: by 2002:a05:6512:3618:b0:513:d5ea:1d21 with SMTP id f24-20020a056512361800b00513d5ea1d21mr5855791lfs.69.1712562077693;
        Mon, 08 Apr 2024 00:41:17 -0700 (PDT)
Received: from vasant-suse.suse.cz ([2001:9e8:ab70:9c00:7f0b:c18e:56a6:4f2])
        by smtp.gmail.com with ESMTPSA id j3-20020adfff83000000b00341e2146b53sm8271413wrr.106.2024.04.08.00.41.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Apr 2024 00:41:16 -0700 (PDT)
From: vsntk18@gmail.com
To: x86@kernel.org
Cc: cfir@google.com,
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
	mstunes@vmware.com,
	nivedita@alum.mit.edu,
	peterz@infradead.org,
	rientjes@google.com,
	seanjc@google.com,
	stable@vger.kernel.org,
	thomas.lendacky@amd.com,
	virtualization@lists.linux-foundation.org,
	vkarasulli@suse.de,
	ashish.kalra@amd.com,
	michael.roth@amd.com,
	Borislav.Petkov@amd.com,
	Dhaval.Giani@amd.com
Subject: [PATCH v5 08/10] x86/sev: Handle CLFLUSH MMIO events
Date: Mon,  8 Apr 2024 09:40:47 +0200
Message-Id: <20240408074049.7049-9-vsntk18@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240408074049.7049-1-vsntk18@gmail.com>
References: <20240408074049.7049-1-vsntk18@gmail.com>
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
index d769f80d0264..1bffc2205480 100644
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

