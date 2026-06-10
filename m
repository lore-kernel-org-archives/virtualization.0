Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 181E4336885
	for <virtualization@lists.linux.dev>; Wed, 10 Jun 2026 23:35:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781134512; cv=none; b=JhT/8/C/SnwpSx0km+To5qJwhOfEtVQpc/+ZbpWpYGD4MMIcSnK4Wk8FpIbXpL53IQ2OuoTl6MOAbnm23vs6KVpMa/En2zc4wIJmA9o7/UHCPPxhdFXWFcVQlm9Wivr8eaZ07gxYfNK1qXoNKaGWI7Iw8XsHB3KmslfomXsW36E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781134512; c=relaxed/simple;
	bh=Q0GHcH8Um8SH1FpKA3xq0Nka+lgPxYfvFIDdo8kKVp8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kvV6GwRhHYFy/ml82bb5RGHpcgvPFisCp+/Pfyq9lrPJLRBEPv7gj8acOD7bXmWTYZtvW1q5QCufP5u9tgN+hvGwpbgimNZE7n90xqYEGknRLWWKsx4L1gAvEnV7OZIn7h8e6G32mtLp9mK7Y2Luw3kml2m/CmVGCp4ZNIwBG9g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=asu.edu; spf=pass smtp.mailfrom=asu.edu; dkim=pass (2048-bit key) header.d=asu.edu header.i=@asu.edu header.b=EAqpr+Lp; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=asu.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=asu.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=asu.edu header.i=@asu.edu header.b="EAqpr+Lp"
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-2bf237e1433so80198015ad.1
        for <virtualization@lists.linux.dev>; Wed, 10 Jun 2026 16:35:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=asu.edu; s=google; t=1781134509; x=1781739309; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=6Gu9x5/y7r12LiwFW9csPbVwnmzWa33CTWccxkH9Atw=;
        b=EAqpr+Lp252PUklYdTga61jBgODFotwvLsH000Ph/LKF8ZXlfZn/Gzr4OlO150+0mv
         CvQTZOrWnJTPiaTKvQpPYcUplN+zVbxcYdDcJYxEaElPB+9VXQB4kR/3pI9QQqM0wbV8
         5v24onbvbTAiGgD7zqwIlLTlXz1tMzt3ewKKLqFWh7QT05XcGC3lJr/81XKz2RK/ba2v
         J1O1RsT1NOiFPl3/d2es28Vf7iFAfe+ORvzeC8ZK0/RtFRp+eeuE5hMLtwSzy0r1szAQ
         qXOBV38/CddLaovn9F4vkdL/GMbXWDlThbvPSbcq71gkUXpxYok1YUy1LysdzRcW2QJE
         j3Yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781134509; x=1781739309;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6Gu9x5/y7r12LiwFW9csPbVwnmzWa33CTWccxkH9Atw=;
        b=MitDmNgO/bPiaHws+HLKUqBtInHw9u2DJZ5rfEHe7+vdxKMMnfooc5tPEudtYZ3xrB
         ecVGMdV4F05fwaSlP+sFM/Bwj4VQamIu3aBihrl8asuJ2ynaRx/8Mab4rkEhMPHu4xa0
         FDesy2Oy/+RIaN/D7J7CkXrUOVykBWCxPNV1N5YGdMbSseOyz+B2avNskB14kvf+ay8l
         D1lza5r6sf++6iPLWymovUDZfMKfscHyiYQDvUEDo0R/y/WyYKF4IDGfvBlFtFj8KWmh
         D+b2RiXmPxL4iLbtNuOlTnmQQPuoM5Q9MonZBjs/kpB6z9QZXz6fwI9NmxYINb56niN6
         bc2w==
X-Forwarded-Encrypted: i=1; AFNElJ/JpnAJALpFWJXyGcR0/1dnxxgGL48yw5NyYUCAmh7tXk9yH6Tv9HT+YsR7QRte7pH2mW3tBcu9kXwQaaBl+A==@lists.linux.dev
X-Gm-Message-State: AOJu0YyfNwa8PaxEavt36QZYCx+hmA4y7eytCrfnrojuok5S34MqStdq
	hxZvE6FYAgaUw859dIbiDlHB+MjlvP57PWrJ2XL1HdQMrOtNJxjA9pej1ZsPj+/Rhg==
X-Gm-Gg: Acq92OFeoW5PVfr+8/92zzuJs0wIP4EmaZiwIR9AMdk6gpxl/38Zpf8SIvl+lCSwjCP
	8mrpUG+B5ykKcWGRqKAsmGlzSJkfC9Nfc+GpFVUY/eiYNtNH4cviXySkU4yB5l3OJbN76x5zTu+
	toOwUn/0Md0G2MOK8lzQG0pmArDgKcpPaOEvytRJ9pLbu6FbOsLVPadg8N3L4QGeb1XBggJDzhV
	EmYDK3ULE8UcoYBMqLkERDJ8g+Z2IU91q3E/bE1N3thMpkLL2196s2aGD8GBxST4d6xtZeAtWLx
	AVxphbPdiFfcSzWaETnV3J1O54fnEjvIXfNNFXCO9wBc7pfqSsHyLevhv7PIx4lLREsh2+uPsPU
	GAYOlmKm9uA3WKSNr4HsO9UFi+7LP5/+t4NZLY6LCAKGeRjW7f8IqeyZaQNPUTcvsEDej5TnfZe
	opLk1EkYLHN+9hOVsH
X-Received: by 2002:a17:902:e745:b0:2bf:1fbd:b946 with SMTP id d9443c01a7336-2c2edae7b99mr2130765ad.0.1781134509375;
        Wed, 10 Jun 2026 16:35:09 -0700 (PDT)
Received: from p1 ([2607:fb91:1582:d2f1:7bbf:a7c4:749b:120a])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2c2d9bb2199sm7649435ad.77.2026.06.10.16.35.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Jun 2026 16:35:09 -0700 (PDT)
Date: Wed, 10 Jun 2026 16:35:06 -0700
From: Xiang Mei <xmei5@asu.edu>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: jasowang@redhat.com, xuanzhuo@linux.alibaba.com, eperezma@redhat.com, 
	andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com, kuba@kernel.org, 
	pabeni@redhat.com, netdev@vger.kernel.org, virtualization@lists.linux.dev, 
	linux-kernel@vger.kernel.org, minhquangbui99@gmail.com, bestswngs@gmail.com
Subject: Re: [PATCH net] virtio-net: fix len check in receive_big()
Message-ID: <5vtwwpfftbzq7ehm6itoq2263gffo67yv4nebrwgsa6fkb2t7s@wdxt4exrvfpj>
References: <20260610221606.1091465-1-xmei5@asu.edu>
 <20260610181911-mutt-send-email-mst@kernel.org>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260610181911-mutt-send-email-mst@kernel.org>

On Wed, Jun 10, 2026 at 06:21:49PM -0400, Michael S. Tsirkin wrote:
> On Wed, Jun 10, 2026 at 03:16:06PM -0700, Xiang Mei wrote:
> > receive_big() bounds the device-announced length by
> > (big_packets_num_skbfrags + 1) * PAGE_SIZE.  That is still too loose:
> > add_recvbuf_big() sets sg[1] to start at offset
> > sizeof(struct padded_vnet_hdr) into the first page, so the chain
> > actually carries hdr_len + (PAGE_SIZE - sizeof(padded_vnet_hdr)) +
> > big_packets_num_skbfrags * PAGE_SIZE bytes -- 20 bytes less than the
> > check allows for the common hdr_len == 12 case.
> > 
> > A malicious virtio backend can announce a len in that gap.  page_to_skb()
> > then walks one frag past the page chain, storing a NULL page->private
> > into skb_shinfo()->frags[MAX_SKB_FRAGS], which is both an out-of-bounds
> > write past the static frag array and a NULL frag handed up the rx path.
> > Bound len by the size add_recvbuf_big() actually advertised.
> > 
> > Fixes: 0c716703965f ("virtio-net: fix received length check in big packets")
> > Reported-by: Weiming Shi <bestswngs@gmail.com>
> > Signed-off-by: Xiang Mei <xmei5@asu.edu>
> 
> Let's instead (or additionally?), bound the frags array index.

I went with "additionally" rather than "instead": 1/2 restores the
length invariant in receive_big(), and 2/2 makes the frag loop
self-defending so it no longer depends on the caller validating len.

I didn't find a case triggering the issue of 2/2 so I could not produce
a PoC that actually crashes the kernel through 2/2's path independently
of the 1/2 bug. With 1/2 applied, the over-long len is rejected before
the loop, so the guard is never exercised by a real trigger I could find.

So 2/2 is defense-in-depth rather than a demonstrated separate bug.
Please feel free to decide whether it's worth taking. A v2 was sent.

Thanks,
Xiang
> 
> Seems more robust.
> 
> > ---
> >  drivers/net/virtio_net.c | 8 +++++---
> >  1 file changed, 5 insertions(+), 3 deletions(-)
> > 
> > diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> > index f4adcfee7a80..afe73eda1491 100644
> > --- a/drivers/net/virtio_net.c
> > +++ b/drivers/net/virtio_net.c
> > @@ -1999,15 +1999,17 @@ static struct sk_buff *receive_big(struct net_device *dev,
> >  				   struct virtnet_rq_stats *stats)
> >  {
> >  	struct page *page = buf;
> > +	unsigned long max_len;
> >  	struct sk_buff *skb;
> >  
> >  	/* Make sure that len does not exceed the size allocated in
> >  	 * add_recvbuf_big.
> >  	 */
> > -	if (unlikely(len > (vi->big_packets_num_skbfrags + 1) * PAGE_SIZE)) {
> > +	max_len = vi->hdr_len + (PAGE_SIZE - sizeof(struct padded_vnet_hdr)) +
> > +		  vi->big_packets_num_skbfrags * PAGE_SIZE;
> > +	if (unlikely(len > max_len)) {
> >  		pr_debug("%s: rx error: len %u exceeds allocated size %lu\n",
> > -			 dev->name, len,
> > -			 (vi->big_packets_num_skbfrags + 1) * PAGE_SIZE);
> > +			 dev->name, len, max_len);
> >  		goto err;
> >  	}
> >  
> > -- 
> > 2.43.0
> 
