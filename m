Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3463F15ECEE
	for <virtualization@lists.linux.dev>; Wed, 24 Apr 2024 23:14:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714000469; cv=none; b=fBLCGIyF7Tya6fBRjyCqtot0SxyVzTYSoNhkpVVplppwypXx/IZS6TqQsiFmTAtgIOaowjiG0pq9KSnl4tnIUE3EDbb32tByz44NxHenWAzfGzqcba29KsuKZ/BZriiF42vadskl/jzTInkwzTgWKiB8fLZID+W8QXgJUpjE5zo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714000469; c=relaxed/simple;
	bh=nJNB/KulTbCbDLeJblQkEeFfKzMceokVHJqyrs68Oh0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Lg3cSqLrnQ122RuWra5wEt30YXoHsZS7Xnk5+F3TOxxAcri9yspCiFWxqpDcEPmoQfQvcjheJV8QmEQTZSYdLdQIHkEibm5wF+AQ5LCeogUxz6bd6TquQpb/ISoK5hSBPY6frkNnKKWO+8JCLZnTCNdoRAI+fqPX2itv4DYQb7g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=S7i9Hwjo; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="S7i9Hwjo"
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-6f2f6142d64so418752b3a.2
        for <virtualization@lists.linux.dev>; Wed, 24 Apr 2024 16:14:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1714000468; x=1714605268; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aunCHk/+21TGD3cC0MnOgjQi+s2AopaplDfw/uAJlwA=;
        b=S7i9HwjouWDkwDeeeIBWGdLKOs74Q+nNVZUcaL6Xq3BHvPFCTJcpDpnboy93Z75x1j
         onmZMcUCvRxzvE5aYc6cfapF5n7rcIRGgefVHYYdpb0vpV8UpkTtRmZbhDXbmYH1vjO5
         wYz9ZX3SgmPtPzeIn2gLZpgPy8YzqwGEEm+SA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714000468; x=1714605268;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aunCHk/+21TGD3cC0MnOgjQi+s2AopaplDfw/uAJlwA=;
        b=A63STVSLA0LLE/hqDP5y66rCai/Tm3hy4uxs2XjXpajZIAxeNZx2/1hUSDx29hYU8q
         ICzJ4k4GUQkvhIfx9IjTRAJvbzr8YHQZ9U6RdOOb1O5JvwlhB7h3wplB6reCGSbNtERD
         G6jF0g3gcKcnixRMVewGERhzU13/5geNCdp5E+5omwSr/RtmaAQxzNhly1FjWzjn12jI
         GNQPcnhffESdHB7qc/EfTN7TGknp1b1ZU6OCtpbKleW5o1UF0j9pYAwjPsCCgb8GDIrd
         PJ3oAo0pX6r2O8iVE5859H03wL5sX6i6oyVby/ZZJufjyV/NiGCn9x5DUFTkIGRtdthX
         Fqaw==
X-Forwarded-Encrypted: i=1; AJvYcCXPWYFOcSxsrl+wkuW5KJISaHmmOUBbEUC8f+cGCy16G5YVTMttc/CNECzzoSO3YvOSmje7d88Hts5lIFEq9/9N/mhMmv57dcy6bctYPx8=
X-Gm-Message-State: AOJu0Ywjg/oCR3FhurkHYJoz0TWPxboBHSIZJqbzrFhDIiuPqGM8y0mU
	r+dJ8usrhKUFA0V30zUt95qrSjYDXT+heug6ooSnRNstg4sIIN5Io18yYCVynaumr+4LRDlklZE
	=
X-Google-Smtp-Source: AGHT+IHHdzGAXQ8gL0olZCSpi68pN5CG8/dpakkeGHeT/XAiJRJCeztoRovHlbGUOJO8Jirtf9fuow==
X-Received: by 2002:a05:6a20:9c8f:b0:1a9:8836:ae37 with SMTP id mj15-20020a056a209c8f00b001a98836ae37mr4530009pzb.12.1714000467703;
        Wed, 24 Apr 2024 16:14:27 -0700 (PDT)
Received: from amakhalov-build-vm.eng.vmware.com ([64.186.27.43])
        by smtp.gmail.com with ESMTPSA id n17-20020a170903111100b001e520495f51sm12383936plh.124.2024.04.24.16.14.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Apr 2024 16:14:27 -0700 (PDT)
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
Subject: [PATCH v9 1/8] x86/vmware: Correct macro names
Date: Wed, 24 Apr 2024 16:14:06 -0700
Message-Id: <20240424231407.14098-1-alexey.makhalov@broadcom.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <adcbfb9a-a4e1-4a32-b786-6c204d941e9f@broadcom.com>
References: <adcbfb9a-a4e1-4a32-b786-6c204d941e9f@broadcom.com>
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
 arch/x86/kernel/cpu/vmware.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/arch/x86/kernel/cpu/vmware.c b/arch/x86/kernel/cpu/vmware.c
index 11f83d07925e..f58c8d669bd3 100644
--- a/arch/x86/kernel/cpu/vmware.c
+++ b/arch/x86/kernel/cpu/vmware.c
@@ -49,10 +49,11 @@
 #define VMWARE_CMD_GETVERSION    10
 #define VMWARE_CMD_GETHZ         45
 #define VMWARE_CMD_GETVCPU_INFO  68
-#define VMWARE_CMD_LEGACY_X2APIC  3
-#define VMWARE_CMD_VCPU_RESERVED 31
 #define VMWARE_CMD_STEALCLOCK    91
 
+#define GETVCPU_INFO_LEGACY_X2APIC           BIT(3)
+#define GETVCPU_INFO_VCPU_RESERVED           BIT(31)
+
 #define STEALCLOCK_NOT_AVAILABLE (-1)
 #define STEALCLOCK_DISABLED        0
 #define STEALCLOCK_ENABLED         1
@@ -476,8 +477,8 @@ static bool __init vmware_legacy_x2apic_available(void)
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

