Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0A5A3F4DC0
	for <virtualization@lists.linux.dev>; Fri, 29 May 2026 14:45:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780065905; cv=none; b=Br7oFHnnRBN9MwwijSK1EB7O6CHXm8MZIHlruRc7TrTrugCf3yoPDOyY0TXEuHTGy8362TGpwGpWMWAaLyjSfoknAsrrkuhB7IRXdbWgDkzwgWYMII1vdCXbH+CCkQEBliatXNh+Zd4iPURWCu/AJcDMKaXPB5G9GggkHQCb/is=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780065905; c=relaxed/simple;
	bh=eotALkKBLw2yWarXNKTm3nPmBYb4JWK2U7pCUvm8B4E=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=rW+aX4Vr3Lfr9qohAS9fn3308S1RLtpGJ1WrLQDQhaqF/TaVR0IGcpzOxzGU/rar5WJ4NklarCwsgjuNZPMvu0K4VFOOJQuin4UfY/9tWn3bQbkBFX2Rd7T0ReYHghi5j5CZ7zcpgo5iQUuus7CPe9rNF3WT0W93Blwn3LKzfGc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=mX52cosl; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="mX52cosl"
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-2beb9002a00so68689575ad.0
        for <virtualization@lists.linux.dev>; Fri, 29 May 2026 07:45:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780065902; x=1780670702; darn=lists.linux.dev;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=Cv3iY8yWhIG9MApRDLOLL6ifa8DISlk6XR/KWuM4GwE=;
        b=mX52coslHlHOek1ZAuEFqw/YSbcDCl6h8egTRk4/XLl3oQ1tdgTM0jODgK2YHjF41W
         EMPvXzEDhXAs18N7UBcryphqC6QJkXOVh3YCzm/7ybzJt92bMm8HhsWgFdMQbakme2qg
         EUy2qkzfhcf/XaQw3R5Uc147ANQ1Y79i31Tp/nFP5y+U5DgfT2qacBzQn5744SdPR6Lm
         nHfGJzPes4Zf1+mJwiLtP/UgSDudL/EQc3rtGLIg5lqQP2s9rrG9XpHQLld9XFrDvmW6
         dLufb1hNy+CYdAP8INrK8+Z/w7E/ue+EPYiiOgUVtBckd2g3brTFsoAH+LFIX3+xFOU7
         eKfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780065902; x=1780670702;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Cv3iY8yWhIG9MApRDLOLL6ifa8DISlk6XR/KWuM4GwE=;
        b=iSlsj5qb0Zln7HYhUBzFyKahPFu9oz11DHt+FQV1+G7pdotJUDKAdqYDg/U/DvcjJg
         3c3R1tul2sz4ew3eISYhZ9Xts9Wa75Sq34enENJiTMl1YXxEtCRYrGkSlmVlln8l4DX+
         sPK9J21p034fFdeZpxbHkx/i6mEdu4R5cPDSNB0QLbuMLSz4tuQE70rYjXUQhOGWbqRm
         vhHJZOOgiSmGBEMQoWLepz4ALbupabgUIhhAnXeytZLboBV3rP0tBBTkaInIHDjpchXX
         xw0+VztL1nehBikoMypwm2yV2DrupdBp8lBgllrHSQXtVv47MeplS1q9NoEYpYbBlxtQ
         dKQw==
X-Forwarded-Encrypted: i=1; AFNElJ8g7y5glaEMdGftpoltVovFj3xy2HxEY+9n/zSL7t3SaT9ApadpueBqDWov+xHA7uW+KKKsuoWlz4kdOfXmkA==@lists.linux.dev
X-Gm-Message-State: AOJu0YxHjeTDMATTCOYAYLSHxjI2xxBL3D3F5X4MyUisSHxSBCUSSWtA
	FwM06Wbm8pG3mFvm8MlwCSKVs6lCRyfGxZD//eoybUE1QmO3Ca9iJyBb2ssX6H/sfnZwGjpXpyg
	Z6ggxPg==
X-Received: from plem4.prod.google.com ([2002:a17:902:e404:b0:2bc:f203:12a1])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:1983:b0:2bf:23ad:8595
 with SMTP id d9443c01a7336-2bf367b260amr1523355ad.4.1780065902031; Fri, 29
 May 2026 07:45:02 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Fri, 29 May 2026 07:43:56 -0700
In-Reply-To: <20260529144435.704127-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20260529144435.704127-1-seanjc@google.com>
X-Mailer: git-send-email 2.54.0.823.g6e5bcc1fc9-goog
Message-ID: <20260529144435.704127-10-seanjc@google.com>
Subject: [PATCH v4 09/47] x86/acrn: Mark TSC frequency as known when using
 ACRN for calibration
From: Sean Christopherson <seanjc@google.com>
To: Paolo Bonzini <pbonzini@redhat.com>, Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, 
	Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	Kiryl Shutsemau <kas@kernel.org>, Sean Christopherson <seanjc@google.com>, 
	"K. Y. Srinivasan" <kys@microsoft.com>, Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>, 
	Dexuan Cui <decui@microsoft.com>, Long Li <longli@microsoft.com>, 
	Ajay Kaher <ajay.kaher@broadcom.com>, Alexey Makhalov <alexey.makhalov@broadcom.com>, 
	Jan Kiszka <jan.kiszka@siemens.com>, Andy Lutomirski <luto@kernel.org>, 
	Peter Zijlstra <peterz@infradead.org>, Juergen Gross <jgross@suse.com>, 
	Daniel Lezcano <daniel.lezcano@kernel.org>, John Stultz <jstultz@google.com>
Cc: "H. Peter Anvin" <hpa@zytor.com>, Rick Edgecombe <rick.p.edgecombe@intel.com>, 
	Vitaly Kuznetsov <vkuznets@redhat.com>, 
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, 
	Boris Ostrovsky <boris.ostrovsky@oracle.com>, Stephen Boyd <sboyd@kernel.org>, kvm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-coco@lists.linux.dev, 
	linux-hyperv@vger.kernel.org, virtualization@lists.linux.dev, 
	xen-devel@lists.xenproject.org, David Woodhouse <dwmw@amazon.co.uk>, 
	Tom Lendacky <thomas.lendacky@amd.com>, Nikunj A Dadhania <nikunj@amd.com>, 
	David Woodhouse <dwmw2@infradead.org>, Michael Kelley <mhklinux@outlook.com>, 
	Thomas Gleixner <tglx@linutronix.de>
Content-Type: text/plain; charset="UTF-8"

Mark the TSC frequency as known when using ACRN's PV CPUID information.
Per commit 81a71f51b89e ("x86/acrn: Set up timekeeping") and common sense,
the TSC freq is explicitly provided by the hypervisor.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kernel/cpu/acrn.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/x86/kernel/cpu/acrn.c b/arch/x86/kernel/cpu/acrn.c
index ad8f2da8003b..0303fe6a2efa 100644
--- a/arch/x86/kernel/cpu/acrn.c
+++ b/arch/x86/kernel/cpu/acrn.c
@@ -33,6 +33,8 @@ static void __init acrn_init_platform(void)
 {
 	/* Install system interrupt handler for ACRN hypervisor callback */
 	sysvec_install(HYPERVISOR_CALLBACK_VECTOR, sysvec_acrn_hv_callback);
+
+	setup_force_cpu_cap(X86_FEATURE_TSC_KNOWN_FREQ);
 }
 
 static bool acrn_x2apic_available(void)
-- 
2.54.0.823.g6e5bcc1fc9-goog

