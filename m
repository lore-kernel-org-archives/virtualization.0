Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 141E31BF53
	for <virtualization@lists.linux.dev>; Tue, 13 Aug 2024 03:46:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723520765; cv=none; b=YaHgEmLJddfVvEz69ixXDaO4zD2wi1gxM3qtBPUX7dC5m6HKAgNDZKYPmUrkWCwpPMiAQAxUYmMCq32qxEQpIktOBLEJVfw1ZkH6FpHOvXGeX1pY9BsE8X2FPKtdVkEcvCQ6yvCAigv+CO8Vd0mU5JPj5+k30mps7fySZx5tHfo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723520765; c=relaxed/simple;
	bh=yceP9DAWKPKlT7Sq5hjZWKK36tp3OUW2w6K7QPwMXj4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aVmAKcZAOoPHWFLk+4aAsSyu7f/CD8+mJ+oNL26bp4hvTyAWBdwQVWGk5nn6B9J9nF+c6rtKBVtVjD1civ7pP4A559t3zpR30uaYMNXgzqPcsXRYJbySAO3EhvDSJLU6/MiG5BmrBLewu9+lpp/9Rlan42eFoOiYW4nAT4zOvnU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=hzeEWx74; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hzeEWx74"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1723520763;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VLzbGP2JsMnr9jy5iZ9KVQ1RMqy5vYx7gbKlTyJ7iAc=;
	b=hzeEWx74XvIbn+xSkUjmfYR/gNzObLxcGtljCNhiP3t9x1aYLSxVr2LBoNOkburAsUC0Yh
	cH/4OlVjVZLrw6Ljg7y9RrRv8QAJksGjdshR9Hn/DNjMZM6p71dj6tLJpY33uwEw5fp0As
	Q70P0Cl3uPnSvCy3QjZPfdWpx6fAEpU=
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com
 [209.85.210.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-691-S0x5euVYO9ihIf1WCn4jzA-1; Mon, 12 Aug 2024 23:45:59 -0400
X-MC-Unique: S0x5euVYO9ihIf1WCn4jzA-1
Received: by mail-pf1-f199.google.com with SMTP id d2e1a72fcca58-7106ed795deso2904690b3a.1
        for <virtualization@lists.linux.dev>; Mon, 12 Aug 2024 20:45:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723520758; x=1724125558;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VLzbGP2JsMnr9jy5iZ9KVQ1RMqy5vYx7gbKlTyJ7iAc=;
        b=QxXCAw58ezvIOXYgxbXV7Q1aKQz00Z1PnKMoV1wLvkWd2FIP9+a35lnBOjDsYC6jyd
         ZTXqTuPgWUZdi3ji6fvFOI2XuZOKby+sMtvcvZ8a6kO9jogjGc+8UEOfk0SEVmcrZxOx
         kLrdKx9KGVsRie+owfzVhsceZ6CrUiXbxQp0LKbMoWcbMzhQ8TsGnZmnrVMvwna5jK7F
         WgV7xfxhVCgriSQ5Rh7NSUoSg51yk6UhiPjkP0unokoCRMp7jlqDUGZTicZEHKqgSCNG
         bnBeq2mmxExwmXdQW0hoyJ4RcRgu11Hc0gat6LkfE1AfHQNXMRmRiJaQ1W21ZYHWQh8u
         8GTw==
X-Forwarded-Encrypted: i=1; AJvYcCVaIkXa1n5j4LxNqIdJICaeK1sQLpgkkVScpvdbUILSTFlTxrhJznKDa1nCVDCZTQBOImnAkK+dc9Bk1D7e/GeLzmKaDrsc8QARSiODBeQ=
X-Gm-Message-State: AOJu0Yw11n6a+cQmbZCxEB2V0j3Va+/wFoai32fgYeMVGRTVTMMCdJVY
	+d2jPYNvk5LD83Z+ptqjTsWyWCbLjSl7m0Z2eDRcDJkn9v9lTLHHoFrjdjqvC5+1JkFcx/zVLri
	TrOBmqXpFCJPp7mLTvkRt+abkqeJThMnVQGUNGJlvcDGDOikPFtnLGqUROrBhpuiahiXZ54IZ5V
	n8n1W0PmlN4LlhcTQEXZ/y0Zpi2c2864GcdGf8gaY=
X-Received: by 2002:a05:6a20:d807:b0:1c2:8efc:88e9 with SMTP id adf61e73a8af0-1c8d758f7b3mr2695456637.40.1723520758531;
        Mon, 12 Aug 2024 20:45:58 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHzdASWlW/KSJWKCN/sNH/7JSAZUMKWVCaiEG3UXrFA9r5uSYwo8aJRYAd+QG4neTb0YfGVMCyAfG0csmi814c=
X-Received: by 2002:a05:6a20:d807:b0:1c2:8efc:88e9 with SMTP id
 adf61e73a8af0-1c8d758f7b3mr2695435637.40.1723520757960; Mon, 12 Aug 2024
 20:45:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20240806022224.71779-1-jasowang@redhat.com> <20240806022224.71779-5-jasowang@redhat.com>
 <20240806082436-mutt-send-email-mst@kernel.org>
In-Reply-To: <20240806082436-mutt-send-email-mst@kernel.org>
From: Jason Wang <jasowang@redhat.com>
Date: Tue, 13 Aug 2024 11:45:46 +0800
Message-ID: <CACGkMEuNqpeNwmFNu-104RxRr0VnBt5Tv_MLg0UdWmjoDxZsMA@mail.gmail.com>
Subject: Re: [PATCH net-next V6 4/4] virtio-net: synchronize probe with ndo_set_features
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: xuanzhuo@linux.alibaba.com, eperezma@redhat.com, davem@davemloft.net, 
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, 
	virtualization@lists.linux.dev, netdev@vger.kernel.org, 
	linux-kernel <linux-kernel@vger.kernel.org>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 6, 2024 at 8:25=E2=80=AFPM Michael S. Tsirkin <mst@redhat.com> =
wrote:
>
> On Tue, Aug 06, 2024 at 10:22:24AM +0800, Jason Wang wrote:
> > We calculate guest offloads during probe without the protection of
> > rtnl_lock. This lead to race between probe and ndo_set_features. Fix
> > this by moving the calculation under the rtnl_lock.
> >
> > Signed-off-by: Jason Wang <jasowang@redhat.com>
>
> Fixes tag pls?

Fixes: 3f93522ffab2 ("virtio-net: switch off offloads on demand if
possible on XDP set")

Thanks


>
> > ---
> >  drivers/net/virtio_net.c | 10 +++++-----
> >  1 file changed, 5 insertions(+), 5 deletions(-)
> >
> > diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> > index fc5196ca8d51..1d86aa07c871 100644
> > --- a/drivers/net/virtio_net.c
> > +++ b/drivers/net/virtio_net.c
> > @@ -6596,6 +6596,11 @@ static int virtnet_probe(struct virtio_device *v=
dev)
> >               netif_carrier_on(dev);
> >       }
> >
> > +     for (i =3D 0; i < ARRAY_SIZE(guest_offloads); i++)
> > +             if (virtio_has_feature(vi->vdev, guest_offloads[i]))
> > +                     set_bit(guest_offloads[i], &vi->guest_offloads);
> > +     vi->guest_offloads_capable =3D vi->guest_offloads;
> > +
> >       rtnl_unlock();
> >
> >       err =3D virtnet_cpu_notif_add(vi);
> > @@ -6604,11 +6609,6 @@ static int virtnet_probe(struct virtio_device *v=
dev)
> >               goto free_unregister_netdev;
> >       }
> >
> > -     for (i =3D 0; i < ARRAY_SIZE(guest_offloads); i++)
> > -             if (virtio_has_feature(vi->vdev, guest_offloads[i]))
> > -                     set_bit(guest_offloads[i], &vi->guest_offloads);
> > -     vi->guest_offloads_capable =3D vi->guest_offloads;
> > -
> >       pr_debug("virtnet: registered device %s with %d RX and TX vq's\n"=
,
> >                dev->name, max_queue_pairs);
> >
> > --
> > 2.31.1
>

