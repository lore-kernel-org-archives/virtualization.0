Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C059328C014
	for <virtualization@lists.linux.dev>; Thu, 27 Nov 2025 01:09:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764205754; cv=none; b=t0wz7DETNuENiLsDUWn94Dvne02hhMryjgyc4wLK+ySPy/FSbwaXHjuoZxi2vaRhLKXVK4Ydls2RDVmBIU0v9oQlynypHYcWTq/MNydcRcS6+p4cVgXpwMtCdGBxBiAi0O438U/uYdVWowvaNDND8ekKZHSUVDNS4H4VV5QqEGI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764205754; c=relaxed/simple;
	bh=Ctofiznd8z5aUzVJ+ihEmSEYUQiQu3/ESxLKKSwVAT8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mYSq7voCSxV1MpJj/UglpfJhqooEf0kS3ay5OYuIS77bjeYtivBMq7da7WHj5OLVM5S18SxkJ3j78p8T6noIhKmtDIksReIH052zwpln3KBySEs1Gka5enIRV9xOrNyKnmiaXSLO/WoIAF2e7pU2Fv981k73xclYItNgCnnFEvk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=h17dFGOC; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="h17dFGOC"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1764205751;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+fIuq3Wp4BeebjpNpG0wUv9Qzy/8IqNgZEzWKyUeiT4=;
	b=h17dFGOCfRzVjLOAFIxwqneJL8FKO7yxRQwkFFshJp8ft6bvydwIXiTRWoPO4Uc/dzfAXM
	aFFK36xVzYTcUAhKSeC/qKRaA4Sd0skslI3SECGoDMRTlrjyepiK4Ic1QpfE9L2HncdEnO
	ubRvjkJJq2QtS/JGEhQm6rPbHt/sWTA=
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com
 [209.85.215.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-556-72Pgu9mvPFipTWf14dLKUQ-1; Wed, 26 Nov 2025 20:09:08 -0500
X-MC-Unique: 72Pgu9mvPFipTWf14dLKUQ-1
X-Mimecast-MFC-AGG-ID: 72Pgu9mvPFipTWf14dLKUQ_1764205747
Received: by mail-pg1-f199.google.com with SMTP id 41be03b00d2f7-bd74e95f05aso860988a12.1
        for <virtualization@lists.linux.dev>; Wed, 26 Nov 2025 17:09:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764205747; x=1764810547;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=+fIuq3Wp4BeebjpNpG0wUv9Qzy/8IqNgZEzWKyUeiT4=;
        b=Luyl3fqsfgU/72lr0oHF/20uDrtv53YSxCElQlyjXMKlrUK16BhNxHAv+40NsVd1mr
         gS8Hx3E29jwR6Pf96noMhPiVUXXKdndGj33UVI/lJ8qoT3+LtIU4O7kewA6aKmvPOa4r
         E3QNjfAntfv02e3FJNcggHKgeAZ/slUSYina6XYteqdBSEafn0b416jEcSzX+F/vo5h2
         Kx8SGnZL7A8ENPYU+h9nrgfi0M2nV+X5XSgz+FEnXm9C395ULx8iEeD7QhRY6maE2KLw
         LQ+74B2/rXAtCgy7DI/Em+RaHXR7lFzGQxOOLpuN8HRnK8bM7Uajks08DAFGGNb4n5nF
         Hpuw==
X-Forwarded-Encrypted: i=1; AJvYcCVYWihN7Y/mIfsDOiA3FGq6VtSNDIW/jtcMeyJmco8b1t0nejySh6tMn2ke9W1GKJ990dcTltWrBMi2dLuKHg==@lists.linux.dev
X-Gm-Message-State: AOJu0Yzx0S4fB5bmCxKFelNkdKdNrvRTZRWkCuPHxin8KNsh/qKb2AUa
	N2bghMY6/N330BFOu4Sf+DLeTCZTkP+QDQYkd/kif6gJWLJfVK6SElUmgiJ5yC8i2iv0RksmID/
	lutiFEKtYw1ceOKWIIYvedcIZSrNsaHPvx7zRyk+qVGL8B0xAUPzvtWLMVdVbGFDL8mOSYOJXbp
	Xd/AnCwSYC44rffxYwIxR+EtMScmF4s+uS4l5BikS6I0I=
X-Gm-Gg: ASbGncsbW3xjyt1wBbIeqzlGi9/iseyNdbSRlMdLS8VV76DVHrjmD3vFUPO3mlOxItD
	Oi5e0LoOanO/ZBodOV8p2GsowVTe/6jeTMq5BYkojNNP5ili8KaI7G/+/krIS1fK15xs3/KSH8r
	zZoza06vqqzJphlGgPSJi2i9nCaOd8phYd58IV3clzi/uUxWX6V5yw2b9+UNBrwoCD
X-Received: by 2002:a17:902:dacb:b0:269:b2e5:900d with SMTP id d9443c01a7336-29b6beebec7mr257541885ad.5.1764205747417;
        Wed, 26 Nov 2025 17:09:07 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFPDNamYNduzNpXyT/xW1ZQEyOB0Lis20nwGLU/hQvR/oP+MQrKzzm7g4m+9/51XsOAa525fC5RiOVpei7R5uk=
X-Received: by 2002:a17:902:dacb:b0:269:b2e5:900d with SMTP id
 d9443c01a7336-29b6beebec7mr257541495ad.5.1764205746933; Wed, 26 Nov 2025
 17:09:06 -0800 (PST)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20251113005529.2494066-1-jon@nutanix.com> <CACGkMEtQZ3M-sERT2P8WV=82BuXCbBHeJX+zgxx+9X7OUTqi4g@mail.gmail.com>
 <E1226897-C6D1-439C-AB3B-012F8C4A72DF@nutanix.com> <CACGkMEuPK4=Tf3x-k0ZHY1rqL=2rg60-qdON8UJmQZTqpUryTQ@mail.gmail.com>
 <A0AFD371-1FA3-48F7-A259-6503A6F052E5@nutanix.com> <CACGkMEvD16y2rt+cXupZ-aEcPZ=nvU7+xYSYBkUj7tH=ER3f-A@mail.gmail.com>
 <121ABD73-9400-4657-997C-6AEA578864C5@nutanix.com> <CACGkMEtk7veKToaJO9rwo7UeJkN+reaoG9_XcPG-dKAho1dV+A@mail.gmail.com>
 <61102cff-bb35-4fe4-af61-9fc31e3c65e0@app.fastmail.com> <02B0FDF1-41D4-4A7D-A57E-089D2B69CEF2@nutanix.com>
In-Reply-To: <02B0FDF1-41D4-4A7D-A57E-089D2B69CEF2@nutanix.com>
From: Jason Wang <jasowang@redhat.com>
Date: Thu, 27 Nov 2025 09:08:55 +0800
X-Gm-Features: AWmQ_bnsXM38rarXUDstecHvEAw99LfY0bJMCpF_57ywtegttUxJS9KRjDg4vNQ
Message-ID: <CACGkMEshKS84YBuqyEzYuuWJqUwGML4N+5Ev6owbiPHvogO=3Q@mail.gmail.com>
Subject: Re: [PATCH net-next] vhost: use "checked" versions of get_user() and put_user()
To: Jon Kohler <jon@nutanix.com>
Cc: Arnd Bergmann <arnd@arndb.de>, "Michael S. Tsirkin" <mst@redhat.com>, 
	=?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
	"kvm@vger.kernel.org" <kvm@vger.kernel.org>, 
	"virtualization@lists.linux.dev" <virtualization@lists.linux.dev>, Netdev <netdev@vger.kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	Linus Torvalds <torvalds@linux-foundation.org>, Borislav Petkov <bp@alien8.de>, 
	Sean Christopherson <seanjc@google.com>, 
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Russell King <linux@armlinux.org.uk>, 
	Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, 
	Krzysztof Kozlowski <krzk@kernel.org>, Alexandre Belloni <alexandre.belloni@bootlin.com>, 
	Linus Walleij <linus.walleij@linaro.org>, Drew Fustini <fustini@kernel.org>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: nyBx7_rZJf-VbcZoDcglqe6zkyMRrmPU0RidrcgD7yY_1764205747
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 27, 2025 at 3:48=E2=80=AFAM Jon Kohler <jon@nutanix.com> wrote:
>
>
>
> > On Nov 26, 2025, at 5:25=E2=80=AFAM, Arnd Bergmann <arnd@arndb.de> wrot=
e:
> >
> > On Wed, Nov 26, 2025, at 07:04, Jason Wang wrote:
> >> On Wed, Nov 26, 2025 at 3:45=E2=80=AFAM Jon Kohler <jon@nutanix.com> w=
rote:
> >>>> On Nov 19, 2025, at 8:57=E2=80=AFPM, Jason Wang <jasowang@redhat.com=
> wrote:
> >>>> On Tue, Nov 18, 2025 at 1:35=E2=80=AFAM Jon Kohler <jon@nutanix.com>=
 wrote:
> >>> Same deal goes for __put_user() vs put_user by way of commit
> >>> e3aa6243434f ("ARM: 8795/1: spectre-v1.1: use put_user() for __put_us=
er()=E2=80=9D)
> >>>
> >>> Looking at arch/arm/mm/Kconfig, there are a variety of scenarios
> >>> where CONFIG_CPU_SPECTRE will be enabled automagically. Looking at
> >>> commit 252309adc81f ("ARM: Make CONFIG_CPU_V7 valid for 32bit ARMv8 i=
mplementations")
> >>> it says that "ARMv8 is a superset of ARMv7", so I=E2=80=99d guess tha=
t just
> >>> about everything ARM would include this by default?
> >
> > I think the more relevant commit is for 64-bit Arm here, but this does
> > the same thing, see 84624087dd7e ("arm64: uaccess: Don't bother
> > eliding access_ok checks in __{get, put}_user").
>
> Ah! Right, this is definitely the important bit, as it makes it
> crystal clear that these are exactly the same thing. The current
> code is:
> #define get_user        __get_user
> #define put_user        __put_user
>
> So, this patch changing from __* to regular versions is a no-op
> on arm side of the house, yea?
>
> > I would think that if we change the __get_user() to get_user()
> > in this driver, the same should be done for the
> > __copy_{from,to}_user(), which similarly skips the access_ok()
> > check but not the PAN/SMAP handling.
>
> Perhaps, thats a good call out. I=E2=80=99d file that under one battle
> at a time. Let=E2=80=99s get get/put user dusted first, then go down
> that road?
>
> > In general, the access_ok()/__get_user()/__copy_from_user()
> > pattern isn't really helpful any more, as Linus already
> > explained. I can't tell from the vhost driver code whether
> > we can just drop the access_ok() here and use the plain
> > get_user()/copy_from_user(), or if it makes sense to move
> > to the newer user_access_begin()/unsafe_get_user()/
> > unsafe_copy_from_user()/user_access_end() and try optimize
> > out a few PAN/SMAP flips in the process.

Right, according to my testing in the past, PAN/SMAP is a killer for
small packet performance (PPS).

>
> In general, I think there are a few spots where we might be
> able to optimize (vhost_get_vq_desc perhaps?) as that gets
> called quite a bit and IIRC there are at least two flips
> in there that perhaps we could elide to one? An investigation
> for another day I think.

Did you mean trying to read descriptors in a batch, that would be
better and with IN_ORDER it would be even faster as a single (at most
two) copy_from_user() might work (without the need to use
user_access_begin()/user_access_end().

>
> Anyhow, with this info - Jason - is there anything else you
> can think of that we want to double click on?

Nope.

Thanks

>
> Jon

