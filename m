Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E0831A2C28
	for <virtualization@lists.linux.dev>; Wed,  8 May 2024 02:20:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715134822; cv=none; b=Aj0uDKO8TyQt7Jcs4Gg2ZZtjk3OVZYA4cqLpy/DHEEAgSPwI6BImazn+/w7HFIbn92PUS3sZc2XOJGjG5QqbWoNG8MEdNA7aJj/zYV3ZU8n39deMWjbLXPYGmugae/zggpE8SS6JwJ7BHX2W8hooJIaeI4y1OZ/ZsCFr5BnM9dM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715134822; c=relaxed/simple;
	bh=To48W6gHUNYXb3bRuXaPMRqay8anRjSoz6uMYJy9qcw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lLw7MEWDQVh1bmHmlb3AYFecBUak4GfIq8yWcPnYVPiS+VSnqYDUqf/hCdIJtC3nF4kEWErK+XKFqfFbE5VuI7jT3KKSemlUzXHOF5GtFAn6N0gDAlFBotXAhStsjBQ/JnNIbL7qGbR48DNj3jkts1TfZreG4h0CD7kAc7UcTck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=FM+64Zwf; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FM+64Zwf"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1715134819;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=U1EMMCLnKM7Cf1E2LbokRIGtBgxEkk3Z+5jGNuEeHVw=;
	b=FM+64ZwfWKaj84dkMU4HEk7kbwfhDP0xUWR2r83ZLZjh+ISPcZOeHek2Fa1cwzZgv7VecX
	Zfhvw621D59WFAbUJKAxiviUtGK+T3p7FrCCFkkjD9+nYByhoMsNmMQhQ0y7PrBZx+q2sF
	42ahBxP/ypf+KEtrLdmSbyr4iHSFdAQ=
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com
 [209.85.215.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-452-pdEfVVRRN1-iH8lgPm9oaA-1; Tue, 07 May 2024 22:20:18 -0400
X-MC-Unique: pdEfVVRRN1-iH8lgPm9oaA-1
Received: by mail-pg1-f197.google.com with SMTP id 41be03b00d2f7-6292562bac4so3001729a12.1
        for <virtualization@lists.linux.dev>; Tue, 07 May 2024 19:20:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715134817; x=1715739617;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=U1EMMCLnKM7Cf1E2LbokRIGtBgxEkk3Z+5jGNuEeHVw=;
        b=hqv1GYFaE80LkS06OcNVyKM0LI702I2SsJlby216CqEZ958Z//W5dXXGDnei4FYSRI
         /IM/qUfiRRCNw8Otq4gZeRfh8lOeHy6uvNhWDB7dECXjnbp48Z5xBng8hFLZTIGwjPJL
         1tS9QrssWEx2OcZgEyyk+i8//ZqG0pLkJ2KMLDJcWDvSwV6OuphUlXH6RtDYwHVz+TzQ
         QZPE+s0bSULhwforuWDtTWfZxfbfPhH2+BcHC8zVXA44G0fUNGaAMT/mZPZrH1XQQidi
         9LicGO026MEscBt7iy7y5mjo1oTem7Mo35bxwStzJgB9AoZWAiKfsk2PcxrNMT+Hx3yr
         S4+A==
X-Forwarded-Encrypted: i=1; AJvYcCWEtNhy2Czgt/NmSQZaOU9ek6Ymi6EUaTz8YlyZlRIx0WFIG+iCSyMvpaLqzPZlnNeEse3G4RmrRhbyF4hs1fm+4SmdLVVIAEv7D6Xtczs=
X-Gm-Message-State: AOJu0YwsgCZtOQknvVD5MEA2rHWsnbtF+l8yU0fSwb95qWl2ZPKF7kaX
	EKczsbChnbsmwb16fN+OX1vqdNEo1G7vsSmblJlY3uJMa9psoojyvct5fv4UnCwdFBI3Q6+kQIQ
	XVtrXP3i5nRstGASjyDj8cgFNzHz1IhWK40y3t3Sz4ywgthMZxPc96H5ABPPAkZqsgRHc288eOY
	nSa4edbr89YKtxf5YHq/hnbjMhGD5DZnp15TI8/5s=
X-Received: by 2002:a17:902:c10c:b0:1ec:71f0:4009 with SMTP id d9443c01a7336-1eeb078ff34mr16722105ad.53.1715134817002;
        Tue, 07 May 2024 19:20:17 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFWGBbUy7QqDhlPL8ZopBBTJeNKNw21Wp6a93ZqpKsHy4u4FCtuZt1zn63NHEcmGwBuKEM6aCkZ5sX+2desa0Y=
X-Received: by 2002:a17:902:c10c:b0:1ec:71f0:4009 with SMTP id
 d9443c01a7336-1eeb078ff34mr16721845ad.53.1715134816614; Tue, 07 May 2024
 19:20:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20240426065441.120710-1-hengqi@linux.alibaba.com>
 <20240426065441.120710-2-hengqi@linux.alibaba.com> <CACGkMEvUT_uyLaqi533BUOqCYW1dYZTqdW_CC3-LgQXhhdJYFw@mail.gmail.com>
 <1715064795.2147572-1-hengqi@linux.alibaba.com>
In-Reply-To: <1715064795.2147572-1-hengqi@linux.alibaba.com>
From: Jason Wang <jasowang@redhat.com>
Date: Wed, 8 May 2024 10:20:05 +0800
Message-ID: <CACGkMEtdk8L9jAh+9YAE0Nwwsd2_XXULU68mFn5Rje6f-MHWAw@mail.gmail.com>
Subject: Re: [PATCH net-next v2 1/2] virtio_net: introduce ability to get
 reply info from device
To: Heng Qi <hengqi@linux.alibaba.com>
Cc: netdev@vger.kernel.org, virtualization@lists.linux.dev, 
	"Michael S . Tsirkin" <mst@redhat.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
	Eric Dumazet <edumazet@google.com>, "David S . Miller" <davem@davemloft.net>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, May 7, 2024 at 2:56=E2=80=AFPM Heng Qi <hengqi@linux.alibaba.com> w=
rote:
>
> On Tue, 7 May 2024 14:24:19 +0800, Jason Wang <jasowang@redhat.com> wrote=
:
> > On Fri, Apr 26, 2024 at 2:54=E2=80=AFPM Heng Qi <hengqi@linux.alibaba.c=
om> wrote:
> > >
> > > From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> > >
> > > As the spec https://github.com/oasis-tcs/virtio-spec/commit/42f389989=
823039724f95bbbd243291ab0064f82
> > >
> > > Based on the description provided in the above specification, we have
> > > enabled the virtio-net driver to support acquiring some response
> > > information from the device via the CVQ (Control Virtqueue).
> > >
> > > Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> >
> > I wonder if we need to tweak the spec as it has:
> >
> > """
> > Upon disabling and re-enabling a transmit virtqueue, the device MUST
> > set the coalescing parameters of the virtqueue
> > to those configured through the VIRTIO_NET_CTRL_NOTF_COAL_TX_SET
> > command, or, if the driver did not set any TX coalescing parameters,
> > to 0.
> > """
> >
> > So for reset, this patch tells us the device would have a non-zero
> > default value.
> >
> > But spec tolds us after vq reset, it has a zero default value ...
>
> Maybe we add a bool or flag for driver to mark whether the user has activ=
ely
> configured interrupt coalescing parameters. Then we can take actions when
> vq reset occurs?

I basically mean we probably need to tweak the spec. For example say
the device may have a default value for coalescing so driver need to
read them.

Thanks

>
> Thanks.
>
> >
> > Thanks
> >
> >
> > > ---
> > >  drivers/net/virtio_net.c | 24 +++++++++++++++++-------
> > >  1 file changed, 17 insertions(+), 7 deletions(-)
> > >
> > > diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> > > index 7176b956460b..3bc9b1e621db 100644
> > > --- a/drivers/net/virtio_net.c
> > > +++ b/drivers/net/virtio_net.c
> > > @@ -2527,11 +2527,12 @@ static int virtnet_tx_resize(struct virtnet_i=
nfo *vi,
> > >   * supported by the hypervisor, as indicated by feature bits, should
> > >   * never fail unless improperly formatted.
> > >   */
> > > -static bool virtnet_send_command(struct virtnet_info *vi, u8 class, =
u8 cmd,
> > > -                                struct scatterlist *out)
> > > +static bool virtnet_send_command_reply(struct virtnet_info *vi, u8 c=
lass, u8 cmd,
> > > +                                      struct scatterlist *out,
> > > +                                      struct scatterlist *in)
> > >  {
> > > -       struct scatterlist *sgs[4], hdr, stat;
> > > -       unsigned out_num =3D 0, tmp;
> > > +       struct scatterlist *sgs[5], hdr, stat;
> > > +       u32 out_num =3D 0, tmp, in_num =3D 0;
> > >         int ret;
> > >
> > >         /* Caller should know better */
> > > @@ -2549,10 +2550,13 @@ static bool virtnet_send_command(struct virtn=
et_info *vi, u8 class, u8 cmd,
> > >
> > >         /* Add return status. */
> > >         sg_init_one(&stat, &vi->ctrl->status, sizeof(vi->ctrl->status=
));
> > > -       sgs[out_num] =3D &stat;
> > > +       sgs[out_num + in_num++] =3D &stat;
> > >
> > > -       BUG_ON(out_num + 1 > ARRAY_SIZE(sgs));
> > > -       ret =3D virtqueue_add_sgs(vi->cvq, sgs, out_num, 1, vi, GFP_A=
TOMIC);
> > > +       if (in)
> > > +               sgs[out_num + in_num++] =3D in;
> > > +
> > > +       BUG_ON(out_num + in_num > ARRAY_SIZE(sgs));
> > > +       ret =3D virtqueue_add_sgs(vi->cvq, sgs, out_num, in_num, vi, =
GFP_ATOMIC);
> > >         if (ret < 0) {
> > >                 dev_warn(&vi->vdev->dev,
> > >                          "Failed to add sgs for command vq: %d\n.", r=
et);
> > > @@ -2574,6 +2578,12 @@ static bool virtnet_send_command(struct virtne=
t_info *vi, u8 class, u8 cmd,
> > >         return vi->ctrl->status =3D=3D VIRTIO_NET_OK;
> > >  }
> > >
> > > +static bool virtnet_send_command(struct virtnet_info *vi, u8 class, =
u8 cmd,
> > > +                                struct scatterlist *out)
> > > +{
> > > +       return virtnet_send_command_reply(vi, class, cmd, out, NULL);
> > > +}
> > > +
> > >  static int virtnet_set_mac_address(struct net_device *dev, void *p)
> > >  {
> > >         struct virtnet_info *vi =3D netdev_priv(dev);
> > > --
> > > 2.32.0.3.g01195cf9f
> > >
> >
>

