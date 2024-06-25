Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9564F146D7C
	for <virtualization@lists.linux.dev>; Tue, 25 Jun 2024 08:34:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719304454; cv=none; b=LLd1V4KhyA5+y1zH+6LRGB7hgXwXZU8R2BSf5xcRJkgWkN/O/BdGBWMjWOzV0TV1UAoiVgfE34LFIdVDt2w7CQ0fxfkctJCjxgF1Ttq3MPE+Cpw8X98+9dZYV+LjXpS3lHQfXXHa7tWo2Bauo0lR+TZEI6PMyaj7jK+kzjSZGEw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719304454; c=relaxed/simple;
	bh=L65BVw1IfGXIpPCpLltvH1Pr3HFst845zg0oA4nj5mc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=dRb4ULXj8hYd941u+UeMtBxktT9c8XRIvlBkh3EPa4usoHWFELHb1CpE7a35HKSNgoEs2UgbnqyroHo0rtn9lSuQPXPmff4+s7IcyIgsV5mfalAW6ORbfQI2XYw56O3aiyR+qD4BCGWg55X/yH9D4K4AxWbouF3G/kcuVcpe0Mc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=H+gnRdpF; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="H+gnRdpF"
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-1f6a837e9a3so32247855ad.1
        for <virtualization@lists.linux.dev>; Tue, 25 Jun 2024 01:34:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1719304452; x=1719909252; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=LaZTDIj+9Ci38w0UviyVOkLNbmq1P63k6Hrc4PEaBIQ=;
        b=H+gnRdpFrJC87qFfLKNiqJbwNHE2nUTaa2GYGllGDQtQ4xLY29ys+pMuq++2+N6q26
         AEYT3bRI1Wlo2yUNr4r18N3iNxBv4FY7QYoa5ea3XItiv25m4D9pei/R9ZXDwOL3BVFG
         faW42Cd+TedeJLC/s0zu98o1lYvFJZ1COy32g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719304452; x=1719909252;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LaZTDIj+9Ci38w0UviyVOkLNbmq1P63k6Hrc4PEaBIQ=;
        b=CXKTJTHoX8Ru+ND0dKxnJ/tHfANLZcIJKfG1EwC0ipduGtzfJABBOwVsxjetMPtlDO
         op0xTqonDbwPuMeOPuknRoARcoOAkGQS9rWEv43dbKHrr+mG4UUp7PpbgdfV17BmtYoy
         DmIpTqvJLnv7heYoqt8YumX2Ez9DhZJNudqWLKcFd0lka1uqfXwAXMRaU+xIYmBXl5JK
         aoPpf3LInXDyOGiXzoWD8U+PCiBIIhoZDGjQMRwIbXiEASTF8520BHA1GdEfy3CUkJKT
         65/V0f1oMW5KsSSe6OKzwjOZWzszjhv76KhNMfzNMXdnV8pGuYnVOCutGTWv4aCYorI7
         CDlg==
X-Forwarded-Encrypted: i=1; AJvYcCV6Xd6G4yShfaS/QRGouv8U/0/GbdoU1wmrm2Dy56nb8Z5vcLpyeUoENmnmI8DvaLaAjq4eTnBAQiQQY027ZeL5VZ/+J97TMuU3ui+jRoE=
X-Gm-Message-State: AOJu0YwBJiAe7+dURr6B7zNBn/mMSQYJYOk9+w27h8W+/iofLFIjj5vr
	L53D+d5z/a89P9/g40RcpFsET9XnqGdQDGQlLAa5VYnhtQeb3gdiyEVnQiiN8g==
X-Google-Smtp-Source: AGHT+IFvtgAjlj7uBPVh9T4VXCJSxzqqWolw/cxJnogKrJancnYPlW73KylsMYsJMzjjVEBypTPkHA==
X-Received: by 2002:a17:903:234f:b0:1fa:3428:53ba with SMTP id d9443c01a7336-1fa34285bb8mr71977385ad.64.1719304451837;
        Tue, 25 Jun 2024 01:34:11 -0700 (PDT)
Received: from amakhalov-build-vm.eng.vmware.com ([192.19.161.250])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f9eb2f027fsm75937105ad.6.2024.06.25.01.34.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Jun 2024 01:34:11 -0700 (PDT)
From: Alexey Makhalov <alexey.makhalov@broadcom.com>
To: linux-kernel@vger.kernel.org,
	virtualization@lists.linux.dev,
	bp@alien8.de,
	hpa@zytor.com,
	dave.hansen@linux.intel.com,
	mingo@redhat.com,
	tglx@linutronix.de
Cc: x86@kernel.org,
	ajay.kaher@broadcom.com,
	bcm-kernel-feedback-list@broadcom.com,
	Alexey Makhalov <alexey.makhalov@broadcom.com>,
	Alex James <alex.james@broadcom.com>
Subject: [PATCH] x86/vmware: fix panic in vmware_hypercall_slow()
Date: Tue, 25 Jun 2024 01:33:48 -0700
Message-Id: <20240625083348.2299-1-alexey.makhalov@broadcom.com>
X-Mailer: git-send-email 2.39.4
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Caller of vmware_hypercall_slow() can pass NULL into *out1,
*out2,... *out5. It will lead to a NULL pointer dereference.

Check a pointer for NULL before assigning a value.

Fixes: 	666cbb562d05d ("x86/vmware: Introduce VMware hypercall API")
Co-developed-by: Alex James <alex.james@broadcom.com>
Signed-off-by: Alex James <alex.james@broadcom.com>
Signed-off-by: Alexey Makhalov <alexey.makhalov@broadcom.com>
---
 arch/x86/kernel/cpu/vmware.c | 26 +++++++++++++++++++-------
 1 file changed, 19 insertions(+), 7 deletions(-)

diff --git a/arch/x86/kernel/cpu/vmware.c b/arch/x86/kernel/cpu/vmware.c
index 55903563afd3..16da970499f2 100644
--- a/arch/x86/kernel/cpu/vmware.c
+++ b/arch/x86/kernel/cpu/vmware.c
@@ -72,13 +72,13 @@ unsigned long vmware_hypercall_slow(unsigned long cmd,
 				    u32 *out1, u32 *out2, u32 *out3,
 				    u32 *out4, u32 *out5)
 {
-	unsigned long out0;
+	unsigned long out0, rbx, rcx, rdx, rsi, rdi;
 
 	switch (vmware_hypercall_mode) {
 	case CPUID_VMWARE_FEATURES_ECX_VMCALL:
 		asm_inline volatile ("vmcall"
-				: "=a" (out0), "=b" (*out1), "=c" (*out2),
-				"=d" (*out3), "=S" (*out4), "=D" (*out5)
+				: "=a" (out0), "=b" (rbx), "=c" (rcx),
+				"=d" (rdx), "=S" (rsi), "=D" (rdi)
 				: "a" (VMWARE_HYPERVISOR_MAGIC),
 				"b" (in1),
 				"c" (cmd),
@@ -89,8 +89,8 @@ unsigned long vmware_hypercall_slow(unsigned long cmd,
 		break;
 	case CPUID_VMWARE_FEATURES_ECX_VMMCALL:
 		asm_inline volatile ("vmmcall"
-				: "=a" (out0), "=b" (*out1), "=c" (*out2),
-				"=d" (*out3), "=S" (*out4), "=D" (*out5)
+				: "=a" (out0), "=b" (rbx), "=c" (rcx),
+				"=d" (rdx), "=S" (rsi), "=D" (rdi)
 				: "a" (VMWARE_HYPERVISOR_MAGIC),
 				"b" (in1),
 				"c" (cmd),
@@ -101,8 +101,8 @@ unsigned long vmware_hypercall_slow(unsigned long cmd,
 		break;
 	default:
 		asm_inline volatile ("movw %[port], %%dx; inl (%%dx), %%eax"
-				: "=a" (out0), "=b" (*out1), "=c" (*out2),
-				"=d" (*out3), "=S" (*out4), "=D" (*out5)
+				: "=a" (out0), "=b" (rbx), "=c" (rcx),
+				"=d" (rdx), "=S" (rsi), "=D" (rdi)
 				: [port] "i" (VMWARE_HYPERVISOR_PORT),
 				"a" (VMWARE_HYPERVISOR_MAGIC),
 				"b" (in1),
@@ -113,6 +113,18 @@ unsigned long vmware_hypercall_slow(unsigned long cmd,
 				: "cc", "memory");
 		break;
 	}
+
+	if (out1)
+		*out1 = rbx;
+	if (out2)
+		*out2 = rcx;
+	if (out3)
+		*out3 = rdx;
+	if (out4)
+		*out4 = rsi;
+	if (out5)
+		*out5 = rdi;
+
 	return out0;
 }
 
-- 
2.39.4

