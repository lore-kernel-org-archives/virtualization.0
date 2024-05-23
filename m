Received: from mail-qv1-f51.google.com (mail-qv1-f51.google.com [209.85.219.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E60E82892
	for <virtualization@lists.linux.dev>; Thu, 23 May 2024 19:15:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716491745; cv=none; b=VPa/Yn1VkO6IkWXTINJ3D9gKZf+m/2NSWRamLcP0VL5f3hW5z8Vgs/lFZXvohhFy2gKFn4YFgAFpCEBvum5mGutzUtOBfJ0I7ZNb17oarPu2yB/L/SlhyUAlhpcPCRF1RmoCI2ZZwUF4+YyCEmeZmAjlXU7FDR10YJWzX38NhQU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716491745; c=relaxed/simple;
	bh=M704MWHwyyg4r3sYtIOpDT3E8SyShb3NiouS2fvBgek=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=NbuzDdGPHN4FlfMo2KX9tdMaXEwyzXSsz48iH9I0BDu+ZX9yZ2zYr+P61oD7BF/WD/lM0Sq/bztbwbMya2bdw2GR7edpNIgI1VNNw+9v7PwhP42Rg3pL2WrwDSPhcP+G3TgjFOH8pi1PVh2iOYu4KdpUQbT/E7c6mVgGgwW1IsY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=aPH/BMiP; arc=none smtp.client-ip=209.85.219.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="aPH/BMiP"
Received: by mail-qv1-f51.google.com with SMTP id 6a1803df08f44-6aa93d19a25so20299676d6.3
        for <virtualization@lists.linux.dev>; Thu, 23 May 2024 12:15:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1716491743; x=1717096543; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4QGCJNvGWko8B9wup6iwCm4c9keuD69o33VzvSan8uM=;
        b=aPH/BMiPARRWYexuh3djeMWDz5Z/ofgRkuaIYBTE9zrLALjVSFLDGlK1GuWqo16l1T
         DyaA7FRgOZYlY97hQOG5XOuLL3m5KHlRHJCrxLh51mDGJlfwoJI9n6AKy6jSzAL32lzY
         LtDMICnX3J5yb9K1zE9QPNZKLB0u5ckLvF9Lg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716491743; x=1717096543;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4QGCJNvGWko8B9wup6iwCm4c9keuD69o33VzvSan8uM=;
        b=Si4TC4HSfID0l1Y2sz0Wig+bPTCQc/zoi6GeM4wuwlEGTZCQ9OP//J29N+8icmEZpE
         3Ojlg1RUvkL3yPLiQyrNGqaJxtfCcqUbTdOLj3dibXce7umPVCrGP0ErPcBIQWOFLyFs
         iFlW2Y4RAANwnGQJRoAw0L4t9xil44+emRVixXHBy7qhSeV2MwcjTqDI90eTes7I7bOG
         R5A/ArmezGT0qjeZd185p+JBV6qLZjuwknw64ArF1VcJhy6tn+oWiMQ1dSKdbApFjf3Y
         8dpMgrlfOnJeiaTCvr+ePpaViyRZYgDXHGJllVqU43IThg6e6oJGD+f8DVyAY6Q/ZGLY
         UmsA==
X-Forwarded-Encrypted: i=1; AJvYcCUC+zoWqxvchjQvmTIt1dXJO4wwMNh/xsJEIVTODdcjjqatl78kY6fq1na4wxbXMAxoeWKcSdSHA0jNx4CXkVzgfFsq2vmHjwHxv3lOCPU=
X-Gm-Message-State: AOJu0Yxu+OT4jgwzogIejgbNJF5oS76uP21nB+RJi7e7f9tZuiTj7yof
	yXwQnafd0UMjX5QHgQJot9LLnNWxrtBVFHdl2HsHcS3XAqj/q8J4mlOiez/G5g==
X-Google-Smtp-Source: AGHT+IGCAtfhhWo6Rlq59zoTSeJjZRf1YXbHOspqfLPOVEnivKrPPVuS9RVtKABc8sYtmtvtPHf0hQ==
X-Received: by 2002:a05:6214:4888:b0:6a0:cbeb:c5c0 with SMTP id 6a1803df08f44-6abcd0d7813mr50266d6.55.1716491743143;
        Thu, 23 May 2024 12:15:43 -0700 (PDT)
Received: from amakhalov-build-vm.eng.vmware.com ([192.19.161.250])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-43e4a89b61dsm21219821cf.45.2024.05.23.12.15.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 May 2024 12:15:42 -0700 (PDT)
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
Subject: [PATCH v10 7/8] x86/vmware: Remove legacy VMWARE_HYPERCALL* macros
Date: Thu, 23 May 2024 12:14:45 -0700
Message-Id: <20240523191446.54695-8-alexey.makhalov@broadcom.com>
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

No more direct use of these macros should be allowed.
vmware_hypercallX api still use new implementation of VMWARE_HYPERCALL
macro internally, but it is not exposed outside of the vmware.h.

Signed-off-by: Alexey Makhalov <alexey.makhalov@broadcom.com>
---
 arch/x86/include/asm/vmware.h | 26 --------------------------
 1 file changed, 26 deletions(-)

diff --git a/arch/x86/include/asm/vmware.h b/arch/x86/include/asm/vmware.h
index 5114f4c75c54..78567920b23f 100644
--- a/arch/x86/include/asm/vmware.h
+++ b/arch/x86/include/asm/vmware.h
@@ -274,30 +274,4 @@ unsigned long vmware_hypercall_hb_in(unsigned long cmd, unsigned long in2,
 #undef VMW_BP_CONSTRAINT
 #undef VMWARE_HYPERCALL
 
-/* The low bandwidth call. The low word of edx is presumed clear. */
-#define VMWARE_HYPERCALL						\
-	ALTERNATIVE_2("movw $" __stringify(VMWARE_HYPERVISOR_PORT) ", %%dx; " \
-		      "inl (%%dx), %%eax",				\
-		      "vmcall", X86_FEATURE_VMCALL,			\
-		      "vmmcall", X86_FEATURE_VMW_VMMCALL)
-
-/*
- * The high bandwidth out call. The low word of edx is presumed to have the
- * HB and OUT bits set.
- */
-#define VMWARE_HYPERCALL_HB_OUT						\
-	ALTERNATIVE_2("movw $" __stringify(VMWARE_HYPERVISOR_PORT_HB) ", %%dx; " \
-		      "rep outsb",					\
-		      "vmcall", X86_FEATURE_VMCALL,			\
-		      "vmmcall", X86_FEATURE_VMW_VMMCALL)
-
-/*
- * The high bandwidth in call. The low word of edx is presumed to have the
- * HB bit set.
- */
-#define VMWARE_HYPERCALL_HB_IN						\
-	ALTERNATIVE_2("movw $" __stringify(VMWARE_HYPERVISOR_PORT_HB) ", %%dx; " \
-		      "rep insb",					\
-		      "vmcall", X86_FEATURE_VMCALL,			\
-		      "vmmcall", X86_FEATURE_VMW_VMMCALL)
 #endif
-- 
2.39.0

