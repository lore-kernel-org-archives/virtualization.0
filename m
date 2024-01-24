Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B378818EAD
	for <virtualization@lists.linux-foundation.org>; Wed, 24 Jan 2024 11:04:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.137
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706094254; cv=none; b=h3eOLlAIbP8iviqLVFIesxoH/3ZqqK8DETLlI5xMAlmaUV4WUDd72NXDigKk4diDkAxYtRWy0eRmhxwLJ+C1RTEL/5OcywR7zQYtMXUvXk84Wd2b5AEHHqjw4XY1TXgCTXtN2B7TFEAw6FvjI6HdGa1hhZbUgvHUucIMy1nziGU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706094254; c=relaxed/simple;
	bh=RQj3sUXdtYHYvevvKwr5sdDtzYfqublH8XzC8qK0vO4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YtbZfTQDU8gV8UNu+glLMHuZjk/4sUjTMaRCYas65KTm4CSLc6TlRQy43bXjh7ryx3HrvZOx8fg7bccN0J89RJ9N83mD2z9rdvVG1bFZfV/smmkKMihaYS8il90goATSPQTem96nzvqw4oQafUtAmfWdYZnTnR+I8uCAjhPlCSU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.137
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 320F4417C1
	for <virtualization@lists.linux-foundation.org>; Wed, 24 Jan 2024 11:04:12 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 320F4417C1
X-Virus-Scanned: amavisd-new at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -9.899
X-Spam-Level:
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id fiywXime_uUq
	for <virtualization@lists.linux-foundation.org>;
	Wed, 24 Jan 2024 11:04:11 +0000 (UTC)
Received: from out30-98.freemail.mail.aliyun.com (out30-98.freemail.mail.aliyun.com [115.124.30.98])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 7DCCA4097B
	for <virtualization@lists.linux-foundation.org>; Wed, 24 Jan 2024 11:04:09 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 7DCCA4097B
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R121e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046050;MF=hengqi@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0W.GRcE5_1706094243;
Received: from 30.221.149.132(mailfrom:hengqi@linux.alibaba.com fp:SMTPD_---0W.GRcE5_1706094243)
          by smtp.aliyun-inc.com;
          Wed, 24 Jan 2024 19:04:03 +0800
Message-ID: <896749de-39b6-4081-91f3-1e316706a0e9@linux.alibaba.com>
Date: Wed, 24 Jan 2024 19:04:02 +0800
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/3] virtio_net: Add missing virtio header in skb for
 XDP_PASS
To: Liang Chen <liangchen.linux@gmail.com>
Cc: virtualization@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
 "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>,
 Xuan Zhuo <xuanzhuo@linux.alibaba.com>
References: <20240124085721.54442-1-liangchen.linux@gmail.com>
 <20240124085721.54442-3-liangchen.linux@gmail.com>
From: Heng Qi <hengqi@linux.alibaba.com>
In-Reply-To: <20240124085721.54442-3-liangchen.linux@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



在 2024/1/24 下午4:57, Liang Chen 写道:
> For the XDP_PASS scenario of the XDP path, the skb constructed with
> xdp_buff does not include the virtio header. Adding the virtio header
> information back when creating the skb.
>
> Signed-off-by: Liang Chen <liangchen.linux@gmail.com>
> ---
>   drivers/net/virtio_net.c | 6 ++++++
>   1 file changed, 6 insertions(+)
>
> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> index b56828804e5f..2de46eb4c661 100644
> --- a/drivers/net/virtio_net.c
> +++ b/drivers/net/virtio_net.c
> @@ -1270,6 +1270,9 @@ static struct sk_buff *receive_small_xdp(struct net_device *dev,
>   	if (unlikely(!skb))
>   		goto err;
>   
> +	/* Store the original virtio header for subsequent use by the driver. */
> +	memcpy(skb_vnet_common_hdr(skb), &virtnet_xdp.hdr, vi->hdr_len);

If xdp push or xdp pull modifies xdp_buff, will the original header 
still apply to the modified data?

Thanks,
Heng

> +
>   	if (metasize)
>   		skb_metadata_set(skb, metasize);
>   
> @@ -1635,6 +1638,9 @@ static struct sk_buff *receive_mergeable_xdp(struct net_device *dev,
>   		head_skb = build_skb_from_xdp_buff(dev, vi, xdp, xdp_frags_truesz);
>   		if (unlikely(!head_skb))
>   			break;
> +		/* Store the original virtio header for subsequent use by the driver. */
> +		memcpy(skb_vnet_common_hdr(head_skb), &virtnet_xdp.hdr, vi->hdr_len);
> +
>   		return head_skb;
>   
>   	case XDP_TX:

