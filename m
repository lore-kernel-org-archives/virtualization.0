Received: from mail-yw1-f174.google.com (mail-yw1-f174.google.com [209.85.128.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96291157E98
	for <virtualization@lists.linux.dev>; Thu, 13 Jun 2024 19:17:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718306264; cv=none; b=BOv4hZghus2cb9Qa/uFFczUP3g1J4RQSKWXDWhWQF0DU//kdTWbkU5b+aHzhLmNI+2FMgoFNMiQa8nAqIMpSQrMNTTae+Ro11DK5+mm94Y2GUIVMviguBzCfw9X8Fiu+R8J5Xxxaro5nl/T4DH9nYCrfbTl2Th4pSGtzuT/e++U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718306264; c=relaxed/simple;
	bh=gJtizgfTtQbGQhXe0Ffz4OqK1Rt5xK/EhfhSkvCPdfY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=pI9wJCx0rODsac6n0QNVftoz9/Z4ruMkZEkf028ETccgDx8mbFpqmyUKrHZmg+r0HrsrUKFF4vDDlxWsQ1LIIrUsdYhd/RmZ0qGYMwvGksli1H+xd4ARjZl+5xmGTkRR6shyvrdXj8jH32nV4yJJ0en13/q0LlTXLGrtB/GuNjc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=GexY5MIF; arc=none smtp.client-ip=209.85.128.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="GexY5MIF"
Received: by mail-yw1-f174.google.com with SMTP id 00721157ae682-62f86eaffbeso15590647b3.3
        for <virtualization@lists.linux.dev>; Thu, 13 Jun 2024 12:17:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1718306261; x=1718911061; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7pPcaHiPPoaU0LCl+3obAd9PjZsEURqyWYfZZD0IxMg=;
        b=GexY5MIFxMeqp9yyxKMP9bVW7xvlU/H+T0bfQDx0R3yMZUGlLDQp/QsgTivg5iEqJl
         +WaNuWLsw/0LEJDmC5XCJ7MJ81zajv+zloFAY/apihYde8/aniIK/EvXJwp+sYvTsSUK
         J5BBn1kdEKquus39Y9u0xldCi9wtnFVrQLh4g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718306261; x=1718911061;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7pPcaHiPPoaU0LCl+3obAd9PjZsEURqyWYfZZD0IxMg=;
        b=DJo9jKm0i6gHK+MBE7fDl3BzCEXoTfGYXUbZSyf3FeTHVMdPnbq52jL1vXnE+5RuYE
         t0wBPGq9Wvj8RfvzUhXt1aJqknbkjNfrc95ul3Z6Y6EjJWLAAPpbwvXBTYWA7E5n2XOc
         5XrkT1cAds/IQHdadf2QYbzaEw0sKwlbVheKlf203nrxhN2m3w1PUxTBNxO4uNJY4SW4
         xcqDdzYfBre2j5AMgFoe+aGeLWDk5/qtLVKyZGW6bbPRcZFSuwI1HW981Adfwj6xU2iQ
         l3mrrqoML3JJpNEDkoPFVpAWPh3b02AwDF8TQPRC8eBNHBgypOEn6C4hXK/6d3BnClGl
         JHXA==
X-Forwarded-Encrypted: i=1; AJvYcCXypCIHhs17YW62m8vIk9Jkf3D3fbADS8QwWGkMLo6sUInBozWWArc3nllUhqIx1IN5Pnfy8u0AssSd8qPbbS+iBt2+InrrgwaZVPa/NxE=
X-Gm-Message-State: AOJu0Yy/whQrWsTXT6qHXFnnG0t7Rp7PPomrmA5zRWKKjhe9u6neMqR7
	sagkQ4boZ7SjLrc1LoeNMwzUHis5pZCVgVlXadW7Iur5d8EQyigcFLIpMnZd1g==
X-Google-Smtp-Source: AGHT+IEWURrmB3A2rOUKWL00yxGmIpKcgzJOWJY4x+5FfERXRFuKFdGultRWCA+8ZJ4Et9888+QB5w==
X-Received: by 2002:a81:e90b:0:b0:618:83a4:588e with SMTP id 00721157ae682-63223d3b72emr4007287b3.37.1718306261554;
        Thu, 13 Jun 2024 12:17:41 -0700 (PDT)
Received: from amakhalov-build-vm.eng.vmware.com ([192.19.161.250])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6b2a5eb47f6sm9714106d6.82.2024.06.13.12.17.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Jun 2024 12:17:41 -0700 (PDT)
From: Alexey Makhalov <alexey.makhalov@broadcom.com>
To: linux-kernel@vger.kernel.org,
	virtualization@lists.linux.dev,
	bp@alien8.de,
	hpa@zytor.com,
	dave.hansen@linux.intel.com,
	mingo@redhat.com,
	tglx@linutronix.de
Cc: x86@kernel.org,
	netdev@vger.kernel.org,
	richardcochran@gmail.com,
	linux-input@vger.kernel.org,
	dmitry.torokhov@gmail.com,
	zackr@vmware.com,
	linux-graphics-maintainer@vmware.com,
	pv-drivers@vmware.com,
	timothym@vmware.com,
	akaher@vmware.com,
	dri-devel@lists.freedesktop.org,
	daniel@ffwll.ch,
	airlied@gmail.com,
	tzimmermann@suse.de,
	mripard@kernel.org,
	maarten.lankhorst@linux.intel.com,
	horms@kernel.org,
	kirill.shutemov@linux.intel.com,
	Alexey Makhalov <alexey.makhalov@broadcom.com>
Subject: [PATCH v11 6/8] x86/vmware: Correct macro names
Date: Thu, 13 Jun 2024 12:16:48 -0700
Message-Id: <20240613191650.9913-7-alexey.makhalov@broadcom.com>
X-Mailer: git-send-email 2.39.4
In-Reply-To: <20240613191650.9913-1-alexey.makhalov@broadcom.com>
References: <20240613191650.9913-1-alexey.makhalov@broadcom.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

VCPU_RESERVED and LEGACY_X2APIC are not VMware hypercall commands.
These are bits in return value of VMWARE_CMD_GETVCPU_INFO command.
Change VMWARE_CMD_ prefix to GETVCPU_INFO_ one. And move bit-shift
operation to the macro body.

Fixes: 4cca6ea04d31c ("x86/apic: Allow x2apic without IR on VMware platform")
Signed-off-by: Alexey Makhalov <alexey.makhalov@broadcom.com>
---
 arch/x86/kernel/cpu/vmware.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/x86/kernel/cpu/vmware.c b/arch/x86/kernel/cpu/vmware.c
index c0a3ffa9e023..d24ba03b30b8 100644
--- a/arch/x86/kernel/cpu/vmware.c
+++ b/arch/x86/kernel/cpu/vmware.c
@@ -42,8 +42,8 @@
 #define CPUID_VMWARE_INFO_LEAF               0x40000000
 #define CPUID_VMWARE_FEATURES_LEAF           0x40000010
 
-#define VMWARE_CMD_LEGACY_X2APIC  3
-#define VMWARE_CMD_VCPU_RESERVED 31
+#define GETVCPU_INFO_LEGACY_X2APIC           BIT(3)
+#define GETVCPU_INFO_VCPU_RESERVED           BIT(31)
 
 #define STEALCLOCK_NOT_AVAILABLE (-1)
 #define STEALCLOCK_DISABLED        0
@@ -473,8 +473,8 @@ static bool __init vmware_legacy_x2apic_available(void)
 	u32 eax;
 
 	eax = vmware_hypercall1(VMWARE_CMD_GETVCPU_INFO, 0);
-	return !(eax & BIT(VMWARE_CMD_VCPU_RESERVED)) &&
-		(eax & BIT(VMWARE_CMD_LEGACY_X2APIC));
+	return !(eax & GETVCPU_INFO_VCPU_RESERVED) &&
+		(eax & GETVCPU_INFO_LEGACY_X2APIC);
 }
 
 #ifdef CONFIG_AMD_MEM_ENCRYPT
-- 
2.39.4

