Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 809C027AC31
	for <virtualization@lists.linux.dev>; Fri, 13 Mar 2026 06:30:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773383414; cv=pass; b=HO29pc5Ubr2M2qMsvjnkFR499UbHUpgAJv4j9Iz5SgHiRzIAGNpuYMat4RAM2teIO59a/c30zZhELF24/XV18msH6OILOfWIJ8O+Q0eoY30vZg1SpuE7QAfYAEhEA83riYvPZCbiBn2XeC/9du0Yf6YL88/D140sOuZPXoj7JuA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773383414; c=relaxed/simple;
	bh=3WtB1EO7ULP2dv1nFjQ5XE7neEDPZu3SzQtV2a9e/Q4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=n6bUOhjbJfx/xk9A+SuTPFrGCKHnqEkY/c+EYHybCultu+zQ7zKPjlEi7oFkw7t781KMbp/ekR6bmH7UdnxYDEJO+o6t+MQ0r5HCxj1bQrKRtDBhzBXx+ylkW46imCAScHZElH4Cn4DyTU5ZdyUFkLtdVlaJz0B4fvxL0n3XcQg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=agVskVSe; arc=pass smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="agVskVSe"
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-b9431300833so268254866b.0
        for <virtualization@lists.linux.dev>; Thu, 12 Mar 2026 23:30:11 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773383410; cv=none;
        d=google.com; s=arc-20240605;
        b=CwYTZqfDZO3lYf82ITdi8Py+8G1cDpxdQJhs52wRIfhFpAe64ENnuqC1wjsiuRlUdB
         JXAe7vTviBSK334yM+sccpxsYvsf+fLLO2orlYru2wsg3kpq6L4NI7MgASR1aLCj1EHY
         orDWs/+ROvGf0CAxZ1dD6GBIxZfqTGsUu3aKp9tnOfWUhlIb7FerDAPqDo90VonmZGw9
         AiwE0MWiftY8EtxeJp8wM38FEeOmfKdJuN1x9YrkmtwSnpmOAzP5ozDnTyhaMz/ZmM3A
         aOh8A5beFWjbhJkB606HGbIiwi09QGdFeVB5zwoZ+g6+cTzW9yzI8STFXtqMf6fcQwNw
         5a5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=dPJHfICB2kVM1pQvzl6TqPezMCEYItbR1A1kcv/R7E0=;
        fh=pJRhDwUOX8k0IAzmfCnLuetHgWTJ/POd9nq32t5+q+Q=;
        b=SbQn/IR6sF2MfHxabRGzEY8YNDmYbg610XG2f+WXsb8B7SdI+ZxbCEJHlSvmnmd2Cl
         y5y7ASGqDedb3HefJaoXY4dNbcgs5TuhuXKMXB+AGO9FivmfAQSu0MAr3xBk1kznUiAp
         br0ZaaoXD0nINlUoLkcRhlt7CGvj/IGZfteac28tU8PgqPGrR0YAVVBbw2H1axTRZTlq
         hIZy5gIgjv7SXNzx7Qy2XBYamvQ3RE+gLaZzMlGTj+b2fra0/Wky7uKGBJkIO82PMlqi
         lryqVKvIn8CAL8C87w1MEoDgUPUXyuOZtvQX03EufeB3NGwQxtEXKbe94e3xwhsESYh2
         heTA==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773383410; x=1773988210; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dPJHfICB2kVM1pQvzl6TqPezMCEYItbR1A1kcv/R7E0=;
        b=agVskVSe6ScPrHHw1sRUeoll96OUgHykQAIJcy7igfg6FrIwe1zrS5g/7sSOw9nsSW
         H9bfdfi8Sh/s4HeijkRuiQy1jXgQ+WqlsZX1/hH1S8qf4Yl+Jp0n444aov+wtBwZqE/g
         TGrKVJtNCiZoGaefQsDxOrqDBp6ww/TISZ5/EN1eWBQXUJ7XKEzL0TJZ+gtVSAHBehDP
         tTuNOXZ8xUYac4Grq9lnN9/VL6RtWApvA24msJJl7wrpMk2I4xR7HTJLGqydb26ihBRc
         tihqd+OuhX7qAKa0GcIbzuCRq0F+PnsdEVGGmH5N0202U78AGsZToSzfBgpLviIYjidB
         R67g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773383410; x=1773988210;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=dPJHfICB2kVM1pQvzl6TqPezMCEYItbR1A1kcv/R7E0=;
        b=Lo2WnZyJkICk0chIEDXJf96Uos0JzCgx7TbIC1QsiLTDWT+RavwwphDVY+koSscjVB
         vI7YDy2hLsf9XRlzWpbDk7xEOm7w00NjpGTfhubL7SaEKwbLXYrRxEpUyJsd0CB7TmwV
         WbsSyFRxNSxm+ZsrT3PiTqgV0uOfnP4s6F8Q6Ku/DETnLNLPTcf3NnMODwrPil00CrEU
         KS+IEqbdu6C6FA86obVf87CFJTmfvfEP1J9Ao5E8Vc9UlwK6eeE7is9zw9enD6d6L79V
         M8HJJ7mXPQIm6yTqllEsMMTO6mnEOntzLRV6auDsKljMjYQfQWBUMvq4/MS+1uD32JCJ
         xpvQ==
X-Forwarded-Encrypted: i=1; AJvYcCVsLE6R9Pp6RbxCMtacKjSZ/bidEV3+DF7/DyBlZPrVpko3nhcxxOdxmIgZ6qPCgOpbEfXjtkgWDRYoXoIcmg==@lists.linux.dev
X-Gm-Message-State: AOJu0YxH3LXMxTl2sxe8p9AanTeumsVRoWz11JhlRyS4Qzb8NzZLnxUp
	sYZV7sVqSIGLAQ1ytKtij3ozK3RyRVN0QvNWmP6kpG3Y7EgWk/WrhWNMZDj53XynG83vyFen5Fk
	TWrrZTdkNsoRORxFFv94ZHXu51LdzWobKM8mp
X-Gm-Gg: ATEYQzzRXKFkZR1ujff7Hf9S47tInYsuQFVFs/z3CcKbQd2//QuIuybrF9svGip1SGb
	uQP19nG1SshDH4rDtFHvOu0nioG3sOHhuYm30xnTJSZj0hziEedBcoiD2QBlS8zuSOptyl2Fyc/
	NMQdC+gj8Wur/105g/b1KXLUH7LSyLJCAONYyteaZ/w7yGBltOLu3sS/VRDGjqrXHqcvUG1EO4G
	KJOIzAPbMSXFJleKzWTo0a2jetm9smvdEf6+aQBMw1x0JJMRmB1eo65T914HSag5uKhUjOYdVUf
	nbX1NCdFxvqFiSFFaVpNZxpffneCsERZT6Or3ZFKbQrMU3RHzZlydRQpLN8ibhfJC99vow9b3Y3
	8U+49zQ==
X-Received: by 2002:a17:907:3d87:b0:b93:a3db:a68c with SMTP id
 a640c23a62f3a-b97651e7241mr118021166b.40.1773383409452; Thu, 12 Mar 2026
 23:30:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260312193717.12221-1-rosenp@gmail.com> <7jwgbrijeldghk44tdg2be5q7o7vuj5np3nlbl2pxuln6c7ll7@ntuquxxdnfmm>
In-Reply-To: <7jwgbrijeldghk44tdg2be5q7o7vuj5np3nlbl2pxuln6c7ll7@ntuquxxdnfmm>
From: Rosen Penev <rosenp@gmail.com>
Date: Thu, 12 Mar 2026 23:29:58 -0700
X-Gm-Features: AaiRm51lyu5fd17YeYxCP6g9ZNV_rgw3odQq_g1fIwHyYebHzAUSuwEuLroDVYs
Message-ID: <CAKxU2N_7sZu+J46sCQH4jgVB0r9HsHREToeCTg0Hz4PaVjY+sQ@mail.gmail.com>
Subject: Re: [PATCHv3] gpio: virtio: remove one kcalloc
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: linux-gpio@vger.kernel.org, 
	"Enrico Weigelt, metux IT consult" <info@metux.net>, Viresh Kumar <vireshk@kernel.org>, Linus Walleij <linusw@kernel.org>, 
	Bartosz Golaszewski <brgl@kernel.org>, Kees Cook <kees@kernel.org>, 
	"Gustavo A. R. Silva" <gustavoars@kernel.org>, 
	"open list:VIRTIO GPIO DRIVER" <virtualization@lists.linux.dev>, open list <linux-kernel@vger.kernel.org>, 
	"open list:KERNEL HARDENING (not covered by other areas):Keyword:b__counted_by(_le|_be)?b" <linux-hardening@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 12, 2026 at 11:09=E2=80=AFPM Viresh Kumar <viresh.kumar@linaro.=
org> wrote:
>
> On 12-03-26, 12:37, Rosen Penev wrote:
> > A flexible array member can be used to combine allocations.
> >
> > Signed-off-by: Rosen Penev <rosenp@gmail.com>
> > Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
> > ---
> >  v3: add counting field for __counted_by.
> >  v2: add space in struct
> >  drivers/gpio/gpio-virtio.c | 14 +++++++-------
> >  1 file changed, 7 insertions(+), 7 deletions(-)
> >
> > diff --git a/drivers/gpio/gpio-virtio.c b/drivers/gpio/gpio-virtio.c
> > index ed6e0e90fa8a..57d0eb532c3c 100644
> > --- a/drivers/gpio/gpio-virtio.c
> > +++ b/drivers/gpio/gpio-virtio.c
> > @@ -52,7 +52,6 @@ struct virtio_gpio {
> >       struct virtio_device *vdev;
> >       struct mutex lock; /* Protects virtqueue operation */
> >       struct gpio_chip gc;
> > -     struct virtio_gpio_line *lines;
> >       struct virtqueue *request_vq;
> >
> >       /* irq support */
> > @@ -60,6 +59,9 @@ struct virtio_gpio {
> >       struct mutex irq_lock; /* Protects irq operation */
> >       raw_spinlock_t eventq_lock; /* Protects queuing of the buffer */
> >       struct vgpio_irq_line *irq_lines;
> > +
> > +     u16 ngpio;
> > +     struct virtio_gpio_line lines[] __counted_by(ngpio);
> >  };
>
> I wonder if it is worth it anymore. Why combining allocations is better w=
hen we
> are ending up using more memory ?
No idea. That's what maintainers suggested for some unknown reason.

Anyway, I don't care if this gets merged anymore.
>
> --
> viresh
