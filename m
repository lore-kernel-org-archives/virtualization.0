Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56F75264631
	for <virtualization@lists.linux.dev>; Thu, 20 Feb 2025 23:17:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740093446; cv=none; b=aGxQ82l+djwkWlBnSsBkndM1vNJwQolg9zzZgHt6In1zc7q68clr1Q8YP66StllWPzmmoLEOcepD2PTpPj4RG28DrYEzshWFe9RPK9OndsSfZYR71p2N3DC5Kef4WhQe/GA7TnPHLNqn97nCopBDUn5r/Nr4Qo3tFjiwq6yQKRw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740093446; c=relaxed/simple;
	bh=1cIjuvp4munwp36O0Su27G+k3yaY66vxM/AalS2J9ro=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=M2bf7scXE/4FC7A5viTg1l3S12OQi2IjSkD08WNtbuNRupMLsOhM43No/M8SHIAPpSR3L/lyU6ST7N9jmHFsYZsb1LMR3yjIl/PY1FiI5JDJ9G0ydXV5ZOrVlQc2LYGbykJuerIL/zXQia6fEXd5SSvKh8mBgwBffIjPRxlqMz4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=KNV5v92b; arc=none smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="KNV5v92b"
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-54522e82e7dso2937e87.0
        for <virtualization@lists.linux.dev>; Thu, 20 Feb 2025 15:17:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1740093442; x=1740698242; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yRORyKgcdd4uVm+XGlcno7rV+y967/k6WA8VcDaJDCw=;
        b=KNV5v92bUGO82CB6XfHMGJs9DqAMh7c4qf8UNKwNSs6eOhuTBQ16n2oktA3f5jUJVI
         nsKQoa3GeduA65YcHhmcgbRVtr/AsLUSvtZ15mCh00efqPqUCUfCl8q4gei0jV7VlppG
         O/cfA1wFYcJrpKsgLKnJ0R4E9wBFS/Rb3//55kZ1WB9Zt7qePueDGiOWEBzKyCrO7eMO
         dG28eJjyj24+DmeYrSRocIPghDH6IDDZF338JiGepICYOdFpF48dVFikMYN9koG6/oyu
         xt+b9qGlV9QUeDTOTwyZOfjUrB7k2sE5BOLBX0X6+4tMWDYG7X7GF1EL0xgSsA/SU7qV
         YtuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740093442; x=1740698242;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yRORyKgcdd4uVm+XGlcno7rV+y967/k6WA8VcDaJDCw=;
        b=wyIXTI6matu8fsMfS83qKh9xjGy5DaAFoa+qpcnvq1ng33RPZa1qPawjTzFwi1TFWT
         /hUUqrYoIKqiIdPl4JGQ4tLzypWJQsFvn92LJLBEmfCvKVsf55FLsqipbP6a/iX0TI7x
         MyZqz6QuoE9i5YmYgzwwxxPRLYPYOfq54kmunSVXqatWOuh0U9Q1WOC2eegQLC3/q5Zz
         yNHjD7vUOY6mjVCVxWL4D0Fm1d2xzNOBmIn389k1KAB3k4akHoDX2hvsqrwmnLwSd64S
         h6ctGnxPtb03PzktR9tB03FhZNDdWtN5YitkLde7CLgGDBeE3CCR9Vp6MP7xmet85PYv
         mRew==
X-Forwarded-Encrypted: i=1; AJvYcCULeK7eARFsQLcTNS1BEHnqUhTTsyMx8vve+n9h3zGxrmUR2iGcFuySL4xzH9dREVqqY/lOfZsgAkL1xH2byQ==@lists.linux.dev
X-Gm-Message-State: AOJu0Yw9rjfQLDSVdDLHPMjCwEbQTgV2Er7cTXE47e/T9ztKIimimOUq
	yR/tKVBxV9LBJpp0WWOuJWnExo3OYFAZ9rHRwCURYRwZgkWeMPWTQagVIdYsi2TscYZylapq7X/
	toaE4YomxioQHbD4IaWNbYxdZKyqSIpnEDzYd
X-Gm-Gg: ASbGncsFCzMFOtxWTKaDdiaJ8bTMdsvL/1DOIOcj8aJIQJqD1h5ZivNjs8qTlie7XyS
	AJZ7YFjasIUlfGJ3RP5b16xcxIXu+46VvaTgD8gj9S2AwGRKIkuPvxqwohmI/zWjFlFLoyHtvFn
	/O4SVYC9ZLg1ChW0p79uP8tMqBk1oZ
X-Google-Smtp-Source: AGHT+IEWQiBc288yYrLCTppIrbxa3qN0HBmgiL7WK6l/eN2zlTxhCP/B74cPGse/0Iz95hyG2RtMrjG+GdCe2cYgGKw=
X-Received: by 2002:a05:6512:124f:b0:545:2301:b1c6 with SMTP id
 2adb3069b0e04-54839f9c24dmr36007e87.7.1740093442260; Thu, 20 Feb 2025
 15:17:22 -0800 (PST)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20250220211628.1832258-1-vannapurve@google.com>
 <20250220211628.1832258-2-vannapurve@google.com> <9120e074-52af-4ae5-a08c-e62a879c7ebb@intel.com>
In-Reply-To: <9120e074-52af-4ae5-a08c-e62a879c7ebb@intel.com>
From: Vishal Annapurve <vannapurve@google.com>
Date: Thu, 20 Feb 2025 15:17:10 -0800
X-Gm-Features: AWEUYZlcMEtt0DdUpswWfn-2RnJ9b7h7OlP4aU2QsZo74T1M7MMOMNFwfs29_Zg
Message-ID: <CAGtprH-utPk=u938odDYAWAFLSZj+OhVH_k_RCHc87k3eqm0jQ@mail.gmail.com>
Subject: Re: [PATCH V5 1/4] x86/paravirt: Move halt paravirt calls under CONFIG_PARAVIRT
To: Dave Hansen <dave.hansen@intel.com>
Cc: x86@kernel.org, linux-kernel@vger.kernel.org, linux-coco@lists.linux.dev, 
	virtualization@lists.linux.dev, pbonzini@redhat.com, seanjc@google.com, 
	erdemaktas@google.com, ackerleytng@google.com, jxgao@google.com, 
	sagis@google.com, oupton@google.com, pgonda@google.com, kirill@shutemov.name, 
	dave.hansen@linux.intel.com, chao.p.peng@linux.intel.com, 
	isaku.yamahata@gmail.com, sathyanarayanan.kuppuswamy@linux.intel.com, 
	jgross@suse.com, ajay.kaher@broadcom.com, alexey.amakhalov@broadcom.com, 
	"Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>, stable@vger.kernel.org, 
	Andi Kleen <ak@linux.intel.com>, Tony Luck <tony.luck@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 20, 2025 at 1:47=E2=80=AFPM Dave Hansen <dave.hansen@intel.com>=
 wrote:
>
> On 2/20/25 13:16, Vishal Annapurve wrote:
> > Since enabling CONFIG_PARAVIRT_XXL is too bloated for TDX guest
> > like platforms, move HLT and SAFE_HLT paravirt calls under
> > CONFIG_PARAVIRT.
>
> I guess it's just one patch, but doesn't this expose CONFIG_PARAVIRT=3Dy
> users to what _was_ specific to CONFIG_PARAVIRT_XXL=3Dy? According to the
> changelog, TDX users shouldn't have to use use PARAVIRT_XXL, so
> PARAVIRT=3Dy and PARAVIRT_XXL=3Dn must be an *IMPORTANT* configuration fo=
r
> TDX users.
>
> Before this patch, those users would have no way to hit the
> unsafe-for-TDX pv_native_safe_halt(). After this patch, they will hit it.

Before this patch, those users had access to arch_safe_halt() ->
native_safe_halt() path. With this patch, such users can execute
arch_safe_halt -> pv_native_safe_halt() -> native_safe_halt(), so this
patch doesn't cause any additional regression.

>
> So, there are two possibilities:
>
>  1. This patch breaks bisection for an important TDX configuration
>  2. This patch's conjecture that PARAVIRT_XXL=3Dn is important for TDX
>     is wrong and it is not necessary in the first place.
>
> What am I missing?
