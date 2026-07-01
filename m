Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F32714DA554
	for <virtualization@lists.linux.dev>; Wed,  1 Jul 2026 19:32:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782934365; cv=none; b=pa5cgTi3fZjwIz6SfPBbOVeOwsNzvZDf0FLHWBGi1adWxzD1lR+3SNf1NLKXPctKtCOy78NRJJ91k0Q/PTq+L3X5KBxcgTM+CmaP1zV2mZwjLGThgblIlyEENVttkYXe/M05hXfoYSGzcc2Xlb1a9ORe9AQsNaIb+FKmBZxnreQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782934365; c=relaxed/simple;
	bh=CiGkqE/6AT+VqdBT08JjtFv5kCcpPymLLHYJ+kIZoXI=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=o9Yb0aBifcVkMK57W7RJjBOPoUs6KQLUh+eWJbLe8YEhc/8jrLT/C2JWxHX4Mzf3hvIAhpW1TE4f+hQCBJ8iT7L5b/F/Juhs+gRAtExfaFqAg+Tx33IVKEe31Mjo9JnBnozAMU24eJrkrwLN/kgGHWBdP2SslPjDDKmYnIVJCYg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Wx5JUneq; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Wx5JUneq"
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-c88da04b71dso969151a12.3
        for <virtualization@lists.linux.dev>; Wed, 01 Jul 2026 12:32:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1782934362; x=1783539162; darn=lists.linux.dev;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=FaUjTU3QKJy+ktbmudl/+1GzmAqwQnS7of3spvtM7gQ=;
        b=Wx5JUneqJVE21VqXCETEm32+kBC9DLQGeyYglDe59YwYj3cchXnG91X+iba2f01oXy
         5uCRoE4rk+3fnZ5GEDENtDqLsmaJJ7Yz478vbM5AI4vEdybZcXCRGdKzoOI0TFGfgOwm
         l316QvKXCJikjum7zkA3C9FSPbDfHAV66VeDRi086GJ1pepOXhmUy23fz5Mrd04LMolL
         U7Cphm/8WK9Z2bGbpIXA1Ijpe2Q5Axzm4ENOD/6g83D2gqPvZWDk2G5kB8RwmumgAfAQ
         cqJTh1SONVpGqn0DR86u75q7pxNG2WH4e2wz+LmTLhyLxSERI/p9b9jEiBSgsapGN6OQ
         k+BA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782934362; x=1783539162;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FaUjTU3QKJy+ktbmudl/+1GzmAqwQnS7of3spvtM7gQ=;
        b=jIwCXjRL1acdU3cbXE3lWSucY7a1i8stcnffY/x6aC72i53M5A9Im14+GmPbM3wOSq
         842wrrOddq9V1I2D6YYFemzVTB/BH/6BmIJcPOI9SKav6fZuwsOk0qQBjlY4cul8fqGG
         Y++MwUCtKBAjyJbFG99sjaJqfS8cLzHTTi7tpt/ON9oOlwixC1hvANZjaol7zbzchOda
         KTO6x6xuw15pKlIccNl2HRvPlSt8TWuzrEFWgIh6oiOCd1LiBQUyYgS/4JtTWNsCCl8y
         F9AYmLio9bRYItAhXgJ+DRPwGnIcVkt8b/ylH4qocmAl8/CWjR3V8AcVdZr8hm7Ho7Wh
         4xMQ==
X-Forwarded-Encrypted: i=1; AFNElJ8i6Fn1DGerR1qxbswlDiI+st2V35jGRaPAbJqhR4pIJtsdbBRRKE0oiHlwJaSX67JVfhPposDhDaLAn/j4lQ==@lists.linux.dev
X-Gm-Message-State: AOJu0Yxa/e6V/+JVotXNdcWznR0KJ3iNqDMVEgiGvCJzBLWJrg6vGLYq
	mJxMZqurbNxvk9QDWzjFuniNZi/t++liYVUQXlAImLtFDn1NDB2e6jy6PA+zwZ91vH6kZVqm1qe
	vUqfUSA==
X-Received: from pghx17.prod.google.com ([2002:a63:f711:0:b0:c9a:53ea:434a])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a21:1b84:b0:398:9b42:69f7
 with SMTP id adf61e73a8af0-3bfed3b19b0mr3536321637.39.1782934362055; Wed, 01
 Jul 2026 12:32:42 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Wed,  1 Jul 2026 12:31:34 -0700
In-Reply-To: <20260701193212.749551-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20260701193212.749551-1-seanjc@google.com>
X-Mailer: git-send-email 2.55.0.rc0.799.gd6f94ed593-goog
Message-ID: <20260701193212.749551-14-seanjc@google.com>
Subject: [PATCH v5 13/51] x86/acrn: Mark TSC frequency as known when using
 ACRN for calibration
From: Sean Christopherson <seanjc@google.com>
To: Jonathan Corbet <corbet@lwn.net>, Paolo Bonzini <pbonzini@redhat.com>, 
	Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	Kiryl Shutsemau <kas@kernel.org>, Rick Edgecombe <rick.p.edgecombe@intel.com>, 
	Sean Christopherson <seanjc@google.com>, "K. Y. Srinivasan" <kys@microsoft.com>, 
	Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>, 
	Dexuan Cui <decui@microsoft.com>, Long Li <longli@microsoft.com>, 
	Ajay Kaher <ajay.kaher@broadcom.com>, Alexey Makhalov <alexey.makhalov@broadcom.com>, 
	Jan Kiszka <jan.kiszka@siemens.com>, Andy Lutomirski <luto@kernel.org>, 
	Peter Zijlstra <peterz@infradead.org>, Juergen Gross <jgross@suse.com>, 
	Daniel Lezcano <daniel.lezcano@kernel.org>, John Stultz <jstultz@google.com>
Cc: Shuah Khan <skhan@linuxfoundation.org>, "H. Peter Anvin" <hpa@zytor.com>, 
	Vitaly Kuznetsov <vkuznets@redhat.com>, 
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, 
	Boris Ostrovsky <boris.ostrovsky@oracle.com>, Stephen Boyd <sboyd@kernel.org>, linux-doc@vger.kernel.org, 
	kvm@vger.kernel.org, linux-kernel@vger.kernel.org, linux-coco@lists.linux.dev, 
	linux-hyperv@vger.kernel.org, virtualization@lists.linux.dev, 
	xen-devel@lists.xenproject.org, Tom Lendacky <thomas.lendacky@amd.com>, 
	Nikunj A Dadhania <nikunj@amd.com>, David Woodhouse <dwmw@amazon.co.uk>, 
	David Woodhouse <dwmw2@infradead.org>, Michael Kelley <mhklinux@outlook.com>, 
	Thomas Gleixner <tglx@linutronix.de>
Content-Type: text/plain; charset="UTF-8"

Mark the TSC frequency as known when using ACRN's PV CPUID information.
Per commit 81a71f51b89e ("x86/acrn: Set up timekeeping") and common sense,
the TSC freq is explicitly provided by the hypervisor.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kernel/cpu/acrn.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/x86/kernel/cpu/acrn.c b/arch/x86/kernel/cpu/acrn.c
index dc71a6fdd461..3818f6ae0629 100644
--- a/arch/x86/kernel/cpu/acrn.c
+++ b/arch/x86/kernel/cpu/acrn.c
@@ -40,6 +40,7 @@ static void __init acrn_init_platform(void)
 	if (acrn_tsc_khz_cpuid) {
 		x86_init.hyper.get_tsc_khz = acrn_get_tsc_khz;
 		x86_init.hyper.get_cpu_khz = acrn_get_tsc_khz;
+		setup_force_cpu_cap(X86_FEATURE_TSC_KNOWN_FREQ);
 	}
 }
 
-- 
2.55.0.rc0.799.gd6f94ed593-goog

