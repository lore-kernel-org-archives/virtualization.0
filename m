Received: from out30-99.freemail.mail.aliyun.com (out30-99.freemail.mail.aliyun.com [115.124.30.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 136142C375E
	for <virtualization@lists.linux.dev>; Thu, 11 Jun 2026 02:19:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.99
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781144372; cv=none; b=ALFogXIhuvypKw80PysXpX7aaTp9RnzhRSpYbjKtzphOE2rOUkRuNVac2lpwJrjqogs4/SjNzzrD4SiR5yFlPRC2tAlP7/M6WbYsc1BjDguP9UxEq7IOLfdxi+RniT14r6Vy0IkhavaFrpCMKRnyn/ZdsZ01FeYCfZmwMCStpwE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781144372; c=relaxed/simple;
	bh=ohBD7T1JgaazoP0A4h0fIVfGYj8iyEv0bobf5aak09Y=;
	h=Message-ID:Subject:Date:From:To:Cc:References:In-Reply-To; b=Gt5Ev9MQFEh+PTAn0ZSBrbfN2J+nI53nU3VjlqJb2M/aMAlR36o1M8JnsboHO9FDMGJEszIcJIVkHHsizYw5wgXbSVG4mvcAUZDOOBru1dI89CXgBvhusdx6Nc3j8suOEZhe9NP+stpnNn8+yDB27rR8susIKbML1KNxSaj6j7Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=ixzaoqVl; arc=none smtp.client-ip=115.124.30.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="ixzaoqVl"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1781144365; h=Message-ID:Subject:Date:From:To;
	bh=3+YL61YLNP1oJQZrFdy9vPrItM3azFHydrfA78eswbw=;
	b=ixzaoqVlh5e2FRtE3OXHSaUP/vTN46+c1hEBkbboDzgsDLvXLB1XrueFmeHDudAAx7SCnMf52O4Ma3SJG9dETZNTKyR+57F8sNNVgYAW/ID2K3nSHTO1IDhrpNGIbDYn2LNstaij98fU/LTXevv1iMhNhRyTEEww5Ik++EfjVbM=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R181e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037033178;MF=xuanzhuo@linux.alibaba.com;NM=1;PH=DS;RN=14;SR=0;TI=SMTPD_---0X4c0N2Y_1781144364;
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com fp:SMTPD_---0X4c0N2Y_1781144364 cluster:ay36)
          by smtp.aliyun-inc.com;
          Thu, 11 Jun 2026 10:19:25 +0800
Message-ID: <1781144329.8069873-2-xuanzhuo@linux.alibaba.com>
Subject: Re: [PATCH net v2 2/2] virtio-net: harden page_to_skb() big-packet frag loop
Date: Thu, 11 Jun 2026 10:18:49 +0800
From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
To: Xiang Mei <xmei5@asu.edu>
Cc: andrew+netdev@lunn.ch,
 davem@davemloft.net,
 edumazet@google.com,
 kuba@kernel.org,
 pabeni@redhat.com,
 netdev@vger.kernel.org,
 virtualization@lists.linux.dev,
 linux-kernel@vger.kernel.org,
 minhquangbui99@gmail.com,
 bestswngs@gmail.com,
 Xiang Mei <xmei5@asu.edu>,
 mst@redhat.com,
 jasowang@redhat.com,
 eperezma@redhat.com
References: <20260610232936.1176094-1-xmei5@asu.edu>
 <20260610232936.1176094-2-xmei5@asu.edu>
In-Reply-To: <20260610232936.1176094-2-xmei5@asu.edu>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>

On Wed, 10 Jun 2026 16:29:36 -0700, Xiang Mei <xmei5@asu.edu> wrote:
> This is a robustness hardening patch. The slow-path frag loop in
> page_to_skb() walks the page chain via page->private until the
> device-reported len is consumed, implicitly trusting that len fits the
> chain. It does not stop when the chain is exhausted (page becomes NULL
> at the tail), nor when nr_frags reaches the end of the static
> skb_shinfo()->frags[MAX_SKB_FRAGS] array.
>
> Both bounds are needed: the chain length is big_packets_num_skbfrags + 1
> pages, which for an MTU-driven configuration can be well below
> MAX_SKB_FRAGS, so neither guard implies the other.
>
> Make the loop self-defending so it no longer relies on the caller having
> validated len: stop once the chain is exhausted, and never index past
> MAX_SKB_FRAGS. No functional change for well-formed input.

At this point, we are assuming that len represents the correct packet length. If
there is a bug in the validation, it can be fixed, just like in your previous
patch. Indeed, not checking nr_frags is also based on the overall design.
However, I do not recommend adding this kind of enhancement. If we follow
this logic, we would end up adding similar code in many other places, which
doesn't make much sense.

Thanks.

>
> Signed-off-by: Xiang Mei <xmei5@asu.edu>
> ---
> v2: robustness patch
>
>  drivers/net/virtio_net.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> index afe73eda1491..518c22fa1b68 100644
> --- a/drivers/net/virtio_net.c
> +++ b/drivers/net/virtio_net.c
> @@ -906,8 +906,11 @@ static struct sk_buff *page_to_skb(struct virtnet_info *vi,
>  	}
>
>  	BUG_ON(offset >= PAGE_SIZE);
> -	while (len) {
> +	while (len && page) {
>  		unsigned int frag_size = min((unsigned)PAGE_SIZE - offset, len);
> +
> +		if (unlikely(skb_shinfo(skb)->nr_frags >= MAX_SKB_FRAGS))
> +			break;
>  		skb_add_rx_frag(skb, skb_shinfo(skb)->nr_frags, page, offset,
>  				frag_size, truesize);
>  		len -= frag_size;
> --
> 2.43.0
>
