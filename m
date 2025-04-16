Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1D0819066D
	for <virtualization@lists.linux.dev>; Wed, 16 Apr 2025 02:25:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744770337; cv=none; b=TI1TCKYFXDeQcbVbxyCe9fmH/zq036PQKq/kjY7rLK09L0FS+YnGUbLbhiIZ1w3kh80J8gfMVQF49rupu0Ny0hLujvmq9VIP3IcojGCedAkrBt0XIOc4aTYvzmpGBlAsUyn/iOJ80ETLlb3uWP/PVI8v0gOypjaKzpKl5kx7cl4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744770337; c=relaxed/simple;
	bh=Fq60TVjg8hdz7OzAED/AfXd7INuQmua9Mckrs6NN3VM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=j7mOe8fRBfbRwmD0jNbIexz2cjORqVJqM1fc6EagbCxLGEIbbsezCxX4GSM0Lv0/+1bfh5voDqLl+wWe3bU8WGb2wrG+gN5pbqSVa0u4g4kcjC9bSbBBHzSiSQ6kHSw/Ck1zlqStDQKj47JQ1pVeovbxcjTj+I+3euWBxadLc5o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=U8K3xmt1; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="U8K3xmt1"
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2242ac37caeso58835ad.1
        for <virtualization@lists.linux.dev>; Tue, 15 Apr 2025 19:25:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1744770335; x=1745375135; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=s6R1dE+WfBiT5qGwENgdRrornJr/YiHxdg8wrTb8+t8=;
        b=U8K3xmt1y2sYqXyzuNPhPm5f1B/9EOc7KiBB1YAYoOPcArvp272beJXX3NAGUAt+af
         RhfAEUdmTUQRobygtuTOegjSsu+uSTHJC092mbrPSgFxTWxZzB6qYEZOYZOaJG7AeOO8
         O+WKaAbdXZg48xVu8NAH7MYXuqn6JV1AHv6BMAOWkuvaT9vAaaQeUbOkoBoBhRQO1i1Q
         xHGvJJhL89WL+KoI4wR+ABmYWHm08aBoelwBSZ/8IhRsbhtlqXVFJiRhxNn9GaEFbOnW
         3dL75TaHVYEoWtVLcvDuDEuKK/1v93eaxjM5exq5Xi7CTWENO3pmiLmGp25tzWRu5DTH
         YSDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744770335; x=1745375135;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=s6R1dE+WfBiT5qGwENgdRrornJr/YiHxdg8wrTb8+t8=;
        b=aZtn7+8jaJUFrAcx5IlXpfEFVllqhc1ILm87jX+Ycz6pK4d7ILbYUj073zJyShaS3I
         3flL+P7FvXME+Q24V9Tv9UuBATAdr2Sm6+1k8X90F2bfOaBh9m98ss2bl+TYGWh/+Iwq
         bOX2Ol6plAIb5qEWMGpiiG+4jWrxthzC2P6Y9uO4CvTE6FDur4YaTBND/T97tYEbbl6n
         6SWhvss6aBVbz4UbeHggohzQz/SLM+sb2aCwhrMD5UsBuw3wxkQxA9FRNWXqnrqZmXQk
         6FyPizym82L+wHmyfKSQroGpKK0nOz2/KcN83LSMUI2Vb9CsaVsv/aZucOaChOehl4Ca
         narg==
X-Forwarded-Encrypted: i=1; AJvYcCV0ONeuKIHKanu+CdTACZDCOnLxTewMCBjmjvNBYYrjg+TNY9IeqeJPOzg2OmfZBSDBo2SbxsxilZSF/qKdzw==@lists.linux.dev
X-Gm-Message-State: AOJu0YytqtySYphesFiNKE2bFiEgbmS3uw6f3iaexYs2HuaqiZadtT+g
	OFU1BnfygIcefEwlFLCFi9Chtu/u1P1JXqmxilgfOoer5syKS8XtpfoO93DloYYyBRyloexGR5F
	BpeS0Yvf7Mz4IR7B4rcboFW1O9g64ZNxNVbwn
X-Gm-Gg: ASbGnctNnr/8bR4S6aFknAqalvDq9ZC5wpoLkY6Ov4EV6Keg8PhHdVl42qxclNCSrnk
	P3HSUjlYGDH+m9X2ZfxiY3RPXf/sbgNiEpNMQhoEXlUkXW4vY6tSpm7glNfndxF8/zMOiiw7vNr
	+Lcv+qvhrBfDdYv/8IJNVAkxXREFBXQvjAGebQcQYXmlUZijRCcY98MjY=
X-Google-Smtp-Source: AGHT+IG9RiKIlFiaf5R//EGgfl+L5t1otqcCAe6fn0MT3S3JpXCs/7FHbJfIZvFN/RP5dz9VHtsw0EA1mQA/tyEw6vE=
X-Received: by 2002:a17:903:1aa6:b0:21f:631c:7fc9 with SMTP id
 d9443c01a7336-22c353bac4cmr171545ad.0.1744770334611; Tue, 15 Apr 2025
 19:25:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20250415-stable_fixup-v1-1-0bea1b5f583c@ciq.com>
In-Reply-To: <20250415-stable_fixup-v1-1-0bea1b5f583c@ciq.com>
From: Vishal Annapurve <vannapurve@google.com>
Date: Tue, 15 Apr 2025 19:25:22 -0700
X-Gm-Features: ATxdqUFoeX6dUsNwNufCHKFr6Tl2La5AmtfAgoT41BdEM1trNaeFr3d_M47Tirc
Message-ID: <CAGtprH-iO-Bk3bsqMCkdRp4xOQWzHsOVY7DDNyxh3u6AmhMBFg@mail.gmail.com>
Subject: Re: [PATCH REGRESSION-FIX] x86/paravirt: Move halt paravirt calls
 under CONFIG_PARAVIRT
To: bmastbergen@ciq.com
Cc: stable@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>, 
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	"H. Peter Anvin" <hpa@zytor.com>, Juergen Gross <jgross@suse.com>, Ajay Kaher <ajay.kaher@broadcom.com>, 
	Alexey Makhalov <alexey.amakhalov@broadcom.com>, 
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, 
	"Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>, Tony Luck <tony.luck@intel.com>, 
	Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>, 
	Andi Kleen <ak@linux.intel.com>, linux-kernel@vger.kernel.org, 
	virtualization@lists.linux.dev, regressions@lists.linux.dev, 
	Ingo Molnar <mingo@kernel.org>, Ryan Afranji <afranji@google.com>, Andy Lutomirski <luto@kernel.org>, 
	Brian Gerst <brgerst@gmail.com>, Linus Torvalds <torvalds@linux-foundation.org>, stable@kernel.org, 
	Josh Poimboeuf <jpoimboe@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

> ...
> 6.12.23 fails to build with the following error if CONFIG_XEN_PV is
> not set:
>
> arch/x86/coco/tdx/tdx.c: In function =E2=80=98tdx_early_init=E2=80=99:
> arch/x86/coco/tdx/tdx.c:1080:19: error: =E2=80=98struct pv_irq_ops=E2=80=
=99 has no member
> named =E2=80=98safe_halt=E2=80=99
>  1080 |         pv_ops.irq.safe_halt =3D tdx_safe_halt;
>       |                   ^
> arch/x86/coco/tdx/tdx.c:1081:19: error: =E2=80=98struct pv_irq_ops=E2=80=
=99 has no member
> named =E2=80=98halt=E2=80=99
>  1081 |         pv_ops.irq.halt =3D tdx_halt;
>       |                   ^
>
> This is because XEN_PV selects PARAVIRT_XXL, and 'safe_halt' and
> 'halt' are only defined for pv_irq_ops if PARAVIRT_XXL is defined.
>
> The build breakage was introduced in 6.12.23 by stable commit
> 805e3ce5e0e3 which is a backport of 9f98a4f4e721 ("x86/tdx: Fix
> arch_safe_halt() execution for TDX VMs").
>
> Consider picking up upstream commit 22cc5ca5de52 ("x86/paravirt:
> Move halt paravirt calls under CONFIG_PARAVIRT") for stable 6.12.y
> which fixes the build regression by moving 'safe_halt' and 'halt'
> out from under the PARAVIRT_XXL config.
>
> This patch is 22cc5ca5de52 backported to 6.12.23.  There were a
> couple of merge conflicts due to the missing upstream commits below:
>

Thanks Brett for looking into this. I have posted a similar patch [1]
and I see that the issue you reported is also being discussed already
[2].

[1] https://lore.kernel.org/stable/20250408132341.4175633-1-vannapurve@goog=
le.com/
[2] https://lore.kernel.org/stable/20250410180423.GA3430900@ax162/
