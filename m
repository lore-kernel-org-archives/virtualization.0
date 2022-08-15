Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C92E3C00140
	for <virtualization@archiver.kernel.org>; Mon, 15 Aug 2022 23:36:28 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 6F60760C2A;
	Mon, 15 Aug 2022 23:36:28 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 6F60760C2A
Authentication-Results: smtp3.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20210112 header.b=ZUpPnnTP
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 35PpynK3YrEJ; Mon, 15 Aug 2022 23:36:27 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id DF98A60C25;
	Mon, 15 Aug 2022 23:36:26 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org DF98A60C25
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id BE320C0033;
	Mon, 15 Aug 2022 23:36:26 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 9F39BC002D
 for <virtualization@lists.linux-foundation.org>;
 Mon, 15 Aug 2022 23:36:25 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 78FF28186E
 for <virtualization@lists.linux-foundation.org>;
 Mon, 15 Aug 2022 23:36:25 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 78FF28186E
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20210112 header.b=ZUpPnnTP
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id ffQ5IBfQGAFE
 for <virtualization@lists.linux-foundation.org>;
 Mon, 15 Aug 2022 23:36:24 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 8320581852
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com
 [IPv6:2607:f8b0:4864:20::1029])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 8320581852
 for <virtualization@lists.linux-foundation.org>;
 Mon, 15 Aug 2022 23:36:24 +0000 (UTC)
Received: by mail-pj1-x1029.google.com with SMTP id
 o5-20020a17090a3d4500b001ef76490983so8099581pjf.2
 for <virtualization@lists.linux-foundation.org>;
 Mon, 15 Aug 2022 16:36:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:sender:from:to:cc;
 bh=jXfmFWyPTI+/X9q6YSHrJyPzaAFzd5pRVR1VGmA59ow=;
 b=ZUpPnnTP2SeMrbSXwPX7TejLi5n/sg43tnIuviaoBDPf7szFy14G/Zm/d34T16qUeV
 tU9ym01zECetIx2f/W5H651WscbCumYf3f3L9u2Mmqf2kJ1g+l4TvGDNh9X3GWZdtjr3
 PxLVyDsbcz3zvyLyiTuVSCkcYJOJWifqML0hzBaFvU4xbhdaDq6+zxdCNZZTWV7lHMXs
 pWggQ/K4SKGSJID46FK3VA7StW/Vga2++z50+dGb7X33RU5w+Zs13ehrcVlCuoJ42txk
 XbMIJWcmqsI9Wo3ymQnnJUWGUEUqNFSbrgJvY/WxEwdY5bmR9fqSQ03LPs/pyN/hffDt
 8xhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc;
 bh=jXfmFWyPTI+/X9q6YSHrJyPzaAFzd5pRVR1VGmA59ow=;
 b=7i5xbHJiLHK1jYSQnRdj0lIqYMgXHE/+T3XD+EKZiiWo/6wCD+kpuSww+w0l78llZq
 09xgmoXv6LQiymsOul5UprX3NY4J9xwj+t9+oDhVmpsVubZiPgMZxf1KegWmPlnUWUfy
 Z/eNnRo/Q8az6tM84H2mLn7m8Gs8IGad0U3Y6xXsYe5D86ILYQj1kkDj2Rzo7jVqX7W8
 uJgtdhBiXxDFHw96tmIW7l3EvS8Kecn7H3+kVMIAvr+mcPJbh4hfKhTd3j88wTzb0ubW
 U3nVV/nZDHubw8aOijW1KipJa/F/MRdfOpNS2ff/McmHWPUe8+BVYXGPaQgl57yYRxv+
 enKQ==
X-Gm-Message-State: ACgBeo3KlvbmwnK2LlTcuF0zxc2J4JAIdPI+hkNaPtb5hIEeNcw/Icdh
 VKUe3yfjVfp4y3Apt0WgWcQ=
X-Google-Smtp-Source: AA6agR4i/Lselxo0AHv145hK8gytkCZZZ32/Q8nJ7bBvGMnJ7eQAw+KQLokHJ1E+lcUggJFlO4NT0w==
X-Received: by 2002:a17:903:11cd:b0:170:cde8:18b7 with SMTP id
 q13-20020a17090311cd00b00170cde818b7mr19364760plh.165.1660606583904; 
 Mon, 15 Aug 2022 16:36:23 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
 by smtp.gmail.com with ESMTPSA id
 q3-20020a17090a304300b001f2c22fa4ddsm4959475pjl.50.2022.08.15.16.36.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 15 Aug 2022 16:36:21 -0700 (PDT)
Date: Mon, 15 Aug 2022 16:36:18 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH v3 1/5] virtio_net: Revert "virtio_net: set the default
 max ring size by find_vqs()"
Message-ID: <20220815233618.GA653119@roeck-us.net>
References: <20220815215938.154999-1-mst@redhat.com>
 <20220815215938.154999-2-mst@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20220815215938.154999-2-mst@redhat.com>
Cc: Jens Axboe <axboe@kernel.dk>,
 "Martin K. Petersen" <martin.petersen@oracle.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org,
 James Bottomley <James.Bottomley@hansenpartnership.com>,
 Eric Dumazet <edumazet@google.com>, Andres Freund <andres@anarazel.de>,
 Greg KH <gregkh@linuxfoundation.org>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>,
 Linus Torvalds <torvalds@linux-foundation.org>,
 "David S. Miller" <davem@davemloft.net>
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

On Mon, Aug 15, 2022 at 06:00:25PM -0400, Michael S. Tsirkin wrote:
> This reverts commit 762faee5a2678559d3dc09d95f8f2c54cd0466a7.
> 
> This has been reported to trip up guests on GCP (Google Cloud).
> The reason is that virtio_find_vqs_ctx_size is broken on legacy
> devices. We can in theory fix virtio_find_vqs_ctx_size but
> in fact the patch itself has several other issues:
> 
> - It treats unknown speed as < 10G
> - It leaves userspace no way to find out the ring size set by hypervisor
> - It tests speed when link is down
> - It ignores the virtio spec advice:
>         Both \field{speed} and \field{duplex} can change, thus the driver
>         is expected to re-read these values after receiving a
>         configuration change notification.
> - It is not clear the performance impact has been tested properly
> 
> Revert the patch for now.
> 
> Reported-by: Andres Freund <andres@anarazel.de>
> Link: https://lore.kernel.org/r/20220814212610.GA3690074%40roeck-us.net
> Link: https://lore.kernel.org/r/20220815070203.plwjx7b3cyugpdt7%40awork3.anarazel.de
> Link: https://lore.kernel.org/r/3df6bb82-1951-455d-a768-e9e1513eb667%40www.fastmail.com
> Link: https://lore.kernel.org/r/FCDC5DDE-3CDD-4B8A-916F-CA7D87B547CE%40anarazel.de
> Fixes: 762faee5a267 ("virtio_net: set the default max ring size by find_vqs()")
> Cc: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> Cc: Jason Wang <jasowang@redhat.com>
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> Tested-by: Andres Freund <andres@anarazel.de>
> Tested-by: From: Guenter Roeck <linux@roeck-us.net>

s/From: //

> ---
>  drivers/net/virtio_net.c | 42 ++++------------------------------------
>  1 file changed, 4 insertions(+), 38 deletions(-)
> 
> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> index d934774e9733..ece00b84e3a7 100644
> --- a/drivers/net/virtio_net.c
> +++ b/drivers/net/virtio_net.c
> @@ -3432,29 +3432,6 @@ static unsigned int mergeable_min_buf_len(struct virtnet_info *vi, struct virtqu
>  		   (unsigned int)GOOD_PACKET_LEN);
>  }
>  
> -static void virtnet_config_sizes(struct virtnet_info *vi, u32 *sizes)
> -{
> -	u32 i, rx_size, tx_size;
> -
> -	if (vi->speed == SPEED_UNKNOWN || vi->speed < SPEED_10000) {
> -		rx_size = 1024;
> -		tx_size = 1024;
> -
> -	} else if (vi->speed < SPEED_40000) {
> -		rx_size = 1024 * 4;
> -		tx_size = 1024 * 4;
> -
> -	} else {
> -		rx_size = 1024 * 8;
> -		tx_size = 1024 * 8;
> -	}
> -
> -	for (i = 0; i < vi->max_queue_pairs; i++) {
> -		sizes[rxq2vq(i)] = rx_size;
> -		sizes[txq2vq(i)] = tx_size;
> -	}
> -}
> -
>  static int virtnet_find_vqs(struct virtnet_info *vi)
>  {
>  	vq_callback_t **callbacks;
> @@ -3462,7 +3439,6 @@ static int virtnet_find_vqs(struct virtnet_info *vi)
>  	int ret = -ENOMEM;
>  	int i, total_vqs;
>  	const char **names;
> -	u32 *sizes;
>  	bool *ctx;
>  
>  	/* We expect 1 RX virtqueue followed by 1 TX virtqueue, followed by
> @@ -3490,15 +3466,10 @@ static int virtnet_find_vqs(struct virtnet_info *vi)
>  		ctx = NULL;
>  	}
>  
> -	sizes = kmalloc_array(total_vqs, sizeof(*sizes), GFP_KERNEL);
> -	if (!sizes)
> -		goto err_sizes;
> -
>  	/* Parameters for control virtqueue, if any */
>  	if (vi->has_cvq) {
>  		callbacks[total_vqs - 1] = NULL;
>  		names[total_vqs - 1] = "control";
> -		sizes[total_vqs - 1] = 64;
>  	}
>  
>  	/* Allocate/initialize parameters for send/receive virtqueues */
> @@ -3513,10 +3484,8 @@ static int virtnet_find_vqs(struct virtnet_info *vi)
>  			ctx[rxq2vq(i)] = true;
>  	}
>  
> -	virtnet_config_sizes(vi, sizes);
> -
> -	ret = virtio_find_vqs_ctx_size(vi->vdev, total_vqs, vqs, callbacks,
> -				       names, sizes, ctx, NULL);
> +	ret = virtio_find_vqs_ctx(vi->vdev, total_vqs, vqs, callbacks,
> +				  names, ctx, NULL);
>  	if (ret)
>  		goto err_find;
>  
> @@ -3536,8 +3505,6 @@ static int virtnet_find_vqs(struct virtnet_info *vi)
>  
>  
>  err_find:
> -	kfree(sizes);
> -err_sizes:
>  	kfree(ctx);
>  err_ctx:
>  	kfree(names);
> @@ -3897,9 +3864,6 @@ static int virtnet_probe(struct virtio_device *vdev)
>  		vi->curr_queue_pairs = num_online_cpus();
>  	vi->max_queue_pairs = max_queue_pairs;
>  
> -	virtnet_init_settings(dev);
> -	virtnet_update_settings(vi);
> -
>  	/* Allocate/initialize the rx/tx queues, and invoke find_vqs */
>  	err = init_vqs(vi);
>  	if (err)
> @@ -3912,6 +3876,8 @@ static int virtnet_probe(struct virtio_device *vdev)
>  	netif_set_real_num_tx_queues(dev, vi->curr_queue_pairs);
>  	netif_set_real_num_rx_queues(dev, vi->curr_queue_pairs);
>  
> +	virtnet_init_settings(dev);
> +
>  	if (virtio_has_feature(vdev, VIRTIO_NET_F_STANDBY)) {
>  		vi->failover = net_failover_create(vi->dev);
>  		if (IS_ERR(vi->failover)) {
> -- 
> MST
> 
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
