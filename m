Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E28CFC38142
	for <virtualization@archiver.kernel.org>; Tue, 31 Jan 2023 11:41:13 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 4E24C8136F;
	Tue, 31 Jan 2023 11:41:13 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 4E24C8136F
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=VBiP0RFB
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id qwPFhRyDKRTe; Tue, 31 Jan 2023 11:41:12 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id CE5AB81337;
	Tue, 31 Jan 2023 11:41:11 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org CE5AB81337
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id A38C0C0033;
	Tue, 31 Jan 2023 11:41:11 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 89DF4C002B
 for <virtualization@lists.linux-foundation.org>;
 Tue, 31 Jan 2023 11:41:10 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 5D4BE8136F
 for <virtualization@lists.linux-foundation.org>;
 Tue, 31 Jan 2023 11:41:10 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 5D4BE8136F
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id qw_RizVqDM77
 for <virtualization@lists.linux-foundation.org>;
 Tue, 31 Jan 2023 11:41:09 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org E1BA281337
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id E1BA281337
 for <virtualization@lists.linux-foundation.org>;
 Tue, 31 Jan 2023 11:41:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1675165267;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=fAhGPz0l1YATjw4W3cNaX9n0xpYwF3Qyz9gqZuwYgPk=;
 b=VBiP0RFBfIEVsKSb84itZTtd/HePIj8JpGfGQYpaaBvxwPzy6HtVDL/PXwLVUlt/bkZOIf
 YbmCqddMzhkky9oLvLOy+oUz38Lg919+Qp+UDV6fGPGhcH7cEhVHCUx+1r4L4uoofmoUU9
 EBhsBX7lDQ6hpb527uA4zIr802VwXnc=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-621-Y5Gtv2uNMKukwxhAeACtAw-1; Tue, 31 Jan 2023 06:41:06 -0500
X-MC-Unique: Y5Gtv2uNMKukwxhAeACtAw-1
Received: by mail-qv1-f71.google.com with SMTP id
 ob12-20020a0562142f8c00b004c6c72bf1d0so8043223qvb.9
 for <virtualization@lists.linux-foundation.org>;
 Tue, 31 Jan 2023 03:41:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=mime-version:user-agent:content-transfer-encoding:references
 :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=t0pVvL03jcaCFyRgspQVvHakK5COVOMI25MafnyLE2I=;
 b=5J+CKSfYJ1AO8M20x+vPUhVT5QRmihnOmGqdrcG4+wETuxQuHeyH5/kKGBMV6mqFLr
 YhVqvA6YozNESRgBBXuwBQEPXJHu/5ftr1I3OpwPcDIxztL/lJfIXwCeWIrca9fGEpss
 NifMMRq59nrOyQmHXt3TYY6jy7UOhFTuCK9mjl0aUQVE89q46qTc1ohTdvyUUXBcs4bs
 98IpRc821VzNdb6Xhhw1faVIW9Kr18rPYgRvDfCy1KMc0mmbfei0askiKzQBvTaKohCb
 dWGS8p9aQqnC8IcugJAx2UD3Tgq4Gn0D0IN2jX76YY9ktHPtYsGONiiCFK2B5Up6KO+V
 /huw==
X-Gm-Message-State: AO0yUKUaRM2wjfPgoCX/WeNQ0TwVjuUcpue7MIsL51NEgoUVrTci/1AJ
 hRSdnZRY6W3tMhiEFz5IE6GfFQIENpEo940MYwh6gLv8e8k7+6LJkuSrwJKvtcze87LUDGZ/ydu
 1nHIQ8wwh6g2bkf/zng80wAolGV2S64iDoCCbOhUrfw==
X-Received: by 2002:a0c:9130:0:b0:53a:6000:e4ae with SMTP id
 q45-20020a0c9130000000b0053a6000e4aemr6168973qvq.4.1675165265541; 
 Tue, 31 Jan 2023 03:41:05 -0800 (PST)
X-Google-Smtp-Source: AK7set9f6OCpGakG2JgTMvzK1B61y13TQZr3Nc5Q8YgVjyNptfDGsEnb3nyJlrcbvN1U9e8uqZwy4Q==
X-Received: by 2002:a0c:9130:0:b0:53a:6000:e4ae with SMTP id
 q45-20020a0c9130000000b0053a6000e4aemr6168932qvq.4.1675165265060; 
 Tue, 31 Jan 2023 03:41:05 -0800 (PST)
Received: from gerbillo.redhat.com (146-241-113-28.dyn.eolo.it.
 [146.241.113.28]) by smtp.gmail.com with ESMTPSA id
 p74-20020a37424d000000b0071a5dbcafbfsm6948896qka.29.2023.01.31.03.41.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 31 Jan 2023 03:41:04 -0800 (PST)
Message-ID: <7c996ac279a6a2fa527906c3e91219ceb64e93fc.camel@redhat.com>
Subject: Re: [PATCH v3 2/2] virtio_net: notify MAC address change on device
 initialization
From: Paolo Abeni <pabeni@redhat.com>
To: Laurent Vivier <lvivier@redhat.com>, linux-kernel@vger.kernel.org
Date: Tue, 31 Jan 2023 12:41:00 +0100
In-Reply-To: <8bb17aed-d643-2e33-472a-9f237e26e4d1@redhat.com>
References: <20230127204500.51930-1-lvivier@redhat.com>
 <20230127204500.51930-3-lvivier@redhat.com>
 <949500bd10077989eb21bd41d6bb1a0de296f9d8.camel@redhat.com>
 <8bb17aed-d643-2e33-472a-9f237e26e4d1@redhat.com>
User-Agent: Evolution 3.46.3 (3.46.3-1.fc37)
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: Cindy Lu <lulu@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
 Eugenio =?ISO-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
 Eli Cohen <elic@nvidia.com>, virtualization@lists.linux-foundation.org,
 Gautam Dawar <gautam.dawar@xilinx.com>
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

On Tue, 2023-01-31 at 10:32 +0100, Laurent Vivier wrote:
> On 1/31/23 10:01, Paolo Abeni wrote:
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
> > >   drivers/net/virtio_net.c | 20 ++++++++++++++++++++
> > >   1 file changed, 20 insertions(+)
> > > 
> > > diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> > > index 7d700f8e545a..704a05f1c279 100644
> > > --- a/drivers/net/virtio_net.c
> > > +++ b/drivers/net/virtio_net.c
> > > @@ -3806,6 +3806,8 @@ static int virtnet_probe(struct virtio_device *vdev)
> > >   		eth_hw_addr_set(dev, addr);
> > >   	} else {
> > >   		eth_hw_addr_random(dev);
> > > +		dev_info(&vdev->dev, "Assigned random MAC address %pM\n",
> > > +			 dev->dev_addr);
> > >   	}
> > >   
> > >   	/* Set up our device-specific information */
> > > @@ -3933,6 +3935,24 @@ static int virtnet_probe(struct virtio_device *vdev)
> > >   
> > >   	virtio_device_ready(vdev);
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
> 
> It depends if we can send the command using the control command queue or not.
> I don't think we can use a vq before virtio_device_ready().

Sounds reasonable. @Michael: do you have any additional comments?

Thanks!

Paolo

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
