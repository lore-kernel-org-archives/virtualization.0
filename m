Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4382342E8DF
	for <virtualization@lists.linux.dev>; Wed,  1 Jul 2026 19:33:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782934412; cv=none; b=ZT4eE9OQ21ZLvkvYMH6/0YQuXhh4kucd+AxNqZimhYzkZJZb5ed+7Ymlv9f40aWrSmKkdrue2Q/oiq/zD0btPeOLSl2CJNt9aUi3V5o+joiWQXtuM3oT6/ZqrbZpwGYyfN/97maD7H+xGr1F07uzc4JFPVhviXP1AUeYGIyiMK0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782934412; c=relaxed/simple;
	bh=t2gV+eBO9o787fvbLEefqahl8FVWKIIpfUP+z3tzyok=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=SsKa+A1ZHJWdQ6LvviY9Ck7l6P5pJORB79lddYP+pgz2zMa4FwuyiqyFFXQEtXJv5UeaC08jr0E7XriCiPM9beZhw3OaSx5Nab0j78B6+xu/3YqKi9GMWGtrLp9QDPA3yBkRenRaOfPQsq5w4Yo3UEZezY9/dRY3sXUudNLKNXc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Ylw1Qqlc; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Ylw1Qqlc"
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-c88aab7c1fcso999694a12.3
        for <virtualization@lists.linux.dev>; Wed, 01 Jul 2026 12:33:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1782934408; x=1783539208; darn=lists.linux.dev;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=ukYnz5D3jEol4z1WUeRHDVtFiLPopAappLYurzMw/rI=;
        b=Ylw1QqlcDHA3VtYD7VrbOqwDRoy0vzDWIuciKnPSlUgGcu7Ae5JWZfZdZqXFOdq4sd
         Echw4wTWuWMh3nQKjnYnMGa1p0M8eyUAFtbOo2XRhYRxxr/rHmidiydF0KE90xcHgwK0
         K54y9397nco9UUxO91fv4P2/02rssOCRlH3VNgdPR5gUzgSw3VD1jH3TDjr1e5jnMSsf
         qXxBmxgEHywyJZU6miZJ1KK+L67xk2DBzSTlSfPSSYuUmT5TGErmkAqnc2ptmtJjlZ8m
         WhWV5vh0BU/HUMPNSaXiC7tIXxuKDOTJmcFFr6OUaPbh5nutoiKHl8FHEFgSGnSgV6QV
         cHzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782934408; x=1783539208;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ukYnz5D3jEol4z1WUeRHDVtFiLPopAappLYurzMw/rI=;
        b=VB42UHO4lEuxa25hhD8vPV5/Bi2x+gLKTvXIKWuajlzGX7ca0A+b/KCZKWp28ZgjNQ
         6/E9HG+4TAtoTDZR9Pyyx/1AbQo7lNOj8gYxiCHxdQhKVsMQoxigPdLFadjw3GA3TpLQ
         rLKzu28Ii5G6xIZTMwqsUW53V7tsjiOpk/xStgjbgpzZgFwhRcRtFFtroNus1OTS9nn0
         2k2GdBOa1Rm1Zs0eILW4CHbb+3upkAoNcPVQzejI4ymR0kyLoJuuUgxohNrPwiQX7vhM
         buzCItoWRRH5409DOXd618wGgp3PuUP8ByDB3Q+hytuTNjp3RbUYcagqXNXGqA0W6Uco
         ERiA==
X-Forwarded-Encrypted: i=1; AFNElJ+6nNJcmvBF7C0RoonTiiZYqTQwCIvmuXs2Fj104vw3DRTfmHCotTnP0eMiGNZQTQrZqS8Qz91Kwcs0yLKlYA==@lists.linux.dev
X-Gm-Message-State: AOJu0YyjTs5nMNRe+WtlfTfFE/2nchjk1OJR20zvZOoZnJjlh0FKCzKW
	bAiKgeh0HQnAQZk8ik1lViskh+afyYBoJv0tOrcLfBO4gQKJveEQbCgSqtoh0rB4ClfQUwyEtCF
	fLuIbLw==
X-Received: from pgad26.prod.google.com ([2002:a05:6a02:4f5a:b0:c99:d21a:f6b7])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a21:748b:b0:3bf:d1f9:b1db
 with SMTP id adf61e73a8af0-3bfed5e1001mr3530009637.52.1782934408107; Wed, 01
 Jul 2026 12:33:28 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Wed,  1 Jul 2026 12:32:12 -0700
In-Reply-To: <20260701193212.749551-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20260701193212.749551-1-seanjc@google.com>
X-Mailer: git-send-email 2.55.0.rc0.799.gd6f94ed593-goog
Message-ID: <20260701193212.749551-52-seanjc@google.com>
Subject: [PATCH v5 51/51] x86/kvm: Get local APIC bus frequency from PV CPUID
 Timing Info
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

When running as a KVM guest with PV timing info provided by the host,
stuff the APIC timer period/frequency with the local APIC bus frequency
reported in CPUID.0x40000010.EBX instead of trying to calibrate/guess the
frequency.

See Documentation/virt/kvm/x86/cpuid.rst for details.

Reviewed-by: David Woodhouse <dwmw@amazon.co.uk>
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kernel/kvm.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kernel/kvm.c b/arch/x86/kernel/kvm.c
index f9a6346077b0..beea0b6aa78e 100644
--- a/arch/x86/kernel/kvm.c
+++ b/arch/x86/kernel/kvm.c
@@ -990,7 +990,7 @@ static void __init kvm_init_platform(void)
 		.mask_lo = (u32)(~(SZ_4G - tolud - 1)) | MTRR_PHYSMASK_V,
 		.mask_hi = (BIT_ULL(boot_cpu_data.x86_phys_bits) - 1) >> 32,
 	};
-	u32 timing_info_leaf;
+	u32 timing_info_leaf, apic_khz;
 	bool tsc_is_reliable;
 
 	if (cc_platform_has(CC_ATTR_GUEST_MEM_ENCRYPT) &&
@@ -1052,6 +1052,11 @@ static void __init kvm_init_platform(void)
 			x86_init.hyper.get_tsc_khz = kvm_get_tsc_khz;
 			x86_init.hyper.get_cpu_khz = kvm_get_tsc_khz;
 		}
+
+		/* The leaf also includes the local APIC bus/timer frequency.*/
+		apic_khz = cpuid_ebx(timing_info_leaf);
+		if (apic_khz)
+			apic_set_timer_period_khz(apic_khz, "KVM hypervisor");
 	}
 
 	/*
-- 
2.55.0.rc0.799.gd6f94ed593-goog

