Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com [209.85.216.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 885894AA11D
	for <virtualization@lists.linux.dev>; Thu,  6 Aug 2026 23:37:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786059434; cv=none; b=NXunoaNw3F5ccNKXdkX/ihrULS0UW4rODqDe2ffCCrQH3cMMBrVf8xwO5222kNlA29dEGVAggEDsEUQUU4BMOwn5faaijuMWzp9fUgm9lG86wBj5XTf2GtzMJYGXwIzhWWCDGWb39GKgWXOsa+pZ0InU90i8RBVvKm4tOhKFJLQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786059434; c=relaxed/simple;
	bh=O74eXjp88Xj4Hu2r50cQeq7DVhhqDrykpjbML2eTnkU=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=ezMczOUzRbBSP2PmPISRmbMOVbcMpxT8KFcNuDI4u3Tf0vvvtqDRMs/5/S1X8o6b2ra0B90dyXAJw/zvfJxuMYEouHW/aPMJeRIACDpcPfC5x11/9TXe2lV3B8W7bH7WICYs3xL0lPBAMvo2XOKZOfxmdPW+amw6Wxibe3i3bPA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=iqRRVZ/P; arc=none smtp.client-ip=209.85.216.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="iqRRVZ/P"
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-3811279d51aso4527473a91.1
        for <virtualization@lists.linux.dev>; Thu, 06 Aug 2026 16:37:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1786059432; x=1786664232; darn=lists.linux.dev;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:reply-to:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=4ag8yTwNbmjHFkBZxZL+JA4uvidx3vZA6IwgDKjMnAQ=;
        b=iqRRVZ/PWA8Q9f2AmhgdhV8yVzAjBwWWREVFBIICD7J5CfJsV5MdFjcBtBNJCUAN9m
         AOhB1ed84Z6m0vaFeOH4ztPGxrcTJvW1TBBhMgRHE/H+6Asf57ppaspIdtB4ptx7UxtC
         VBeB/KVG3rS6VRRq7d/S3Y9+1JyEMn89VfCf+jhDPtAc1rRTFxWt5z5udfduScxpOMRe
         cTY2HLcyygqv50mOtTrO031jo/MkIB4i6ehecakbzI/U7cX6jfsR5qg9DFamLaYO7La7
         ge+jNI3bjWWLQL7WXnhmgQmUPrh/T2xYxSeA9Q1Pi2c6YNxwbaKt+abXR8Ekr7Y90erz
         YXVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786059432; x=1786664232;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:reply-to:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=4ag8yTwNbmjHFkBZxZL+JA4uvidx3vZA6IwgDKjMnAQ=;
        b=i94Hfq2wbI+Bf1hxu1PhNbWJRs2mtXs360rzUxrhELzDsHH7OfDEYvC5PX1AA+E7Kb
         qqYPvkUZKSUM+iHXb588Y31pV2e+gMP1PvHSFHRJmCT7clEamj0381FUuNBWZ4w0+QzA
         3+wvqt9lnekst/NRXHIb3OPHQc5dGX6KESdORvh/1XJvaJU1aX+JqVI2iiPU9SzFtH4u
         S6O8yim8YNykbIRqiXSjn19Z3LiIR3/FzCyPnj5xnEtKKfqRwQk+8kQA7s/Va2RRRVel
         UlzDGY/WX4vjxtfomVRIMQMw9CAklWUaFm6vdXq9L8zP0trzzFEyeRPkQpn2zlnBlyo3
         eCIg==
X-Forwarded-Encrypted: i=1; AHgh+RpJOHlfJ03FXpqnGKiwTSSbe8fl7NugyG7FpqjH4ngYLBQX9XSCOgnMY0qudNxQcgQYGxXdKDhR3SI/YljgHA==@lists.linux.dev
X-Gm-Message-State: AOJu0YwkiyLSzIH4/igdjIUFp0XrzPDusMiC3VDwySvq32WaYdp0NHn2
	scN6X7xr6ycdbgPjIH0VVST4mJMQ9Wd7B+1MipbDRzfpuAEUG/smv36UUhF21T6QLjNiyXaRZyJ
	eo2s0ug==
X-Received: from pjbqb12.prod.google.com ([2002:a17:90b:280c:b0:38f:2874:84ed])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90a:c88e:b0:38e:488f:7068
 with SMTP id 98e67ed59e1d1-3903c5373b4mr20565740a91.2.1786059431685; Thu, 06
 Aug 2026 16:37:11 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Thu,  6 Aug 2026 16:35:55 -0700
In-Reply-To: <20260806233609.212337-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20260806233609.212337-1-seanjc@google.com>
X-Mailer: git-send-email 2.55.0.679.g6767b8d81c-goog
Message-ID: <20260806233609.212337-39-seanjc@google.com>
Subject: [PATCH v6 38/51] x86/xen/time: Mark xen_setup_vsyscall_time_info() as __init
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

Annotate xen_setup_vsyscall_time_info() as being used only during kernel
initialization; it's called only by xen_time_init(), which is already
tagged __init.

Reviewed-by: David Woodhouse <dwmw@amazon.co.uk>
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/xen/time.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/xen/time.c b/arch/x86/xen/time.c
index 8cd8bfaf1320..bc26f00fc53e 100644
--- a/arch/x86/xen/time.c
+++ b/arch/x86/xen/time.c
@@ -443,7 +443,7 @@ void xen_restore_time_memory_area(void)
 	xen_sched_clock_offset = xen_clocksource_read() - xen_clock_value_saved;
 }
 
-static void xen_setup_vsyscall_time_info(void)
+static void __init xen_setup_vsyscall_time_info(void)
 {
 	struct vcpu_register_time_memory_area t;
 	struct pvclock_vsyscall_time_info *ti;
-- 
2.55.0.679.g6767b8d81c-goog

