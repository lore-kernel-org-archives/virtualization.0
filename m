Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C3258C77B73
	for <virtualization@archiver.kernel.org>; Tue,  6 Jun 2023 01:57:48 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 43C5360741;
	Tue,  6 Jun 2023 01:57:48 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 43C5360741
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id v2RyqmTZiChP; Tue,  6 Jun 2023 01:57:47 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id AE55560073;
	Tue,  6 Jun 2023 01:57:46 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org AE55560073
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 8382CC007A;
	Tue,  6 Jun 2023 01:57:46 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 49238C0029
 for <virtualization@lists.linux-foundation.org>;
 Tue,  6 Jun 2023 01:57:45 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 1B7A540441
 for <virtualization@lists.linux-foundation.org>;
 Tue,  6 Jun 2023 01:57:45 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 1B7A540441
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Zp6t5Z_FmBZQ
 for <virtualization@lists.linux-foundation.org>;
 Tue,  6 Jun 2023 01:57:44 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org AD97740227
Received: from out30-112.freemail.mail.aliyun.com
 (out30-112.freemail.mail.aliyun.com [115.124.30.112])
 by smtp2.osuosl.org (Postfix) with ESMTPS id AD97740227
 for <virtualization@lists.linux-foundation.org>;
 Tue,  6 Jun 2023 01:57:43 +0000 (UTC)
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R251e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=ay29a033018046060;
 MF=xuanzhuo@linux.alibaba.com; NM=1; PH=DS; RN=13; SR=0;
 TI=SMTPD_---0VkU4BR6_1686016655; 
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com
 fp:SMTPD_---0VkU4BR6_1686016655) by smtp.aliyun-inc.com;
 Tue, 06 Jun 2023 09:57:36 +0800
Message-ID: <1686016374.4953902-2-xuanzhuo@linux.alibaba.com>
Subject: Re: [RFC PATCH net] virtio_net: Prevent napi_weight changes with
 VIRTIO_NET_F_NOTF_COAL support
Date: Tue, 6 Jun 2023 09:52:54 +0800
From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
To: Brett Creeley <brett.creeley@amd.com>
References: <20230605210237.60988-1-brett.creeley@amd.com>
In-Reply-To: <20230605210237.60988-1-brett.creeley@amd.com>
Cc: xuanzhuo@linux.alibaba.com, brett.creeley@amd.com, mst@redhat.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
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

On Mon, 5 Jun 2023 14:02:36 -0700, Brett Creeley <brett.creeley@amd.com> wrote:
> Commit 699b045a8e43 ("net: virtio_net: notifications coalescing
> support") added support for VIRTIO_NET_F_NOTF_COAL. The get_coalesce
> call made changes to report "1" in tx_max_coalesced_frames if
> VIRTIO_NET_F_NOTF_COAL is not supported and napi.weight is non-zero.
> However, the napi_weight value could still be changed by the
> set_coalesce call regardless of whether or not the device supports
> VIRTIO_NET_F_NOTF_COAL.
>
> It seems like the tx_max_coalesced_frames value should not control more
> than 1 thing (i.e. napi_weight and the device's tx_max_packets). So, fix
> this by only allowing the napi_weight change if VIRTIO_NET_F_NOTF_COAL
> is not supported by the virtio device.


@Jason I wonder should we keep this function to change the napi weight by the
coalesec command.

Thanks.

>
> It wasn't clear to me if this was the intended behavior, so that's why
> I'm sending this as an RFC patch initially. Based on the feedback, I
> will resubmit as an official patch.
>
> Fixes: 699b045a8e43 ("net: virtio_net: notifications coalescing support")
> Signed-off-by: Brett Creeley <brett.creeley@amd.com>
> ---
>  drivers/net/virtio_net.c | 24 +++++++++++++-----------
>  1 file changed, 13 insertions(+), 11 deletions(-)
>
> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> index 486b5849033d..e28387866909 100644
> --- a/drivers/net/virtio_net.c
> +++ b/drivers/net/virtio_net.c
> @@ -2990,19 +2990,21 @@ static int virtnet_set_coalesce(struct net_device *dev,
>  	int ret, i, napi_weight;
>  	bool update_napi = false;
>
> -	/* Can't change NAPI weight if the link is up */
> -	napi_weight = ec->tx_max_coalesced_frames ? NAPI_POLL_WEIGHT : 0;
> -	if (napi_weight ^ vi->sq[0].napi.weight) {
> -		if (dev->flags & IFF_UP)
> -			return -EBUSY;
> -		else
> -			update_napi = true;
> -	}
> -
> -	if (virtio_has_feature(vi->vdev, VIRTIO_NET_F_NOTF_COAL))
> +	if (virtio_has_feature(vi->vdev, VIRTIO_NET_F_NOTF_COAL)) {
>  		ret = virtnet_send_notf_coal_cmds(vi, ec);
> -	else
> +	} else {
> +		/* Can't change NAPI weight if the link is up */
> +		napi_weight = ec->tx_max_coalesced_frames ?
> +			NAPI_POLL_WEIGHT : 0;
> +		if (napi_weight ^ vi->sq[0].napi.weight) {
> +			if (dev->flags & IFF_UP)
> +				return -EBUSY;
> +			else
> +				update_napi = true;
> +		}
> +
>  		ret = virtnet_coal_params_supported(ec);
> +	}
>
>  	if (ret)
>  		return ret;
> --
> 2.17.1
>
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
