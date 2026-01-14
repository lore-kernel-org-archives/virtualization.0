Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB6C136165B
	for <virtualization@lists.linux.dev>; Wed, 14 Jan 2026 21:28:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768426125; cv=none; b=UO+zquz0QR1flLpiwuIWAfagk7PhYDkixogT3WhK4ebeCZEvQejLVMV8ss5gVLGZd+4RuJMcT9WHt4C1QNEJf0M5W2LyPeIRYEtNdCwNBH3ZW6AnD59Q5lwhsrgPyv7858f1AGy1YCA3QRDugi5nOtSrzUUluWCGxgadnShKcJU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768426125; c=relaxed/simple;
	bh=F/GzsP/Lcsg8Z1oVLG0GeMKnSweu/KKnlXg0nc0UOMk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HxJ3qg/AlR/8cU0fVJKOm33QawsLBUz8I/gOUx+Gtw7PFfpqGtoZO2Kurh/IUlS5GymYGe1/jhyeYEttGrcBhSaviXaqT4VgpA1cZEuFiltopMgpt/VmkEu9eAhjS6DIua1WVwinGlwn4BInDRMLcstv4ACG3BtfeZNtoNgpH68=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bBDQxbh1; arc=none smtp.client-ip=209.85.167.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bBDQxbh1"
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-59b672f8e40so324895e87.2
        for <virtualization@lists.linux.dev>; Wed, 14 Jan 2026 13:28:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768426122; x=1769030922; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wZNFRW6LSRSd0pfz18sQgjo75u0U6fj3cOemGcU21+w=;
        b=bBDQxbh1LtJRoSqj6Avj6zTW4e7fl/qauPc0Yh/USpBwq3yM++F/TZO1yZWZWuzYOW
         Tlp5iydUWFO+kcNJfuGUxqPOLLwVEpulvE8C9qg1zi0CC0CbU2+KmZCxzYkIazQoBOde
         yJyfisF5+eu5uNmSFIYvMyZ8BVFWVORpSR3NTxMD/SZ/75b8UylLLZzaVzrfnJ1ejC3c
         P1i15+eu8oqQA1Cq0cx5fP/wtYeCYh8Iqo7J0HkQ9O5RfjNfjmgQjkL5qhQgNAkNxaT+
         MY2AYY2bgrP0OwPNoa8gjq+Q4aFnjxecKCH8sejl36x3jdPPiwEaSIW06FHxFooxZNZF
         KMHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768426122; x=1769030922;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=wZNFRW6LSRSd0pfz18sQgjo75u0U6fj3cOemGcU21+w=;
        b=hmuB/ewvVon8vhDcUprdaXLmK4uFgah35rvGGqIBFiTRwvw/aXPejvCWlnlTGh8hHn
         3N+c6UfMkMEKiaDbcOfmyuQ2vMxd8cOXCo2wMQWRj17WlH8VMVZixZV9dQCN40JrZfqF
         WTFF51qKE10g6yBQIintZ90NyuSfp8UrREwnWw6PjsN7flGSpGRUksjb2QOOoBUKxPjn
         GRKIggGACpgWymo47hc54TGerF24H04L6+GkJol2M/BNXD5QLlmuJpm59BtZ25RTgCpR
         qPMTMtl/ryGrVDtBjLt4llYPhPNVYK04UUOtS+2qKuCQLYuwpJfyaEtaQgNjRyBNF+U7
         9aIw==
X-Forwarded-Encrypted: i=1; AJvYcCXVnGGrEQb52Eg2g+V3CsBjfpiXbd+u95HHkwW6txu39uY754wuNlrDZVCIv9VlREUJtiVXCxCbtWpPkyo7HQ==@lists.linux.dev
X-Gm-Message-State: AOJu0Yy2GB0y/Z38JdUYfdUyzL82Br6SICNGZvGWJfnsx3SMiMxYFyIc
	N7NcQUu2k/3BQcQUERzZDM3j6huvvjYYGtr0reu/1Dc+2CEsOIpP08FfMDcJMAjs3viGHoFAMIJ
	GUbklkh876OPPm+gms2WZl6xwE4HGovs=
X-Gm-Gg: AY/fxX41OpNmjGjkW7gRIeaudz27zYgJfX6CPTf56NlQaShvFqYYJwRsXNmRkGCMm9e
	o7z8B1+dP7CGUA9uXjIwakhAxML0A/STb00It5WgqZjhE7+txrgIDJysB53YTtNHPbiCqs9h84s
	RJSXXXNxMS8vCADJZc4uhGoFDliJ48pRKxXYt999H3BGZEPocNCxqvE8o4MRw46hcDR+XAgeCoj
	Ve+Q9yAoN3kiINI544p+rZL6FKULas3PXLKfjqeiUKmRmOfDqpprDYVvh+hlWl5P5q3GSo5TqEj
	pkmTIse0p7dNeA25xFVu8OM6FHWq07LfgBx+QA==
X-Received: by 2002:a05:651c:f17:b0:382:f78d:a0c with SMTP id
 38308e7fff4ca-383607e2c37mr12614551fa.21.1768426121710; Wed, 14 Jan 2026
 13:28:41 -0800 (PST)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260105093944.52387-1-ubizjak@gmail.com> <20260114202846.GGaWf8foEIum1AotkZ@fat_crate.local>
In-Reply-To: <20260114202846.GGaWf8foEIum1AotkZ@fat_crate.local>
From: Uros Bizjak <ubizjak@gmail.com>
Date: Wed, 14 Jan 2026 22:28:29 +0100
X-Gm-Features: AZwV_Qg4Kjyyqbb-XgUZgbi98Bgiaj79UuxkaDnfwXkvb0k-3q92xuJViAeoDJE
Message-ID: <CAFULd4ZiSa_yFRHW33=yb_daOW2EZqtUiYuzXfmwQ8LBbDdsow@mail.gmail.com>
Subject: Re: [PATCH RESEND 1/2] x86/paravirt: Remove trailing semicolons from
 alternative asm templates
To: Borislav Petkov <bp@alien8.de>
Cc: bcm-kernel-feedback-list@broadcom.com, virtualization@lists.linux.dev, 
	x86@kernel.org, linux-kernel@vger.kernel.org, Juergen Gross <jgross@suse.com>, 
	Ajay Kaher <ajay.kaher@broadcom.com>, Alexey Makhalov <alexey.makhalov@broadcom.com>, 
	Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@kernel.org>, 
	Dave Hansen <dave.hansen@linux.intel.com>, "H. Peter Anvin" <hpa@zytor.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 14, 2026 at 9:29=E2=80=AFPM Borislav Petkov <bp@alien8.de> wrot=
e:
>
> On Mon, Jan 05, 2026 at 10:39:06AM +0100, Uros Bizjak wrote:
> > GCC inline asm treats semicolons as instruction separators, so a
> > semicolon after the last instruction is not required.
> >
> > Signed-off-by: Uros Bizjak <ubizjak@gmail.com>
> > Reviewed-by: Juergen Gross <jgross@suse.com>
> > Cc: Ajay Kaher <ajay.kaher@broadcom.com>
> > Cc: Alexey Makhalov <alexey.makhalov@broadcom.com>
> > Cc: Thomas Gleixner <tglx@linutronix.de>
> > Cc: Ingo Molnar <mingo@kernel.org>
> > Cc: Borislav Petkov <bp@alien8.de>
> > Cc: Dave Hansen <dave.hansen@linux.intel.com>
> > Cc: "H. Peter Anvin" <hpa@zytor.com>
> > ---
> >  arch/x86/include/asm/paravirt.h       | 20 ++++++++++----------
> >  arch/x86/include/asm/paravirt_types.h |  2 +-
> >  2 files changed, 11 insertions(+), 11 deletions(-)
>
> Those don't apply anymore. Please rebase them against latest tip/master
> branch.

The rebased series was sent and can be also found at [1].

[1] https://lore.kernel.org/lkml/20260114211948.74774-1-ubizjak@gmail.com/

Thanks,
Uros.
