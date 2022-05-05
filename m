Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AA001C433F5
	for <virtualization@archiver.kernel.org>; Thu,  5 May 2022 02:12:06 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 4BE1A401A3;
	Thu,  5 May 2022 02:12:06 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id BypzkFo8tJiX; Thu,  5 May 2022 02:12:05 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id D619E40182;
	Thu,  5 May 2022 02:12:04 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id B59FEC0039;
	Thu,  5 May 2022 02:12:04 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 1038AC0032
 for <virtualization@lists.linux-foundation.org>;
 Thu,  5 May 2022 02:12:04 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 0C907401A3
 for <virtualization@lists.linux-foundation.org>;
 Thu,  5 May 2022 02:12:04 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 0HVeKX6bezAe
 for <virtualization@lists.linux-foundation.org>;
 Thu,  5 May 2022 02:12:03 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from out30-54.freemail.mail.aliyun.com
 (out30-54.freemail.mail.aliyun.com [115.124.30.54])
 by smtp2.osuosl.org (Postfix) with ESMTPS id AF7F440182
 for <virtualization@lists.linux-foundation.org>;
 Thu,  5 May 2022 02:12:02 +0000 (UTC)
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R371e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=e01e04395; MF=xuanzhuo@linux.alibaba.com;
 NM=1; PH=DS; RN=11; SR=0; TI=SMTPD_---0VCEWZQR_1651716717; 
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com
 fp:SMTPD_---0VCEWZQR_1651716717) by smtp.aliyun-inc.com(127.0.0.1);
 Thu, 05 May 2022 10:11:57 +0800
Message-ID: <1651716696.4057877-1-xuanzhuo@linux.alibaba.com>
Subject: Re: [PATCH net-next 2/2] net: move snowflake callers to
 netif_napi_add_tx_weight()
Date: Thu, 5 May 2022 10:11:36 +0800
From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
To: Jakub Kicinski <kuba@kernel.org>
References: <20220504163725.550782-1-kuba@kernel.org>
 <20220504163725.550782-2-kuba@kernel.org>
In-Reply-To: <20220504163725.550782-2-kuba@kernel.org>
Cc: mst@redhat.com, netdev@vger.kernel.org, claudiu.manoil@nxp.com,
 UNGLinuxDriver@microchip.com, edumazet@google.com,
 bryan.whitehead@microchip.com, Jakub Kicinski <kuba@kernel.org>,
 pabeni@redhat.com, virtualization@lists.linux-foundation.org,
 davem@davemloft.net
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

On Wed,  4 May 2022 09:37:25 -0700, Jakub Kicinski <kuba@kernel.org> wrote:
> Make the drivers with custom tx napi weight call netif_napi_add_tx_weight().
>
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> ---
> CC: claudiu.manoil@nxp.com
> CC: bryan.whitehead@microchip.com
> CC: UNGLinuxDriver@microchip.com
> CC: mst@redhat.com
> CC: jasowang@redhat.com
> CC: virtualization@lists.linux-foundation.org
> ---
>  drivers/net/ethernet/freescale/gianfar.c      | 4 ++--
>  drivers/net/ethernet/microchip/lan743x_main.c | 6 +++---
>  drivers/net/virtio_net.c                      | 5 +++--
>  3 files changed, 8 insertions(+), 7 deletions(-)
>
> diff --git a/drivers/net/ethernet/freescale/gianfar.c b/drivers/net/ethernet/freescale/gianfar.c
> index f0b652a65043..3dc9369a33f7 100644
> --- a/drivers/net/ethernet/freescale/gianfar.c
> +++ b/drivers/net/ethernet/freescale/gianfar.c
> @@ -3233,8 +3233,8 @@ static int gfar_probe(struct platform_device *ofdev)
>  	for (i = 0; i < priv->num_grps; i++) {
>  		netif_napi_add(dev, &priv->gfargrp[i].napi_rx,
>  			       gfar_poll_rx_sq, NAPI_POLL_WEIGHT);
> -		netif_tx_napi_add(dev, &priv->gfargrp[i].napi_tx,
> -				  gfar_poll_tx_sq, 2);
> +		netif_napi_add_tx_weight(dev, &priv->gfargrp[i].napi_tx,
> +					 gfar_poll_tx_sq, 2);
>  	}
>
>  	if (priv->device_flags & FSL_GIANFAR_DEV_HAS_CSUM) {
> diff --git a/drivers/net/ethernet/microchip/lan743x_main.c b/drivers/net/ethernet/microchip/lan743x_main.c
> index 9ac0c2b96a15..efbddf24ba31 100644
> --- a/drivers/net/ethernet/microchip/lan743x_main.c
> +++ b/drivers/net/ethernet/microchip/lan743x_main.c
> @@ -2044,9 +2044,9 @@ static int lan743x_tx_open(struct lan743x_tx *tx)
>  	tx->vector_flags = lan743x_intr_get_vector_flags(adapter,
>  							 INT_BIT_DMA_TX_
>  							 (tx->channel_number));
> -	netif_tx_napi_add(adapter->netdev,
> -			  &tx->napi, lan743x_tx_napi_poll,
> -			  tx->ring_size - 1);
> +	netif_napi_add_tx_weight(adapter->netdev,
> +				 &tx->napi, lan743x_tx_napi_poll,
> +				 tx->ring_size - 1);
>  	napi_enable(&tx->napi);
>
>  	data = 0;
> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> index cbba9d2e8f32..ebb98b796352 100644
> --- a/drivers/net/virtio_net.c
> +++ b/drivers/net/virtio_net.c
> @@ -3315,8 +3315,9 @@ static int virtnet_alloc_queues(struct virtnet_info *vi)
>  		vi->rq[i].pages = NULL;
>  		netif_napi_add(vi->dev, &vi->rq[i].napi, virtnet_poll,
>  			       napi_weight);
> -		netif_tx_napi_add(vi->dev, &vi->sq[i].napi, virtnet_poll_tx,
> -				  napi_tx ? napi_weight : 0);
> +		netif_napi_add_tx_weight(vi->dev, &vi->sq[i].napi,
> +					 virtnet_poll_tx,
> +					 napi_tx ? napi_weight : 0);

for virtio-net:

Reviewed-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>


>
>  		sg_init_table(vi->rq[i].sg, ARRAY_SIZE(vi->rq[i].sg));
>  		ewma_pkt_len_init(&vi->rq[i].mrg_avg_pkt_len);
> --
> 2.34.1
>
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
