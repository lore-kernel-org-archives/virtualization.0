Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF2341BD9DB
	for <virtualization@lists.linux.dev>; Mon, 10 Feb 2025 08:23:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739175783; cv=none; b=CxNd/JVnCvUJw1PV3dD8P2zpjZdPtLKXsjcX07nn8Di6nJJEUZcLtqD2iQ64SORUiixBNODEi02E9ozri8f2KYmp5Gu4UJ5c1ZVrTLhAqrXI6zCJ6q3J/m34fdOgBuB1C7GO3rIT4ncX8xxFQr0+q0vV1B4esKJRHHCLQ4Zz8rs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739175783; c=relaxed/simple;
	bh=YkP0GghXk5rZxXF+bKkrcLZxMboqgkzN8bfvUUzqc+4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=COfLENlRn7ep636PHoZEi3c50CxFze5e1yKO9L4O2BMbziwL+dhzJG4n+AvzgnlO4dfNYfI9V9MCQHvYBFIBRFcWdZl/9A9BL5SjGsUjZDEmYmJJOBkghc7bruQetp4kOowt35a548AB/cLXZsVSKrBPXKA3CjZ6gOZ4IUdoHls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=oYQnfRNf; arc=none smtp.client-ip=209.85.167.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="oYQnfRNf"
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-54504bf07cdso1888123e87.2
        for <virtualization@lists.linux.dev>; Mon, 10 Feb 2025 00:23:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1739175780; x=1739780580; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZoT+boRbhRr/jTb1oqMqPAiRLBIMVE1Brfce63wCwqw=;
        b=oYQnfRNfQfBf20ZnYUNA4/m49LsuJ+T5ffVTdG+u1MH92SHdhru6Yp/d0s/wxG6pdJ
         IUsAS0hECKOc67XTfSkYvEs2511W4lksH8oRc+Dki2JTQvM+fiX4EsmvC7R40X67v7dA
         Wp0Us4XIFXE/1PieVsTVVCoDllaz5RvKsDrPWmX6BOFupuDkn39e4Bs4FsSHzqRd1/cW
         8cyRTnj/lHCoU8B50TIqRu8f0tW5rnT7a8ZX77bSCJBQ4KFQiHegxkoW3Rzvdfy6IxVL
         quyGhk9RYQjQRRQZbONQcTEp7GsqKMVFDVSID95tZqkp3OWqt7UYRWZlyRZ0dBhvIrnW
         MpRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739175780; x=1739780580;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZoT+boRbhRr/jTb1oqMqPAiRLBIMVE1Brfce63wCwqw=;
        b=H9ENfUpDH/0Prj6qio0bC/2WYRfTasNZ5rb+tIyDVK+42/E5KkKbRttJDmEBOa5zps
         Hv0HssCFpNssvApzQE61hMoOkIcJtAr+0TEEQx0AXe7L6l8Y2hKK5PMQPY/vBlZPTHX8
         JPLe1H8Uqpf2Bt6SAC9N0eyIDCcjqM5BfAwRSp2SrSjVbUSOuhnZMbH/EIvzQwUoaSrS
         65ostBhtU+F/sKUhZGvhW+DbqmHryFnh35dPy9KTv13WoT25XmiwmP1Dx58uoT4nkmgb
         7zClXShySFuk4LaSYlcup0cViEQUMQdVKKR32R/LUmMWfcq1ZRsDurwe+fhcKleZT42x
         hehQ==
X-Forwarded-Encrypted: i=1; AJvYcCXoPfrWFhKpri5F312RtMtNSoo1Afoj1sUCmWs7XJi7aknzfhmrhMJ+5ddak75117d907xeas3MKC7BB/AaoQ==@lists.linux.dev
X-Gm-Message-State: AOJu0Yw5n0fcvMGyky4OouAaIw7KvcWRhmyyi69NK+iuWwbj0fg/mdOS
	5UhNSpzxEP+K3f7iRAQLdkbibszLHSR4FEPPGogqBkwi+iB8pSKNn8RB0pPTHi/+WWojknG1f82
	p5u1u6lwVv2/HbPUobK5bbL1j9NMZhNjyRyQUdw==
X-Gm-Gg: ASbGnct7lQMkOdvjZJPvkH5pqLqrWtLa5PCa6GLzLpss7J3hUcdVc4HabwDOt2gRoya
	S43aMtQtOuo4t39UI8XWGPMwUf5F03iUmzPt2HSzoiDDT4xGczAeNko0M6GllOyB/UkxAV949V4
	oKaN99gFSreFTaWFFBYBSG+gPh4dcg
X-Google-Smtp-Source: AGHT+IFFAiFvMPMX5w5vYWoD1W4TlwXK4TNGtARGkVlKtIMWS7CPgk80bycWo/eBWUAIbKZuY1UA3HQ76st0rRLGm2U=
X-Received: by 2002:ac2:47f3:0:b0:544:ffbe:cd22 with SMTP id
 2adb3069b0e04-544ffbecdebmr2209076e87.46.1739175779838; Mon, 10 Feb 2025
 00:22:59 -0800 (PST)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20250103083520.1764441-1-a909204013@gmail.com>
 <20250106043508.x3pwt3jzh37t265f@vireshk-i7> <20250107060044.hteiw6dgycz5rr7x@vireshk-i7>
 <CAHqiF6Aoe4eUShxpPfKczPF-bVneiyM0gpZ7xWF3artzoC__7Q@mail.gmail.com> <20250210045653.p5d6svdl4d32sttf@vireshk-i7>
In-Reply-To: <20250210045653.p5d6svdl4d32sttf@vireshk-i7>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Mon, 10 Feb 2025 09:22:49 +0100
X-Gm-Features: AWEUYZm0bjFLpqFBJMLvFtabmvBsH883FPmkZVriR3JJZIG8MQp8vYUvvpxS9Nc
Message-ID: <CAMRc=MfocjJW_oYbePC2yOWZUHnTuUfkvs0d+ANz9=TDdegBxg@mail.gmail.com>
Subject: Re: [PATCH] drivers:gpio: support multiple virtio-gpio controller instances
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Leng Cold <a909204013@gmail.com>, Linus Walleij <linus.walleij@linaro.org>, info@metux.net, 
	vireshk@kernel.org, linux-gpio@vger.kernel.org, 
	virtualization@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 10, 2025 at 5:56=E2=80=AFAM Viresh Kumar <viresh.kumar@linaro.o=
rg> wrote:
>
> +GPIO maintainers.
>
> On 08-02-25, 15:54, Leng Cold wrote:
> > ping
> >
> > Viresh Kumar <viresh.kumar@linaro.org> =E4=BA=8E2025=E5=B9=B41=E6=9C=88=
7=E6=97=A5=E5=91=A8=E4=BA=8C 14:00=E5=86=99=E9=81=93=EF=BC=9A
> >
> > > On 06-01-25, 10:05, Viresh Kumar wrote:
> > > > On 03-01-25, 16:35, hlleng wrote:
> > > > > Modify the virtio-gpio driver to support multiple virtual GPIO
> > > controller
> > > > > instances. The previous static global irq_chip structure caused
> > > conflicts
> > > > > between multiple virtio-gpio device instances as they shared the =
same
> > > > > interrupt controller configuration.
> > > >
> > > > What is the conflict you are getting since all it has is callbacks =
only,
> > > I
> > > > wonder why do we need to duplicate it.
> > >
> > > Ahh, so irq chip should be shared actually..
> > >
> > > static void gpiochip_set_irq_hooks(struct gpio_chip *gc)
> > > {
> > >         ...
> > >
> > >         /* Check if the irqchip already has this hook... */
> > >         if (irqchip->irq_enable =3D=3D gpiochip_irq_enable ||
> > >                 irqchip->irq_mask =3D=3D gpiochip_irq_mask) {
> > >                 /*
> > >                  * ...and if so, give a gentle warning that this is b=
ad
> > >                  * practice.
> > >                  */
> > >                 chip_info(gc,
> > >                           "detected irqchip that is shared with multi=
ple
> > > gpiochips: please fix the driver.\n");
> > >                 return;
> > >         }
> > >
> > >         ...
> > > }
> > >
> > > For your patch:
> > >
> > > Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
>
> --
> viresh

The author would have had more success getting our attention if they
used get_maintainer.pl. Also: the subject is wrong, should be "gpio:
virtio: ...".

Please resend a proper version with Viresh' tag collected.

Bart
