Received: from out30-119.freemail.mail.aliyun.com (out30-119.freemail.mail.aliyun.com [115.124.30.119])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB72D25C837
	for <virtualization@lists.linux.dev>; Tue, 24 Jun 2025 08:27:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.119
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750753625; cv=none; b=IlAjUODKDsNNQ0ILG0HYEHYIxdtAfy106rXHVx7MuEBzfZnVD4H76f0uIdg53xsqsrIzqgOkrCGRPO2Xlj10StqYlgw62nVsesYm1xz2MxXfa8zDJFMErsak5GD2ermxf5iXZtZYrXm7ZTQCfvINPMqU1KqqWwS2U7+6SgKlpeM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750753625; c=relaxed/simple;
	bh=MkhaNNhb/Nnu9+FEGNMen7PIoUiQXmzj3D47cfEMJU4=;
	h=Message-ID:Subject:Date:From:To:Cc:References:In-Reply-To; b=dFust071WIIEnwO0K0YCi3Xr8XGWF0sO7f282XJs+Fj+RnQi9+q2Ltp4x34kM6BW+UG4b1LWr2FawpL0QdvzNYVix/NWaZWy8n1xq7wo9cd5SzYtbXBXiVAIs+GdAFJfDlMpFgNAqETPZNm13EeD2zu/qlKN+b6JkH5IwNQNAqQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=MNtZQFKi; arc=none smtp.client-ip=115.124.30.119
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="MNtZQFKi"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1750753615; h=Message-ID:Subject:Date:From:To;
	bh=IH71r0a24x4p09xci6xK0RIn16ZYIq9aUYduNMvc6Vc=;
	b=MNtZQFKi96X4+NCXZ+zAUIcw3kfotjZ9xKPZcTxGHotnziCmn7U/13XWQVy1+9VpXS8Da8bE63MmEidF2hHa97nYEzQ3ZiuqdCfK0xNYiPEMgE+LKYQdJ2/mSFvwo4YpmW78GTvRSagWELD8lC56QqgWhrYMeNPHevWVfSdKtcI=
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com fp:SMTPD_---0Weg--9u_1750753614 cluster:ay36)
          by smtp.aliyun-inc.com;
          Tue, 24 Jun 2025 16:26:55 +0800
Message-ID: <1750753610.4544265-4-xuanzhuo@linux.alibaba.com>
Subject: Re: [PATCH net v2 2/2] virtio-net: xsk: rx: move the xdp->data adjustment to buf_to_xdp()
Date: Tue, 24 Jun 2025 16:26:50 +0800
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
