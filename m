Received: from mail-yw1-f177.google.com (mail-yw1-f177.google.com [209.85.128.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B02351586D5
	for <virtualization@lists.linux.dev>; Thu, 13 Jun 2024 19:17:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718306269; cv=none; b=KBWhP626lzYcEkRG2dvjlg4m/fxRXA9LFUIvBHI42ahDbmRQhKqwD4wdZhP+AnHPnbvN75kpeFr5Wc6/c4snbRlME+07slCvFhcqW47IpU/jRwlHzW/Nqsia43mflC1UsG6tGUP4rQ7SyE5bXad9QkuDDrjFKoupXCiCaOkD6SU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718306269; c=relaxed/simple;
	bh=Q/3uwJcP0awQ0cZ0zuOOajZzP1zhz0U9p5QjUO0IuwE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=tGvpmRpzIPvEG8IQtKV8Rjvf/yOxFY0mmGitdXMnflTWKU7aJFwJBFDcFRbbuC1zGXapWo9SDjWVwh1dJ0Eb0kdOymAvnexXJswEVuE+b4bf5abAggvzbrbTufFKlP1MnLewjvqyVdGREQ7VyxjBt2DGGetpUitpB+ORD+wnYzo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=Z810wp5U; arc=none smtp.client-ip=209.85.128.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="Z810wp5U"
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-6301aa3a89eso16335817b3.2
        for <virtualization@lists.linux.dev>; Thu, 13 Jun 2024 12:17:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1718306267; x=1718911067; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nvm0BsFAFI1cdP2yPyZHFfaL98AuxIoGBUiXiDXnc2A=;
        b=Z810wp5UveGJdrqUs5Y8/PdHangzBOPg2jmmznddTS+TGg9NhrBv5BF9pZHYogoOQW
         SadevF30x5ZfVLvceE1zI+Gd58k5UWt4oYnIHWfzWAZTlQ0kjyeuZN0DVKHZGKPvkBKD
         L0kZ6Oia35eCjg9h1QzgNWtNQH+rPM3a3rGMw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718306267; x=1718911067;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nvm0BsFAFI1cdP2yPyZHFfaL98AuxIoGBUiXiDXnc2A=;
        b=IDlHclAeaBj/HGicL59n003tdlmN8PQu7XeQTnF0jaEd2j1GMVZmyCPydjYcPPOJBY
         P5EtdkI456NgVbkKN/LmKaHQG16DejWVYR02e9Vo/9P46lG9BlurWy0Rmo4OJ1aWAVzj
         Y491+3lZiIAIgiHbJ2SjNIEHw/G/zijXTGH59tU1rqyue7QxryrQjH7Z76k7H48hlB8F
         1XkB2/ZXk0KUYDJvjF4jZ2JjQ5Wudu9mUFlz5rNjhoaI6dnXo/tWmbz3SnC/FeK7NSbB
         hWd3PjhdpSUEisZTb0z1igZdWbtW406yfxGR6aqZDYPofqN8FlVpS93F1AYX+R0xyakq
         mk1g==
X-Forwarded-Encrypted: i=1; AJvYcCVZ60T2j/zkVMo1s62yDW+SLUZ6qu3nkbw79cwbJBo7ewH0tDSrKxRJVGVF5t2eluQ3G3VU0aTjq1BqTknBtwwk2PH28pBp0C1INRhgWSU=
X-Gm-Message-State: AOJu0YyvDFwrulEgGeDrn9HzNrIkB59OFLbxAr0yxp+jtnHA2LV1NO+C
	BbqyM5lTX+6o6bNAtPNOzfKYD53ZpqTDu2WY5cFYOzHQ5ZKJxZiZ2ON23ygzcA==
X-Google-Smtp-Source: AGHT+IFE9wLsZ7ENC3mJ6qucAwCj2u4sQKXs6B3ZL4fkGGOEpeG9V3zFRYPhrCcwGDxwPGGrlz4D+Q==
X-Received: by 2002:a81:8d13:0:b0:62f:b04c:2442 with SMTP id 00721157ae682-63222070cafmr4181267b3.7.1718306266717;
        Thu, 13 Jun 2024 12:17:46 -0700 (PDT)
Received: from amakhalov-build-vm.eng.vmware.com ([192.19.161.250])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6b2a5eb47f6sm9714106d6.82.2024.06.13.12.17.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Jun 2024 12:17:46 -0700 (PDT)
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
Subject: [PATCH v11 7/8] x86/vmware: Remove legacy VMWARE_HYPERCALL* macros
Date: Thu, 13 Jun 2024 12:16:49 -0700
Message-Id: <20240613191650.9913-8-alexey.makhalov@broadcom.com>
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

No more direct use of these macros should be allowed.
vmware_hypercallX api still use new implementation of VMWARE_HYPERCALL
macro internally, but it is not exposed outside of the vmware.h.

Signed-off-by: Alexey Makhalov <alexey.makhalov@broadcom.com>
---
 arch/x86/include/asm/vmware.h | 26 --------------------------
 1 file changed, 26 deletions(-)

diff --git a/arch/x86/include/asm/vmware.h b/arch/x86/include/asm/vmware.h
index 724c8b9b4b8d..d83444f03969 100644
--- a/arch/x86/include/asm/vmware.h
+++ b/arch/x86/include/asm/vmware.h
@@ -279,30 +279,4 @@ unsigned long vmware_hypercall_hb_in(unsigned long cmd, unsigned long in2,
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
2.39.4

