Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 94206CDB465
	for <virtualization@archiver.kernel.org>; Thu, 19 Oct 2023 06:51:14 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 1719F6FAD5;
	Thu, 19 Oct 2023 06:51:14 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 1719F6FAD5
Authentication-Results: smtp3.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=Sy94CrEI
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id d3Wp6Ew4wclg; Thu, 19 Oct 2023 06:51:13 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 5AB246FAAA;
	Thu, 19 Oct 2023 06:51:12 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 5AB246FAAA
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 2EA77C0071;
	Thu, 19 Oct 2023 06:51:12 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id E36A5C0032
 for <virtualization@lists.linux-foundation.org>;
 Thu, 19 Oct 2023 06:51:10 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id C570941AD0
 for <virtualization@lists.linux-foundation.org>;
 Thu, 19 Oct 2023 06:51:10 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org C570941AD0
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=Sy94CrEI
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id WwfFuKJ2ujJq
 for <virtualization@lists.linux-foundation.org>;
 Thu, 19 Oct 2023 06:51:09 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 68AAD400A6
 for <virtualization@lists.linux-foundation.org>;
 Thu, 19 Oct 2023 06:51:09 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 68AAD400A6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1697698268;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=WEnrn0oV2Zsvlmyy6Kx8GPygHPPH0bROxtOVsMDmwjg=;
 b=Sy94CrEIinisPFKjrafMpEkWSPuyYia6StwmdOvqotIkpKKqmr/GEW8JmBCu5myysbTZoQ
 Ouc0qm1euQ1nYqh14s0PFCowA186pjyMLVrbboGl3swn5ppoCBDXRkFS5PN1/KGJLy/Qx7
 bbEJSQHbVt3Y6W9SmP1Zl8QjskME2jg=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-654-i1QgnGWFO1ei1z_PhiwUWw-1; Thu, 19 Oct 2023 02:51:01 -0400
X-MC-Unique: i1QgnGWFO1ei1z_PhiwUWw-1
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-32cef5f8af5so210159f8f.1
 for <virtualization@lists.linux-foundation.org>;
 Wed, 18 Oct 2023 23:51:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697698260; x=1698303060;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=WEnrn0oV2Zsvlmyy6Kx8GPygHPPH0bROxtOVsMDmwjg=;
 b=pLVlwFCyIXbw4xhgscXgcsvUk+jpLi35/lGyzzNh7gdA+4+9gsolVK1Wxm/JsVFSzh
 cjTjPamYuy8rLdo/lny9gm0OfddCMtCUwEyPz8AzQlcGacLVSNvqF4chztNAKgpQtqgP
 g1XfCSXg4qrnjS2rea934ZOhMSCf0RPENr/WyAUUI5LxkUMenCrswR7d39L2f3sCRIsp
 uwumyne/JK9DSfKEkGfmeQqqgwgYelicVD11g8CLBEHH1Tgb6mlombbbKptjjega5H+M
 7didHi4Dt2nt33Bl/2Rc+Uxjo5jstSu9YZJCMon/hb1bbCRTPqn2uXLoTXUORUK/ZO/X
 Bxwg==
X-Gm-Message-State: AOJu0Yzvt37ez29CSTI12rGn/2o684Mr3Eg25rMI6yUzu759VizZ6Qam
 bUyU52bJTR4PUgoLjTJqKqAR7MANPZ+1sUOMXfLwIYIY7XDAnZabdlpc4lpd7+W/5E5cjgHCNJM
 YcYgLDrpdGW5yR6ZRoAPAWWkbtn+3HOovPZPm0lcSlA==
X-Received: by 2002:adf:f708:0:b0:32d:92fc:a625 with SMTP id
 r8-20020adff708000000b0032d92fca625mr709236wrp.24.1697698260329; 
 Wed, 18 Oct 2023 23:51:00 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFGnG71+12AtFbFPJ0v+GF3aUd2jS7Op38XasD08AHZ1VXQ1FZbBAoYs9PiJNB0CFcKbUhqtQ==
X-Received: by 2002:adf:f708:0:b0:32d:92fc:a625 with SMTP id
 r8-20020adff708000000b0032d92fca625mr709224wrp.24.1697698259978; 
 Wed, 18 Oct 2023 23:50:59 -0700 (PDT)
Received: from redhat.com ([2a02:14f:1f2:2037:f34:d61b:7da0:a7be])
 by smtp.gmail.com with ESMTPSA id
 i7-20020adffc07000000b0032d8354fb43sm3765069wrr.76.2023.10.18.23.50.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Oct 2023 23:50:59 -0700 (PDT)
Date: Thu, 19 Oct 2023 02:50:56 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Subject: Re: [PATCH vhost] virtio-ring: split: update avali idx lazily
Message-ID: <20231019023909-mutt-send-email-mst@kernel.org>
References: <20231019063533.99684-1-xuanzhuo@linux.alibaba.com>
MIME-Version: 1.0
In-Reply-To: <20231019063533.99684-1-xuanzhuo@linux.alibaba.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: virtualization@lists.linux-foundation.org
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

On Thu, Oct 19, 2023 at 02:35:33PM +0800, Xuan Zhuo wrote:
> If the vhost-user device is in busy-polling mode, the cachelines of
> avali ring

avail

same in subject

> are raced by the driver process and the vhost-user process.
> Because that the idx will be updated everytime, when the new ring items
> are updated. So one cache line will be read too times, the two processes
> will race the cache line. So I change the way the idx is updated, we
> only update the idx before notifying the device.
> test command:
>     This is the command, that testpmd runs with virtio-net AF_XDP.
> 
>     ./build/app/dpdk-testpmd -l 1-2 --no-pci --main-lcore=2 \
>             --vdev net_af_xdp0,iface=ens5,queue_count=1,busy_budget=0 \
>             --log-level=pmd.net.af_xdp:8 \
>             -- -i -a --nb-cores=1 --rxq=1 --txq=1 --forward-mode=macswap
> 
> without this commit:
>     testpmd> show port stats all
> 
>       ######################## NIC statistics for port 0  ########################
>       RX-packets: 3615824336 RX-missed: 0          RX-bytes:  202486162816
>       RX-errors: 0
>       RX-nombuf:  0
>       TX-packets: 3615795592 TX-errors: 20738      TX-bytes:  202484553152
> 
>       Throughput (since last show)
>       Rx-pps:      3790446          Rx-bps:   1698120056
>       Tx-pps:      3790446          Tx-bps:   1698120056
>       ############################################################################
> 
> with this commit:
>     testpmd> show port stats all
> 
>       ######################## NIC statistics for port 0  ########################
>       RX-packets: 68152727   RX-missed: 0          RX-bytes:  3816552712
>       RX-errors: 0
>       RX-nombuf:  0
>       TX-packets: 68114967   TX-errors: 33216      TX-bytes:  3814438152
> 
>       Throughput (since last show)
>       Rx-pps:      6333196          Rx-bps:   2837272088
>       Tx-pps:      6333227          Tx-bps:   2837285936
>       ############################################################################
> 
> perf c2c:
> 
>     On the vhost-user side, the perf c2c show 34.25% Hitm of the first cache
>     line of the avail structure without this commit. The hitm reduces to
>     1.57% when this commit is included.
> 
> dpdk:
> 
>     I read the code of the dpdk, there is the similar code.
> 
>     virtio_xmit_pkts(void *tx_queue, struct rte_mbuf **tx_pkts, uint16_t nb_pkts)
>     {
>     	[...]
> 
>     	for (nb_tx = 0; nb_tx < nb_pkts; nb_tx++) {
> 
>     		[...]
> 
>     		/* Enqueue Packet buffers */
>     		virtqueue_enqueue_xmit(txvq, txm, slots, use_indirect,
>     			can_push, 0);
>     	}
> 
>     	[...]
> 
>     	if (likely(nb_tx)) {
>     -->		vq_update_avail_idx(vq);
> 
>     		if (unlikely(virtqueue_kick_prepare(vq))) {
>     			virtqueue_notify(vq);
>     			PMD_TX_LOG(DEBUG, "Notified backend after xmit");
>     		}
>     	}
>     }
> 
> End:
> 
>     Is all the _prepared() is called before _notify()?
>     I checked, all the _notify() is called after the _prepare().
> 
> Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>


I am concerned that this seems very aggressive and might cause more kicks
if vhost-user is not in polling more or if it's not vhost-user
at all.

Please test a bunch more configs.

Some ideas if I'm right:
	- update avail index anyway after we added X descriptors
	- if we detect that we had to kick, reset X aggressively to 0
	  then grow it gradually (not sure when though?)
	  





> ---
>  drivers/virtio/virtio_ring.c | 15 ++++++++++-----
>  1 file changed, 10 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
> index 51d8f3299c10..215a38065d22 100644
> --- a/drivers/virtio/virtio_ring.c
> +++ b/drivers/virtio/virtio_ring.c
> @@ -687,12 +687,7 @@ static inline int virtqueue_add_split(struct virtqueue *_vq,
>  	avail = vq->split.avail_idx_shadow & (vq->split.vring.num - 1);
>  	vq->split.vring.avail->ring[avail] = cpu_to_virtio16(_vq->vdev, head);
>  
> -	/* Descriptors and available array need to be set before we expose the
> -	 * new available array entries. */
> -	virtio_wmb(vq->weak_barriers);
>  	vq->split.avail_idx_shadow++;
> -	vq->split.vring.avail->idx = cpu_to_virtio16(_vq->vdev,
> -						vq->split.avail_idx_shadow);
>  	vq->num_added++;
>  
>  	pr_debug("Added buffer head %i to %p\n", head, vq);
> @@ -738,6 +733,14 @@ static bool virtqueue_kick_prepare_split(struct virtqueue *_vq)
>  	bool needs_kick;
>  
>  	START_USE(vq);
> +
> +	/* Descriptors and available array need to be set before we expose the
> +	 * new available array entries.
> +	 */
> +	virtio_wmb(vq->weak_barriers);
> +	vq->split.vring.avail->idx = cpu_to_virtio16(_vq->vdev,
> +						vq->split.avail_idx_shadow);
> +
>  	/* We need to expose available array entries before checking avail
>  	 * event. */
>  	virtio_mb(vq->weak_barriers);
> @@ -2355,6 +2358,8 @@ EXPORT_SYMBOL_GPL(virtqueue_kick_prepare);
>   * virtqueue_notify - second half of split virtqueue_kick call.
>   * @_vq: the struct virtqueue
>   *
> + * The caller MUST call virtqueue_kick_prepare() firstly.
> + *

first

>   * This does not need to be serialized.
>   *
>   * Returns false if host notify failed or queue is broken, otherwise true.
> -- 
> 2.32.0.3.g01195cf9f

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
