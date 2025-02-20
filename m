Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE72020E718
	for <virtualization@lists.linux.dev>; Thu, 20 Feb 2025 23:51:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740095476; cv=none; b=D9+obeZlY2Bhv9+NLwRZ+lzjlc3y7BoW//pFQpLEiW1K5z73JTcYgklF007bL0fggGhfUEfBrn1tdEvwfOHB0GCh1QSYFxnNoVWHlKZwN62qBPpJ1O03lgDtZpud/LVLsi5p+9Yng/gQSNB8K5ss0v1OvEWIm6pe22eOHCI3VN8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740095476; c=relaxed/simple;
	bh=UdWhNOUBSdT4syJ+kosIuq0AfZUSJ0WGNQkI3p+ncvM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sI9dN44WnCO+t6vr+oiFSwYWVSBtB2JkF/cZc8UdsuR2IsLbmyNQsaYkIPqeHc+2Uh/K9BuYDcjvnxhC8bQSQqEAUq187xJbt5GHrSNZ9kZOWRT9vwZXuTnSjf+DBGa+0z/9Y391fK2S3Pqjq4pr8/DVOBJKwGRBDXotYQrpUpU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=dYqJVCB6; arc=none smtp.client-ip=209.85.167.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="dYqJVCB6"
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-54522e82e7dso3125e87.0
        for <virtualization@lists.linux.dev>; Thu, 20 Feb 2025 15:51:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1740095472; x=1740700272; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cF2FkYUFOzGpOUac93fgsUwfXQ+Ch5dCBcOjNCGwr4o=;
        b=dYqJVCB6xU9HEsdpKeQoYHR8BZO6QoDtl255pkj6PaAi21Fhxn+QkUA1PtNLQfXQj2
         3sxnbNNjuhUId5Sn4XYGwcEG+3snGyu1cf9D+D/C7pcUN//9IcmZQU29+Hw1QzVsS+qy
         54mDj6DE91eumNKrciWz2Wc6NTiQpLar/ZlqVqSTMsUphgGSPW6jcVCNzREBRcFLv+Ot
         4wN/7o5kHjP0S8KMOSatEPfyB/tJknnDF7KScZm7i7FEkgA1N6fmsL5xCYtLCbyBXYre
         ZVLtFTjkR6819UDrlORL81RjBMDXuabcmYrs2yAZmg6bhvDoKjCh0NFBdKK5v3Tgi8s+
         mzlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740095472; x=1740700272;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cF2FkYUFOzGpOUac93fgsUwfXQ+Ch5dCBcOjNCGwr4o=;
        b=csRtTxOU/o9AXNXYD1CiQKZbnYQHVxhTD6UREKi049/mYzJjnSZRGpRVuSlFjgU+1Q
         6PGC5r/cjOkgdKotPuoV+n/ny976LtmoKbuV4BkF6oyEvT9QZcIUYyS/s9VAXjycFCVQ
         XoKH0NrX7926BwmpXHwSoLUBIPBJCHftd9Y+w6OodTGW+V9g+xTxXiu/nkvpce4tJutQ
         XyJvjwMgZdPu0sSywnsRdXATK66AFQZFn60fRu7BeyiY1JJ5fCmEJHWDEwuffKNX7gTK
         uUzoWazOZcI4MRsROHMVxdI+68H8uK0vX67htSknsMLMGwzhlniG4KHbid+FdUDWFhCy
         EtRA==
X-Forwarded-Encrypted: i=1; AJvYcCX7FLrbWSv/oYcD9os7ofFskJiAy8iT1xwc9f1wzfMIZUJXV6H09xWiDuRv6mH+2T9WvccnN2oqYxRy5yV0Sw==@lists.linux.dev
X-Gm-Message-State: AOJu0Yw/lwrn4P1UzwmU7LwTyBVMb9x43Fkv603pUU0WDQcZehGbEA1H
	+M+n8VtEOXRJW8stbd6QXrAxLmkpB2rOhSCZ/E6lP34CVp1lXtEuzkqcRSFyYIaCYE0ntBYzFQ8
	pBZarrVTF4ej7pH7dxScwkXrmWWOnluRB5W9L
X-Gm-Gg: ASbGncukvsp76tdA8HX8N0Cj/GZln9Nmlq7vIvhBF0LQbh5DrR8/vQdB75fbZSjCJRm
	yf6q5h+5qcVnvsxmCZJ9F1X+0IS/GtrfT+GPifu+Ysc3XVBYLJCKrXbCn1xFkIGxfIezymKJQLO
	UZHpMQLkJc8bRiYmvhpj89cxcu0IgQ
X-Google-Smtp-Source: AGHT+IHNrahV1BDNb6HGmIpADFoAfSxQLvTQMK+ss0Zxtwi9sdNu6MrrXOWs+BR87xWGqTxyWHbSATFC1ErU9+Atf8g=
X-Received: by 2002:a05:6512:eaa:b0:543:e5ac:8ba9 with SMTP id
 2adb3069b0e04-5483912c478mr118346e87.6.1740095472207; Thu, 20 Feb 2025
 15:51:12 -0800 (PST)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20250220211628.1832258-1-vannapurve@google.com>
 <20250220211628.1832258-3-vannapurve@google.com> <9053a4ef-2de6-47b4-a2f7-62d3ded24cfa@intel.com>
In-Reply-To: <9053a4ef-2de6-47b4-a2f7-62d3ded24cfa@intel.com>
From: Vishal Annapurve <vannapurve@google.com>
Date: Thu, 20 Feb 2025 15:51:00 -0800
X-Gm-Features: AWEUYZnHtnB_aHba-KEBGxrwDPSTc-BtBIYPfsyILXR2O2qhE2mk2NxqrmEtVUY
Message-ID: <CAGtprH_z=4nsDj2GSnCrhwQkKESBqLTcUK3aNZO+2BzMc7P00g@mail.gmail.com>
Subject: Re: [PATCH V5 2/4] x86/tdx: Route safe halt execution via tdx_safe_halt()
To: Dave Hansen <dave.hansen@intel.com>
Cc: x86@kernel.org, linux-kernel@vger.kernel.org, linux-coco@lists.linux.dev, 
	virtualization@lists.linux.dev, pbonzini@redhat.com, seanjc@google.com, 
	erdemaktas@google.com, ackerleytng@google.com, jxgao@google.com, 
	sagis@google.com, oupton@google.com, pgonda@google.com, kirill@shutemov.name, 
	dave.hansen@linux.intel.com, chao.p.peng@linux.intel.com, 
	isaku.yamahata@gmail.com, sathyanarayanan.kuppuswamy@linux.intel.com, 
	jgross@suse.com, ajay.kaher@broadcom.com, alexey.amakhalov@broadcom.com, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 20, 2025 at 3:00=E2=80=AFPM Dave Hansen <dave.hansen@intel.com>=
 wrote:
>
> On 2/20/25 13:16, Vishal Annapurve wrote:
> > Direct HLT instruction execution causes #VEs for TDX VMs which is route=
d
> > to hypervisor via TDCALL. safe_halt() routines execute HLT in STI-shado=
w
> > so IRQs need to remain disabled until the TDCALL to ensure that pending
> > IRQs are correctly treated as wake events.
>
> This isn't quite true. There's only one paravirt safe_halt() and it
> doesn't do HLT or STI.

pv_native_safe_halt() -> native_safe_halt() -> "sti; hlt".

>
> I think it's more true to say that "safe" halts are entered with IRQs
> disabled. They logically do the halt operation and then enable
> interrupts before returning.
>
> > So "sti;hlt" sequence needs to be replaced for TDX VMs with "TDCALL;
> > *_irq_enable()" to keep interrupts disabled during TDCALL execution.
> But this isn't new. TDX already tried to avoid "sti;hlt". It just
> screwed up the implementation.
>
> > Commit bfe6ed0c6727 ("x86/tdx: Add HLT support for TDX guests")
> > prevented the idle routines from using "sti;hlt". But it missed the
> > paravirt routine which can be reached like this as an example:
> >         acpi_safe_halt() =3D>
> >         raw_safe_halt()  =3D>
> >         arch_safe_halt() =3D>
> >         irq.safe_halt()  =3D>
> >         pv_native_safe_halt()
>
> This, on the other hand, *is* important.
>
> > Modify tdx_safe_halt() to implement the sequence "TDCALL;
> > raw_local_irq_enable()" and invoke tdx_halt() from idle routine which j=
ust
> > executes TDCALL without toggling interrupt state. Introduce dependency
> > on CONFIG_PARAVIRT and override paravirt halt()/safe_halt() routines fo=
r
> > TDX VMs.
>
> This changelog glosses over one of the key points: Why *MUST* TDX use
> paravirt? It further confuses the reasoning by alluding to the idea that
> "Direct HLT instruction execution ... is routed to hypervisor via TDCALL"=
.
>
> It gives background and a solution, but it's not obvious what the
> problem is or how the solution _fixes_ the problem.
>
> What must TDX now depend on PARAVIRT?
>
> Why not just route the HLT to a TDXCALL via the #VE code?
>
>

Makes sense, I will update the commit message in the next version to
clearly answer these questions and address the above comments.
