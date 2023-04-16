Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E9FD0C77B61
	for <virtualization@archiver.kernel.org>; Sun, 16 Apr 2023 20:38:24 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 4805D607A4;
	Sun, 16 Apr 2023 20:38:24 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 4805D607A4
Authentication-Results: smtp3.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=UABSA020
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id LQyZUiNZtCTC; Sun, 16 Apr 2023 20:38:23 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id D311260A7F;
	Sun, 16 Apr 2023 20:38:22 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org D311260A7F
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 9BC3AC0036;
	Sun, 16 Apr 2023 20:38:22 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 98640C002A
 for <virtualization@lists.linux-foundation.org>;
 Sun, 16 Apr 2023 20:38:21 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 5E42841B70
 for <virtualization@lists.linux-foundation.org>;
 Sun, 16 Apr 2023 20:38:21 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 5E42841B70
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=UABSA020
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id XZtcEUcK8Cm6
 for <virtualization@lists.linux-foundation.org>;
 Sun, 16 Apr 2023 20:38:20 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 1574941B69
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 1574941B69
 for <virtualization@lists.linux-foundation.org>;
 Sun, 16 Apr 2023 20:38:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1681677498;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=1gmjEPQ1Z2707YDu2q8TGB4gvRcqR+kjHgJ0ZU8q2GE=;
 b=UABSA020eadNdRYgNssvgDc9HlSzrAN2ANud2WR7U5X3ZPIzghaOt7q32NRKV+FRdEtkE2
 I8vuMMnXYhcYu0zZ12/sSyl4eKVcFljgMDckuskuhG2lepF695Pqy2m//FDNoX+wq4lDAL
 155AuKsrXsv4J49Ra5h1w45bX8Apmzs=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-80-_gWvfuk1O6uv026jH_7ZvA-1; Sun, 16 Apr 2023 16:38:17 -0400
X-MC-Unique: _gWvfuk1O6uv026jH_7ZvA-1
Received: by mail-ed1-f70.google.com with SMTP id
 b60-20020a509f42000000b00504eca73d05so7707272edf.18
 for <virtualization@lists.linux-foundation.org>;
 Sun, 16 Apr 2023 13:38:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1681677496; x=1684269496;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1gmjEPQ1Z2707YDu2q8TGB4gvRcqR+kjHgJ0ZU8q2GE=;
 b=UBmJSupn+Uot6F4HRCfG07XwSeZe4gkISKMyp+SGyMnj8jEJMQkbh/8AAKUAe3Zidg
 nBbgtLDckpt9foOUkXcpSEa+x72YDrZoUuWXGUZrRs1bHDTmcKrk6Zd2trXZ+h7lBFP7
 r96NJ8j14ERtSSD9cib6LMpIoP7bh/yAy9PIeAoERsEzSE2ztc1EKMKwKS/XuRsNwr2i
 bto1AxtmY11RMNqTgaIx3ir17jf6ARUiA6lpiXp5JCart4OplOSWK8QZg4ShDDSZLggz
 LFkYFpl9oWnb7m3Yt+RLcay8xVFqf5QoIWCkxbH73pbaoKPl/DrXR0dMOmu6bgefn4zB
 XTTg==
X-Gm-Message-State: AAQBX9fnJkoVSs533lvS3vMqEMxU47YGve3HmafDEDndr9VVVWxYLbwJ
 biwfrdm9iliu2LbYvXfZyYpp1ZjVuPIV8RPYvawBWwFhECFY8gHLQy56awAVhxkZFp1hy5JBVX+
 lkTMvLM4UrjlrmxWoKQ6vU+XjeWowglx+VSxzj4evFw==
X-Received: by 2002:a17:906:bc42:b0:94f:5e17:e80d with SMTP id
 s2-20020a170906bc4200b0094f5e17e80dmr2534414ejv.45.1681677495992; 
 Sun, 16 Apr 2023 13:38:15 -0700 (PDT)
X-Google-Smtp-Source: AKy350ZXEZ6g56atv06YaLfflLN9idtJzsyZtc6S7GD+9Ye4l6xSIop1CrwmmH2GLzP5maJM6si0Jg==
X-Received: by 2002:a17:906:bc42:b0:94f:5e17:e80d with SMTP id
 s2-20020a170906bc4200b0094f5e17e80dmr2534403ejv.45.1681677495687; 
 Sun, 16 Apr 2023 13:38:15 -0700 (PDT)
Received: from redhat.com ([2.52.136.129]) by smtp.gmail.com with ESMTPSA id
 xg12-20020a170907320c00b0094ee99eeb01sm3877035ejb.150.2023.04.16.13.38.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 16 Apr 2023 13:38:15 -0700 (PDT)
Date: Sun, 16 Apr 2023 16:38:11 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Alvaro Karsz <alvaro.karsz@solid-run.com>
Subject: Re: [PATCH net] virtio-net: reject small vring sizes
Message-ID: <20230416163751-mutt-send-email-mst@kernel.org>
References: <20230416074607.292616-1-alvaro.karsz@solid-run.com>
MIME-Version: 1.0
In-Reply-To: <20230416074607.292616-1-alvaro.karsz@solid-run.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 virtualization@lists.linux-foundation.org, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, davem@davemloft.net
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

On Sun, Apr 16, 2023 at 10:46:07AM +0300, Alvaro Karsz wrote:
> Check vring size and fail probe if a transmit/receive vring size is
> smaller than MAX_SKB_FRAGS + 2.
> 
> At the moment, any vring size is accepted. This is problematic because
> it may result in attempting to transmit a packet with more fragments
> than there are descriptors in the ring.
> 
> Furthermore, it leads to an immediate bug:
> 
> The condition: (sq->vq->num_free >= 2 + MAX_SKB_FRAGS) in
> virtnet_poll_cleantx and virtnet_poll_tx always evaluates to false,
> so netif_tx_wake_queue is not called, leading to TX timeouts.
> 
> Signed-off-by: Alvaro Karsz <alvaro.karsz@solid-run.com>
> ---
>  drivers/net/virtio_net.c | 24 ++++++++++++++++++++++++
>  1 file changed, 24 insertions(+)
> 
> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> index 2396c28c012..59676252c5c 100644
> --- a/drivers/net/virtio_net.c
> +++ b/drivers/net/virtio_net.c
> @@ -3745,6 +3745,26 @@ static int init_vqs(struct virtnet_info *vi)
>  	return ret;
>  }
>  
> +static int virtnet_validate_vqs(struct virtnet_info *vi)
> +{
> +	u32 i, min_size = roundup_pow_of_two(MAX_SKB_FRAGS + 2);

why power of two?

> +
> +	/* Transmit/Receive vring size must be at least MAX_SKB_FRAGS + 2
> +	 * (fragments + linear part + virtio header)
> +	 */
> +	for (i = 0; i < vi->max_queue_pairs; i++) {
> +		if (virtqueue_get_vring_size(vi->sq[i].vq) < min_size ||
> +		    virtqueue_get_vring_size(vi->rq[i].vq) < min_size) {
> +			dev_warn(&vi->vdev->dev,
> +				 "Transmit/Receive virtqueue vring size must be at least %u\n",
> +				 min_size);
> +			return -EINVAL;
> +		}
> +	}
> +
> +	return 0;
> +}
> +
>  #ifdef CONFIG_SYSFS
>  static ssize_t mergeable_rx_buffer_size_show(struct netdev_rx_queue *queue,
>  		char *buf)
> @@ -4056,6 +4076,10 @@ static int virtnet_probe(struct virtio_device *vdev)
>  	if (err)
>  		goto free;
>  
> +	err = virtnet_validate_vqs(vi);
> +	if (err)
> +		goto free_vqs;
> +
>  #ifdef CONFIG_SYSFS
>  	if (vi->mergeable_rx_bufs)
>  		dev->sysfs_rx_queue_group = &virtio_net_mrg_rx_group;
> -- 
> 2.34.1

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
