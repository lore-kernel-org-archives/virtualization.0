Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 30AF1C0015E
	for <virtualization@archiver.kernel.org>; Tue, 25 Jul 2023 11:10:32 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id B7652417D9;
	Tue, 25 Jul 2023 11:10:31 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org B7652417D9
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 6zMzyuj1uFRd; Tue, 25 Jul 2023 11:10:30 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 118CD416DC;
	Tue, 25 Jul 2023 11:10:30 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 118CD416DC
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id DB223C0071;
	Tue, 25 Jul 2023 11:10:29 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 4B959C0032
 for <virtualization@lists.linux-foundation.org>;
 Tue, 25 Jul 2023 11:10:28 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 23E2281F1B
 for <virtualization@lists.linux-foundation.org>;
 Tue, 25 Jul 2023 11:10:28 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 23E2281F1B
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id fS-b9rv8UTuH
 for <virtualization@lists.linux-foundation.org>;
 Tue, 25 Jul 2023 11:10:27 +0000 (UTC)
Received: from out30-99.freemail.mail.aliyun.com
 (out30-99.freemail.mail.aliyun.com [115.124.30.99])
 by smtp1.osuosl.org (Postfix) with ESMTPS id EACA781F19
 for <virtualization@lists.linux-foundation.org>;
 Tue, 25 Jul 2023 11:10:26 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org EACA781F19
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R341e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=ay29a033018046049;
 MF=xuanzhuo@linux.alibaba.com; NM=1; PH=DS; RN=8; SR=0;
 TI=SMTPD_---0VoCzvI0_1690283420; 
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com
 fp:SMTPD_---0VoCzvI0_1690283420) by smtp.aliyun-inc.com;
 Tue, 25 Jul 2023 19:10:21 +0800
Message-ID: <1690283405.6083395-2-xuanzhuo@linux.alibaba.com>
Subject: Re: [PATCH net] virtio-net: fix race between set queues and probe
Date: Tue, 25 Jul 2023 19:10:05 +0800
From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
To: Jason Wang <jasowang@redhat.com>
References: <20230725072049.617289-1-jasowang@redhat.com>
In-Reply-To: <20230725072049.617289-1-jasowang@redhat.com>
Cc: mst@redhat.com, netdev@vger.kernel.org,
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
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

On Tue, 25 Jul 2023 03:20:49 -0400, Jason Wang <jasowang@redhat.com> wrote:
> A race were found where set_channels could be called after registering
> but before virtnet_set_queues() in virtnet_probe(). Fixing this by
> moving the virtnet_set_queues() before netdevice registering. While at
> it, use _virtnet_set_queues() to avoid holding rtnl as the device is
> not even registered at that time.
>
> Fixes: a220871be66f ("virtio-net: correctly enable multiqueue")
> Signed-off-by: Jason Wang <jasowang@redhat.com>

Reviewed-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>

> ---
>  drivers/net/virtio_net.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> index 0db14f6b87d3..1270c8d23463 100644
> --- a/drivers/net/virtio_net.c
> +++ b/drivers/net/virtio_net.c
> @@ -4219,6 +4219,8 @@ static int virtnet_probe(struct virtio_device *vdev)
>  	if (vi->has_rss || vi->has_rss_hash_report)
>  		virtnet_init_default_rss(vi);
>
> +	_virtnet_set_queues(vi, vi->curr_queue_pairs);
> +
>  	/* serialize netdev register + virtio_device_ready() with ndo_open() */
>  	rtnl_lock();
>
> @@ -4257,8 +4259,6 @@ static int virtnet_probe(struct virtio_device *vdev)
>  		goto free_unregister_netdev;
>  	}
>
> -	virtnet_set_queues(vi, vi->curr_queue_pairs);
> -
>  	/* Assume link up if device can't report link status,
>  	   otherwise get link status from config. */
>  	netif_carrier_off(dev);
> --
> 2.39.3
>
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
