Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8FF05C54EAA
	for <virtualization@archiver.kernel.org>; Fri, 27 Jan 2023 11:08:15 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 3134B417C2;
	Fri, 27 Jan 2023 11:08:15 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 3134B417C2
Authentication-Results: smtp2.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=Z/afB6xn
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id fE1Z3gikDWNt; Fri, 27 Jan 2023 11:08:13 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 1A6BF400E7;
	Fri, 27 Jan 2023 11:08:13 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 1A6BF400E7
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id E6009C0032;
	Fri, 27 Jan 2023 11:08:12 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id AB5FAC002D
 for <virtualization@lists.linux-foundation.org>;
 Fri, 27 Jan 2023 11:08:11 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 78811827CE
 for <virtualization@lists.linux-foundation.org>;
 Fri, 27 Jan 2023 11:08:11 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 78811827CE
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=Z/afB6xn
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id zhwlZ7tJp-ON
 for <virtualization@lists.linux-foundation.org>;
 Fri, 27 Jan 2023 11:08:10 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 875908270B
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 875908270B
 for <virtualization@lists.linux-foundation.org>;
 Fri, 27 Jan 2023 11:08:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1674817689;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=CKPEQeD05U6KFCAYtgfxbXNA3n/pe6PkgZWvP+2Uf2k=;
 b=Z/afB6xntG4PsNmG+MnNr7ri2/UqOheTxJ9MHkpQ36VKlYSbb1Cc6rAxM7ziuhxOAf+ZvS
 FhiAaMeRoRR8/k4YBR8xtwKNMXnbPy1Xk445k4jrPbMCRYH0IpaPT1AUW/5E8JdWbuFYsw
 ikrzZrufRaKR3tF/sOsCs0xREMVSUA8=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-553-FPOevN1qPNunh1FaDlfwBg-1; Fri, 27 Jan 2023 06:08:07 -0500
X-MC-Unique: FPOevN1qPNunh1FaDlfwBg-1
Received: by mail-ej1-f72.google.com with SMTP id
 gn31-20020a1709070d1f00b0087024adbba2so3247191ejc.20
 for <virtualization@lists.linux-foundation.org>;
 Fri, 27 Jan 2023 03:08:07 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=CKPEQeD05U6KFCAYtgfxbXNA3n/pe6PkgZWvP+2Uf2k=;
 b=YV+95oCaEUOLkIPyZFKqH4xCPiPW7/nSwRlpMDljSOx0qCoFKdPeN5kMwl8LFpZsy9
 cBnSbhhK7XWurAPHQV7UU1kUPNAy1mkcrhj70u4zsCjAiPMRccZEms+7UDLVs09PQPg2
 Qjyozw60W3kl0PCwNmfG4tih+pEMtsWTvjoIGXylxtsk6k0docEZC8qkJIc8Nt5PiboI
 Yitf6UaNpWue9mnDZg3Tfqar4iF+fka8Rouc6VSEKha4wyjYx4fSVwmyafg02mnq7qS3
 vM87f07Cuo9o1nyVa0NqsLjw2swd4l0XFEGVWevWibWnHfpogeAMx0oDHVaSuWXumfdG
 ThHg==
X-Gm-Message-State: AFqh2kojYM/XL3sV8XzbFmUUR0GBT8Gz+4f20NIK5Ay2gZmfeOcKmUnD
 q65EvLe/NGxe8TG0Uj+Vyf026gyaUXkm1d9M0mN0/PPvsVFxxTlr527GZY7MLmAyT7dG0Lpvkor
 GjyyxMCVdQ+oyNTkkHMhkGbIdR5bGYg3fDrMAsxvxTg==
X-Received: by 2002:a17:907:8a07:b0:7c1:5ee1:4c57 with SMTP id
 sc7-20020a1709078a0700b007c15ee14c57mr48312981ejc.8.1674817686729; 
 Fri, 27 Jan 2023 03:08:06 -0800 (PST)
X-Google-Smtp-Source: AMrXdXtEZ9qSwCeJX4118ylH95WPKVKjIFX0j4DWxndoYOi4bwRVWxwjupfV2ZGS4Sf/mhJEOQy+Mg==
X-Received: by 2002:a17:907:8a07:b0:7c1:5ee1:4c57 with SMTP id
 sc7-20020a1709078a0700b007c15ee14c57mr48312963ejc.8.1674817686493; 
 Fri, 27 Jan 2023 03:08:06 -0800 (PST)
Received: from redhat.com ([2.52.137.69]) by smtp.gmail.com with ESMTPSA id
 m5-20020aa7c485000000b0049e19136c22sm2120592edq.95.2023.01.27.03.08.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 27 Jan 2023 03:08:05 -0800 (PST)
Date: Fri, 27 Jan 2023 06:08:01 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Laurent Vivier <lvivier@redhat.com>
Subject: Re: [PATCH v2 1/1] virtio_net: notify MAC address change on device
 initialization
Message-ID: <20230127060453-mutt-send-email-mst@kernel.org>
References: <20230123120022.2364889-1-lvivier@redhat.com>
 <20230123120022.2364889-2-lvivier@redhat.com>
 <20230124024711-mutt-send-email-mst@kernel.org>
 <971beeaf-5e68-eb4a-1ceb-63a5ffa74aff@redhat.com>
MIME-Version: 1.0
In-Reply-To: <971beeaf-5e68-eb4a-1ceb-63a5ffa74aff@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: Cindy Lu <lulu@redhat.com>, "David S. Miller" <davem@davemloft.net>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 virtualization@lists.linux-foundation.org,
 Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
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

On Tue, Jan 24, 2023 at 12:04:24PM +0100, Laurent Vivier wrote:
> On 1/24/23 11:15, Michael S. Tsirkin wrote:
> > On Mon, Jan 23, 2023 at 01:00:22PM +0100, Laurent Vivier wrote:
> > > In virtnet_probe(), if the device doesn't provide a MAC address the
> > > driver assigns a random one.
> > > As we modify the MAC address we need to notify the device to allow it
> > > to update all the related information.
> > > 
> > > The problem can be seen with vDPA and mlx5_vdpa driver as it doesn't
> > > assign a MAC address by default. The virtio_net device uses a random
> > > MAC address (we can see it with "ip link"), but we can't ping a net
> > > namespace from another one using the virtio-vdpa device because the
> > > new MAC address has not been provided to the hardware.
> > 
> > And then what exactly happens? Does hardware drop the outgoing
> > or the incoming packets? Pls include in the commit log.
> 
> I don't know. There is nothing in the kernel logs.
> 
> The ping error is: "Destination Host Unreachable"
> 
> I found the problem with the mlx5 driver as in "it doesn't work when MAC
> address is not set"...
> 
> Perhaps Eli can explain what happens when the MAC address is not set?
> 
> > 
> > > Signed-off-by: Laurent Vivier <lvivier@redhat.com>
> > > ---
> > >   drivers/net/virtio_net.c | 14 ++++++++++++++
> > >   1 file changed, 14 insertions(+)
> > > 
> > > diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> > > index 7723b2a49d8e..4bdc8286678b 100644
> > > --- a/drivers/net/virtio_net.c
> > > +++ b/drivers/net/virtio_net.c
> > > @@ -3800,6 +3800,8 @@ static int virtnet_probe(struct virtio_device *vdev)
> > >   		eth_hw_addr_set(dev, addr);
> > >   	} else {
> > >   		eth_hw_addr_random(dev);
> > > +		dev_info(&vdev->dev, "Assigned random MAC address %pM\n",
> > > +			 dev->dev_addr);
> > >   	}
> > >   	/* Set up our device-specific information */
> > > @@ -3956,6 +3958,18 @@ static int virtnet_probe(struct virtio_device *vdev)
> > >   	pr_debug("virtnet: registered device %s with %d RX and TX vq's\n",
> > >   		 dev->name, max_queue_pairs);
> > > +	/* a random MAC address has been assigned, notify the device */
> > > +	if (!virtio_has_feature(vdev, VIRTIO_NET_F_MAC) &&
> > > +	    virtio_has_feature(vi->vdev, VIRTIO_NET_F_CTRL_MAC_ADDR)) {
> > 
> > Maybe add a comment explaining that we don't fail probe if
> > VIRTIO_NET_F_CTRL_MAC_ADDR is not there because
> > many devices work fine without getting MAC explicitly.
> 
> OK
> 
> > 
> > > +		struct scatterlist sg;
> > > +
> > > +		sg_init_one(&sg, dev->dev_addr, dev->addr_len);
> > > +		if (!virtnet_send_command(vi, VIRTIO_NET_CTRL_MAC,
> > > +					  VIRTIO_NET_CTRL_MAC_ADDR_SET, &sg)) {
> > > +			dev_warn(&vdev->dev, "Failed to update MAC address.\n");
> > 
> > Here, I'm not sure we want to proceed. Is it useful sometimes?
> 
> I think reporting an error is always useful, but I can remove that if you prefer.

No the question was whether we should fail probe not
whether we print the warning.


> > I note that we deny with virtnet_set_mac_address.
> > 
> > > +		}
> > > +	}
> > > +
> > >   	return 0;
> > 
> > 
> > 
> > Also, some code duplication with virtnet_set_mac_address here.
> > 
> > Also:
> > 	When using the legacy interface, \field{mac} is driver-writable
> > 	which provided a way for drivers to update the MAC without
> > 	negotiating VIRTIO_NET_F_CTRL_MAC_ADDR.
> > 
> > How about factoring out code in virtnet_set_mac_address
> > and reusing that?
> > 
> 
> In fact, we can write in the field only if we have VIRTIO_NET_F_MAC
> (according to virtnet_set_mac_address(), and this code is executed only if
> we do not have VIRTIO_NET_F_MAC. So I think it's better not factoring the
> code as we have only the control queue case to manage.
> 
> > This will also handle corner cases such as VIRTIO_NET_F_STANDBY
> > which are not currently addressed.
> 
> F_STANDBY is only enabled when virtio-net device MAC address is equal to the
> VFIO device MAC address, I don't think it can be enabled when the MAC
> address is randomly assigned (in this case it has already failed in
> net_failover_create(), as it has been called using the random mac address),
> it's why I didn't check for it.

But the spec did not say there's a dependency :(.
My point is what should we do if there's F_STANDBY but no MAC?
Maybe add a separate patch clearing F_STANDBY in this case?

> > 
> > 
> > >   free_unregister_netdev:
> > > -- 
> > > 2.39.0
> > 
> 
> Thanks,
> Laurent

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
