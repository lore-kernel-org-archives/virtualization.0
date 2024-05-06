Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF48315E1E8
	for <virtualization@lists.linux.dev>; Mon,  6 May 2024 21:53:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715032422; cv=none; b=pdloKfrmN88xCQDAndECrezxR/ORZ9JUUaD1ar8DNhbr272ZfFGIO4hZs7M2FbW2eoFPSnS2i7O6+XpebLfVxDM83PGPEAcA12tdUoarKg4vixVqzwyTyzZSSqZxsZ93oASRH7LoUc8n/F51aqDS0cxu3OSeDigII/bshHstzgA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715032422; c=relaxed/simple;
	bh=36Y3BMpDPZQyyL3FNj9mP3vbrfKi4AzrJYNgKvH4gwU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=piSPbkONwFw93TnXR9z/Dxyt+eG0ZIE70W/t4CickY76kRgSpKj7lCSWWPfYlxwLsCkQyCZSOs0q5kcjTkxaMUQM0bNKlPAhQQNbdAPCQ6aWVMfCHlysaF6Twr/ibqyKzI5cfnlBPm7jHRr7qLOH2L5lA0entIrDq1Q7ctJCTUk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=LWUGTnyI; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="LWUGTnyI"
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-1e651a9f3ffso11021985ad.1
        for <virtualization@lists.linux.dev>; Mon, 06 May 2024 14:53:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1715032420; x=1715637220; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XasMM8RHDoAht3zV8M7CkVA/nSY/Z484OZ0/rKT1mpc=;
        b=LWUGTnyI1CImb+AIgTaJ+QCHdE0+Sz0zhzVxKI1j0EyNUX7w808Ntk/vhIBRcNtiS9
         u6dkEzGfOgs4Z8/yYp6lqGfMkOc/Jd0k8eJfhQs0hQDk2SG40qyE0auPv9IH2x2ld79J
         FQoSiUyhOFdeX18iOf5aVrckr2koPBwiLLYYM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715032420; x=1715637220;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XasMM8RHDoAht3zV8M7CkVA/nSY/Z484OZ0/rKT1mpc=;
        b=SqWtcDTB6cFXtE17d6sDxxwWiNfrLwmFP6064p0w/6OAOymlbmFhqtiGA4FBjj1VIb
         EU/36vfgsPUq6pUmceAQqS8IJAkBmZBCSF7F8ApRb3sNi4MZz+XZSMhHzMIUe0qjUadK
         gxfrSrtBkHHHs6+9zizVQJC4sTXoHwIFN+ylYIPzxNr3YNEAA6Piklp90RDV5nH3WKs6
         a1Auz/Z6E0YIKpLTb7aEzbc0e2/994r657GCGMXrFrKNE5rpGR5xjsduI0lNe8TdxYP+
         Vb36jND282nzHcFYeVFnyDMLTPxcj0120Cx5k6EJU7M6NNOMZfL56MPyrDh4bq93iJux
         kJcg==
X-Forwarded-Encrypted: i=1; AJvYcCVWzQEuUzpfCyoHCi/IaXUKoJIQJLiBYjCtFUjKq00omBDs7kRpAiwTcUU7tKK3yCfh4s7porvJdAs7RNnQW9A2ZOUIUxVK2T/KBGr0lwE=
X-Gm-Message-State: AOJu0YwWq5xoSa+kZ8+hjWQElrW7WKEYiOh1hIsvvy1gIwlZQTipwXSQ
	FWllsI/6JMpMs4jcWmxrHsydyRo9cSg5/WH3YVWwua8BP/C/ZGBwWqoVfn/xJA==
X-Google-Smtp-Source: AGHT+IENEOGN0tWde3qp/pU38RH6aIHaQEh28095AqfBsIIDAqJikcahIU1wceH2ANpCTzdN1vcY4A==
X-Received: by 2002:a17:902:d355:b0:1eb:3e13:ca0b with SMTP id l21-20020a170902d35500b001eb3e13ca0bmr9908685plk.37.1715032420197;
        Mon, 06 May 2024 14:53:40 -0700 (PDT)
Received: from amakhalov-build-vm.eng.vmware.com ([128.177.82.146])
        by smtp.gmail.com with ESMTPSA id h8-20020a170902f54800b001ed6868e257sm5664008plf.123.2024.05.06.14.53.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 May 2024 14:53:39 -0700 (PDT)
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
Subject: [PATCH v9 2/8] x86/vmware: Correct macro names
Date: Mon,  6 May 2024 14:52:59 -0700
Message-Id: <20240506215305.30756-3-alexey.makhalov@broadcom.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20240506215305.30756-1-alexey.makhalov@broadcom.com>
References: <20240505182829.GBZjfPzeEijTsBUth5@fat_crate.local>
 <20240506215305.30756-1-alexey.makhalov@broadcom.com>
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

Signed-off-by: Alexey Makhalov <alexey.makhalov@broadcom.com>
---
 arch/x86/kernel/cpu/vmware.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/x86/kernel/cpu/vmware.c b/arch/x86/kernel/cpu/vmware.c
index 68d812e12e52..9d804d60a11f 100644
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
@@ -431,8 +431,8 @@ static bool __init vmware_legacy_x2apic_available(void)
 {
 	uint32_t eax, ebx, ecx, edx;
 	VMWARE_CMD(GETVCPU_INFO, eax, ebx, ecx, edx);
-	return !(eax & BIT(VMWARE_CMD_VCPU_RESERVED)) &&
-		(eax & BIT(VMWARE_CMD_LEGACY_X2APIC));
+	return !(eax & GETVCPU_INFO_VCPU_RESERVED) &&
+		(eax & GETVCPU_INFO_LEGACY_X2APIC);
 }
 
 #ifdef CONFIG_AMD_MEM_ENCRYPT
-- 
2.39.0

