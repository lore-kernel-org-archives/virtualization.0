Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C9194AEFA
	for <virtualization@lists.linux-foundation.org>; Mon, 11 Mar 2024 16:17:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.137
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710173861; cv=none; b=AkPhUkKto5kiDkKA6wnNSHMkvAsHwHOmG0DTH9WCqHoKNjgIa7rrHhdzbAqGhvUZ9zpr3DI6mWCVYBFGx+dlnOMY4NXEW/H00Lnka6qLC9NzcRN23uXRC7tkQ0svJ9A6m5C8jl7mZHUUbLnx95oRgJ5yysKib9K60NP6oiJp15k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710173861; c=relaxed/simple;
	bh=uh321KuZzkIr6bov6gkL2gVcZHrVCSYkUtEmo3DNyRc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=eAzlXBRv/ca2/7K/Xd/Qaa2QYePWyhMqOKZKMiUGj1SYoDRA6CQN2lPUSULLn3QyiyNHI0kYggG8QywN3GlOrldbjO5rTCGrinm3w4s8Qb7q6hOuCTc2tz48InIQe8v/ZVRNRwTq9QWV7GctZBl5vcufpUkEqI2smJIQWsuryZw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Lg1v2ZES; arc=none smtp.client-ip=140.211.166.137
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Lg1v2ZES"
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 11741405B9
	for <virtualization@lists.linux-foundation.org>; Mon, 11 Mar 2024 16:17:38 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -1.849
X-Spam-Level:
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id CIHtjOb0F6JQ
	for <virtualization@lists.linux-foundation.org>;
	Mon, 11 Mar 2024 16:17:37 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2a00:1450:4864:20::42a; helo=mail-wr1-x42a.google.com; envelope-from=vsntk18@gmail.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org DDC23405B3
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=none dis=none) header.from=gmail.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org DDC23405B3
Authentication-Results: smtp4.osuosl.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=Lg1v2ZES
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
	by smtp4.osuosl.org (Postfix) with ESMTPS id DDC23405B3
	for <virtualization@lists.linux-foundation.org>; Mon, 11 Mar 2024 16:17:36 +0000 (UTC)
Received: by mail-wr1-x42a.google.com with SMTP id ffacd0b85a97d-33e6aca1ca9so4346675f8f.2
        for <virtualization@lists.linux-foundation.org>; Mon, 11 Mar 2024 09:17:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710173854; x=1710778654; darn=lists.linux-foundation.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KwrPOtCFWcQDMfUXPx+XS96HNczA3gaW/2MdY2qxab4=;
        b=Lg1v2ZESV10YE6Sjlj8df7l77xMcteebpwbRNxXUjZrOrybn1kInnR0LRqiSXUOJp0
         8mhZl9W+7agLO2Xy4Juz193xAgStwqqwtFOm1C4jv91mIKV+NT0uuuenNoWHuPyRDL/j
         0dKheH1pxcVjpj1ByPbEPOprzwBUlRiiZQSsmvWslTesw7yXUTE0zkpsGaaVLX8Q2vS8
         TCMHW2QbucMy+cGkChq7al7BZxjWT4kjMZdhYFOHD+yJYFdMOy4M8z2Lnn0vjSO7tvcG
         xIaL8nNsjokSEZZKBAd3cD8pcbpTzAYs5bbseZ9ROzyLB+89Iow16XmBShU7V7Tf19z7
         +0qQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710173854; x=1710778654;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KwrPOtCFWcQDMfUXPx+XS96HNczA3gaW/2MdY2qxab4=;
        b=D39VfO9Xojv2/gIebaCh1PySVgCXqABbUFGnKWFCkFRnItTdoVQ3gyFi8u2LkgZLyl
         Le30jf77ZeZvWBE1zXputwG5qdvEGHTA9N/qtBkm+7tT9nRIpyywVmVbK5F8grMJHKuJ
         gQI1oDqsLL0mFgJLL9mx/rXJlFH4Rg9W71UchLvuFvWrvSlQGgsZTdX5CWRzPQdKwZFb
         9eumE0CQjR+DELQxGdHWIJdJbmgqPZuJmlHPWipjUL28IqqvJLPKRu1WMNAfFEqjjnOB
         z86SpeBXIeBSE8p4J66QrRcniEGjm4wlKKaoG2PUCmRThoeR/ys9EgRt4ZXXhgtHWxNU
         a9sw==
X-Forwarded-Encrypted: i=1; AJvYcCVBjLnpSlvapIoVOKkPWg2Xxrm/RQ9ae2KVybhTvqMWJyQOnrusCPgro3105F01GKsimS4DEbrGdtaRudzmCGYht6PheydwnnLKRoUHmCXnZMzZR+rX3+kg0w==
X-Gm-Message-State: AOJu0YyF3DXYvNPAzFvTAYFotuK5fo/+zXTEJOA7Je430Mvj4NgFjPgg
	gU2gbbGw4ocV6dGYPDAPAb/zi9zul079gW9WMf8dgDAnjJmCIQ88
X-Google-Smtp-Source: AGHT+IH2ferHpfaCLktwprSAlut0kfkjOaWyxqFOcoy+lU0gHOdVqoYzZnhz4uQfv99VU6U5lBGYiQ==
X-Received: by 2002:a5d:45ce:0:b0:33d:3abb:6db4 with SMTP id b14-20020a5d45ce000000b0033d3abb6db4mr4095738wrs.69.1710173853730;
        Mon, 11 Mar 2024 09:17:33 -0700 (PDT)
Received: from vasant-suse.suse.cz ([2001:9e8:ab47:8200:c3b9:43af:f8e1:76f9])
        by smtp.gmail.com with ESMTPSA id ba14-20020a0560001c0e00b0033e96fe9479sm2823815wrb.89.2024.03.11.09.17.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Mar 2024 09:17:33 -0700 (PDT)
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
Subject: [PATCH v4 1/9] x86/kexec/64: Disable kexec when SEV-ES is active
Date: Mon, 11 Mar 2024 17:17:19 +0100
Message-Id: <20240311161727.14916-2-vsntk18@gmail.com>
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

SEV-ES needs special handling to support kexec. Disable it when SEV-ES
is active until support is implemented.

Signed-off-by: Joerg Roedel <jroedel@suse.de>
Signed-off-by: Vasant Karasulli <vkarasulli@suse.de>
---
 arch/x86/kernel/machine_kexec_64.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/arch/x86/kernel/machine_kexec_64.c b/arch/x86/kernel/machine_kexec_64.c
index bc0a5348b4a6..3671ea1a5045 100644
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

