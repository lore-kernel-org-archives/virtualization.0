Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B609EC433EF
	for <virtualization@archiver.kernel.org>; Sat,  7 May 2022 01:39:04 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 4A0D160B5A;
	Sat,  7 May 2022 01:39:04 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id aTmNb-2SHd0w; Sat,  7 May 2022 01:39:02 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 8D16D607FF;
	Sat,  7 May 2022 01:39:01 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 6BB52C0039;
	Sat,  7 May 2022 01:39:01 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id B699EC002D
 for <virtualization@lists.linux-foundation.org>;
 Sat,  7 May 2022 01:38:59 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 90C2D41548
 for <virtualization@lists.linux-foundation.org>;
 Sat,  7 May 2022 01:38:59 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id SspBWtGPvT33
 for <virtualization@lists.linux-foundation.org>;
 Sat,  7 May 2022 01:38:58 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from out30-42.freemail.mail.aliyun.com
 (out30-42.freemail.mail.aliyun.com [115.124.30.42])
 by smtp4.osuosl.org (Postfix) with ESMTPS id CF85341521
 for <virtualization@lists.linux-foundation.org>;
 Sat,  7 May 2022 01:38:57 +0000 (UTC)
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R101e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=e01e04407; MF=xuanzhuo@linux.alibaba.com;
 NM=1; PH=DS; RN=8; SR=0; TI=SMTPD_---0VCUAvP6_1651887533; 
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com
 fp:SMTPD_---0VCUAvP6_1651887533) by smtp.aliyun-inc.com(127.0.0.1);
 Sat, 07 May 2022 09:38:54 +0800
Message-ID: <1651887524.8548894-1-xuanzhuo@linux.alibaba.com>
Subject: Re: [PATCH net-next 5/6] net: virtio: switch to
 netif_napi_add_weight()
Date: Sat, 7 May 2022 09:38:44 +0800
From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
To: Jakub Kicinski <kuba@kernel.org>
References: <20220506170751.822862-1-kuba@kernel.org>
 <20220506170751.822862-6-kuba@kernel.org>
In-Reply-To: <20220506170751.822862-6-kuba@kernel.org>
Cc: mst@redhat.com, netdev@vger.kernel.org,
 virtualization@lists.linux-foundation.org, edumazet@google.com,
 Jakub Kicinski <kuba@kernel.org>, pabeni@redhat.com, davem@davemloft.net
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

On Fri,  6 May 2022 10:07:50 -0700, Jakub Kicinski <kuba@kernel.org> wrote:
> virtio netdev driver uses a custom napi weight, switch to the new
> API for setting custom weight.
>
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>

Reviewed-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>

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
>
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
