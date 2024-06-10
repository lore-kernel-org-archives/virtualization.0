Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D5B280604
	for <virtualization@lists.linux-foundation.org>; Mon, 10 Jun 2024 10:21:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718014895; cv=none; b=qrN9Uab2OL6CqSL4l6/NrVstCB4UC9CdWK6X19sPC1jwBP/p0IjrLfP4QZgPfifgQ316oPiAOU1Cg65hBMF3vn1mQxRvDIwxzGving1bBKfvPcfP76N1uBa60J4r6NuBzAg82bF2CdikyLhUQNJP1UGpClLbTtlelrmakBnIGaI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718014895; c=relaxed/simple;
	bh=JZT+a3gMm7LX5fmthY+7RJk9xN/fuL/DRlnnw7HuKpA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=dM8sQXBUbO2NWEAnGAiuXaW4oETc8wLvNsNmVMZwuk/1XIe9VVrqu6DQLlFHkRCAzgdNGMSrbmwr+BkXDNE5cM8Uk0XQuM4OOLK9xBnXvZDQjiA5K5SMwJTHZtCjc/ghXufNMlfn6PGwlaUkpdR/xArvGd+vvK5k1YxEX/4YF9s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Lk/Iclig; arc=none smtp.client-ip=140.211.166.133
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Lk/Iclig"
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id AC5EC40289
	for <virtualization@lists.linux-foundation.org>; Mon, 10 Jun 2024 10:21:32 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -1.849
X-Spam-Level:
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id QGa0vIzDEzvN for <virtualization@lists.linux-foundation.org>;
 Mon, 10 Jun 2024 10:21:31 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2a00:1450:4864:20::12e; helo=mail-lf1-x12e.google.com; envelope-from=vsntk18@gmail.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org A4A874022A
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=none dis=none) header.from=gmail.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org A4A874022A
Authentication-Results: smtp2.osuosl.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=Lk/Iclig
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
	by smtp2.osuosl.org (Postfix) with ESMTPS id A4A874022A
	for <virtualization@lists.linux-foundation.org>; Mon, 10 Jun 2024 10:21:31 +0000 (UTC)
Received: by mail-lf1-x12e.google.com with SMTP id 2adb3069b0e04-52c82101407so2422849e87.3
        for <virtualization@lists.linux-foundation.org>; Mon, 10 Jun 2024 03:21:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718014889; x=1718619689; darn=lists.linux-foundation.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PXpLAMRWKrEJAxhlnztpKOQCT6b3mNAcjXJNnKoGzl0=;
        b=Lk/IcligXJ8ot0LCK4K7xPzN06Y3L2q4Cr91KOYHFF74PkhnSV3GPMmxaK8ZNjaMlD
         7Cs17+ttGKJBo0p/DHXHQeFLdN8VmLI1uoQxQ49xoq3JcGCLm+Y4BgNZEIlADRez3vN7
         aY+AtP531rFE9HNlg56WgYz2ArzhfAge/M0Jxhn9eTRNu4rw9HD5kd2NXIhxwIBZ6HFy
         iT/B7bs1m/tBWgYYXjRYEf1TXn1K5ecApg1ixaexq+xotW6COrhTAIgwl53wI23UXnUc
         RGxlSmQCwDYXITWse/qfoglR/ijnoON+B7DurCwXQuAsYWTfxFRtH9M3B0wwMG5QCv+R
         nfhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718014889; x=1718619689;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PXpLAMRWKrEJAxhlnztpKOQCT6b3mNAcjXJNnKoGzl0=;
        b=hhggah0uFboxlnMX/ZEswncmR/SJlWaH9Jp1hPmeV6F44NWYfUHvFh9CxsZ637LyTa
         1f1FsD/0IrMfjTExZYuY7qP7PrIAkeyJUHIYfnSFmAxVkyX2ZxVhtjfTiUz/kAm7KfBc
         MninYXwxvX2ld4aFZFwCqgeiF/x12m6cGGTXaiUMi9nZN/zhFOdI7//BVToWwoRImIn5
         az0BXx7WfdQcWNxB7Cakub00xRIqDyMy9PqXusCHAzMuc1FexCsLK7lU2v/FBK5a7YjE
         3xVt9jBt1MylQQqUcWY084BX0XVtzJMxvKtMp37KXJjrzenuB7zAlBl8dc0fjo41ON5Y
         StkA==
X-Forwarded-Encrypted: i=1; AJvYcCUU2KOfXNk7HZjz9CF5vE9ojqTMzis0XCoJjTT8uG7Ag9bWx5eNBIdIX5friJ5of4ivBWBP4pty9XiS02wN+mDR2Ds1r2N/dFL2xMwdawTMVh+1NJo5qBP1iw==
X-Gm-Message-State: AOJu0YxxKhn+gN5f1F8g7JZDii9tHOd5+MreNmVbHdDunpFh57YJ4rlL
	psf9M+VQ3RFlY86Y9695pAoBHtj8+mUuo8yXO4dLUr0kNTp4bTuN
X-Google-Smtp-Source: AGHT+IHJj4AaRNhrX7A2v/Kk6aeuS0bX16/27Qun+QcsTNsjyz064wpO/4XTT3yY1voEgsZC5VV9Fw==
X-Received: by 2002:ac2:4c82:0:b0:52c:8289:e891 with SMTP id 2adb3069b0e04-52c8289e9a0mr3434713e87.6.1718014889127;
        Mon, 10 Jun 2024 03:21:29 -0700 (PDT)
Received: from vasant-suse.fritz.box ([2001:9e8:ab68:af00:6f43:17ee:43bd:e0a9])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a6f0d7b35d5sm290887766b.192.2024.06.10.03.21.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Jun 2024 03:21:28 -0700 (PDT)
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
Subject: [PATCH v6 03/10] x86/sev: Set GHCB data structure version
Date: Mon, 10 Jun 2024 12:21:06 +0200
Message-Id: <20240610102113.20969-4-vsntk18@gmail.com>
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
index ca20cc4e5826..963d51dcf0e6 100644
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
index f5717eddf75b..f63262a9c2a5 100644
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

