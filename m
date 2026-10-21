Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.133.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792563120;
	b=kQUNUjtgBy2Qm9EreEbCJODUsOnZkhC+Pq4EEimTNGr3UrKujW336ySgZp9hb8sFtvMf
	 VreVPl2u/wUKZO8oYbdd3fCk90GVDoGPEpkNr5KRqHoaRvRWTJKJMKk3yTkbYiePRDpE7
	 zbw3k9oNj5t4dRej6BYbUdXoLowQue6Fj/1FsMBiWXRCxv4+YCq0jGdsOyE4lKcmtMaD9
	 rZpizL7i55vLjV6bDV1SSPuiqb0bjrLcA5pupwL1SHbIuquH1Q+orCcD/GgggCDeMbMrK
	 coCa3vGgoHTEam4JCAchlftxdTX0BEJfGZBcD49v7/gRHTpddhfF25ak3USl42QJ/YA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792563120;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:In-Reply-To:X-Mimecast-Spam-Score:X-Mimecast-MFC-PROC-ID:
	 X-Mimecast-Originator:Content-Type:Content-Disposition;
	bh=eO8b1OM4JwaIVPv9BJ3tr+Qzy2nu/LZKTjlzlZsLRBQ=;
	b=JSiz4x7gmySOf5Ysg1Se9W1Nk6Fy0kwbFRUeEFk8od9gfa+005gE8vxarfqzSN+6yI7O
	 7XxVlX9Js+7ohI/hXJUmWuL0WNmhscgjNNUMHdKD+IBWE4JfB24n7R5sZaxGI/LTSB0gZ
	 a/RAtTf41TnWpQ/Z/fbFsQFDJ6F4EnENtiIfeWT/8+K62YGNR7S/fyx0I02PI5BmGBbZV
	 eMQ2r1GkPyXHnHcMO3l1FvbRyiGTQyJF/h4zXO2riX6oXpQqmvlnPe6eM39DsCIH5zlcH
	 pgaoJPY3ZIVOl4i7ZBSkCW3hdpiiAefu9QyamVV5ur6r7UhEbqN/cBQeM/qBYzIM0eQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b="JTha0l/O";
	arc=none smtp.remote-ip=170.10.133.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27924606A31A
	for <virtualization@lists.linux.dev>; Wed, 21 Oct 2026 06:12:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 27924606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=JTha0l/O
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1792563119;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=eO8b1OM4JwaIVPv9BJ3tr+Qzy2nu/LZKTjlzlZsLRBQ=;
	b=JTha0l/O9F+zjL6CqstHhOXsMAAxmefslS+wgXrdLKR3YD52PBLladNFXvlqH1Ll+Pu53z
	Rww+rhhB0Dk5Syhhp8mFlgVHtlIR6IcZaOeSKE+mj106JvIUEbSdeBfbAU5DowvlkysVio
	ptWvHcjeH2pZ99LTfLP9GslGwtikI8U=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-654-JRvTfe0EMT-HJ4w0aN5yxA-1; Wed, 21 Oct 2026 06:11:58 +0000
X-MC-Unique: JRvTfe0EMT-HJ4w0aN5yxA-1
X-Mimecast-MFC-AGG-ID: JRvTfe0EMT-HJ4w0aN5yxA_1792563117
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-48e1ad3cb66so148237f8f.3
        for <virtualization@lists.linux.dev>; Tue, 20 Oct 2026 23:11:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792563117; x=1793167917;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=eO8b1OM4JwaIVPv9BJ3tr+Qzy2nu/LZKTjlzlZsLRBQ=;
        b=Kcs5NM6Go0vWlpQL9nujAQ3DjVLQtjghyhTghH083LYLysNB7Xh3vU6TyvP1rK6tLF
         Grs5bt4OR4vwKT6A6KAwLtIs1/igSyf4/LCw2UtdsgoRdZ3DR0Yxg9uQoDu1F9LRGXix
         j8o+rn/zJy0kzJNHiU9CP6AVt4v5ioOPbRnaDk7uhsTmLljetxfbs/hJ+HvMJ1aezTan
         WT7oNprutS5hSAMfVm5bZ263HgU9cXI6vXthmExrCOTfDXBzkBhPwhjpZHrwhGSnTuTB
         6Oa9sQm52KMiEoA+CgXuRYaJRhD4AN/ASDXwEKlHIqBureMcAzZC1C+hsp8o8BRiNikp
         PWKQ==
X-Forwarded-Encrypted: i=1; AKwUvBxHLJPaU4usSZ7Bi/TNENqZIErCq3hoZJsg7AlrH2JP+amtMZR8EnGM0f2jWMhhhsCwZccgFToiHhdSCceHZA==@lists.linux.dev
X-Gm-Message-State: AFq9FYLO2f1ETMJIxVTInJNmIlSN1wm7WegtaHuFTF5y4OoMf1I9FbWO
	vpzHnUQOXY7NNEeS0RYL6d7T3SFAOsdpTICEdCxQpjYovLMeint33EgSdhP0GM/6YEPCDm5hLQ/
	ljpWKtDAQWEA8W/CUElFaHB61SdLbqVBFAJqIKJVxCWpA7Nrr0dAOYwRYWKhnGVjjETxQ
X-Gm-Gg: AYBFou24GCQEpwP1X7fzZNkbthYmpyO0ZPI0FOQGTQ990+BeWrurfJOhiHak7JwXj04
	kpjLc0T+mg2j01khzn+GqqZq/q0jhW3wsosRjihYtffG8QQCZ6DyNDTEk+0yOhum7qn8hYXHKSM
	gtQWE+Xy9+aEKWGMQ5sffA1pu5BiXLBjVaCaQKKHlVzwhkuEATWw3j9vDUcf1csSAmYiA7qzf2Q
	zb4TKJRMigUM1DQa8Fu5XkPdHWdhJCPYWfdsbN839/nIqEb8C9rrrjJ0yZqR89OYKM8pJxUMmaN
	k0kxqOSkGfRrb2JhQebbC4wB+owu7Cia4WLe7vg8obtffZ0QRVNXSdWTNreAPxSWKKTALA==
X-Received: by 2002:a05:6000:4a10:b0:48e:e28:ada8 with SMTP id ffacd0b85a97d-48e264e4b73mr1603102f8f.52.1792563116631;
        Tue, 20 Oct 2026 23:11:56 -0700 (PDT)
X-Received: by 2002:a05:6000:4a10:b0:48e:e28:ada8 with SMTP id ffacd0b85a97d-48e264e4b73mr1603051f8f.52.1792563116008;
        Tue, 20 Oct 2026 23:11:56 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:3fd7:5300:3d6b:52a4:a23f:9d0b])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e258424bcsm3212155f8f.55.2026.10.20.23.11.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Oct 2026 23:11:55 -0700 (PDT)
Date: Wed, 21 Oct 2026 02:11:51 -0400
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
Message-ID: <20261021020654-mutt-send-email-mst@kernel.org>
References: <cover.1792411304.git.mst@redhat.com>
 <9c08d12b3a7819ae03ded6a154e4f908276e93d4.1792411304.git.mst@redhat.com>
 <willemdebruijn.kernel.2eb449439b094@gmail.com>
 <20261020170908-mutt-send-email-mst@kernel.org>
 <willemdebruijn.kernel.1da723f98c23a@gmail.com>
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
In-Reply-To: <willemdebruijn.kernel.1da723f98c23a@gmail.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: B-O9p4tn0tLq3_Val41_Ht7siJxRoy8M6AhObHmrJus_1792563117
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Oct 20, 2026 at 08:05:29PM -0400, Willem de Bruijn wrote:
> Michael S. Tsirkin wrote:
> > On Tue, Oct 20, 2026 at 03:44:35PM -0400, Willem de Bruijn wrote:
> > > > +/* Walk the L3 header at @nhoff: where does its transport header
> > > > + * start, and which protocol is it?  Returns false if the header
> > > > + * is truncated, malformed or fragmented.
> > > > + */
> > > > +static inline bool
> > > > +virtio_net_l4_start(struct sk_buff *skb, unsigned int nhoff, __be16 proto,
> > > > +		    unsigned int *thoff, int *ip_proto)
> > > > +{
> > > > +	if (proto == htons(ETH_P_IP)) {
> > > > +		const struct iphdr *iph = virtio_net_ip4_parse(skb, nhoff, thoff);
> > > > +
> > > > +		if (!iph || ip_is_fragment(iph))
> > > > +			return false;
> > > > +		*ip_proto = iph->protocol;
> > > > +		return true;
> > > > +	}
> > > > +
> > > > +	if (proto == htons(ETH_P_IPV6)) {
> > > > +		const struct ipv6hdr *iph;
> > > > +		int flags = 0;
> > > > +
> > > > +		if (!pskb_may_pull(skb, nhoff + sizeof(*iph)))
> > > > +			return false;
> > > > +		iph = (const void *)(skb->data + nhoff);
> > > > +		if (iph->version != 6)
> > > > +			return false;
> > > > +		*thoff = nhoff + sizeof(*iph);
> > > > +		*ip_proto = iph->nexthdr;
> > > > +		if (*ip_proto != IPPROTO_TCP && *ip_proto != IPPROTO_UDP) {
> > > > +			*thoff = nhoff;
> > > > +			*ip_proto = ipv6_find_hdr(skb, thoff, -1, NULL,
> > > > +						  &flags);
> > > > +			if (*ip_proto < 0 || flags & IP6_FH_F_FRAG)
> > > > +				return false;
> > > > +		}
> > > > +		return true;
> > > > +	}
> > > > +
> > > > +	return false;
> > > > +}
> > > 
> > > for all this parsing: could we use flow dissection, like the
> > > !VIRTIO_NET_HDR_F_NEEDS_CSUM case?
> > 
> > Hmm I don't see how.  That one trusts the caller's protocol and network
> > header. We could parse L2 ourselves and use the dissector for L3+. But
> > it stops at whatever it does not know, and every miss would turn into a
> > drop or a software checksum for a packet the stack delivers fine.  Our
> > parser deliberately covers everything the stack can deliver.
> 
> You're right, the protocol and network offset need to be parsed
> manually. After that it could be passed to the flow dissector.
> 
> Totally untested:
> 
>     static inline bool virtio_net_setup_l3_input(struct sk_buff *skb, int *nhoff, __be16 *proto)
>     {
>         const struct net_device *dev = skb->dev;
> 
>         /* Devices with Ethernet framing: ARPHRD_ETHER, loopback, macvlan, etc. */
>         if (dev->header_ops == &eth_header_ops || dev->type == ARPHRD_ETHER) {
>             if (!pskb_may_pull(skb, ETH_HLEN))
>                 return false;
>             *nhoff = ETH_HLEN;
>             *proto = eth_hdr(skb)->h_proto;
>         } else if (dev->type == ARPHRD_NONE) {
>             /* Raw L3 devices (e.g. tun in IFF_TUN mode) */
>             *nhoff = 0;
>             *proto = skb->protocol;
>             if (!*proto) {
>                 if (!pskb_may_pull(skb, 1))
>                     return false;
>                 if ((skb->data[0] >> 4) == 4)
>                     *proto = htons(ETH_P_IP);
>                 else if ((skb->data[0] >> 4) == 6)
>                     *proto = htons(ETH_P_IPV6);
>                 else
>                     return false;
>             }
>         } else {
>             /* Fallback for other netdevs using caller's network header */
>             *nhoff = skb_network_offset(skb);
>             if (*nhoff < 0 || (unsigned int)*nhoff >= skb->len)
>                 return false;
>             *proto = skb->protocol;
>         }
> 
>         return true;
>     }
> 
>     static inline bool virtio_net_csum_partial_ok(struct sk_buff *skb, u8 hdr_gso_type)
>     {
>         struct flow_keys_basic keys;
>         __be16 orig_proto = skb->protocol;
>         u16 orig_net_hdr = skb->network_header;
>         __be16 proto;
>         int nhoff;
>         u16 csum_offset;
>         size_t min_thlen;
>   
>         if (!virtio_net_setup_l3_input(skb, &nhoff, &proto))
>             return false;
>   
>         skb_set_network_header(skb, nhoff);
>         skb->protocol = proto;
>   
>         if (!skb_flow_dissect_flow_keys_basic(dev_net(skb->dev), skb, &keys,
>                               NULL, 0, 0, 0, 0))
>             goto restore_fail;
>   
>         /* Disallow fragments: partial checksums cannot be retained across frags */
>         if (keys.control.flags & FLOW_DIS_IS_FRAGMENT)
>             goto restore_fail;
>   
>         /* Validate protocol matching */
>         switch (keys.basic.ip_proto) {
>         case IPPROTO_TCP:
>             if (!virtio_net_hdr_match_proto(keys.basic.n_proto, hdr_gso_type))
>                 goto restore_fail;
>             min_thlen = sizeof(struct tcphdr);
>             csum_offset = offsetof(struct tcphdr, check);
>             break;
>         case IPPROTO_UDP:
>             if (!virtio_net_hdr_match_proto(keys.basic.n_proto, hdr_gso_type))
>                 goto restore_fail;
>             min_thlen = sizeof(struct udphdr);
>             csum_offset = offsetof(struct udphdr, check);
>             break;
>         default:
>             goto restore_fail;
>         }
> 
>         /* csum_start must match the dissected transport header offset */
>         if (skb_transport_offset(skb) != keys.control.thoff)
>             goto restore_fail;
> 
>         /* csum_offset must point to the transport checksum field */
>         if (skb->csum_offset != csum_offset)
>             goto restore_fail;
> 
>         /* Ensure the transport header is linear */
>         if (!pskb_may_pull(skb, keys.control.thoff + min_thlen))
>             goto restore_fail;
> 
>         return true;
> 
>     restore_fail:
>         skb->protocol = orig_proto;
>         skb->network_header = orig_net_hdr;
>         return false;
>     }



Hmm, an interesting trick, but I don't see how this works for tunnels?
We need to dissect at inner_nh, and on success we can not leave
network_header there - the packet continues to outer IP processing.
I fear making all this work will be more code than the parsing it
replaces.


-- 
MST

