Received: from mail-yw1-f179.google.com (mail-yw1-f179.google.com [209.85.128.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 879C4558211
	for <virtualization@lists.linux.dev>; Tue, 13 Oct 2026 20:45:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.179
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791924347; cv=pass; b=PKDqekma+IF9mlW9dHn9d5pAR4kYjguXyrofbG5GfrW4dLpi5lsc/HwDsH24ghFw0ZSd2rvFxteA8liHVAVwZ2IQcFslsOW8nCxAXQf1rmlc2Y9CCCYOLECGqi5ZUUw6TkR6/LTAP5tP7mNBefXHwSZW9+OtW8jey/FsjormokQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791924347; c=relaxed/simple;
	bh=LOQJGUd0tb6sLwP1Tz4JHSrE5KDQUrXVw/iMmut2Skg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OxVXxKecZ357fRsBq6Y0FDl6vY93divDoYhD+hCRreIT0JXS0ValHwUNaeUnitaa8r1gt0AnF1KaCbQqv7PXbfoav4Oa2bagUVep6EjMEKBEDh0IyHPQCJ1VApM48e/We36Vle8MbE6Pwqa9Gla3CxmMvvEOfvStHexHvTc5kFs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Fzlyc1jv; arc=pass smtp.client-ip=209.85.128.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Fzlyc1jv"
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-8565d77c277so24318217b3.0
        for <virtualization@lists.linux.dev>; Tue, 13 Oct 2026 13:45:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791924344; cv=none;
        d=google.com; s=arc-20260327;
        b=VGphdQKT3V490rMs7Q7YvbJzu6MKuINNKtZ2CGIwPfjrsfHwQChdC7gN1mH7tppNdZ
         5B5y4xOj41s70D4yYXyYDx7drg0eTBnNhHrgVh8jbCTmK4yjT8G3ILeZ0kG7d55aJMoE
         SGY5CuVDPrvQTUrpcCqJ7WNkh6pjRFMRIWDQZo3faW82coDi9X2eCi2cJ5HGnHhCL2Hr
         Idgw4GWAPZgPQahxZzV00di6VSk8kTPuy/jxzjttOKXcxuMgMNMCIqUzg1UGnKASPjrD
         YIapVBHy2i5EIueuG9TbSUgwr/Eac3oJjn/Upp6GwQ3D8cfsXJwZJey5zBPscUGKLjqQ
         VZlQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=fWuW5Tulp1PkJxc5NJ3dJaM8+S2XORNyQfLC7kk9yRk=;
        fh=lzc+WA55r7ZacIxVauvapMzwOdVRcCfDUADe7XVv6yU=;
        b=c0lDzztvw2pD22PDvdIzpmf49P8X7OG4oC0g7sd/zyznQUtQq6oez0xrySllEbAGJm
         ISizjI4y6p0a3foClxiP5+b7zguyLKXPjjjBTFE9KKenDiSTlm+9vIbgUgma8YDbXCYR
         QWll8L5QeVPcpM0sHhf4aXE2U+QY1uvdZ0LtNTrz4DR25bbtnLDmu5/7EJ3kcoRfSZNW
         TDIDkmFoonr0iQ6o9aABuG1Egfg+VLVS3WuyMTasIyBK3lBI7vHOct5NX79mA3zWV2NB
         1UOc3lJS2QGiz2rbutRGo/RzWWQj/VRz8NEGAs9c/ykI2jOAPTkVVU3vP0+naE1UPmyp
         hvAw==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791924344; x=1792529144; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=fWuW5Tulp1PkJxc5NJ3dJaM8+S2XORNyQfLC7kk9yRk=;
        b=Fzlyc1jvRSWjA99PIvsKMf63FRxv1Qbqzg9JmxbV0Q+SeR0fO4nL3rGMrqRSE9+7YP
         LQXs/5XKq42HwCSuzcli+RykT4pTMo8TZkUeBeLHeFqT+kbi5pnmRiZ3XKezaSA20HUZ
         IgC2DrEi4xhFeF+HIziXVhZxRzSbCZ6Fhn/lRWVjkeQSardScAVKnQIZpnxRhjvprXzR
         HJHZJ1nC/bnM3y7NzAegTB+X9hq/6gpXxbLMjOzdZA0gD4qVx31mCYVZ2u3v6fxirxQP
         8Ny4LkqSGtAQoGnyayUiIIDG2I7tRmxFEXEf6tkJwepA0AzdrZRa6xFOvccVbs026I/0
         KLkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791924344; x=1792529144;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=fWuW5Tulp1PkJxc5NJ3dJaM8+S2XORNyQfLC7kk9yRk=;
        b=RADhjCc6TLLxUOxLn1B9brS6gdZaUcGatkUcFiGPiJS0GNboEDQAlUp5kLKqg5LbLo
         WY4gSvgdyqoQhSKq/iL12zjn2n4MaVPjzsmpYzXob5JTYCsRfGY5SSFUWV3fyMnWnLI/
         j+VL9rilX6EgS5KSYUTMMs8qpA1uh4oKhjoCPuTbr2+rxV4550WGD+pWlF3dPlgkrO5L
         8kn3tWrBCxP+mrYjzQCFfYm43/qAEuHUbQjNr9LOTknMmU9CqY5OimqM8fK7/fMowrnl
         KHexqRhRU9pNlrtwbBpJoxXc6xzguNt5dRVmDP5zFCH032FGA6hF6wmBEMIasUm3uIZc
         9g9Q==
X-Forwarded-Encrypted: i=1; AKwUvBxIZtq8gHnLRe9HuZDGQoA/+FIDJcyiWEJ5BcxNPHMtNKti/sB6Cc1l4GqLs9+sO0PEhQAvGzNSxU4+HZ+i5A==@lists.linux.dev
X-Gm-Message-State: AFq9FYKSvaXxWCqdGdPZpdgm1t8SeEIZiNrpNKjMZGfnNhon8jTyIXCv
	w+PMIaUCYuTe6QhGLyxM3e0FHfUYQX0CfJMZKgcfBI23MQXgaE71ZYzdQ83XcnmsHIuR4G4q67g
	hpbxaAsWSJOY340JcLybJ2+jWMdwafDU=
X-Gm-Gg: AYBFou01WuX2X6Liw4eU0QXgIRwsy3eJ7WqBO3MMJeTqqN0zrPLJRc9zFRuCrLVWje3
	btjNO8tjNFEr+Kvt8GEV09WKYzU8aDDBn9jKF3dQEjIhCHcdH1tlAs9F1lrT6iv9i9IL633yn4b
	cYwTbXpf+84gV+9Tt+t86ETAYioMLjpdpzyLDYkiq7f0y3tZMqIlzso3f/53wchjjuYTr/ZUy8u
	3EifCxpqfHpGvREKUdHTzseKXakm520T8pDiFipuZ8HRqjOqY3KFA2RPT4zEZIik/XLvmD+C2f7
	GO6HwS/drYz3iU742YxpMWs0ap70IdKziRy3Y01wuFpUzAxSmZkmcZfkO1xv4g18fukZrel6m7p
	36TzppRnGJE5euqr/eApfEgBUbMm8ih7KGn4YCMoE
X-Received: by 2002:a05:690e:4391:b0:675:3d40:3c34 with SMTP id
 956f58d0204a3-679362b7b92mr2567508d50.68.1791924344382; Tue, 13 Oct 2026
 13:45:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <cover.1791887415.git.mst@redhat.com> <e12c6a45aae251d1642af55d8d3121e554993a66.1791887415.git.mst@redhat.com>
 <20261013070549-mutt-send-email-mst@kernel.org> <CAF=yD-KdTn2rHyp_j8ORr9F5hpm=TzaPRan5+gvLiYBd9HP-sg@mail.gmail.com>
 <20261013143335-mutt-send-email-mst@kernel.org> <CAF=yD-Lz92nGVFab1Dq8M9VusDsKf-ioda8KrZoyh28x3Xtg4Q@mail.gmail.com>
 <20261013163706-mutt-send-email-mst@kernel.org>
In-Reply-To: <20261013163706-mutt-send-email-mst@kernel.org>
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Date: Tue, 13 Oct 2026 14:45:07 -0600
X-Gm-Features: AclHuK_JpsMMVGA2qpRX99GQPNBQTbwUfDE4ZxrsneX5jMqoFaA9d7dnLCSivEw
Message-ID: <CAF=yD-JKeej85t+sCc_5K0b122uw_LiKWwX1fRL2V-QLrGA8QA@mail.gmail.com>
Subject: Re: [PATCH net-next 3/4] net: resolve uncommon partial checksums at ingress
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: linux-kernel@vger.kernel.org, Jason Wang <jasowangio@gmail.com>, 
	=?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org, 
	virtualization@lists.linux.dev, Max Krasnyansky <maxk@qualcomm.com>, 
	Rusty Russell <rusty@rustcorp.com.au>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 13, 2026 at 2:38=E2=80=AFPM Michael S. Tsirkin <mst@redhat.com>=
 wrote:
>
> On Tue, Oct 13, 2026 at 02:32:26PM -0600, Willem de Bruijn wrote:
> > > > > > +
> > > > > > +     if (virtio_net_csum_partial_ok_at_offset(skb, gso_inner_t=
ype, inner_nh,
> > > > > > +                                            inner_proto))
> > > > > > +             return 0;
> > > > > > +
> > > > > > +     if (skb_is_gso(skb))
> > > > > > +             return -EINVAL;
> > > >
> > > > This is a risk the commit message will have to call out.
> > >
> > > I tried with this:
> > >
> > >         > > > We can't easily "complete the checksum" for GSO we don'=
t recognize - GSO
> > >         > > > assumes knowledge of the protocol. We could segment ign=
oring the
> > >         > > > checksum then do whatever csum_start and csum_offset sa=
y, but that
> > >         > > > seems like an overkill for something that should happen=
.
> > >
> > > I guess I can add a more detailed explanation about what the risk is?
> >
> > Let's just explicitly mention the consequence: non-standard GSO
> > packets that previous would be sent may now fail.
> >
> > >
> > > > I don't see a simple way around it. We discussed segmenting here to=
o,
> > > > but that requires intrusive changes to all callers too.
> > > > Alternatively,
> > > >
> > > > 1. call segmentation, but only to see it remove the SKB_GSO_DODGY a=
nd
> > > > thus verify that the TSO/USO packet is valid. Still drop otherwise.
> > > > This also does not add overhead, because it would be called later
> > > > anyway.
> > > >
> > > > 2. a failsafe off-by-default sysctl + static_branch that skips the
> > > > drop when set. Messy, but so is the situation we're dealing with.
> > >
> > > Tack this on top or do you feel it's needed straight away.
> >
> > Not urgent. Can even wait until a report appears. But worth taking a
> > look sooner if either of us gets around to it.
>
> Maybe if people intend all this for stable, I'll feel safer with this in
> there.
>
> Just to make sure, the branch would just short-circuit all checks, yes?

Ah option 2, the failsafe? At least any new failures (GSO) that could
cause regression reports. Operating entirely as before this series
sounds fine too.
