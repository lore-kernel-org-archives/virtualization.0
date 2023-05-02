Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 436B0C77B78
	for <virtualization@archiver.kernel.org>; Tue,  2 May 2023 18:35:04 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id C609F415B9;
	Tue,  2 May 2023 18:35:03 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org C609F415B9
Authentication-Results: smtp4.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=JCg9RcGS
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id TrcNPyGR95kc; Tue,  2 May 2023 18:35:02 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 0120041548;
	Tue,  2 May 2023 18:35:02 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 0120041548
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id C1EC4C007C;
	Tue,  2 May 2023 18:35:01 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 2AA8CC002A
 for <virtualization@lists.linux-foundation.org>;
 Tue,  2 May 2023 18:35:00 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id C274441DD5
 for <virtualization@lists.linux-foundation.org>;
 Tue,  2 May 2023 18:32:57 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org C274441DD5
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id KZn1num4NoVK
 for <virtualization@lists.linux-foundation.org>;
 Tue,  2 May 2023 18:32:56 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 6616741E1A
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 6616741E1A
 for <virtualization@lists.linux-foundation.org>;
 Tue,  2 May 2023 18:32:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1683052375;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=NhpWzKFV6WuY3k3TP6SkZOGPmg0MohvKMd0v7Ellcl4=;
 b=JCg9RcGSxA4TMuaMiyKxJxrLvtGLm03qcFq7gTwqX7X69Rs2XCC8SNOUvxVf8+O8ZP1SuP
 PGq+9z/dcsK5KaaJHXkItf/l5+/duVby9lloVpvuUc6DxEDimPTGfwzAyAUYu2vL2rwH0U
 Kn8RRfVKhRdf37WIBUKoZ/Dzi1/AgOE=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-96-TAHKp6c5MQ2CpzmxpZCbPA-1; Tue, 02 May 2023 14:32:53 -0400
X-MC-Unique: TAHKp6c5MQ2CpzmxpZCbPA-1
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-306362a1607so876064f8f.1
 for <virtualization@lists.linux-foundation.org>;
 Tue, 02 May 2023 11:32:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1683052372; x=1685644372;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=NhpWzKFV6WuY3k3TP6SkZOGPmg0MohvKMd0v7Ellcl4=;
 b=gAiNk2/V3tQYA2tVTDti+2fz+GSjg0AaCYSqaSYZrdstGoMbuU6G5OyuYjLmB7br1B
 MrtWH1CN92nr+x09AWsiVkQOa8x6nAZW8fjuCai2/nVLzBNizC4nVQFHFBnlBKu4qMeu
 e2OWQniLCFMboDlQZ8QeHJo0krWSXeBBXOZJWhgTFYwEP/G4+0liYjVYUncteRtsQTC3
 +/Q4U/HxGpIKGRrmQP0J3l0f87KITyKIYdjENOnsa6azU/SCZC+zgAVAfkbF2Ihi3Obs
 GIyJpCEGSNrpvXX9hllLpr2nzWagnScXyXueC9jmVE0v0U8KJc4ehWWqPDlibHcinvEy
 OT3w==
X-Gm-Message-State: AC+VfDw4GgjSqNL2kdDmNeBEdUqDiXfnyu8b1g+c2QQjSs2k0JzLJXiy
 KMHj5s+GyDsDLuvXiLYaBTxHVvQZi51kVvFIWN7ViUpI3TfiMs+MmMMrI7tZHwCSr+g5Lh//zXs
 2H4s3gJZ/paFqelSEYZBUbF0BTxXDHa8oeHK7AyMa1g==
X-Received: by 2002:adf:e38b:0:b0:2dc:cad4:87b9 with SMTP id
 e11-20020adfe38b000000b002dccad487b9mr11784985wrm.68.1683052372745; 
 Tue, 02 May 2023 11:32:52 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ7NTwwDePG2g45V+TgxsNxz1VA7838wfE2TMtMS4WPnQUULqKPl7ToB/3+9718Vn306lnc9dA==
X-Received: by 2002:adf:e38b:0:b0:2dc:cad4:87b9 with SMTP id
 e11-20020adfe38b000000b002dccad487b9mr11784980wrm.68.1683052372419; 
 Tue, 02 May 2023 11:32:52 -0700 (PDT)
Received: from redhat.com ([2.52.10.43]) by smtp.gmail.com with ESMTPSA id
 i11-20020adfe48b000000b002c3f81c51b6sm31546095wrm.90.2023.05.02.11.32.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 02 May 2023 11:32:51 -0700 (PDT)
Date: Tue, 2 May 2023 14:32:48 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Feng Liu <feliu@nvidia.com>
Subject: Re: [PATCH net v2] virtio_net: Fix error unwinding of XDP
 initialization
Message-ID: <20230502143148-mutt-send-email-mst@kernel.org>
References: <20230502174134.32276-1-feliu@nvidia.com>
MIME-Version: 1.0
In-Reply-To: <20230502174134.32276-1-feliu@nvidia.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: Xuan Zhuo <xuanzhuo@linux.alibaba.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org,
 Simon Horman <simon.horman@corigine.com>, William Tu <witu@nvidia.com>,
 bpf@vger.kernel.org
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

On Tue, May 02, 2023 at 01:41:34PM -0400, Feng Liu wrote:
> When initializing XDP in virtnet_open(), some rq xdp initialization
> may hit an error causing net device open failed. However, previous
> rqs have already initialized XDP and enabled NAPI, which is not the
> expected behavior. Need to roll back the previous rq initialization
> to avoid leaks in error unwinding of init code.
> 
> Also extract a helper function of disable queue pairs, and use newly
> introduced helper function in error unwinding and virtnet_close;
> 
> Fixes: 754b8a21a96d ("virtio_net: setup xdp_rxq_info")
> Signed-off-by: Feng Liu <feliu@nvidia.com>
> Reviewed-by: William Tu <witu@nvidia.com>
> Reviewed-by: Parav Pandit <parav@nvidia.com>
> Reviewed-by: Simon Horman <simon.horman@corigine.com>
> Acked-by: Michael S. Tsirkin <mst@redhat.com>
> ---
>  drivers/net/virtio_net.c | 31 +++++++++++++++++++++----------
>  1 file changed, 21 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> index 8d8038538fc4..5cd78e154d14 100644
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

btw we don't really need this comment - it's how all
error handling is done anyways.
if you need to roll v3, you can drop it.

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
> @@ -2305,11 +2319,8 @@ static int virtnet_close(struct net_device *dev)
>  	/* Make sure refill_work doesn't re-enable napi! */
>  	cancel_delayed_work_sync(&vi->refill);
>  
> -	for (i = 0; i < vi->max_queue_pairs; i++) {
> -		virtnet_napi_tx_disable(&vi->sq[i].napi);
> -		napi_disable(&vi->rq[i].napi);
> -		xdp_rxq_info_unreg(&vi->rq[i].xdp_rxq);
> -	}
> +	for (i = 0; i < vi->max_queue_pairs; i++)
> +		virtnet_disable_qp(vi, i);
>  
>  	return 0;
>  }
> -- 
> 2.37.1 (Apple Git-137.1)

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
