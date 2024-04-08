Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83EA33A8DD
	for <virtualization@lists.linux-foundation.org>; Mon,  8 Apr 2024 07:41:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712562072; cv=none; b=oAmRvXkAKnJft5IrcpX3tKn8PSMF+C1t2zkzyQ9QBrJ+MGyHN7lZchD53Md8H97Z3/i9gU3N3rodl3MDnWidvXseLDnsI2/bo0kWafSPTlNTzVFxPoyLihSX/9F8eCLAP/4zg8Dvo7p1pQMKv1NyyGy3KyoDkwEoe5WQWMOkTaQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712562072; c=relaxed/simple;
	bh=PA9tlwrHq9EaQDOrpwGW0uMmK8o23cX/zpKO//Uv5ZE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=sP3IWLsfQfYYhcFScCCPWAsRM5YIfLGUvSnn8DzOpexUOxYy4+B8Iw0oYQDhv2kh3ANSU559gvp0QupNgPWbt7Y3pI+is8oq0CCDqg/WlBKU3YiZ/h+a1+/nECkJEbZlakMcPQR05CiLoisHoU5pOptvJP2c/tm6CsjoYLK5Cjw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jDnA8Fft; arc=none smtp.client-ip=140.211.166.133
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jDnA8Fft"
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 91E3D4037E
	for <virtualization@lists.linux-foundation.org>; Mon,  8 Apr 2024 07:41:10 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -1.849
X-Spam-Level:
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Yi6cTC0Hdunk for <virtualization@lists.linux-foundation.org>;
 Mon,  8 Apr 2024 07:41:10 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2a00:1450:4864:20::42f; helo=mail-wr1-x42f.google.com; envelope-from=vsntk18@gmail.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org 98916400B8
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=none dis=none) header.from=gmail.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 98916400B8
Authentication-Results: smtp2.osuosl.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=jDnA8Fft
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 98916400B8
	for <virtualization@lists.linux-foundation.org>; Mon,  8 Apr 2024 07:41:09 +0000 (UTC)
Received: by mail-wr1-x42f.google.com with SMTP id ffacd0b85a97d-343cfe8cae1so2538622f8f.3
        for <virtualization@lists.linux-foundation.org>; Mon, 08 Apr 2024 00:41:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712562067; x=1713166867; darn=lists.linux-foundation.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1lm8IoXJe0WYSRwtdxW3X+Cv5dkEchtxnhEW0S0YWJc=;
        b=jDnA8Fft6S6QGipSSMAxnuws0D6E5kglFPpmhbbgkI50GXQrK01Xvh8kEVjaq7Nk1O
         AB3JnPwLc9/KuBsrBLV+IaRGk2MRINXI7bpiRr9EqPhphdBkk2NUwTlGe7qv/p29TQYk
         nlvI1qSoPEaXBzeooe0cCGolMrFDMFzN4ECaxPCNg+qUjdXKBfA8j4KhhqpC1K778XuX
         FJLpD47TKduqTPzjZEQ6leikX34JH1aPwxHCIfINTYxS2aV9x3THpEtWHVcdLJoh7RBv
         ggXD8POE/EwVzL4nLN/gRtPE/awepAJmn3K/fyRPqsOiqvrEmAfmcwHILW0CGhfpYg/F
         4UrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712562067; x=1713166867;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1lm8IoXJe0WYSRwtdxW3X+Cv5dkEchtxnhEW0S0YWJc=;
        b=k49JyQ+7HMes/fKhJewy3BjmyJxkT7RaFKjXklN8b7nc/4Lh6zI76teIvSjxqy+mXr
         O2DaahIKBucZaY7jWtypbNWZrgXTTLJetrYc5SFcX2Yyv4UiqgEKXuLXUyLUg3nhQ6Lu
         fFmaIY5oYt09cJFZTxYV2E+wW6D3dIE2tDZ8mNCtv0DNgwSUQmUlkxtSvdZMzbO3XIaU
         Xgr+hilYLUZ+kGMqmM4BIKc8vAigKeVucAKh/tpv81j1Wju7Hh3oZ51lpywL29dr1fCu
         CYEs8jhDsuNnbp0QVyHiFsbNMb9Hx480AtBhDkQpYM56pPpgkZ7+j1e7TD+yVyylj+M6
         qt1g==
X-Forwarded-Encrypted: i=1; AJvYcCURe747KfXwUEa5mwYYd4heApv2a5eYfBKCeQSkCpCozbUrtb27OLXLvS4uPSe2D/3Te+/Cs+vGNUiGnc3AYko5YMCNTEIVzWN8OxPsK5WdGoUvNpz5FotXhA==
X-Gm-Message-State: AOJu0YxZGE+SyBouSWqS41xA+W3jTu8XnpqyHB3ICEsRm9+tS0IYr1qq
	MreJ4Bv+wffeAA7D8ef/5U+xDpg0LA/quz1++bHcaauIk2UPo6K5
X-Google-Smtp-Source: AGHT+IHsw0MqJncrkEsTav8GeBQKVLnnHHhYYl9/Fi+5JZD1076agLCl079JWImEZPXFh0LSDyynKw==
X-Received: by 2002:adf:e44c:0:b0:343:d06e:51cc with SMTP id t12-20020adfe44c000000b00343d06e51ccmr5136276wrm.66.1712562067341;
        Mon, 08 Apr 2024 00:41:07 -0700 (PDT)
Received: from vasant-suse.suse.cz ([2001:9e8:ab70:9c00:7f0b:c18e:56a6:4f2])
        by smtp.gmail.com with ESMTPSA id j3-20020adfff83000000b00341e2146b53sm8271413wrr.106.2024.04.08.00.41.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Apr 2024 00:41:06 -0700 (PDT)
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
Subject: [PATCH v5 03/10] x86/sev: Set GHCB data structure version
Date: Mon,  8 Apr 2024 09:40:42 +0200
Message-Id: <20240408074049.7049-4-vsntk18@gmail.com>
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

It turned out that the GHCB->protocol field does not declare the
version of the guest-hypervisor communication protocol, but rather the
version of the GHCB data structure. Reflect that in the define used to
set the protocol field.

Signed-off-by: Joerg Roedel <jroedel@suse.de>
Signed-off-by: Vasant Karasulli <vkarasulli@suse.de>
---
 arch/x86/include/asm/sev.h   | 3 +++
 arch/x86/kernel/sev-shared.c | 2 +-
 2 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/arch/x86/include/asm/sev.h b/arch/x86/include/asm/sev.h
index 07e125f32528..829650bdd455 100644
--- a/arch/x86/include/asm/sev.h
+++ b/arch/x86/include/asm/sev.h
@@ -19,6 +19,9 @@
 #define GHCB_PROTOCOL_MAX	2ULL
 #define GHCB_DEFAULT_USAGE	0ULL
 
+/* Version of the GHCB data structure */
+#define GHCB_VERSION		1
+
 #define	VMGEXIT()			{ asm volatile("rep; vmmcall\n\r"); }
 
 struct boot_params;
diff --git a/arch/x86/kernel/sev-shared.c b/arch/x86/kernel/sev-shared.c
index ba51005ddde2..fb62e1582703 100644
--- a/arch/x86/kernel/sev-shared.c
+++ b/arch/x86/kernel/sev-shared.c
@@ -264,7 +264,7 @@ static enum es_result sev_es_ghcb_hv_call(struct ghcb *ghcb,
 					  u64 exit_info_2)
 {
 	/* Fill in protocol and format specifiers */
-	ghcb->protocol_version = ghcb_version;
+	ghcb->protocol_version = GHCB_VERSION;
 	ghcb->ghcb_usage       = GHCB_DEFAULT_USAGE;
 
 	ghcb_set_sw_exit_code(ghcb, exit_code);
-- 
2.34.1

