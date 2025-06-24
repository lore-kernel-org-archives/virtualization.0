Received: from out30-100.freemail.mail.aliyun.com (out30-100.freemail.mail.aliyun.com [115.124.30.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75B2722069F
	for <virtualization@lists.linux.dev>; Tue, 24 Jun 2025 08:05:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750752341; cv=none; b=nGs3s/j5JgnAA3dkaPT5KZUI/fjkoqd1ukbCN/8oseTvcC0zPAuRKFMqZATFRmVwRwfg9fGNyllx1VWnqemYOmo7otT/s3N4XMmxzpEkxpCWW8YKBIMCNv6IWWx0b4BEZrFyJce8bFIWt1VgEa3fL468EjvmTOBSTGn3XuggAfY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750752341; c=relaxed/simple;
	bh=OOHl80Amv7LsMw/nLpiLiGVcG1W77N8pyOuxxY52d2c=;
	h=Message-ID:Subject:Date:From:To:Cc:References:In-Reply-To; b=N7rHTrOnBopHNLEpI6S+iMau5aHbOUVkSmrb9wcgGh7E7/7nBFQas5BpqUwbrTIanIOSDc9zSHurK6fjT1dYrRU9na8N5jy2JF9dWPFObCgq2sPN97VY3lMOwoshLlNG2vUqn6Po1+QSeDsQL6h9H0zqrCrfx5ftQrQRkFHwZD4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=hoyNEHoY; arc=none smtp.client-ip=115.124.30.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="hoyNEHoY"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1750752333; h=Message-ID:Subject:Date:From:To;
	bh=c4oc/DhyhfboKsUraQ8BYgRzmZfqoCc+i4h7UMv5VHY=;
	b=hoyNEHoYRNJ6rjldCgPCsJifjEs8qQr5B/k2KI11Y1RJzHAvMTRjacqEfNVhU9wgZ34Qrh1xAJqae5mTGEQ3J6+6xeWkLi1aCwUvHbAA5TgoUAABxnHwwPP4EabPvEq7b/yN8n0FZs7ZxNdk0lVtgknqBN9IIx/RkjAJt21TTQA=
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com fp:SMTPD_---0Wefzrg-_1750752332 cluster:ay36)
          by smtp.aliyun-inc.com;
          Tue, 24 Jun 2025 16:05:33 +0800
Message-ID: <1750752321.449211-2-xuanzhuo@linux.alibaba.com>
Subject: Re: [PATCH] virtio: virtio_dma_buf: fix missing parameter documentation
Date: Tue, 24 Jun 2025 16:05:21 +0800
From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
To: WangYuli <wangyuli@uniontech.com>
Cc: virtualization@lists.linux.dev,
 linux-kernel@vger.kernel.org,
 zhanjun@uniontech.com,
 niecheng1@uniontech.com,
 guanwentao@uniontech.com,
 WangYuli <wangyuli@uniontech.com>,
 mst@redhat.com,
 jasowang@redhat.com,
 eperezma@redhat.com
References: <241C7118259DA110+20250623065210.270237-1-wangyuli@uniontech.com>
In-Reply-To: <241C7118259DA110+20250623065210.270237-1-wangyuli@uniontech.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>

On Mon, 23 Jun 2025 14:52:10 +0800, WangYuli <wangyuli@uniontech.com> wrote:
> Add missing parameter documentation for virtio_dma_buf_attach()
> function to fix kernel-doc warnings:
>
> Warning: drivers/virtio/virtio_dma_buf.c:41 function parameter 'dma_buf' not described in 'virtio_dma_buf_attach'
> Warning: drivers/virtio/virtio_dma_buf.c:41 function parameter 'attach' not described in 'virtio_dma_buf_attach'
>
> The function documentation was missing descriptions for both the
> 'dma_buf' and 'attach' parameters. Add proper parameter documentation
> following kernel-doc format.
>
> Signed-off-by: WangYuli <wangyuli@uniontech.com>

Reviewed-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>

> ---
>  drivers/virtio/virtio_dma_buf.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/drivers/virtio/virtio_dma_buf.c b/drivers/virtio/virtio_dma_buf.c
> index 3fe1d03b0645..95c10632f84a 100644
> --- a/drivers/virtio/virtio_dma_buf.c
> +++ b/drivers/virtio/virtio_dma_buf.c
> @@ -36,6 +36,8 @@ EXPORT_SYMBOL(virtio_dma_buf_export);
>
>  /**
>   * virtio_dma_buf_attach - mandatory attach callback for virtio dma-bufs
> + * @dma_buf: [in] buffer to attach
> + * @attach: [in] attachment structure
>   */
>  int virtio_dma_buf_attach(struct dma_buf *dma_buf,
>  			  struct dma_buf_attachment *attach)
> --
> 2.50.0
>
