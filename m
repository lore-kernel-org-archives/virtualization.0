Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B56A18035
	for <virtualization@lists.linux-foundation.org>; Wed, 24 Jan 2024 09:16:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706087803; cv=none; b=Rm/WfwoErTtEfJxAKgiw0wAvZxwqrQTx5abJw3GWjQrEb5VLJgwMX2/C/U+5aic9V1+Q4juz3j0gHB0LBw3g/AcX31ZpJsoYYWpx8KLUDl9E2teBjJfkdbQZ/RllNrfQSDFk6pOJDyC/tEsxuk18UUFdq4vdjrMVcJaCVhOroT0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706087803; c=relaxed/simple;
	bh=Gw027f+IjQyyQbAt7FOQ+4RHmj+3PaRU6TIsxKZu6kY=;
	h=Message-ID:Subject:Date:From:To:Cc:References:In-Reply-To; b=cdYEmpHBcbsbwtuYhhfHEq1yDbxBYDpSkct68mm8IogSiAaafzpVElEewjzAroaVILSM2oBnTQBfR79dhMmf1fcKJEcF2XGRR269qsyFKVJCAXNh7y0NSoWptS/ZHj9BvlQ3diWcZYuhDdW15NNguOPdCezBHNmgLgQ2dkhcIe4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.138
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id AF8E1844B1
	for <virtualization@lists.linux-foundation.org>; Wed, 24 Jan 2024 09:16:40 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org AF8E1844B1
X-Virus-Scanned: amavisd-new at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -9.899
X-Spam-Level:
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id xU_S35y6K3Zq
	for <virtualization@lists.linux-foundation.org>;
	Wed, 24 Jan 2024 09:16:39 +0000 (UTC)
Received: from out30-130.freemail.mail.aliyun.com (out30-130.freemail.mail.aliyun.com [115.124.30.130])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 414BB8442B
	for <virtualization@lists.linux-foundation.org>; Wed, 24 Jan 2024 09:16:38 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 414BB8442B
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R831e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045176;MF=xuanzhuo@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0W.G52BL_1706087790;
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com fp:SMTPD_---0W.G52BL_1706087790)
          by smtp.aliyun-inc.com;
          Wed, 24 Jan 2024 17:16:31 +0800
Message-ID: <1706087654.2583706-2-xuanzhuo@linux.alibaba.com>
Subject: Re: [PATCH v2 2/3] virtio_net: Add missing virtio header in skb for XDP_PASS
Date: Wed, 24 Jan 2024 17:14:14 +0800
From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
To: Liang Chen <liangchen.linux@gmail.com>
Cc: virtualization@lists.linux-foundation.org,
 linux-kernel@vger.kernel.org,
 liangchen.linux@gmail.com,
 mst@redhat.com,
 jasowang@redhat.com,
 hengqi@linux.alibaba.com
References: <20240124085721.54442-1-liangchen.linux@gmail.com>
 <20240124085721.54442-3-liangchen.linux@gmail.com>
In-Reply-To: <20240124085721.54442-3-liangchen.linux@gmail.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>

On Wed, 24 Jan 2024 16:57:20 +0800, Liang Chen <liangchen.linux@gmail.com> wrote:
> For the XDP_PASS scenario of the XDP path, the skb constructed with
> xdp_buff does not include the virtio header. Adding the virtio header
> information back when creating the skb.
>
> Signed-off-by: Liang Chen <liangchen.linux@gmail.com>
> ---
>  drivers/net/virtio_net.c | 6 ++++++
>  1 file changed, 6 insertions(+)
>
> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> index b56828804e5f..2de46eb4c661 100644
> --- a/drivers/net/virtio_net.c
> +++ b/drivers/net/virtio_net.c
> @@ -1270,6 +1270,9 @@ static struct sk_buff *receive_small_xdp(struct net_device *dev,
>  	if (unlikely(!skb))
>  		goto err;
>
> +	/* Store the original virtio header for subsequent use by the driver. */
> +	memcpy(skb_vnet_common_hdr(skb), &virtnet_xdp.hdr, vi->hdr_len);

About this, a spec is waiting for voting.

This may change the logic of the csum offset and so on.

Please not do this.

Thanks.


> +
>  	if (metasize)
>  		skb_metadata_set(skb, metasize);
>
> @@ -1635,6 +1638,9 @@ static struct sk_buff *receive_mergeable_xdp(struct net_device *dev,
>  		head_skb = build_skb_from_xdp_buff(dev, vi, xdp, xdp_frags_truesz);
>  		if (unlikely(!head_skb))
>  			break;
> +		/* Store the original virtio header for subsequent use by the driver. */
> +		memcpy(skb_vnet_common_hdr(head_skb), &virtnet_xdp.hdr, vi->hdr_len);
> +
>  		return head_skb;
>
>  	case XDP_TX:
> --
> 2.40.1
>
