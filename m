Received: from mail-vs1-f41.google.com (mail-vs1-f41.google.com [209.85.217.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 755841ABEA1
	for <virtualization@lists.linux.dev>; Fri, 17 Jan 2025 22:56:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737154591; cv=none; b=JC9gF8GWI5Pj9k206+jhRbP7fH+xNkEYj3mtt70MjvlYLY4NWhGCBUVPtnIVJ9LbpNTcmT9alfnGkjGcVxworXdZ5fkolsVKLr3lnVrRHijrmOPVHSG4+pvbfxqi+g317mVHMYrkRClnyOz9Uk/Hsyr/1M+rGx8fQhKs1i8Oqkg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737154591; c=relaxed/simple;
	bh=MZ8k6arSOGKfXEnGEo9T6WIuiEQrTSg4uSoW0G2usmw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pTKHeC5Bn3vaKeZV5b9E9XSJaWN+wmzes5BK20U4GlY/nnGaCGhsbyYl93civv3WkV4aOjDKNl/Z8bAu1mOwHOrzGVNM/BRfiMT7s1dqpatszcpjs/Q8iICdeqV1wc7lu0t0NBoQuyXj+IPBmD+M7AeK91GxTSQ+fIyRNHBo1A0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=UDtIaEz0; arc=none smtp.client-ip=209.85.217.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="UDtIaEz0"
Received: by mail-vs1-f41.google.com with SMTP id ada2fe7eead31-4aff5b3845eso835062137.2
        for <virtualization@lists.linux.dev>; Fri, 17 Jan 2025 14:56:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1737154588; x=1737759388; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=he366X0vqCY56I+SCllNk/+7JBZP0gskgWoZG7rnpZU=;
        b=UDtIaEz0Tj0Jl+JhqNxArkFIG/7yVwIiRjatStzAqady4Q5EGH0bC5EedezuEWavXi
         FOGPuPK3+/E3o2QxCiXYQGiAVzLfebCSMbQ4+/sD7t0pxKs6DMSE7ifRYO/qL9vxl8Nj
         KgzNe2urZDyn4KRqApKzyTbythRHa+0USHmJajdcG1Z3aigvX4yLH36C1dUE89790BJH
         rmchFWGxfN39jxxKu8ws9p6zRGfMdm0VEn9fU997khsJ4Su2fBIoHxAwLZWZEQgGYXVz
         /WcvhiMcnK+QvRG1JfjLKnipsqLoyBDLBGyxGOMcbZ2/wGPrUzeXe8F3WBu0oJZL1lin
         UE/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737154588; x=1737759388;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=he366X0vqCY56I+SCllNk/+7JBZP0gskgWoZG7rnpZU=;
        b=ntOYSB/fyjy9pHI53Pev3LqAY/fvs7Fivpi1a1av74oMZSqjjq5z5ycE8O0wNuGMkc
         EUkoHVgdmal7dqj2I2JnC8qlzM0Y7uavC88fL6An+4QhNqAMdP0QCyMNS/tecupT1ykV
         /VcHT2Oj4ZXKAa7QO2jqsSb1Iz7gBcSwSBoxUf1PdXDPQabGDQiFny9isN+0tfRNmvKQ
         PZ7v04XyI5jM6U6w9BeRk7vkdkvKZJpon/YrvVz2eWdPcrP2+py4l0BFJfdIrdZ+xDPX
         lVPLB6cUATqnimjWGVWEBUTQxpT1DA5uQmLT7eZhTz8G9HQpWLflgC5s4sc0RzcYOndY
         ANYQ==
X-Forwarded-Encrypted: i=1; AJvYcCWaAGPjp30C6tPOTYCGWS3Hqhi17twfkuV7BvOV5FpOpcssAWDWPjbqKy0B92esx7gYiyobCFBwLyngHMEoFA==@lists.linux.dev
X-Gm-Message-State: AOJu0Yz33IvPBM/SeJO+t0xfbRugs4TLIrMFqWIg30jAfK0XNGD8lwLq
	JoPmkkyBe/ybMdxKj+8mqmp3bFhM5kEqfs40UbTyqpeJbUwt/tfiSCU/o5NhIIn0GklHllLX15w
	DRqeUH0vB5PWAspzTN2BFXUtv9uB7yAMafeQM
X-Gm-Gg: ASbGncsJ2uVhvqbvK+KiQ+e3hVO45YyGS9nADWoqPV/cPeeHVGlUxa6jTK+HQhVbykC
	C61JNeEt/OzBoDhgtjQEXsxMALqYg+tHFt8tVFtpsQubM4ht0AU8mzATmEyyaUMh2XaCcQYA=
X-Google-Smtp-Source: AGHT+IF5keh1OkYhUK3RqcqnhV5OxQkXPU+ZsFCvGYt6ItUo4VtXll8joXvSm4m0B5v6T0Q6zgylSiB7Qbwlbay4s9E=
X-Received: by 2002:a05:6102:3712:b0:4b1:14f3:5d6d with SMTP id
 ada2fe7eead31-4b690bc6bc7mr4569126137.6.1737154588110; Fri, 17 Jan 2025
 14:56:28 -0800 (PST)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20241219114400.858980-1-ajay.kaher@broadcom.com>
 <CAGdbjmKSpQSh=xr7MguoSgP85VTR5eu1xUeUXD8RtvZn-=MW3A@mail.gmail.com> <CAD2QZ9atira8k-CgfqEY81ixZK9aPVte48qD+XnwL5LejhqO5Q@mail.gmail.com>
In-Reply-To: <CAD2QZ9atira8k-CgfqEY81ixZK9aPVte48qD+XnwL5LejhqO5Q@mail.gmail.com>
From: Kevin Loughlin <kevinloughlin@google.com>
Date: Fri, 17 Jan 2025 14:56:17 -0800
X-Gm-Features: AbW1kvY6Gnks08-MjwR4sAwr5GSXml24QlRa9pqSN0N5jeFiIqB598rDzpBX4wY
Message-ID: <CAGdbjm+vuSDO_Zm4CiJgVEx1vx+LAT1+fVQG8xj41uYhBY9qkA@mail.gmail.com>
Subject: Re: [PATCH] sev-snp: parse MP tables for VMware hypervisor
To: Ajay Kaher <ajay.kaher@broadcom.com>
Cc: bp@alien8.de, bcm-kernel-feedback-list@broadcom.com, tglx@linutronix.de, 
	mingo@redhat.com, dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com, 
	virtualization@lists.linux.dev, linux-kernel@vger.kernel.org, 
	ye.li@broadcom.com, bo.gan@broadcom.com, 
	vamsi-krishna.brahmajosyula@broadcom.com, alexey.makhalov@broadcom.com, 
	vasavi.sirnapalli@broadcom.com, florian.fainelli@broadcom.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 2, 2025 at 8:31=E2=80=AFPM Ajay Kaher <ajay.kaher@broadcom.com>=
 wrote:
>
> On Thu, Dec 26, 2024 at 9:26=E2=80=AFPM Kevin Loughlin <kevinloughlin@goo=
gle.com> wrote:
> >
> > On Thu, Dec 19, 2024 at 6:44=E2=80=AFAM Ajay Kaher <ajay.kaher@broadcom=
.com> wrote:
> > >
> > > For VMware hypervisor, SEV-SNP enabled VM's could boot without UEFI.
> > > In this case, mpparse_find_mptable() has to be called to parse MP
> > > tables which contains boot information.
> > >
> > > Fixes: 0f4a1e80989a ("x86/sev: Skip ROM range scans and validation fo=
r SEV-SNP guests")
> > > Signed-off-by: Ajay Kaher <ajay.kaher@broadcom.com>
> > > Signed-off-by: Ye Li <ye.li@broadcom.com>
> > > Tested-by: Ye Li <ye.li@broadcom.com>
> > > ---
> > >  arch/x86/kernel/cpu/vmware.c | 7 +++++++
> > >  1 file changed, 7 insertions(+)
> > >
> > > diff --git a/arch/x86/kernel/cpu/vmware.c b/arch/x86/kernel/cpu/vmwar=
e.c
> > > index 00189cd..3e2594d 100644
> > > --- a/arch/x86/kernel/cpu/vmware.c
> > > +++ b/arch/x86/kernel/cpu/vmware.c
> > > @@ -26,6 +26,7 @@
> > >  #include <linux/export.h>
> > >  #include <linux/clocksource.h>
> > >  #include <linux/cpu.h>
> > > +#include <linux/efi.h>
> > >  #include <linux/reboot.h>
> > >  #include <linux/static_call.h>
> > >  #include <asm/div64.h>
> > > @@ -35,6 +36,8 @@
> > >  #include <asm/apic.h>
> > >  #include <asm/vmware.h>
> > >  #include <asm/svm.h>
> > > +#include <asm/mem_encrypt.h>
> > > +#include <asm/efi.h>
> > >
> > >  #undef pr_fmt
> > >  #define pr_fmt(fmt)    "vmware: " fmt
> > > @@ -429,6 +432,10 @@ static void __init vmware_platform_setup(void)
> > >                 pr_warn("Failed to get TSC freq from the hypervisor\n=
");
> > >         }
> > >
> > > +       if (sev_status & MSR_AMD64_SEV_SNP_ENABLED &&
> > > +           !efi_enabled(EFI_BOOT))
> > > +               x86_init.mpparse.find_mptable =3D mpparse_find_mptabl=
e;
> >
> > As far I know, Linux itself currently doesn't PVALIDATE the address
> > ranges scanned in mpparse_find_mptable(), and Linux accesses these
> > addresses as encrypted during early boot. Given this, am I correct
> > that the guest firmware that you're using is doing the PVALIDATE of
> > these ranges before starting Linux (else there would be a crash upon
> > scan)? And then presumably the firmware is also making sure that this
> > memory is encrypted so that Linux isn't reading unencrypted data as
> > encrypted (i.e., garbage)?
>
> Yes, Linux (as a guest) receives valid data.
>
> > If so, does that mean all the ROM region scans removed in [0] are
> > permissible for SEV-SNP guests booting on whichever guest firmware
> > this is? But you only want/need the mptable info here?
>
> Yes, VMware firmware validates MPTABLE info when 'non-EFI guest boots
> on VMware Hypervisor'. The other ROM regions removed in [0] were not
> encrypted and validated. This is a specific use case for the VMware platf=
orm.
> Linux today assumes SNP VMs will be booted with UEFI.
>
> > [0] 0f4a1e80989a ("x86/sev: Skip ROM range scans and validation for
> > SEV-SNP guests")
> >
> > More broadly, ideally the guest firmware would communicate to Linux
> > that these ranges are safe to access (perhaps via the e820 table),
> > rather than Linux making the assumption that the ranges are safe for
> > non-EFI SEV-SNP guest boots in this scenario. However, since you're
> > only changing vmware_platform_setup() for such boots, I don't think we
> > need to hold up this patch on that generality.
>
> This is a VMware specific scenario. VMware Hypervisor makes the MPTABLE
> memory available in e820 when 'non-EFI guest boots on VMware Hypervisor'.
> So it makes sense to do the changes only for vmware_platform_setup().

Works for me. Just wanted to make sure we don't regress Linux to
making assumptions about the safety of accessing memory regions in
CoCo guests without having entries in the e820 table for them.

Reviewed-by: Kevin Loughlin <kevinloughlin@google.com>
