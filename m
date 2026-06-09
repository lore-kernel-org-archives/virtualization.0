Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFAB44C042F
	for <virtualization@lists.linux.dev>; Tue,  9 Jun 2026 17:17:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781025426; cv=none; b=nC4oBn4cJxKkZyffARp111vO9jv76ub7Ra9ST5kfzskoax27PvfKwUDl/A28fVmlU9y5/mRqDGiqKRU/mO54NRFwRWfx600EFvrDIddfPhUl/V5tRM3vUPWbJJmGPrzqGyfYRNi8vfxSA4atjgd1lwYCcnxJ6n5f/f51qke6p0M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781025426; c=relaxed/simple;
	bh=0yX1le44tc/9XtzmqoIANl5jWHza37di/KrrdJWLzbQ=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=aBXItH8HuXeWWrsovTV6alZ27YUKxo3P236vCBnhZ7vQ/VXoX2iOkU1DLOdyTQHxyUjaoy/roU4/bYK9jyMR7JthmuBDSzc2k+boOeAVs/4wHyM0y/hLnGUgdAyAglGwew/Ha6syimWTctX4iMxr8fxjEpDINCxmSok5yDv6OL4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Mj1qmozu; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Mj1qmozu"
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-2c0c1e08848so79095915ad.0
        for <virtualization@lists.linux.dev>; Tue, 09 Jun 2026 10:17:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1781025424; x=1781630224; darn=lists.linux.dev;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=llq4Kn5i8ui4r4izxxTvg7cm7qJE2krNstJXZkbKQn4=;
        b=Mj1qmozuf2/8NpH7QJl3TyXqMQJdic+lSW7lnrGmS578TsfFSnVP5UqW7ltRkS8RFm
         FVcOjRjxymT8j4oE71GdVYBvRc85gsdHPmfDj4MVwj/k3gnMKsITI4xp23tfTPnmXs8V
         ND29mYFmZ1e86VXvpvMjiqwW7DuwfETc7huVRFC+xkNTGDK0uf6Dj8/bDUzMclqgmvq/
         DPt1vr9QLdEd+hQuApCdxaTWhoKFmspwpfcntyqV/0N5ILatkh8KN3UC28IyXAPBHGy2
         jtpA5X/xCJ8BHO/LoOyWLCNEcFx7H7dYkatEY0H//KfN3enm+uxara9Ihh/mFVSRowJR
         y9kQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781025424; x=1781630224;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=llq4Kn5i8ui4r4izxxTvg7cm7qJE2krNstJXZkbKQn4=;
        b=sRke/AcUkqy7QsNcxfWJHpFQZWEmeeA9beJGCbt36mKGoN5GKQx7tdAlkLSHu+mqy8
         HLaBf7NpWihDFIN1pLlAWkoCv2fZpB+jkxHGJhGP/ndc3fRkBsl2S5BMxNKjdfiJ7uYT
         YEl8LbC3h9aSsJeBfkNKs7nc6XmT6OxTUN5wf2/PWGRtRdQhw2w+PBV5U/rCT4d6DiQj
         0/sTiaN+WPICekNQSloVBo3D+uIxk2AHtIT8n5YQ7PPTied6UoryGs2hzwvBNC6n4XSH
         zzwQDaCf7Itg/vHdXdiFcwYtG8Yvt8makuBbL6yfRtuwnzsooCfVP4oP0SfUWc+leLrH
         on7A==
X-Forwarded-Encrypted: i=1; AFNElJ+VngFPtIvdyVnIflAr92c8UKdiGe+STNI+MTnYI8K1QEq3NrCRRKeb+f4ai5rb3xu1BmWWulGkXeMHIwdIFA==@lists.linux.dev
X-Gm-Message-State: AOJu0Yy5TAPAXizszsKCNQvIQJqaC9XSH3KHb/yv5BbnAUM7NT9KjL7w
	4RD5rHi2rBKCmthpp0b+HqQBImPIbzcWusIStl/lCqStcLwbCKZ2F35hmvyx4JlXesW+ntMAwYu
	ie6h6XQ==
X-Received: from plpg1.prod.google.com ([2002:a17:902:9341:b0:2bd:1ca5:b928])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:196b:b0:2be:3434:4e28
 with SMTP id d9443c01a7336-2c2a1c66522mr44737215ad.19.1781025423861; Tue, 09
 Jun 2026 10:17:03 -0700 (PDT)
Date: Tue, 9 Jun 2026 10:17:03 -0700
In-Reply-To: <87a4t86a0l.ffs@fw13>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20260529144435.704127-1-seanjc@google.com> <20260529144435.704127-2-seanjc@google.com>
 <87fr315fq9.ffs@fw13> <aiMPxl5vkvJDldi9@google.com> <87a4t86a0l.ffs@fw13>
Message-ID: <aihKj-0nP7bUbNHH@google.com>
Subject: Re: [PATCH v4 01/47] x86/tsc: Never re-calibrate TSC frequency if its
 exact timing is known
From: Sean Christopherson <seanjc@google.com>
To: Thomas Gleixner <tglx@kernel.org>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Ingo Molnar <mingo@redhat.com>, 
	Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	Kiryl Shutsemau <kas@kernel.org>, "K. Y. Srinivasan" <kys@microsoft.com>, 
	Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>, 
	Dexuan Cui <decui@microsoft.com>, Long Li <longli@microsoft.com>, 
	Ajay Kaher <ajay.kaher@broadcom.com>, Alexey Makhalov <alexey.makhalov@broadcom.com>, 
	Jan Kiszka <jan.kiszka@siemens.com>, Andy Lutomirski <luto@kernel.org>, 
	Peter Zijlstra <peterz@infradead.org>, Juergen Gross <jgross@suse.com>, 
	Daniel Lezcano <daniel.lezcano@kernel.org>, John Stultz <jstultz@google.com>, 
	"H. Peter Anvin" <hpa@zytor.com>, Rick Edgecombe <rick.p.edgecombe@intel.com>, 
	Vitaly Kuznetsov <vkuznets@redhat.com>, 
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, 
	Boris Ostrovsky <boris.ostrovsky@oracle.com>, Stephen Boyd <sboyd@kernel.org>, kvm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-coco@lists.linux.dev, 
	linux-hyperv@vger.kernel.org, virtualization@lists.linux.dev, 
	xen-devel@lists.xenproject.org, David Woodhouse <dwmw@amazon.co.uk>, 
	Tom Lendacky <thomas.lendacky@amd.com>, Nikunj A Dadhania <nikunj@amd.com>, 
	David Woodhouse <dwmw2@infradead.org>, Michael Kelley <mhklinux@outlook.com>
Content-Type: text/plain; charset="us-ascii"

On Fri, Jun 05, 2026, Thomas Gleixner wrote:
> On Fri, Jun 05 2026 at 11:04, Sean Christopherson wrote:
> But we also should have a check in the TSC init code somewhere which
> validates that X86_FEATURE_CONSTANT_TSC is set when
> X86_FEATURE_TSC_KNOWN_FREQ is set. X86_FEATURE_TSC_KNOWN_FREQ is useless
> w/o X86_FEATURE_CONSTANT_TSC.

Ugh, any objection to punting on this for now?  KVM and Xen guests will trigger
TSC_KNOWN_FREQ without CONSTANT_TSC, thanks to commits:

  e10f78050323 ("kvmclock: fix TSC calibration for nested guests")
  898ec52d2ba0 ("x86/xen/time: Set the X86_FEATURE_TSC_KNOWN_FREQ flag in xen_tsc_khz()")

Hyper-V guests might as well?  Hyper-V's handling of TSC is weird, even for a
hypervisor.

Even when the frequency is provided in CPUID by the hypervisor, QEMU at least
requires a fairly explicit opt-in to advertise CONSTANT_TSC, presumably to try
to prevent users from shooting themselves in the foot.
