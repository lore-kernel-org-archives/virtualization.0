Received: from mail-vk1-f179.google.com (mail-vk1-f179.google.com [209.85.221.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 028D2664C6
	for <virtualization@lists.linux.dev>; Tue,  3 Dec 2024 01:45:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733190308; cv=none; b=IrhsgDul9zQ8uzXp3QsoblgmI1raX8Dj8UmcJtCEpnlIXQ8Pd+RoSeM27+Co9uI4o7k5Ter6LYbF1OAHRlzOEN4k+XiZrH4q7aJBh9/IpeTxfoy6FosS41Ywhd9RSH4CN57sLBuPvqskNhbFZ5nq2DTcCBKEwd2KkQGDfHI3Eks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733190308; c=relaxed/simple;
	bh=HbuFI/riZulpFH9oeFjnjmTcBp+J3kMI3l1dSbEdv+8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JOTgz0JPgn7+1eqwt5XqzMySvIp0qxw+uUUS3X/HuaIv2/7oYs6zvahQYTmHDdKCGZexL9qDt+tiWZat0E1Uv+TFnxgX+140Ft81dsyZ8hXI0SnMYaDzjfqL23pBRta0mabdTvc80oBNXK/ULLZM/Y0JJgY1spf8rVtGvoWMBnw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=HGSrFENI; arc=none smtp.client-ip=209.85.221.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="HGSrFENI"
Received: by mail-vk1-f179.google.com with SMTP id 71dfb90a1353d-5152377321cso1262572e0c.2
        for <virtualization@lists.linux.dev>; Mon, 02 Dec 2024 17:45:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1733190305; x=1733795105; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wscqKrTwFb9sgoc/UfAh+DpARa9frP273Npy3sEJYN8=;
        b=HGSrFENIaCSf5vpGl+ukmG2z8fkF2WgGYM3TzdfKgHh08yZh1B9cJFPf13sIH95jlC
         cZTOjJ06MT0y4zH8wQ7yVVj/fV1v9tUrWcF3AwRee5UF20lCyiFZ50dq5BLhhuHGlG9w
         71yVjPKE81Gl1WTfjhIOD8lfMnoOVY4YfpvohGGitDMle6rIlx1QIRNx3mw4YwL9V+QC
         RurCSGMeB72IhN5hs7m+zJTrgHwBAjgNZpH14xENFS71rBfCqUXh8TcPqad1rOk99r3w
         CO8QeW+EoeTvJkp8RxR8RSlYVfPEon/shx/btJAaaciuWU1UBCsbO+XYTfadkHL4zmVd
         hkRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733190305; x=1733795105;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wscqKrTwFb9sgoc/UfAh+DpARa9frP273Npy3sEJYN8=;
        b=DJHSJkMCOcAZYk1T4hvIKjIM0WVzxjdrcIzp+HWM8LIoGRHTgpw76H8g7fxd/TH6Sx
         x3QUc4Yx/zo1jP9/A/AFmPuHYiwmdD2S8vPpzzkfvA11iTltXaxb3VLOgxsNgLxNCe1k
         AJveJf/+bMqAa3Lo9aaEF/gVGGBed18gQtk8Ay6KuMwWZK6ICsJ7NlDUzsPMLspwzi9n
         aj8eeBSp1evJajVPPeZEk2sVceC9NM+nXPWc+bK1Ir6dsOCb1P+ghCmMHuHeL2b7srYZ
         gClb6bj58xAxBbUuPKem/lgm3IO3nQ6gwxUStBNdh7hPrUd2toELchTYTBQfYaBjjtJI
         qV2A==
X-Forwarded-Encrypted: i=1; AJvYcCWyRGrPU4rYvKx5fP06kTYgYke6e6sk4HiROT88CSGh+Wf4AqOlp4WMfZU7hHe+dOT/8Ci01bQV6F5luxXzCA==@lists.linux.dev
X-Gm-Message-State: AOJu0YzgFysdmtMVmTq3UIYCctTrrlNaVrGABeLJ7ZLWroM4B/EDfFeu
	TdvRD7BW8bx3Nm6HVwGajeMgEOcKYsnsZGEOxv0cz6fhbnMiuUsA6gWbZyeX8kn3AnYJjYBcxCk
	I/zyKn2pVICV+KGVkTz3lsbxEB56u21LL2WK5
X-Gm-Gg: ASbGncsMLFCgVXlHrXkYQhamflFlcIaN935mTuV1HSAMUgMikNhLpTkAHZEdsEtAT4J
	5gSomGDmNu7AV1yWCqRupNmPeO6ulVCy6
X-Google-Smtp-Source: AGHT+IEp0cLLV0HS2GVNv35k+CB8WVNUZpet9fwmVxa/fQluHk3o8PZV+wDlJqqbk9+pA1JRUyjCGBWE6ek73EZak9c=
X-Received: by 2002:a05:6122:169a:b0:515:4fab:2e53 with SMTP id
 71dfb90a1353d-515bf56cea7mr1114649e0c.7.1733190304632; Mon, 02 Dec 2024
 17:45:04 -0800 (PST)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20241203005921.1119116-1-kevinloughlin@google.com>
 <20241203005921.1119116-2-kevinloughlin@google.com> <a9560e97-478d-4e03-b936-cf6f663279a4@citrix.com>
In-Reply-To: <a9560e97-478d-4e03-b936-cf6f663279a4@citrix.com>
From: Kevin Loughlin <kevinloughlin@google.com>
Date: Mon, 2 Dec 2024 17:44:53 -0800
Message-ID: <CAGdbjmLRA5g+Rgiq-fRbWaNqXK51+naNBi0b3goKxsN-79wpaw@mail.gmail.com>
Subject: Re: [RFC PATCH 1/2] x86, lib, xenpv: Add WBNOINVD helper functions
To: Andrew Cooper <andrew.cooper3@citrix.com>
Cc: linux-kernel@vger.kernel.org, seanjc@google.com, pbonzini@redhat.com, 
	tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, 
	dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com, 
	kvm@vger.kernel.org, thomas.lendacky@amd.com, pgonda@google.com, 
	sidtelang@google.com, mizhang@google.com, virtualization@lists.linux.dev, 
	xen-devel@lists.xenproject.org, bcm-kernel-feedback-list@broadcom.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 2, 2024 at 5:28=E2=80=AFPM Andrew Cooper <andrew.cooper3@citrix=
.com> wrote:
>
> On 03/12/2024 12:59 am, Kevin Loughlin wrote:
> > diff --git a/arch/x86/include/asm/paravirt.h b/arch/x86/include/asm/par=
avirt.h
> > index d4eb9e1d61b8..c040af2d8eff 100644
> > --- a/arch/x86/include/asm/paravirt.h
> > +++ b/arch/x86/include/asm/paravirt.h
> > @@ -187,6 +187,13 @@ static __always_inline void wbinvd(void)
> >       PVOP_ALT_VCALL0(cpu.wbinvd, "wbinvd", ALT_NOT_XEN);
> >  }
> >
> > +extern noinstr void pv_native_wbnoinvd(void);
> > +
> > +static __always_inline void wbnoinvd(void)
> > +{
> > +     PVOP_ALT_VCALL0(cpu.wbnoinvd, "wbnoinvd", ALT_NOT_XEN);
> > +}
>
> Given this, ...
>
> > diff --git a/arch/x86/kernel/paravirt.c b/arch/x86/kernel/paravirt.c
> > index fec381533555..a66b708d8a1e 100644
> > --- a/arch/x86/kernel/paravirt.c
> > +++ b/arch/x86/kernel/paravirt.c
> > @@ -149,6 +154,7 @@ struct paravirt_patch_template pv_ops =3D {
> >       .cpu.write_cr0          =3D native_write_cr0,
> >       .cpu.write_cr4          =3D native_write_cr4,
> >       .cpu.wbinvd             =3D pv_native_wbinvd,
> > +     .cpu.wbnoinvd           =3D pv_native_wbnoinvd,
> >       .cpu.read_msr           =3D native_read_msr,
> >       .cpu.write_msr          =3D native_write_msr,
> >       .cpu.read_msr_safe      =3D native_read_msr_safe,
>
> this, and ...
>
> > diff --git a/arch/x86/xen/enlighten_pv.c b/arch/x86/xen/enlighten_pv.c
> > index d6818c6cafda..a5c76a6f8976 100644
> > --- a/arch/x86/xen/enlighten_pv.c
> > +++ b/arch/x86/xen/enlighten_pv.c
> > @@ -1162,6 +1162,7 @@ static const typeof(pv_ops) xen_cpu_ops __initcon=
st =3D {
> >               .write_cr4 =3D xen_write_cr4,
> >
> >               .wbinvd =3D pv_native_wbinvd,
> > +             .wbnoinvd =3D pv_native_wbnoinvd,
> >
> >               .read_msr =3D xen_read_msr,
> >               .write_msr =3D xen_write_msr,
>
> this, what is the point having a paravirt hook which is wired to
> native_wbnoinvd() in all cases?
>
> That just seems like overhead for overhead sake.

I'm mirroring what's done for WBINVD here, which was changed to a
paravirt hook in 10a099405fdf ("cpuidle, xenpv: Make more PARAVIRT_XXL
noinstr clean") in order to avoid calls out to instrumented code as
described in the commit message in more detail. I believe a hook is
similarly required for WBNOINVD, but please let me know if you
disagree. Thanks!
