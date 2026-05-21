Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9332F2FC876
	for <virtualization@lists.linux.dev>; Thu, 21 May 2026 21:01:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779397299; cv=none; b=P3JasKSot/zpsOq3Oo9kZthTbDLsZRf7t4GLfQqenOeKPitTNV4fUdt4Cp1S9owKIBQuaW7+ODWY5Acv3qF+TZHa6TpCztKR6ALm7+QHH32Is5uczZ+N2wHSpwXFpJsQ+YRmwFS9prXB2BWCz0yGc2ZWx+fZ9oHWtlkzhrMCM3g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779397299; c=relaxed/simple;
	bh=UTNkbHY7Wjr/dyzbQ6GvUNv1NaEz32luLYEXfy53m6g=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=lCtrfSV2MfEI5inZbwmpDRcqlSQtBSKDUDAXyo5jijwgsf9qPJqsXQdj2tR2W/TEn7CGD3giWDQTzJaB2rjSL//7LBA1m9j3GBKXHSzONybU6fPahPCBOlxfjOF+Z866mUtDzgXEsP+JCf+hKClLzTxC98LxBbP/C+ehBrgmx00=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=krXqT5rH; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="krXqT5rH"
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-2bd04e4fe3dso117368185ad.3
        for <virtualization@lists.linux.dev>; Thu, 21 May 2026 14:01:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779397297; x=1780002097; darn=lists.linux.dev;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=iN4mR6FXbVUwqAWLl+PlqYFyvLBNkg9d4d7Akdf1bJQ=;
        b=krXqT5rHcUGfzMufFvLUrUfftfp9ZEx4fn012f/SMkUNiwCHTYfb443S057/OITIlV
         ymcUVIu+Fc9UsmzIJpZJpdaR982OKL8vsgluOCJVCR1YqsTbYErQ1SWFwo682C/9T/WK
         C0zOTzMoFmzUPry/u69WXNPmE6VRDPKIj2mK+OmjS5wxcItSl0mGa+KgQW33VMUNUnN6
         lYtcqwTL0einmu/FEfy6kZQpjGI8Aiv4eII5qdP5x8WunBFe7eCQg55cPOv8rDYVU4ko
         w81o8JW0ODpg8bxHu7PXbs7TjRBU5qwxNmsd2f8H45/4GNjjj7fdFWIt1rMDKOlaE3nQ
         BjUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779397297; x=1780002097;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=iN4mR6FXbVUwqAWLl+PlqYFyvLBNkg9d4d7Akdf1bJQ=;
        b=LeKlJSGsEJeXtCWg12x7YMV/PctDUUChPncaup/Z4uFt7zs59mmKupmr7l830VBcSU
         EOAa4HTfXkb80pL09jzGlUmYBQbHgIZ7q2566sSWzyNBd8uBDNY0HUYVnTFOHXiwrW6Y
         bnMWzkmR4MZbNTa3FTzGO78U6o3KJXfrhunsYEHHEfgLYqcwnyvcldWmoqmv6hkEsCHf
         S/9BZ77UPmMi3soZv9Gq7fVte4aaG4iwAkKIvkv8DMD345VWUTpmEcgr/H0JZPjADfKU
         88u2nfPkFwR0JO8L+QQj+ECRrnY2OY25wi1umg8dXioDBzuhQI7NGSDM+BhiX378GOmK
         kY5g==
X-Forwarded-Encrypted: i=1; AFNElJ+DBEggyu0Waq17fSjhsXJB6skrvcc/qgfKdRdhRu/8qrQ/ADMnUNtJdGV3NZ1nY6TcrdfntZQZDXqri2v6Qw==@lists.linux.dev
X-Gm-Message-State: AOJu0Yzia8h397QQcPTpJt6HAPr3cC5Xh1Rk56a9k6/DRBKauIVqR3Tp
	HFlm8UbpG87J2hSAihMSKftCxEeQfNnFJMy8716xx2+UrItun8eVr7b/Gs/IxfkfZg73wznSuJg
	oeYIXaQ==
X-Received: from plge10.prod.google.com ([2002:a17:902:cf4a:b0:2bd:40d4:e407])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:e84c:b0:2ba:4ad9:70f6
 with SMTP id d9443c01a7336-2beb06aa272mr6036375ad.31.1779397296608; Thu, 21
 May 2026 14:01:36 -0700 (PDT)
Date: Thu, 21 May 2026 14:01:35 -0700
In-Reply-To: <c54fd01b-fe22-4c9c-8d5f-5b317de07a40@oracle.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20260515191942.1892718-1-seanjc@google.com> <20260515191942.1892718-38-seanjc@google.com>
 <c54fd01b-fe22-4c9c-8d5f-5b317de07a40@oracle.com>
Message-ID: <ag9yryEe0A7_AZCT@google.com>
Subject: Re: [PATCH v3 37/41] x86/kvmclock: Use TSC for sched_clock if it's
 constant and non-stop
From: Sean Christopherson <seanjc@google.com>
To: Dongli Zhang <dongli.zhang@oracle.com>
Cc: kvm@vger.kernel.org, Rick Edgecombe <rick.p.edgecombe@intel.com>, 
	Vitaly Kuznetsov <vkuznets@redhat.com>, 
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, 
	Boris Ostrovsky <boris.ostrovsky@oracle.com>, Stephen Boyd <sboyd@kernel.org>, x86@kernel.org, 
	linux-coco@lists.linux.dev, linux-hyperv@vger.kernel.org, 
	virtualization@lists.linux.dev, linux-kernel@vger.kernel.org, 
	xen-devel@lists.xenproject.org, Kiryl Shutsemau <kas@kernel.org>, 
	Paolo Bonzini <pbonzini@redhat.com>, "K. Y. Srinivasan" <kys@microsoft.com>, 
	Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>, 
	Dexuan Cui <decui@microsoft.com>, Long Li <longli@microsoft.com>, 
	Ajay Kaher <ajay.kaher@broadcom.com>, Alexey Makhalov <alexey.makhalov@broadcom.com>, 
	Jan Kiszka <jan.kiszka@siemens.com>, Dave Hansen <dave.hansen@linux.intel.com>, 
	Andy Lutomirski <luto@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Juergen Gross <jgross@suse.com>, 
	Daniel Lezcano <daniel.lezcano@kernel.org>, Thomas Gleixner <tglx@kernel.org>, 
	John Stultz <jstultz@google.com>, Michael Kelley <mhklinux@outlook.com>, 
	Tom Lendacky <thomas.lendacky@amd.com>, Nikunj A Dadhania <nikunj@amd.com>, 
	Thomas Gleixner <tglx@linutronix.de>, David Woodhouse <dwmw@amazon.co.uk>
Content-Type: text/plain; charset="us-ascii"

On Thu, May 21, 2026, Dongli Zhang wrote:
> On 2026-05-15 12:19 PM, Sean Christopherson wrote:
> > Prefer the TSC over kvmclock for sched_clock if the TSC is constant,
> > nonstop, and not marked unstable via command line.  I.e. use the same
> > criteria as tweaking the clocksource rating so that TSC is preferred over
> > kvmclock.  Per the below comment from native_sched_clock(), sched_clock
> > is more tolerant of slop than clocksource; using TSC for clocksource but
> > not sched_clock makes little to no sense, especially now that KVM CoCo
> > guests with a trusted TSC use TSC, not kvmclock.
> > 
> >         /*
> >          * Fall back to jiffies if there's no TSC available:
> >          * ( But note that we still use it if the TSC is marked
> >          *   unstable. We do this because unlike Time Of Day,
> >          *   the scheduler clock tolerates small errors and it's
> >          *   very important for it to be as fast as the platform
> >          *   can achieve it. )
> >          */
> > 
> > The only advantage of using kvmclock is that doing so allows for early
> > and common detection of PVCLOCK_GUEST_STOPPED, but that code has been
> > broken for over two years with nary a complaint, i.e. it can't be
> > _that_ valuable.  And as above, certain types of KVM guests are losing
> > the functionality regardless, i.e. acknowledging PVCLOCK_GUEST_STOPPED
> > needs to be decoupled from sched_clock() no matter what.
> 
> Has it been broken for two years because of pvclock_clocksource_read_nowd()?

Yep.  Because pvclock_clocksource_read_nowd() ignores PVCLOCK_GUEST_STOPPED, the
flag only ever gets recognized when the kernel reads WALL_CLOCK, which AFAICT
only happens at initial boot, and during suspend and resume.
