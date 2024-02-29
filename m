Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF17B50A6D
	for <virtualization@lists.linux.dev>; Thu, 29 Feb 2024 08:37:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709195851; cv=none; b=pNhCJbnvrlwzTk8yZ/xoLfgjZ0dEp2SSgc5cGVyf8+FI+APZgIK9VP7wjTK3WWCLZ57gV8plPL57FJsMTvWLxm+yWRer4HbnJt8CcEnFhT3u62zVY8wdsfQCo8ifZ1spCvQ8uwwUCUHxISsiXk5uEsrySKk932Uyl3WNzXOQGhQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709195851; c=relaxed/simple;
	bh=73aWUygvtPP8Z7/LtZcyFtLnYpjq7zVAKtXzB+vWT2Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=o/IF28DuFMAMiOjdt/59x36Dg/eG3NLzpOS0Vt+GANnu26wy8NWV9pRk+ec+naAzN6Xf+uqTFblCgsQX6ji1knutPCPBmfsMXbMCSf6dqqy/F+5tjiuoFMQp0DBdznn1QTYIs/VokJroAJtMuyZ6S0XFcfd50BDbZtYdSLC/+Zc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gAb7QeAY; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gAb7QeAY"
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-56647babfe6so950718a12.3
        for <virtualization@lists.linux.dev>; Thu, 29 Feb 2024 00:37:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709195848; x=1709800648; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=e8cTr0+z19J6pwkR8dLU+gDwd3ZIlpIHp0+RUxF/+gU=;
        b=gAb7QeAYUMB3ULDvAyEqXinyx1JlNkMIxPTqDDNWcNdF0nwbeR9Ogm4hJvppYh93dj
         uorSOQ7ymPMOA94pRbN150CX4Qnd8NiMYzRoUMu/gWWIP9usuWvA/WC3ntQASly44mHG
         8aiuEIvBBRaJrqAd/RBxbU7D83Bv3PybnMD+SY2MpAPPjL4dTVSovgZLdmwtZDmKrFh8
         N4wvGYEMR0uOu16d7b/vTo9sjFvzmkjsV0JBDfVfYUDt70CUJJotCg/L/YfRCLDrhwYD
         PWEKzjECnBdZHs/w0rSuCr+7mWkUttZq3t+7htzwT38rOwq1Ji2py3neEcD6g5gS2luU
         RTeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709195848; x=1709800648;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=e8cTr0+z19J6pwkR8dLU+gDwd3ZIlpIHp0+RUxF/+gU=;
        b=UsvifnuLcta3kuX+sc4kMihMCXs3XGuCRIinWrUjMowucLAwIIGiyuM3JKOqflBXLu
         BYfnNopaS6ehF8aAnEbNiiXdBMwMsiVsy+lLjjryzf7tlkLUWWWQfJlpQ9uos3H2RbY4
         Hdz1LJM6X8I9opj+Ej5YUuB6DuGgQRCMCpdcBuvSCHawQSZ+ET5d3nN/HSF/DNJ74xJQ
         HKur695tE4pZqe0UwHCi2db9ysUiLD0niQcRS/XhI37X5edRfhdznjRQ2GvrUKgZx9Xp
         xzq4HSxleqWmV9NE2RH+TqsAwgPZgvs6j2PgQAq1vNSU6+/1CsOdZgLwnHqnQPLdnXQL
         90xQ==
X-Forwarded-Encrypted: i=1; AJvYcCUG/8kHBtua3Jm7OrfCMT3O6OpxINpbSWcdySZIBCCnDcnWVgFTXw2EAShVBtLdZO7Vo5jqyCUt2G1dZHDE6mvJdZCBT+PsWX/AxBWLluc=
X-Gm-Message-State: AOJu0YwgI9g4kaJIF82W1KQ8O7yP6r8P2gsZ7MwcnrqJKMk+QDJJJLmU
	TpC9ntsYtztENq0SE7gXUfsEB17CvLrSFGv1ueZbQIn6wLFS2J77HeAt26A+ijKLB0EUxCUQI3u
	AV0dSdDcQvrswSEEtTcAEuxnUD6U=
X-Google-Smtp-Source: AGHT+IFLhjfZIE6MHHesG5Kgo+lcNytIZXrW9TCaJs/ONRHajCriDWIZXmhUNamJ26KxMcmMKaD+7mSOf7PlKGyLbYs=
X-Received: by 2002:a05:6402:3097:b0:564:65c5:f048 with SMTP id
 de23-20020a056402309700b0056465c5f048mr902059edb.28.1709195848187; Thu, 29
 Feb 2024 00:37:28 -0800 (PST)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20240202121151.65710-1-liangchen.linux@gmail.com>
 <c8d59e75-d0bb-4a03-9ef4-d6de65fa9356@kernel.org> <CAKhg4tJFpG5nUNdeEbXFLonKkFUP0QCh8A9CpwU5OvtnBuz4Sw@mail.gmail.com>
 <5297dad6499f6d00f7229e8cf2c08e0eacb67e0c.camel@redhat.com>
 <CAKhg4tLbF8SfYD4dU9U9Nhii4FY2dftjPKYz-Emrn-CRwo10mg@mail.gmail.com>
 <73c242b43513bde04eebb4eb581deb189443c26b.camel@redhat.com>
 <CAKhg4tJPjcShkw4-FHFkKOcgzHK27A5pMu9FP7OWj4qJUX1ApA@mail.gmail.com>
 <1b2d471a5d06ecadcb75e3d9155b6d566afb2767.camel@redhat.com>
 <1708652254.1517398-1-xuanzhuo@linux.alibaba.com> <CACGkMEuUeQTJYpZDx8ggqwBWULQS1Fjd_DgPvVMLq-_cjYfm7g@mail.gmail.com>
 <65dcf7a775437_20e0a2087f@john.notmuch>
In-Reply-To: <65dcf7a775437_20e0a2087f@john.notmuch>
From: Liang Chen <liangchen.linux@gmail.com>
Date: Thu, 29 Feb 2024 16:37:10 +0800
Message-ID: <CAKhg4t+dzRPjyRXAifS_TCGPv3SfMMm1CF3pCs18OR+o9v+S_Q@mail.gmail.com>
Subject: Re: [PATCH net-next v5] virtio_net: Support RX hash XDP hint
To: John Fastabend <john.fastabend@gmail.com>
Cc: Jason Wang <jasowang@redhat.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
	Paolo Abeni <pabeni@redhat.com>, Jesper Dangaard Brouer <hawk@kernel.org>, mst@redhat.com, 
	hengqi@linux.alibaba.com, davem@davemloft.net, edumazet@google.com, 
	kuba@kernel.org, netdev@vger.kernel.org, virtualization@lists.linux.dev, 
	linux-kernel@vger.kernel.org, bpf@vger.kernel.org, daniel@iogearbox.net, 
	ast@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 27, 2024 at 4:42=E2=80=AFAM John Fastabend <john.fastabend@gmai=
l.com> wrote:
>
> Jason Wang wrote:
> > On Fri, Feb 23, 2024 at 9:42=E2=80=AFAM Xuan Zhuo <xuanzhuo@linux.aliba=
ba.com> wrote:
> > >
> > > On Fri, 09 Feb 2024 13:57:25 +0100, Paolo Abeni <pabeni@redhat.com> w=
rote:
> > > > On Fri, 2024-02-09 at 18:39 +0800, Liang Chen wrote:
> > > > > On Wed, Feb 7, 2024 at 10:27=E2=80=AFPM Paolo Abeni <pabeni@redha=
t.com> wrote:
> > > > > >
> > > > > > On Wed, 2024-02-07 at 10:54 +0800, Liang Chen wrote:
> > > > > > > On Tue, Feb 6, 2024 at 6:44=E2=80=AFPM Paolo Abeni <pabeni@re=
dhat.com> wrote:
> > > > > > > >
> > > > > > > > On Sat, 2024-02-03 at 10:56 +0800, Liang Chen wrote:
> > > > > > > > > On Sat, Feb 3, 2024 at 12:20=E2=80=AFAM Jesper Dangaard B=
rouer <hawk@kernel.org> wrote:
> > > > > > > > > > On 02/02/2024 13.11, Liang Chen wrote:
> > > > > > > > [...]
> > > > > > > > > > > @@ -1033,6 +1039,16 @@ static void put_xdp_frags(stru=
ct xdp_buff *xdp)
> > > > > > > > > > >       }
> > > > > > > > > > >   }
> > > > > > > > > > >
> > > > > > > > > > > +static void virtnet_xdp_save_rx_hash(struct virtnet_=
xdp_buff *virtnet_xdp,
> > > > > > > > > > > +                                  struct net_device =
*dev,
> > > > > > > > > > > +                                  struct virtio_net_=
hdr_v1_hash *hdr_hash)
> > > > > > > > > > > +{
> > > > > > > > > > > +     if (dev->features & NETIF_F_RXHASH) {
> > > > > > > > > > > +             virtnet_xdp->hash_value =3D hdr_hash->h=
ash_value;
> > > > > > > > > > > +             virtnet_xdp->hash_report =3D hdr_hash->=
hash_report;
> > > > > > > > > > > +     }
> > > > > > > > > > > +}
> > > > > > > > > > > +
> > > > > > > > > >
> > > > > > > > > > Would it be possible to store a pointer to hdr_hash in =
virtnet_xdp_buff,
> > > > > > > > > > with the purpose of delaying extracting this, until and=
 only if XDP
> > > > > > > > > > bpf_prog calls the kfunc?
> > > > > > > > > >
> > > > > > > > >
> > > > > > > > > That seems to be the way v1 works,
> > > > > > > > > https://lore.kernel.org/all/20240122102256.261374-1-liang=
chen.linux@gmail.com/
> > > > > > > > > . But it was pointed out that the inline header may be ov=
erwritten by
> > > > > > > > > the xdp prog, so the hash is copied out to maintain its i=
ntegrity.
> > > > > > > >
> > > > > > > > Why? isn't XDP supposed to get write access only to the pkt
> > > > > > > > contents/buffer?
> > > > > > > >
> > > > > > >
> > > > > > > Normally, an XDP program accesses only the packet data. Howev=
er,
> > > > > > > there's also an XDP RX Metadata area, referenced by the data_=
meta
> > > > > > > pointer. This pointer can be adjusted with bpf_xdp_adjust_met=
a to
> > > > > > > point somewhere ahead of the data buffer, thereby granting th=
e XDP
> > > > > > > program access to the virtio header located immediately befor=
e the
> > > > > >
> > > > > > AFAICS bpf_xdp_adjust_meta() does not allow moving the meta_dat=
a before
> > > > > > xdp->data_hard_start:
> > > > > >
> > > > > > https://elixir.bootlin.com/linux/latest/source/net/core/filter.=
c#L4210
> > > > > >
> > > > > > and virtio net set such field after the virtio_net_hdr:
> > > > > >
> > > > > > https://elixir.bootlin.com/linux/latest/source/drivers/net/virt=
io_net.c#L1218
> > > > > > https://elixir.bootlin.com/linux/latest/source/drivers/net/virt=
io_net.c#L1420
> > > > > >
> > > > > > I don't see how the virtio hdr could be touched? Possibly even =
more
> > > > > > important: if such thing is possible, I think is should be some=
what
> > > > > > denied (for the same reason an H/W nic should prevent XDP from
> > > > > > modifying its own buffer descriptor).
> > > > >
> > > > > Thank you for highlighting this concern. The header layout differ=
s
> > > > > slightly between small and mergeable mode. Taking 'mergeable mode=
' as
> > > > > an example, after calling xdp_prepare_buff the layout of xdp_buff
> > > > > would be as depicted in the diagram below,
> > > > >
> > > > >                       buf
> > > > >                        |
> > > > >                        v
> > > > >         +--------------+--------------+-------------+
> > > > >         | xdp headroom | virtio header| packet      |
> > > > >         | (256 bytes)  | (20 bytes)   | content     |
> > > > >         +--------------+--------------+-------------+
> > > > >         ^                             ^
> > > > >         |                             |
> > > > >  data_hard_start                    data
> > > > >                                   data_meta
> > > > >
> > > > > If 'bpf_xdp_adjust_meta' repositions the 'data_meta' pointer a li=
ttle
> > > > > towards 'data_hard_start', it would point to the inline header, t=
hus
> > > > > potentially allowing the XDP program to access the inline header.
>
> Fairly late to the thread sorry. Given above layout does it make sense to
> just delay extraction to the kfunc as suggested above? Sure the XDP progr=
am
> could smash the entry in virtio header, but this is already the case for
> anything else there. A program writing over the virtio header is likely
> buggy anyways. Worse that might happen is bad rss values and mappings?

Thank you for raising the concern. I am not quite sure if the XDP
program is considered buggy, as it is agnostic to the layout of the
inline header.
Let's say an XDP program calls bpf_xdp_adjust_meta to adjust data_meta
to point to the inline header and overwrites it without even knowing
of its existence. Later, when the XDP program invokes the kfunc to
retrieve the hash, incorrect data would be returned. In this case, the
XDP program seems to be doing everything legally but ends up with the
wrong hash data.

Thanks,
Liang

>
> I like seeing more use cases for the hints though.
>
> Thanks!
> John
