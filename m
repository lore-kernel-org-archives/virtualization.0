Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FB734CA264
	for <virtualization@lists.linux.dev>; Wed,  1 Jul 2026 19:32:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782934357; cv=none; b=ZfgQjXC7dHydNtStot442pqA5xoqytKmsvDfrfjk0Gc6aTqlubzUMXiOEo2oHBm66OBJ533M5OYpZOCUktNsh0DsnDSF+TLmMCwDIcN5PBgiL8AlIAy6fqkge38Xii4n98rTWFYquNCm9jvLryTgXRdVX2RfUWXy5AOqWtmiP5w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782934357; c=relaxed/simple;
	bh=p5tLZkB3crC07vF32aPnSFAmwAQDDSFCr6tkFys+CMo=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Ja53STJVrKgl2l7YqCL97UjhOh2o05StFaLaoPawYp6+hIByR4tje/mk28Lw62Qp7aI4hOhhJD3Pc3hOpX1fbpwdpCLAQqKrzGQYaTWA2VOFduJpeyVX2DTz9VzNAuRQbkJjqpLGYoN3HP0J1t9UAz7xDtLJc3xwXjsbDSbYLRQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=KOZIE8cC; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="KOZIE8cC"
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-2c825562f8bso11895635ad.2
        for <virtualization@lists.linux.dev>; Wed, 01 Jul 2026 12:32:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1782934354; x=1783539154; darn=lists.linux.dev;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=evwxLM71EsC76xUKnJUsM6sZDhf4kmGP6xo/jdNLobw=;
        b=KOZIE8cCnD+asX9uEOP6Tky6tmu957Tt+OYf7DkxYLsGTmvHaLBldQGkcHPBJs+Wqy
         wNs1NCD1p2ni9DPDLK6rgpfcFBXZiGBsUAX68VHtW/gNwDahOEJntjkudfcsoPlGFXMj
         d35Iktse0dzYl+rHvsRha4+YogPZWoTDzJcqkhqIpiM/FFRTr2Bsghfrx1iQtZCiV2rz
         8blYC+s5ksXsh8AJ3FPpZ+WWBWFMzZNnzuR+I2juRx/2BKFw+tLCuvEiI08O6Ujah0L0
         orCINb52PV4U5AoTXdgVjtMceAEG68BwlfrZQDd7EOMNOi8H86HMBGQSDiFj1O+jjt56
         5Zig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782934354; x=1783539154;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=evwxLM71EsC76xUKnJUsM6sZDhf4kmGP6xo/jdNLobw=;
        b=rC2hVyHY+LA8FWssxsaK8kxlNbyWvgErDk1qXkytqXnc3n9VlRmdIgLadBb4HXg2Qc
         Q5x8Ognl8bYt8r/8D87KM66N7sIbg5LotcA4VgKk2mGJbvYM5lanRUyHnYWDNPakoCZM
         UEghq86frBaoZfQON/ZYud2qlKQ/4kiOo+DgkuE5Rski3+okV9G3CLjqLnxfHgUSnw5z
         sB+tqyytrQVQVZ6Kf2y0uQ8MNsaDesDZES3YiEKKIHX7A7336g0Y4vwEzL4g15VcPtY9
         e/1zf1KbB8JazwFBZNjKd0OvtmyIBlb62yfEMhqMsXT/ucUB8paVghTSH63vy67d9ZJn
         Cmhw==
X-Forwarded-Encrypted: i=1; AHgh+RpeGSdR9OGpd/hNdMkpoklzzvYozSjrQi15K3jk1lMd9fX/Ba7h4804mxLqxw/JiTkeYaDi0SehMngTHSQ1Ag==@lists.linux.dev
X-Gm-Message-State: AOJu0YxjRSqi8TPqouWOBoEyXz3PZSHmnLm6HlyIGMzteTc6K8JXCtwd
	fb+Yl3oGHCvIwA41gKME5225jSdc8TRJRiNPENS3QJXREyyQoYu4KxdTYbeqvfue4q6yEWxyle0
	lElqaxw==
X-Received: from plha8.prod.google.com ([2002:a17:902:ecc8:b0:2c6:a75b:2129])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:f8c:b0:2c7:d603:117f
 with SMTP id d9443c01a7336-2ca7e754b82mr34808385ad.26.1782934353608; Wed, 01
 Jul 2026 12:32:33 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Wed,  1 Jul 2026 12:31:27 -0700
In-Reply-To: <20260701193212.749551-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20260701193212.749551-1-seanjc@google.com>
X-Mailer: git-send-email 2.55.0.rc0.799.gd6f94ed593-goog
Message-ID: <20260701193212.749551-7-seanjc@google.com>
Subject: [PATCH v5 06/51] x86/sev: Don't override CPU frequency calibration
 for SNP's Secure TSC
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

Don't override the kernel's CPU frequency calibration routine when
registering SNP's Secure TSC calibration routine.  SNP (the architecture)
provides zero guarantees that the CPU runs at the same frequency as the
TSC.  The justification for clobbering the CPU routine was:

  Since the difference between CPU base and TSC frequency does not apply
  in this case, the same callback is being used.

but that's simply not true.  E.g. if APERF/MPERF is exposed to the VM, then
the CPU frequency absolutely does matter.

While relying on heuristics and/or the untrusted hypervisor to provide the
CPU frequency isn't ideal, it's at least not outright wrong.

Fixes: 73bbf3b0fbba ("x86/tsc: Init the TSC for Secure TSC guests")
Cc: Nikunj A Dadhania <nikunj@amd.com>
Cc: Tom Lendacky <thomas.lendacky@amd.com>
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/coco/sev/core.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/x86/coco/sev/core.c b/arch/x86/coco/sev/core.c
index ed0ac52a765e..665de1aea0ee 100644
--- a/arch/x86/coco/sev/core.c
+++ b/arch/x86/coco/sev/core.c
@@ -2046,7 +2046,6 @@ void __init snp_secure_tsc_init(void)
 
 	snp_tsc_freq_khz = SNP_SCALE_TSC_FREQ(tsc_freq_mhz * 1000, secrets->tsc_factor);
 
-	x86_platform.calibrate_cpu = securetsc_get_tsc_khz;
 	x86_platform.calibrate_tsc = securetsc_get_tsc_khz;
 
 	early_memunmap(mem, PAGE_SIZE);
-- 
2.55.0.rc0.799.gd6f94ed593-goog

