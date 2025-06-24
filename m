Received: from out30-130.freemail.mail.aliyun.com (out30-130.freemail.mail.aliyun.com [115.124.30.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F34423BCFF
	for <virtualization@lists.linux.dev>; Tue, 24 Jun 2025 08:27:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750753637; cv=none; b=pEmZ+Cx7EDiZYheznXXaGOvbQL1+zoFjs55uOBkoX1m4V+8/6bE04pN3TpzfYkOqUc68yMtI/res9X7TGVx7V5fSHHmhoko7aysKB+4cryD0hpRX4B6yCjjQT54lD3E4c8+5fKcMDpOJOmGq93QNt+GShISZsXK5P1idz0fkd1k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750753637; c=relaxed/simple;
	bh=IP9zZ6vX1r03ltWl8w9ViI+/XIllLTAlSCc4K5E75r8=;
	h=Message-ID:Subject:Date:From:To:Cc:References:In-Reply-To; b=jb/RoJGqf3gSB/TBHiRMiC6Z3UXmjbKtETLAFUDUy0nXmv06yYe2p0ShNAMN7qFl7pezBM138GoqveQeMdlaDmYJU9oa9aJnSQzGtjyJnJetRM1o0j7PkwXRArL6wbYKi6ENGP13Rt/g4vuIBOi4BC3bv5SeA7X6YxV291V/ZCg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=i/8+Xitu; arc=none smtp.client-ip=115.124.30.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="i/8+Xitu"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1750753632; h=Message-ID:Subject:Date:From:To;
	bh=xto8ohKa0ryNBVBrFTAZ50J9YmnkUMJE78zO1Eob+DM=;
	b=i/8+XituebggDz3LQBZl5B+k0RLDgie3MFN8Q22jn4wcfxNetb6WjvlVUzkf3iTUshCF2ZYRy4EFn4yZ9FKPL/OjtnzA1n9+Yifqgulw3SOseW65c6eGDrRagsyJElV1SCcqEOXHDyLTow0ChdGdnWeAKWNCvcaDaSm9I7p0nzk=
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com fp:SMTPD_---0WegCBpn_1750753630 cluster:ay36)
          by smtp.aliyun-inc.com;
          Tue, 24 Jun 2025 16:27:11 +0800
Message-ID: <1750753624.9023402-5-xuanzhuo@linux.alibaba.com>
Subject: Re: [PATCH net v2 2/2] virtio-net: xsk: rx: move the xdp->data adjustment to buf_to_xdp()
Date: Tue, 24 Jun 2025 16:27:04 +0800
From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
To: Bui Quang Minh <minhquangbui99@gmail.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>,
 Jason Wang <jasowang@redhat.com>,
 =?utf-8?q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>,
 Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>,
 Jesper Dangaard Brouer <hawk@kernel.org>,
 John Fastabend <john.fastabend@gmail.com>,
 virtualization@lists.linux.dev,
 linux-kernel@vger.kernel.org,
 bpf@vger.kernel.org,
 Bui Quang Minh <minhquangbui99@gmail.com>,
 netdev@vger.kernel.org
References: <20250621144952.32469-1-minhquangbui99@gmail.com>
 <20250621144952.32469-3-minhquangbui99@gmail.com>
In-Reply-To: <20250621144952.32469-3-minhquangbui99@gmail.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>

On Sat, 21 Jun 2025 21:49:52 +0700, Bui Quang Minh <minhquangbui99@gmail.com> wrote:
> This commit does not do any functional changes. It moves xdp->data
> adjustment for buffer other than first buffer to buf_to_xdp() helper so
> that the xdp_buff adjustment does not scatter over different functions.
>
> Signed-off-by: Bui Quang Minh <minhquangbui99@gmail.com>

Reviewed-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>

> ---
>  drivers/net/virtio_net.c | 16 ++++++++++++++--
>  1 file changed, 14 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> index 1eb237cd5d0b..4e942ea1bfa3 100644
> --- a/drivers/net/virtio_net.c
> +++ b/drivers/net/virtio_net.c
> @@ -1159,7 +1159,19 @@ static struct xdp_buff *buf_to_xdp(struct virtnet_info *vi,
>  		return NULL;
>  	}
>
> -	xsk_buff_set_size(xdp, len);
> +	if (first_buf) {
> +		xsk_buff_set_size(xdp, len);
> +	} else {
> +		/* This is the same as xsk_buff_set_size but with the adjusted
> +		 * xdp->data.
> +		 */
> +		xdp->data = xdp->data_hard_start + XDP_PACKET_HEADROOM;
> +		xdp->data -= vi->hdr_len;
> +		xdp->data_meta = xdp->data;
> +		xdp->data_end = xdp->data + len;
> +		xdp->flags = 0;
> +	}
> +
>  	xsk_buff_dma_sync_for_cpu(xdp);
>
>  	return xdp;
> @@ -1284,7 +1296,7 @@ static int xsk_append_merge_buffer(struct virtnet_info *vi,
>  			goto err;
>  		}
>
> -		memcpy(buf, xdp->data - vi->hdr_len, len);
> +		memcpy(buf, xdp->data, len);
>
>  		xsk_buff_free(xdp);
>
> --
> 2.43.0
>
