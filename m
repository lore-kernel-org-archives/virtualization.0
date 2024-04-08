Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 147374EB3A
	for <virtualization@lists.linux-foundation.org>; Mon,  8 Apr 2024 07:41:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712562086; cv=none; b=rmaIqbEF05ajdPrKNmeWfsGgoFCOmTYujmFbftSMuho0SrBi6CMeYKVyPJ8yujFoWdRmHCiiv5Ycf37wfhcq0hXdxxg+Zx+On7Q7DXW+zw07WIyW98K1IwlmYGc11N7uVbIH/xVgD4IXySimIRE8NmJuTag5ObDF+qtAIb7rvcc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712562086; c=relaxed/simple;
	bh=nraWtElHPDcy4J/h0QtFNZ3iGaE/9eKaPhhvDhuTS7E=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=BsZlRN1oOenITQKwmGt5pZUcB8DjC2NUNwxYpqV2cbO+IpFvaVMwgai+KBFVEOOgW+qxPYz89hS0bdUg4qlxhVxlA62v2HmDgEeGjZ5pqoCG4SBjgvA7+ejFKeZwp7BfS4mpIaCBICRQsL9ciy8Vk9rZuDhsKqAQGNC2eMHcigU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=X1cikGer; arc=none smtp.client-ip=140.211.166.138
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X1cikGer"
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id C5FE381E29
	for <virtualization@lists.linux-foundation.org>; Mon,  8 Apr 2024 07:41:24 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -1.849
X-Spam-Level:
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Qbg5QOBMUdYG for <virtualization@lists.linux-foundation.org>;
 Mon,  8 Apr 2024 07:41:24 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2a00:1450:4864:20::429; helo=mail-wr1-x429.google.com; envelope-from=vsntk18@gmail.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org D53DE81C19
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=none dis=none) header.from=gmail.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org D53DE81C19
Authentication-Results: smtp1.osuosl.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=X1cikGer
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
	by smtp1.osuosl.org (Postfix) with ESMTPS id D53DE81C19
	for <virtualization@lists.linux-foundation.org>; Mon,  8 Apr 2024 07:41:23 +0000 (UTC)
Received: by mail-wr1-x429.google.com with SMTP id ffacd0b85a97d-343e986aa6cso817198f8f.1
        for <virtualization@lists.linux-foundation.org>; Mon, 08 Apr 2024 00:41:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712562082; x=1713166882; darn=lists.linux-foundation.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vffWxrDfGUfj6Dj40L1W41htTqoat8lNT1P/loOuIyQ=;
        b=X1cikGer28JR4I1jYddTuRMZNFxbCcEFAPi36LQmg70XQ0DQpT2NMXWnCOuV1UmvND
         jz1YXQijaMIpqapRBAYIOUtHdOBi20Q63doQ06ELP4+4LenOYoJxYn/rvzBRvnVBs6yv
         1pbvvThRy0w+kQYrKKCHUgT6oW8a2ySgjl4jUnPibTOvh//wSszlgMdC5Bwux5rXXkZl
         L9gYu2bairT4m4dV7Ni7iSMV3813RzqL6jCk4nFl/+LoTHjKw+gJNobgSK0wqyQkIyIr
         /j/2mSVmbfP5QYaTsJ9eK4cOODNPW3u9ooIohmy6V1WElV3PQvpp/QD2jszJieYv0aRW
         9p0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712562082; x=1713166882;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vffWxrDfGUfj6Dj40L1W41htTqoat8lNT1P/loOuIyQ=;
        b=inVtpXn/F5+wSAlcU0yar0cBp81j+SbSamWp2IAvoSMTr9K26OAiWNKtwTLuyvvqbA
         uJVBV31SOs/ivE/wtg+wyriD4cnt3XK0E2+GKxbFZh1Tsfg8W5IPU36yPe+eh9yChSRo
         63Ja3Cr4lrtHjg4cA9pZn+geJJic0ScRsotU9bvgm4EZKKUI6i2i7+7vWbsPkgsJEMW7
         GxcsLGD0VXn/fROq0XVnBeMRrlAWHGnI1k97Pg5BuiE758U2u9nH7wxUjFGKxnOfVQc0
         J0p5FdDy4FZrOgva4z7DRGoJSaBcI3EZeHRhM1GwpXSpCmdDykRtyZ3wZ5u3y2WiFLPg
         X7rQ==
X-Forwarded-Encrypted: i=1; AJvYcCV/5DjQzC3kwzTobQiDJPfiRT8yo5nN7KkYWIolO0VRzxrCXJMAeV5EmJ0dak+3sRRP501cgWNREIp2gf6SCTh7wbveIgO73ZiOyVkGlSoa3usbYNoHH61YBw==
X-Gm-Message-State: AOJu0YyNFggVIr65Yz+xsKOO6phFqjOFZamb0YPPvi8T69niiHFhEdpv
	kTwNvkEHs+ojvZ/CDqZ13yFO994AmMRB6ayx+x013IE3d2TJfVkf
X-Google-Smtp-Source: AGHT+IFJ4+QJwRhaWOkJ+xi/SDRYHJSS+dNKUjJlrOrr+g4LrjWQZtOQ6FOdPmbvQsUHzg88XvrMoA==
X-Received: by 2002:a5d:64a2:0:b0:345:b238:534d with SMTP id m2-20020a5d64a2000000b00345b238534dmr1768262wrp.28.1712562081667;
        Mon, 08 Apr 2024 00:41:21 -0700 (PDT)
Received: from vasant-suse.suse.cz ([2001:9e8:ab70:9c00:7f0b:c18e:56a6:4f2])
        by smtp.gmail.com with ESMTPSA id j3-20020adfff83000000b00341e2146b53sm8271413wrr.106.2024.04.08.00.41.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Apr 2024 00:41:20 -0700 (PDT)
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
Subject: [PATCH v5 10/10] x86/sev: Exclude AP jump table related code for SEV-SNP guests
Date: Mon,  8 Apr 2024 09:40:49 +0200
Message-Id: <20240408074049.7049-11-vsntk18@gmail.com>
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
index aa53e8eb4cd5..d915d9158926 100644
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

