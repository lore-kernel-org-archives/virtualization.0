Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E06515A8
	for <virtualization@lists.linux.dev>; Wed, 17 Jul 2024 01:19:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721179163; cv=none; b=qNXi3cSTpjuTRYUBnoJq5nZtlvoq7hdEQXGl73k0pN2P9e+im28MVGKlnXZAx3YJgXaXMGc3TDkVgxrOpGByfLSekyvk/3HcxAI4kpAbVZeG8CgDMmeJX3aO33UAtBSwD6v0HI4foVX/fjSZ9AfA5SIDPWETPvZLQmwv6wFIeI8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721179163; c=relaxed/simple;
	bh=oziEPybKPGKKJX9eqpNcwIXuPIslkqwhKxm4ZyKRbsQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AUFKBtXqsFSxCekNt6c5XsEzPKPfS/0QAPugvDhjR1BBQI0nEIIC88cvJxnJoY7CFp0IQwlFB0ngwuCLf6lSf9ddhPHg3mkN1lSFGlO6/JehFlqNYXd9ThTpdJBIVcugwF/JjAsS8bKehIHjVcGhoJw9ZrcNLnTBL8HsCcMLuD4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=NA4jB0Zh; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NA4jB0Zh"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1721179160;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=J+7YGyDFen1uURg1+GOQ6tfcaDLJpyDVLVSUf1Ukjs0=;
	b=NA4jB0Zh4cr21Yk/rU1z6YuLhi3YpD664nu8UEI9XVpammuc3sbk5t8c5xuw2qHGW3ThKe
	ycHwwYgPkWwG9MWEy/p1zUlYCrdLcSu4IZ3y7Q/EmPzwRRRplkMkRf+xE05gShGqrPWRqf
	um1BozD0J05u5IWI+cCJAoee4ZHubCk=
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-689-G6awnUjtOvmwvoT2Ac9h9A-1; Tue, 16 Jul 2024 21:19:15 -0400
X-MC-Unique: G6awnUjtOvmwvoT2Ac9h9A-1
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-2c97ff21741so5470643a91.1
        for <virtualization@lists.linux.dev>; Tue, 16 Jul 2024 18:19:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721179154; x=1721783954;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=J+7YGyDFen1uURg1+GOQ6tfcaDLJpyDVLVSUf1Ukjs0=;
        b=GFR/fTqEpcpbPGdv2CIybbk7w6GhI2tp+h5fiHWeLSntfxOkxvd9YFwFq3z7CPI3cV
         JstNI1000320jZ7pXbIwWrJ4ZEh2kRCQ9TotoVwNaC7q07MeVE/liFzUHXcJqNSfdM8U
         ckZDScWPA5bSXnJ0o+VxeAX+R3Z0YjuqtjL5ygkWOYIgFAXKNA3OukGrWLOKeOxbMBz5
         iIucZ1zO0n3VCDek9glO8MVz1tzWqFAX3JGnUc5WV35PXo7xltaMreoPzb5Tpi9+tSeM
         DMBGID23RBE3SSME4z/mHEafoQ2etuxcvI6QUujF6fS8suE9QU4YAc4uq74G+6IpSSVh
         rkKw==
X-Forwarded-Encrypted: i=1; AJvYcCXE4hGi0hM/wiHcJdk/xDdhzPJoZezAvHvRWxY5+V8H6E8oENjNBO1n3WBx9hg3Bg76MhauXj+NkgFjBWEWUisalyrfUDuG6pVuG+c9yOY=
X-Gm-Message-State: AOJu0YxF8dzNQgJ11I1j2w8lUIHJvDwYBReHlJNoAI1bUaYmKuO3vu15
	d7KEpsCE8Axx4BBDlcNjB/q/NfE/na+reI/BfHfjOUjtW7CoJanyevLMumBvmmHMfRpdp35oYLE
	nuz5xWHXY4iFbsgJuKTKM2tnYgXfhPfZcfbDRn3H3Cx2UzE7lhVmtd+8EnRSxU/ZsC0jZsgFQsT
	PFi7P9knSXxokRIMSHRm80DYKcI2KHY50z5q5ESOI=
X-Received: by 2002:a17:90a:4b8d:b0:2ca:7f3e:a10f with SMTP id 98e67ed59e1d1-2cb5246a470mr98780a91.9.1721179154337;
        Tue, 16 Jul 2024 18:19:14 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG/1co9VHWeOnJTmAO8d1EtRjX/srZeJbipZi+BIS6hvcIBcotrZRve5FhK5PcQbqQn+X8Z2HlJnPMOuJzY15M=
X-Received: by 2002:a17:90a:4b8d:b0:2ca:7f3e:a10f with SMTP id
 98e67ed59e1d1-2cb5246a470mr98757a91.9.1721179153862; Tue, 16 Jul 2024
 18:19:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20240709080214.9790-1-jasowang@redhat.com> <20240709080214.9790-4-jasowang@redhat.com>
 <20240709090743-mutt-send-email-mst@kernel.org> <CACGkMEv4CVK4YdOvHEbMY3dLc3cxF_tPN8H4YO=0rvFLaK-Upw@mail.gmail.com>
In-Reply-To: <CACGkMEv4CVK4YdOvHEbMY3dLc3cxF_tPN8H4YO=0rvFLaK-Upw@mail.gmail.com>
From: Jason Wang <jasowang@redhat.com>
Date: Wed, 17 Jul 2024 09:19:02 +0800
Message-ID: <CACGkMEvDiQHfLaBRoaFtpYJHKTqicqbrpeZWzat43YveTa9Wyg@mail.gmail.com>
Subject: Re: [PATCH net-next v3 3/3] virtio-net: synchronize operstate with
 admin state on up/down
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: xuanzhuo@linux.alibaba.com, eperezma@redhat.com, 
	virtualization@lists.linux.dev, linux-kernel@vger.kernel.org, 
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, 
	netdev@vger.kernel.org, Venkat Venkatsubra <venkat.x.venkatsubra@oracle.com>, 
	Gia-Khanh Nguyen <gia-khanh.nguyen@oracle.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 10, 2024 at 11:03=E2=80=AFAM Jason Wang <jasowang@redhat.com> w=
rote:
>
> On Tue, Jul 9, 2024 at 9:28=E2=80=AFPM Michael S. Tsirkin <mst@redhat.com=
> wrote:
> >
> > On Tue, Jul 09, 2024 at 04:02:14PM +0800, Jason Wang wrote:
> > > This patch synchronize operstate with admin state per RFC2863.
> > >
> > > This is done by trying to toggle the carrier upon open/close and
> > > synchronize with the config change work. This allows propagate status
> > > correctly to stacked devices like:
> > >
> > > ip link add link enp0s3 macvlan0 type macvlan
> > > ip link set link enp0s3 down
> > > ip link show
> > >
> > > Before this patch:
> > >
> > > 3: enp0s3: <BROADCAST,MULTICAST> mtu 1500 qdisc pfifo_fast state DOWN=
 mode DEFAULT group default qlen 1000
> > >     link/ether 00:00:05:00:00:09 brd ff:ff:ff:ff:ff:ff
> > > ......
> > > 5: macvlan0@enp0s3: <BROADCAST,MULTICAST,UP,LOWER_UP,M-DOWN> mtu 1500=
 qdisc noqueue state UP mode DEFAULT group default qlen 1000
> > >     link/ether b2:a9:c5:04:da:53 brd ff:ff:ff:ff:ff:ff
> > >
> > > After this patch:
> > >
> > > 3: enp0s3: <BROADCAST,MULTICAST> mtu 1500 qdisc pfifo_fast state DOWN=
 mode DEFAULT group default qlen 1000
> > >     link/ether 00:00:05:00:00:09 brd ff:ff:ff:ff:ff:ff
> > > ...
> > > 5: macvlan0@enp0s3: <NO-CARRIER,BROADCAST,MULTICAST,UP,M-DOWN> mtu 15=
00 qdisc noqueue state LOWERLAYERDOWN mode DEFAULT group default qlen 1000
> > >     link/ether b2:a9:c5:04:da:53 brd ff:ff:ff:ff:ff:ff
> >
> > I think that the commit log is confusing. It seems to say that
> > the issue fixed is synchronizing state with hardware
> > config change.
> > But your example does not show any
> > hardware change. Isn't this example really just
> > a side effect of setting carrier off on close?
>
> The main goal for this patch is to make virtio-net follow RFC2863. The
> main thing that is missed is to synchronize the operstate with admin
> state, if we do this, we get several good results, one of the obvious
> one is to allow virtio-net to propagate status to the upper layer, for
> example if the admin state of the lower virtio-net is down it should
> be propagated to the macvlan on top, so I give the example of using a
> stacked device. I'm not we had others but the commit log is probably
> too small to say all of it.

Michael, any more comments on this?

Thans

>
> >
> >
> > > Cc: Venkat Venkatsubra <venkat.x.venkatsubra@oracle.com>
> > > Cc: Gia-Khanh Nguyen <gia-khanh.nguyen@oracle.com>
> > > Signed-off-by: Jason Wang <jasowang@redhat.com>
> >
> > Yes but this just forces lots of re-reads of config on each
> > open/close for no good reason.
>
> Does it really harm? Technically the link status could be changed
> several times when the admin state is down as well.
>
> > Config interrupt is handled in core, you can read once
> > on probe and then handle config changes.
>
> Per RFC2863, the code tries to avoid dealing with any operstate change
> via config space read when the admin state is down.
>
> >
> >
> >
> >
> >
> > > ---
> > >  drivers/net/virtio_net.c | 64 ++++++++++++++++++++++++--------------=
--
> > >  1 file changed, 38 insertions(+), 26 deletions(-)
> > >
> > > diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> > > index 0b4747e81464..e6626ba25b29 100644
> > > --- a/drivers/net/virtio_net.c
> > > +++ b/drivers/net/virtio_net.c
> > > @@ -2476,6 +2476,25 @@ static void virtnet_cancel_dim(struct virtnet_=
info *vi, struct dim *dim)
> > >       net_dim_work_cancel(dim);
> > >  }
> > >
> > > +static void virtnet_update_settings(struct virtnet_info *vi)
> > > +{
> > > +     u32 speed;
> > > +     u8 duplex;
> > > +
> > > +     if (!virtio_has_feature(vi->vdev, VIRTIO_NET_F_SPEED_DUPLEX))
> > > +             return;
> > > +
> > > +     virtio_cread_le(vi->vdev, struct virtio_net_config, speed, &spe=
ed);
> > > +
> > > +     if (ethtool_validate_speed(speed))
> > > +             vi->speed =3D speed;
> > > +
> > > +     virtio_cread_le(vi->vdev, struct virtio_net_config, duplex, &du=
plex);
> > > +
> > > +     if (ethtool_validate_duplex(duplex))
> > > +             vi->duplex =3D duplex;
> > > +}
> > > +
> > >  static int virtnet_open(struct net_device *dev)
> > >  {
> > >       struct virtnet_info *vi =3D netdev_priv(dev);
> > > @@ -2494,6 +2513,18 @@ static int virtnet_open(struct net_device *dev=
)
> > >                       goto err_enable_qp;
> > >       }
> > >
> > > +     if (virtio_has_feature(vi->vdev, VIRTIO_NET_F_STATUS)) {
> > > +             virtio_config_driver_enable(vi->vdev);
> > > +             /* Do not schedule the config change work as the
> > > +              * config change notification might have been disabled
> > > +              * by the virtio core. */
> >
> > I don't get why you need this.
> > If the notification was disabled it will just trigger later.
> > This is exactly why using core is a good idea.
>
> So we need a read here (this seems to be not rare for most modern
> hardware NICs) because we don't know if the link status is changed or
> not and it is not guaranteed by virtio_config_driver_enable() since it
> only works when there's a pending config change. Another thing is that
> the device is being freezed, so the virtio core may prevent the device
> from accessing the device.
>
> So using virtio_config_changed() will guaranteed that:
>
> 1) if the device is not being freezed, it will read the config space soon
> 2) if the device is being freezed, the read of the config space will
> be delayed to resume
>
> >
> >
> > > +             virtio_config_changed(vi->vdev);
> > > +     } else {
> > > +             vi->status =3D VIRTIO_NET_S_LINK_UP;
> > > +             virtnet_update_settings(vi);
> >
> >
> > And why do we need this here I don't get at all.
>
> See above, because doing this on a probe is racy and buggy: The
> opersate is up even if the adminstate is not, this is conflict with
> RFC2863:
>
> "
> If ifAdminStatus is down(2) then ifOperStatus
>             should be down(2)
> "
>
> >
> > > +             netif_carrier_on(dev);
> > > +     }
> >
> >
> >
> > > +
> > >       return 0;
> > >
> > >  err_enable_qp:
> > > @@ -2936,12 +2967,19 @@ static int virtnet_close(struct net_device *d=
ev)
> > >       disable_delayed_refill(vi);
> > >       /* Make sure refill_work doesn't re-enable napi! */
> > >       cancel_delayed_work_sync(&vi->refill);
> > > +     /* Make sure config notification doesn't schedule config work *=
/
> > > +     virtio_config_driver_disable(vi->vdev);
> > > +     /* Make sure status updating is cancelled */
> > > +     cancel_work_sync(&vi->config_work);
> > >
> > >       for (i =3D 0; i < vi->max_queue_pairs; i++) {
> > >               virtnet_disable_queue_pair(vi, i);
> > >               virtnet_cancel_dim(vi, &vi->rq[i].dim);
> > >       }
> > >
> > > +     vi->status &=3D ~VIRTIO_NET_S_LINK_UP;
> > > +     netif_carrier_off(dev);
> > > +
> > >       return 0;
> > >  }
> > >
> > > @@ -4640,25 +4678,6 @@ static void virtnet_init_settings(struct net_d=
evice *dev)
> > >       vi->duplex =3D DUPLEX_UNKNOWN;
> > >  }
> > >
> > > -static void virtnet_update_settings(struct virtnet_info *vi)
> > > -{
> > > -     u32 speed;
> > > -     u8 duplex;
> > > -
> > > -     if (!virtio_has_feature(vi->vdev, VIRTIO_NET_F_SPEED_DUPLEX))
> > > -             return;
> > > -
> > > -     virtio_cread_le(vi->vdev, struct virtio_net_config, speed, &spe=
ed);
> > > -
> > > -     if (ethtool_validate_speed(speed))
> > > -             vi->speed =3D speed;
> > > -
> > > -     virtio_cread_le(vi->vdev, struct virtio_net_config, duplex, &du=
plex);
> > > -
> > > -     if (ethtool_validate_duplex(duplex))
> > > -             vi->duplex =3D duplex;
> > > -}
> > > -
> > >  static u32 virtnet_get_rxfh_key_size(struct net_device *dev)
> > >  {
> > >       return ((struct virtnet_info *)netdev_priv(dev))->rss_key_size;
> > > @@ -6000,13 +6019,6 @@ static int virtnet_probe(struct virtio_device =
*vdev)
> > >       /* Assume link up if device can't report link status,
> > >          otherwise get link status from config. */
> > >       netif_carrier_off(dev);
> > > -     if (virtio_has_feature(vi->vdev, VIRTIO_NET_F_STATUS)) {
> > > -             schedule_work(&vi->config_work);
> > > -     } else {
> > > -             vi->status =3D VIRTIO_NET_S_LINK_UP;
> > > -             virtnet_update_settings(vi);
> > > -             netif_carrier_on(dev);
> > > -     }
> >
> >
> > Here it all made sense - we were reading config for the 1st time.
>
> See above.
>
> Thanks
>
> >
> >
> > >       for (i =3D 0; i < ARRAY_SIZE(guest_offloads); i++)
> > >               if (virtio_has_feature(vi->vdev, guest_offloads[i]))
> > > --
> > > 2.31.1
> >
> >

