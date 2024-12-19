Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F56D223E64
	for <virtualization@lists.linux.dev>; Thu, 19 Dec 2024 11:44:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734608678; cv=none; b=VcQaVNPTxS/+3U7LDvTngAEVRu3EmbpSzaC+vxxPe+sNK8iR6gH6vj8V1WnSeojga6bFOKXWMOFs7P9Fkpe92O3EXux7rX058WgXqoYxbm6McGAhQWqvawZ0Lj2vSfpdbGfM2gW1K4nEUjfbbn7OOoYx8A0Hhp+RlHTGvxNj+x8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734608678; c=relaxed/simple;
	bh=e2OcAuG9sIbdzf27FIeuULgjmj5hqQGmRqePR5SUDt4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=P4JE1FBGQbBzS/GJjAhQ00lXYYn2n7n/VoG1y9UQmiW0p/gR+urMXft/uIUwf4Eip7QC2osMOAItvCQTxz+d2iDIAw6kX5B0kLPVzDAikxuzaQCkrUk+vDTB3a8Bn6CRVWKOgm+TIzeYcoALGf0MYnf2GKpHShaPoP4AvQy4R+Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=Q6Vw4ZjB; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="Q6Vw4ZjB"
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-21683192bf9so6622515ad.3
        for <virtualization@lists.linux.dev>; Thu, 19 Dec 2024 03:44:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1734608676; x=1735213476; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=DLkdsF0sdcfDlAKnYPRnqVa0E+ymIUm5yMYfCRJfz/w=;
        b=Q6Vw4ZjBOtUYTZ++1NZZrLogaNTi//CejKno9mVfXvjo3dDkxi3mtDwT3Z1VfYrtvH
         1kTRGGLQUcfpYAjpwlaToAWzclSZkknxN7Y/GqseBeKGysE3UtFnM9aIn48dvqs2lvJw
         q0ZS2kMdvQGS8Wl5zcsy9ZbxYDo+65jWwvUdg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734608676; x=1735213476;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DLkdsF0sdcfDlAKnYPRnqVa0E+ymIUm5yMYfCRJfz/w=;
        b=EuQdlvsYSVrURpGsnhaOvHFT1v369WOh4JR98uKKC/9RDgabCLPEtVKPIihIcLJSYA
         kJBRIo5c0vCLwcCc6EaWzKI2Gv/IGMphFFZ8ykkU+T2BNIcPN5ABz+25iW9ztdqiM9da
         4GX0E1gAphs/WkOrQWJLXBL29KNbmJs2LpjhpNymr26dyHtcjLx4LSCC9GnEfjmibG/8
         looz14Ebsvoz980ZZYbo1io6hDGI3ElxYT72APbR9uVUhq89FCQUz+ZJqi4bssLDoxZj
         T+lUTmaGguQB5Fpbyh1vl4pYGGG9QQws9yUuJ0THZTAVgAlZnvlsy/02VX2eHluhgjmi
         /REQ==
X-Forwarded-Encrypted: i=1; AJvYcCVkO4T3/lkdO9o5CVdk1wdx6b8cQsEA8suKJe9VJt9pu6VW1WRQtJG/ge2I7lAQ9WpgT4AUzxHoSR3BEfhCvg==@lists.linux.dev
X-Gm-Message-State: AOJu0YyLJbRQr6ou4hzAN+5Gmz6m2IBUnlrgrBKo2xjbTnL7e1j7hGJb
	KHbHJPlY4J7LJZwJ42Ir4T5+unPLEthUZTbbeBcefUU2a1rYNwcIeVXjbSoEhQ==
X-Gm-Gg: ASbGnctJvxkdgRv/vVUuCKsvv8vBnwQrKa8CkXeItj3YE4ZCqGCIE1FWDHhC1w2cvie
	2gTBv7+TdN30zurcl5cELEg78LV57O1ZnkACr7cGgJSN2yxC8XSbQ6g0mWiadmvgIFtMB4wfczh
	zUoKvyED3l4n/CwrlFkhpskEo4G5Wu+VeLN/yFsivAWYwLMVtG/cRftmNndw7mabWNlTCoTKCjm
	1Uv0fW5+RoM/a2eafspDAtqucZrFMN9ZEuqZN6FpeWRVfgSy5iycCEsStSAxkk7emlwyvOMbrHE
	TygEKp5beg==
X-Google-Smtp-Source: AGHT+IGMsqpQuZD2TiNxGF/tEAFnLCvWSCRJh/qZ0nob0DXUeZoTTk4t6zkDU9AaAiUzyHQxfUmtXA==
X-Received: by 2002:a17:902:eccf:b0:216:32c4:f7f5 with SMTP id d9443c01a7336-218d70e524bmr81260355ad.19.1734608676407;
        Thu, 19 Dec 2024 03:44:36 -0800 (PST)
Received: from photon-dev.. ([192.19.161.250])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-219dc9cde19sm10543325ad.167.2024.12.19.03.44.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Dec 2024 03:44:35 -0800 (PST)
From: Ajay Kaher <ajay.kaher@broadcom.com>
To: kevinloughlin@google.com,
	bp@alien8.de
Cc: bcm-kernel-feedback-list@broadcom.com,
	tglx@linutronix.de,
	mingo@redhat.com,
	dave.hansen@linux.intel.com,
	x86@kernel.org,
	hpa@zytor.com,
	virtualization@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	ajay.kaher@broadcom.com,
	ye.li@broadcom.com,
	bo.gan@broadcom.com,
	vamsi-krishna.brahmajosyula@broadcom.com,
	alexey.makhalov@broadcom.com,
	vasavi.sirnapalli@broadcom.com,
	florian.fainelli@broadcom.com
Subject: [PATCH] sev-snp: parse MP tables for VMware hypervisor
Date: Thu, 19 Dec 2024 11:44:00 +0000
Message-Id: <20241219114400.858980-1-ajay.kaher@broadcom.com>
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
Signed-off-by: Ajay Kaher <ajay.kaher@broadcom.com>
Signed-off-by: Ye Li <ye.li@broadcom.com>
Tested-by: Ye Li <ye.li@broadcom.com>
---
 arch/x86/kernel/cpu/vmware.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/x86/kernel/cpu/vmware.c b/arch/x86/kernel/cpu/vmware.c
index 00189cd..3e2594d 100644
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
@@ -35,6 +36,8 @@
 #include <asm/apic.h>
 #include <asm/vmware.h>
 #include <asm/svm.h>
+#include <asm/mem_encrypt.h>
+#include <asm/efi.h>
 
 #undef pr_fmt
 #define pr_fmt(fmt)	"vmware: " fmt
@@ -429,6 +432,10 @@ static void __init vmware_platform_setup(void)
 		pr_warn("Failed to get TSC freq from the hypervisor\n");
 	}
 
+	if (sev_status & MSR_AMD64_SEV_SNP_ENABLED &&
+	    !efi_enabled(EFI_BOOT))
+		x86_init.mpparse.find_mptable = mpparse_find_mptable;
+
 	vmware_paravirt_ops_setup();
 
 #ifdef CONFIG_X86_IO_APIC
-- 
2.39.4

