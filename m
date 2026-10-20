Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.129.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792532981;
	b=j4pGlNba1LKvP5SryM4hwytf3Til7vNg/WQXAXI3KNwy6XRS0gHmxWTZpz00zzfEPgDD
	 vdeCiOtC3xrRx6n5c1uJnUh5lPxeYbJNr0snkq8r2uB4uJbDkJO2hnFO3zoAsg890vlHl
	 0OFzNMGVN6tUxWtWks7McutNyMkCc9swW9+ML2CqQl+DAeF8SUAzH9yleY5ICRT3zW8l/
	 oy36U+fn0u05DghIwKK2bmSKQv0sO7onfSDjqDe5/diVLW6+1nRU38QvPniKVjikD66Ep
	 SvjyIS1zmDisSlH1vs4V455wn2SmYTLB8RkuklNR5B3WsI9ssLMJBV/9gb1rX9A9gsA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792532981;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:In-Reply-To:X-Mimecast-Spam-Score:X-Mimecast-MFC-PROC-ID:
	 X-Mimecast-Originator:Content-Type:Content-Disposition;
	bh=6a23BIgyFqsOlkHIU2aMu3SBCeDxKSj45oBJ7lnIkkY=;
	b=xCssF7sZKLwsLaIyiueJV6NxvA1jtMP9li0KHA3pmr+t52WYdKp1vhyinRIetuIDTijo
	 YvKMot6uOnHKyHkmVPKWWXsLq5e0zwKBgK28+Gdh6Lzc0bqAJZZEFIo51QgC7vUbPe7xM
	 D6KvjxxLkBYTY+JsgHq77rd0w2nQ4xyvhq50mP2PJBd8mSOjamdaQL9KnORjH0oxe2+lX
	 FLvNxZsMnzjUiQP4IVMqWQu+shyCjcCY755tUP5twLFssso1FfAPlSzZ6Vfr2QwSohzDK
	 4J0B9yh00WeutWKNU3y3YT4z5i8oQ3/UpGZF0RkGWrptuy7JNA5JPpx2Yf4vPY1mW+g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=eXxUXygj;
	arc=none smtp.remote-ip=170.10.129.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4920B606A319
	for <virtualization@lists.linux.dev>; Tue, 20 Oct 2026 21:49:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4920B606A319
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=eXxUXygj
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1792532980;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=6a23BIgyFqsOlkHIU2aMu3SBCeDxKSj45oBJ7lnIkkY=;
	b=eXxUXygjpIdNOWXdt2do2mPWMPNSImKQTPSXrcCwWEKGg+WvQyVWcLSixU7jZwhX7Qym2A
	wYMWQvdX6+WOf87CRW+xm1Dtdi5N2uBwuGchQJ3SpP+Xh6zej8Ljm7LGkY6LiACzQ2yjRS
	P0OLdYxSmQhh8SOQjR2UZ+hAyBXAviY=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-353-RpdRJz1-MOu1XFKL_52EJw-1; Tue, 20 Oct 2026 21:49:39 +0000
X-MC-Unique: RpdRJz1-MOu1XFKL_52EJw-1
X-Mimecast-MFC-AGG-ID: RpdRJz1-MOu1XFKL_52EJw_1792532978
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-48af5a07314so54467f8f.2
        for <virtualization@lists.linux.dev>; Tue, 20 Oct 2026 14:49:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792532978; x=1793137778;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=6a23BIgyFqsOlkHIU2aMu3SBCeDxKSj45oBJ7lnIkkY=;
        b=xbUwuvqTnmcRCmZ8QFrL6zdl0FySqVov+jfffAHMJfiF7oN4npl5aTQEPmEfwa2RnF
         Rms1nHprf6BEiQ+2+/GF/0gmbDUjz/bxRgST0lN8XhS1TAgW5jUmLuTcYLScvxlNwi5z
         DEy0I61Wiu74tMFVvFDsL5BFVygom0YgZ1jwJPECBvNXA0KqH4tS5Ivzk9c6p5jnJu8o
         6v+aeN4FRkV4Mw6zkYjpgNe3j3jnSeIw1ZST+HPQ61//pllbKKf0G4CO5/8I1i57bqxS
         WVTSJ9MmScou/kTTHX4hrmlUf2XM26f0Qf5Ap3CpLmlgbBn9/yRSnjrx2tsDdczlrVuL
         IGFA==
X-Forwarded-Encrypted: i=1; AKwUvByI2owLPedKBoETZ6QmC8aOe68tVCf8g7yyLiyuUO/nsUP8hp/oSMWuuSze44jazB1I3HBSRIbte72yx4Y6wQ==@lists.linux.dev
X-Gm-Message-State: AFq9FYIL5D40FKzAEQsk4xsVx7DFSFljZHosIQ+v5l005d5fgvgWlYAq
	BLEagGOw+oDbA3vthexn0oAu94kAUh5qiw2qh7narnNBScvSgWHN30GwZdtY49b/WThEVgLzKsd
	rSLfV+zXr3Jesgf0yRwUmzuCqD/uUN06A4FviIk+PXlTgq8qHICUEORixR8CocSaqLF9v
X-Gm-Gg: AYBFou3UEycirAVgarW1Zf4tp532afwUCYYOvAp8rt3bOzoYLR7Iu/5RT11nK3OGnNI
	BAsyUK0l3oeFAEjKJTQ69YtdirFCiC6chMaz5vNEIGwvJkvj1GqhbarHpwuiEEiAeiRjrgnmjGn
	a+5/kmajWyV4M5CbPByjVYZhXLVre5x99FDW7GMu/PNgXGDUJ3eLuOqRNM6a//nG3X6JGpw89gI
	1HAROle+GGbxwe32OcrPkIXPEFSDG8UV21aH8Q8x8f0vtQwA662z49ifxFCwCT7A+tAeLEjR/nl
	h1mKl23F9n83gVsqjvkS9dxAhYSeXgxyIS1iihBsb8DJqhRMZV3Xr6TnD2ah+VD8v/1j6A==
X-Received: by 2002:a5d:6f17:0:b0:48e:cd3:64f8 with SMTP id ffacd0b85a97d-48e2641dda7mr47260f8f.4.1792532977765;
        Tue, 20 Oct 2026 14:49:37 -0700 (PDT)
X-Received: by 2002:a5d:6f17:0:b0:48e:cd3:64f8 with SMTP id ffacd0b85a97d-48e2641dda7mr47229f8f.4.1792532977316;
        Tue, 20 Oct 2026 14:49:37 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:3fd7:5300:3d6b:52a4:a23f:9d0b])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e25828c6dsm1149327f8f.24.2026.10.20.14.49.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Oct 2026 14:49:35 -0700 (PDT)
Date: Tue, 20 Oct 2026 17:49:32 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: linux-kernel@vger.kernel.org, Chris Arges <carges@cloudflare.com>,
	=?iso-8859-1?Q?Bj=F6rn_T=F6pel?= <bjorn@kernel.org>,
	Phil Sutter <phil@nwl.cc>, Jason Wang <jasowangio@gmail.com>,
	Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, virtualization@lists.linux.dev,
	Max Krasnyansky <maxk@qualcomm.com>,
	Rusty Russell <rusty@rustcorp.com.au>,
	Paulos Yibelo <habte.yibelo@gmail.com>
Subject: Re: [PATCH net v3 5/8] net: resolve uncommon partial checksums at
 ingress
Message-ID: <20261020170908-mutt-send-email-mst@kernel.org>
References: <cover.1792411304.git.mst@redhat.com>
 <9c08d12b3a7819ae03ded6a154e4f908276e93d4.1792411304.git.mst@redhat.com>
 <willemdebruijn.kernel.2eb449439b094@gmail.com>
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
In-Reply-To: <willemdebruijn.kernel.2eb449439b094@gmail.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 3iFciM2cKbyEuHwSQLQiCg58HHf7CRiy_YSzfdH5gp0_1792532978
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Oct 20, 2026 at 03:44:35PM -0400, Willem de Bruijn wrote:
> > +/* Walk the L3 header at @nhoff: where does its transport header
> > + * start, and which protocol is it?  Returns false if the header
> > + * is truncated, malformed or fragmented.
> > + */
> > +static inline bool
> > +virtio_net_l4_start(struct sk_buff *skb, unsigned int nhoff, __be16 proto,
> > +		    unsigned int *thoff, int *ip_proto)
> > +{
> > +	if (proto == htons(ETH_P_IP)) {
> > +		const struct iphdr *iph = virtio_net_ip4_parse(skb, nhoff, thoff);
> > +
> > +		if (!iph || ip_is_fragment(iph))
> > +			return false;
> > +		*ip_proto = iph->protocol;
> > +		return true;
> > +	}
> > +
> > +	if (proto == htons(ETH_P_IPV6)) {
> > +		const struct ipv6hdr *iph;
> > +		int flags = 0;
> > +
> > +		if (!pskb_may_pull(skb, nhoff + sizeof(*iph)))
> > +			return false;
> > +		iph = (const void *)(skb->data + nhoff);
> > +		if (iph->version != 6)
> > +			return false;
> > +		*thoff = nhoff + sizeof(*iph);
> > +		*ip_proto = iph->nexthdr;
> > +		if (*ip_proto != IPPROTO_TCP && *ip_proto != IPPROTO_UDP) {
> > +			*thoff = nhoff;
> > +			*ip_proto = ipv6_find_hdr(skb, thoff, -1, NULL,
> > +						  &flags);
> > +			if (*ip_proto < 0 || flags & IP6_FH_F_FRAG)
> > +				return false;
> > +		}
> > +		return true;
> > +	}
> > +
> > +	return false;
> > +}
> 
> for all this parsing: could we use flow dissection, like the
> !VIRTIO_NET_HDR_F_NEEDS_CSUM case?

Hmm I don't see how.  That one trusts the caller's protocol and network
header. We could parse L2 ourselves and use the dissector for L3+. But
it stops at whatever it does not know, and every miss would turn into a
drop or a software checksum for a packet the stack delivers fine.  Our
parser deliberately covers everything the stack can deliver.

-- 
MST

