Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.175
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792592231;
	b=fr3nTGDzXxBKN9rQ0p9JNG2L0UlcqrF1ms9GXtnBtps6wZMwCniQe3fHK2p1qXTi/Lwu
	 tI5lDhKxrTZ5Gtf9AEH/bOT6hW5U+prTke5rhCmO99Pc0GZJHIluFNxOn/+LOEGoAmPK5
	 z8Rnm7YC37xqIgNM+j5aIKm25oA2TxAYywiAUxU41LeFINTw1VtB8q7dIppQoKlX1gnEJ
	 fRrECLqrjfoinWdyTjrnpvUpl5JCCwerayywXByRj3vQXU2rzNlt6Rrkj57EOANraACkb
	 9KyI4jVVqkj71KgXhFCAW665FMLsKblrbbMS2d9+vKFe3FPF98Gn/30VlnmH5eeGIVw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792592231;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=xux5QvP8YQiJThcV5md5s9PvW9xG2SSFmNPqLeHDz08=;
	b=Fn3pLXEfHa2KqfwPBQ1Hoh/QD+seOsrvQDWdtXkPk8aM5f7d+ntu+bZ8PBJiWKqnUNhl
	 y1/Dk+zV+Tf6Ly50GWy7DQFoupUCsUwCZpRsR3pfvpIuvjTdivLtgylmCR3dAijc+fc8C
	 RkQ8GGqj0QMzViyb6ATCeA0tNgTZeAYXlyz7NUhoCtIiqQy4pdeA9Yz9Q71Xwje5IUgiN
	 F3dBXjDQ4qhbsKyZWmAOI9DoCLH9Hw/aR2dJDHdJj8aWATKPiOTsoZ1msG+4iZnLOBN6M
	 wOUhoSTsZ4tHEVRjJL+iHh9jyFfDrHGe0QfQZjOwFGyEfV4qnzAHurA0b9V62gcPTNw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=B40QmB+G;
	arc=none smtp.remote-ip=209.85.221.175
Received: from mail-vk1-f175.google.com (mail-vk1-f175.google.com [209.85.221.175])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93CC4606A320
	for <virtualization@lists.linux.dev>; Wed, 21 Oct 2026 14:17:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 93CC4606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=B40QmB+G
Received: by mail-vk1-f175.google.com with SMTP id 71dfb90a1353d-5ead4026fe6so292267e0c.2
        for <virtualization@lists.linux.dev>; Wed, 21 Oct 2026 07:17:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792592229; x=1793197029; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:mime-version:subject
         :references:in-reply-to:message-id:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=xux5QvP8YQiJThcV5md5s9PvW9xG2SSFmNPqLeHDz08=;
        b=B40QmB+Gycyao8+wubKt3AR2upjV4VgZgy5Gfy3+cSWN+I6OVRwo4MIBzGzw0A9ufV
         ltPw4n423u2ZTr6o+aWfjCwmxZX8WzcrsTfoZzjjLwwNZbWsFM4pG8xy2EXLMP1mnbY1
         6imDmBADX61lDD6ZrOer7WnrXFGY+t6YYA0fBBCJMe/i5Vzly4RQt8whmv6PPe4ahUy4
         Y5kkQIOes/Rzz68sEUpNTu8xdq05v+TSSddvlT5+WFAxDgqZsrB+INEFvJnP4ZE7MfOa
         gfrFdWC7WwMSy6ZTRggpXYPJbuhdeITlcV5P7l89nnUjgPEObYmvL2h4rm0SAdcvu2ay
         JfPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792592229; x=1793197029;
        h=content-transfer-encoding:content-type:mime-version:subject
         :references:in-reply-to:message-id:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=xux5QvP8YQiJThcV5md5s9PvW9xG2SSFmNPqLeHDz08=;
        b=ySoNq5v6SSgPf3lVXmlzX/gd+XTUUPiy1kCdPXjGdaxGpxkpG9htn21vxw4exhJ3xV
         d2s1rQY3Z7Ljc8yq9NYfsbGadX+l57I/mBWB9SBR3PTsCmiccbY5trxBmn87NHj/XHwt
         TX1LkEk2vmtnnbPPJWhsIow/gV7UaDbEhj7qEzdW/iIGS0bd0ev38Vw0KRFSDNiGxwQO
         ZXAUdjyI1ro+/ynj/OQo+RtfoFtyKCvgmuqxtvo5UCsBZZQ2sTcSD23vm5Wkuwxk+CYQ
         7jrH8H0Zjx2JK1uDV1Wzunpe7X+IkffoJYvFr8CAHKzNu1mL9fGV1fQluVQJGTK8OwoT
         K2GQ==
X-Forwarded-Encrypted: i=1; AKwUvBxm85fE7FoVJXeY4Z+I0dmF6j56Rqlvzq5Ipg42BgM9307ocIppjIRu7x4Uz8iUdtxLNTmInrvsi8Nm9lF/RA==@lists.linux.dev
X-Gm-Message-State: AFq9FYI51XmXLc60UVKCpcWrjIS2K978gOe6COUqUqKeEhB/8EZ+sy5r
	GRfTRT07mXF5rTwrIqrr2qxELgw1jy6Z+Wum1T5NB9NyOcD5S4Goac0h
X-Gm-Gg: AYBFou3zIEKlo0OTv8sNM19mpberZhNL9d/ogx5BTxzclzgm5EM1D+8o4TNsy5CiqLY
	sIFvmhwzPQkpKjujwwZYDS+73BWXLkKZlSP4dJCmOCqkOBqP9lUp+b++SK8SVMR9Hfba5GT5axe
	fwvaQjfWSHbtU7xtPBmjJlo/9lI/VQ+kpYgc/x6yuSio+2tvyChC36i4rxbGiGRl0u/jaLX+IPe
	MqIJsl48mOMh90qkTi8Rp8b8dbTJOZ07j7eYbvtGtF31toM/H4pusBtuaUSjBZGVCJJzC52oZhC
	qhEZHn+MfTzL+XKdXuu1Gz8HLeXfy+el8uoWDsg+yoJ2pGnKy2QDAsNJCa3F6ts3Vh+CChypNHR
	jqdgXr7JW5uNZ8ctVmCPMU6Q4pX1e2Gh4B+dT2PO1/TMJb43iWmXl+qliZgMjS8MztuGlG8/dcO
	ekUGJL1mkfMwdTCau4CoPlgu5eQskyS9Syje7XpoIlwdl0E8g9+UmbbSN1qE3IdCVhCk/Yt637b
	m+5dkAkyouigKt4f6G7RHPFUTuMniRURv3Bde4hCgCpZHYeTp0sGIe8tPZscdGlpkkamAlXe+Bv
	8VepxZNSD9hwxOGbjYyVaDpWTLKYKERDlg8vTmz+L+tJDWn+KduUcaiEcB8PvKju10Gl1Hc474K
	9tY6R0cUiFxGHdYRuptA=
X-Received: by 2002:a05:6122:e145:b0:5ea:e197:43ee with SMTP id 71dfb90a1353d-5eaebe9cb1emr809668e0c.19.1792592229260;
        Wed, 21 Oct 2026 07:17:09 -0700 (PDT)
Received: from gmail.com (111.46.245.35.bc.googleusercontent.com. [35.245.46.111])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5eae969803dsm3503712e0c.2.2026.10.21.07.17.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Oct 2026 07:17:08 -0700 (PDT)
Date: Wed, 21 Oct 2026 10:17:07 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: "Michael S. Tsirkin" <mst@redhat.com>, 
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: linux-kernel@vger.kernel.org, 
 Chris Arges <carges@cloudflare.com>, 
 =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>, 
 Phil Sutter <phil@nwl.cc>, 
 Jason Wang <jasowangio@gmail.com>, 
 =?UTF-8?B?RXVnZW5pbyBQw6lyZXo=?= <eperezma@redhat.com>, 
 Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@kernel.org>, 
 Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, 
 netdev@vger.kernel.org, 
 virtualization@lists.linux.dev, 
 Max Krasnyansky <maxk@qualcomm.com>, 
 Rusty Russell <rusty@rustcorp.com.au>, 
 Paulos Yibelo <habte.yibelo@gmail.com>
Message-ID: <willemdebruijn.kernel.37619d32a8f3c@gmail.com>
In-Reply-To: <20261021035050-mutt-send-email-mst@kernel.org>
References: <cover.1792411304.git.mst@redhat.com>
 <9c08d12b3a7819ae03ded6a154e4f908276e93d4.1792411304.git.mst@redhat.com>
 <willemdebruijn.kernel.2eb449439b094@gmail.com>
 <20261020170908-mutt-send-email-mst@kernel.org>
 <willemdebruijn.kernel.1da723f98c23a@gmail.com>
 <20261021035050-mutt-send-email-mst@kernel.org>
Subject: Re: [PATCH net v3 5/8] net: resolve uncommon partial checksums at
 ingress
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable

Michael S. Tsirkin wrote:
> On Tue, Oct 20, 2026 at 08:05:29PM -0400, Willem de Bruijn wrote:
> > Michael S. Tsirkin wrote:
> > > On Tue, Oct 20, 2026 at 03:44:35PM -0400, Willem de Bruijn wrote:
> > > > > +/* Walk the L3 header at @nhoff: where does its transport head=
er
> > > > > + * start, and which protocol is it?  Returns false if the head=
er
> > > > > + * is truncated, malformed or fragmented.
> > > > > + */
> > > > > +static inline bool
> > > > > +virtio_net_l4_start(struct sk_buff *skb, unsigned int nhoff, _=
_be16 proto,
> > > > > +		    unsigned int *thoff, int *ip_proto)
> > > > > +{
> > > > > +	if (proto =3D=3D htons(ETH_P_IP)) {
> > > > > +		const struct iphdr *iph =3D virtio_net_ip4_parse(skb, nhoff,=
 thoff);
> > > > > +
> > > > > +		if (!iph || ip_is_fragment(iph))
> > > > > +			return false;
> > > > > +		*ip_proto =3D iph->protocol;
> > > > > +		return true;
> > > > > +	}
> > > > > +
> > > > > +	if (proto =3D=3D htons(ETH_P_IPV6)) {
> > > > > +		const struct ipv6hdr *iph;
> > > > > +		int flags =3D 0;
> > > > > +
> > > > > +		if (!pskb_may_pull(skb, nhoff + sizeof(*iph)))
> > > > > +			return false;
> > > > > +		iph =3D (const void *)(skb->data + nhoff);
> > > > > +		if (iph->version !=3D 6)
> > > > > +			return false;
> > > > > +		*thoff =3D nhoff + sizeof(*iph);
> > > > > +		*ip_proto =3D iph->nexthdr;
> > > > > +		if (*ip_proto !=3D IPPROTO_TCP && *ip_proto !=3D IPPROTO_UDP=
) {
> > > > > +			*thoff =3D nhoff;
> > > > > +			*ip_proto =3D ipv6_find_hdr(skb, thoff, -1, NULL,
> > > > > +						  &flags);
> > > > > +			if (*ip_proto < 0 || flags & IP6_FH_F_FRAG)
> > > > > +				return false;
> > > > > +		}
> > > > > +		return true;
> > > > > +	}
> > > > > +
> > > > > +	return false;
> > > > > +}
> > > > =

> > > > for all this parsing: could we use flow dissection, like the
> > > > !VIRTIO_NET_HDR_F_NEEDS_CSUM case?
> > > =

> > > Hmm I don't see how.  That one trusts the caller's protocol and net=
work
> > > header. We could parse L2 ourselves and use the dissector for L3+. =
But
> > > it stops at whatever it does not know, and every miss would turn in=
to a
> > > drop or a software checksum for a packet the stack delivers fine.  =
Our
> > > parser deliberately covers everything the stack can deliver.
> > =

> > You're right, the protocol and network offset need to be parsed
> > manually. After that it could be passed to the flow dissector.
> =

> I posted v4 with the custom parser, since i had it tested. Let's do
> cleanups on top? I spent too much time on this, to be frank.

Yes, as a matter of fact, on investigating this approach in more
detail, I agree that flow dissection is a worse choice.

> Hmm, an interesting trick, but I don't see how this works for tunnels?
> We need to dissect at inner_nh, and on success we can not leave
> network_header there - the packet continues to outer IP processing.
> I fear making all this work will be more code than the parsing it
> replaces.

On the upsides, quoting an LLM:

"
  Using the flow dissector replaces all of virtio_net_ip4_parse(), virtio=
_net_l3_start(), virtio_net_l4_start(), and
  virtio_net_csum_partial_ok_at_offset() with two compact functions:

   Function                                 |              Lines of Code =
              | Description
  ------------------------------------------|----------------------------=
--------------|-----------------------------------------------------
   virtio_net_setup_l3_input()              |                ~28 lines   =
              | Anchors L2 framing (eth_header_ops vs raw L3)
   virtio_net_csum_partial_ok()             |                ~42 lines   =
              | Runs flow dissector and validates thoff/csum_offset
   virtio_net_tnl_offsets_ok()              |                 ~8 lines   =
              | Reuses outer dissection keys for tunnel validation
   Total dedicated parsing code             |                ~78 lines   =
              |
  =E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80
  ### Summary of Differences

  =E2=80=A2 Net Code Reduction: ~103 fewer lines of C code added to virti=
o_net.h (~57% reduction in new parsing code).
  =E2=80=A2 Eliminated Series Dependencies: Patch 7/8 (net: add ip4_parse=
()) is completely eliminated, reducing the patch series by an entire patc=
h.
  =E2=80=A2 Deduplication: The existing non-checksum GSO validation in __=
virtio_net_hdr_to_skb() (lines 120=E2=80=93146, 27 lines) already calls
  skb_flow_dissect_flow_keys_basic(); sharing virtio_net_setup_l3_input()=
 consolidates both paths onto a single ingress dissection mechanism.
"

I particularly like that we use the same for NEEDS_CSUM and !NEEDS_CSUM.
Also the lack of code duplication.

But, the goal of this patch is to minimize overhead in the hot path of
standard TCP/IP and UDP code. And flow dissection is significantly more
expensive that open coding those specific checks.
