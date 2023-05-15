Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 188D4C77B75
	for <virtualization@archiver.kernel.org>; Mon, 15 May 2023 04:46:01 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id A6EF6614DB;
	Mon, 15 May 2023 04:46:01 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org A6EF6614DB
Authentication-Results: smtp3.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=JHoQobCR
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id MnqzLuQ6LeCN; Mon, 15 May 2023 04:46:00 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 08C10614C7;
	Mon, 15 May 2023 04:46:00 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 08C10614C7
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id DA24BC0036;
	Mon, 15 May 2023 04:45:59 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id C1AA0C002A
 for <virtualization@lists.linux-foundation.org>;
 Mon, 15 May 2023 04:45:58 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 9B54341E05
 for <virtualization@lists.linux-foundation.org>;
 Mon, 15 May 2023 04:45:58 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 9B54341E05
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=JHoQobCR
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 1ObpqFhlWFTT
 for <virtualization@lists.linux-foundation.org>;
 Mon, 15 May 2023 04:45:57 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 82EE341E01
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 82EE341E01
 for <virtualization@lists.linux-foundation.org>;
 Mon, 15 May 2023 04:45:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1684125956;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ryX5sovAmXV6c1qawtyVZ+Us+777l7mLCNx8VtBdO6Q=;
 b=JHoQobCRcz+GtmHM2s7uPt7xiWzxaAp51Eag4HQcTiNKOzgDa3KjOKFW/IBMWUh7eKRC3I
 uHWv0tnagHpT3wpJXSNSdBZ4nPMu0egSITBtkQhXZhhHLuu3SyP5I91kd5+90BFVWuCu+S
 9zxc7DFlrXWqFSHSkJE9lYhpgFs0c/k=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-120-x9VjpjrkNT26C7Z1Eprewg-1; Mon, 15 May 2023 00:45:55 -0400
X-MC-Unique: x9VjpjrkNT26C7Z1Eprewg-1
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-3076fc5c278so7139907f8f.3
 for <virtualization@lists.linux-foundation.org>;
 Sun, 14 May 2023 21:45:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684125954; x=1686717954;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ryX5sovAmXV6c1qawtyVZ+Us+777l7mLCNx8VtBdO6Q=;
 b=aoH9AN6d10u0l/81obeu4YNoxYTTnAacRl86I55I25sIaYAwQ4kdgUfunbBgPceqkR
 OszSfw1hTOAq6v+C40ThfPfb+VU8p/AXuUSp3sCZh3MXDlhakFjvykPtIeUPCb9YS2zv
 QVxKn9YSYb7SpvrdaX6ZclfX22G8X1uAQNMGkI7kaUK/g3yvMWwNy6Mf25cYZiDHYJ4k
 /2hKSiun4A8UhMLP3AQ+l0AL7r3IQl6FxBBXV4+2u56dAKX1GOdmJzorLfq1BaUSRvkW
 R5hFoUBlgiDSj6Bwvz4+V2jkuWrniEulRFZyjnWKH1sOvDbOPMFMnKxg4TnqehsFzEbM
 hc9w==
X-Gm-Message-State: AC+VfDyAA2Z/Ow/LE7UQATfr3QLYe6omOvPtJhVXHL4AtwgLD0Z49C7v
 HAkaZ6of4pyuLBYaq3qeMyViE5TtpuShnN/F48CbU5yf5tiqagiJmUE4c0T96MRJHHSVZG5JveH
 q/fc8H0+s+LZ5QzruCkA0rvISpnYEcBMv6t0c+5PV1w==
X-Received: by 2002:a5d:6683:0:b0:301:2452:e4d with SMTP id
 l3-20020a5d6683000000b0030124520e4dmr23428615wru.46.1684125953903; 
 Sun, 14 May 2023 21:45:53 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ42y5Y36NSzazTv8MjmNVkJslp/Zk6xu1eJXmwaycyOF+fLj/EzxbUv7iCGkEDR/oCPfHIFIw==
X-Received: by 2002:a5d:6683:0:b0:301:2452:e4d with SMTP id
 l3-20020a5d6683000000b0030124520e4dmr23428600wru.46.1684125953545; 
 Sun, 14 May 2023 21:45:53 -0700 (PDT)
Received: from redhat.com ([2.52.146.3]) by smtp.gmail.com with ESMTPSA id
 o10-20020a1c750a000000b003f42bb3a5adsm17946718wmc.4.2023.05.14.21.45.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 14 May 2023 21:45:52 -0700 (PDT)
Date: Mon, 15 May 2023 00:45:49 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Feng Liu <feliu@nvidia.com>
Subject: Re: [PATCH net v6] virtio_net: Fix error unwinding of XDP
 initialization
Message-ID: <20230515004542-mutt-send-email-mst@kernel.org>
References: <20230512151812.1806-1-feliu@nvidia.com>
MIME-Version: 1.0
In-Reply-To: <20230512151812.1806-1-feliu@nvidia.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: Xuan Zhuo <xuanzhuo@linux.alibaba.com>, netdev@vger.kernel.org,
 Jiri Pirko <jiri@nvidia.com>, linux-kernel@vger.kernel.org,
 virtualization@lists.linux-foundation.org, William Tu <witu@nvidia.com>,
 Simon Horman <simon.horman@corigine.com>, Bodong Wang <bodong@nvidia.com>,
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

On Fri, May 12, 2023 at 11:18:12AM -0400, Feng Liu wrote:
> When initializing XDP in virtnet_open(), some rq xdp initialization
> may hit an error causing net device open failed. However, previous
> rqs have already initialized XDP and enabled NAPI, which is not the
> expected behavior. Need to roll back the previous rq initialization
> to avoid leaks in error unwinding of init code.
> 
> Also extract helper functions of disable and enable queue pairs.
> Use newly introduced disable helper function in error unwinding and
> virtnet_close. Use enable helper function in virtnet_open.
> 
> Fixes: 754b8a21a96d ("virtio_net: setup xdp_rxq_info")
> Signed-off-by: Feng Liu <feliu@nvidia.com>
> Reviewed-by: Jiri Pirko <jiri@nvidia.com>
> Reviewed-by: William Tu <witu@nvidia.com>

Acked-by: Michael S. Tsirkin <mst@redhat.com>

> ---
> v5 -> v6
> feedbacks from Xuan Zhuo
> - add disable_delayed_refill and cancel_delayed_work_sync
> 
> v4 -> v5
> feedbacks from Michael S. Tsirkin
> - rename helper as virtnet_disable_queue_pair
> - rename helper as virtnet_enable_queue_pair
> 
> v3 -> v4
> feedbacks from Jiri Pirko
> - Add symmetric helper function virtnet_enable_qp to enable queues.
> - Error handle:  cleanup current queue pair in virtnet_enable_qp,
>   and complete the reset queue pairs cleanup in virtnet_open.
> - Fix coding style.
> feedbacks from Parav Pandit
> - Remove redundant debug message and white space.
> 
> v2 -> v3
> feedbacks from Michael S. Tsirkin
> - Remove redundant comment.
> 
> v1 -> v2
> feedbacks from Michael S. Tsirkin
> - squash two patches together.
> 
> ---
>  drivers/net/virtio_net.c | 61 +++++++++++++++++++++++++++++-----------
>  1 file changed, 44 insertions(+), 17 deletions(-)
> 
> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> index a12ae26db0e2..56ca1d270304 100644
> --- a/drivers/net/virtio_net.c
> +++ b/drivers/net/virtio_net.c
> @@ -1868,6 +1868,38 @@ static int virtnet_poll(struct napi_struct *napi, int budget)
>  	return received;
>  }
>  
> +static void virtnet_disable_queue_pair(struct virtnet_info *vi, int qp_index)
> +{
> +	virtnet_napi_tx_disable(&vi->sq[qp_index].napi);
> +	napi_disable(&vi->rq[qp_index].napi);
> +	xdp_rxq_info_unreg(&vi->rq[qp_index].xdp_rxq);
> +}
> +
> +static int virtnet_enable_queue_pair(struct virtnet_info *vi, int qp_index)
> +{
> +	struct net_device *dev = vi->dev;
> +	int err;
> +
> +	err = xdp_rxq_info_reg(&vi->rq[qp_index].xdp_rxq, dev, qp_index,
> +			       vi->rq[qp_index].napi.napi_id);
> +	if (err < 0)
> +		return err;
> +
> +	err = xdp_rxq_info_reg_mem_model(&vi->rq[qp_index].xdp_rxq,
> +					 MEM_TYPE_PAGE_SHARED, NULL);
> +	if (err < 0)
> +		goto err_xdp_reg_mem_model;
> +
> +	virtnet_napi_enable(vi->rq[qp_index].vq, &vi->rq[qp_index].napi);
> +	virtnet_napi_tx_enable(vi, vi->sq[qp_index].vq, &vi->sq[qp_index].napi);
> +
> +	return 0;
> +
> +err_xdp_reg_mem_model:
> +	xdp_rxq_info_unreg(&vi->rq[qp_index].xdp_rxq);
> +	return err;
> +}
> +
>  static int virtnet_open(struct net_device *dev)
>  {
>  	struct virtnet_info *vi = netdev_priv(dev);
> @@ -1881,22 +1913,20 @@ static int virtnet_open(struct net_device *dev)
>  			if (!try_fill_recv(vi, &vi->rq[i], GFP_KERNEL))
>  				schedule_delayed_work(&vi->refill, 0);
>  
> -		err = xdp_rxq_info_reg(&vi->rq[i].xdp_rxq, dev, i, vi->rq[i].napi.napi_id);
> +		err = virtnet_enable_queue_pair(vi, i);
>  		if (err < 0)
> -			return err;
> -
> -		err = xdp_rxq_info_reg_mem_model(&vi->rq[i].xdp_rxq,
> -						 MEM_TYPE_PAGE_SHARED, NULL);
> -		if (err < 0) {
> -			xdp_rxq_info_unreg(&vi->rq[i].xdp_rxq);
> -			return err;
> -		}
> -
> -		virtnet_napi_enable(vi->rq[i].vq, &vi->rq[i].napi);
> -		virtnet_napi_tx_enable(vi, vi->sq[i].vq, &vi->sq[i].napi);
> +			goto err_enable_qp;
>  	}
>  
>  	return 0;
> +
> +err_enable_qp:
> +	disable_delayed_refill(vi);
> +	cancel_delayed_work_sync(&vi->refill);
> +
> +	for (i--; i >= 0; i--)
> +		virtnet_disable_queue_pair(vi, i);
> +	return err;
>  }
>  
>  static int virtnet_poll_tx(struct napi_struct *napi, int budget)
> @@ -2305,11 +2335,8 @@ static int virtnet_close(struct net_device *dev)
>  	/* Make sure refill_work doesn't re-enable napi! */
>  	cancel_delayed_work_sync(&vi->refill);
>  
> -	for (i = 0; i < vi->max_queue_pairs; i++) {
> -		virtnet_napi_tx_disable(&vi->sq[i].napi);
> -		napi_disable(&vi->rq[i].napi);
> -		xdp_rxq_info_unreg(&vi->rq[i].xdp_rxq);
> -	}
> +	for (i = 0; i < vi->max_queue_pairs; i++)
> +		virtnet_disable_queue_pair(vi, i);
>  
>  	return 0;
>  }
> -- 
> 2.37.1 (Apple Git-137.1)

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
