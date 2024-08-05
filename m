Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56B1213D50B
	for <virtualization@lists.linux.dev>; Mon,  5 Aug 2024 06:17:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722838631; cv=none; b=kZj/ZVZ01abZ48XtiPkBxsxSKAHj573XsQPUl6hLCXIakJnes69g1MQepdLFT/xZ8jxYCIgXHMHAlxsQbZpeLJF2d3I3nGFC9CnbbpiLaSTLSolL1vGEmXJWEfq5FtM1wphIl0BQTN4D+cOg+pCjGWfkxBNiGjb1VALMPzo6HP0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722838631; c=relaxed/simple;
	bh=Rit4jcoqnFILYWO8SBQsZCnBg4Ywfq3V1qADQrAkrwk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jyaxn7P0VMAJpZCBs2AogaCtBvedVr3YnlxS2u2sEUEa4cTNfbMOoCfH0UBZdFdaUD7ayhINrvEAEUh8lUwIe/Hr9MV87AqJUQFoCH35UabuebqzOx5NoEGJAG7tf1lzh5r3gurCNWZoqmoyZ32WEVkO0HLrcruSQ39MwOJTN2U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=PdbgnUMz; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PdbgnUMz"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1722838628;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zhPxt2+wzyEUDBe4s1sTOBs3jhz1NJVxgB47WCLuhIk=;
	b=PdbgnUMzJIMCBxbVo51QBwR3GTG0EZdByjEHvRsIIyMSSSsEcGvmayDls1B5h5PgSWWCBW
	aSWzzr5TnbGhscLLD33SGR+ExduS1lvjjhG2umM97v9zfsrLkY2Rohu+Lw64Q0wAL2ob20
	aBWVKSRghr4YB8PIT77LxewVqKLYktM=
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com
 [209.85.210.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-146-uW8vuq5oM-uFpMjOWZZByQ-1; Mon, 05 Aug 2024 02:17:04 -0400
X-MC-Unique: uW8vuq5oM-uFpMjOWZZByQ-1
Received: by mail-pf1-f198.google.com with SMTP id d2e1a72fcca58-7104f37771eso4910136b3a.2
        for <virtualization@lists.linux.dev>; Sun, 04 Aug 2024 23:17:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722838624; x=1723443424;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zhPxt2+wzyEUDBe4s1sTOBs3jhz1NJVxgB47WCLuhIk=;
        b=NNeGMaUKEkE+FAcOX2hF545OpEPw7nK1G4ea2qJ7RIQpHchSJY4UsoEoLkJGp85gSX
         KCtAaapfO1P2ND4TyYXlmShwfwKUsBTTaUwXIseWYiX2n2SxgIcM638UXDaLniMZuFBy
         xka8nQBcaPfr2vZPxVX7tUejc3WvpC9ju+yQajk+gVxEiwzIoknSzdM+VRhGmXhy8kEC
         rHr4ERC+4UQ5GtahwKeXUnA00dyW7Vz0qSnzcidmclEkUj1KVX9L2dSKnxuFrjaSgHF4
         0BuPppY6iID3Db3uzxneeqQ281QsQcYrth3Hu/yDk7xjNKrlafzw4BsFiaFaX2AsugSA
         5SEw==
X-Forwarded-Encrypted: i=1; AJvYcCUEg0cgDATarG/TawMWgoHw1WUMGTxw6BYtJgIJUvg05x3qO6w7aCBoHGoZIBUDEDOPnk2+fy+KxbQGZ3MeDHu8W/nY2a6tNVAmFDjq4DA=
X-Gm-Message-State: AOJu0YyBcPFnEYT0JDpfZ5YeBcv2sjBQ5tmwK2sWcXoPBwcqdRjy1nu4
	+cMLRSs05PyK/zyNB5q5RDWlkaPjDBBglXo05cpHpVtxcIV8+W6eStVll5A9pT4cffcShsxUwWx
	1RfRleQVE5pxPAWGyzaGYpdbqvoRYyby24mWLvLVH3K7V7HWIbLFvTxWr0Q4ViwMxab90gcefrw
	GfR+o1vd+eibHFpXR9wsJLS4itfZHIAVhqi+tkR/U=
X-Received: by 2002:a05:6a20:1596:b0:1c3:b2da:7e27 with SMTP id adf61e73a8af0-1c69953e15dmr11239118637.14.1722838623622;
        Sun, 04 Aug 2024 23:17:03 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGR/F9LA6B2u2qRpitMWhN7IesolWXzsgRINkyrLzhTDqlOy7Vw70opvzmfZVX6qh9u8Rz+KekB5aOKrQcfupM=
X-Received: by 2002:a05:6a20:1596:b0:1c3:b2da:7e27 with SMTP id
 adf61e73a8af0-1c69953e15dmr11239090637.14.1722838623012; Sun, 04 Aug 2024
 23:17:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20240805030242.62390-1-jasowang@redhat.com> <20240805030242.62390-4-jasowang@redhat.com>
 <20240805014422-mutt-send-email-mst@kernel.org>
In-Reply-To: <20240805014422-mutt-send-email-mst@kernel.org>
From: Jason Wang <jasowang@redhat.com>
Date: Mon, 5 Aug 2024 14:16:51 +0800
Message-ID: <CACGkMEsRaY282qQ98611PxYBdYSWkNeX9-qzY7r3ThsRnZVySw@mail.gmail.com>
Subject: Re: [PATCH V5 net-next 3/3] virtio-net: synchronize operstate with
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

On Mon, Aug 5, 2024 at 1:52=E2=80=AFPM Michael S. Tsirkin <mst@redhat.com> =
wrote:
>
> On Mon, Aug 05, 2024 at 11:02:42AM +0800, Jason Wang wrote:
> > This patch synchronize operstate with admin state per RFC2863.
>
>
> synchronizes
>
> >
> > This is done by trying to toggle the carrier upon open/close and
> > synchronize with the config change work. This allows propagate status
>
> to propagate

Will fix.

>
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
>
> Add an empty line here pls.
>
> > Cc: Venkat Venkatsubra <venkat.x.venkatsubra@oracle.com>
> > Cc: Gia-Khanh Nguyen <gia-khanh.nguyen@oracle.com>
> > Signed-off-by: Jason Wang <jasowang@redhat.com>
> > ---
> >  drivers/net/virtio_net.c | 78 +++++++++++++++++++++++++---------------
> >  1 file changed, 50 insertions(+), 28 deletions(-)
> >
> > diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> > index 0383a3e136d6..fc5196ca8d51 100644
> > --- a/drivers/net/virtio_net.c
> > +++ b/drivers/net/virtio_net.c
> > @@ -2885,6 +2885,25 @@ static void virtnet_cancel_dim(struct virtnet_in=
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
> > @@ -2903,6 +2922,15 @@ static int virtnet_open(struct net_device *dev)
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
> > +     }
> > +
> >       return 0;
> >
> >  err_enable_qp:
> > @@ -3381,12 +3409,22 @@ static int virtnet_close(struct net_device *dev=
)
> >       disable_delayed_refill(vi);
> >       /* Make sure refill_work doesn't re-enable napi! */
> >       cancel_delayed_work_sync(&vi->refill);
> > +     /* Prevent the config change callback from changing carrier
> > +      * after close
> > +      */
> > +     virtio_config_driver_disable(vi->vdev);
> > +     /* Stop getting status/speed updates: we don't care until next
> > +      * open
> > +      */
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
> > @@ -5085,25 +5123,6 @@ static void virtnet_init_settings(struct net_dev=
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
> > @@ -6514,6 +6533,9 @@ static int virtnet_probe(struct virtio_device *vd=
ev)
> >               goto free_failover;
> >       }
> >
> > +     /* Disable config change notification until ndo_open. */
> > +     virtio_config_driver_disable(vi->vdev);
> > +
> >       virtio_device_ready(vdev);
> >
> >       virtnet_set_queues(vi, vi->curr_queue_pairs);
> > @@ -6563,25 +6585,25 @@ static int virtnet_probe(struct virtio_device *=
vdev)
> >               vi->device_stats_cap =3D le64_to_cpu(v);
> >       }
> >
> > -     rtnl_unlock();
> > -
> > -     err =3D virtnet_cpu_notif_add(vi);
> > -     if (err) {
> > -             pr_debug("virtio_net: registering cpu notifier failed\n")=
;
> > -             goto free_unregister_netdev;
> > -     }
> > -
> >       /* Assume link up if device can't report link status,
> >          otherwise get link status from config. */
> >       netif_carrier_off(dev);
> >       if (virtio_has_feature(vi->vdev, VIRTIO_NET_F_STATUS)) {
> > -             schedule_work(&vi->config_work);
> > +             virtnet_config_changed_work(&vi->config_work);
> >       } else {
> >               vi->status =3D VIRTIO_NET_S_LINK_UP;
> >               virtnet_update_settings(vi);
> >               netif_carrier_on(dev);
> >       }
> >
> > +     rtnl_unlock();
>
>
> OK I guess you are moving rtnl to make sure this does not
> run in parallel with ndo_open/close.
> I do, however, wonder whether ndo_set_features
> can happen before guest_offloads_capable calculation below.
> WDYT?

I think it can and it needs another patch to fix (probably on top).

Thanks

>
> > +     err =3D virtnet_cpu_notif_add(vi);
> > +     if (err) {
> > +             pr_debug("virtio_net: registering cpu notifier failed\n")=
;
> > +             goto free_unregister_netdev;
> > +     }
> > +
> >       for (i =3D 0; i < ARRAY_SIZE(guest_offloads); i++)
> >               if (virtio_has_feature(vi->vdev, guest_offloads[i]))
> >                       set_bit(guest_offloads[i], &vi->guest_offloads);
> > --
> > 2.31.1
>

