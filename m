Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DE71AC61DA4
	for <virtualization@archiver.kernel.org>; Fri,  3 Feb 2023 08:48:49 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 5CB2741C87;
	Fri,  3 Feb 2023 08:48:49 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 5CB2741C87
Authentication-Results: smtp4.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=BgEsteXr
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id dt6C8VilVxGV; Fri,  3 Feb 2023 08:48:47 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 3B9D341C53;
	Fri,  3 Feb 2023 08:48:47 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 3B9D341C53
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 12176C0032;
	Fri,  3 Feb 2023 08:48:47 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id A4C49C002B
 for <virtualization@lists.linux-foundation.org>;
 Fri,  3 Feb 2023 08:48:45 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 72A6241C87
 for <virtualization@lists.linux-foundation.org>;
 Fri,  3 Feb 2023 08:48:45 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 72A6241C87
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 6DuVpo2H_kzU
 for <virtualization@lists.linux-foundation.org>;
 Fri,  3 Feb 2023 08:48:44 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 16A3941C53
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 16A3941C53
 for <virtualization@lists.linux-foundation.org>;
 Fri,  3 Feb 2023 08:48:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1675414122;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ZAKc94Ixe1rZj/Kzn4+Ft2huDa+LD1uWLCdlu0GoQEk=;
 b=BgEsteXrejCfXPjDci4JrRObcvUonNccVupIGNF6PxolEsw18ZwCMaGfbIiezRXHP9hP/k
 Kr+TkTJR1rTiz6xh0wdCs+7GpshlZuOVjGOyokYOBSVUvfQvEqi7Et//LOGiedIMSDyxDD
 Lt4hzvxpsOWD/yD81UAZTa1i8d1ZQ54=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-433-wneB7yCQPiSANOz3xMHSSQ-1; Fri, 03 Feb 2023 03:48:41 -0500
X-MC-Unique: wneB7yCQPiSANOz3xMHSSQ-1
Received: by mail-ed1-f72.google.com with SMTP id
 d21-20020aa7c1d5000000b004a6e1efa7d0so2897688edp.19
 for <virtualization@lists.linux-foundation.org>;
 Fri, 03 Feb 2023 00:48:41 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ZAKc94Ixe1rZj/Kzn4+Ft2huDa+LD1uWLCdlu0GoQEk=;
 b=lpfhd2HYT55e/YkMjJ8G81CYwUMQDEP+Fdvk9IbXxErq1RaZKVUpZ/nt4s0xdV80+q
 tZZxHau2i+Lp8ywN2H60FhiragXQNCND6Sjh4hZGEySAQUBu8S+vutXMbsVvHfl+gSj7
 WB67g3AxfQUXqufFRAz5YmlNUbinbceRZK+57eGz0Gz+a+8YJ0SzkpMuwy55kzcAZpyA
 SeRP1jL6xgz5JAEzeQNs+4lQ1KkWaM00ZwDdtnbjiEPA48PhGsmLsoJeRvwSexzW9lJG
 yAk4PhZXZLJtsqR9UsylV8wQOairSPUXnznv3d5elyBp6ZL1NaG0Pn8Tzf31HBW98ax/
 Ebng==
X-Gm-Message-State: AO0yUKX/+u+KrSpH8PwR/2TxIR4CFHrTrQEedhsK6eoUQsWjBD3kCWRm
 m1oW83LcX6+TIeTlW+GPTI0JYk/uou87v31muzhUfqChnarMukVu6+kBENk1whFRof2GbTBYniq
 QcDZhEggnUsnoPUflcxRIFdtHx6jZ2nyQXnpgb5vb9g==
X-Received: by 2002:a17:907:6087:b0:887:5f45:d688 with SMTP id
 ht7-20020a170907608700b008875f45d688mr9561678ejc.41.1675414118819; 
 Fri, 03 Feb 2023 00:48:38 -0800 (PST)
X-Google-Smtp-Source: AK7set89lm9S151OquZnuoyt8nL85dYjqpw2IBo88NRgrkXAApp4gVR7Yo3jPOqbvdp2IEZXVkmbZQ==
X-Received: by 2002:a17:907:6087:b0:887:5f45:d688 with SMTP id
 ht7-20020a170907608700b008875f45d688mr9561666ejc.41.1675414118604; 
 Fri, 03 Feb 2023 00:48:38 -0800 (PST)
Received: from redhat.com ([2.52.156.122]) by smtp.gmail.com with ESMTPSA id
 n24-20020a170906841800b00889310a3fcbsm1035683ejx.210.2023.02.03.00.48.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 03 Feb 2023 00:48:37 -0800 (PST)
Date: Fri, 3 Feb 2023 03:48:33 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Subject: Re: [PATCH 20/33] virtio_net: xsk: introduce
 virtnet_rq_bind_xsk_pool()
Message-ID: <20230203034642-mutt-send-email-mst@kernel.org>
References: <20230202110058.130695-1-xuanzhuo@linux.alibaba.com>
 <20230202110058.130695-21-xuanzhuo@linux.alibaba.com>
MIME-Version: 1.0
In-Reply-To: <20230202110058.130695-21-xuanzhuo@linux.alibaba.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: Petr Machata <petrm@nvidia.com>, Menglong Dong <imagedong@tencent.com>,
 Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
 Jesper Dangaard Brouer <hawk@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, netdev@vger.kernel.org,
 John Fastabend <john.fastabend@gmail.com>,
 =?iso-8859-1?Q?Bj=F6rn_T=F6pel?= <bjorn@kernel.org>,
 Alexei Starovoitov <ast@kernel.org>, Eric Dumazet <edumazet@google.com>,
 Kuniyuki Iwashima <kuniyu@amazon.com>,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 Jonathan Lemon <jonathan.lemon@gmail.com>, Jakub Kicinski <kuba@kernel.org>,
 bpf@vger.kernel.org, Paolo Abeni <pabeni@redhat.com>,
 virtualization@lists.linux-foundation.org,
 "David S. Miller" <davem@davemloft.net>,
 Magnus Karlsson <magnus.karlsson@intel.com>
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

On Thu, Feb 02, 2023 at 07:00:45PM +0800, Xuan Zhuo wrote:
> This function is used to bind or unbind xsk pool to virtnet rq.
> 
> Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> ---
>  drivers/net/virtio/Makefile     |  2 +-
>  drivers/net/virtio/main.c       |  8 ++---
>  drivers/net/virtio/virtio_net.h | 16 ++++++++++
>  drivers/net/virtio/xsk.c        | 56 +++++++++++++++++++++++++++++++++
>  4 files changed, 76 insertions(+), 6 deletions(-)
>  create mode 100644 drivers/net/virtio/xsk.c
> 
> diff --git a/drivers/net/virtio/Makefile b/drivers/net/virtio/Makefile
> index 15ed7c97fd4f..8c2a884d2dba 100644
> --- a/drivers/net/virtio/Makefile
> +++ b/drivers/net/virtio/Makefile
> @@ -5,4 +5,4 @@
>  
>  obj-$(CONFIG_VIRTIO_NET) += virtio_net.o
>  
> -virtio_net-y := main.o
> +virtio_net-y := main.o xsk.o
> diff --git a/drivers/net/virtio/main.c b/drivers/net/virtio/main.c
> index 049a3bb9d88d..0ee23468b795 100644
> --- a/drivers/net/virtio/main.c
> +++ b/drivers/net/virtio/main.c
> @@ -110,7 +110,6 @@ struct padded_vnet_hdr {
>  	char padding[12];
>  };
>  
> -static void virtnet_rq_free_unused_buf(struct virtqueue *vq, void *buf);
>  static void virtnet_sq_free_unused_buf(struct virtqueue *vq, void *buf);
>  
>  static void *xdp_to_ptr(struct xdp_frame *ptr)
> @@ -1351,8 +1350,7 @@ static int add_recvbuf_mergeable(struct virtnet_info *vi,
>   * before we're receiving packets, or from refill_work which is
>   * careful to disable receiving (using napi_disable).
>   */
> -static bool try_fill_recv(struct virtnet_info *vi, struct receive_queue *rq,
> -			  gfp_t gfp)
> +bool try_fill_recv(struct virtnet_info *vi, struct receive_queue *rq, gfp_t gfp)
>  {
>  	int err;
>  	bool oom;
> @@ -1388,7 +1386,7 @@ static void skb_recv_done(struct virtqueue *rvq)
>  	virtqueue_napi_schedule(&rq->napi, rvq);
>  }
>  
> -static void virtnet_napi_enable(struct virtqueue *vq, struct napi_struct *napi)
> +void virtnet_napi_enable(struct virtqueue *vq, struct napi_struct *napi)
>  {
>  	napi_enable(napi);
>  
> @@ -3284,7 +3282,7 @@ static void virtnet_sq_free_unused_buf(struct virtqueue *vq, void *buf)
>  		xdp_return_frame(ptr_to_xdp(buf));
>  }
>  
> -static void virtnet_rq_free_unused_buf(struct virtqueue *vq, void *buf)
> +void virtnet_rq_free_unused_buf(struct virtqueue *vq, void *buf)

If you are making this an API now you better document
what it does. Same applies to other stuff you are
making non-static.


>  {
>  	struct virtnet_info *vi = vq->vdev->priv;
>  	int i = vq2rxq(vq);
> diff --git a/drivers/net/virtio/virtio_net.h b/drivers/net/virtio/virtio_net.h
> index b46f083a630a..4a7633714802 100644
> --- a/drivers/net/virtio/virtio_net.h
> +++ b/drivers/net/virtio/virtio_net.h
> @@ -168,6 +168,12 @@ struct send_queue {
>  
>  	/* Record whether sq is in reset state. */
>  	bool reset;
> +
> +	struct {
> +		struct xsk_buff_pool __rcu *pool;
> +
> +		dma_addr_t hdr_dma_address;
> +	} xsk;
>  };
>  
>  /* Internal representation of a receive virtqueue */
> @@ -200,6 +206,13 @@ struct receive_queue {
>  	char name[16];
>  
>  	struct xdp_rxq_info xdp_rxq;
> +
> +	struct {
> +		struct xsk_buff_pool __rcu *pool;
> +
> +		/* xdp rxq used by xsk */
> +		struct xdp_rxq_info xdp_rxq;
> +	} xsk;
>  };
>  
>  static inline bool is_xdp_raw_buffer_queue(struct virtnet_info *vi, int q)
> @@ -274,4 +287,7 @@ int virtnet_xdp_handler(struct bpf_prog *xdp_prog, struct xdp_buff *xdp,
>  			unsigned int *xdp_xmit,
>  			struct virtnet_rq_stats *stats);
>  int virtnet_tx_reset(struct virtnet_info *vi, struct send_queue *sq);
> +bool try_fill_recv(struct virtnet_info *vi, struct receive_queue *rq, gfp_t gfp);
> +void virtnet_napi_enable(struct virtqueue *vq, struct napi_struct *napi);
> +void virtnet_rq_free_unused_buf(struct virtqueue *vq, void *buf);
>  #endif
> diff --git a/drivers/net/virtio/xsk.c b/drivers/net/virtio/xsk.c
> new file mode 100644
> index 000000000000..e01ff2abea11
> --- /dev/null
> +++ b/drivers/net/virtio/xsk.c
> @@ -0,0 +1,56 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/*
> + * virtio-net xsk
> + */
> +
> +#include "virtio_net.h"
> +
> +static int virtnet_rq_bind_xsk_pool(struct virtnet_info *vi, struct receive_queue *rq,
> +				    struct xsk_buff_pool *pool, struct net_device *dev)

This static function is unused after this patch, so compiler will
complain. Yes it's just a warning but still not nice.


> +{
> +	bool running = netif_running(vi->dev);
> +	int err, qindex;
> +
> +	qindex = rq - vi->rq;
> +
> +	if (pool) {
> +		err = xdp_rxq_info_reg(&rq->xsk.xdp_rxq, dev, qindex, rq->napi.napi_id);
> +		if (err < 0)
> +			return err;
> +
> +		err = xdp_rxq_info_reg_mem_model(&rq->xsk.xdp_rxq,
> +						 MEM_TYPE_XSK_BUFF_POOL, NULL);
> +		if (err < 0) {
> +			xdp_rxq_info_unreg(&rq->xsk.xdp_rxq);
> +			return err;
> +		}
> +
> +		xsk_pool_set_rxq_info(pool, &rq->xsk.xdp_rxq);
> +	} else {
> +		xdp_rxq_info_unreg(&rq->xsk.xdp_rxq);
> +	}
> +
> +	if (running)
> +		napi_disable(&rq->napi);
> +
> +	err = virtqueue_reset(rq->vq, virtnet_rq_free_unused_buf);
> +	if (err)
> +		netdev_err(vi->dev, "reset rx fail: rx queue index: %d err: %d\n", qindex, err);
> +
> +	if (pool) {
> +		if (err)
> +			xdp_rxq_info_unreg(&rq->xsk.xdp_rxq);
> +		else
> +			rcu_assign_pointer(rq->xsk.pool, pool);
> +	} else {
> +		rcu_assign_pointer(rq->xsk.pool, NULL);
> +	}
> +
> +	if (!try_fill_recv(vi, rq, GFP_KERNEL))
> +		schedule_delayed_work(&vi->refill, 0);
> +
> +	if (running)
> +		virtnet_napi_enable(rq->vq, &rq->napi);
> +
> +	return err;
> +}
> -- 
> 2.32.0.3.g01195cf9f

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
