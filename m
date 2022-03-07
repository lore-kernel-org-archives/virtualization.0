Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8CB72C433EF
	for <virtualization@archiver.kernel.org>; Mon,  7 Mar 2022 10:00:33 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 17F08403B8;
	Mon,  7 Mar 2022 10:00:33 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id d-tZta3V9NjJ; Mon,  7 Mar 2022 10:00:32 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 796B340136;
	Mon,  7 Mar 2022 10:00:31 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 4A3F3C001D;
	Mon,  7 Mar 2022 10:00:31 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id C3130C000B
 for <virtualization@lists.linux-foundation.org>;
 Mon,  7 Mar 2022 10:00:29 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id B204581A24
 for <virtualization@lists.linux-foundation.org>;
 Mon,  7 Mar 2022 10:00:29 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id E8J9FZcLa41d
 for <virtualization@lists.linux-foundation.org>;
 Mon,  7 Mar 2022 10:00:27 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 8B76281378
 for <virtualization@lists.linux-foundation.org>;
 Mon,  7 Mar 2022 10:00:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1646647226;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=A0eAGIa8ZFoiGy0ltp+n8ALS+KZeFMfXfRLbv+BRamg=;
 b=TQDj/m8TZ4Uyspurrfd9uywe9qqb/2/i5j4CjHhRMleNVuiPGBUEyMuUJhkA/MMNbc3CBr
 CtWOZHkuFwvavwk4KH/mGGmoEIlWRIJKb7bVkqKPgSguJz6yxKgle8fG61jdM2ckYJfAyU
 jMqRMLmmdBu5uPpGy8I60xl7UhyHE8E=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-177-HRzQ9Qy1NXOWiWKzEtmh1g-1; Mon, 07 Mar 2022 05:00:25 -0500
X-MC-Unique: HRzQ9Qy1NXOWiWKzEtmh1g-1
Received: by mail-ej1-f72.google.com with SMTP id
 ey18-20020a1709070b9200b006da9614af58so4711173ejc.10
 for <virtualization@lists.linux-foundation.org>;
 Mon, 07 Mar 2022 02:00:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=A0eAGIa8ZFoiGy0ltp+n8ALS+KZeFMfXfRLbv+BRamg=;
 b=cwrzDhbjn9RIsR/Sn/35EGNlrQ3B8iqrCANDX+Pw/j8mczstUiaqVJuHGZrjkkxyiI
 wLDBmc0e1f3Sm4RvtZqk+9kL9aA8pLc8nWk3G4L/0tvILsVKZTN0YtlNbdzARInWgput
 h7pgAMnLXb/kq1IxsNYrM5rPnTxEQhgAVGHwHzqqdwBv++uV4sH3MTmlSa+W6WjoPXu1
 IaWfXi4et5m6IOTtoohSfrwTKij6u7sebYAZmc05aTn49c96Yn3hLuEV3wccLeTUdCi5
 P2zVzpOh9aaJttuKFr99IpuQfo6F6dpqrtdBQs5cAdqopsXpd/tpt7hxFXHmHv6WJV9b
 Emtw==
X-Gm-Message-State: AOAM533RNouVHtMcJIWOyEs/GkMglpbZVLVf+f7mDr+9KlP77Wrse9wT
 wvAcYCwXBKB5LV7mpKzWXQ2k9n1Frcv1PoLIdypqzUaWUdNKB+6BpCKRR7QeceiEMvEyFBLKuAZ
 XwTul3Q0KMeoxzaZ6f2Qreb+GiHu/5ee182nuFItIDQ==
X-Received: by 2002:a50:9d8a:0:b0:410:d303:8af5 with SMTP id
 w10-20020a509d8a000000b00410d3038af5mr10365898ede.371.1646647223980; 
 Mon, 07 Mar 2022 02:00:23 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyKtnzgZGNOoEz8OAiIExnA/bdilkwHBohftbq+PKv8FwwC5RapOUy2aAve0Y32kBXGfJ6ItQ==
X-Received: by 2002:a50:9d8a:0:b0:410:d303:8af5 with SMTP id
 w10-20020a509d8a000000b00410d3038af5mr10365886ede.371.1646647223740; 
 Mon, 07 Mar 2022 02:00:23 -0800 (PST)
Received: from redhat.com ([2.55.138.228]) by smtp.gmail.com with ESMTPSA id
 i6-20020a17090685c600b006daecf0b350sm2880444ejy.75.2022.03.07.02.00.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 07 Mar 2022 02:00:23 -0800 (PST)
Date: Mon, 7 Mar 2022 05:00:20 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Subject: Re: [PATCH vhost] virtio_net: fix build warnings
Message-ID: <20220307045948-mutt-send-email-mst@kernel.org>
References: <20220307094042.22180-1-xuanzhuo@linux.alibaba.com>
MIME-Version: 1.0
In-Reply-To: <20220307094042.22180-1-xuanzhuo@linux.alibaba.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: Stephen Rothwell <sfr@canb.auug.org.au>, netdev@vger.kernel.org,
 virtualization@lists.linux-foundation.org, Jakub Kicinski <kuba@kernel.org>,
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

On Mon, Mar 07, 2022 at 05:40:42PM +0800, Xuan Zhuo wrote:
> These warnings appear on some platforms (arm multi_v7_defconfig). This
> patch fixes these warnings.
> 
> drivers/net/virtio_net.c: In function 'virtnet_rx_vq_reset':
> drivers/net/virtio_net.c:1823:63: warning: format '%ld' expects argument of type 'long int', but argument 3 has type 'int' [-Wformat=]
>  1823 |                    "reset rx reset vq fail: rx queue index: %ld err: %d\n",
>       |                                                             ~~^
>       |                                                               |
>       |                                                               long int
>       |                                                             %d
>  1824 |                    rq - vi->rq, err);
>       |                    ~~~~~~~~~~~
>       |                       |
>       |                       int
> drivers/net/virtio_net.c: In function 'virtnet_tx_vq_reset':
> drivers/net/virtio_net.c:1873:63: warning: format '%ld' expects argument of type 'long int', but argument 3 has type 'int' [-Wformat=]
>  1873 |                    "reset tx reset vq fail: tx queue index: %ld err: %d\n",
>       |                                                             ~~^
>       |                                                               |
>       |                                                               long int
>       |                                                             %d
>  1874 |                    sq - vi->sq, err);
>       |                    ~~~~~~~~~~~
>       |                       |
>       |                       int
> 
> Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
> Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>

I squashed this into the problematic patch. Take a look
at my tree to verify all's well pls.

> ---
>  drivers/net/virtio_net.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> index 1fa2d632a994..4d629d1ea894 100644
> --- a/drivers/net/virtio_net.c
> +++ b/drivers/net/virtio_net.c
> @@ -1820,7 +1820,7 @@ static int virtnet_rx_vq_reset(struct virtnet_info *vi,
>  
>  err:
>  	netdev_err(vi->dev,
> -		   "reset rx reset vq fail: rx queue index: %ld err: %d\n",
> +		   "reset rx reset vq fail: rx queue index: %td err: %d\n",
>  		   rq - vi->rq, err);
>  	virtnet_napi_enable(rq->vq, &rq->napi);
>  	return err;
> @@ -1870,7 +1870,7 @@ static int virtnet_tx_vq_reset(struct virtnet_info *vi,
>  
>  err:
>  	netdev_err(vi->dev,
> -		   "reset tx reset vq fail: tx queue index: %ld err: %d\n",
> +		   "reset tx reset vq fail: tx queue index: %td err: %d\n",
>  		   sq - vi->sq, err);
>  	virtnet_napi_tx_enable(vi, sq->vq, &sq->napi);
>  	return err;
> -- 
> 2.31.0

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
