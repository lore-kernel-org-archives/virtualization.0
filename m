Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DAD526E951
	for <virtualization@lists.linux.dev>; Thu, 27 Feb 2025 19:27:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740684430; cv=none; b=QIx5wNbKzAYw+jF1qFlu3MECYtN2Y2PVNmbJDT0HcPqT5qby7eftvZeobRMtfj0S8OYluK84oudhiw7GAS5tTyPaPQl0H1c3SDaXWTnkJ01L7g3xX51cvfKmmmScYlQsnJroqmd6rjCj9FkVBsZgMbn6t8wHD6WfcRfWykVZpDU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740684430; c=relaxed/simple;
	bh=d1Qxg472CkVrkJspIto61QqE2XsIjtKw5J3xPkJikcY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uQkvF9/37XkMyOgQknNt9Md6SofqYb32jBi5AnBAxIXr/Bm6f9kXV/OQTGxubSVdrlnxSz3+btfrc2ZsK+DzCmIjZn2i84jnOcFG01azn4mRpNn5SMb6wPpvoVM3I7+V7EBNzBZLBkPQKdd+bPAT+gtcm97VaQ18ovbSHhj5Lpg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ncujX4Qa; arc=none smtp.client-ip=209.85.167.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ncujX4Qa"
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-54843052b67so1284e87.0
        for <virtualization@lists.linux.dev>; Thu, 27 Feb 2025 11:27:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1740684426; x=1741289226; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UtLSNJVT+92AMNNdy2v/ceT4EU9CKE0f6wRbNLrZ7oU=;
        b=ncujX4QaZiLCXbCo0ltrqrD69sRWGEqsbvsdzCXWVFO1BkheGVTrH0V5Qqc+Jo2Fhx
         1MxzXzbdswKUDx1fJmCl0jlSgB6axGY/nldV+gk2TbvB3bD5Dt+g1tg/qdCiQ3YdSjtp
         ZfsKlHqYJyih0aU6y6o1P821WsA94JOPdZjj3Z+HRovtvT4N75vjPBoZdT9X3wpJexnJ
         0fbFdJOl85FoDoVXiTLE+yHKT/dOLOmzOHXeVY5LeUYdTDq3Te2vkTYTba3BZNMYuhZL
         sOC8Gasc5OF5cFfHaRE++fCFzWQ8exMpMsekZZ5KmDGFL1caPDcetxIUTl5HqRcAym6D
         krVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740684426; x=1741289226;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UtLSNJVT+92AMNNdy2v/ceT4EU9CKE0f6wRbNLrZ7oU=;
        b=b0+Jd2jf2/8CUGPtfheuG4UGO14uRf9BdPldGY7/C2lvt/w3No8IsQUZgy8lKwiGvF
         EdcQLRTFc/C/VUX+IlxpG8UBRKwlcl+cOHkJ+PkQMI7PTsgFnLXnnbLw3FMTuiNcvBJq
         E2FHS8AM/cYsJ+Mwo2azpUlZXL0rdg2P29+yLzCtrGQG2cGfAItjE0/jiGUKKAB+nbYQ
         WWnRX5muHOALF+GcHvDM5uob+ePlUsaKDS+3i633cCKNBirXOWEL52U/aK7QfPW9e8uO
         Q/lC2cdYr9Uve8/EcoUEq0TinR8vl5jqzZPsioODDfuXr+ncwz7Bbuh2AdqoGUj2UQDX
         04EQ==
X-Forwarded-Encrypted: i=1; AJvYcCW92hGMCrusnagg7FxAQ51wBAz/TYdwZT8YGqDMEtqcpqRp4OmAafJZUfq6rhSbXbWpCJ7rSHcihzNYBFtZiw==@lists.linux.dev
X-Gm-Message-State: AOJu0YycCDQQ3PeKODDGZeY4S+hiPlLCQy3z68eH4IMc6MoVPT8ATecs
	XHuY0yyqRjTgvFsbb9H4JHAb4YS6CVLS/v+8m6a+3uQQTR41yuBspn3b7mRwXrMLMGpt9ogwU7r
	XETA31Whrmkdc7cZ5VMgtYzXjsuy4CzeZiQ1A
X-Gm-Gg: ASbGncsvTB34W30okxT+SdtiAGAZYgeN0TiUHed2u3/SM+NwgB0SOJfzwWgU6XLQD8w
	owvNf6UreBaD36W60CoyBQ2jdYipD8lZlf0askhz/nV8SjRpw4OCC+4RDfqNalQdh4AtLV66hnb
	J2oRnpdu4guyeFycpOAs1TGBTwheYl7nhEiiNc5xbd
X-Google-Smtp-Source: AGHT+IEdSIwybUjSkkV5vNkBMcDTqOmFlDjP0ogUFLrcyG7hy/eEgdi+TbKAXYt1FUTQRVem2blej27QUoMzQ6ig7ik=
X-Received: by 2002:a05:6512:3a84:b0:543:cf0c:ed14 with SMTP id
 2adb3069b0e04-5494debd8fdmr16005e87.5.1740684425486; Thu, 27 Feb 2025
 11:27:05 -0800 (PST)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20250225004704.603652-1-vannapurve@google.com>
 <20250225004704.603652-3-vannapurve@google.com> <pvbwlmkknw7cwln4onmi5mujpykyaxisb73khlriq7pzqhgno2@nvu3cbchp4am>
In-Reply-To: <pvbwlmkknw7cwln4onmi5mujpykyaxisb73khlriq7pzqhgno2@nvu3cbchp4am>
From: Vishal Annapurve <vannapurve@google.com>
Date: Thu, 27 Feb 2025 11:26:53 -0800
X-Gm-Features: AQ5f1JpNkvOxWDJlk_d64tma-tOWc1scSvqjWSXHu6nUjd70ID7CCmOSArfFMN8
Message-ID: <CAGtprH8mxENaH-Y0=b0kKJio=EG0OKt_qeguRBJECagXL4poPA@mail.gmail.com>
Subject: Re: [PATCH v6 2/3] x86/tdx: Fix arch_safe_halt() execution for TDX VMs
To: "Kirill A. Shutemov" <kirill@shutemov.name>
Cc: dave.hansen@linux.intel.com, kirill.shutemov@linux.intel.com, 
	jgross@suse.com, ajay.kaher@broadcom.com, ak@linux.intel.com, 
	tony.luck@intel.com, thomas.lendacky@amd.com, tglx@linutronix.de, 
	mingo@redhat.com, bp@alien8.de, hpa@zytor.com, pbonzini@redhat.com, 
	seanjc@google.com, kai.huang@intel.com, chao.p.peng@linux.intel.com, 
	isaku.yamahata@gmail.com, sathyanarayanan.kuppuswamy@linux.intel.com, 
	erdemaktas@google.com, ackerleytng@google.com, jxgao@google.com, 
	sagis@google.com, afranji@google.com, kees@kernel.org, jikos@kernel.org, 
	peterz@infradead.org, x86@kernel.org, linux-kernel@vger.kernel.org, 
	linux-coco@lists.linux.dev, virtualization@lists.linux.dev, 
	bcm-kernel-feedback-list@broadcom.com, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 26, 2025 at 3:49=E2=80=AFAM Kirill A. Shutemov <kirill@shutemov=
.name> wrote:
>
> On Tue, Feb 25, 2025 at 12:47:03AM +0000, Vishal Annapurve wrote:
> > Direct HLT instruction execution causes #VEs for TDX VMs which is route=
d
> > to hypervisor via TDCALL. If HLT is executed in STI-shadow, resulting #=
VE
> > handler will enable interrupts before TDCALL is routed to hypervisor
> > leading to missed wakeup events.
> >
> > Current TDX spec doesn't expose interruptibility state information to
> > allow #VE handler to selectively enable interrupts. To bypass this
> > issue, TDX VMs need to replace "sti;hlt" execution with direct TDCALL
> > followed by explicit interrupt flag update.
> >
> > Commit bfe6ed0c6727 ("x86/tdx: Add HLT support for TDX guests")
> > prevented the idle routines from executing HLT instruction in STI-shado=
w.
> > But it missed the paravirt routine which can be reached like this as an
> > example:
> >         acpi_safe_halt() =3D>
> >         raw_safe_halt()  =3D>
> >         arch_safe_halt() =3D>
> >         irq.safe_halt()  =3D>
> >         pv_native_safe_halt()
>
> I would rather use paravirt spinlock example. It is less controversial.
> I still see no point in ACPI cpuidle be a thing in TDX guests.
>

I will modify the description to include a paravirt spinlock example.

> >
> > To reliably handle arch_safe_halt() for TDX VMs, introduce explicit
> > dependency on CONFIG_PARAVIRT and override paravirt halt()/safe_halt()
> > routines with TDX-safe versions that execute direct TDCALL and needed
> > interrupt flag updates. Executing direct TDCALL brings in additional
> > benefit of avoiding HLT related #VEs altogether.
> >
> > Cc: stable@vger.kernel.org
> > Fixes: bfe6ed0c6727 ("x86/tdx: Add HLT support for TDX guests")
> > Signed-off-by: Vishal Annapurve <vannapurve@google.com>
>
> Reviewed-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
>
> --
>   Kiryl Shutsemau / Kirill A. Shutemov
