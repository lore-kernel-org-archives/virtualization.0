Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 776BBC38142
	for <virtualization@archiver.kernel.org>; Tue, 24 Jan 2023 10:15:34 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 0CD186105F;
	Tue, 24 Jan 2023 10:15:34 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 0CD186105F
Authentication-Results: smtp3.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=Uh5Igb4W
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id UAmcCnosSb2r; Tue, 24 Jan 2023 10:15:33 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 93A9E61049;
	Tue, 24 Jan 2023 10:15:32 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 93A9E61049
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 67D63C0033;
	Tue, 24 Jan 2023 10:15:32 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 1AFAAC002D
 for <virtualization@lists.linux-foundation.org>;
 Tue, 24 Jan 2023 10:15:31 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id D605740147
 for <virtualization@lists.linux-foundation.org>;
 Tue, 24 Jan 2023 10:15:30 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org D605740147
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=Uh5Igb4W
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id IqQmNGHV94BO
 for <virtualization@lists.linux-foundation.org>;
 Tue, 24 Jan 2023 10:15:29 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 76763400F2
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 76763400F2
 for <virtualization@lists.linux-foundation.org>;
 Tue, 24 Jan 2023 10:15:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1674555328;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=NFgKaLWubEk/cRokgGdvBW4gpMpmZbK+meQJanVkKO8=;
 b=Uh5Igb4WRitkY7lAkMqFHRnS9HRBU63cZJ/8cfpQrOc3amso49QleCGhbpol89o/x3f2xg
 ep849bUx5BEyMsIodAoHYMjivyACKUexGeHoeTEai6nY/Nor033wRz41GHMTGDvJUd6xBb
 BN0J9MYJX50MKCzLrfRrGk8FIp5ajzA=
Received: from mail-vs1-f72.google.com (mail-vs1-f72.google.com
 [209.85.217.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-47-i_W5r5M8N1KlnWKjyyG4lQ-1; Tue, 24 Jan 2023 05:15:26 -0500
X-MC-Unique: i_W5r5M8N1KlnWKjyyG4lQ-1
Received: by mail-vs1-f72.google.com with SMTP id
 68-20020a670347000000b003bf750cb86eso3502635vsd.8
 for <virtualization@lists.linux-foundation.org>;
 Tue, 24 Jan 2023 02:15:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=NFgKaLWubEk/cRokgGdvBW4gpMpmZbK+meQJanVkKO8=;
 b=WHUzazQY5S4H0YXdAvkPZhkSpt16UY4xEadq/fxoYDHLQqgx8iRHEdkfZqJPYiMpFw
 rgO43d1VbuIUFubBtkMM7L7Ss9gSQaYnWi/pY2Ss4/gjtsi9KpPZn1raEQUEQxHinSlZ
 pnKol8y14p2A2SY9xV4E8YH92b7bvVGv00CQbySvcmcHdxs2jdxRGN4610DocwJ1z4rf
 vDDbB0hgx3AIGN2EvdnXevTowij4nIaSdzsgtA8+oiMl1wyOK5Ek4JuBGLaAMvBt74UT
 6pGr3JituXm0Ve0kxYGC+ddwj8u4VJYmXQgVg83zSfyKjTM9yvQUCzXJoL9uC/ZtT0NL
 evRA==
X-Gm-Message-State: AFqh2koUV9m/opRLyC+RZ15DopCgBzWtIaB4SM8KWLDIn2jS6cCV2eLn
 S837B5bw5yeaq6pXdmKlRNqPwawMCfWf8AFoC8Y/r9atVTVR1aWVVEA4lHwpZM9lzqdsmbEk6nr
 moG5BUc+OAMZv+J2scZ5YsLHX+Dx8++GlfNeZS2WtoQ==
X-Received: by 2002:a05:6102:3e08:b0:3d0:d383:72b6 with SMTP id
 j8-20020a0561023e0800b003d0d38372b6mr16531977vsv.11.1674555326242; 
 Tue, 24 Jan 2023 02:15:26 -0800 (PST)
X-Google-Smtp-Source: AMrXdXufWDfGyzlwj9ku95BLubbEIcCLMhu58PdSNVkjhU4LwXOgwCiaQKrtaMKVEBK2ZmpgsHg/Ag==
X-Received: by 2002:a05:6102:3e08:b0:3d0:d383:72b6 with SMTP id
 j8-20020a0561023e0800b003d0d38372b6mr16531967vsv.11.1674555325974; 
 Tue, 24 Jan 2023 02:15:25 -0800 (PST)
Received: from redhat.com ([45.144.113.7]) by smtp.gmail.com with ESMTPSA id
 i1-20020ab02481000000b004199ab0d752sm112004uan.16.2023.01.24.02.15.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 24 Jan 2023 02:15:24 -0800 (PST)
Date: Tue, 24 Jan 2023 05:15:17 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Laurent Vivier <lvivier@redhat.com>
Subject: Re: [PATCH v2 1/1] virtio_net: notify MAC address change on device
 initialization
Message-ID: <20230124024711-mutt-send-email-mst@kernel.org>
References: <20230123120022.2364889-1-lvivier@redhat.com>
 <20230123120022.2364889-2-lvivier@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20230123120022.2364889-2-lvivier@redhat.com>
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

On Mon, Jan 23, 2023 at 01:00:22PM +0100, Laurent Vivier wrote:
> In virtnet_probe(), if the device doesn't provide a MAC address the
> driver assigns a random one.
> As we modify the MAC address we need to notify the device to allow it
> to update all the related information.
> 
> The problem can be seen with vDPA and mlx5_vdpa driver as it doesn't
> assign a MAC address by default. The virtio_net device uses a random
> MAC address (we can see it with "ip link"), but we can't ping a net
> namespace from another one using the virtio-vdpa device because the
> new MAC address has not been provided to the hardware.

And then what exactly happens? Does hardware drop the outgoing
or the incoming packets? Pls include in the commit log.

> Signed-off-by: Laurent Vivier <lvivier@redhat.com>
> ---
>  drivers/net/virtio_net.c | 14 ++++++++++++++
>  1 file changed, 14 insertions(+)
> 
> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> index 7723b2a49d8e..4bdc8286678b 100644
> --- a/drivers/net/virtio_net.c
> +++ b/drivers/net/virtio_net.c
> @@ -3800,6 +3800,8 @@ static int virtnet_probe(struct virtio_device *vdev)
>  		eth_hw_addr_set(dev, addr);
>  	} else {
>  		eth_hw_addr_random(dev);
> +		dev_info(&vdev->dev, "Assigned random MAC address %pM\n",
> +			 dev->dev_addr);
>  	}
>  
>  	/* Set up our device-specific information */
> @@ -3956,6 +3958,18 @@ static int virtnet_probe(struct virtio_device *vdev)
>  	pr_debug("virtnet: registered device %s with %d RX and TX vq's\n",
>  		 dev->name, max_queue_pairs);
>  
> +	/* a random MAC address has been assigned, notify the device */
> +	if (!virtio_has_feature(vdev, VIRTIO_NET_F_MAC) &&
> +	    virtio_has_feature(vi->vdev, VIRTIO_NET_F_CTRL_MAC_ADDR)) {

Maybe add a comment explaining that we don't fail probe if
VIRTIO_NET_F_CTRL_MAC_ADDR is not there because
many devices work fine without getting MAC explicitly.

> +		struct scatterlist sg;
> +
> +		sg_init_one(&sg, dev->dev_addr, dev->addr_len);
> +		if (!virtnet_send_command(vi, VIRTIO_NET_CTRL_MAC,
> +					  VIRTIO_NET_CTRL_MAC_ADDR_SET, &sg)) {
> +			dev_warn(&vdev->dev, "Failed to update MAC address.\n");

Here, I'm not sure we want to proceed. Is it useful sometimes?
I note that we deny with virtnet_set_mac_address.

> +		}
> +	}
> +
>  	return 0;



Also, some code duplication with virtnet_set_mac_address here.

Also:
	When using the legacy interface, \field{mac} is driver-writable
	which provided a way for drivers to update the MAC without
	negotiating VIRTIO_NET_F_CTRL_MAC_ADDR.

How about factoring out code in virtnet_set_mac_address
and reusing that?


This will also handle corner cases such as VIRTIO_NET_F_STANDBY
which are not currently addressed.


>  free_unregister_netdev:
> -- 
> 2.39.0

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
