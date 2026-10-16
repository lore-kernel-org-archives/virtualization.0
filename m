Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0ED83EC6B3
	for <virtualization@lists.linux.dev>; Fri, 16 Oct 2026 09:43:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792143797; cv=none; b=OO9aK4B7z9GRgTVPhMbsR8dmj7c9oA+Ij2L+9gU7yfPtY6jLJ8mp4KmfxE3c9qN/9s5Kyg/bI5TqwcRijmC1LlO/8MHsKJJQwLaSaZD56K27r7B8/hwkb5OKC7oY1IvgrIaRNUCXpNfQHWMYTl635SKI8uV8doOkCY87YH391ug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792143797; c=relaxed/simple;
	bh=wNZ412Ae3m8jBXHfRGmC8hQuWMi22RyrCtR8KESTa9k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=neEuMHeMB+UcNFfJdaU4FJVv+mTCz3FNmArjutT21ct1cHdOXtylxovisy+Wucwd4vQD8K6l1Io6Q+PQPioqKBv4+99OOm+WJlpll2itF4bRHkeG0chr3wPAqMu7V7GdXtlS8m5dVyj+TUDBGub6npLMzanCzBo9kul3Ki9vcGw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=TZ9yghOn; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TZ9yghOn"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1792143794;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=GSsULpZ3pzORBRFAex1hz9lIvJDrQuTo9GJjL73TxMQ=;
	b=TZ9yghOnovYFUIzVIxlFqz1FyuAZ7BML14hjiLZzSBqCQZPVlsEhOeJVyb7URobTYN++Pl
	hoi4Pt1xaO3h3h850fUQB/0d3O+4kV+dScxdw70H1LqQIVQHqRqJzdzvrJ7Nyr2FEt5Fp3
	2t0JbGXjT9B/LQqEnyHGNFCsK+6aSlg=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-604-wXh7xp-MP92KIa8J2t-5cQ-1; Fri, 16 Oct 2026 09:43:12 +0000
X-MC-Unique: wXh7xp-MP92KIa8J2t-5cQ-1
X-Mimecast-MFC-AGG-ID: wXh7xp-MP92KIa8J2t-5cQ_1792143791
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-495689bfcc8so52221325e9.1
        for <virtualization@lists.linux.dev>; Fri, 16 Oct 2026 02:43:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792143791; x=1792748591;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=GSsULpZ3pzORBRFAex1hz9lIvJDrQuTo9GJjL73TxMQ=;
        b=ZQjPVBJjtwjrCiHt3lcWNmQcjg82dv69kumZ+HSEE7fcqJ8wqh5w7Rr+DkBYaMQT3R
         Ftf73wkPDiDjnLKcXknsYE4G7Sn50d2s4eO9MGnM2ke+rjueu/3FZ7NCtZQ4EdBUfguM
         0HomNlMTwwNV4+VgClkW3hPa1xEcuscF259Jmo6jxABLRvIvYo8bTUM4ZYiLn6FOdWAJ
         mYKHQPIF7vtBjx/DuFBZcck24yKezo3iV+6MlMuWy5qyPSjD0f5Gu34p4cJmRvQuny5b
         y+aGlB1b5POZdxSv6iDHU8xTXLi8z8Pccq0NpnRgN5Ieu+bSAV77O7xL7d3QZBFtE9NH
         TQ8w==
X-Forwarded-Encrypted: i=1; AKwUvBxxBI21Z2rcQLBjDchd0xmMs8aOdqEQNveNeuNBns2Jd0MB29cJW6q+guRpBZ+mZld7EeM2OOCeNMJK2dex/A==@lists.linux.dev
X-Gm-Message-State: AFq9FYJ8R5H0347CUAWmetg7okre+PqlKR9gU4q5HUUPjzaB8zvsgO7e
	2z0yeh3n0YRiyEtwvFqK9nu67eCg9MyAmTLoVY0WBqYl8QOka96MIIjxqodO/jufgWlzlIv282D
	sKdzSwON+j8PMulbAZElPgExtiUnMNlZsaHitUeW8yhUcVKffZWILdnGn4GX9GWa8v728
X-Gm-Gg: AYBFou0duY1Jfxp21nH9vZNobhDQwF1SxgBovrOMP1/N5RCoCMS0Skf+jTD9HD/12FF
	YLrksbNkI3PdzDkK9I+Q+pKHzWGjkANUX0b5I0erDemuJATWu3oh8S3Uz/U2itfj48vgECs0xoK
	W9tKFKS+9PvZD+Bx4XrEPBoLAssep8XsXnxJ38RJPN7c+z49I2s1m8cHGiA5LmxMW6eGpNrxXV4
	mLkgirPjZtyhexD9446WCBT6QvRzQR6uY/ip7WHw0Hnv9iwoLN+loPfFcJZZ7MHImVz+la+x69A
	T6wfHtUSqdVAe3mrIdImpVavjErfUXdUHNkNIKfmLG/4UyOGudDEAt+FEkrhFoZpLsCorA==
X-Received: by 2002:a05:600c:6388:b0:4a1:6f78:8419 with SMTP id 5b1f17b1804b1-4a18e3ee8f9mr441048135e9.0.1792143791209;
        Fri, 16 Oct 2026 02:43:11 -0700 (PDT)
X-Received: by 2002:a05:600c:6388:b0:4a1:6f78:8419 with SMTP id 5b1f17b1804b1-4a18e3ee8f9mr441047565e9.0.1792143790656;
        Fri, 16 Oct 2026 02:43:10 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:3fd7:5300:3d6b:52a4:a23f:9d0b])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48dfd4c5957sm3899658f8f.9.2026.10.16.02.43.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Oct 2026 02:43:09 -0700 (PDT)
Date: Fri, 16 Oct 2026 05:43:06 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Johannes Berg <johannes@sipsolutions.net>
Cc: linux-kernel@vger.kernel.org,
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
	Jason Wang <jasowangio@gmail.com>,
	Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, virtualization@lists.linux.dev,
	Rusty Russell <rusty@rustcorp.com.au>,
	Max Krasnyansky <maxk@qualcomm.com>,
	Richard Weinberger <richard@nod.at>,
	Anton Ivanov <anton.ivanov@cambridgegreys.com>,
	linux-um@lists.infradead.org
Subject: Re: [PATCH net-next v2 2/7] um: vector: honor virtio net hdr
 conversion failures
Message-ID: <20261016054142-mutt-send-email-mst@kernel.org>
References: <cover.1792067836.git.mst@redhat.com>
 <6716834884238de0ab1ab313004044122aa2adbf.1792067836.git.mst@redhat.com>
 <8420ba1fe84fc7d105825026802d4ad10d44af71.camel@sipsolutions.net>
 <20261015085119-mutt-send-email-mst@kernel.org>
 <64ee40b97fc447bbf3abb80250ad0d9f3cf3c6fa.camel@sipsolutions.net>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <64ee40b97fc447bbf3abb80250ad0d9f3cf3c6fa.camel@sipsolutions.net>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: Fhnh_y7nKwWJx51kjsl1yCFWtmfSllisjYOW0TCswGQ_1792143791
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Oct 15, 2026 at 02:55:23PM +0200, Johannes Berg wrote:
> On Thu, 2026-10-15 at 08:52 -0400, Michael S. Tsirkin wrote:
> > On Thu, Oct 15, 2026 at 02:47:01PM +0200, Johannes Berg wrote:
> > > On Thu, 2026-10-15 at 08:41 -0400, Michael S. Tsirkin wrote:
> > > > virtio_net_hdr_to_skb() refuses packets whose checksum metadata
> > > > it cannot make sense of, but the vector raw transport ignored
> > > > its return value: rejected packets went on into the stack with
> > > > their metadata unvalidated.
> > > > 
> > > > Propagate the failure.
> > > > 
> > > > Assisted-by: LLM
> > > > Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> > > > ---
> > > >  arch/um/drivers/vector_transports.c | 4 +++-
> > > >  1 file changed, 3 insertions(+), 1 deletion(-)
> > > > 
> > > > diff --git a/arch/um/drivers/vector_transports.c b/arch/um/drivers/vector_transports.c
> > > > index e1fb2a76fdff..8b7548458663 100644
> > > > --- a/arch/um/drivers/vector_transports.c
> > > > +++ b/arch/um/drivers/vector_transports.c
> > > > @@ -210,7 +210,9 @@ static int raw_verify_header(
> > > >  		return 1;
> > > >  
> > > >  	skb_set_network_header(skb, ETH_HLEN);
> > > > -	virtio_net_hdr_to_skb(skb, vheader, virtio_legacy_is_little_endian());
> > > > +	if (virtio_net_hdr_to_skb(skb, vheader,
> > > > +			virtio_legacy_is_little_endian()) < 0)
> > > > +		return -1;
> > > >  	return 0;
> > > > 
> > > 
> > > Seems it'd be simpler to just
> > > 
> > > 	return virtio_net_hdr_to_skb(...);
> > > 
> > > As far as I can tell, the function only returns -EINVAL or 0 (never a
> > > positive value), and the caller only cares about negative (error) or
> > > positive (no checksum needed), so that'd be equivalent?
> > > 
> > > johannes
> > 
> > if raw_verify_header can safely return any errno - i did not want to
> > audit it.
> 
> You already used an LLM and still didn't want to? ;-)
> 
> I checked briefly (by hand) and it seems fine, it's assigned to the
> function pointer, which only has two callers on the _kern.c side.
> 
> johannes


                               header_check = vp->verify_header(
                                        mmsg_vector->msg_hdr.msg_iov->iov_base,
                                        skb,
                                        vp
                                );
                                if (header_check < 0) {
                                /* Overlay header failed to verify - discard.
                                 * We can actually keep this skb and reuse it,
                                 * but that will make the prep logic too
                                 * complex.
                                 */
                                        dev_kfree_skb_irq(skb);
                                        vp->estats.rx_encaps_errors++;
                                        (*skbuff_vector) = NULL;
                                        mmsg_vector++;
                                        skbuff_vector++;
                                        continue;
                                }
                                if (header_check > 0) {
                                        vp->estats.rx_csum_offload_good++;
                                        skb->ip_summed = CHECKSUM_UNNECESSARY;
                                }



so any negative is fine, but if we return 1 then it will force to CHECKSUM_UNNECESSARY
which I am not sure is what was intended?


-- 
MST

