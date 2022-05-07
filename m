Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2BABCC433F5
	for <virtualization@archiver.kernel.org>; Sat,  7 May 2022 06:55:55 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id C59B340185;
	Sat,  7 May 2022 06:55:54 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ZAr6QW3PgEFj; Sat,  7 May 2022 06:55:54 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 5E93240025;
	Sat,  7 May 2022 06:55:53 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 40500C0032;
	Sat,  7 May 2022 06:55:53 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id CC8E4C002D
 for <virtualization@lists.linux-foundation.org>;
 Sat,  7 May 2022 06:55:51 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id A6A9D60BF5
 for <virtualization@lists.linux-foundation.org>;
 Sat,  7 May 2022 06:55:51 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id jrQgyQBYjrEQ
 for <virtualization@lists.linux-foundation.org>;
 Sat,  7 May 2022 06:55:50 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id B8777607FF
 for <virtualization@lists.linux-foundation.org>;
 Sat,  7 May 2022 06:55:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1651906549;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=5ky9664jBBxipaK1+T4WD1CyHdwDxzdCPyIZwivjlQ8=;
 b=KSBCNFESphMoeeWYDiHVy4/1JslIh8iB3kKFvaZ+JvKHc/hZg4E0Q3rrQlbnSxkISSZhX6
 GfFIwaZ2Kv/tRHvMWsox+Y3ez1vbWzGfEM8m0c7vsVbo6NuLJHMkCWqQ6z99yqtQOHgs6S
 xBFkfou8zR/ic3x0hPl6oEExG+o3G/Q=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-634-1B7MGSh2PcKa2dgaGvM1Dw-1; Sat, 07 May 2022 02:55:40 -0400
X-MC-Unique: 1B7MGSh2PcKa2dgaGvM1Dw-1
Received: by mail-wm1-f71.google.com with SMTP id
 c62-20020a1c3541000000b0038ec265155fso7215130wma.6
 for <virtualization@lists.linux-foundation.org>;
 Fri, 06 May 2022 23:55:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=5ky9664jBBxipaK1+T4WD1CyHdwDxzdCPyIZwivjlQ8=;
 b=X72Xy9NgQKh81D7Sm11pXFimgzXPXfeslBGlm0UzzOetkVD82+HXwmT9/zD8bCZanz
 FMHfchOkG5bkGKtMSLLg2m6rHTponek0BPG1TgXOx7dID77TWCITB74l7R5J0IukFP4u
 AE+bogpK8WJPNuwf1+Xu82VrJFGVbvfiJyJU5YFas7L3NHVvaOyDDwFvk4tRCHxU0Pxq
 iPDpGVqQAwPqX3e7n8jPnmQsR6pP48JjAKcvh6pkOjmIT0Dzw7HuaoC0DcEbhtKhhPi5
 wD6f3SjJ2vkGRzvbpLdcL946lDjCSUlT8NTDMY4qUwyMEz0dsljtbbJvJidvYFgnjxr/
 O5lA==
X-Gm-Message-State: AOAM530BUOnSBY9u9fluoFXIyVqI+PcOXl90oditSqVHM2We8LpgjkyU
 gFLcso+yOuvprfReCE49WPJkh1tJATJA5kA5SqkX0xc2Lon2fEBxXcodOlHmECquVimEcKutovH
 pRyQOKFjWrkNE5NTbM1Q16eLSe1atABx/QqqY3eml2A==
X-Received: by 2002:a5d:5887:0:b0:20c:83c9:b72 with SMTP id
 n7-20020a5d5887000000b0020c83c90b72mr5533769wrf.588.1651906539534; 
 Fri, 06 May 2022 23:55:39 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwBtR1KWNuMpwef5G9NX642kzlWT08eDCiawrk/2foN5QTS+D1MNeZJ72hyJtzipf1hz24aGA==
X-Received: by 2002:a5d:5887:0:b0:20c:83c9:b72 with SMTP id
 n7-20020a5d5887000000b0020c83c90b72mr5533755wrf.588.1651906539325; 
 Fri, 06 May 2022 23:55:39 -0700 (PDT)
Received: from redhat.com ([2.55.154.141]) by smtp.gmail.com with ESMTPSA id
 t18-20020a5d6912000000b0020c5253d913sm5154408wru.95.2022.05.06.23.55.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 06 May 2022 23:55:38 -0700 (PDT)
Date: Sat, 7 May 2022 02:55:35 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jakub Kicinski <kuba@kernel.org>
Subject: Re: [PATCH net-next 5/6] net: virtio: switch to
 netif_napi_add_weight()
Message-ID: <20220507025428-mutt-send-email-mst@kernel.org>
References: <20220506170751.822862-1-kuba@kernel.org>
 <20220506170751.822862-6-kuba@kernel.org>
MIME-Version: 1.0
In-Reply-To: <20220506170751.822862-6-kuba@kernel.org>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: netdev@vger.kernel.org, virtualization@lists.linux-foundation.org,
 edumazet@google.com, pabeni@redhat.com, davem@davemloft.net
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

On Fri, May 06, 2022 at 10:07:50AM -0700, Jakub Kicinski wrote:
> virtio netdev driver uses a custom napi weight, switch to the new
> API for setting custom weight.
> 
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>

Acked-by: Michael S. Tsirkin <mst@redhat.com>

> ---
> CC: mst@redhat.com
> CC: jasowang@redhat.com
> CC: virtualization@lists.linux-foundation.org
> ---
>  drivers/net/virtio_net.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> index ebb98b796352..db05b5e930be 100644
> --- a/drivers/net/virtio_net.c
> +++ b/drivers/net/virtio_net.c
> @@ -3313,8 +3313,8 @@ static int virtnet_alloc_queues(struct virtnet_info *vi)
>  	INIT_DELAYED_WORK(&vi->refill, refill_work);
>  	for (i = 0; i < vi->max_queue_pairs; i++) {
>  		vi->rq[i].pages = NULL;
> -		netif_napi_add(vi->dev, &vi->rq[i].napi, virtnet_poll,
> -			       napi_weight);
> +		netif_napi_add_weight(vi->dev, &vi->rq[i].napi, virtnet_poll,
> +				      napi_weight);
>  		netif_napi_add_tx_weight(vi->dev, &vi->sq[i].napi,
>  					 virtnet_poll_tx,
>  					 napi_tx ? napi_weight : 0);
> -- 
> 2.34.1

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
