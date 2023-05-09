Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A161BC77B7C
	for <virtualization@archiver.kernel.org>; Tue,  9 May 2023 04:43:00 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 8436641F46;
	Tue,  9 May 2023 04:42:59 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 8436641F46
Authentication-Results: smtp4.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=RLbafM62
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 6vo4TtXjavaO; Tue,  9 May 2023 04:42:57 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 9C03141E69;
	Tue,  9 May 2023 04:42:56 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 9C03141E69
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 4DAEBC0036;
	Tue,  9 May 2023 04:42:56 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 64222C002A
 for <virtualization@lists.linux-foundation.org>;
 Tue,  9 May 2023 04:42:55 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 2C3DE41D4D
 for <virtualization@lists.linux-foundation.org>;
 Tue,  9 May 2023 04:42:55 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 2C3DE41D4D
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=RLbafM62
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 8mxZluMGeO_1
 for <virtualization@lists.linux-foundation.org>;
 Tue,  9 May 2023 04:42:53 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 48C13403AA
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 48C13403AA
 for <virtualization@lists.linux-foundation.org>;
 Tue,  9 May 2023 04:42:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1683607371;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=W7lkveXXMx28z2hQQkgi6XifNwekRx4w5U94EsCpzfo=;
 b=RLbafM62OckbkZ2sQxijDifkWh6JlIEU12aMwnVK8yauG/4Hs2HjBNXFLw/f4T//S9kkLW
 yAZLr3GzMbGR6Kt6bkJzTrTd3mlPIumY+6yUpGtjI5wS4f8vEpcTVQXGzN+0+JMYx2isTS
 r7kM5f6JunsMRS0HyX7yYABgGtmxTNY=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-175-P-yv56iTMBe0_O47sgn_jg-1; Tue, 09 May 2023 00:42:48 -0400
X-MC-Unique: P-yv56iTMBe0_O47sgn_jg-1
Received: by mail-qk1-f198.google.com with SMTP id
 af79cd13be357-7577727a00eso744713685a.1
 for <virtualization@lists.linux-foundation.org>;
 Mon, 08 May 2023 21:42:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1683607368; x=1686199368;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=W7lkveXXMx28z2hQQkgi6XifNwekRx4w5U94EsCpzfo=;
 b=WaPa0Qz3O8PGaliNBrKhVq7GR+Mr+4/sJxdAxIqfkMVxGYNYxUokQBr6t5EJFiLYUj
 I3mEf1yh5R7CYdMeI7Q5nMU/L4MzlGzH9xrI//jHm3hTmfTp6EdUKhm4t9+elZFWCoDy
 VA1mpQhdZ/CdpWhwuyNlTADRVcaiTenaaOvDmcQ3iFVkxjL0V+AfK5a0dUn0NsT8Qqag
 stUdT0G80cV8F5wAyODfZnfDiSKNWq/pmmmrrRRbymyttW8iSJ4OSz7lJGKQE7GMR3FZ
 hUJLBaI+YK1MUPj1t3XRhxX2ccPAu61c3B37uRcux1M5COVdqC+DbwdK55jDVUDnXPG+
 TjSg==
X-Gm-Message-State: AC+VfDx9JcWIjyd0j3qMiESr3tOZIR1m2rLVbrp6QMlwIH3PtqAPMaev
 BneK/FI7fEgNIgqCpTeN+McF18WhPRZW+QqjApkkSv7Enn5Zl8+j4Lyll1w9vvsF542Oc+7l50W
 O/azedBVYF/Tbw86pRDWwdLdHqrNULVy1s5sGrnLjpA==
X-Received: by 2002:a05:6214:408:b0:5dd:b986:b44 with SMTP id
 z8-20020a056214040800b005ddb9860b44mr22544258qvx.6.1683607368246; 
 Mon, 08 May 2023 21:42:48 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ6j3iab8C9dTm3YoE+9qDG5jkVMfm91YDSkfYW2q1isW0mgFLBflIC9pEd53x+/Sn1pYDGxFw==
X-Received: by 2002:a05:6214:408:b0:5dd:b986:b44 with SMTP id
 z8-20020a056214040800b005ddb9860b44mr22544245qvx.6.1683607367963; 
 Mon, 08 May 2023 21:42:47 -0700 (PDT)
Received: from redhat.com ([185.187.243.118]) by smtp.gmail.com with ESMTPSA id
 r3-20020a0ce283000000b005dd8b9345aesm492559qvl.70.2023.05.08.21.42.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 08 May 2023 21:42:47 -0700 (PDT)
Date: Tue, 9 May 2023 00:42:39 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Feng Liu <feliu@nvidia.com>
Subject: Re: [PATCH net v4] virtio_net: Fix error unwinding of XDP
 initialization
Message-ID: <20230509004010-mutt-send-email-mst@kernel.org>
References: <20230508222708.68281-1-feliu@nvidia.com>
MIME-Version: 1.0
In-Reply-To: <20230508222708.68281-1-feliu@nvidia.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: Xuan Zhuo <xuanzhuo@linux.alibaba.com>, netdev@vger.kernel.org,
 Jiri Pirko <jiri@nvidia.com>, linux-kernel@vger.kernel.org,
 virtualization@lists.linux-foundation.org,
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

On Mon, May 08, 2023 at 06:27:08PM -0400, Feng Liu wrote:
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
> ---
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
>  drivers/net/virtio_net.c | 58 ++++++++++++++++++++++++++++------------
>  1 file changed, 41 insertions(+), 17 deletions(-)
> 
> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> index 8d8038538fc4..df7c08048fa7 100644
> --- a/drivers/net/virtio_net.c
> +++ b/drivers/net/virtio_net.c
> @@ -1868,6 +1868,38 @@ static int virtnet_poll(struct napi_struct *napi, int budget)
>  	return received;
>  }
>  
> +static void virtnet_disable_qp(struct virtnet_info *vi, int qp_index)


I am guessing _qp stands for queue pair? Let's call it
virtnet_disable_queue_pair please, consistently with max_queue_pairs.

> +{
> +	virtnet_napi_tx_disable(&vi->sq[qp_index].napi);
> +	napi_disable(&vi->rq[qp_index].napi);
> +	xdp_rxq_info_unreg(&vi->rq[qp_index].xdp_rxq);
> +}
> +
> +static int virtnet_enable_qp(struct virtnet_info *vi, int qp_index)

Similarly, virtnet_enable_queue_pair

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
> @@ -1881,22 +1913,17 @@ static int virtnet_open(struct net_device *dev)
>  			if (!try_fill_recv(vi, &vi->rq[i], GFP_KERNEL))
>  				schedule_delayed_work(&vi->refill, 0);
>  
> -		err = xdp_rxq_info_reg(&vi->rq[i].xdp_rxq, dev, i, vi->rq[i].napi.napi_id);
> +		err = virtnet_enable_qp(vi, i);
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
> +	for (i--; i >= 0; i--)
> +		virtnet_disable_qp(vi, i);
> +	return err;
>  }
>  
>  static int virtnet_poll_tx(struct napi_struct *napi, int budget)
> @@ -2305,11 +2332,8 @@ static int virtnet_close(struct net_device *dev)
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
