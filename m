Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AC4C16DC12
	for <virtualization@lists.linux.dev>; Thu,  1 Aug 2024 06:55:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722495337; cv=none; b=Fy2bOG1mqikGiqgHckT83BP8KBFgeSiRQWgfw3bC7qKaQHDtUzUsIvz/Js9AseDjn+gruV9BLOE8kVXL23FMvoSAd047SsJwZ531xRPKSLPLJtqCbjgxdmpdWfiazcn6fHvEIvTqEXuLLtMxMUFjOkRAuunpZ0fzZI951bAlT7A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722495337; c=relaxed/simple;
	bh=XmnboEv8s3bbCYuApa/z4HR+4kvHOYqJS2JQgb3lN7s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Amfx+hugnQeAcSbmEo1/wL4V+L4sNwWKNrGz2IGHlXFL7m+JUb3+z4Z7vQPRgcNi4URXa+j16aPA1UF527fcAH0qrFj6xYwh6fSaREwoqPoifWofjrS9hBxOvVG/zU2kGsS8lgkI8DcKi77bs97y+n9CxnNWiJ0gb2w4dO9GKF0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=EyF/xZ2O; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EyF/xZ2O"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1722495335;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=e/2BPCX2iEFS2x7x8P+6xvEQ8wkNWEdKFiA03A2xmsE=;
	b=EyF/xZ2OygKp/7iHrD/Jwm0UCHM2oguKpMwQ59NQ8DmyHhMARaMSD00+spIFImNrcd985p
	fuX8fh8dLQ/ZYntkbIa4cK68ARHKTgLOuFMAGzpijod8R1frvDOh9BDEIr+lNiglWAa2sw
	C6KQ0RWTFvL5ljzGawZd2p/BZT0lBY8=
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com
 [209.85.210.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-692-ynhq9wn5NdiSUnJMHFrvdQ-1; Thu, 01 Aug 2024 02:55:31 -0400
X-MC-Unique: ynhq9wn5NdiSUnJMHFrvdQ-1
Received: by mail-pf1-f200.google.com with SMTP id d2e1a72fcca58-70d14fc3317so5699336b3a.1
        for <virtualization@lists.linux.dev>; Wed, 31 Jul 2024 23:55:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722495331; x=1723100131;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=e/2BPCX2iEFS2x7x8P+6xvEQ8wkNWEdKFiA03A2xmsE=;
        b=Vr2m9R0cn7rTY9RIqqyekSVzKiXzyautVAyXBuUlFV5o2viYPwkbnbHGjRrO6z+cFw
         27ylkLu4GU/p4mH85F67oDtsjEclQ8NZbD9PIeQ6TURqNA2Y9O1RVmEkEfVNxfZaAgA8
         qbq7nFz0/g3LzILXTEl9gg5XMT1KwBIMJyvZ8nUec5aOj+vnbASoNECdVd5zRVMUiWdk
         efZPTPS+TpGIsl+9GwM+hNu++WwrVwRfG/2RtRrNCgejh4ULKPT5q75HG/CpdEIY4T+W
         VEGwrJyPM0IAUFO+hcPlC3GZpj+GXXGwMI7ihifEE5I8eGiXV0IPi/FQnIemGxjo+hHF
         zL2g==
X-Forwarded-Encrypted: i=1; AJvYcCXYE715JsZmm43gdtv5RRQriT4U11TZIK65/N4xD44Ga3w2dfqxiprLcRe00ZVjcKQcq/Z2WFUU8b6h9wA+Ojip9meVlDPkxv1X/K+KCbM=
X-Gm-Message-State: AOJu0Yw8095QXjgrKaIotPnV3tk/BuSNh43gi53xBsZGf2nPxtLx3P2U
	IW6sLIPXv/4ImS+cvipVi3E4DqA0WK2fJtVzhiEltPM0ckbfsg1v7u5NwqyS5Lx8X9nmo/HR49j
	8S8PlLYa1H5vPgKTzUROaYnyXvZyV2uURhWQLKaBJ6aK02wY+Np3BDbhUKzFz7jtKS+ZphXcW/u
	tKhf2RryLyiYPY/9I8YfrygZxo+1SuYhrbugED/MY=
X-Received: by 2002:a05:6a20:7f93:b0:1c4:8da5:5825 with SMTP id adf61e73a8af0-1c68cd00bf6mr2402460637.0.1722495330760;
        Wed, 31 Jul 2024 23:55:30 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHpCLihdYaTqSd19jfZQaY7T42e8Ti6xkXLOfjRWiTxpGzH3UkfsuJkq8k/QVINpbLTMq+Sq3QBs8L+YGgsG9I=
X-Received: by 2002:a05:6a20:7f93:b0:1c4:8da5:5825 with SMTP id
 adf61e73a8af0-1c68cd00bf6mr2402442637.0.1722495330165; Wed, 31 Jul 2024
 23:55:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20240731025947.23157-1-jasowang@redhat.com> <20240731025947.23157-4-jasowang@redhat.com>
 <20240801015914-mutt-send-email-mst@kernel.org> <CACGkMEs_0O3Bc_oe9XF9=qMRv7+a8wG3N9=EMA1nxpiDF56V2Q@mail.gmail.com>
 <20240801024202-mutt-send-email-mst@kernel.org>
In-Reply-To: <20240801024202-mutt-send-email-mst@kernel.org>
From: Jason Wang <jasowang@redhat.com>
Date: Thu, 1 Aug 2024 14:55:18 +0800
Message-ID: <CACGkMEvsx_6YNF0m0akVxk8LMVZztaGnbc-761CDKMZpxywR6g@mail.gmail.com>
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

On Thu, Aug 1, 2024 at 2:43=E2=80=AFPM Michael S. Tsirkin <mst@redhat.com> =
wrote:
>
> On Thu, Aug 01, 2024 at 02:13:49PM +0800, Jason Wang wrote:
> > On Thu, Aug 1, 2024 at 2:06=E2=80=AFPM Michael S. Tsirkin <mst@redhat.c=
om> wrote:
> > >
> > > On Wed, Jul 31, 2024 at 10:59:47AM +0800, Jason Wang wrote:
> > > > This patch synchronize operstate with admin state per RFC2863.
> > > >
> > > > This is done by trying to toggle the carrier upon open/close and
> > > > synchronize with the config change work. This allows propagate stat=
us
> > > > correctly to stacked devices like:
> > > >
> > > > ip link add link enp0s3 macvlan0 type macvlan
> > > > ip link set link enp0s3 down
> > > > ip link show
> > > >
> > > > Before this patch:
> > > >
> > > > 3: enp0s3: <BROADCAST,MULTICAST> mtu 1500 qdisc pfifo_fast state DO=
WN mode DEFAULT group default qlen 1000
> > > >     link/ether 00:00:05:00:00:09 brd ff:ff:ff:ff:ff:ff
> > > > ......
> > > > 5: macvlan0@enp0s3: <BROADCAST,MULTICAST,UP,LOWER_UP,M-DOWN> mtu 15=
00 qdisc noqueue state UP mode DEFAULT group default qlen 1000
> > > >     link/ether b2:a9:c5:04:da:53 brd ff:ff:ff:ff:ff:ff
> > > >
> > > > After this patch:
> > > >
> > > > 3: enp0s3: <BROADCAST,MULTICAST> mtu 1500 qdisc pfifo_fast state DO=
WN mode DEFAULT group default qlen 1000
> > > >     link/ether 00:00:05:00:00:09 brd ff:ff:ff:ff:ff:ff
> > > > ...
> > > > 5: macvlan0@enp0s3: <NO-CARRIER,BROADCAST,MULTICAST,UP,M-DOWN> mtu =
1500 qdisc noqueue state LOWERLAYERDOWN mode DEFAULT group default qlen 100=
0
> > > >     link/ether b2:a9:c5:04:da:53 brd ff:ff:ff:ff:ff:ff
> > > >
> > > > Cc: Venkat Venkatsubra <venkat.x.venkatsubra@oracle.com>
> > > > Cc: Gia-Khanh Nguyen <gia-khanh.nguyen@oracle.com>
> > > > Signed-off-by: Jason Wang <jasowang@redhat.com>
> > > > ---
> > > >  drivers/net/virtio_net.c | 84 ++++++++++++++++++++++++++----------=
----
> > > >  1 file changed, 54 insertions(+), 30 deletions(-)
> > > >
> > > > diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> > > > index 0383a3e136d6..0cb93261eba1 100644
> > > > --- a/drivers/net/virtio_net.c
> > > > +++ b/drivers/net/virtio_net.c
> > > > @@ -2878,6 +2878,7 @@ static int virtnet_enable_queue_pair(struct v=
irtnet_info *vi, int qp_index)
> > > >       return err;
> > > >  }
> > > >
> > > > +
> > > >  static void virtnet_cancel_dim(struct virtnet_info *vi, struct dim=
 *dim)
> > > >  {
> > > >       if (!virtio_has_feature(vi->vdev, VIRTIO_NET_F_VQ_NOTF_COAL))
> > > > @@ -2885,6 +2886,25 @@ static void virtnet_cancel_dim(struct virtne=
t_info *vi, struct dim *dim)
> > > >       net_dim_work_cancel(dim);
> > > >  }
> > > >
> > > > +static void virtnet_update_settings(struct virtnet_info *vi)
> > > > +{
> > > > +     u32 speed;
> > > > +     u8 duplex;
> > > > +
> > > > +     if (!virtio_has_feature(vi->vdev, VIRTIO_NET_F_SPEED_DUPLEX))
> > > > +             return;
> > > > +
> > > > +     virtio_cread_le(vi->vdev, struct virtio_net_config, speed, &s=
peed);
> > > > +
> > > > +     if (ethtool_validate_speed(speed))
> > > > +             vi->speed =3D speed;
> > > > +
> > > > +     virtio_cread_le(vi->vdev, struct virtio_net_config, duplex, &=
duplex);
> > > > +
> > > > +     if (ethtool_validate_duplex(duplex))
> > > > +             vi->duplex =3D duplex;
> > > > +}
> > > > +
> > > >  static int virtnet_open(struct net_device *dev)
> > > >  {
> > > >       struct virtnet_info *vi =3D netdev_priv(dev);
> > > > @@ -2903,6 +2923,16 @@ static int virtnet_open(struct net_device *d=
ev)
> > > >                       goto err_enable_qp;
> > > >       }
> > > >
> > > > +     if (virtio_has_feature(vi->vdev, VIRTIO_NET_F_STATUS)) {
> > > > +             if (vi->status & VIRTIO_NET_S_LINK_UP)
> > > > +                     netif_carrier_on(vi->dev);
> > > > +             virtio_config_driver_enable(vi->vdev);
> > > > +     } else {
> > > > +             vi->status =3D VIRTIO_NET_S_LINK_UP;
> > > > +             netif_carrier_on(dev);
> > > > +             virtnet_update_settings(vi);
> > > > +     }
> > > > +
> > > >       return 0;
> > > >
> > > >  err_enable_qp:
> > > > @@ -3381,12 +3411,18 @@ static int virtnet_close(struct net_device =
*dev)
> > > >       disable_delayed_refill(vi);
> > > >       /* Make sure refill_work doesn't re-enable napi! */
> > > >       cancel_delayed_work_sync(&vi->refill);
> > > > +     /* Make sure config notification doesn't schedule config work=
 */
> > > > +     virtio_config_driver_disable(vi->vdev);
> > > > +     /* Make sure status updating is cancelled */
> > > > +     cancel_work_sync(&vi->config_work);
> > > >
> > > >       for (i =3D 0; i < vi->max_queue_pairs; i++) {
> > > >               virtnet_disable_queue_pair(vi, i);
> > > >               virtnet_cancel_dim(vi, &vi->rq[i].dim);
> > > >       }
> > > >
> > > > +     netif_carrier_off(dev);
> > > > +
> > > >       return 0;
> > > >  }
> > > >
> > > > @@ -5085,25 +5121,6 @@ static void virtnet_init_settings(struct net=
_device *dev)
> > > >       vi->duplex =3D DUPLEX_UNKNOWN;
> > > >  }
> > > >
> > > > -static void virtnet_update_settings(struct virtnet_info *vi)
> > > > -{
> > > > -     u32 speed;
> > > > -     u8 duplex;
> > > > -
> > > > -     if (!virtio_has_feature(vi->vdev, VIRTIO_NET_F_SPEED_DUPLEX))
> > > > -             return;
> > > > -
> > > > -     virtio_cread_le(vi->vdev, struct virtio_net_config, speed, &s=
peed);
> > > > -
> > > > -     if (ethtool_validate_speed(speed))
> > > > -             vi->speed =3D speed;
> > > > -
> > > > -     virtio_cread_le(vi->vdev, struct virtio_net_config, duplex, &=
duplex);
> > > > -
> > > > -     if (ethtool_validate_duplex(duplex))
> > > > -             vi->duplex =3D duplex;
> > > > -}
> > > > -
> > > >  static u32 virtnet_get_rxfh_key_size(struct net_device *dev)
> > > >  {
> > > >       return ((struct virtnet_info *)netdev_priv(dev))->rss_key_siz=
e;
> > > > @@ -6514,6 +6531,11 @@ static int virtnet_probe(struct virtio_devic=
e *vdev)
> > > >               goto free_failover;
> > > >       }
> > > >
> > > > +     /* Forbid config change notification until ndo_open. */
> > > > +     virtio_config_driver_disable(vi->vdev);
> > > > +     /* Make sure status updating work is done */
> > >
> > > Wait a second, how can anything run here, this is probe,
> > > config change callbacks are never invoked at all.
> >
> > For buggy devices.
>
> buggy or not, virtio core will not invoke callbacks until
> after probe and scan.

I think you're right, but we still need the
virtio_config_driver_disable(). Otherwise the config change callback
might race with ndo_open().

>
> > >
> > > > +     cancel_work_sync(&vi->config_work);
> > > > +
> > >
> > >
> > > this is pointless, too.
> > >
> > > >       virtio_device_ready(vdev);
> > > >
> > > >       virtnet_set_queues(vi, vi->curr_queue_pairs);
> > > > @@ -6563,6 +6585,19 @@ static int virtnet_probe(struct virtio_devic=
e *vdev)
> > > >               vi->device_stats_cap =3D le64_to_cpu(v);
> > > >       }
> > > >
> > > > +     /* Assume link up if device can't report link status,
> > > > +           otherwise get link status from config. */
> > > > +        netif_carrier_off(dev);
> > > > +        if (virtio_has_feature(vi->vdev, VIRTIO_NET_F_STATUS)) {
> > > > +             /* This is safe as config notification change has bee=
n
> > > > +                disabled. */
> > >
> > > What "this"? pls explain what this does: get config data from
> > > device.
> > >
> > > Actually not because it was disabled. probe can poke at
> > > config with impunity no change callbacks trigger during probe.
> >
> > Only if we have a good device.
>
> not if you read the core code.

Right after the device is ready the config notification might be
triggered by the device, but the callback will be blocked by the core.

Thanks


>
> > >
> > > > +                virtnet_config_changed_work(&vi->config_work);
> > >
> > >
> > >
> >
> > Thanks
> >
> >
> > >
> > > > +        } else {
> > > > +                vi->status =3D VIRTIO_NET_S_LINK_UP;
> > > > +                virtnet_update_settings(vi);
> > > > +                netif_carrier_on(dev);
> > > > +        }
> > > > +
> > > >       rtnl_unlock();
> > > >
> > > >       err =3D virtnet_cpu_notif_add(vi);
> > > > @@ -6571,17 +6606,6 @@ static int virtnet_probe(struct virtio_devic=
e *vdev)
> > > >               goto free_unregister_netdev;
> > > >       }
> > > >
> > > > -     /* Assume link up if device can't report link status,
> > > > -        otherwise get link status from config. */
> > > > -     netif_carrier_off(dev);
> > > > -     if (virtio_has_feature(vi->vdev, VIRTIO_NET_F_STATUS)) {
> > > > -             schedule_work(&vi->config_work);
> > > > -     } else {
> > > > -             vi->status =3D VIRTIO_NET_S_LINK_UP;
> > > > -             virtnet_update_settings(vi);
> > > > -             netif_carrier_on(dev);
> > > > -     }
> > > > -
> > > >       for (i =3D 0; i < ARRAY_SIZE(guest_offloads); i++)
> > > >               if (virtio_has_feature(vi->vdev, guest_offloads[i]))
> > > >                       set_bit(guest_offloads[i], &vi->guest_offload=
s);
> > > > --
> > > > 2.31.1
> > >
>

