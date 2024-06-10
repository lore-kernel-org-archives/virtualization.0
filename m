Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAC2D84E1F
	for <virtualization@lists.linux-foundation.org>; Mon, 10 Jun 2024 10:21:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718014910; cv=none; b=cfKq39qL3eUWD7ZRCBGMmEg904UURE7VM4nPznzU8/fqGZJdqTj/RODVnoDw/d+T1BuUh5MZEyPItzmrElyg/hEJUffs+DIbkPVJ+FrHNcHNrbtOma+BIwuu21eyULoiMuKzc+W8TaMWNWm2sckGodjiSTlirNv+FGBWNA3Xmxg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718014910; c=relaxed/simple;
	bh=RIX6F02RU57kcYISt2QqN6Kv/cJq5+UN3QzaEDCLbYU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=pBqp7saEXKtKLVtRTN/0FFDxzttels0LCLfp4npQVmwKLtJq+vp+ybXcrI2ui8SfU2nX0VjjVf5asqmdeBJPJqFZnVDwonK64C0l+DceMJlESagElI6aE+25/ZmTTUF1/DE59e046wX06/umY1P9HxZOmpvr7GIoUKMowuKwetU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RancdGrT; arc=none smtp.client-ip=140.211.166.133
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RancdGrT"
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 99D4C40289
	for <virtualization@lists.linux-foundation.org>; Mon, 10 Jun 2024 10:21:47 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -1.849
X-Spam-Level:
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 5YhfAbEMOGfl for <virtualization@lists.linux-foundation.org>;
 Mon, 10 Jun 2024 10:21:46 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2a00:1450:4864:20::62a; helo=mail-ej1-x62a.google.com; envelope-from=vsntk18@gmail.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org 4AC174063D
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=none dis=none) header.from=gmail.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 4AC174063D
Authentication-Results: smtp2.osuosl.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=RancdGrT
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 4AC174063D
	for <virtualization@lists.linux-foundation.org>; Mon, 10 Jun 2024 10:21:46 +0000 (UTC)
Received: by mail-ej1-x62a.google.com with SMTP id a640c23a62f3a-a6ef8bf500dso216995966b.0
        for <virtualization@lists.linux-foundation.org>; Mon, 10 Jun 2024 03:21:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718014904; x=1718619704; darn=lists.linux-foundation.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BdG6ACuG1uJUkfwp3EsaLBLMvj3TgqNuoQIAGjhnFXs=;
        b=RancdGrTZxoo3DOylJB7FnA6oCC9e+dRHzwYP3bEcrD+BOW0L9UOAK5RQoEI6AI+iF
         AZu6/CS//TeQA6hy34Jy8NAvWisx+xnUVMqqABDnUxecag2Y/19LNZ3qymZmlnme6Lzv
         LDGHWsXZUbgmAcp/IhRFbw/kajn8vEyWgaeWIXAdC6Z/4Jq4fMJi3RJq1jsqkfIE8g2c
         DOqiNgjtpMZEXKa+T8I8PGts7xSE0HVuOBNChzlMWKg0TEOFrqU1AKI0frFrRT3fvxi9
         6Lhwn2J2zRyDHvtBCnfHpc+W5ZbKYC61Q51E9S8krmE8d66JDCdRedL+ssis0TAVbxSL
         UTqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718014904; x=1718619704;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BdG6ACuG1uJUkfwp3EsaLBLMvj3TgqNuoQIAGjhnFXs=;
        b=et+1Vn1WOchNX66t+4vb/GTPAi22PK5Yl2Hvh+CICwYsC4onGDQtnxL2Sjv3TfOxQl
         LKA14nJQD98+9sQCryGH2PdI+4X2zTyDuDX8MbeTiVZAjPFxTcyARWRsUwkCQP+yAgSV
         Elu7L+k7pfoH7I3f8aOa08HolvabyRGjevBLvQxQevm1uvCq7PYvdrokpQrWwdhQ+m3N
         YjP7ephGoHd477nfMWRyPcJjwUdsoXmKJRffeE5HFT7fmMyw22erVDYgebOW2rtq5zhP
         lA9LD8T3AttW6Z/azVvQ7kKFRP+G5cXxD21VilTSvuIGlh+kgIcyL0bXMjdIz6F+O0IO
         90Xg==
X-Forwarded-Encrypted: i=1; AJvYcCVhd+BEj8MEpmmIN5Yyqd1bn3tk+QpBrRN7GdJMHgzQBDQTcnsGzq3v5351i5Fhxt6p/RAIQPoJrlwb0AWIXknIenBZMv/pKVFT1ol9A4R/nMT8cdtB65rhuw==
X-Gm-Message-State: AOJu0YxOS2ab9p1umCx5bF6dafGSEmdhllQhNkOi3wsy1RvNxAenw8Xl
	3lqBQPrFwgcxsAr4WY8JcVdUPe+QjAhzSLWNTzh1tXT5vvY/ImBB
X-Google-Smtp-Source: AGHT+IG+5xSdjmTwqQbKCwcV+YEwd87sFYBvU+bVS0NNITGRecW7wGay6Ao5a2CebEX1GwPUmPMrcw==
X-Received: by 2002:a17:907:9486:b0:a6f:1798:bf80 with SMTP id a640c23a62f3a-a6f1798bfabmr270645066b.52.1718014904098;
        Mon, 10 Jun 2024 03:21:44 -0700 (PDT)
Received: from vasant-suse.fritz.box ([2001:9e8:ab68:af00:6f43:17ee:43bd:e0a9])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a6f0d7b35d5sm290887766b.192.2024.06.10.03.21.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Jun 2024 03:21:43 -0700 (PDT)
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
Subject: [PATCH v6 10/10] x86/sev: Exclude AP jump table related code for SEV-SNP guests
Date: Mon, 10 Jun 2024 12:21:13 +0200
Message-Id: <20240610102113.20969-11-vsntk18@gmail.com>
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

From: Vasant Karasulli <vkarasulli@suse.de>

Unlike SEV-ES, AP jump table technique is not used in SEV-SNP
when transitioning from one layer of code to another
(e.g. when going from UEFI to the OS).

Signed-off-by: Vasant Karasulli <vkarasulli@suse.de>
---
 arch/x86/kernel/sev.c    | 6 +++++-
 arch/x86/realmode/init.c | 5 +++--
 2 files changed, 8 insertions(+), 3 deletions(-)

diff --git a/arch/x86/kernel/sev.c b/arch/x86/kernel/sev.c
index e64320507da2..a9cf74512269 100644
--- a/arch/x86/kernel/sev.c
+++ b/arch/x86/kernel/sev.c
@@ -1392,7 +1392,8 @@ STACK_FRAME_NON_STANDARD(sev_jumptable_ap_park);
 void sev_es_stop_this_cpu(void)
 {
 	if (!(cc_vendor == CC_VENDOR_AMD) ||
-	    !cc_platform_has(CC_ATTR_GUEST_STATE_ENCRYPT))
+	    !cc_platform_has(CC_ATTR_GUEST_STATE_ENCRYPT) ||
+	     cc_platform_has(CC_ATTR_GUEST_SEV_SNP))
 		return;
 
 	/* Only park in the AP jump table when the code has been installed */
@@ -1468,6 +1469,9 @@ bool sev_kexec_supported(void)
 	if (!cc_platform_has(CC_ATTR_GUEST_STATE_ENCRYPT))
 		return true;
 
+	if (cc_platform_has(CC_ATTR_GUEST_SEV_SNP))
+		return false;
+
 	/*
 	 * KEXEC with SEV-ES and more than one CPU is only supported
 	 * when the AP jump table is installed.
diff --git a/arch/x86/realmode/init.c b/arch/x86/realmode/init.c
index f9bc444a3064..ed798939be5d 100644
--- a/arch/x86/realmode/init.c
+++ b/arch/x86/realmode/init.c
@@ -80,8 +80,9 @@ static void __init sme_sev_setup_real_mode(struct trampoline_header *th)
 		 */
 		th->start = (u64) secondary_startup_64_no_verify;
 
-		if (sev_es_setup_ap_jump_table(real_mode_header))
-			panic("Failed to get/update SEV-ES AP Jump Table");
+		if (!cc_platform_has(CC_ATTR_GUEST_SEV_SNP))
+			if (sev_es_setup_ap_jump_table(real_mode_header))
+				panic("Failed to get/update SEV-ES AP Jump Table");
 	}
 #endif
 }
-- 
2.34.1

