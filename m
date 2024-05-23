Received: from mail-qk1-f177.google.com (mail-qk1-f177.google.com [209.85.222.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97EFE84FCF
	for <virtualization@lists.linux.dev>; Thu, 23 May 2024 19:15:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716491740; cv=none; b=suaCnqt01nIoSMyRLuBjx7syPwQ/nnKeSsjvyDDBKR3g3QybS2p0D+wszDngLaiU9sXr8xxdTiRN5xQDRHgUdzTEyB8jUoWWwkZHeSM34Bp7pxqMQj1PKLK0PKgUOc9pQW+pf4Mq9/Syb6qFLn9EYm8GiGm7/Q872IUBLxcM5Dg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716491740; c=relaxed/simple;
	bh=cwPi0cwLaudKiJrBxIwug/LIGv5XW3nEwzrdc3S5Ovs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=F8Cq3PgPcyfQz2E0NsXjoSxr/4xG75bnkmnGWeVItpbR89vE846B+9CpfYAhQEiaYz1P20mSS67dt/RknKGohqAQ89JnWePxZCR35TRVsR3y8HZr9KEaKZCdOgwnxPOxo7CFyDlwT8zuecvkq1wbkrQ6+sh3BtF39aSDtmlkwps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=NN54n4Rf; arc=none smtp.client-ip=209.85.222.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="NN54n4Rf"
Received: by mail-qk1-f177.google.com with SMTP id af79cd13be357-7930504b2e2so150233985a.3
        for <virtualization@lists.linux.dev>; Thu, 23 May 2024 12:15:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1716491738; x=1717096538; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KZPMIYqCPOQ9lUONW9JG6SX+420+rT4m9cGMXu5m3VI=;
        b=NN54n4Rfh2+I//sy9HZkXJ7pfvPRXExjQjt1R86c6eCepvj5b98sEwLQVu3leXNnQK
         aoi03bIYwdDUwjgKZUdxteVngmSgMePPS/NPIwMGicY8LF4V19JCmK7FP8ew7bdcPoF+
         l+RMy4c3f5y8HXGvgxeWruqCYxhCYTd5xemMM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716491738; x=1717096538;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KZPMIYqCPOQ9lUONW9JG6SX+420+rT4m9cGMXu5m3VI=;
        b=v+SYX3pO0b3UDKcNgNSfpZssDCjFQ/PNj1dKQTBjQnxrr2G03C57wVmqI3aeWZPtcR
         RfNdim3t0qiDJIhcbCz9ml3zWVjPyQKwCrd14aMdb1gdJesP8acGkxpHUE2aVzQLcnLI
         KCeumYMpSJhGlyODRnr45XcudsMcAGV6mWiEi9NM939H2sc68Li0Nw8oRJx02chzCWFZ
         ePItITgtChe2fsbGL22otiQejG5VGVHeTMZHwYlLJZb3l3HthaOjXXUVdiev9V5dkU1D
         7yL+HeRKvyCkcUm37MQkbeVmJAGVNKnlhkZfu+nMMxXiVi5ApMOzllEBmQH/7b+u1Hvt
         706g==
X-Forwarded-Encrypted: i=1; AJvYcCVeDr5LfUsveGj8tJ3/0bMhJFqsR3B+ioNqncE/Uv2ibHqjewRll379lf+jbLhyj9RJu409ZDYGijmGQbMx0iSeh9c32r/p/iU7xizkeaE=
X-Gm-Message-State: AOJu0YzHJN3FTZuGmh1KVTKW7fjK4iSotuu82KdDsz2sVqSLjECI+oUh
	sjHrsuV6VPLzc6Ri1bVLCBwr1wadD/l1QU4rKLzXswtFWuHj95zuySaAk3Op+w9jOizX1jM7Bnw
	=
X-Google-Smtp-Source: AGHT+IG2JzfPFZy3xWsQUnDD6DVaCv75DpVNO+T61rq9vujIHdvBjciczesgyKtATQ7tmpk6hsg4FQ==
X-Received: by 2002:a05:620a:5608:b0:792:9d32:d37f with SMTP id af79cd13be357-794aaf8eeccmr19545485a.0.1716491737788;
        Thu, 23 May 2024 12:15:37 -0700 (PDT)
Received: from amakhalov-build-vm.eng.vmware.com ([192.19.161.250])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-43e4a89b61dsm21219821cf.45.2024.05.23.12.15.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 May 2024 12:15:37 -0700 (PDT)
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
Subject: [PATCH v10 6/8] x86/vmware: Correct macro names
Date: Thu, 23 May 2024 12:14:44 -0700
Message-Id: <20240523191446.54695-7-alexey.makhalov@broadcom.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20240523191446.54695-1-alexey.makhalov@broadcom.com>
References: <20240523191446.54695-1-alexey.makhalov@broadcom.com>
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
index 6796425eaaa1..58442c2581e7 100644
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
@@ -424,8 +424,8 @@ static bool __init vmware_legacy_x2apic_available(void)
 	u32 eax;
 
 	eax = vmware_hypercall1(VMWARE_CMD_GETVCPU_INFO, 0);
-	return !(eax & BIT(VMWARE_CMD_VCPU_RESERVED)) &&
-		(eax & BIT(VMWARE_CMD_LEGACY_X2APIC));
+	return !(eax & GETVCPU_INFO_VCPU_RESERVED) &&
+		(eax & GETVCPU_INFO_LEGACY_X2APIC);
 }
 
 #ifdef CONFIG_AMD_MEM_ENCRYPT
-- 
2.39.0

