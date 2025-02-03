Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCD661552EB
	for <virtualization@lists.linux.dev>; Mon,  3 Feb 2025 22:03:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738620204; cv=none; b=XGPzHfP8gL4W9jDtr2KSKXRc5kUCBGrlRkk0KJi3eA2h67d+Vn8j7wHQFRZffO0LOd3g3eBZHFCZzMKH1ix+yokoFFE3XKFS7hRZzSg6/wugxaFIiHW00xEBmYkaQJ+g4BYL6Qz+qhprBd3Hex/+iRmBHwFKtwDNMAqxi4o3scs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738620204; c=relaxed/simple;
	bh=eUs8Te/3qXoZlaU+lsAvePAAnsKpOkJeJh7kJfdkLCY=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=SZXZtzS6vUS8r8J4m4z7Q4sLqtiPzKtz1qlDjQ3dUSqRXRqBgFO24vf1F6pIDksJ44bipE/GnAK/I5mACHlEHWArK6nvyLvoy9EP+mHpaKqP95ZWVHM2rZDSwN2vLYDk4/WMOC0yWHAkxAtgwbAQ5O2+iMEQv07AlG7qGRDjDv0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=cn4ipmJl; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="cn4ipmJl"
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-2f780a3d6e5so9395134a91.0
        for <virtualization@lists.linux.dev>; Mon, 03 Feb 2025 14:03:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1738620201; x=1739225001; darn=lists.linux.dev;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=aKyU5o4qg4MzJLbHNBTuIVedrQGzcqdvvxUHOUnfSU8=;
        b=cn4ipmJlWfwXkwk/w6QcY9qi1GKqHMKyRThiDv21MbsCGQCQiseZwWvb+L0C3muYey
         r6J/FrtcG6hpUISZRaXE//3odYZ51iPxVv5/espc58x0KVaMF/xD54OeDNVJ2pqYaqZK
         CcC2fF/yEl3TB4+sey3xp1mLXWiRL7vJUY6UZBIdetKVmeEFhx2pmqWpTphCHi7pzsi/
         gHf6g54iRkfSEdxwvETBuVBfAO1/QCv2QaoL+BZkMVVCW+XgbQ3c6V47Vz9Q7hR6Rk8U
         rkrlt/ItpraCCUI5CfPCD7E5ZcdqoqlXjLB+oYAJXQxiFoOs/8Gn1oof0Aa/RJK9kaWF
         tlQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738620201; x=1739225001;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=aKyU5o4qg4MzJLbHNBTuIVedrQGzcqdvvxUHOUnfSU8=;
        b=M8YUUHGOjpAk1kL6alRP16CEM+pnBrZs/LVRH/7/pMYbbhn6cIaB1yetFcTBqBO7ZD
         Hrv1koGdJJ8ecX57pQDs7c4FrTMCk2odBnThtbjqp5W+5LO0mgu87DPXpedNoMGtOEY7
         kTgmUjqlbNJLgvNZ3mV3zJvyTfoRCWK4rputm9tg0taanhede6/aAeVKPO0B2nzSzreW
         v4t/ftudp6H3OyfvIodWcewP1hQZPAbfuxCXTiioKK/9gkNYSBf3zl06XtA1+AvWVbMG
         jnX1YWaJTrCbouJxGfHXMUQ4Oi26PZZB+sUb+V2h8aXK2jA23AMbV1bNc0cELXL3o6+a
         RWlw==
X-Forwarded-Encrypted: i=1; AJvYcCWs9Th4aQWWjc4DHysLL45r7fUbZoUlcZTPGjD+j8DYfrkeH1ll03Ow3C+sjjR/w0UfuUuXcie4ENtCgDoKxQ==@lists.linux.dev
X-Gm-Message-State: AOJu0Yw0RlLAC8FwaTlZzVuBqb1WrmFjRwxRhx71DEEN3FL1PZC89j0U
	iTI1Zdq2ee1UHF00V2aEcIYeJZ8Yc4fwM7vWHNKCTOFXnCYJxIP7mKMCqIpt6Zbx/MAynvkVr0a
	GSw==
X-Google-Smtp-Source: AGHT+IFdBp/YFKt3tvbP89npJlfJHjx2Z4+9Qkgevwe01Rjz28QPVaPLsqR/RKs2uDbYm8l82lXHNvJ4gI0=
X-Received: from pfbfb39.prod.google.com ([2002:a05:6a00:2da7:b0:728:e945:d2c2])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:acc:b0:71d:f2e3:a878
 with SMTP id d2e1a72fcca58-72fd0bc6c50mr33717772b3a.5.1738620200924; Mon, 03
 Feb 2025 14:03:20 -0800 (PST)
Date: Mon, 3 Feb 2025 14:03:19 -0800
In-Reply-To: <855xlra7yh.fsf@amd.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20250201021718.699411-1-seanjc@google.com> <20250201021718.699411-2-seanjc@google.com>
 <855xlra7yh.fsf@amd.com>
Message-ID: <Z6E9JyybI6SUWlcG@google.com>
Subject: Re: [PATCH 01/16] x86/tsc: Add a standalone helpers for getting TSC
 info from CPUID.0x15
From: Sean Christopherson <seanjc@google.com>
To: Nikunj A Dadhania <nikunj@amd.com>
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	"Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>, Juergen Gross <jgross@suse.com>, 
	"K. Y. Srinivasan" <kys@microsoft.com>, Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>, 
	Dexuan Cui <decui@microsoft.com>, Ajay Kaher <ajay.kaher@broadcom.com>, 
	Alexey Makhalov <alexey.amakhalov@broadcom.com>, Jan Kiszka <jan.kiszka@siemens.com>, 
	Paolo Bonzini <pbonzini@redhat.com>, Andy Lutomirski <luto@kernel.org>, 
	Peter Zijlstra <peterz@infradead.org>, linux-kernel@vger.kernel.org, 
	linux-coco@lists.linux.dev, virtualization@lists.linux.dev, 
	linux-hyperv@vger.kernel.org, jailhouse-dev@googlegroups.com, 
	kvm@vger.kernel.org, xen-devel@lists.xenproject.org, 
	Tom Lendacky <thomas.lendacky@amd.com>
Content-Type: text/plain; charset="us-ascii"

On Mon, Feb 03, 2025, Nikunj A Dadhania wrote:
> Sean Christopherson <seanjc@google.com> writes:
> > Extract retrieval of TSC frequency information from CPUID into standalone
> > helpers so that TDX guest support and kvmlock can reuse the logic.  Provide
> 
> s/kvmlock/kvmclock
> 
> > a version that includes the multiplier math as TDX in particular does NOT
> > want to use native_calibrate_tsc()'s fallback logic that derives the TSC
> > frequency based on CPUID.0x16 when the core crystal frequency isn't known.
> >
> > No functional change intended.
> >
> > Signed-off-by: Sean Christopherson <seanjc@google.com>
> > ---
> 
> ...
> 
> > +
> > +static inline int cpuid_get_tsc_freq(unsigned int *tsc_khz,
> > +				     unsigned int *crystal_khz)
> 
> Should we add this in patch 6/16 where it is being used for the first time ?

No strong preference on my end.  I put it here mostly to keep each patch focused
on a single subsystem where possible, since the series touches so many areas.  I
also wanted to show the "full" API in a single patch, but I agree that adding a
helper without a user is generally undesirable.
