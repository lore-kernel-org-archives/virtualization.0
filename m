Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 211B3C636CC
	for <virtualization@archiver.kernel.org>; Tue, 31 Jan 2023 14:41:10 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 886B74038D;
	Tue, 31 Jan 2023 14:41:10 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 886B74038D
Authentication-Results: smtp2.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=Ph01g9YX
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 59Uc1xnIt6dC; Tue, 31 Jan 2023 14:41:09 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 06539401B1;
	Tue, 31 Jan 2023 14:41:08 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 06539401B1
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id A067AC0032;
	Tue, 31 Jan 2023 14:41:08 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 91AC0C002B
 for <virtualization@lists.linux-foundation.org>;
 Tue, 31 Jan 2023 14:41:07 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 6AF3841703
 for <virtualization@lists.linux-foundation.org>;
 Tue, 31 Jan 2023 14:41:07 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 6AF3841703
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=Ph01g9YX
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id OCslkDxUN-0A
 for <virtualization@lists.linux-foundation.org>;
 Tue, 31 Jan 2023 14:41:05 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 2A47A416FC
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 2A47A416FC
 for <virtualization@lists.linux-foundation.org>;
 Tue, 31 Jan 2023 14:41:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1675176064;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Z9iK88+7O95uE6QeVxyAJA8KVjnGbjhJ4CYFVZ8tzRw=;
 b=Ph01g9YXjk9VBDYrOEduUVA7trSGyYeoaar/WpS3SFhkOzc+5ULj0amY+OpVkNsD73zUOF
 wYr6QV/Y/md5AgesIFKD48BRkAaLRw9CXmPiMvlIxlnnk5ORG5Gt3l2co8EOTzd191prtD
 Q9dVUfVPUhJiTOb2BdY0TzHo6XTV304=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-451-dCBZtLfiNAmJw0OF131WCQ-1; Tue, 31 Jan 2023 09:41:03 -0500
X-MC-Unique: dCBZtLfiNAmJw0OF131WCQ-1
Received: by mail-qv1-f69.google.com with SMTP id
 lw11-20020a05621457cb00b005376b828c22so8279028qvb.6
 for <virtualization@lists.linux-foundation.org>;
 Tue, 31 Jan 2023 06:41:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=mime-version:user-agent:content-transfer-encoding:references
 :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=kDZeka6s2FVzAq9jQS/8+R+TVdtKiTI6wM5H/QR27ws=;
 b=BPYm2xbScol+dE5mQBpRvQOnQQYpuaFIVIPUdpw0Rso6mE0J3FQx2rj/TkiE6G5YTl
 66i4voprGBNyBw0kytZVkLUJr5PYzzB/6j6hQIkBDr7W2NYQnTNzL6K2abC90g3jUhN6
 ATVIPafwjYFRxCaXYz9UUIiRJkOcQGzMs+glZ/+klnMRI7tKMsDzjBjgwE4t+UgeEpJj
 FcIpad1/qTlHAbs0Cx7axt02imdHu5fWVxk4sZpA7TowZSfvtnbvcfIm4JLmoyaBPv/9
 9bdDq/NR/Qn07kHSpIE9AmpPHBQgTQFaK4Yf9XoF+SkA7sxT8EkkWqoPv8+kRGh5dwfp
 Pb6Q==
X-Gm-Message-State: AFqh2kopV3IK7kIkd+L0t0w7RSvI4kuDpchTUEWM97GCzhSnb6tdkomu
 7yCCqrkq2rG54zO7/MEPKspmz6lJy9Rs1xZMUGz2xXpK1xJO3Xdrfk7hjS0vDQpp1KhIJIyyF8Q
 eOjcuxlXHDd551dVQIyJScczBMXrYnOWwXEQttv8tpA==
X-Received: by 2002:ac8:4519:0:b0:3b6:35cb:b944 with SMTP id
 q25-20020ac84519000000b003b635cbb944mr23843666qtn.2.1675176062584; 
 Tue, 31 Jan 2023 06:41:02 -0800 (PST)
X-Google-Smtp-Source: AMrXdXsLbf6GbwnxjCtGXO/npxRlAJRvvSIoFiQszhdhLaXnEkLpDqGgtp5TB3gnsbZNwt8XGUE+gg==
X-Received: by 2002:ac8:4519:0:b0:3b6:35cb:b944 with SMTP id
 q25-20020ac84519000000b003b635cbb944mr23843644qtn.2.1675176062323; 
 Tue, 31 Jan 2023 06:41:02 -0800 (PST)
Received: from gerbillo.redhat.com (146-241-113-28.dyn.eolo.it.
 [146.241.113.28]) by smtp.gmail.com with ESMTPSA id
 fb23-20020a05622a481700b003b62cd6e60esm9720172qtb.43.2023.01.31.06.41.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 31 Jan 2023 06:41:01 -0800 (PST)
Message-ID: <0743f81b0c84d7bbe3b727c746f4f4e856305d4e.camel@redhat.com>
Subject: Re: [PATCH v3 2/2] virtio_net: notify MAC address change on device
 initialization
From: Paolo Abeni <pabeni@redhat.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
Date: Tue, 31 Jan 2023 15:40:58 +0100
In-Reply-To: <20230131084213-mutt-send-email-mst@kernel.org>
References: <20230127204500.51930-1-lvivier@redhat.com>
 <20230127204500.51930-3-lvivier@redhat.com>
 <949500bd10077989eb21bd41d6bb1a0de296f9d8.camel@redhat.com>
 <20230131084213-mutt-send-email-mst@kernel.org>
User-Agent: Evolution 3.46.3 (3.46.3-1.fc37)
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: Laurent Vivier <lvivier@redhat.com>, Cindy Lu <lulu@redhat.com>,
 "David S. Miller" <davem@davemloft.net>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org,
 Eugenio =?ISO-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
 Gautam Dawar <gautam.dawar@xilinx.com>, Eli Cohen <elic@nvidia.com>
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

On Tue, 2023-01-31 at 08:43 -0500, Michael S. Tsirkin wrote:
> On Tue, Jan 31, 2023 at 10:01:53AM +0100, Paolo Abeni wrote:
> > On Fri, 2023-01-27 at 21:45 +0100, Laurent Vivier wrote:
> > > In virtnet_probe(), if the device doesn't provide a MAC address the
> > > driver assigns a random one.
> > > As we modify the MAC address we need to notify the device to allow it
> > > to update all the related information.
> > > 
> > > The problem can be seen with vDPA and mlx5_vdpa driver as it doesn't
> > > assign a MAC address by default. The virtio_net device uses a random
> > > MAC address (we can see it with "ip link"), but we can't ping a net
> > > namespace from another one using the virtio-vdpa device because the
> > > new MAC address has not been provided to the hardware:
> > > RX packets are dropped since they don't go through the receive filters,
> > > TX packets go through unaffected.
> > > 
> > > Signed-off-by: Laurent Vivier <lvivier@redhat.com>
> > > ---
> > >  drivers/net/virtio_net.c | 20 ++++++++++++++++++++
> > >  1 file changed, 20 insertions(+)
> > > 
> > > diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> > > index 7d700f8e545a..704a05f1c279 100644
> > > --- a/drivers/net/virtio_net.c
> > > +++ b/drivers/net/virtio_net.c
> > > @@ -3806,6 +3806,8 @@ static int virtnet_probe(struct virtio_device *vdev)
> > >  		eth_hw_addr_set(dev, addr);
> > >  	} else {
> > >  		eth_hw_addr_random(dev);
> > > +		dev_info(&vdev->dev, "Assigned random MAC address %pM\n",
> > > +			 dev->dev_addr);
> > >  	}
> > >  
> > >  	/* Set up our device-specific information */
> > > @@ -3933,6 +3935,24 @@ static int virtnet_probe(struct virtio_device *vdev)
> > >  
> > >  	virtio_device_ready(vdev);
> > >  
> > > +	/* a random MAC address has been assigned, notify the device.
> > > +	 * We don't fail probe if VIRTIO_NET_F_CTRL_MAC_ADDR is not there
> > > +	 * because many devices work fine without getting MAC explicitly
> > > +	 */
> > > +	if (!virtio_has_feature(vdev, VIRTIO_NET_F_MAC) &&
> > > +	    virtio_has_feature(vi->vdev, VIRTIO_NET_F_CTRL_MAC_ADDR)) {
> > > +		struct scatterlist sg;
> > > +
> > > +		sg_init_one(&sg, dev->dev_addr, dev->addr_len);
> > > +		if (!virtnet_send_command(vi, VIRTIO_NET_CTRL_MAC,
> > > +					  VIRTIO_NET_CTRL_MAC_ADDR_SET, &sg)) {
> > > +			pr_debug("virtio_net: setting MAC address failed\n");
> > > +			rtnl_unlock();
> > > +			err = -EINVAL;
> > > +			goto free_unregister_netdev;
> > 
> > Since the above is still dealing with device initialization, would it
> > make sense moving such init step before registering the netdevice? 
> > 
> > Cheers,
> > 
> > Paolo
> 
> We can't really, device has to be ready otherwise
> we can't send commands to it.

Thanks, I see. Also, Laurent already clarified the above.

Should I read your comment as you are ok with the patches in the
current form?

Cheers,

Paolo

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
