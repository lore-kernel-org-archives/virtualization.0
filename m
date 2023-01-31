Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 03D48C38142
	for <virtualization@archiver.kernel.org>; Tue, 31 Jan 2023 13:43:18 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 754C540297;
	Tue, 31 Jan 2023 13:43:18 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 754C540297
Authentication-Results: smtp2.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=SY/ds4ge
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id qPKr7BD-nrJA; Tue, 31 Jan 2023 13:43:17 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id E8F0540223;
	Tue, 31 Jan 2023 13:43:16 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org E8F0540223
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id B9E27C0033;
	Tue, 31 Jan 2023 13:43:16 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 18A03C002B
 for <virtualization@lists.linux-foundation.org>;
 Tue, 31 Jan 2023 13:43:15 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id E184C402E4
 for <virtualization@lists.linux-foundation.org>;
 Tue, 31 Jan 2023 13:43:14 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org E184C402E4
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 3TuXn6JdBTRM
 for <virtualization@lists.linux-foundation.org>;
 Tue, 31 Jan 2023 13:43:13 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 90F9D40223
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 90F9D40223
 for <virtualization@lists.linux-foundation.org>;
 Tue, 31 Jan 2023 13:43:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1675172592;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=FjK9CwJ0qU9dRcgLTPDubY9KveWkyLemzeLHtogsBVU=;
 b=SY/ds4gej2PC4logJqkoKKq4zA9cIUZajTYyMOmMB74eN/kFSJhZ2OgyncSs4UcEoS7ewN
 L/WhZhvpJw+8jZpC4GIhDnVn8CoMaMQr0Cd41nfRkJrAguyEa5EkvxIDKc8Pqnp6vwN4Qm
 1jp8G66XA2LAdzUkG40HT9WL7TBsbcI=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-185-RCl6KMJdPA2o7t388Fh9gQ-1; Tue, 31 Jan 2023 08:43:09 -0500
X-MC-Unique: RCl6KMJdPA2o7t388Fh9gQ-1
Received: by mail-wm1-f72.google.com with SMTP id
 bd21-20020a05600c1f1500b003dc5cb10dcfso2586720wmb.9
 for <virtualization@lists.linux-foundation.org>;
 Tue, 31 Jan 2023 05:43:09 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=FjK9CwJ0qU9dRcgLTPDubY9KveWkyLemzeLHtogsBVU=;
 b=g6NDyg0BOIZdmQ2h0a/6A4QPC62sh5a8FFt2mmR+O0vowq3IzQwb4Bx/yt62vhcL7y
 JI97jrLS4s0i8BSq4R8X3l4UQiIMqIgkuAkVyUvmfpVcR6U2KmleS6u7akOZ8nkzAJg0
 FiYQXm3BqZ0JknriajY01hVtz840FnuLTuTl6KlLGYmEJF55uy6diKdycsUZSPvmetnf
 de+4yW7nsqdla1eD5681udt8ejizaoOFk5SLXBGfXSDgPBm/A/rUilpOcVXUeuErChKm
 KkkyNXNwCCuw1xoxJKyuayDl8oV5adnUKFZrqhZlzV3g8c8WrkX6nLO9izmWRWj3bmi0
 REOg==
X-Gm-Message-State: AO0yUKUwx2zeHpMgEvLWSYveNsCyDE9THZbbtRNbg6WEP4N7KLp9E9xk
 txRo4QEWgplD3eUOKJTPtttO0pDILmZ8J8bp5xb0UQ+ue6z3ugorEgW7XkZp5zHc6YcR6PCKbwO
 j6IR3CVpuLuBkNqQNxYma+xECgqPC7P1TdYzReUTj0A==
X-Received: by 2002:a5d:6186:0:b0:2c1:28dc:1566 with SMTP id
 j6-20020a5d6186000000b002c128dc1566mr2925918wru.41.1675172588152; 
 Tue, 31 Jan 2023 05:43:08 -0800 (PST)
X-Google-Smtp-Source: AK7set+p39CqWABw+L+6uLvyXB/Xo6TtwQky3aHV0sHHTMfoOt2nrNUb+4VicVe08niov9+PPvP6YQ==
X-Received: by 2002:a5d:6186:0:b0:2c1:28dc:1566 with SMTP id
 j6-20020a5d6186000000b002c128dc1566mr2925898wru.41.1675172587836; 
 Tue, 31 Jan 2023 05:43:07 -0800 (PST)
Received: from redhat.com ([2.52.144.173]) by smtp.gmail.com with ESMTPSA id
 f6-20020a5d50c6000000b002bfc24e1c55sm14824129wrt.78.2023.01.31.05.43.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 31 Jan 2023 05:43:07 -0800 (PST)
Date: Tue, 31 Jan 2023 08:43:03 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Paolo Abeni <pabeni@redhat.com>
Subject: Re: [PATCH v3 2/2] virtio_net: notify MAC address change on device
 initialization
Message-ID: <20230131084213-mutt-send-email-mst@kernel.org>
References: <20230127204500.51930-1-lvivier@redhat.com>
 <20230127204500.51930-3-lvivier@redhat.com>
 <949500bd10077989eb21bd41d6bb1a0de296f9d8.camel@redhat.com>
MIME-Version: 1.0
In-Reply-To: <949500bd10077989eb21bd41d6bb1a0de296f9d8.camel@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: Laurent Vivier <lvivier@redhat.com>, Cindy Lu <lulu@redhat.com>,
 netdev@vger.kernel.org, Gautam Dawar <gautam.dawar@xilinx.com>,
 linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org,
 Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
 Eli Cohen <elic@nvidia.com>, "David S. Miller" <davem@davemloft.net>
X-BeenThere: virtualization@lists.linux-foundation.org
X-Mailman-Version: 2.1.15
Precedence: list
List-Id: Linux virtualization <virtualization.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>, 
 <mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>, 
 <mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

On Tue, Jan 31, 2023 at 10:01:53AM +0100, Paolo Abeni wrote:
> On Fri, 2023-01-27 at 21:45 +0100, Laurent Vivier wrote:
> > In virtnet_probe(), if the device doesn't provide a MAC address the
> > driver assigns a random one.
> > As we modify the MAC address we need to notify the device to allow it
> > to update all the related information.
> > 
> > The problem can be seen with vDPA and mlx5_vdpa driver as it doesn't
> > assign a MAC address by default. The virtio_net device uses a random
> > MAC address (we can see it with "ip link"), but we can't ping a net
> > namespace from another one using the virtio-vdpa device because the
> > new MAC address has not been provided to the hardware:
> > RX packets are dropped since they don't go through the receive filters,
> > TX packets go through unaffected.
> > 
> > Signed-off-by: Laurent Vivier <lvivier@redhat.com>
> > ---
> >  drivers/net/virtio_net.c | 20 ++++++++++++++++++++
> >  1 file changed, 20 insertions(+)
> > 
> > diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> > index 7d700f8e545a..704a05f1c279 100644
> > --- a/drivers/net/virtio_net.c
> > +++ b/drivers/net/virtio_net.c
> > @@ -3806,6 +3806,8 @@ static int virtnet_probe(struct virtio_device *vdev)
> >  		eth_hw_addr_set(dev, addr);
> >  	} else {
> >  		eth_hw_addr_random(dev);
> > +		dev_info(&vdev->dev, "Assigned random MAC address %pM\n",
> > +			 dev->dev_addr);
> >  	}
> >  
> >  	/* Set up our device-specific information */
> > @@ -3933,6 +3935,24 @@ static int virtnet_probe(struct virtio_device *vdev)
> >  
> >  	virtio_device_ready(vdev);
> >  
> > +	/* a random MAC address has been assigned, notify the device.
> > +	 * We don't fail probe if VIRTIO_NET_F_CTRL_MAC_ADDR is not there
> > +	 * because many devices work fine without getting MAC explicitly
> > +	 */
> > +	if (!virtio_has_feature(vdev, VIRTIO_NET_F_MAC) &&
> > +	    virtio_has_feature(vi->vdev, VIRTIO_NET_F_CTRL_MAC_ADDR)) {
> > +		struct scatterlist sg;
> > +
> > +		sg_init_one(&sg, dev->dev_addr, dev->addr_len);
> > +		if (!virtnet_send_command(vi, VIRTIO_NET_CTRL_MAC,
> > +					  VIRTIO_NET_CTRL_MAC_ADDR_SET, &sg)) {
> > +			pr_debug("virtio_net: setting MAC address failed\n");
> > +			rtnl_unlock();
> > +			err = -EINVAL;
> > +			goto free_unregister_netdev;
> 
> Since the above is still dealing with device initialization, would it
> make sense moving such init step before registering the netdevice? 
> 
> Cheers,
> 
> Paolo

We can't really, device has to be ready otherwise
we can't send commands to it.

-- 
MST

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
