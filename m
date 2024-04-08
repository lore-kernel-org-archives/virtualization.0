Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24FE22E3F9
	for <virtualization@lists.linux-foundation.org>; Mon,  8 Apr 2024 07:41:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712562068; cv=none; b=jPpnE2ZeBvC6vnPPxov98jAooHB88MHJ/iGTnrzMnChnb1LPV4HIByeueOZSe/eex7WEJQlwHRt0Bb/zDY2KSOh1AL+dlCqYGmb2MmfoDQJZAf+giXqveab8lCY28gXT0FhynATVwzbcDO0tAUJVCiuCGTT9WjFc1Q2heHSPr1I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712562068; c=relaxed/simple;
	bh=deFR0EbFGoz01sPfPnM8bTuqp1Yx689MWIkLggdnTCk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=tDhqPD1cCU+ZZb5WRPa4tKIRsQVZsPjWf44ujl6s3Qdyz6bo/tkEop0AZT8pQeWoqZIKX3eCuY5/3geaExYCxWPKtYVrUAPK9RHtc9yjKlpOthp/PuV+TZjbtRVd0wIl+ZDcQQwkd7ozlwEbQzdA79uEPlruq/jb3l3Fm3UY1W8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=etR6y4Jz; arc=none smtp.client-ip=140.211.166.136
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="etR6y4Jz"
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id B37C060A93
	for <virtualization@lists.linux-foundation.org>; Mon,  8 Apr 2024 07:41:06 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -1.849
X-Spam-Level:
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id df7tg998gFMG for <virtualization@lists.linux-foundation.org>;
 Mon,  8 Apr 2024 07:41:06 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2a00:1450:4864:20::335; helo=mail-wm1-x335.google.com; envelope-from=vsntk18@gmail.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org B746760A53
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=none dis=none) header.from=gmail.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org B746760A53
Authentication-Results: smtp3.osuosl.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=etR6y4Jz
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
	by smtp3.osuosl.org (Postfix) with ESMTPS id B746760A53
	for <virtualization@lists.linux-foundation.org>; Mon,  8 Apr 2024 07:41:05 +0000 (UTC)
Received: by mail-wm1-x335.google.com with SMTP id 5b1f17b1804b1-4166ccac75cso5042505e9.0
        for <virtualization@lists.linux-foundation.org>; Mon, 08 Apr 2024 00:41:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712562063; x=1713166863; darn=lists.linux-foundation.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1UC5Sjs0y+1l0bqhsbHpWK9vOawmeA7/6gd6QlKv6W8=;
        b=etR6y4JzYsCuLrqNKwe6leKxUxxgLw5TeAfPgmtd6PSIHYhNO6QS9Km4rVqrimOdsV
         NykVEyq2eyu5N0RRLU+HoRvKlHPo1WmamT5+P3rWLwGC9ER8ObTVUI3zLCcz4Pql8twK
         /5HRkIwGN0Dz4A/kYygHWUp1C1PgDEFONpaDm2NT/aa/KtwXUPY7SwtQvXiSwNfVoHNs
         YTt+BPo5y67GhVNqvH7MAI9CkefFysDxTHzgp7FthUpSDJKCL8ORMSQB9mKbwnAa0HSz
         +LRSVhVcXW9pH3CtO9SCoq/QeEgrSHadwC5LJgTOm7kkjOFMenfXV7L2oSELHQx4AUeo
         tXYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712562063; x=1713166863;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1UC5Sjs0y+1l0bqhsbHpWK9vOawmeA7/6gd6QlKv6W8=;
        b=KvolWJqPwI1mhUuGWhXZRh9ayM5Q50QjtHBfCEGuhwJnDZMKvLWZFDMFtr3sUaVl74
         e4I+Kotltux24U6dRdAG5Sic+E6/kmNmzbU+6854swTr9e5c7nF756w3VQZqBZylHO4Y
         vMGPIWPp5MLA9YQeqybgfuedMg0w8gVGV71mhRTpb/Rxkdmzm1rkaeJ2RAlv6T6Pn1eL
         cV4r+88zKKvXzB0tYqm7EHwH/byLISaa0ym4oRfwsZMxo0mZ08+VlcW5iwGFnmRpEHee
         VLmCnw3TMr2djahz3yi+h4TyMGw5ZZdFUmCVDBK56IBTtpVmFi3tWVnPHIrZ5kh5vkqp
         9lqw==
X-Forwarded-Encrypted: i=1; AJvYcCV36AupdnT9uvTStnagtbY6KhNG7gVexCymUw+UN76rxAQMdVaYTvNyWKRmiatoxF8fJEM2LBxNhHbO5qpkbVbDKWYUHjYXZP6u7UCMxSF30e3g0etOZJOe4g==
X-Gm-Message-State: AOJu0YyivNNxYn3y6uh8+8qFa4htBu8ZqAkuU4yNpLzrKvKEIa/9xKbE
	fsZ+/TZ01hYkKrKbWbIYqB/N9K0fhADuQdpmh5dUGYFNFrT/ZrQ3
X-Google-Smtp-Source: AGHT+IEA4rqVnV0zCmstOW3Lm+tswAKk7lUuBX8iEtTS9cgrpMZ4GU/tM2sKL8kd/pn/zpEd0eSv3A==
X-Received: by 2002:a05:600c:470b:b0:416:6a7a:8528 with SMTP id v11-20020a05600c470b00b004166a7a8528mr1630488wmo.39.1712562063310;
        Mon, 08 Apr 2024 00:41:03 -0700 (PDT)
Received: from vasant-suse.suse.cz ([2001:9e8:ab70:9c00:7f0b:c18e:56a6:4f2])
        by smtp.gmail.com with ESMTPSA id j3-20020adfff83000000b00341e2146b53sm8271413wrr.106.2024.04.08.00.41.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Apr 2024 00:41:02 -0700 (PDT)
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
Subject: [PATCH v5 01/10] x86/kexec/64: Disable kexec when SEV-ES is active
Date: Mon,  8 Apr 2024 09:40:40 +0200
Message-Id: <20240408074049.7049-2-vsntk18@gmail.com>
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

SEV-ES needs special handling to support kexec. Disable it when SEV-ES
is active until support is implemented.

Cc: stable@vger.kernel.org
Signed-off-by: Joerg Roedel <jroedel@suse.de>
Signed-off-by: Vasant Karasulli <vkarasulli@suse.de>
---
 arch/x86/kernel/machine_kexec_64.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/arch/x86/kernel/machine_kexec_64.c b/arch/x86/kernel/machine_kexec_64.c
index b180d8e497c3..4696e149d70d 100644
--- a/arch/x86/kernel/machine_kexec_64.c
+++ b/arch/x86/kernel/machine_kexec_64.c
@@ -267,11 +267,22 @@ static void load_segments(void)
 		);
 }

+static bool machine_kexec_supported(void)
+{
+	if (cc_platform_has(CC_ATTR_GUEST_STATE_ENCRYPT))
+		return false;
+
+	return true;
+}
+
 int machine_kexec_prepare(struct kimage *image)
 {
 	unsigned long start_pgtable;
 	int result;

+	if (!machine_kexec_supported())
+		return -ENOSYS;
+
 	/* Calculate the offsets */
 	start_pgtable = page_to_pfn(image->control_code_page) << PAGE_SHIFT;

--
2.34.1

