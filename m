Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1906542F709;
	Wed, 12 Aug 2026 23:34:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786577670; cv=none; b=FMx1n2VBWigKrJ8TB+mDYqh4CFpfeAVjjdMkV1XDXkuAjx7es6puo9s4Qa3n/NuWJmVF6w/2rNM+PNjNdXFv6dModqFyr2kY0La99y4g5eg5ekZ4VKdWe1eDf6jre/sSFqe8HEwXsSGGOUgM3DDL2T8mM7xHJIT2p9ZqTz7voOI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786577670; c=relaxed/simple;
	bh=v+uiCzIKNHWhRE1IIvRFcDEk9iV9xUz1wn0tskNdLGo=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ot84gwu7jjiANQE00LRDBLjNomJIjzRPklP34EjrQbZ3M+T/GOf0Vb/NMkPH1K3gnaovagSQ4fqzFtMfm9uhXy6X2dOapP0Bwhuv9TzQna29M6xDYc9Cjc4P5y6PGgU97yUIlTBGXSrfZqL9D8EZT3QqIN6OOfB7T5OTA0jIoJs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UmutzZC3; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UmutzZC3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7FE0F1F000E9;
	Wed, 12 Aug 2026 23:34:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786577668;
	bh=2z3tL2RCApMwA1jVVzeIDlFHZOe9EaKl7mBll48J/ZM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=UmutzZC35eJDGAPKD7PI5EkrcsTBSdR3LZjSjrhKBIDc0oYx2twsapRQTztHc8kmv
	 lXUJevooS2VI75Q6npzVapf2tyji0OHC7s8y8i/XkXCQ6o0f2jPQrdYAMAQJ30tWT+
	 eVBzyU/XlH9r9lH4XnmgQotdlM1lcIXu/AH4+1gUbXpjXy7/tPWTnRJxJ0SXs2WoDB
	 UxM7Er4R9evablZbYcgeakn0KwxwhB1YjgvD0Q16rjpRVEldlir6bUxhQBBfLDHwx7
	 1LUQefEaY/jPkL8QpXdchZaU0k+1NpdmKsOPpimORuiynfP80VxEh9cqmFGTPoT9lB
	 IY1EaMl4AuR0g==
Date: Wed, 12 Aug 2026 16:34:27 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Longjun Tang <lange_tang@163.com>
Cc: mst@redhat.com, jasowangio@gmail.com, xuanzhuo@linux.alibaba.com,
 virtualization@lists.linux.dev, netdev@vger.kernel.org,
 tanglongjun@kylinos.cn
Subject: Re: [PATCH] virtio_net: add rx-alloc-fail counter
Message-ID: <20260812163427.3c44ac4d@kernel.org>
In-Reply-To: <20260812012254.27668-1-lange_tang@163.com>
References: <20260812012254.27668-1-lange_tang@163.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 12 Aug 2026 09:22:54 +0800 Longjun Tang wrote:
> From: tanglongjun <tanglongjun@kylinos.cn>
> 
> Count buffer and skb allocation failures on the rx queue and
> report them via rx-alloc-fail in netdev qstats.

You are not plumbing the new stat into virtnet_get_base_stats()
This may be an entirely reasonable choice if you can't / don't 
want to retain the stats for the entire device (e.g. when queues
get disabled). But please explain the choice in the commit msg.

Please explain your motivation / what made you write this patch.
TBH the patches from KylinOS addresses are often slop so it would
be useful to understand whether your choices here are guided by
production experience, or not.

Last but not least, AI suggests:

> @@ -1917,8 +1919,10 @@ static struct sk_buff *receive_small_xdp(struct net_device *dev,
>  	}
>  
>  	skb = virtnet_build_skb(buf, buflen, xdp.data - buf, len);
> -	if (unlikely(!skb))
> +	if (unlikely(!skb)) {
> +		u64_stats_inc(&stats->alloc_fail);
>  		goto err;
> +	}
>  
>  	if (metasize)
>  		skb_metadata_set(skb, metasize);
The commit message says the patch counts "buffer and skb allocation
failures on the rx queue", and the uAPI description in
Documentation/netlink/specs/netdev.yaml for rx-alloc-fail says "Number of
times skb or buffer allocation failed on the Rx datapath".  Can several
allocation failure sites on the same datapath still be missed?
In this same function the earlier buffer allocation failure is not counted:
	xdp_page = xdp_linearize_page(dev, rq, &num_buf, page,
				      offset, header_offset,
				      &tlen);
	if (!xdp_page)
		goto err_xdp;
and xdp_linearize_page() returns NULL exactly on allocation failure:
	page = page_pool_alloc_pages(rq->page_pool, GFP_ATOMIC);
	if (!page)
		return NULL;
The mergeable XDP path has the same shape in receive_mergeable_xdp():
mergeable_xdp_get_buf() returns NULL when its page_pool_alloc_pages() call
fails, and that goes to err_xdp counting only xdp_drops/drops.
The AF_XDP receive path is not instrumented at all.  xsk_construct_skb(),
called from virtnet_receive_xsk_small() and virtnet_receive_xsk_merge(),
fails like this:
	skb = napi_alloc_skb(&rq->napi, size);
	if (unlikely(!skb)) {
		xsk_buff_free(xdp);
		return NULL;
	}
and xsk_append_merge_buffer() drops the remaining buffers when
napi_alloc_frag() or virtnet_skb_append_frag() fails, again without
touching alloc_fail.
So with an XSK pool bound to a queue, or with an XDP program that needs
linearization, can rx-alloc-fail stay at 0 while memory pressure is
actually causing the drops?
-- 
pw-bot: cr
