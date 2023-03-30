Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 114FAC6FD1D
	for <virtualization@archiver.kernel.org>; Thu, 30 Mar 2023 10:18:28 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 7DB504093C;
	Thu, 30 Mar 2023 10:18:28 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 7DB504093C
Authentication-Results: smtp4.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=ahm2yxlE
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id QqXqszboX_aj; Thu, 30 Mar 2023 10:18:27 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 8DD5C4094C;
	Thu, 30 Mar 2023 10:18:26 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 8DD5C4094C
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 6658EC0036;
	Thu, 30 Mar 2023 10:18:26 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id C4336C002F
 for <virtualization@lists.linux-foundation.org>;
 Thu, 30 Mar 2023 10:18:24 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 9FDDB60BBF
 for <virtualization@lists.linux-foundation.org>;
 Thu, 30 Mar 2023 10:18:24 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 9FDDB60BBF
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=ahm2yxlE
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id h8w0mM6OSx0e
 for <virtualization@lists.linux-foundation.org>;
 Thu, 30 Mar 2023 10:18:23 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 4197660B94
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 4197660B94
 for <virtualization@lists.linux-foundation.org>;
 Thu, 30 Mar 2023 10:18:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1680171502;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=D3EZsrdmO9AbrlTOEdgv57FwH1B8prEFQMdY/clsLEs=;
 b=ahm2yxlEOA6GBMp50kfSf74eQXIxLOCUcNUyasm6WK2EMY22gPEdS/RF7Roy2FGpfwXG/+
 7SLQazXqb5W2OVKuUkt1oKCvIz9GMfdk2gA5KlvWDXTWb9A1KbGb1OuHJFDzY8D+XcgGkF
 QlSMsj222dMV4I+Eb2KYIM4HjA/eVfk=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-292-YwIWqTxgMlq7ND1wzVtHAg-1; Thu, 30 Mar 2023 06:18:20 -0400
X-MC-Unique: YwIWqTxgMlq7ND1wzVtHAg-1
Received: by mail-qv1-f70.google.com with SMTP id
 6a1803df08f44-57c67ea348eso12362156d6.1
 for <virtualization@lists.linux-foundation.org>;
 Thu, 30 Mar 2023 03:18:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112; t=1680171499;
 h=mime-version:user-agent:content-transfer-encoding:references
 :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=5G4KlQgalZLZCJDa8edjfg+cOTUz1wNZ1RGVK9EOjxg=;
 b=fThaoc/KB0ZAxf5cvGP/T1cZzJjHKFyfVVkWcV7puxPGZLIVPaPU0qHqkXOX2W/e0N
 WQFQswZSYLfUFcwr8CD+7Kgbb5QmTb0r8gl/rYwBLKOxR+K7VwhyXmu0oEnKwTbDAjhh
 qHvm1AZlRJImhY/FasTJVEuWKxGWwOm+5juf4g8i/gF1tuG6Z/rKbVhWBXnJxuiS3T0i
 bGkDGEk23otAQgApSHY4GkvvmMhu7K9TFQIBFqaRUFj7GTNzqNO2FqA/DLTsbc+Czxyq
 5J++D/okug3SgTnDEuRCO8fMwuK74t+c+OZ6cUrKlav8QfS7f7x7g2922B5QeUlrF+WU
 Rd4w==
X-Gm-Message-State: AAQBX9eXxyRONwgmdebnCaNsZ0MedbDcstGfnACEgw16F96psO718oMB
 qDaGB0eBYG4S+bVfK/0Oe3gPsyIG+aSME10Ar3PW/0VLk8dIjj+TEvkGqw7fLME6jwBf2SjTfKr
 VvqfyEw8vX5XIQFsPJaxGOzYeXCakaz0Y/RDSpaxsWg==
X-Received: by 2002:a05:6214:5089:b0:57d:747b:1f7 with SMTP id
 kk9-20020a056214508900b0057d747b01f7mr1974010qvb.1.1680171499603; 
 Thu, 30 Mar 2023 03:18:19 -0700 (PDT)
X-Google-Smtp-Source: AKy350bvx8K/owgkDcL8x2YcXmXFmidn7E2vZNaiTvyyPaK6M4yc/CbTywaTxcrJm2j30ZXWyITBOQ==
X-Received: by 2002:a05:6214:5089:b0:57d:747b:1f7 with SMTP id
 kk9-20020a056214508900b0057d747b01f7mr1973988qvb.1.1680171499214; 
 Thu, 30 Mar 2023 03:18:19 -0700 (PDT)
Received: from gerbillo.redhat.com (146-241-228-125.dyn.eolo.it.
 [146.241.228.125]) by smtp.gmail.com with ESMTPSA id
 f17-20020ac84711000000b003e635f0fdb4sm169635qtp.53.2023.03.30.03.18.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 30 Mar 2023 03:18:18 -0700 (PDT)
Message-ID: <3155cdb517e0db77d8664e5623c9d39e437fd796.camel@redhat.com>
Subject: Re: [PATCH net-next 7/8] virtio_net: introduce receive_mergeable_xdp()
From: Paolo Abeni <pabeni@redhat.com>
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>, netdev@vger.kernel.org
Date: Thu, 30 Mar 2023 12:18:15 +0200
In-Reply-To: <20230328120412.110114-8-xuanzhuo@linux.alibaba.com>
References: <20230328120412.110114-1-xuanzhuo@linux.alibaba.com>
 <20230328120412.110114-8-xuanzhuo@linux.alibaba.com>
User-Agent: Evolution 3.46.4 (3.46.4-1.fc37)
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: Jesper Dangaard Brouer <hawk@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, "Michael S. Tsirkin" <mst@redhat.com>,
 John Fastabend <john.fastabend@gmail.com>, Alexei Starovoitov <ast@kernel.org>,
 virtualization@lists.linux-foundation.org, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, bpf@vger.kernel.org,
 "David S. Miller" <davem@davemloft.net>
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

Hi,

On Tue, 2023-03-28 at 20:04 +0800, Xuan Zhuo wrote:
> The purpose of this patch is to simplify the receive_mergeable().
> Separate all the logic of XDP into a function.
> 
> Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> ---
>  drivers/net/virtio_net.c | 128 +++++++++++++++++++++++----------------
>  1 file changed, 76 insertions(+), 52 deletions(-)
> 
> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> index 136131a7868a..c8978d8d8adb 100644
> --- a/drivers/net/virtio_net.c
> +++ b/drivers/net/virtio_net.c
> @@ -1316,6 +1316,63 @@ static void *mergeable_xdp_prepare(struct virtnet_info *vi,
>  	return page_address(xdp_page) + VIRTIO_XDP_HEADROOM;
>  }
>  
> +static struct sk_buff *receive_mergeable_xdp(struct net_device *dev,
> +					     struct virtnet_info *vi,
> +					     struct receive_queue *rq,
> +					     struct bpf_prog *xdp_prog,
> +					     void *buf,
> +					     void *ctx,
> +					     unsigned int len,
> +					     unsigned int *xdp_xmit,
> +					     struct virtnet_rq_stats *stats)
> +{
> +	struct virtio_net_hdr_mrg_rxbuf *hdr = buf;
> +	int num_buf = virtio16_to_cpu(vi->vdev, hdr->num_buffers);
> +	struct page *page = virt_to_head_page(buf);
> +	int offset = buf - page_address(page);
> +	unsigned int xdp_frags_truesz = 0;
> +	struct sk_buff *head_skb;
> +	unsigned int frame_sz;
> +	struct xdp_buff xdp;
> +	void *data;
> +	u32 act;
> +	int err;
> +
> +	data = mergeable_xdp_prepare(vi, rq, xdp_prog, ctx, &frame_sz, &num_buf, &page,
> +				     offset, &len, hdr);
> +	if (!data)
> +		goto err_xdp;
> +
> +	err = virtnet_build_xdp_buff_mrg(dev, vi, rq, &xdp, data, len, frame_sz,
> +					 &num_buf, &xdp_frags_truesz, stats);
> +	if (unlikely(err))
> +		goto err_xdp;
> +
> +	act = virtnet_xdp_handler(xdp_prog, &xdp, dev, xdp_xmit, stats);
> +
> +	switch (act) {
> +	case VIRTNET_XDP_RES_PASS:
> +		head_skb = build_skb_from_xdp_buff(dev, vi, &xdp, xdp_frags_truesz);
> +		if (unlikely(!head_skb))
> +			goto err_xdp;
> +		return head_skb;
> +
> +	case VIRTNET_XDP_RES_CONSUMED:
> +		return NULL;
> +
> +	case VIRTNET_XDP_RES_DROP:
> +		break;
> +	}
> +
> +err_xdp:
> +	put_page(page);
> +	mergeable_buf_free(rq, num_buf, dev, stats);
> +
> +	stats->xdp_drops++;
> +	stats->drops++;
> +	return NULL;
> +}
> +
>  static struct sk_buff *receive_mergeable(struct net_device *dev,
>  					 struct virtnet_info *vi,
>  					 struct receive_queue *rq,
> @@ -1325,21 +1382,22 @@ static struct sk_buff *receive_mergeable(struct net_device *dev,
>  					 unsigned int *xdp_xmit,
>  					 struct virtnet_rq_stats *stats)
>  {
> -	struct virtio_net_hdr_mrg_rxbuf *hdr = buf;
> -	int num_buf = virtio16_to_cpu(vi->vdev, hdr->num_buffers);
> -	struct page *page = virt_to_head_page(buf);
> -	int offset = buf - page_address(page);
> -	struct sk_buff *head_skb, *curr_skb;
> -	struct bpf_prog *xdp_prog;
>  	unsigned int truesize = mergeable_ctx_to_truesize(ctx);
>  	unsigned int headroom = mergeable_ctx_to_headroom(ctx);
>  	unsigned int tailroom = headroom ? sizeof(struct skb_shared_info) : 0;
>  	unsigned int room = SKB_DATA_ALIGN(headroom + tailroom);
> -	unsigned int frame_sz;
> -	int err;
> +	struct virtio_net_hdr_mrg_rxbuf *hdr;
> +	struct sk_buff *head_skb, *curr_skb;
> +	struct bpf_prog *xdp_prog;
> +	struct page *page;
> +	int num_buf;
> +	int offset;
>  
>  	head_skb = NULL;
>  	stats->bytes += len - vi->hdr_len;
> +	hdr = buf;
> +	num_buf = virtio16_to_cpu(vi->vdev, hdr->num_buffers);
> +	page = virt_to_head_page(buf);
>  
>  	if (unlikely(len > truesize - room)) {
>  		pr_debug("%s: rx error: len %u exceeds truesize %lu\n",
> @@ -1348,51 +1406,21 @@ static struct sk_buff *receive_mergeable(struct net_device *dev,
>  		goto err_skb;
>  	}
>  
> -	if (likely(!vi->xdp_enabled)) {
> -		xdp_prog = NULL;
> -		goto skip_xdp;
> -	}
> -
> -	rcu_read_lock();
> -	xdp_prog = rcu_dereference(rq->xdp_prog);
> -	if (xdp_prog) {
> -		unsigned int xdp_frags_truesz = 0;
> -		struct xdp_buff xdp;
> -		void *data;
> -		u32 act;
> -
> -		data = mergeable_xdp_prepare(vi, rq, xdp_prog, ctx, &frame_sz, &num_buf, &page,
> -					     offset, &len, hdr);
> -		if (!data)
> -			goto err_xdp;
> -
> -		err = virtnet_build_xdp_buff_mrg(dev, vi, rq, &xdp, data, len, frame_sz,
> -						 &num_buf, &xdp_frags_truesz, stats);
> -		if (unlikely(err))
> -			goto err_xdp;
> -
> -		act = virtnet_xdp_handler(xdp_prog, &xdp, dev, xdp_xmit, stats);
> -
> -		switch (act) {
> -		case VIRTNET_XDP_RES_PASS:
> -			head_skb = build_skb_from_xdp_buff(dev, vi, &xdp, xdp_frags_truesz);
> -			if (unlikely(!head_skb))
> -				goto err_xdp;
> -
> +	if (likely(vi->xdp_enabled)) {

This changes the branch prediction hint compared to the existing code;
as we currently have:
	if (likely(!vi->xdp_enabled)) {


and I think it would be better avoid such change.

Thanks,

Paolo

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
