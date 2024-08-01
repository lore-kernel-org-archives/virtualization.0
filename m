Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77FF91A0B08
	for <virtualization@lists.linux.dev>; Thu,  1 Aug 2024 06:14:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722492846; cv=none; b=qIjbyxCyxAA4UbayfP0nNlghI6+lSix82fFd5pJ/YS2Z3RkJ1zAkw0YP5PkFaH20qFio/GWlLsQ+sU37x6a4Bm2wQJYGEmtroG4Qem+b7p/b23PqC4Y6jXwZGmUQXgQeH0//X1/brV68y8JlV3EGr7cagk/+Bm2fgsV/xmGZmJ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722492846; c=relaxed/simple;
	bh=e493XAaZl34qArOahl8IyEm6SZv4XXdc6FYHsEhyAEk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MBL4cjAMjefvz7n/V3hbh7sRXYzRjwma4gOnZLQET6hZh2XGi1aG78park5HdIEUreA2l6goIZzTzbHQe9WwKKOPBZguq6F/ABfEmEO81Z4HMlatIk0Py8J94IlexoghgtalYZfiMMTpukfy3sDEcqFAolG4QME8v5M4Ckk3Rv0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Iv16VSTO; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Iv16VSTO"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1722492843;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Abz/kpzsZo0Wgm68WD23BeZwIb/oeuESPA2aYsBBRDQ=;
	b=Iv16VSTO46izFMcRvifKFlriSseqDgAWMXeguhRpDoKlCFzYLbxXhb84E0Cr759AB9aYHx
	NOvefo3c2Bc7VkibzVpcuSjS9u1he8olfgq7j80gYIE2rREqx/JuC+VhuXJV0YOsD793HB
	j0pfWkRqxU7kHgDzW2ow17dCbuNBBdc=
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-593-HTRiwI26PZOhWeyIMSH5bQ-1; Thu, 01 Aug 2024 02:14:02 -0400
X-MC-Unique: HTRiwI26PZOhWeyIMSH5bQ-1
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-2cb81c562edso6462022a91.2
        for <virtualization@lists.linux.dev>; Wed, 31 Jul 2024 23:14:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722492841; x=1723097641;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Abz/kpzsZo0Wgm68WD23BeZwIb/oeuESPA2aYsBBRDQ=;
        b=VAqQD4fzdZahbjoN7jU6Vk0ybpvNOIbAgjZH14T9aIspqcFNmfWY9iQFQGbXvZiyCo
         tTfQkyjmOnmSGv+YpyEx011XfUspLZK9k0G+mekCUXY9RqEgz/3bj2g52Da7EaI9Dswv
         WDrVS3tzDedmVRfGXv1+PvQ5U3VWsoyDxjEdCN6v5MHoc3zjJ8g0DLm5Vv/MtCDLkLgs
         eVTB2iPmXrcr96+KVPTRawy4trWQiNRW57cyx4dNGdgCsMSbc/x6o0tUXRnmXfNfYwfs
         dGpoooq4d5NRPeKwHp0Wv9X6cz+rZaATm7zgnXkZW+8ZDJWDQ6uu7xlw7Of5hAKhGmS2
         0NrQ==
X-Forwarded-Encrypted: i=1; AJvYcCUWnTlbvqy7SIYGqbjPgqEcWp0zTaW87wXdnTMR5tWMvzh4r+0n1R/Odf32VJQ06bGk+33jE0ptMsct1EQWV1+T93gseovSHJMXZqHS+Y8=
X-Gm-Message-State: AOJu0YxuFYgCZXUz8vUhh8v+D0MjS8rtRcpWlfDmA7CMPac145CfSMo8
	yMqsDunZ3fRhzjQA2HzrD6ftMpKa4DfnshJ2Mg2ZIrGDR6pTaDk52vl2Jc+Yksg9OEZxTe7oG+D
	EzXMsgn2+17eRv3DW/TG73JslpZ4sZPXszoS46JxSbW3MJzYL/uyqya/na7m9+dQVYKkjLy4IL4
	z7Sisws3iGVFw9W0/MtFpcUUSsouKWZrC/z/X5Y+I=
X-Received: by 2002:a17:90b:3b44:b0:2cb:4c25:f941 with SMTP id 98e67ed59e1d1-2cfe787167cmr1924340a91.17.1722492841236;
        Wed, 31 Jul 2024 23:14:01 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHMtV/LjANvLKAm+QyiMXr3Ura7T31A2ScQoc/TJ8zQx32VcD0yRPPbJevex1nxqVyg5izOtYk+OGLQDynH2os=
X-Received: by 2002:a17:90b:3b44:b0:2cb:4c25:f941 with SMTP id
 98e67ed59e1d1-2cfe787167cmr1924314a91.17.1722492840719; Wed, 31 Jul 2024
 23:14:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20240731025947.23157-1-jasowang@redhat.com> <20240731025947.23157-4-jasowang@redhat.com>
 <20240801015914-mutt-send-email-mst@kernel.org>
In-Reply-To: <20240801015914-mutt-send-email-mst@kernel.org>
From: Jason Wang <jasowang@redhat.com>
Date: Thu, 1 Aug 2024 14:13:49 +0800
Message-ID: <CACGkMEs_0O3Bc_oe9XF9=qMRv7+a8wG3N9=EMA1nxpiDF56V2Q@mail.gmail.com>
Subject: Re: [PATCH V4 net-next 3/3] virtio-net: synchronize operstate with
 admin state on up/down
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: xuanzhuo@linux.alibaba.com, eperezma@redhat.com, davem@davemloft.net, 
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, 
	virtualization@lists.linux.dev, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, 
	Venkat Venkatsubra <venkat.x.venkatsubra@oracle.com>, 
	Gia-Khanh Nguyen <gia-khanh.nguyen@oracle.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 1, 2024 at 2:06=E2=80=AFPM Michael S. Tsirkin <mst@redhat.com> =
wrote:
>
> On Wed, Jul 31, 2024 at 10:59:47AM +0800, Jason Wang wrote:
> > This patch synchronize operstate with admin state per RFC2863.
> >
> > This is done by trying to toggle the carrier upon open/close and
> > synchronize with the config change work. This allows propagate status
> > correctly to stacked devices like:
> >
> > ip link add link enp0s3 macvlan0 type macvlan
> > ip link set link enp0s3 down
> > ip link show
> >
> > Before this patch:
> >
> > 3: enp0s3: <BROADCAST,MULTICAST> mtu 1500 qdisc pfifo_fast state DOWN m=
ode DEFAULT group default qlen 1000
> >     link/ether 00:00:05:00:00:09 brd ff:ff:ff:ff:ff:ff
> > ......
> > 5: macvlan0@enp0s3: <BROADCAST,MULTICAST,UP,LOWER_UP,M-DOWN> mtu 1500 q=
disc noqueue state UP mode DEFAULT group default qlen 1000
> >     link/ether b2:a9:c5:04:da:53 brd ff:ff:ff:ff:ff:ff
> >
> > After this patch:
> >
> > 3: enp0s3: <BROADCAST,MULTICAST> mtu 1500 qdisc pfifo_fast state DOWN m=
ode DEFAULT group default qlen 1000
> >     link/ether 00:00:05:00:00:09 brd ff:ff:ff:ff:ff:ff
> > ...
> > 5: macvlan0@enp0s3: <NO-CARRIER,BROADCAST,MULTICAST,UP,M-DOWN> mtu 1500=
 qdisc noqueue state LOWERLAYERDOWN mode DEFAULT group default qlen 1000
> >     link/ether b2:a9:c5:04:da:53 brd ff:ff:ff:ff:ff:ff
> >
> > Cc: Venkat Venkatsubra <venkat.x.venkatsubra@oracle.com>
> > Cc: Gia-Khanh Nguyen <gia-khanh.nguyen@oracle.com>
> > Signed-off-by: Jason Wang <jasowang@redhat.com>
> > ---
> >  drivers/net/virtio_net.c | 84 ++++++++++++++++++++++++++--------------
> >  1 file changed, 54 insertions(+), 30 deletions(-)
> >
> > diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> > index 0383a3e136d6..0cb93261eba1 100644
> > --- a/drivers/net/virtio_net.c
> > +++ b/drivers/net/virtio_net.c
> > @@ -2878,6 +2878,7 @@ static int virtnet_enable_queue_pair(struct virtn=
et_info *vi, int qp_index)
> >       return err;
> >  }
> >
> > +
> >  static void virtnet_cancel_dim(struct virtnet_info *vi, struct dim *di=
m)
> >  {
> >       if (!virtio_has_feature(vi->vdev, VIRTIO_NET_F_VQ_NOTF_COAL))
> > @@ -2885,6 +2886,25 @@ static void virtnet_cancel_dim(struct virtnet_in=
fo *vi, struct dim *dim)
> >       net_dim_work_cancel(dim);
> >  }
> >
> > +static void virtnet_update_settings(struct virtnet_info *vi)
> > +{
> > +     u32 speed;
> > +     u8 duplex;
> > +
> > +     if (!virtio_has_feature(vi->vdev, VIRTIO_NET_F_SPEED_DUPLEX))
> > +             return;
> > +
> > +     virtio_cread_le(vi->vdev, struct virtio_net_config, speed, &speed=
);
> > +
> > +     if (ethtool_validate_speed(speed))
> > +             vi->speed =3D speed;
> > +
> > +     virtio_cread_le(vi->vdev, struct virtio_net_config, duplex, &dupl=
ex);
> > +
> > +     if (ethtool_validate_duplex(duplex))
> > +             vi->duplex =3D duplex;
> > +}
> > +
> >  static int virtnet_open(struct net_device *dev)
> >  {
> >       struct virtnet_info *vi =3D netdev_priv(dev);
> > @@ -2903,6 +2923,16 @@ static int virtnet_open(struct net_device *dev)
> >                       goto err_enable_qp;
> >       }
> >
> > +     if (virtio_has_feature(vi->vdev, VIRTIO_NET_F_STATUS)) {
> > +             if (vi->status & VIRTIO_NET_S_LINK_UP)
> > +                     netif_carrier_on(vi->dev);
> > +             virtio_config_driver_enable(vi->vdev);
> > +     } else {
> > +             vi->status =3D VIRTIO_NET_S_LINK_UP;
> > +             netif_carrier_on(dev);
> > +             virtnet_update_settings(vi);
> > +     }
> > +
> >       return 0;
> >
> >  err_enable_qp:
> > @@ -3381,12 +3411,18 @@ static int virtnet_close(struct net_device *dev=
)
> >       disable_delayed_refill(vi);
> >       /* Make sure refill_work doesn't re-enable napi! */
> >       cancel_delayed_work_sync(&vi->refill);
> > +     /* Make sure config notification doesn't schedule config work */
> > +     virtio_config_driver_disable(vi->vdev);
> > +     /* Make sure status updating is cancelled */
> > +     cancel_work_sync(&vi->config_work);
> >
> >       for (i =3D 0; i < vi->max_queue_pairs; i++) {
> >               virtnet_disable_queue_pair(vi, i);
> >               virtnet_cancel_dim(vi, &vi->rq[i].dim);
> >       }
> >
> > +     netif_carrier_off(dev);
> > +
> >       return 0;
> >  }
> >
> > @@ -5085,25 +5121,6 @@ static void virtnet_init_settings(struct net_dev=
ice *dev)
> >       vi->duplex =3D DUPLEX_UNKNOWN;
> >  }
> >
> > -static void virtnet_update_settings(struct virtnet_info *vi)
> > -{
> > -     u32 speed;
> > -     u8 duplex;
> > -
> > -     if (!virtio_has_feature(vi->vdev, VIRTIO_NET_F_SPEED_DUPLEX))
> > -             return;
> > -
> > -     virtio_cread_le(vi->vdev, struct virtio_net_config, speed, &speed=
);
> > -
> > -     if (ethtool_validate_speed(speed))
> > -             vi->speed =3D speed;
> > -
> > -     virtio_cread_le(vi->vdev, struct virtio_net_config, duplex, &dupl=
ex);
> > -
> > -     if (ethtool_validate_duplex(duplex))
> > -             vi->duplex =3D duplex;
> > -}
> > -
> >  static u32 virtnet_get_rxfh_key_size(struct net_device *dev)
> >  {
> >       return ((struct virtnet_info *)netdev_priv(dev))->rss_key_size;
> > @@ -6514,6 +6531,11 @@ static int virtnet_probe(struct virtio_device *v=
dev)
> >               goto free_failover;
> >       }
> >
> > +     /* Forbid config change notification until ndo_open. */
> > +     virtio_config_driver_disable(vi->vdev);
> > +     /* Make sure status updating work is done */
>
> Wait a second, how can anything run here, this is probe,
> config change callbacks are never invoked at all.

For buggy devices.

>
> > +     cancel_work_sync(&vi->config_work);
> > +
>
>
> this is pointless, too.
>
> >       virtio_device_ready(vdev);
> >
> >       virtnet_set_queues(vi, vi->curr_queue_pairs);
> > @@ -6563,6 +6585,19 @@ static int virtnet_probe(struct virtio_device *v=
dev)
> >               vi->device_stats_cap =3D le64_to_cpu(v);
> >       }
> >
> > +     /* Assume link up if device can't report link status,
> > +           otherwise get link status from config. */
> > +        netif_carrier_off(dev);
> > +        if (virtio_has_feature(vi->vdev, VIRTIO_NET_F_STATUS)) {
> > +             /* This is safe as config notification change has been
> > +                disabled. */
>
> What "this"? pls explain what this does: get config data from
> device.
>
> Actually not because it was disabled. probe can poke at
> config with impunity no change callbacks trigger during probe.

Only if we have a good device.

>
> > +                virtnet_config_changed_work(&vi->config_work);
>
>
>

Thanks


>
> > +        } else {
> > +                vi->status =3D VIRTIO_NET_S_LINK_UP;
> > +                virtnet_update_settings(vi);
> > +                netif_carrier_on(dev);
> > +        }
> > +
> >       rtnl_unlock();
> >
> >       err =3D virtnet_cpu_notif_add(vi);
> > @@ -6571,17 +6606,6 @@ static int virtnet_probe(struct virtio_device *v=
dev)
> >               goto free_unregister_netdev;
> >       }
> >
> > -     /* Assume link up if device can't report link status,
> > -        otherwise get link status from config. */
> > -     netif_carrier_off(dev);
> > -     if (virtio_has_feature(vi->vdev, VIRTIO_NET_F_STATUS)) {
> > -             schedule_work(&vi->config_work);
> > -     } else {
> > -             vi->status =3D VIRTIO_NET_S_LINK_UP;
> > -             virtnet_update_settings(vi);
> > -             netif_carrier_on(dev);
> > -     }
> > -
> >       for (i =3D 0; i < ARRAY_SIZE(guest_offloads); i++)
> >               if (virtio_has_feature(vi->vdev, guest_offloads[i]))
> >                       set_bit(guest_offloads[i], &vi->guest_offloads);
> > --
> > 2.31.1
>

