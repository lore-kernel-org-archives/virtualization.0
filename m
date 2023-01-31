Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 57745C38142
	for <virtualization@archiver.kernel.org>; Tue, 31 Jan 2023 22:09:43 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id E446F81AF6;
	Tue, 31 Jan 2023 22:09:42 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org E446F81AF6
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=BdcnUZFX
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id yE7XDVrZ08jm; Tue, 31 Jan 2023 22:09:42 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 713F480A64;
	Tue, 31 Jan 2023 22:09:41 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 713F480A64
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 4B040C0032;
	Tue, 31 Jan 2023 22:09:41 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id A48D1C002B
 for <virtualization@lists.linux-foundation.org>;
 Tue, 31 Jan 2023 22:09:40 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 7EAA941882
 for <virtualization@lists.linux-foundation.org>;
 Tue, 31 Jan 2023 22:09:40 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 7EAA941882
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=BdcnUZFX
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id mR_KL4CUe60y
 for <virtualization@lists.linux-foundation.org>;
 Tue, 31 Jan 2023 22:09:39 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 8C4DD4187D
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 8C4DD4187D
 for <virtualization@lists.linux-foundation.org>;
 Tue, 31 Jan 2023 22:09:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1675202978;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=b+EInBavO8bUQmbkFuSQwUsNVOCGCJTbOtt6tsAhifI=;
 b=BdcnUZFXllZbgjL5FKmZM6FQDSzNh45W9t2MnFQ2ICY9pLON10Z8M91Gfw9Wl3MBR0K1uj
 tZ98RqO8aCHV5NvQGbJpUgq4NMJfxsCp/doOMBmV7dXcklHIrJixFSj5KXpdR0RtreqiHQ
 VtwWN8gDgy7VMPiOnxn/L09U4DdU5FI=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-362-YOgqS4oyMVOsRsqk3VoHyQ-1; Tue, 31 Jan 2023 17:09:36 -0500
X-MC-Unique: YOgqS4oyMVOsRsqk3VoHyQ-1
Received: by mail-ed1-f69.google.com with SMTP id
 w16-20020a056402129000b004a1f1a2e79dso9343287edv.23
 for <virtualization@lists.linux-foundation.org>;
 Tue, 31 Jan 2023 14:09:36 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=b+EInBavO8bUQmbkFuSQwUsNVOCGCJTbOtt6tsAhifI=;
 b=gAZpOsPpkhMwyNFnnJb35XhcOAKkTXMo5oL7UhmqlfznnHIf+4zwlhvgdf0eTqzSEH
 SAuy4kqp/4K8UhewVymTLiPd9XtjW6OkO2qqmnLcptN2IE6n22doV8FL4CkossCzu9Wh
 3UMjJnE4oSUrp0JSYHvSe7dEQmt9wKVOoAkj0ctYRJJYuwT4zXAnyNeaaOzR8nQQRXpk
 058bxUoYwVLLPpoyR9TLGxbh7a2LXb2gvISCToLYlwoHs+p3Bs4kCkbIPn20eUDst20N
 X/WgoyPJzU1TqzEl3hR/cMH4B1X6vE1botfdVdcP9o5Zm24+PU909YqMgQsBrPFbLfxb
 0Izg==
X-Gm-Message-State: AO0yUKVgr7bzLGhOmpWR5fstvOkLxff6y5uR674SnX1xQRF7vKiQ5yc+
 Cq6olctj3MbCI8JsAM0Mwgf7R5Dwbigbv5wMD2YHwWP0pb3Oi4H1ovn6bvVSPm6wAuTaA6ffJ97
 dvI87wmABTloqAtqEmrNyrjdIVJ1WxUZ0PfAWKD8+/g==
X-Received: by 2002:a17:907:7e9e:b0:878:5c22:6e03 with SMTP id
 qb30-20020a1709077e9e00b008785c226e03mr6070820ejc.73.1675202975371; 
 Tue, 31 Jan 2023 14:09:35 -0800 (PST)
X-Google-Smtp-Source: AK7set/umuCR+3IZE7Li+5UeArJ7g88Vg8CTJWN7CwjHLCAHc+Y5XBZ1wpIH1VghWcytadpuSByN2w==
X-Received: by 2002:a17:907:7e9e:b0:878:5c22:6e03 with SMTP id
 qb30-20020a1709077e9e00b008785c226e03mr6070806ejc.73.1675202975121; 
 Tue, 31 Jan 2023 14:09:35 -0800 (PST)
Received: from redhat.com ([2.52.144.173]) by smtp.gmail.com with ESMTPSA id
 d23-20020a1709063ed700b0088d0b51f056sm818204ejj.40.2023.01.31.14.09.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 31 Jan 2023 14:09:34 -0800 (PST)
Date: Tue, 31 Jan 2023 17:09:30 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Laurent Vivier <lvivier@redhat.com>
Subject: Re: [PATCH v3 1/2] virtio_net: disable VIRTIO_NET_F_STANDBY if
 VIRTIO_NET_F_MAC is not set
Message-ID: <20230131170923-mutt-send-email-mst@kernel.org>
References: <20230127204500.51930-1-lvivier@redhat.com>
 <20230127204500.51930-2-lvivier@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20230127204500.51930-2-lvivier@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: Cindy Lu <lulu@redhat.com>, "David S. Miller" <davem@davemloft.net>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 virtualization@lists.linux-foundation.org,
 Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
 Eli Cohen <elic@nvidia.com>, Gautam Dawar <gautam.dawar@xilinx.com>
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

On Fri, Jan 27, 2023 at 09:44:59PM +0100, Laurent Vivier wrote:
> failover relies on the MAC address to pair the primary and the standby
> devices:
> 
>   "[...] the hypervisor needs to enable VIRTIO_NET_F_STANDBY
>    feature on the virtio-net interface and assign the same MAC address
>    to both virtio-net and VF interfaces."
> 
>   Documentation/networking/net_failover.rst
> 
> This patch disables the STANDBY feature if the MAC address is not
> provided by the hypervisor.
> 
> Signed-off-by: Laurent Vivier <lvivier@redhat.com>

Acked-by: Michael S. Tsirkin <mst@redhat.com>

> ---
>  drivers/net/virtio_net.c | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> index 7723b2a49d8e..7d700f8e545a 100644
> --- a/drivers/net/virtio_net.c
> +++ b/drivers/net/virtio_net.c
> @@ -3688,6 +3688,12 @@ static int virtnet_validate(struct virtio_device *vdev)
>  			__virtio_clear_bit(vdev, VIRTIO_NET_F_MTU);
>  	}
>  
> +	if (virtio_has_feature(vdev, VIRTIO_NET_F_STANDBY) &&
> +	    !virtio_has_feature(vdev, VIRTIO_NET_F_MAC)) {
> +		dev_warn(&vdev->dev, "device advertises feature VIRTIO_NET_F_STANDBY but not VIRTIO_NET_F_MAC, disabling standby");
> +		__virtio_clear_bit(vdev, VIRTIO_NET_F_STANDBY);
> +	}
> +
>  	return 0;
>  }
>  
> -- 
> 2.39.1

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
