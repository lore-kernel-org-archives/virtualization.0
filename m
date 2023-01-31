Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0974EC38142
	for <virtualization@archiver.kernel.org>; Tue, 31 Jan 2023 09:02:05 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 70DAF400EF;
	Tue, 31 Jan 2023 09:02:05 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 70DAF400EF
Authentication-Results: smtp2.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=ga5Ee7Bs
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 2ITYwx_vSTFr; Tue, 31 Jan 2023 09:02:04 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id CEA7440101;
	Tue, 31 Jan 2023 09:02:03 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org CEA7440101
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id A5DB2C0032;
	Tue, 31 Jan 2023 09:02:03 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id C9E1BC002B
 for <virtualization@lists.linux-foundation.org>;
 Tue, 31 Jan 2023 09:02:02 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id A356F40981
 for <virtualization@lists.linux-foundation.org>;
 Tue, 31 Jan 2023 09:02:02 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org A356F40981
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=ga5Ee7Bs
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id cKz7_WRoCiJf
 for <virtualization@lists.linux-foundation.org>;
 Tue, 31 Jan 2023 09:02:01 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 57FA74097A
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 57FA74097A
 for <virtualization@lists.linux-foundation.org>;
 Tue, 31 Jan 2023 09:02:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1675155720;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=QIHT8E8sby0WGNdWp5sGZRRNaRA79rKzdH9xDxwJQHg=;
 b=ga5Ee7BsjxWEp1gq0gWDrP/xVWcJ8DKWkzVLRWZOGEmtbeWcSO7SH3zmB5jB7JgmRz0OFw
 MuG6tZhjatIFVUZXb+UoZUQv6pOBi8yNaQu2WnE7C/smMNGOoQHqjA2lIJmo2GVWCNdm+p
 MacwoBa/32BLFEi/uieChIjFYFWRTmo=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-356-e96tO8tAMYGPSbSSIBW5FA-1; Tue, 31 Jan 2023 04:01:58 -0500
X-MC-Unique: e96tO8tAMYGPSbSSIBW5FA-1
Received: by mail-qk1-f200.google.com with SMTP id
 a198-20020ae9e8cf000000b007259083a3c8so880985qkg.7
 for <virtualization@lists.linux-foundation.org>;
 Tue, 31 Jan 2023 01:01:58 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=mime-version:user-agent:content-transfer-encoding:references
 :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=0vt2tjqxlN7/1NemGgBR2FJoG/wRT9bFNFt/hjOlWcI=;
 b=w5XKvStiwmhSzsiVQ8FaQb08116hwN31k2YmzqS81RwPJ4YWhe/1bukQrBX7S3+hy7
 0wc6okcFDuGpkiiA+MD/9eB6pwj5K6QvuNVaKnNuyL3tHu+6CzKarnnLWFY+gIP1OXNf
 agThYzTtH5ZiET/Kxznf3WZwLVZWRhVXy0hniHCT7rIYYHll1TQ4wOUq+x0He1hH+b0v
 CJ5gNSYtjPdBOBzeB+uTSb12bbtFGpbY38819n0UmWmOFZ64GbM9tvxvm4Go8CG+xQLV
 NBdagJpuZjEVKXqBSNCd9S3jGs3qEkEwb+lOQjFCanSFnB9g8HZ14vvKGJRgBodmKwfW
 Icsw==
X-Gm-Message-State: AO0yUKUzBpzXM1J/82RmigkQ9tbt8Hm/gKPrx1EEDvJ7035BXSAseQrj
 8gokxgG9BBUYVj29wxMaO2qyPIL8m/tL2oVTvQPTmUu1uNqho8pZvkBhJlq8qiDmRHttT7Pv6Ct
 hljNOlCvvOiK0wf750PXO5UKO9IiI3xwNRAh6TKi5LQ==
X-Received: by 2002:a0c:b282:0:b0:53a:a0b4:99e5 with SMTP id
 r2-20020a0cb282000000b0053aa0b499e5mr5701070qve.5.1675155718289; 
 Tue, 31 Jan 2023 01:01:58 -0800 (PST)
X-Google-Smtp-Source: AK7set/8gyp2fjq9TftLcjH1ZOMz2/ugjeYGTj52R3CtGBrlxJBMNlEq5CYyi69gOrfXhoP9k+Q6SA==
X-Received: by 2002:a0c:b282:0:b0:53a:a0b4:99e5 with SMTP id
 r2-20020a0cb282000000b0053aa0b499e5mr5701037qve.5.1675155718008; 
 Tue, 31 Jan 2023 01:01:58 -0800 (PST)
Received: from gerbillo.redhat.com (146-241-113-28.dyn.eolo.it.
 [146.241.113.28]) by smtp.gmail.com with ESMTPSA id
 z16-20020ae9c110000000b0070617deb4b7sm9385834qki.134.2023.01.31.01.01.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 31 Jan 2023 01:01:57 -0800 (PST)
Message-ID: <949500bd10077989eb21bd41d6bb1a0de296f9d8.camel@redhat.com>
Subject: Re: [PATCH v3 2/2] virtio_net: notify MAC address change on device
 initialization
From: Paolo Abeni <pabeni@redhat.com>
To: Laurent Vivier <lvivier@redhat.com>, linux-kernel@vger.kernel.org
Date: Tue, 31 Jan 2023 10:01:53 +0100
In-Reply-To: <20230127204500.51930-3-lvivier@redhat.com>
References: <20230127204500.51930-1-lvivier@redhat.com>
 <20230127204500.51930-3-lvivier@redhat.com>
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

On Fri, 2023-01-27 at 21:45 +0100, Laurent Vivier wrote:
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

Since the above is still dealing with device initialization, would it
make sense moving such init step before registering the netdevice? 

Cheers,

Paolo

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
