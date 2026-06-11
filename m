Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3130E30D3F6
	for <virtualization@lists.linux.dev>; Thu, 11 Jun 2026 05:56:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781157395; cv=none; b=sKLjguHkp0GBpsOqmLSB+GjPZ/Bd5Y5/MXpN2GxThHAXIXWwareccJ1L6sAjSVSxrCz2yXL8B+pQg6m9V6GTOCdGFRDsZ1RILcSipjqUX41GJPIpxDXIvJhPyRY5Bd94QeI+2jY5JuppC+tTuYPeWcQaydDcym64afJkzdXJsNw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781157395; c=relaxed/simple;
	bh=8RgB4L/mtyXUigOfElNRhYNFAjXq4m+NZ5s58y2e468=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=rjTWzIaDmkrLlVRnAxhyLRM99dwV7c33cgFkybG2VN6J2823Jz2rl1MNHM7I+zQR7TKYPi3r+PRM5RaiT+bbtvIQehtDZsezp1l125nFB3wBB97tnqowrxfoeoxwTNVCLuxeCPC0snznaLVNTdtzk3p/FufSk0RvUDEXj1VnFig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=FJ0b9/Rs; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FJ0b9/Rs"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1781157393;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=2NVtvAee8olyH9I5i9y9HtNMlvI+nO9nnsWLj7hlmuk=;
	b=FJ0b9/Rsm6IZ54JvweCSjDeZuESR0up/Z9WsQqqeRFBBwgPtRvYI2Bpol4RBKrhEcgkpuG
	m8AHqHwLbY6FTOitrcPO3ChlCN+4jWmIntVqXKeaMABheWWTiDqDJO0rQLEg/iAPXH3pH6
	IH7eFvBcspsWl29j9nXdjN9hl9/Tzg4=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-623-yAhniBsfPnuP5zaFjjGdUQ-1; Thu, 11 Jun 2026 01:56:32 -0400
X-MC-Unique: yAhniBsfPnuP5zaFjjGdUQ-1
X-Mimecast-MFC-AGG-ID: yAhniBsfPnuP5zaFjjGdUQ_1781157391
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-45ef9437b7aso4838165f8f.0
        for <virtualization@lists.linux.dev>; Wed, 10 Jun 2026 22:56:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781157391; x=1781762191;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2NVtvAee8olyH9I5i9y9HtNMlvI+nO9nnsWLj7hlmuk=;
        b=M6rUoIZlovI/fH053jC+Z1YZOqaV7zamI+uFBJLsq7YZu5eiwgm7IYEQ6oDwejODjc
         vYTeoxGOrpuUtr7fZgGjagmJaKXDxr3aWzDV8hTZ1l56VAt5f/opgFFfYTI6pFG1tyZE
         z0Y8BiViSDzt1gXEWdu0bXJ3s3XK2NRtotlI8YM4tkn2Sd5TmbgIluHA1xopOITax+B4
         buNdKrAaisr6ae+nXFWGAzTPxzKKwYajfmlPq6UrSsDsSUjCOcvIMNO9EEgllzQ99BU6
         p1rZ8MU638/WqfZp3/ZIrgO0iRtXz1/omD0qXyiaG1Pd0Jd4KmcHFLWzA80ezlWKeU8K
         W0BA==
X-Forwarded-Encrypted: i=1; AFNElJ+Mz3g3vJiw6taAKYl75TQeUOaYQLAjxVzlGRQXlsVFLneYARcimdcDVz8d3Bg+wo4um3Xf59JhNfOu0UHQNQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YwlDt8i819Xw5jIIEV5ddW4cvW9S5zxokMeeCZK1dvC6rL8c+Is
	YcEko8MZYmF1hJi0L8mPWYah97NJtNJSMo111bXe9WyRol18cAeM428RQuPr1pW/8cbuFkk5Qhn
	K9CIiWu//zrUKDQJPvL4MjJ0bRdpD2DKWYvZr3LEWYL+R/doLR9Ixn1pMW/0N38366/zK
X-Gm-Gg: Acq92OHE1PbyCcFFz/VqfV4Uq+2d6SKKE3eG0TJG3MDMQEUOoROSMlTR12PHJBe1+4a
	xCrLBAxsxdYvKWac8fYpha8mo+/FlmDS5Fmw19nn4bJ9M/LjQXnj33Jp0+Zn1U2TF/bQ46ml69Z
	4WAOu27Fhu/1IsshNiRCQj+Nzxp0LbzeYM2AfqlBE75ymnm5LOw8EIglHBoNfGgxcR4peIcT2+l
	EHnhxXcNrVqLJqQsOTtBxphczrA2o01x4DIbRSgVSRlOTVvg2+sB6alU87QU8NsiR3/C8/V0JJE
	yn9Mpa2iVgVv7b2PBdIGiKQ9L2NZB+SmnK1O+Q3CZ+zYWsK5zqZTM3d5v9tZH+KECfcSrjeLOVr
	4u1/LbAk55uswoSkWrPyoJch4yAxVGmOBOCmVuFBGJEdj+YbuPj4Fjg==
X-Received: by 2002:a05:6000:490c:b0:45e:f52b:f4b7 with SMTP id ffacd0b85a97d-46067593598mr1505318f8f.17.1781157390708;
        Wed, 10 Jun 2026 22:56:30 -0700 (PDT)
X-Received: by 2002:a05:6000:490c:b0:45e:f52b:f4b7 with SMTP id ffacd0b85a97d-46067593598mr1505285f8f.17.1781157390190;
        Wed, 10 Jun 2026 22:56:30 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-85-71.inter.net.il. [80.230.85.71])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4601f3446aesm85429628f8f.24.2026.06.10.22.56.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Jun 2026 22:56:29 -0700 (PDT)
Date: Thu, 11 Jun 2026 01:56:26 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Xiang Mei <xmei5@asu.edu>
Cc: jasowang@redhat.com, xuanzhuo@linux.alibaba.com, eperezma@redhat.com,
	andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org,
	virtualization@lists.linux.dev, linux-kernel@vger.kernel.org,
	minhquangbui99@gmail.com, bestswngs@gmail.com
Subject: Re: [PATCH net v3] virtio-net: fix len check in receive_big()
Message-ID: <20260611014519-mutt-send-email-mst@kernel.org>
References: <20260611024616.1408317-1-xmei5@asu.edu>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20260611024616.1408317-1-xmei5@asu.edu>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: NZ81Kuu5OzuJgr0jxULCJKBnDCuhoof2GtORqdfGqPI_1781157391
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Jun 10, 2026 at 07:46:16PM -0700, Xiang Mei wrote:
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

Thanks for the patch! Something small to improve:

> ---
> v3: revoke 2/2 and add Xuan Zhuo's Reviewed-by tag
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

Assignment can happen here?

>  	struct sk_buff *skb;
>  
>  	/* Make sure that len does not exceed the size allocated in
>  	 * add_recvbuf_big.
>  	 */
> -	if (unlikely(len > (vi->big_packets_num_skbfrags + 1) * PAGE_SIZE)) {
> +	max_len = vi->hdr_len + (PAGE_SIZE - sizeof(struct padded_vnet_hdr)) +
> +		  vi->big_packets_num_skbfrags * PAGE_SIZE;

Took me a while to figure out what is going on, but I finally
understand:


Reducing
(vi->big_packets_num_skbfrags + 1) * PAGE_SIZE 

(what we allocated)

by sizeof(struct padded_vnet_hdr) - vi->hdr_len


right?

So clearer as:


	unsigned long max_len = (vi->big_packets_num_skbfrags + 1) * PAGE_SIZE -
	sizeof(struct padded_vnet_hdr) + vi->hdr_len;




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

