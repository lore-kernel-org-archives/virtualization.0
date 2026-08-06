Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com [209.85.210.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B931647F78C
	for <virtualization@lists.linux.dev>; Thu,  6 Aug 2026 23:36:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786059393; cv=none; b=W0Z4zsDh11zXjKOfUo2hEXgxlMZrBuskSGBqWS9noIgxYT2ldvZc+EXKikSj9HLlN0xp4tVDQMJv/KgvLg9g4SIQ43G1IG9oPsWyPqRvDVdunlINDVWltDaBEE7QmsRUyAqjH9rI9M1JFOlAxt7k0cIxr5fuVcCiCq1zzwsi0gw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786059393; c=relaxed/simple;
	bh=COVjz/VMaG10y/OAye851r7NpDmo+A5RSCjUP4fF4Ws=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=JJje8DOI8tMvyR0xrb/3wA7w+6zAG/yvLHS511lfpMKPNNm8m4xtY57t08u5KoV/7mdez+0aNI6UnqNMUeMRcoyTtMkgIahfzyACZkJTfn2xmG5GWu+Fn+zUBuHzsr19gyTDAUGWvQyMEmp3iwem2npSnzUoDo32HCH8fjKd0XQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=YNikd5Jo; arc=none smtp.client-ip=209.85.210.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="YNikd5Jo"
Received: by mail-pf1-f198.google.com with SMTP id d2e1a72fcca58-84842381150so4348657b3a.3
        for <virtualization@lists.linux.dev>; Thu, 06 Aug 2026 16:36:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1786059388; x=1786664188; darn=lists.linux.dev;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:reply-to:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=2SJsprQma6tQ2oU494vKbTkDMI4EE2yRA8rYyHQJqoI=;
        b=YNikd5JoYR7cv2i52UdI4GFP+PDVyzWelReFFSuQGPEcLHipYmlS9BcaqEr2UxWuMI
         ph3BoB5SR3MK0+/nQNixUbYsrpwP07T1cjMNxMh3zAJMrIMk7kItqnRqKE/ohQxC+EZE
         qczC4i4SwCDzu4/ELVDCfd12vXy/XwyK2ioqEbpWSm4NrADfMDFN51DZNlDsoNriR8V0
         stjWTfWq6lkb9ZCHDixLH1ZAoDCZtGvHlsz1izWZ75zKmgK/EfxRe2UkVECu3icJ4DIj
         tnypjP0LKsSE9gwhthBA/M8frTRmCQsRKEUD3YQRfn+o52d62r2D+AXZhPGAXXJ2/UdE
         fGig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786059388; x=1786664188;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:reply-to:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=2SJsprQma6tQ2oU494vKbTkDMI4EE2yRA8rYyHQJqoI=;
        b=kIuFnUJr11WTEw+jZqyyssLh6VJ2MDJ2LLYMgq0YeDGCwdH8bJc3HTu4MNa0hiJPv4
         5gErj+bJSg7tXdMoTgvgfJEfy9YCwiqag6nQXGpxpK7g5YMibACu0KBvzgU4U3TA3ocf
         VAnMWfVx6JXWIg/mSfsDWOREnFYZG/b/QiRxcJwekjHuLAe8SWQc9q2EWKk0Xce5p+Fs
         riNyMTjctADis20VchWnPNfoS6ssHTj0Ul+IR+gCrFTEwbMkaa5ic1PztOHI5pKtJtCm
         NDoG1HreV5XiceqCsCMsMjiM6jb1TQy9UmPPiI9QqPTpm6MeOJB4KwAGK7YB+6KSOayI
         Jfqw==
X-Forwarded-Encrypted: i=1; AHgh+RphzmSPVVBhP0hzY6pUGGn6rJEZbt7H0AJ9GW0qZs4kEEVwhVZCEyH197PADN08a1mJjS9/C5HKmcxnt+U81Q==@lists.linux.dev
X-Gm-Message-State: AOJu0YwlEn+5tZ+U7cakezIaiUKPaWEcI+CjKjOLs1DxEyJ+h8EytuzV
	sUzDeSzcHqJfj7f10bK6DfPr8xxrBblEOdOzxZu0REJ8eO4QW9mXatemO6jWnIREj93MrP7pAeE
	og7wang==
X-Received: from pglr15.prod.google.com ([2002:a63:514f:0:b0:c9a:7d72:c316])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:2d0c:b0:84e:2382:f4f0
 with SMTP id d2e1a72fcca58-84f2dfc8ed4mr19812672b3a.4.1786059387185; Thu, 06
 Aug 2026 16:36:27 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Thu,  6 Aug 2026 16:35:20 -0700
In-Reply-To: <20260806233609.212337-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20260806233609.212337-1-seanjc@google.com>
X-Mailer: git-send-email 2.55.0.679.g6767b8d81c-goog
Message-ID: <20260806233609.212337-4-seanjc@google.com>
Subject: [PATCH v6 03/51] x86/tsc: Ensure that TSC recalibration doesn't run
 if TSC frequency is known
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

When attempting TSC recalibration post-boot, which is only done for ancient
CPUS (P4 and K7) on SMP=n kernels, assert that the TSC frequency isn't
known (explicitly provided by hardware) by way of MSR or CPUID, and bail if
the impossible happens.  In practice, recalibration and TSC_KNOWN_FREQ are
mutually exclusive, as TSC_KNOWN_FREQ will only be set when running on
hardware that was released decades after recalibration was obsoleted, but
but it's hard to see that, especially when looking at just the TSC code.

Note, the WARN can likely be tripped by running in a virtual machine and
concocting an impossible CPU model, e.g. by combining a P4 signature with
CPUID 0x15.  This is working as intended, as such a virtual CPU model is
wildly out-of-spec and is not supported.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kernel/tsc.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/x86/kernel/tsc.c b/arch/x86/kernel/tsc.c
index 4392fddd616e..bc4348585194 100644
--- a/arch/x86/kernel/tsc.c
+++ b/arch/x86/kernel/tsc.c
@@ -930,6 +930,9 @@ void recalibrate_cpu_khz(void)
 	if (!boot_cpu_has(X86_FEATURE_TSC))
 		return;
 
+	if (WARN_ON_ONCE(cpu_feature_enabled(X86_FEATURE_TSC_KNOWN_FREQ)))
+		return;
+
 	cpu_khz = x86_platform.calibrate_cpu();
 	tsc_khz = x86_platform.calibrate_tsc();
 	if (tsc_khz == 0)
-- 
2.55.0.679.g6767b8d81c-goog

