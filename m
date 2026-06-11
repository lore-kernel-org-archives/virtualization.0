Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3411330677C
	for <virtualization@lists.linux.dev>; Thu, 11 Jun 2026 06:04:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781157861; cv=none; b=VibLA3gq1cOCOKpLmjz9Hay1AcLFBZXABYbgWT05fqgwNuC4xT3o2hgl60dFBg4h8XV8GNFEM5w6zGeQVfksHi+pJyP4gaV9YdasfiW+bpst4/NYR58WKNH0KhosxXAm2oMFmJhkXk722K0iKwp/N5umSTMPoWBr8j74Pu+atqU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781157861; c=relaxed/simple;
	bh=THJuQE2MrTb5ZIYu3BzOWvVCOA5+CKpxg+aLafJ1Wfw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=QYaF2a9//uLvL4QR+7pkvFJofUB0RN3BH3Pvbay0LRI/sUexfwF6r0Thlc22hBVf+SZ5f6YrqbEG3moCD5QVo+s5RwZzkaPBkj6wUnEX8d43u81d5qc31TXQePjCuUbOQ/np/orkIfmUGpAgC36bnZdET5FRj9e9ikBZcAgjuWE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=BlagH+E6; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BlagH+E6"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1781157859;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=HRTToFtG9hV0gA1EWdpPvRzBaGUtoQe1flCF2qnScak=;
	b=BlagH+E6wk25ON9Gy7riL9mUXcJsoKPW9y1MHsi8Wak8RfgSS5TZ4VTicrIy/H5aor3crx
	aYrPZvFjLbFeK7Bcm2cLpEC7/Q1o4BlfRluqjHcUq5U2KpCgb3Udfr/rSZA3osaF7uqiOb
	DJZhjMVAIlQOxA4uNvwvhNdSfQ0a8nw=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-150-zJQ73LKGPcymOjCXTZKDrg-1; Thu, 11 Jun 2026 02:04:17 -0400
X-MC-Unique: zJQ73LKGPcymOjCXTZKDrg-1
X-Mimecast-MFC-AGG-ID: zJQ73LKGPcymOjCXTZKDrg_1781157857
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-45ef55779d1so4750651f8f.0
        for <virtualization@lists.linux.dev>; Wed, 10 Jun 2026 23:04:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781157857; x=1781762657;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HRTToFtG9hV0gA1EWdpPvRzBaGUtoQe1flCF2qnScak=;
        b=CxTlIxUnT7sdh5pxAmWtDHhj6lO8zA8MNCPWIRY96SD37NWsI0xMMNP5v2T4/Re9M5
         ieEHU9AoDQBBDw8LUJifDGLdO5QvXZDBl9wGQFg7ThmVRJeYWRK93EJoYLEPoElIh7Ke
         +nGe8qVOrkccmAXoIryzCeuz8JC5goTkFqlKfEDHFhiS0Gcw6WD3KrxkXIpC1vaMLhjv
         MD78dMjS7Cd8v+yFxe4GMp6ux2Kv3iIqJJc3iqi5MGqr0PQepLkllvRohOErfeF8osEt
         B2ep8kHyKFeMRNPSWw7vLpi4eqkr93sWWNDnZgkercqpG1J36ZbAcA7j85pVmFr00jfc
         hxLA==
X-Forwarded-Encrypted: i=1; AFNElJ8fKzfiLcD+K8XCi8YUlrji2k9yPP0JF66BPOFE5GOddaG+ifoYduV6F9B+e4Zw3V+ceScb2+VA2poFRVIEBw==@lists.linux.dev
X-Gm-Message-State: AOJu0YytOzkW+uqXE/Va6pvVKfUOSokmBf49wfmjZcczGpCkWQFj97uZ
	Ipsvasq4q2iORL93+7mW5a5TjylZgMwFXut3wMF84Rw/Xa+hAFhq5CSwkLjFLtWfa5E46vUqbX/
	z7xz0xt4evMuKrJP/hSRiTthhBgpP7x5xaK88S+dOwyYddUzYe5OjN2v6rDXhxC/fzGAr
X-Gm-Gg: Acq92OGxePVaOAb1DyVXuSjxFAuHtKd7mqmgHcyc6w8LyXna7THRTS7zwyoP1hzHVcr
	Vc8tdVo+tw6QiQDTKXkFqk8PAyYwW47SDIeEHwyKQBXAp+EOLd7/DHJL1Y0VXkIT2FQ4Ybxz994
	EQvg/NOr8LwArSLqWRw0TB60XnNFWJ+obKO3t7bozViGVXD4AhH5UFqlRNX9ICHC6tGpbQYspdI
	Z+h3Vkmnayh1Y5sd9foruPCqfojK2CI1N3Y+E+7LZOmIoLBdY+lVWfgCZ55KAzXswoyccZJ4rHv
	mTeZgTtN6Lf9Sg1F/Rr/BL1W1kRaccNmfZRcNWzUk6aUu/Td8uCiiNFEjWRi99UBNHJQEoyJqaf
	tlsBTW6XLxCH4bE0kPbf16MoTWI+uCVp50xSOP6D1RlvT5uDz+qJsYw==
X-Received: by 2002:a05:6000:460a:b0:460:3233:beeb with SMTP id ffacd0b85a97d-460677b4012mr1689571f8f.43.1781157856483;
        Wed, 10 Jun 2026 23:04:16 -0700 (PDT)
X-Received: by 2002:a05:6000:460a:b0:460:3233:beeb with SMTP id ffacd0b85a97d-460677b4012mr1689509f8f.43.1781157855948;
        Wed, 10 Jun 2026 23:04:15 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-85-71.inter.net.il. [80.230.85.71])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4601f351ac0sm135110395f8f.27.2026.06.10.23.04.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Jun 2026 23:04:14 -0700 (PDT)
Date: Thu, 11 Jun 2026 02:04:11 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Cc: Xiang Mei <xmei5@asu.edu>, andrew+netdev@lunn.ch, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	netdev@vger.kernel.org, virtualization@lists.linux.dev,
	linux-kernel@vger.kernel.org, minhquangbui99@gmail.com,
	bestswngs@gmail.com, jasowang@redhat.com, eperezma@redhat.com
Subject: Re: [PATCH net v2 2/2] virtio-net: harden page_to_skb() big-packet
 frag loop
Message-ID: <20260611015712-mutt-send-email-mst@kernel.org>
References: <20260610232936.1176094-1-xmei5@asu.edu>
 <20260610232936.1176094-2-xmei5@asu.edu>
 <1781144329.8069873-2-xuanzhuo@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <1781144329.8069873-2-xuanzhuo@linux.alibaba.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 7QfFU3e_G3K5SDTUCUjY97hzC2FP0FGCwSty2Xe3w1w_1781157857
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Jun 11, 2026 at 10:18:49AM +0800, Xuan Zhuo wrote:
> On Wed, 10 Jun 2026 16:29:36 -0700, Xiang Mei <xmei5@asu.edu> wrote:
> > This is a robustness hardening patch. The slow-path frag loop in
> > page_to_skb() walks the page chain via page->private until the
> > device-reported len is consumed, implicitly trusting that len fits the
> > chain. It does not stop when the chain is exhausted (page becomes NULL
> > at the tail), nor when nr_frags reaches the end of the static
> > skb_shinfo()->frags[MAX_SKB_FRAGS] array.
> >
> > Both bounds are needed: the chain length is big_packets_num_skbfrags + 1
> > pages, which for an MTU-driven configuration can be well below
> > MAX_SKB_FRAGS, so neither guard implies the other.

i don't get it, and then what?

> >
> > Make the loop self-defending so it no longer relies on the caller having
> > validated len: stop once the chain is exhausted, and never index past
> > MAX_SKB_FRAGS. No functional change for well-formed input.
> 
> At this point, we are assuming that len represents the correct packet length.
> If
> there is a bug in the validation, it can be fixed, just like in your previous
> patch. Indeed, not checking nr_frags is also based on the overall design.
> However, I do not recommend adding this kind of enhancement. If we follow
> this logic, we would end up adding similar code in many other places, which
> doesn't make much sense.
> 
> Thanks.


I will be frank, I'm never sure where the confidential computing guys
draw the line.

Are speculative things of concern, for example?


> >
> > Signed-off-by: Xiang Mei <xmei5@asu.edu>
> > ---
> > v2: robustness patch
> >
> >  drivers/net/virtio_net.c | 5 ++++-
> >  1 file changed, 4 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> > index afe73eda1491..518c22fa1b68 100644
> > --- a/drivers/net/virtio_net.c
> > +++ b/drivers/net/virtio_net.c
> > @@ -906,8 +906,11 @@ static struct sk_buff *page_to_skb(struct virtnet_info *vi,
> >  	}
> >
> >  	BUG_ON(offset >= PAGE_SIZE);
> > -	while (len) {
> > +	while (len && page) {


don't see why we would check page

> >  		unsigned int frag_size = min((unsigned)PAGE_SIZE - offset, len);
> > +
> > +		if (unlikely(skb_shinfo(skb)->nr_frags >= MAX_SKB_FRAGS))
> > +			break;

so do we want BUG_ON here maybe?

> >  		skb_add_rx_frag(skb, skb_shinfo(skb)->nr_frags, page, offset,
> >  				frag_size, truesize);
> >  		len -= frag_size;
> > --
> > 2.43.0
> >

