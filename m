Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com [209.85.210.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55C2449EF39
	for <virtualization@lists.linux.dev>; Thu,  6 Aug 2026 23:36:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786059412; cv=none; b=ovhXWBJUI/XBdZbdVFycA/FnCCsX/spmKkZXmJnUwLr4rJDZ+3oYkYhN/uY5QleKbeq9nfPYteJI1/z1XQkEMRo4U4Og6Mh6VOaZaIBsz1FiBzTk/1b0Olew7lXyLm4VcmqAJCVJrDK0UkK853AvGs02Rt5cpv3yNsJtvOSLkgU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786059412; c=relaxed/simple;
	bh=hNEb8xDuzhPNI6tvifSOafJznm7WdTSs3VtHjZgwixU=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=ry3eh55viecaYP92+BqWyNiRUjA/A83Rih2ICLj9672k5jaqS7UQ08zIz2ckMyRzPaB+qnHI77xfvEIVC1uN/SezbHkp22vpTqKTmeHXszJ9V8BeAdQeL+PMThNEOsDXOL5Jyy8hAGnIOgNnYGk0CmgnTdGU3xQS38oRXncJgcY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=iZ/Nh5k1; arc=none smtp.client-ip=209.85.210.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="iZ/Nh5k1"
Received: by mail-pf1-f200.google.com with SMTP id d2e1a72fcca58-84f0d3ab2f4so2321045b3a.1
        for <virtualization@lists.linux.dev>; Thu, 06 Aug 2026 16:36:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1786059408; x=1786664208; darn=lists.linux.dev;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:reply-to:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=kOFXKheX158XT5RdBZeZqj6PvfchU0LO18FYNMDj3A4=;
        b=iZ/Nh5k1/WC8I0M/m+j+R6uzB4O+fh/3MBlySMnYPIdrdHfr/gvYjCY7g2t3VS6zVU
         4of2m6hPICue+99oThLxJ/ldBECVGGTlqwC6OAlzzPIzNyDNLPCC3oxNzE0ezHqEIJu9
         nir+3NETti27uY1R313D5b3RBz6ERVpUfYeor5/LhDlsx0F+AfprtfwjQv5YrUKLgRXV
         2wN1SCwAkaJtPv5cr0by+4zSK2cdzYgUFQTBSGym3oO4o03K4OsbPpsk0sFHQOdERTNm
         Vd8XuLmNUmGuJhDdlb2xufzYVAcXI8Y+dZfdgTAR1Lo1J+0Iqsk/kqULmmvomJWp83Qm
         hWWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786059408; x=1786664208;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:reply-to:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=kOFXKheX158XT5RdBZeZqj6PvfchU0LO18FYNMDj3A4=;
        b=boDxZt9fuFtMQpqmGNAo2Q5bENCRpxvqVGy5TmGbJia84grhwBKL9fIQz1q8/pEFuV
         fHSQZcqDdc60WQELVdk2kGsQVgTuTiv7aMBYcH9Nu1XWYEsFcEQu1eFe3eD7qeViaEJW
         AstnPU930g/V+erKinFP2rhysuMIbDggb0VF+jjoQysUaBvb/GCNcUOl77tOhtnRye+n
         GXSK8e+0R9Hikrk5ItffqeF6PkQinVNF927M8uKhCfPOCklCIl7th6tZPyKXUY4Pzdu0
         8QfjXRqvyGIC4x0nHBTA5vTGcVeXc+Dgy7Zr6A/M0KpoHhUT/HoUmMSnfHhf7j8R+BwL
         KEoA==
X-Forwarded-Encrypted: i=1; AHgh+RoKPK0Fjd68att0Gx3UEKQhS4pVju6bJyrd30J/lVTA0+7xM728mk9MNRhni2Ccg/PQfGFMBLU4wEzBafJccQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YyCqAPpNqi5JJqT1iPUTcCtCoXCnICbRDI6vHUHJtRdDM7/Kubl
	HvfGLQUBQH2Pdj4B17tZedhrjPNxdBVfRf0w+8qGShm3vNRoKl9UAJyMXCUJUJyCbnEgEI7VgWr
	/4aAzaA==
X-Received: from pgay6.prod.google.com ([2002:a05:6a02:4966:b0:cbb:8616:5536])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:3d4f:b0:847:9188:e492
 with SMTP id d2e1a72fcca58-84f2e04d173mr18898130b3a.22.1786059408172; Thu, 06
 Aug 2026 16:36:48 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Thu,  6 Aug 2026 16:35:36 -0700
In-Reply-To: <20260806233609.212337-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20260806233609.212337-1-seanjc@google.com>
X-Mailer: git-send-email 2.55.0.679.g6767b8d81c-goog
Message-ID: <20260806233609.212337-20-seanjc@google.com>
Subject: [PATCH v6 19/51] x86/kvmclock: Drop dead check on TSC being unstable
 during kvmclock_init()
From: Sean Christopherson <seanjc@google.com>
To: Kiryl Shutsemau <kas@kernel.org>, Rick Edgecombe <rick.p.edgecombe@intel.com>, 
	Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	"K. Y. Srinivasan" <kys@microsoft.com>, Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>, 
	Dexuan Cui <decui@microsoft.com>, Long Li <longli@microsoft.com>, 
	Ajay Kaher <ajay.kaher@broadcom.com>, Alexey Makhalov <alexey.makhalov@broadcom.com>, 
	Jan Kiszka <jan.kiszka@siemens.com>, Dave Hansen <dave.hansen@linux.intel.com>, 
	Andy Lutomirski <luto@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Juergen Gross <jgross@suse.com>, 
	Daniel Lezcano <daniel.lezcano@kernel.org>, Thomas Gleixner <tglx@kernel.org>, 
	John Stultz <jstultz@google.com>
Cc: Vitaly Kuznetsov <vkuznets@redhat.com>, 
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, 
	Boris Ostrovsky <boris.ostrovsky@oracle.com>, Stephen Boyd <sboyd@kernel.org>, 
	Miroslav Lichvar <mlichvar@redhat.com>, x86@kernel.org, linux-coco@lists.linux.dev, 
	kvm@vger.kernel.org, linux-hyperv@vger.kernel.org, 
	virtualization@lists.linux.dev, linux-kernel@vger.kernel.org, 
	xen-devel@lists.xenproject.org, Michael Kelley <mhklinux@outlook.com>, 
	Tom Lendacky <thomas.lendacky@amd.com>, Nikunj A Dadhania <nikunj@amd.com>, 
	David Woodhouse <dwmw@amazon.co.uk>, David Woodhouse <dwmw2@infradead.org>, 
	Thomas Gleixner <tglx@linutronix.de>
Content-Type: text/plain; charset="UTF-8"

As pointed out by Sashiko[*], kvmclock_init() runs before __setup() and
thus before notsc_setup() or tsc_setup() can mark the TSC unstable.
kvmclock_init() also runs well before tsc_init(), and even before
tsc_early_init().  Simply delete the check, as it's been dead code since
it was introduced.

Note, odds are good the check_tsc_unstable() call was copied from Xen's
xen_time_init()+xen_tsc_safe_clocksource() logic (as so much of KVM's PV
code was).  However, xen_time_init() runs via x86_init.timers.timer_init(),
which is invoke from x86_late_time_init(), and thus after params have been
parsed.

Alternatively, kvmclock could register itself later on, or tsc_setup()
could be parsed as an early param.  Given that there's zero evidence there
was any meaningful intent or need to actually check for an unstable TSC,
go with the simplest option.

Fixes: 7539b174aef4 ("x86: kvmguest: use TSC clocksource if invariant TSC is exposed")
Link: https://lore.kernel.org/all/20260529181213.0B27A1F00893@smtp.kernel.org [*]
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kernel/kvmclock.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/arch/x86/kernel/kvmclock.c b/arch/x86/kernel/kvmclock.c
index 061a22d31dea..29ca37e9a3bc 100644
--- a/arch/x86/kernel/kvmclock.c
+++ b/arch/x86/kernel/kvmclock.c
@@ -362,8 +362,7 @@ void __init kvmclock_init(void)
 	 *
 	 */
 	if (boot_cpu_has(X86_FEATURE_CONSTANT_TSC) &&
-	    boot_cpu_has(X86_FEATURE_NONSTOP_TSC) &&
-	    !check_tsc_unstable())
+	    boot_cpu_has(X86_FEATURE_NONSTOP_TSC))
 		kvm_clock.rating = 299;
 
 	clocksource_register_hz(&kvm_clock, NSEC_PER_SEC);
-- 
2.55.0.679.g6767b8d81c-goog

