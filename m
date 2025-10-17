Received: from out30-100.freemail.mail.aliyun.com (out30-100.freemail.mail.aliyun.com [115.124.30.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47B1B433BC
	for <virtualization@lists.linux.dev>; Fri, 17 Oct 2025 00:58:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760662685; cv=none; b=Cyk5JKP/6muYalr9nk89x8n6v/fKl1rng8dMT+4qAG3zgkN9HkOWzvCpFhQGPqNdWroGl0KHTreKf5SFQjuPnfaq0ZLXuWtU2j55r4x+30HIQwKkOjMZLWFD86SNipGk8XaVCa6rmsDlgQbsgmPK5qgeZlMyrHHyNF5W1VYvtG4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760662685; c=relaxed/simple;
	bh=cikAfzhjErC0zNYhTw+YhZa1pZhEIUvvHOKlGbvjKac=;
	h=Message-ID:Subject:Date:From:To:Cc:References:In-Reply-To; b=JToPvgiDH8ihQK/Nb1UkjrmjxT84HZsTao5LFp3iVx7UwXGknfsRh8TZiytlodRmgFN5x4SV3MrS5e1g1C0B6Z95qAGuMUTIxd/dMgMZKaNEoJV5DoV7ct466mUwVEbP/NaKURRFoWVTPcdy9g4Biw2Kwi5WbxFeyx6Wy2joWiY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=RFTiJfSa; arc=none smtp.client-ip=115.124.30.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="RFTiJfSa"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1760662679; h=Message-ID:Subject:Date:From:To;
	bh=bIANy4Ycj+HBtemaCXpipLOBIsrD9gM6qo8E04r1ozY=;
	b=RFTiJfSaB2GogOY1bXunslwOnjhAS+htXjXQCvNLUrrvl94gJZ/P0opbQLkry2BL38HES3L55chVxRtZ0dL8Tv+8XkecGUmaS9GfHpFHhdsCU5Cocg2n/siDA9iSESSEJtqU4W3DIhOXavh5C6rz0qmCqc4jTfkgCp5qhHh0bH4=
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com fp:SMTPD_---0WqMOOPm_1760662678 cluster:ay36)
          by smtp.aliyun-inc.com;
          Fri, 17 Oct 2025 08:57:59 +0800
Message-ID: <1760662656.1338146-1-xuanzhuo@linux.alibaba.com>
Subject: Re: [PATCH net] virtio_net: fix header access in big_packets mode
Date: Fri, 17 Oct 2025 08:57:36 +0800
From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
To: Wen Xin <w_xin@apple.com>
Cc: mst@redhat.com,
 jasowang@redhat.com,
 eperezma@redhat.com,
 virtualization@lists.linux.dev,
 Wen Xin <w_xin@apple.com>,
 netdev@vger.kernel.org
References: <20251016223305.51435-1-w_xin@apple.com>
In-Reply-To: <20251016223305.51435-1-w_xin@apple.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>

http://lore.kernel.org/all/20251013020629.73902-1-xuanzhuo@linux.alibaba.com

do the same thing.


On Thu, 16 Oct 2025 15:33:05 -0700, Wen Xin <w_xin@apple.com> wrote:
> In Linux virtio-net driver's (drivers/net/virtio_net.c) big packets mode (vi->big_packets && vi->mergeable_rx_bufs), the buf
> pointer passed to receive_buf() is a struct page pointer, not a buffer
> pointer. The current code incorrectly casts this page pointer directly as
> a virtio_net_common_hdr, causing it to read flags from the page struct
> memory instead of the actual packet data.
>
> Signed-off-by: Wen Xin <w_xin@apple.com>
> ---
>  drivers/net/virtio_net.c | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> index 7646ddd9bef7..c10f5585bc88 100644
> --- a/drivers/net/virtio_net.c
> +++ b/drivers/net/virtio_net.c
> @@ -2566,7 +2566,13 @@ static void receive_buf(struct virtnet_info *vi, struct receive_queue *rq,
>  	 * virtnet_xdp_set()), so packets marked as
>  	 * VIRTIO_NET_HDR_F_NEEDS_CSUM get dropped during XDP processing.
>  	 */
> -	flags = ((struct virtio_net_common_hdr *)buf)->hdr.flags;
> +	if (vi->big_packets && !vi->mergeable_rx_bufs) {
> +		struct virtio_net_common_hdr *hdr = page_address((struct page *)buf);
> +
> +		flags = hdr->hdr.flags;
> +	} else {
> +		flags = ((struct virtio_net_common_hdr *)buf)->hdr.flags;
> +	}
>
>  	if (vi->mergeable_rx_bufs)
>  		skb = receive_mergeable(dev, vi, rq, buf, ctx, len, xdp_xmit,
> --
> 2.39.5 (Apple Git-154)
>
