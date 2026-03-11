Received: from out30-130.freemail.mail.aliyun.com (out30-130.freemail.mail.aliyun.com [115.124.30.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F9E3374184
	for <virtualization@lists.linux.dev>; Wed, 11 Mar 2026 06:40:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773211213; cv=none; b=VVlAq2GpsrQaiEoeHeTw97NVZ63uUn2m3hJ3cLzz0shEV7CIKWdXaAbhmz+F7SZ4zLT8+RdWUa8dJxQGP/ohWQogYEh0AAFV0Wbq3rfC8Qo5wAOve1b3ddqBweiB5iXvR5yie3TbdEDpBQouMRUiaAkHPLGkIWt7I3UTlfPumLc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773211213; c=relaxed/simple;
	bh=ZsjOez3Qway2mYAXvu5QL0vJ5UlYJAMwXZdy+YBKfwI=;
	h=Message-ID:Subject:Date:From:To:Cc:References:In-Reply-To; b=eUVQ33TFJDkTdB73O0SOizURvigpZXKKUi0WRABoNdrxHJZwYKsP1lw9WSp8IMD1MduHdhXKf+jqrOtEHjFA3HQG7XiKk1UyG4ES+3f7Fdty66Q9ZtoNDaduohEHusncsZ6AZnoJdxKTDcwh88mGwoU4htdRKlmSwoges6LCiRA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=CcDeQUvO; arc=none smtp.client-ip=115.124.30.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="CcDeQUvO"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1773211199; h=Message-ID:Subject:Date:From:To;
	bh=uofCL946arayV1G7q+ZDv8qxg7fecoCepNUKFyCvd9k=;
	b=CcDeQUvOoiO/qsIQY4OOzMORYnbW6zhv5FTSWVtwgUuOEkMlDmg4Cpy+nWcVFYrMvkmMad4v5cPENgwoq0Kz+pPcR9B4MbKwVMPME3gpCgiH1gYiWT1YhjiD88vTB/BMCBLGNgzqBMYKLKPcXgEgnRYkxKNxngQk2tLI14byGKU=
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com fp:SMTPD_---0X-irTwk_1773211198 cluster:ay36)
          by smtp.aliyun-inc.com;
          Wed, 11 Mar 2026 14:39:59 +0800
Message-ID: <1773210927.2628298-1-xuanzhuo@linux.alibaba.com>
Subject: Re: [PATCH net v8 2/2] virtio-net: correct hdr_len handling for tunnel gso
Date: Wed, 11 Mar 2026 14:35:27 +0800
From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
To: Paolo Abeni <pabeni@redhat.com>
Cc: Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
 Jason Wang <jasowang@redhat.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 =?utf-8?q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>,
 Jiri Pirko <jiri@resnulli.us>,
 Alvaro Karsz <alvaro.karsz@solid-run.com>,
 virtualization@lists.linux.dev,
 netdev@vger.kernel.org
References: <20260305031938.24518-1-xuanzhuo@linux.alibaba.com>
 <20260305031938.24518-3-xuanzhuo@linux.alibaba.com>
 <cf62a942-e1e8-4b37-837a-b0bd76297656@redhat.com>
In-Reply-To: <cf62a942-e1e8-4b37-837a-b0bd76297656@redhat.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>

On Tue, 10 Mar 2026 11:05:33 +0100, Paolo Abeni <pabeni@redhat.com> wrote:
> On 3/5/26 4:19 AM, Xuan Zhuo wrote:
> > The commit a2fb4bc4e2a6a03 ("net: implement virtio helpers to handle UDP
> > GSO tunneling.") introduces support for the UDP GSO tunnel feature in
> > virtio-net.
> >
> > The virtio spec says:
> >
> >     If the \field{gso_type} has the VIRTIO_NET_HDR_GSO_UDP_TUNNEL_IPV4 bit or
> >     VIRTIO_NET_HDR_GSO_UDP_TUNNEL_IPV6 bit set, \field{hdr_len} accounts for
> >     all the headers up to and including the inner transport.
> >
> > The commit did not update the hdr_len to include the inner transport.
> >
> > I observed that the "hdr_len" is 116 for this packet:
> >
> >     17:36:18.241105 52:55:00:d1:27:0a > 2e:2c:df:46:a9:e1, ethertype IPv4 (0x0800), length 2912: (tos 0x0, ttl 64, id 45197, offset 0, flags [none], proto UDP (17), length 2898)
> >         192.168.122.100.50613 > 192.168.122.1.4789: [bad udp cksum 0x8106 -> 0x26a0!] VXLAN, flags [I] (0x08), vni 1
> >     fa:c3:ba:82:05:ee > ce:85:0c:31:77:e5, ethertype IPv4 (0x0800), length 2862: (tos 0x0, ttl 64, id 14678, offset 0, flags [DF], proto TCP (6), length 2848)
> >         192.168.3.1.49880 > 192.168.3.2.9898: Flags [P.], cksum 0x9266 (incorrect -> 0xaa20), seq 515667:518463, ack 1, win 64, options [nop,nop,TS val 2990048824 ecr 2798801412], length 2796
> >
> > 116 = 14(mac) + 20(ip) + 8(udp) + 8(vxlan) + 14(inner mac) + 20(inner ip) + 32(innner tcp)
> >
> > Fixes: a2fb4bc4e2a6a03 ("net: implement virtio helpers to handle UDP GSO tunneling.")
> > Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> > ---
> >  include/linux/virtio_net.h | 31 ++++++++++++++++++++-----------
> >  1 file changed, 20 insertions(+), 11 deletions(-)
> >
> > diff --git a/include/linux/virtio_net.h b/include/linux/virtio_net.h
> > index 23f42bb8ece0..906157779955 100644
> > --- a/include/linux/virtio_net.h
> > +++ b/include/linux/virtio_net.h
> > @@ -209,18 +209,29 @@ static inline int virtio_net_hdr_to_skb(struct sk_buff *skb,
> >
> >  static inline void virtio_net_set_hdrlen(const struct sk_buff *skb,
> >  					 struct virtio_net_hdr *hdr,
> > +					 struct skb_shared_info *sinfo,
> >  					 bool little_endian,
> >  					 bool feature_hdrlen)
> >  {
> >  	u16 hdr_len;
> >
> >  	if (feature_hdrlen) {
> > -		hdr_len = skb_transport_offset(skb);
> > -
> > -		if (hdr->gso_type == VIRTIO_NET_HDR_GSO_UDP_L4)
> > -			hdr_len += sizeof(struct udphdr);
> > -		else
> > -			hdr_len += tcp_hdrlen(skb);
> > +		if (sinfo->gso_type & (SKB_GSO_UDP_TUNNEL |
> > +				       SKB_GSO_UDP_TUNNEL_CSUM)) {
> > +			hdr_len = skb_inner_transport_offset(skb);
> > +
> > +			if (hdr->gso_type == VIRTIO_NET_HDR_GSO_UDP_L4)
> > +				hdr_len += sizeof(struct udphdr);
> > +			else
> > +				hdr_len += inner_tcp_hdrlen(skb);
> > +		} else {
> > +			hdr_len = skb_transport_offset(skb);
> > +
> > +			if (hdr->gso_type == VIRTIO_NET_HDR_GSO_UDP_L4)
> > +				hdr_len += sizeof(struct udphdr);
> > +			else
> > +				hdr_len += tcp_hdrlen(skb);
> > +		}
>
> I already mentioned the following a couple of times, with no replies...
> perhaps the 3rd attempt will be more successful.
>
> I think it's a bad adding tunnel specific check here. It sounds like
> layering violation. Instead you could have tunnel-specific variant, say
> virtio_net_set_tnl_hdrlen(), and use it in virtio_net_hdr_tnl_from_skb().
>
> Or you could try what i suggested in:
>
> https://lore.kernel.org/netdev/CAF6piCLkv6kFqoq7OQfJ=Su9AVHSQ9J7DzaumOSf5xuf9w-kyA@mail.gmail.com/#t

I saw your suggestions, though I didn't reply directly. I proceeded to adjust
the code based on my understanding of your feedback, but it appears my
understanding was incorrect. After re-reading your suggestions, I think
virtio_net_hdr_from_skb does not need to be changed. Instead, within
virtio_net_hdr_tnl_from_skb, we should directly call the device header length
function based on whether the feature is negotiated.

Thanks.

>
> Thanks,
>
> Paolo
>
