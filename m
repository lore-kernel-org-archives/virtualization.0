Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54B1D146A92
	for <virtualization@lists.linux.dev>; Tue, 25 Jun 2024 07:16:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719299786; cv=none; b=aIpc9+OKKeVFFkCYDZtU+Xnk2X0xDaN+5meOmrw64tCsMWTgtSS3efDdGY1fcGJGJ52T9RyJhblPD/AODd0/b2aKqhMgnPU3dINdVXshOH3RHJ1epO384PC2FKopnE+xOGi2+MImBlolaCwkJALUY9x5fNAVuCX0cmsn5NZYRx4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719299786; c=relaxed/simple;
	bh=xetssutV+uB/aGUYr84dRxPIMyGB/yv1uiSrE55emWY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=outftmhzDa8DRNRorY2NGHxMSQpNZ+bfjHc3pj0uupuzsL76bBKqGLqGDo7lDtDmkBzueOu0QXyUmJ4Nw748M4Er6N15GDdg1CGEr70i+f0h4y5ttGIQXPAdA/3cbHa2yy9JOGLzp8Rk+vKIQgMKrg4fPhpkGMWFcU0MBDYbQBM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=b1UgNRpy; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="b1UgNRpy"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1719299783;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=83RIYUqfgOwmfcWFt4IC4y0oJD58iblfvt+zaDSBWwE=;
	b=b1UgNRpyAgdC/eVY756DV1BOmExaM4igNpdcc1v5Gjhr972oCrxUSM+nnpEikrT+ShAFK4
	d9SCFACEf5y9fHuzG7RXYJ1SxKlf4CKCARFHJYSgV6PkAUIw2DTesheR2zZRclOeOgcQL3
	TEDG3qnzqaDpZZPHCpLEfNKudYkGkPw=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-679-wi4zsF3yOFiYE09et2MNxw-1; Tue, 25 Jun 2024 03:16:21 -0400
X-MC-Unique: wi4zsF3yOFiYE09et2MNxw-1
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-42196394b72so32261015e9.0
        for <virtualization@lists.linux.dev>; Tue, 25 Jun 2024 00:16:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719299780; x=1719904580;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=83RIYUqfgOwmfcWFt4IC4y0oJD58iblfvt+zaDSBWwE=;
        b=LYRd63L6v+fsJ84Jk7345cbN0K1vEXSvOsnOQ9MLL43ZSsxEcFQyaMX6EAYN4Hr8BH
         aO1+2I6qi6KYVJcwsXonvoyCDkWUsCd2FV2AcjprcIxhKWx2v/Ye62glw2Dk1B3Zu5R3
         TgeHUjM6/2PlLlaJiXjxQJxYMRBSKM1wIoriEIFx+Bn4UhfN2uIcLuOytwu7MyyIiyWe
         sg/rrmohftUCgQ6/QAJfNamU2BXwxiYfach53CP5uK2+RrSx2IncVbdQp7OokQ47QFQ3
         tMfjajMWQSM0hmM7uzyeqR55Vo2CGuZAsWG0EbRZetA+w5JB8FK6J1ZstsmUPEGHNWxa
         SKWg==
X-Forwarded-Encrypted: i=1; AJvYcCVhDPQtau/wgvUk+SBpDZV+i79ZaTXhppnfEdZKQMMBPTo8Akdm6TsT+4b2ofEQxwXsmQ8fOe+BTxhHtezcIrkDzHdx538HSsZSo4nYmVU=
X-Gm-Message-State: AOJu0Yw3uzXlubKMYsSNYioQ8W14/3kTW/NzB656Igt1pNuRAaeAdsj4
	e20RyiRtDM6jPD5N5JJBw5PPfdHtcvTv+6UlEDrizdT/HA3Tqv6ad9h433bDr8lxzntqarEkpRT
	jIxjZOAnG0EMa9IPtnkTRfw/YQgqxCuFzL6JzlTV24yaq6Xh36XUIA8I8CWm+LKFW9c1OH8Zf
X-Received: by 2002:a7b:ce16:0:b0:424:6c83:a78e with SMTP id 5b1f17b1804b1-4248cc67447mr42997905e9.40.1719299779701;
        Tue, 25 Jun 2024 00:16:19 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFH5r4+wWVEhT87Okk1mm91YxyY156l2jYoof2FlZWbV2LdiRQsg9jyTs260a1DZlEoGAbu9A==
X-Received: by 2002:a7b:ce16:0:b0:424:6c83:a78e with SMTP id 5b1f17b1804b1-4248cc67447mr42997595e9.40.1719299778914;
        Tue, 25 Jun 2024 00:16:18 -0700 (PDT)
Received: from redhat.com ([2a02:14f:1f6:f72:b8c7:9fc2:4c8b:feb3])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4247d0c547asm202886645e9.22.2024.06.25.00.16.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Jun 2024 00:16:18 -0700 (PDT)
Date: Tue, 25 Jun 2024 03:16:12 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jason Wang <jasowang@redhat.com>
Cc: xuanzhuo@linux.alibaba.com, eperezma@redhat.com, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	virtualization@lists.linux.dev, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, venkat.x.venkatsubra@oracle.com,
	gia-khanh.nguyen@oracle.com
Subject: Re: [PATCH V2 3/3] virtio-net: synchronize operstate with admin
 state on up/down
Message-ID: <20240625031455-mutt-send-email-mst@kernel.org>
References: <20240624024523.34272-1-jasowang@redhat.com>
 <20240624024523.34272-4-jasowang@redhat.com>
 <20240624060057-mutt-send-email-mst@kernel.org>
 <CACGkMEsysbded3xvU=qq6L_SmR0jmfvXdbthpZ0ERJoQhveZ3w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <CACGkMEsysbded3xvU=qq6L_SmR0jmfvXdbthpZ0ERJoQhveZ3w@mail.gmail.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

On Tue, Jun 25, 2024 at 09:27:38AM +0800, Jason Wang wrote:
> On Mon, Jun 24, 2024 at 6:07 PM Michael S. Tsirkin <mst@redhat.com> wrote:
> >
> > On Mon, Jun 24, 2024 at 10:45:23AM +0800, Jason Wang wrote:
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
> > > 3: enp0s3: <BROADCAST,MULTICAST> mtu 1500 qdisc pfifo_fast state DOWN mode DEFAULT group default qlen 1000
> > >     link/ether 00:00:05:00:00:09 brd ff:ff:ff:ff:ff:ff
> > > ......
> > > 5: macvlan0@enp0s3: <BROADCAST,MULTICAST,UP,LOWER_UP,M-DOWN> mtu 1500 qdisc noqueue state UP mode DEFAULT group default qlen 1000
> > >     link/ether b2:a9:c5:04:da:53 brd ff:ff:ff:ff:ff:ff
> > >
> > > After this patch:
> > >
> > > 3: enp0s3: <BROADCAST,MULTICAST> mtu 1500 qdisc pfifo_fast state DOWN mode DEFAULT group default qlen 1000
> > >     link/ether 00:00:05:00:00:09 brd ff:ff:ff:ff:ff:ff
> > > ...
> > > 5: macvlan0@enp0s3: <NO-CARRIER,BROADCAST,MULTICAST,UP,M-DOWN> mtu 1500 qdisc noqueue state LOWERLAYERDOWN mode DEFAULT group default qlen 1000
> > >     link/ether b2:a9:c5:04:da:53 brd ff:ff:ff:ff:ff:ff
> > >
> > > Cc: Venkat Venkatsubra <venkat.x.venkatsubra@oracle.com>
> > > Cc: Gia-Khanh Nguyen <gia-khanh.nguyen@oracle.com>
> > > Signed-off-by: Jason Wang <jasowang@redhat.com>
> > > ---
> > >  drivers/net/virtio_net.c | 72 +++++++++++++++++++++++-----------------
> > >  1 file changed, 42 insertions(+), 30 deletions(-)
> > >
> > > diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> > > index b1f8b720733e..eff3ad3d6bcc 100644
> > > --- a/drivers/net/virtio_net.c
> > > +++ b/drivers/net/virtio_net.c
> > > @@ -2468,6 +2468,25 @@ static int virtnet_enable_queue_pair(struct virtnet_info *vi, int qp_index)
> > >       return err;
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
> > > +     virtio_cread_le(vi->vdev, struct virtio_net_config, speed, &speed);
> > > +
> > > +     if (ethtool_validate_speed(speed))
> > > +             vi->speed = speed;
> > > +
> > > +     virtio_cread_le(vi->vdev, struct virtio_net_config, duplex, &duplex);
> > > +
> > > +     if (ethtool_validate_duplex(duplex))
> > > +             vi->duplex = duplex;
> > > +}
> > > +
> > >  static int virtnet_open(struct net_device *dev)
> > >  {
> > >       struct virtnet_info *vi = netdev_priv(dev);
> > > @@ -2486,6 +2505,22 @@ static int virtnet_open(struct net_device *dev)
> > >                       goto err_enable_qp;
> > >       }
> > >
> > > +     /* Assume link up if device can't report link status,
> > > +        otherwise get link status from config. */
> > > +     netif_carrier_off(dev);
> > > +     if (virtio_has_feature(vi->vdev, VIRTIO_NET_F_STATUS)) {
> > > +             virtio_config_enable(vi->vdev);
> > > +             /* We are not sure if config interrupt is disabled by
> > > +              * core or not, so we can't schedule config_work by
> > > +              * ourselves.
> > > +              */
> >
> > This comment confuses more than it explains.
> > You seem to be arguing about some alternative design
> > you had in mind, but readers don't have it in mind.
> >
> >
> > Please just explain what this does and why.
> > For what: something like "Trigger re-read of config - same
> > as we'd do if config changed".
> >
> > Now, please do what you don't do here: explain the why:
> >
> >
> > why do we want all these VM
> > exits on each open/close as opposed to once on probe and later on
> > config changed interrupt.
> 
> Fine, the main reason is that a config interrupt might be pending
> during ifdown and core may disable configure interrupt due to several
> reasons.
> 
> Thanks

If the config changes exactly as command is executing?
Then we'll get an interrupt later and update.
You can't always win this race, even if you read it can
change right after.


> 
> >
> >
> > > +             virtio_config_changed(vi->vdev);
> > > +     } else {
> > > +             vi->status = VIRTIO_NET_S_LINK_UP;
> > > +             virtnet_update_settings(vi);
> > > +             netif_carrier_on(dev);
> > > +     }
> > > +
> > >       return 0;
> > >
> > >  err_enable_qp:
> > > @@ -2928,12 +2963,19 @@ static int virtnet_close(struct net_device *dev)
> > >       disable_delayed_refill(vi);
> > >       /* Make sure refill_work doesn't re-enable napi! */
> > >       cancel_delayed_work_sync(&vi->refill);
> > > +     /* Make sure config notification doesn't schedule config work */
> > > +     virtio_config_disable(vi->vdev);
> > > +     /* Make sure status updating is cancelled */
> > > +     cancel_work_sync(&vi->config_work);
> > >
> > >       for (i = 0; i < vi->max_queue_pairs; i++) {
> > >               virtnet_disable_queue_pair(vi, i);
> > >               cancel_work_sync(&vi->rq[i].dim.work);
> > >       }
> > >
> > > +     vi->status &= ~VIRTIO_NET_S_LINK_UP;
> > > +     netif_carrier_off(dev);
> > > +
> > >       return 0;
> > >  }
> > >
> > > @@ -4632,25 +4674,6 @@ static void virtnet_init_settings(struct net_device *dev)
> > >       vi->duplex = DUPLEX_UNKNOWN;
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
> > > -     virtio_cread_le(vi->vdev, struct virtio_net_config, speed, &speed);
> > > -
> > > -     if (ethtool_validate_speed(speed))
> > > -             vi->speed = speed;
> > > -
> > > -     virtio_cread_le(vi->vdev, struct virtio_net_config, duplex, &duplex);
> > > -
> > > -     if (ethtool_validate_duplex(duplex))
> > > -             vi->duplex = duplex;
> > > -}
> > > -
> > >  static u32 virtnet_get_rxfh_key_size(struct net_device *dev)
> > >  {
> > >       return ((struct virtnet_info *)netdev_priv(dev))->rss_key_size;
> > > @@ -5958,17 +5981,6 @@ static int virtnet_probe(struct virtio_device *vdev)
> > >               goto free_unregister_netdev;
> > >       }
> > >
> > > -     /* Assume link up if device can't report link status,
> > > -        otherwise get link status from config. */
> > > -     netif_carrier_off(dev);
> > > -     if (virtio_has_feature(vi->vdev, VIRTIO_NET_F_STATUS)) {
> > > -             schedule_work(&vi->config_work);
> > > -     } else {
> > > -             vi->status = VIRTIO_NET_S_LINK_UP;
> > > -             virtnet_update_settings(vi);
> > > -             netif_carrier_on(dev);
> > > -     }
> > > -
> > >       for (i = 0; i < ARRAY_SIZE(guest_offloads); i++)
> > >               if (virtio_has_feature(vi->vdev, guest_offloads[i]))
> > >                       set_bit(guest_offloads[i], &vi->guest_offloads);
> > > --
> > > 2.31.1
> >

