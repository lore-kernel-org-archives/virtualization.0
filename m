Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EDBF400163
	for <virtualization@lists.linux.dev>; Fri, 15 May 2026 19:21:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778872875; cv=none; b=Woh68DpbGbvqazRmAvOt3p/ndVf0GUop97fbGkODtHfw5LgTHPQ5XOX8iF7fXgA3PndKimuX8klCZxCRpY7UfN38sZ2SXmXuCblFMOb8Ikwplm7DXeKxrsTiqvR4QSsfXjrHhWg9H7X/EMLcTW5yO2x3xfvzOH6V8VqOqH8Zac0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778872875; c=relaxed/simple;
	bh=7fNZAyvHkd4hTsuWucV5ADSCdPdtVNOHGfWpS1jSTro=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=l9N+C0dfRrRpUYa18aPKvBvuUEazeNcL7tW8bVdBb42cjI1JXr4japZ6G6UO20Xzj46tcAUaCiYRDCKU++Yf+zG4sQ58CTA+J9LXc4q1+toDcAMk12HzLSqQWixXIwyokxw0ySBE001rCln/QgtPOUCmivZ6qWPciUwvjwhm8hU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=I2SzYlEc; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="I2SzYlEc"
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-837d0d71c61so80792b3a.1
        for <virtualization@lists.linux.dev>; Fri, 15 May 2026 12:21:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1778872871; x=1779477671; darn=lists.linux.dev;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=HRAsSS8xU7yGk1K8a9fV0Bzp4HNJreTB4TmSZ4FXvc4=;
        b=I2SzYlEcyGLt/1qSQbwdmqO+260hj5MkrNTCPwKbEd9zuWZKYoluBQCNBugklOLxXb
         1b4X6hjf+3XJqoKhevGCU/YIDbuMlcYBHrhGwtucQEXs481sFPr7xSI8ERIz+nIBux+d
         jyggGZYKlNGJn0oBPNSC7d7o3Na/jCMrMpRyNq93zJE+klpbitclU87KW1D2AluKE8r+
         Kni5AHWgPO7T80BOkwR7R5hOjWHyzHezOA3At6EUgRhJHy9NjNbrzm63mTDQ+H5/lMOe
         tyvRg7g3qrFf7zb8ZF/Ntx73UK0Mw7JYbiL/BEw3m+Z755I4aVd7x3R1Pl4eVOjXwS/9
         7Hdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778872871; x=1779477671;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HRAsSS8xU7yGk1K8a9fV0Bzp4HNJreTB4TmSZ4FXvc4=;
        b=mLHJctqLXHDYefmaQld1umcSw8UAXNdwyVMdUetFXc8QxUlZ8oyUXoMY++Q/98iyvy
         ytjCW+UIXqclKe9f+YhoFRHRPR5IfmNBs3hoai3CKO5ZzFvzGmL5tu+b+zR5R1Q1jPvt
         T/pnUpCT11m8kqMUvSNtGaz8p8/E+N0AgrkD/foG7AreZlcaD0bbsbCM1kcFRwNMwPAQ
         yMqiYFvcNHqKoDmVtH5lMF5ayYAWNvcu0Bv9pAdikChWngrVruLgV/08mE1u8d6U2vUj
         H17G/3nwEKGDoarOS8YL9COdaxHnNoxspNw62uXJFegeLq8f+ZVg48WiymbCupDOUZiw
         fByg==
X-Forwarded-Encrypted: i=1; AFNElJ9BY9PEJwbVSFAHq3ldv3M5jBKfSyDZCHjpx2Drj5nMXtG3ffWEo5aJ4ixuW8LvekO9XBTePgiAUfnt/BJiUA==@lists.linux.dev
X-Gm-Message-State: AOJu0YwjcxNzPpBqoSHssRWLkfeVTpoKPlQ3ZKXe1fJWFcBo/uGleCWZ
	tICTXtkiMUTeUaVbXMtOMkSOYfsoecagV8wNWOObkH1oRmiD1pv2yuQQzda8fDXCicSKPSivErL
	/3yH4lw==
X-Received: from pfdc5.prod.google.com ([2002:aa7:8c05:0:b0:82f:a75b:f7fa])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:ab0d:b0:839:e27c:6cce
 with SMTP id d2e1a72fcca58-83f33d97d9amr5480931b3a.37.1778872871152; Fri, 15
 May 2026 12:21:11 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Fri, 15 May 2026 12:19:33 -0700
In-Reply-To: <20260515191942.1892718-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20260515191942.1892718-1-seanjc@google.com>
X-Mailer: git-send-email 2.54.0.563.g4f69b47b94-goog
Message-ID: <20260515191942.1892718-33-seanjc@google.com>
Subject: [PATCH v3 32/41] x86/tsc: Rejects attempts to override TSC
 calibration with lesser routine
From: Sean Christopherson <seanjc@google.com>
To: Kiryl Shutsemau <kas@kernel.org>, Paolo Bonzini <pbonzini@redhat.com>, 
	Sean Christopherson <seanjc@google.com>, "K. Y. Srinivasan" <kys@microsoft.com>, 
	Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>, 
	Dexuan Cui <decui@microsoft.com>, Long Li <longli@microsoft.com>, 
	Ajay Kaher <ajay.kaher@broadcom.com>, Alexey Makhalov <alexey.makhalov@broadcom.com>, 
	Jan Kiszka <jan.kiszka@siemens.com>, Dave Hansen <dave.hansen@linux.intel.com>, 
	Andy Lutomirski <luto@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Juergen Gross <jgross@suse.com>, 
	Daniel Lezcano <daniel.lezcano@kernel.org>, Thomas Gleixner <tglx@kernel.org>, 
	John Stultz <jstultz@google.com>
Cc: Rick Edgecombe <rick.p.edgecombe@intel.com>, Vitaly Kuznetsov <vkuznets@redhat.com>, 
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, 
	Boris Ostrovsky <boris.ostrovsky@oracle.com>, Stephen Boyd <sboyd@kernel.org>, x86@kernel.org, 
	linux-coco@lists.linux.dev, kvm@vger.kernel.org, linux-hyperv@vger.kernel.org, 
	virtualization@lists.linux.dev, linux-kernel@vger.kernel.org, 
	xen-devel@lists.xenproject.org, Michael Kelley <mhklinux@outlook.com>, 
	Tom Lendacky <thomas.lendacky@amd.com>, Nikunj A Dadhania <nikunj@amd.com>, 
	Thomas Gleixner <tglx@linutronix.de>, David Woodhouse <dwmw@amazon.co.uk>
Content-Type: text/plain; charset="UTF-8"

When registering a TSC frequency calibration routine, sanity check that
the incoming routine is as robust as the outgoing routine, and reject the
incoming routine if the sanity check fails.

Because native calibration routines only mark the TSC frequency as known
and reliable when they actually run, the effective progression of
capabilities is: None (native) => Known and maybe Reliable (PV) =>
Known and Reliable (CoCo).  Violating that progression for a PV override
is relatively benign, but messing up the progression when CoCo is
involved is more problematic, as it likely means a trusted source of
information (hardware/firmware) is being discarded in favor of a less
trusted source (hypervisor).

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kernel/tsc.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/x86/kernel/tsc.c b/arch/x86/kernel/tsc.c
index 98bef1d06fa9..7a261214fa3e 100644
--- a/arch/x86/kernel/tsc.c
+++ b/arch/x86/kernel/tsc.c
@@ -1319,8 +1319,13 @@ void tsc_register_calibration_routines(unsigned long (*calibrate_tsc)(void),
 
 	if (properties & TSC_FREQUENCY_KNOWN)
 		setup_force_cpu_cap(X86_FEATURE_TSC_KNOWN_FREQ);
+	else if (WARN_ON(boot_cpu_has(X86_FEATURE_TSC_KNOWN_FREQ)))
+		return;
+
 	if (properties & TSC_RELIABLE)
 		setup_force_cpu_cap(X86_FEATURE_TSC_RELIABLE);
+	else if (WARN_ON(boot_cpu_has(X86_FEATURE_TSC_RELIABLE)))
+		return;
 
 	x86_platform.calibrate_tsc = calibrate_tsc;
 	if (calibrate_cpu)
-- 
2.54.0.563.g4f69b47b94-goog

