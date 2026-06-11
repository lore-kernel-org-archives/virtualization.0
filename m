Received: from out30-112.freemail.mail.aliyun.com (out30-112.freemail.mail.aliyun.com [115.124.30.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4C5F1E7660
	for <virtualization@lists.linux.dev>; Thu, 11 Jun 2026 01:55:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.112
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781142951; cv=none; b=W/MD9uNo9aHiD3RVHDLq7OP58r4YN6sLScdhswOU2LB9dL+Gl6GwrhDc2wLTec/x75EQBHMFIFojQ5xZuWV4i4tSWt6aZh3uNKguQ2ox/ycjaCnlE37leCUYLnivKJKNuJTSobohaWAgNtE6xmpAN5ms1WGn8wk1ICftaAmtCAM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781142951; c=relaxed/simple;
	bh=uICGC2yxGlAniXxit1OUkqRwByVAR45ztTbIMmRpvPI=;
	h=Message-ID:Subject:Date:From:To:Cc:References:In-Reply-To; b=DtR2VunRbfG1TRmKAoKmD+PqLbljqbqpSk18LHrFb7ugTVSxjKzuo1hBEHTOX/cftKabS1OWPce9ffLWjQp087sj8PPF85Im2dzy+ParwsXh/t4DNBPzEPmJiKLBTh/jg/8Ol/aPx2rxyuAdgtx6r86Rynul8ZluQomXJMJqFFs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=tbpY+li0; arc=none smtp.client-ip=115.124.30.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="tbpY+li0"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1781142946; h=Message-ID:Subject:Date:From:To;
	bh=ssfM3bgYmJ7PMTz5aWvZ74bFGz6EBIGbRO1Dwbi+lpE=;
	b=tbpY+li0fs7nH3zRXWzSrMoEV0Oy1lzya/wYJBb63wkAPxUWd6lOE4D6pBtPOfMrBmbjWD4gH/QZzf2ZUk4bX2TvLbwmtduKTXg+oQ1TxWWVonMWylrdwtRwtyPMbRqKKm3ZZyQ0stY5ahl/x7nSyD26x656VW8A70sOaq2Q6Fg=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R261e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033045133197;MF=xuanzhuo@linux.alibaba.com;NM=1;PH=DS;RN=14;SR=0;TI=SMTPD_---0X4c2ryc_1781142945;
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com fp:SMTPD_---0X4c2ryc_1781142945 cluster:ay36)
          by smtp.aliyun-inc.com;
          Thu, 11 Jun 2026 09:55:45 +0800
Message-ID: <1781142936.5492013-1-xuanzhuo@linux.alibaba.com>
Subject: Re: [PATCH net v2 1/2] virtio-net: fix len check in receive_big()
Date: Thu, 11 Jun 2026 09:55:36 +0800
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
In-Reply-To: <20260610232936.1176094-1-xmei5@asu.edu>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>

On Wed, 10 Jun 2026 16:29:35 -0700, Xiang Mei <xmei5@asu.edu> wrote:
> receive_big() bounds the device-announced length by
> (big_packets_num_skbfrags + 1) * PAGE_SIZE.  That is still too loose:
> add_recvbuf_big() sets sg[1] to start at offset
> sizeof(struct padded_vnet_hdr) into the first page, so the chain
> actually carries hdr_len + (PAGE_SIZE - sizeof(padded_vnet_hdr)) +
> big_packets_num_skbfrags * PAGE_SIZE bytes -- 20 bytes less than the
> check allows for the common hdr_len == 12 case.
>
> A malicious virtio backend can announce a len in that gap.  page_to_skb()
> then walks one frag past the page chain, storing a NULL page->private
> into skb_shinfo()->frags[MAX_SKB_FRAGS], which is both an out-of-bounds
> write past the static frag array and a NULL frag handed up the rx path.
>
> Bound len by the size add_recvbuf_big() actually advertised.
>
> Fixes: 0c716703965f ("virtio-net: fix received length check in big packets")
> Reported-by: Weiming Shi <bestswngs@gmail.com>
> Signed-off-by: Xiang Mei <xmei5@asu.edu>

Reviewed-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>

> ---
> v2: add 2/2 for robustness
>
>  drivers/net/virtio_net.c | 8 +++++---
>  1 file changed, 5 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> index f4adcfee7a80..afe73eda1491 100644
> --- a/drivers/net/virtio_net.c
> +++ b/drivers/net/virtio_net.c
> @@ -1999,15 +1999,17 @@ static struct sk_buff *receive_big(struct net_device *dev,
>  				   struct virtnet_rq_stats *stats)
>  {
>  	struct page *page = buf;
> +	unsigned long max_len;
>  	struct sk_buff *skb;
>
>  	/* Make sure that len does not exceed the size allocated in
>  	 * add_recvbuf_big.
>  	 */
> -	if (unlikely(len > (vi->big_packets_num_skbfrags + 1) * PAGE_SIZE)) {
> +	max_len = vi->hdr_len + (PAGE_SIZE - sizeof(struct padded_vnet_hdr)) +
> +		  vi->big_packets_num_skbfrags * PAGE_SIZE;
> +	if (unlikely(len > max_len)) {
>  		pr_debug("%s: rx error: len %u exceeds allocated size %lu\n",
> -			 dev->name, len,
> -			 (vi->big_packets_num_skbfrags + 1) * PAGE_SIZE);
> +			 dev->name, len, max_len);
>  		goto err;
>  	}
>
> --
> 2.43.0
>
