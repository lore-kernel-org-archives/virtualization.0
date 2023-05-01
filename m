Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 611E5C77B7C
	for <virtualization@archiver.kernel.org>; Mon,  1 May 2023 14:15:28 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id EABB381E81;
	Mon,  1 May 2023 14:15:27 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org EABB381E81
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=Tc4n80UL
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id u6THwYZePhA3; Mon,  1 May 2023 14:15:27 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 5E0A381E13;
	Mon,  1 May 2023 14:15:26 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 5E0A381E13
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 09A0BC0037;
	Mon,  1 May 2023 14:15:26 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id B3287C002A
 for <virtualization@lists.linux-foundation.org>;
 Mon,  1 May 2023 14:15:24 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 815D260F04
 for <virtualization@lists.linux-foundation.org>;
 Mon,  1 May 2023 14:15:24 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 815D260F04
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=Tc4n80UL
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id YQUystekFqZV
 for <virtualization@lists.linux-foundation.org>;
 Mon,  1 May 2023 14:15:23 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 9B9B760B45
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 9B9B760B45
 for <virtualization@lists.linux-foundation.org>;
 Mon,  1 May 2023 14:15:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1682950522;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=RkzLjfDV3jDBH/5apcAJdC/NVfaw0NU9ehtudGGZu7o=;
 b=Tc4n80ULeL7rjeXKORyuuW9O9fuXVJCWqxCoNoe6JaCRU/WMdo5jKdhjRSrcKVdIfwS1J9
 Z/l5jvvGKwyFJuTdBcCAtBtcS0n78JYdYveYbcZWO5J4ggvvPVHCgbg2T4YCTQ5J0Uvv2k
 kni0WQjxE+qh4UvSToyuf7VaOxDcQP0=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-408-DWipLteHPk6aSN0p7SyIIw-1; Mon, 01 May 2023 10:15:00 -0400
X-MC-Unique: DWipLteHPk6aSN0p7SyIIw-1
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-2ff4bc7a6a3so1562804f8f.3
 for <virtualization@lists.linux-foundation.org>;
 Mon, 01 May 2023 07:14:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1682950484; x=1685542484;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=RkzLjfDV3jDBH/5apcAJdC/NVfaw0NU9ehtudGGZu7o=;
 b=Ig+g4IJKZPAsgZ7mNz2hlldJdmNsIm+QYMlXYaofJkwraf35OmnGX16bZqBi0Srg4b
 qpRcJdcz1uTQsQqs3ZuHHLOSjT1KiZSx/d9xmBaqY9mEPdQduH/eOsvU0LVVC59NbSO8
 wwLY8RboDqY4SEw1rtZSplk+srAxgkxA/K2I3JadYcZcZKbqTEIzwBLuJskwKaon5c9p
 qt8herJJNyxwYWpPsAYuw5wjSua1aSBXGSj7AtzefBrbnJLxHarKsjfNwmk1nbV6guNe
 STsKHfCvy+3l5hptmG0AMhqnCpgx9XbrSkbthbsbrXFrdlSMxwYVmipLL7yT5w7MaeVh
 XnWQ==
X-Gm-Message-State: AC+VfDx0/rZSn6AR5xkCVgdiF4LZkUK+FRKSbX1WIRYBeOX3vUVaVT6D
 0rjKjQtUq1vJjUOlchQGrU9lJz8FLujsYMMjv+oPimxZ2t7i2hIiNTujj1ZNGD1MNj2GyDNVFS0
 wNXSPn/M63k3J75vy6GxfoZHw39zgJh40UoZxCcFy+g==
X-Received: by 2002:a05:6000:509:b0:2fe:851c:672f with SMTP id
 a9-20020a056000050900b002fe851c672fmr9551048wrf.8.1682950484514; 
 Mon, 01 May 2023 07:14:44 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ7bj2HHSdD3I+NdpPeXH4HQFptQUC3elBpKv3Fi3+yFl4cDAKLhdolkyoIR/w5qExxaIYONDQ==
X-Received: by 2002:a05:6000:509:b0:2fe:851c:672f with SMTP id
 a9-20020a056000050900b002fe851c672fmr9551040wrf.8.1682950484267; 
 Mon, 01 May 2023 07:14:44 -0700 (PDT)
Received: from redhat.com ([31.210.184.46]) by smtp.gmail.com with ESMTPSA id
 z16-20020a5d4410000000b002f79ea6746asm28263967wrq.94.2023.05.01.07.14.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 01 May 2023 07:14:43 -0700 (PDT)
Date: Mon, 1 May 2023 10:14:40 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Feng Liu <feliu@nvidia.com>
Subject: Re: [PATCH net v1 1/2] virtio_net: Fix error unwinding of XDP
 initialization
Message-ID: <20230501101415-mutt-send-email-mst@kernel.org>
References: <20230428223712.67499-1-feliu@nvidia.com>
MIME-Version: 1.0
In-Reply-To: <20230428223712.67499-1-feliu@nvidia.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: Xuan Zhuo <xuanzhuo@linux.alibaba.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org,
 William Tu <witu@nvidia.com>, bpf@vger.kernel.org
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

On Fri, Apr 28, 2023 at 06:37:12PM -0400, Feng Liu wrote:
> When initializing XDP in virtnet_open(), some rq xdp initialization
> may hit an error causing net device open failed. However, previous
> rqs have already initialized XDP and enabled NAPI, which is not the
> expected behavior. Need to roll back the previous rq initialization
> to avoid leaks in error unwinding of init code.
> 
> Fixes: 754b8a21a96d ("virtio_net: setup xdp_rxq_info")
> Signed-off-by: Feng Liu <feliu@nvidia.com>
> Reviewed-by: William Tu <witu@nvidia.com>
> Reviewed-by: Parav Pandit <parav@nvidia.com>

Acked-by: Michael S. Tsirkin <mst@redhat.com>

Post with 2/2 in the same thread or better just squashed.

> ---
>  drivers/net/virtio_net.c | 24 +++++++++++++++++++-----
>  1 file changed, 19 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> index 8d8038538fc4..fc6ee833a09f 100644
> --- a/drivers/net/virtio_net.c
> +++ b/drivers/net/virtio_net.c
> @@ -1868,6 +1868,13 @@ static int virtnet_poll(struct napi_struct *napi, int budget)
>  	return received;
>  }
>  
> +static void virtnet_disable_qp(struct virtnet_info *vi, int qp_index)
> +{
> +	virtnet_napi_tx_disable(&vi->sq[qp_index].napi);
> +	napi_disable(&vi->rq[qp_index].napi);
> +	xdp_rxq_info_unreg(&vi->rq[qp_index].xdp_rxq);
> +}
> +
>  static int virtnet_open(struct net_device *dev)
>  {
>  	struct virtnet_info *vi = netdev_priv(dev);
> @@ -1883,20 +1890,27 @@ static int virtnet_open(struct net_device *dev)
>  
>  		err = xdp_rxq_info_reg(&vi->rq[i].xdp_rxq, dev, i, vi->rq[i].napi.napi_id);
>  		if (err < 0)
> -			return err;
> +			goto err_xdp_info_reg;
>  
>  		err = xdp_rxq_info_reg_mem_model(&vi->rq[i].xdp_rxq,
>  						 MEM_TYPE_PAGE_SHARED, NULL);
> -		if (err < 0) {
> -			xdp_rxq_info_unreg(&vi->rq[i].xdp_rxq);
> -			return err;
> -		}
> +		if (err < 0)
> +			goto err_xdp_reg_mem_model;
>  
>  		virtnet_napi_enable(vi->rq[i].vq, &vi->rq[i].napi);
>  		virtnet_napi_tx_enable(vi, vi->sq[i].vq, &vi->sq[i].napi);
>  	}
>  
>  	return 0;
> +
> +	/* error unwinding of xdp init */
> +err_xdp_reg_mem_model:
> +	xdp_rxq_info_unreg(&vi->rq[i].xdp_rxq);
> +err_xdp_info_reg:
> +	for (i = i - 1; i >= 0; i--)
> +		virtnet_disable_qp(vi, i);
> +
> +	return err;
>  }
>  
>  static int virtnet_poll_tx(struct napi_struct *napi, int budget)
> -- 
> 2.37.1 (Apple Git-137.1)

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
