Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 94C30C38142
	for <virtualization@archiver.kernel.org>; Tue, 31 Jan 2023 22:09:29 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 1D94241880;
	Tue, 31 Jan 2023 22:09:29 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 1D94241880
Authentication-Results: smtp4.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=WFavo6h/
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id CXPFcc3hz9Ih; Tue, 31 Jan 2023 22:09:28 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 428A64187D;
	Tue, 31 Jan 2023 22:09:27 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 428A64187D
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 15F60C0032;
	Tue, 31 Jan 2023 22:09:27 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id BE640C002B
 for <virtualization@lists.linux-foundation.org>;
 Tue, 31 Jan 2023 22:09:25 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 8BCC441880
 for <virtualization@lists.linux-foundation.org>;
 Tue, 31 Jan 2023 22:09:25 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 8BCC441880
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id p34r1Z4uHK_p
 for <virtualization@lists.linux-foundation.org>;
 Tue, 31 Jan 2023 22:09:24 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 99B5E4187D
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 99B5E4187D
 for <virtualization@lists.linux-foundation.org>;
 Tue, 31 Jan 2023 22:09:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1675202963;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Ip7LN5t2XMU2RXyA57wD+YKH27SGyN1LXlfzY7WmEN8=;
 b=WFavo6h/eexQX+XMM5JOfU0buq9keVPsDpNhugzbBdKQPbp3hr5jHQAnr6O5rGhXZaIvk0
 SdvqiX/9MWJ2Wcr9V06fu8fw8zkojudDc9VNK3ks3+W98OKTmkPa4jYzMYjkltV8aq2GBu
 GA2Ae0dz6W4kmkldAc2DxUWgj27fL48=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-327-RozhgcSONvG5MO1vLlfrPQ-1; Tue, 31 Jan 2023 17:09:21 -0500
X-MC-Unique: RozhgcSONvG5MO1vLlfrPQ-1
Received: by mail-ed1-f71.google.com with SMTP id
 s3-20020a50ab03000000b0049ec3a108beso11450706edc.7
 for <virtualization@lists.linux-foundation.org>;
 Tue, 31 Jan 2023 14:09:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Ip7LN5t2XMU2RXyA57wD+YKH27SGyN1LXlfzY7WmEN8=;
 b=pUjWmkDc0YjgR+KhaXur118xNso/5p40WolQOkPG65NuXKDo4wpfc7LnLOpQmRMUyt
 GCooDrcHs1qKzyTxnrwveCo3Chl7vApwtD7Lxu9bbUHQ6iJTIQi4mXE4tAVL0GTG+DA8
 Qcf6L4Khxo7K1kxVWxyqTh2aHRGHXzkqpLEyLLqt8BBzwUK0BasdG4ye5OpG9aY2bMB+
 UF0AO//Kx7LiCNjNF8erFpYe5f7aP4OFL+EZTJwHw7dgTxLI4bsSKIYy5ppayDVfgdz9
 j2vWV4iyIzxYElkIOo/OoaEU2hLYsJAP1XkRAIAIU+Eyf1nZtwn81+cRn28f8zMZ0GMp
 2xjA==
X-Gm-Message-State: AO0yUKV2WRLCt03TzfWm8yyLDaykMl9W4eSXr7oeczRjKnuIqdrdZ3BX
 kPmz4lx/YXyu6QFGWTZuWJ9xw+ukUC4KcbNozGWyV//eimw+JJXkV71ZT6C7yMfuKLfFy99Kv9P
 TDp0+hsRFKd7akIwmFgawjWk1EFi1GrRGzN/BvHgqRQ==
X-Received: by 2002:a05:6402:202e:b0:4a2:449a:9498 with SMTP id
 ay14-20020a056402202e00b004a2449a9498mr10759874edb.31.1675202960761; 
 Tue, 31 Jan 2023 14:09:20 -0800 (PST)
X-Google-Smtp-Source: AK7set8v8HniRH4JSAGTfryw69wu0KZFyBxDDgNcZStsKTfdJjHe3oeQBGrcGyuRfy7DNSiGzKJRUQ==
X-Received: by 2002:a05:6402:202e:b0:4a2:449a:9498 with SMTP id
 ay14-20020a056402202e00b004a2449a9498mr10759855edb.31.1675202960506; 
 Tue, 31 Jan 2023 14:09:20 -0800 (PST)
Received: from redhat.com ([2.52.144.173]) by smtp.gmail.com with ESMTPSA id
 a66-20020a509ec8000000b00482e0c55e2bsm889495edf.93.2023.01.31.14.09.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 31 Jan 2023 14:09:19 -0800 (PST)
Date: Tue, 31 Jan 2023 17:09:15 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Laurent Vivier <lvivier@redhat.com>
Subject: Re: [PATCH v3 2/2] virtio_net: notify MAC address change on device
 initialization
Message-ID: <20230131170908-mutt-send-email-mst@kernel.org>
References: <20230127204500.51930-1-lvivier@redhat.com>
 <20230127204500.51930-3-lvivier@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20230127204500.51930-3-lvivier@redhat.com>
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

On Fri, Jan 27, 2023 at 09:45:00PM +0100, Laurent Vivier wrote:
> In virtnet_probe(), if the device doesn't provide a MAC address the
> driver assigns a random one.
> As we modify the MAC address we need to notify the device to allow it
> to update all the related information.
> 
> The problem can be seen with vDPA and mlx5_vdpa driver as it doesn't
> assign a MAC address by default. The virtio_net device uses a random
> MAC address (we can see it with "ip link"), but we can't ping a net
> namespace from another one using the virtio-vdpa device because the
> new MAC address has not been provided to the hardware:
> RX packets are dropped since they don't go through the receive filters,
> TX packets go through unaffected.
> 
> Signed-off-by: Laurent Vivier <lvivier@redhat.com>

Acked-by: Michael S. Tsirkin <mst@redhat.com>

> ---
>  drivers/net/virtio_net.c | 20 ++++++++++++++++++++
>  1 file changed, 20 insertions(+)
> 
> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> index 7d700f8e545a..704a05f1c279 100644
> --- a/drivers/net/virtio_net.c
> +++ b/drivers/net/virtio_net.c
> @@ -3806,6 +3806,8 @@ static int virtnet_probe(struct virtio_device *vdev)
>  		eth_hw_addr_set(dev, addr);
>  	} else {
>  		eth_hw_addr_random(dev);
> +		dev_info(&vdev->dev, "Assigned random MAC address %pM\n",
> +			 dev->dev_addr);
>  	}
>  
>  	/* Set up our device-specific information */
> @@ -3933,6 +3935,24 @@ static int virtnet_probe(struct virtio_device *vdev)
>  
>  	virtio_device_ready(vdev);
>  
> +	/* a random MAC address has been assigned, notify the device.
> +	 * We don't fail probe if VIRTIO_NET_F_CTRL_MAC_ADDR is not there
> +	 * because many devices work fine without getting MAC explicitly
> +	 */
> +	if (!virtio_has_feature(vdev, VIRTIO_NET_F_MAC) &&
> +	    virtio_has_feature(vi->vdev, VIRTIO_NET_F_CTRL_MAC_ADDR)) {
> +		struct scatterlist sg;
> +
> +		sg_init_one(&sg, dev->dev_addr, dev->addr_len);
> +		if (!virtnet_send_command(vi, VIRTIO_NET_CTRL_MAC,
> +					  VIRTIO_NET_CTRL_MAC_ADDR_SET, &sg)) {
> +			pr_debug("virtio_net: setting MAC address failed\n");
> +			rtnl_unlock();
> +			err = -EINVAL;
> +			goto free_unregister_netdev;
> +		}
> +	}
> +
>  	rtnl_unlock();
>  
>  	err = virtnet_cpu_notif_add(vi);
> -- 
> 2.39.1

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
