Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 738423C8C69
	for <virtualization@lists.linux.dev>; Tue, 16 Jun 2026 04:40:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781584810; cv=none; b=tB+xHXwbYvtVn9uIJpURtvHeXFZVof5YAZf4dNfUqlPuZElHd6aXi2J8PXG5aEpI7ms+2bZ0lWUSacRLEfuCCivNZRElIlVmfcU2HIAwKFH2fznB5pbnbfVOl3HV7HbGjgRMA2ZswEBp/aFFTz2PVNAhrfg6VVhlvSwjj/4uOrw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781584810; c=relaxed/simple;
	bh=K0KBXkkerxODXYIYqDg633MvdlbzP4uKtATH407a6no=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=Px+2PwawmxPLmSKkFlD0GjOkd7uu5WaCRSkriHB3UF0BF2LZdLVsQYZv3cQsXX1OkJNB7VBtfz3Q5VUrh5n8c/OtZqBBWbe4CCFqbya5ndAKKT2nrMQljeI8E9JTqAqKGTaO+jV6Tzp6EqQhbX+6zGTUoUxCJdmXmexGW9w3PEE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=QWG2T6PA; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QWG2T6PA"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1781584808;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Fa+y+4svYLao6WVKf5RjVtNUrFzhHWJGrO40meUSAic=;
	b=QWG2T6PA/VYUzFce127sa71gfG1794nS0IBn+81K/oGvYbv1rxT8zKRMp9QmsXpb5R0ku9
	A5GVecZnpDgLz2qlbeC9B1DrS4FqB0MPGsFRMvNNpE7BAzHd6pVQ5gQOLmYXuYyZA445st
	Dv/pioWots0p3gEdBD9qLuafJqTBvx8=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-573-I-A4XtU8Mo6jqk-x9K8Vgg-1; Tue, 16 Jun 2026 00:40:04 -0400
X-MC-Unique: I-A4XtU8Mo6jqk-x9K8Vgg-1
X-Mimecast-MFC-AGG-ID: I-A4XtU8Mo6jqk-x9K8Vgg_1781584804
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-460153ce644so2958864f8f.0
        for <virtualization@lists.linux.dev>; Mon, 15 Jun 2026 21:40:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781584803; x=1782189603;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Fa+y+4svYLao6WVKf5RjVtNUrFzhHWJGrO40meUSAic=;
        b=e/RWMjKIZbi34nrssDCFAu5pVfGnch/+zM9YkXSTsnrzMiSGCN2mv657/VFaPk040N
         Nnk6D4VYChMQX/ZhZm4ikKUODkWlCU2uU9yDc/fn5ENICzO6J2Pvaz3Ch3Lh9760t5sc
         mevXQlKu5kLgZZJp/eMg5yliLoaZo9wint2NLMJKtJpF+HlDiK6v1mAizHJ2eVfTq1px
         eLMV6Gk2YQTkS6pCEVCqD+CU2DV+qVo5ljLESuxUEgKggM72te++QvqSEkXD49Y3uEcS
         SsrHjQuArKOQ8hNxBzL/pNEsdK+1um6i/itHhL0DzhTEPcWrqhptDMggk1qNBT9KrQYH
         viWA==
X-Forwarded-Encrypted: i=1; AFNElJ96GxL519JydPwvd9nMWzNIL70GV9Aqax0rK/EruCAfVh9w6vLGlrF3f51tgU6eFPPKg+jW9naAHTgl40NsWw==@lists.linux.dev
X-Gm-Message-State: AOJu0Yx2rVCViPeFpwT6/owNyFJSGA65f/ghRA3bhaQRgMb+FYx+K416
	gRwlTcurrEfDK8qWmI9Tg8RLE0rxW2yN/giu6CSDV0i9H27wsxeevfREIHC+d88ApOP2HxOH16C
	Sq4Sje9xrVdx3IIoXCOjnYap+upS0ENu1ClOmSzAejkHf6rTcfoh0Dhtptv/FOubA6Hb8
X-Gm-Gg: Acq92OGLEpxW0Fyw7Rb10R3Phxk3JeWMPiClv/QUDqX/rzgUl5/rYi7kq4BQEPqUbAL
	GmBd7a/cbJ+dWs4qqcrruRqgdaT/FBjNHzq0lEbmF6aO8rxEi7BDBL8KxjnigcfCDqQ3606n+p7
	pfcZJYHk2ndzK1GWqDd/gnnAtehJSrW7DnJNcB00qLit15EXt/ZPoDkwMwPia731oymOhVi5rPh
	uAwjk//sbL9zGvZFYAZUBXmA/fMsXlDWRuKdcu70meHL7DF/Abm+gUXOwwg5m72GLUNumQ2/WJv
	v6szqSg/pBPym7aGmytN+Z+gTdR4XRxRKKRG+7cxTW8pkfHa50ga+lmMTeZxX6y5IoVil+d9tZR
	/0pDKPfwMbECarY5oDnmeQh+jEy1lwLlwK+eVCMLSPW4=
X-Received: by 2002:a05:600c:4e8c:b0:492:3173:b17 with SMTP id 5b1f17b1804b1-49231730dafmr4650605e9.17.1781584803452;
        Mon, 15 Jun 2026 21:40:03 -0700 (PDT)
X-Received: by 2002:a05:600c:4e8c:b0:492:3173:b17 with SMTP id 5b1f17b1804b1-49231730dafmr4650265e9.17.1781584802949;
        Mon, 15 Jun 2026 21:40:02 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-85-71.inter.net.il. [80.230.85.71])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49230a4ff67sm23740805e9.6.2026.06.15.21.40.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Jun 2026 21:40:01 -0700 (PDT)
Date: Tue, 16 Jun 2026 00:39:58 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Xiang Mei <xmei5@asu.edu>
Cc: jasowang@redhat.com, xuanzhuo@linux.alibaba.com, eperezma@redhat.com,
	andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org,
	virtualization@lists.linux.dev, linux-kernel@vger.kernel.org,
	minhquangbui99@gmail.com, bestswngs@gmail.com
Subject: Re: [PATCH net v4] virtio-net: fix len check in receive_big()
Message-ID: <20260616003903-mutt-send-email-mst@kernel.org>
References: <20260616042837.2249468-1-xmei5@asu.edu>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20260616042837.2249468-1-xmei5@asu.edu>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: fgpN-zMXxUT0h1zSXpiFFCEwbRhuCvwcJJ-T8MtWhOQ_1781584804
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Jun 15, 2026 at 09:28:37PM -0700, Xiang Mei wrote:
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
> Reviewed-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>

Acked-by: Michael S. Tsirkin <mst@redhat.com>

> ---
> v4: use easy to understand math to compute the max_len
> v3: revoke 2/2 and add Xuan Zhuo's Reviewed-by tag

I still feel 2/2 is good defence in depth but it can be
pursued separately.

> v2: add additiona check as 2/2
> 
>  drivers/net/virtio_net.c | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> index f4adcfee7a80..8f4562316aaa 100644
> --- a/drivers/net/virtio_net.c
> +++ b/drivers/net/virtio_net.c
> @@ -1999,15 +1999,16 @@ static struct sk_buff *receive_big(struct net_device *dev,
>  				   struct virtnet_rq_stats *stats)
>  {
>  	struct page *page = buf;
> +	unsigned long max_len = (vi->big_packets_num_skbfrags + 1) * PAGE_SIZE -
> +				sizeof(struct padded_vnet_hdr) + vi->hdr_len;
>  	struct sk_buff *skb;
>  
>  	/* Make sure that len does not exceed the size allocated in
>  	 * add_recvbuf_big.
>  	 */
> -	if (unlikely(len > (vi->big_packets_num_skbfrags + 1) * PAGE_SIZE)) {
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

