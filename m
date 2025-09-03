Received: from mail-qk1-f178.google.com (mail-qk1-f178.google.com [209.85.222.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0547D3054E5
	for <virtualization@lists.linux.dev>; Wed,  3 Sep 2025 13:51:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756907519; cv=none; b=it9mN1dwYxQgRPwbnaby2rjKSJYEk9JQXBqY2uiqCFggdlAAXs4z954GceK2ZWSyHZSmi1ajNoPLlACES/ld1u0Z0u1foRBbslduln1yTZnaikqmCBQBQmvQVaPCoB+7WSau6d+YPNdKvFkjrMtz97wUQoeMIL31UIVgT3NFqhI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756907519; c=relaxed/simple;
	bh=7C7Vprc6WxqGCYsdl0EetVroGpHV19XxLdEBnU9vA14=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=T7Gt/uptHiBsRP2N1b4Pn2cYHPJ0rmVc1+66bGNr97NKmI551xdh6O1toBRL8dboIoR88BUClap4t+B2fx6DxYVfXS46wT+cD2lKgTpQXVXme7iaehS/IeD3wEFpric3M2h7KNu9UZpJMcTsyiXMXw8276AJBDUfCXleloVGjNA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OnIKS4/S; arc=none smtp.client-ip=209.85.222.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OnIKS4/S"
Received: by mail-qk1-f178.google.com with SMTP id af79cd13be357-8072bb631daso143993785a.1
        for <virtualization@lists.linux.dev>; Wed, 03 Sep 2025 06:51:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756907517; x=1757512317; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oPdtlv7HxzVylpclcQP0fll3az3xTGmJG0SNLO2peok=;
        b=OnIKS4/S7lc5gQbo9x9s+njowTd+1SyzXABQX27OgdVLvqwlRImCh0hjpgHxtzm5s4
         V05PKAl4UCwE1I+cvxviuFGA9vI/nWftpRLkeKSZJllMYLfb8Ay1C1wKfSCEtXOaDfZ6
         h4sZkhg/vK5+HsbWwuktfLXDkdtwby48olrYA5dn6GGxcCoyPXJyvuLruegaC2x64JkQ
         YwSrRK9KsvG6GgVL0JIQIfeJzts20HFEyb3Ed6NAZfQq8cEzXRotEKB3evGkYGwO37fs
         WjgY+ovECBWgVJ9Otz6HR+0F0CagGl85xu2dGlwoBag96n3L9FjUC4jTMV7VJsH4TYlD
         qDjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756907517; x=1757512317;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=oPdtlv7HxzVylpclcQP0fll3az3xTGmJG0SNLO2peok=;
        b=OEZBtD3LBphdJdGoLFtkJiGo6OdRgEmXx3nmtzjELP08N79x88Fefwre0ybbJvoEI7
         VOb9Iwqhu0iaVaIuk8k1VbwkyHj5F1dfAxUZh4z+W35/e5Hg7S2I4/b6jQQPNP0gx+mB
         UkECgwLObDidQB2++0fcOwS2S8U3z109JemC5cnRcqsyy6bwYzLNrTIuq09vYi/CZT/2
         q5EIHjX1wLDGQ75q8shiOzIwmPXnFRcq8hv0upOPW9kGqJX4pRZvx3n1nUmdMjXDSAwa
         0HahbymNDA1fCXcqBJxlRUGA4rrWqgWNHlZWxKSATu7rJE3c234EmhTJ6GIWkD1Mg1a8
         +kyg==
X-Forwarded-Encrypted: i=1; AJvYcCXTBKFlKbV4AKHvVIE6tR1DeiBjAQzwVtwVFE5OIgK1+BIEkfBFSd49HbiEg0hmplhN5jgtbasHtHb1/HeGng==@lists.linux.dev
X-Gm-Message-State: AOJu0YwGQvZLiiYTplnxws/C+0+jAMY3pNj+xREf+HMdB+A19+qE8FGc
	ZqyjwJ6miJYDvvPiYazZWbtGQ6RF7M8byjWQ5UqaKqcHAqXLpZHJsAHv
X-Gm-Gg: ASbGncu3gC5N92zykInt+cjqZkQfE1XnGUFhtWqlIjxcuAh5KkbbGDIJgVR6H1AxKFu
	5LYfmOiXxzLeJH+4Ofyfw4WTfw2eYxrNZ4ucjDTz+XupZTW/6mlnVqdifogDbjMZOmFjauvkgNM
	zYhx4cK8uweKQFrIXUoq+ihWNW+4xPBgmACiuVedMRvlZ/PoOg71CBLEh5GkBeJsftWU7esTMWO
	vq8slfEYqpLpmflOHLi5yFFzTrFPrYnr2xD3i8/84YfhyKZxEzoAxLW8V2nOLIzco1b/E2AoUbc
	AgJ9KlapKcCj8vTJZKsEvjS3KsIXoxmEAJqloEcEt4ooHld4m6/33v6HwDJQ2nqj00D2zH5pUae
	VOM3dsR13FnFOFIItvaoRGmLhzcKnPCesgr0cSA7PpGjApAcLN8vps9dJH489RqVngS3KS5dOce
	yVRFSbfPhvX8W4
X-Google-Smtp-Source: AGHT+IHd5QO8rXHYKVepHmXV1bdJPpjQGcBtqXOELN9+bo/yCZVPywfEO7HQeg7wtxFmypA4bZ1CMQ==
X-Received: by 2002:a05:620a:1a21:b0:7f3:62f3:32b1 with SMTP id af79cd13be357-7ff26eaadf7mr1574330785a.1.1756907516825;
        Wed, 03 Sep 2025 06:51:56 -0700 (PDT)
Received: from gmail.com (141.139.145.34.bc.googleusercontent.com. [34.145.139.141])
        by smtp.gmail.com with UTF8SMTPSA id af79cd13be357-80aa78f2affsm108414785a.30.2025.09.03.06.51.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Sep 2025 06:51:56 -0700 (PDT)
Date: Wed, 03 Sep 2025 09:51:55 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Jason Wang <jasowang@redhat.com>, 
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: Simon Schippers <simon.schippers@tu-dortmund.de>, 
 mst@redhat.com, 
 eperezma@redhat.com, 
 stephen@networkplumber.org, 
 netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 virtualization@lists.linux.dev, 
 kvm@vger.kernel.org, 
 Tim Gebauer <tim.gebauer@tu-dortmund.de>
Message-ID: <willemdebruijn.kernel.372e97487ad8b@gmail.com>
In-Reply-To: <CACGkMEshZGJfh+Og_xrPeZYoWkBAcvqW8e93_DCr7ix4oOaP8Q@mail.gmail.com>
References: <20250902080957.47265-1-simon.schippers@tu-dortmund.de>
 <20250902080957.47265-5-simon.schippers@tu-dortmund.de>
 <willemdebruijn.kernel.251eacee11eca@gmail.com>
 <CACGkMEshZGJfh+Og_xrPeZYoWkBAcvqW8e93_DCr7ix4oOaP8Q@mail.gmail.com>
Subject: Re: [PATCH 4/4] netdev queue flow control for vhost_net
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable

Jason Wang wrote:
> On Wed, Sep 3, 2025 at 5:31=E2=80=AFAM Willem de Bruijn
> <willemdebruijn.kernel@gmail.com> wrote:
> >
> > Simon Schippers wrote:
> > > Stopping the queue is done in tun_net_xmit.
> > >
> > > Waking the queue is done by calling one of the helpers,
> > > tun_wake_netdev_queue and tap_wake_netdev_queue. For that, in
> > > get_wake_netdev_queue, the correct method is determined and saved i=
n the
> > > function pointer wake_netdev_queue of the vhost_net_virtqueue. Then=
, each
> > > time after consuming a batch in vhost_net_buf_produce, wake_netdev_=
queue
> > > is called.
> > >
> > > Co-developed-by: Tim Gebauer <tim.gebauer@tu-dortmund.de>
> > > Signed-off-by: Tim Gebauer <tim.gebauer@tu-dortmund.de>
> > > Signed-off-by: Simon Schippers <simon.schippers@tu-dortmund.de>
> > > ---
> > >  drivers/net/tap.c      |  6 ++++++
> > >  drivers/net/tun.c      |  6 ++++++
> > >  drivers/vhost/net.c    | 34 ++++++++++++++++++++++++++++------
> > >  include/linux/if_tap.h |  2 ++
> > >  include/linux/if_tun.h |  3 +++
> > >  5 files changed, 45 insertions(+), 6 deletions(-)
> > >
> > > diff --git a/drivers/net/tap.c b/drivers/net/tap.c
> > > index 4d874672bcd7..0bad9e3d59af 100644
> > > --- a/drivers/net/tap.c
> > > +++ b/drivers/net/tap.c
> > > @@ -1198,6 +1198,12 @@ struct socket *tap_get_socket(struct file *f=
ile)
> > >  }
> > >  EXPORT_SYMBOL_GPL(tap_get_socket);
> > >
> > > +void tap_wake_netdev_queue(struct file *file)
> > > +{
> > > +     wake_netdev_queue(file->private_data);
> > > +}
> > > +EXPORT_SYMBOL_GPL(tap_wake_netdev_queue);
> > > +
> > >  struct ptr_ring *tap_get_ptr_ring(struct file *file)
> > >  {
> > >       struct tap_queue *q;
> > > diff --git a/drivers/net/tun.c b/drivers/net/tun.c
> > > index 735498e221d8..e85589b596ac 100644
> > > --- a/drivers/net/tun.c
> > > +++ b/drivers/net/tun.c
> > > @@ -3739,6 +3739,12 @@ struct socket *tun_get_socket(struct file *f=
ile)
> > >  }
> > >  EXPORT_SYMBOL_GPL(tun_get_socket);
> > >
> > > +void tun_wake_netdev_queue(struct file *file)
> > > +{
> > > +     wake_netdev_queue(file->private_data);
> > > +}
> > > +EXPORT_SYMBOL_GPL(tun_wake_netdev_queue);
> >
> > Having multiple functions with the same name is tad annoying from a
> > cscape PoV, better to call the internal functions
> > __tun_wake_netdev_queue, etc.
> >
> > > +
> > >  struct ptr_ring *tun_get_tx_ring(struct file *file)
> > >  {
> > >       struct tun_file *tfile;
> > > diff --git a/drivers/vhost/net.c b/drivers/vhost/net.c
> > > index 6edac0c1ba9b..e837d3a334f1 100644
> > > --- a/drivers/vhost/net.c
> > > +++ b/drivers/vhost/net.c
> > > @@ -130,6 +130,7 @@ struct vhost_net_virtqueue {
> > >       struct vhost_net_buf rxq;
> > >       /* Batched XDP buffs */
> > >       struct xdp_buff *xdp;
> > > +     void (*wake_netdev_queue)(struct file *f);
> >
> > Indirect function calls are expensive post spectre. Probably
> > preferable to just have a branch.
> >
> > A branch in `file->f_op !=3D &tun_fops` would be expensive still as i=
t
> > may touch a cold cacheline.
> >
> > How about adding a bit in struct ptr_ring itself. Pahole shows plenty=

> > of holes. Jason, WDYT?
> >
> =

> I'm not sure I get the idea, did you mean a bit for classifying TUN
> and TAP? If this is, I'm not sure it's a good idea as ptr_ring should
> have no knowledge of its user.

That is what I meant.
 =

> Consider there were still indirect calls to sock->ops, maybe we can
> start from the branch.

What do you mean?

Tangential: if indirect calls really are needed in a hot path, e.g.,
to maintain this isolation of ptr_ring from its users, then
INDIRECT_CALL wrappers can be used to avoid the cost.

That too effectively breaks the isolation between caller and callee.
But only for the most important N callers that are listed in the
INDIRECT_CALL_? wrapper.
