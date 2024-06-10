Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 251827E575
	for <virtualization@lists.linux-foundation.org>; Mon, 10 Jun 2024 10:21:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718014891; cv=none; b=BrNdp0zWNqS+bBgK9J/LRY/9fLrxxLAjRk/YdEvcEFF9G/ydMnDYp5ceoeet6UhQvT9CtHwLOuP9V+aqbt0W7IYFPFjmbxV69sHyS1LQD+UxcJWdJdD3wp80o4t/csBEbw4N+2hZSohTi5/UA1pbEZ9v7hC0CIK1NaOu2HFOFBQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718014891; c=relaxed/simple;
	bh=B2wImS6jYkVNxmJNAz/7Rmlae+jcWsMN5Euy7uX8VsY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=H8QWNS0Rh5AESBM5x6a5WkxnQs1xYZAziI93L0xEKr/yDWWNus6U2rNRXlz9jizBBl4yz1gzAgHKf0NDjoihDdjcFEjgiDa9WSGv4bQX622CbUb438bV4+hJ3WoLjhShijRFO0xtVhK1+x7QNRFocXB14c4HpXJeLX0h+8+CxBg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gTRElLHu; arc=none smtp.client-ip=140.211.166.136
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gTRElLHu"
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id A7547607D6
	for <virtualization@lists.linux-foundation.org>; Mon, 10 Jun 2024 10:21:28 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -1.849
X-Spam-Level:
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Fw6aTE29c5i3 for <virtualization@lists.linux-foundation.org>;
 Mon, 10 Jun 2024 10:21:28 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2a00:1450:4864:20::535; helo=mail-ed1-x535.google.com; envelope-from=vsntk18@gmail.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org B6FAC60667
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=none dis=none) header.from=gmail.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org B6FAC60667
Authentication-Results: smtp3.osuosl.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=gTRElLHu
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
	by smtp3.osuosl.org (Postfix) with ESMTPS id B6FAC60667
	for <virtualization@lists.linux-foundation.org>; Mon, 10 Jun 2024 10:21:27 +0000 (UTC)
Received: by mail-ed1-x535.google.com with SMTP id 4fb4d7f45d1cf-57c60b13a56so2820142a12.0
        for <virtualization@lists.linux-foundation.org>; Mon, 10 Jun 2024 03:21:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718014885; x=1718619685; darn=lists.linux-foundation.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iEfSemHRxgSOfPiZYMvW6KyDv2YGLxFXvDUpF+fStco=;
        b=gTRElLHuZEgEcQmgc9Zp0Sz8Hrv5jiwFtu6oR4sVdTUdI3rMbKcq+R8ncU8KoOZnMl
         IyF5twaHvMtp4/ojILKIir99GrqqfCio0Z4AxN/sti7WsZPcJYLwC7DKl/sonaV3I0X1
         Mn5JRqbhgeVZ16RHdYjgDGdhIH6bNSSF8RwvORcCkp1MIGQCXrvHCRn4paajNvvhkgR1
         36fPl8whR65cNMjXOnyK2xhyk2ZOAAUJRc9+GXM3th+JRq2uKRuBWzy6fKGPG1j/B2eb
         mVQzMr74zYqd/mdisIzsFUzv2DP10ZOHyIqrBnBPf9Gn03YEwX3OYJbpyFWX3NXv4ngb
         Vgsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718014885; x=1718619685;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iEfSemHRxgSOfPiZYMvW6KyDv2YGLxFXvDUpF+fStco=;
        b=JvJP9U3rvoP9Id9qEbckM8G7kwM2A6gVstU8NZbmge/b3D1zCSKfSMv7x0qwyesKAt
         WU0Hb53Gp0wO5dE9rcg6ditG0V+2tur1+YZZE2fvOmpeso2jqoMkuOeEs/wL9RvdXZpx
         Jzx7MPHMyDNTzDLp3lbpGz4733Y5PeR15+aqDbs6/iWB13YoKRiPY2fcwkxMLe49wxWD
         ryfRLjDpRuq27hfpCJAykGPoFDCera0QXPazgGjmhrEu56W9uZSF5/aXanP7I4Y39OaP
         ZikVErvTDCeDOnc5PLmO5jt3YFy4UD7ZYBXKRUb5JBoGre5pJkNNqMZ6Hqqw8hJnT8Mx
         VEyw==
X-Forwarded-Encrypted: i=1; AJvYcCXPN8i7E1xSYFKL32YqMw2rmXie+h1AQ5KFKWIcbz+RN3mwqAeeANBNKyjzz22sDORnsZnRvU9cN/z3OjGkkuh7o2mwMFIE0q3avsgItDv7n2PmKrR+8kVMgQ==
X-Gm-Message-State: AOJu0YyDUqoUCy4SY6aflYjcHlE8cCfslSsB395tDdsaPDWw7xCzeq8e
	y70nNAD6jfGE+sFzltT4+cQ1slute9ppWyIRTBf+wbzvleFDM3PM
X-Google-Smtp-Source: AGHT+IG1u2X9S9HjwLyvUzoKmM04a54bnBw7Lz54/NkJdSpdqT0nvOtendvNpOdVPb71wHGOXHjzEw==
X-Received: by 2002:a17:906:3289:b0:a69:1a11:d396 with SMTP id a640c23a62f3a-a6cdc0e252amr568492666b.71.1718014885293;
        Mon, 10 Jun 2024 03:21:25 -0700 (PDT)
Received: from vasant-suse.fritz.box ([2001:9e8:ab68:af00:6f43:17ee:43bd:e0a9])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a6f0d7b35d5sm290887766b.192.2024.06.10.03.21.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Jun 2024 03:21:24 -0700 (PDT)
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
Subject: [PATCH v6 01/10] x86/kexec/64: Disable kexec when SEV-ES is active
Date: Mon, 10 Jun 2024 12:21:04 +0200
Message-Id: <20240610102113.20969-2-vsntk18@gmail.com>
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

SEV-ES needs special handling to support kexec. Disable it when SEV-ES
is active until support is implemented.

Cc: stable@vger.kernel.org
Signed-off-by: Joerg Roedel <jroedel@suse.de>
Signed-off-by: Vasant Karasulli <vkarasulli@suse.de>
---
 arch/x86/kernel/machine_kexec_64.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/arch/x86/kernel/machine_kexec_64.c b/arch/x86/kernel/machine_kexec_64.c
index cc0f7f70b17b..1dfb47df5c01 100644
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

