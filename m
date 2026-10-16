Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACC0944A3E9
	for <virtualization@lists.linux.dev>; Fri, 16 Oct 2026 09:47:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792144047; cv=none; b=lDbmG/cI15yFt/A3I19O8lCKFmT5rfbIowaBWO56WwEmoUOjc/kzPV3aeUtGGOU/E/qzoK8yx0FLtwtnMQn56sRKmgJw7NCyuXcEjploOjZqfnEHYkaERJxHKfMUM6lhht/MxTq19dUZhSbRYBquZt1jEisETculzSUTI9fQfnU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792144047; c=relaxed/simple;
	bh=/6bOhgavwLkfu7osE233gpBu5fCr5YepuuO9BGSvMqA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=fjWrnRi7aE/CeA4tTM+YQEM70QOJwlFrTYKthC9uthdHbznbw5orseljjgldShqLr+HTq1cSuD+335Wkw4hn5euhk3EjxCVPQ5kSUIgo7xNrzhAsrzJNcFOzSHwqux+E4k9wGS8IIjoFQtnRVpuFXQe99d9C7Cv6RI8DofquwQQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=LLJguYNV; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LLJguYNV"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1792144044;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=tbR14oJGPzfB2FN3IihSMtrRfZxHPOZ8SpBePeCP3+Q=;
	b=LLJguYNV0QOMOfRRPdJtyj6zslbI5Bwb1pFFt5qx942i/QphEMqtbG3nnHJi5RrE6+TxR8
	mVg0ICtf2U+7O9soqjhg+2/NFD4/gW4MfoCUg9Xlm4Wp1uTNo1bT+Imt8mvqiFiYBnNtHc
	PTkZZHZyflSQpVYWAYN7sAQskjUBaNo=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-623-ovjdvJIGMjmkXIp1sLlJcQ-1; Fri, 16 Oct 2026 09:47:23 +0000
X-MC-Unique: ovjdvJIGMjmkXIp1sLlJcQ-1
X-Mimecast-MFC-AGG-ID: ovjdvJIGMjmkXIp1sLlJcQ_1792144042
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-4a1bfd5516bso17751465e9.3
        for <virtualization@lists.linux.dev>; Fri, 16 Oct 2026 02:47:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792144042; x=1792748842;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=tbR14oJGPzfB2FN3IihSMtrRfZxHPOZ8SpBePeCP3+Q=;
        b=EFTbzbfxmuLvK8orEUuyhD0T5gaECUTmQHev1iQ2uSXj0+sZjLUcjI9fvAZg1UqwX6
         VXhRpXVy/rmykyvxTbE/plJjHVRSMpf+AdYrrZWgydrUmzjKxdRKG4JgqBUq47bqF0zD
         nwKMVhxQ2K+QxbmIIazH9AXAFhuqxPBcxDzPHlY4J1afi3sLQnLsbC/eL5ayVtxDgIqF
         iTUvhQymJ2A+dczCc98shVq1310On0ivYfzxdmILiVbtp9szNU0m7uAP5rMNicyt0dZg
         GKE2LkrbzQWfW9fgQQpA3TJODcLhTfzP/XwRKFXHEpX0wXL9TCUbr5+srIe0LZ/V10F7
         jlJQ==
X-Forwarded-Encrypted: i=1; AKwUvBxEDnCSIiRzpbxVxM2Eb1LxdLKB7nb3oNni+uj3RnjcOITWUaDNmjLysSHdzyWlsjaVpWf9uogfclO1RgMxdA==@lists.linux.dev
X-Gm-Message-State: AFq9FYJonOq8T8S+xnjLytTAetUTtA7LFo0dxwlOdEgAyTZwEpvF3mSW
	9fILR0cme8Kek4hU9kTU2VnE/CsOQzWmvsI4ygFiiU6fuBmvsGAvyBeBpPnv30jZa4bp9zklJTM
	aMe4YNvJh7QhfkqUvejssaMM42b2O5/NiN0d1Yfs56LYsZwoezPfk3RUV3VlaC5w345tP
X-Gm-Gg: AYBFou1GmiHZJw1ZUW26YA/dWgx+BkGO3IdDhzGU7fqoLyI+I5Uyt2CmGyAseKglFZG
	j8egxA5k6VUEMSSXbg0dHcJNU0JbSjyizkbg5rVF0tnq1cNNdNaf+Yqv2DQxpWWhg8w6U4GfN7a
	5hI13h3CxjHmsOsGUUzfIfSd7KlKuQZU0herEs+WANyPLR/ean6crC9yCjGeEqHvQIRtz1EGTy/
	xBCPmXjkizYJZoAAN2h87yPtA8QrlzoGqXVFBYty4gvsL5208F71o0xFTXpDLnPA0W/Akm9ek+i
	0te+HBAyy1b3WUoImBemZsoeyXSH6te0gneCCzgmI5ZkpVJpiAxhZxwkGTyDWdKm93nK2A==
X-Received: by 2002:a05:600d:82ea:b0:4a1:cedc:ab49 with SMTP id 5b1f17b1804b1-4a1cedcacd6mr26955495e9.31.1792144042091;
        Fri, 16 Oct 2026 02:47:22 -0700 (PDT)
X-Received: by 2002:a05:600d:82ea:b0:4a1:cedc:ab49 with SMTP id 5b1f17b1804b1-4a1cedcacd6mr26955045e9.31.1792144041692;
        Fri, 16 Oct 2026 02:47:21 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:3fd7:5300:3d6b:52a4:a23f:9d0b])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48dfd4f8d12sm4029612f8f.36.2026.10.16.02.47.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Oct 2026 02:47:21 -0700 (PDT)
Date: Fri, 16 Oct 2026 05:47:16 -0400
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
Message-ID: <20261016054558-mutt-send-email-mst@kernel.org>
References: <cover.1792067836.git.mst@redhat.com>
 <6716834884238de0ab1ab313004044122aa2adbf.1792067836.git.mst@redhat.com>
 <8420ba1fe84fc7d105825026802d4ad10d44af71.camel@sipsolutions.net>
 <20261015085119-mutt-send-email-mst@kernel.org>
 <64ee40b97fc447bbf3abb80250ad0d9f3cf3c6fa.camel@sipsolutions.net>
 <20261016054142-mutt-send-email-mst@kernel.org>
 <18ba10ec7aa6659ee4711f8dd3f3138e314e4af6.camel@sipsolutions.net>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <18ba10ec7aa6659ee4711f8dd3f3138e314e4af6.camel@sipsolutions.net>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: sRYwbEgsh2ahzkuzlDz8H7vuIbYlzIX12Aj0epv9n9k_1792144042
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Oct 16, 2026 at 11:44:16AM +0200, Johannes Berg wrote:
> On Fri, 2026-10-16 at 05:43 -0400, Michael S. Tsirkin wrote:
> > 
> > > > > > -	virtio_net_hdr_to_skb(skb, vheader, virtio_legacy_is_little_endian());
> > > > > > +	if (virtio_net_hdr_to_skb(skb, vheader,
> > > > > > +			virtio_legacy_is_little_endian()) < 0)
> > > > > > +		return -1;
> > > > > >  	return 0;
> > > > > > 
> > > > > 
> > > > > Seems it'd be simpler to just
> > > > > 
> > > > > 	return virtio_net_hdr_to_skb(...);
> > > > > 
> > > > > As far as I can tell, the function only returns -EINVAL or 0 (never a
> > > > > positive value), and the caller only cares about negative (error) or
> > > > > positive (no checksum needed), so that'd be equivalent?
> > > > > 
> > > > > johannes
> > > > 
> > > > if raw_verify_header can safely return any errno - i did not want to
> > > > audit it.
> > > 
> > > You already used an LLM and still didn't want to? ;-)
> > > 
> > > I checked briefly (by hand) and it seems fine, it's assigned to the
> > > function pointer, which only has two callers on the _kern.c side.
> > > 
> > > johannes
> > 
> > 
> >                                header_check = vp->verify_header(
> >                                         mmsg_vector->msg_hdr.msg_iov->iov_base,
> >                                         skb,
> >                                         vp
> >                                 );
> >                                 if (header_check < 0) {
> >                                 /* Overlay header failed to verify - discard.
> >                                  * We can actually keep this skb and reuse it,
> >                                  * but that will make the prep logic too
> >                                  * complex.
> >                                  */
> >                                         dev_kfree_skb_irq(skb);
> >                                         vp->estats.rx_encaps_errors++;
> >                                         (*skbuff_vector) = NULL;
> >                                         mmsg_vector++;
> >                                         skbuff_vector++;
> >                                         continue;
> >                                 }
> >                                 if (header_check > 0) {
> >                                         vp->estats.rx_csum_offload_good++;
> >                                         skb->ip_summed = CHECKSUM_UNNECESSARY;
> >                                 }
> > 
> > 
> > 
> > so any negative is fine, but if we return 1 then it will force to CHECKSUM_UNNECESSARY
> > which I am not sure is what was intended?
> > 
> Right, but virtio_net_hdr_to_skb() cannot return 1, only 0 on success
> and -ERROR on failure?
> 
> johannes

After this patchset, it can, to signal slow path software checksum.
I'm changing callers first so that changing the function itself
does not break bisect. I should mention this in the commit log.

-- 
MST

