Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 018D62AC17
	for <virtualization@lists.linux.dev>; Thu, 13 Mar 2025 17:31:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741887107; cv=none; b=UolD0BYXKcREPscGYcxQYApfEFC2erQUhyjEAS6AnHNpyP0LbC1em/VoDOsYKIgs5mI/uAyNNBtuVSgagPvIC1xjZNXSJ3NALMll+nlciuSmxKalEu5O2pIBOHJ9lGYziI+ZITfoY5l1U5MP/xlt+FxjAX4mOMojpEM5SVz01js=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741887107; c=relaxed/simple;
	bh=yfW1gIa1MbRIx3vJ4nkUHmJnpytrI2/a0Qk/PMxYlCI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=kbRD37FileTuH8kyBZzUbJ8CVeC0Z9Tr/n5VkZtC6Zg4Iom3K6CgFBL/XIOlmm2vJAEJDzBi4/iQ3D+6hdZWnfOJ5wUbgqzeoC66XaEqJa6lYptSD0/x2WWLT01kh2iQS7Bhzr/npQPe230HdCQQYwkn/e1tNsQfHc3pGw4KPt0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=IL06jyZD; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="IL06jyZD"
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-22334203781so45886455ad.0
        for <virtualization@lists.linux.dev>; Thu, 13 Mar 2025 10:31:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1741887101; x=1742491901; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ggMXVBojLEYrYjpK3rBBG/mb1zKKBgNArl4a0+lTQ20=;
        b=IL06jyZDmE+VargFkFDYuTIDquUzRw+UyxIcehvlF2fVgrz43bBc9C1fsDeCdB5uLn
         gH7IkmARZfXBuIttGrO2gfHW3coGGhl5MksxEOLiCCB3o+dUlwyaKM9kayP+r6dsHizS
         HwzHd8d/yjsJjiQJkAMUJP3FRtluv41utFWYk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741887101; x=1742491901;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ggMXVBojLEYrYjpK3rBBG/mb1zKKBgNArl4a0+lTQ20=;
        b=b/mQIyBkV98DTqFzMwNSQKLWAtA8mNHo7HLB1AoeT6x+hkgv+QQKi3aQHCLJcTria2
         5z59bD6W50AcFMLpKPfULB9lHjmI1zXTlubZLifIVHodt9NKiUT9CKF/XygqI9q6GFnY
         O+ArgCcDfUkSoWALepIacESptA7HAHmmuYczsz4V4TUlSsyv0rwi+HQV7erS0wjfw90x
         yISqcD/Nkub98CUShTOje1W8tQYFsj/S3NFHsemYFa8+Ok36Jo4bfTxqr4AwkG702IfI
         OTJklJUps4iVdn5pMgWaoDQgr49VMRrYJCAfRB9mTAzm/rDOfNEFrMfepOIuk7DlwF7i
         pGHg==
X-Forwarded-Encrypted: i=1; AJvYcCV9AvwQrzz36wY5uAa6rfWhcEg77J8Xntnwkw38L4i1FMbGr0NM29n2PXUSY6iwvjx8o9XJtVLco2xrcCVekA==@lists.linux.dev
X-Gm-Message-State: AOJu0YzpHi4/OitPSbYKcSB9ZivMiv/Xs3y2WP/r5kzTRWNmLeX7GiW2
	PHXsFbk7GatDj6Ra3v16hAOWOtupogWdXuHuDQ/opQlJu1rWBpPW/2/g1ybM6Q==
X-Gm-Gg: ASbGncvuDycR8j160fbKWKR5rpKKNHnCKFNfceVOEsRk5+FEuj+MTWiBWZObL3NWCG4
	7lPrYHNgnMIkHbgg2YRh8X3SKb7GbUImgdQsVWh2SmBVKup2+FIwcQwcW2LD1Y37xxou/BIO1xu
	TuItVekagWGTRcgSPfA1BPiNHpAVUUWjwX4u3aBtt+Ry4628+23oMY09LYQErRAfrm0QRA5jPd9
	6pNVwGvUoHusPKE5X8HtEso/y4YvGAQLB8pWr+1fc1yHuAueBci6fNJz52oC0Q+eChBpXZoNiEw
	TUwIwN7+BfuPrE1mKwTHt0jCjYiGYnoFctldhFoSA8B1tyW2qohDdkKHmxE7vjtpJPnwpwmZzw=
	=
X-Google-Smtp-Source: AGHT+IHTh9DQK18PXTqgsKvgHuC0vEOJvBIRPhsGggDCXl4nz4ApyCfoHStC5pwpS2+3w/OHm4FWkQ==
X-Received: by 2002:a05:6a00:844:b0:725:41c4:dbc7 with SMTP id d2e1a72fcca58-737107120d6mr4984412b3a.4.1741887101113;
        Thu, 13 Mar 2025 10:31:41 -0700 (PDT)
Received: from photon-dev.. ([192.19.161.250])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7371167d89asm1646471b3a.94.2025.03.13.10.31.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Mar 2025 10:31:40 -0700 (PDT)
From: Ajay Kaher <ajay.kaher@broadcom.com>
To: bp@alien8.de,
	thomas.lendacky@amd.com
Cc: ajay.kaher@broadcom.com,
	alexey.makhalov@broadcom.com,
	bcm-kernel-feedback-list@broadcom.com,
	bo.gan@broadcom.com,
	dave.hansen@linux.intel.com,
	florian.fainelli@broadcom.com,
	hpa@zytor.com,
	kevinloughlin@google.com,
	linux-kernel@vger.kernel.org,
	mingo@redhat.com,
	tglx@linutronix.de,
	vamsi-krishna.brahmajosyula@broadcom.com,
	vasavi.sirnapalli@broadcom.com,
	virtualization@lists.linux.dev,
	x86@kernel.org,
	ye.li@broadcom.com
Subject: [PATCH v2] sev-snp: parse MP tables for VMware hypervisor
Date: Thu, 13 Mar 2025 17:31:11 +0000
Message-Id: <20250313173111.10918-1-ajay.kaher@broadcom.com>
X-Mailer: git-send-email 2.39.4
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

For VMware hypervisor, SEV-SNP enabled VM's could boot without UEFI.
In this case, mpparse_find_mptable() has to be called to parse MP
tables which contains boot information.

Fixes: 0f4a1e80989a ("x86/sev: Skip ROM range scans and validation for SEV-SNP guests")
Co-developed-by: Ye Li <ye.li@broadcom.com>
Signed-off-by: Ye Li <ye.li@broadcom.com>
Signed-off-by: Ajay Kaher <ajay.kaher@broadcom.com>
Tested-by: Ye Li <ye.li@broadcom.com>
Reviewed-by: Kevin Loughlin <kevinloughlin@google.com>
---
Changes since v1:
https://lore.kernel.org/lkml/20241219114400.858980-1-ajay.kaher@broadcom.com/
        - use cc_platform_has(CC_ATTR_GUEST_SEV_SNP) instead of
          (sev_status & MSR_AMD64_SEV_SNP_ENABLED)
	- remove unwanted header files
---
 arch/x86/kernel/cpu/vmware.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/x86/kernel/cpu/vmware.c b/arch/x86/kernel/cpu/vmware.c
index 00189cdeb..cb3f900c4 100644
--- a/arch/x86/kernel/cpu/vmware.c
+++ b/arch/x86/kernel/cpu/vmware.c
@@ -26,6 +26,7 @@
 #include <linux/export.h>
 #include <linux/clocksource.h>
 #include <linux/cpu.h>
+#include <linux/efi.h>
 #include <linux/reboot.h>
 #include <linux/static_call.h>
 #include <asm/div64.h>
@@ -429,6 +430,9 @@ static void __init vmware_platform_setup(void)
 		pr_warn("Failed to get TSC freq from the hypervisor\n");
 	}
 
+	if (cc_platform_has(CC_ATTR_GUEST_SEV_SNP) && !efi_enabled(EFI_BOOT))
+		x86_init.mpparse.find_mptable = mpparse_find_mptable;
+
 	vmware_paravirt_ops_setup();
 
 #ifdef CONFIG_X86_IO_APIC
-- 
2.39.4

