Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3FB41C77B73
	for <virtualization@archiver.kernel.org>; Tue,  6 Jun 2023 01:50:34 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id B4B8941553;
	Tue,  6 Jun 2023 01:50:33 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org B4B8941553
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id SZNGnoCZ338l; Tue,  6 Jun 2023 01:50:32 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id DE77B4154A;
	Tue,  6 Jun 2023 01:50:31 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org DE77B4154A
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id A7BCCC007A;
	Tue,  6 Jun 2023 01:50:31 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 9DB6AC0029
 for <virtualization@lists.linux-foundation.org>;
 Tue,  6 Jun 2023 01:50:30 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 786864059C
 for <virtualization@lists.linux-foundation.org>;
 Tue,  6 Jun 2023 01:50:30 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 786864059C
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Gf_I8eEXVGow
 for <virtualization@lists.linux-foundation.org>;
 Tue,  6 Jun 2023 01:50:29 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 955FB40463
Received: from out30-97.freemail.mail.aliyun.com
 (out30-97.freemail.mail.aliyun.com [115.124.30.97])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 955FB40463
 for <virtualization@lists.linux-foundation.org>;
 Tue,  6 Jun 2023 01:50:27 +0000 (UTC)
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R151e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=ay29a033018046059;
 MF=xuanzhuo@linux.alibaba.com; NM=1; PH=DS; RN=14; SR=0;
 TI=SMTPD_---0VkU73yf_1686016221; 
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com
 fp:SMTPD_---0VkU73yf_1686016221) by smtp.aliyun-inc.com;
 Tue, 06 Jun 2023 09:50:22 +0800
Message-ID: <1686016211.426338-1-xuanzhuo@linux.alibaba.com>
Subject: Re: [PATCH net] virtio_net: use control_buf for coalesce params
Date: Tue, 6 Jun 2023 09:50:11 +0800
From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
To: Brett Creeley <brett.creeley@amd.com>
References: <20230605195925.51625-1-brett.creeley@amd.com>
In-Reply-To: <20230605195925.51625-1-brett.creeley@amd.com>
Cc: xuanzhuo@linux.alibaba.com, brett.creeley@amd.com, mst@redhat.com,
 allen.hubbe@amd.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
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

On Mon, 5 Jun 2023 12:59:25 -0700, Brett Creeley <brett.creeley@amd.com> wrote:
> Commit 699b045a8e43 ("net: virtio_net: notifications coalescing
> support") added coalescing command support for virtio_net. However,
> the coalesce commands are using buffers on the stack, which is causing
> the device to see DMA errors. There should also be a complaint from
> check_for_stack() in debug_dma_map_xyz(). Fix this by adding and using
> coalesce params from the control_buf struct, which aligns with other
> commands.
>
> Fixes: 699b045a8e43 ("net: virtio_net: notifications coalescing support")
> Reviewed-by: Shannon Nelson <shannon.nelson@amd.com>
> Signed-off-by: Allen Hubbe <allen.hubbe@amd.com>
> Signed-off-by: Brett Creeley <brett.creeley@amd.com>

Reviewed-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>

Thanks.

> ---
>  drivers/net/virtio_net.c | 16 ++++++++--------
>  1 file changed, 8 insertions(+), 8 deletions(-)
>
> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> index 56ca1d270304..486b5849033d 100644
> --- a/drivers/net/virtio_net.c
> +++ b/drivers/net/virtio_net.c
> @@ -205,6 +205,8 @@ struct control_buf {
>  	__virtio16 vid;
>  	__virtio64 offloads;
>  	struct virtio_net_ctrl_rss rss;
> +	struct virtio_net_ctrl_coal_tx coal_tx;
> +	struct virtio_net_ctrl_coal_rx coal_rx;
>  };
>
>  struct virtnet_info {
> @@ -2934,12 +2936,10 @@ static int virtnet_send_notf_coal_cmds(struct virtnet_info *vi,
>  				       struct ethtool_coalesce *ec)
>  {
>  	struct scatterlist sgs_tx, sgs_rx;
> -	struct virtio_net_ctrl_coal_tx coal_tx;
> -	struct virtio_net_ctrl_coal_rx coal_rx;
>
> -	coal_tx.tx_usecs = cpu_to_le32(ec->tx_coalesce_usecs);
> -	coal_tx.tx_max_packets = cpu_to_le32(ec->tx_max_coalesced_frames);
> -	sg_init_one(&sgs_tx, &coal_tx, sizeof(coal_tx));
> +	vi->ctrl->coal_tx.tx_usecs = cpu_to_le32(ec->tx_coalesce_usecs);
> +	vi->ctrl->coal_tx.tx_max_packets = cpu_to_le32(ec->tx_max_coalesced_frames);
> +	sg_init_one(&sgs_tx, &vi->ctrl->coal_tx, sizeof(vi->ctrl->coal_tx));
>
>  	if (!virtnet_send_command(vi, VIRTIO_NET_CTRL_NOTF_COAL,
>  				  VIRTIO_NET_CTRL_NOTF_COAL_TX_SET,
> @@ -2950,9 +2950,9 @@ static int virtnet_send_notf_coal_cmds(struct virtnet_info *vi,
>  	vi->tx_usecs = ec->tx_coalesce_usecs;
>  	vi->tx_max_packets = ec->tx_max_coalesced_frames;
>
> -	coal_rx.rx_usecs = cpu_to_le32(ec->rx_coalesce_usecs);
> -	coal_rx.rx_max_packets = cpu_to_le32(ec->rx_max_coalesced_frames);
> -	sg_init_one(&sgs_rx, &coal_rx, sizeof(coal_rx));
> +	vi->ctrl->coal_rx.rx_usecs = cpu_to_le32(ec->rx_coalesce_usecs);
> +	vi->ctrl->coal_rx.rx_max_packets = cpu_to_le32(ec->rx_max_coalesced_frames);
> +	sg_init_one(&sgs_rx, &vi->ctrl->coal_rx, sizeof(vi->ctrl->coal_rx));
>
>  	if (!virtnet_send_command(vi, VIRTIO_NET_CTRL_NOTF_COAL,
>  				  VIRTIO_NET_CTRL_NOTF_COAL_RX_SET,
> --
> 2.17.1
>
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
