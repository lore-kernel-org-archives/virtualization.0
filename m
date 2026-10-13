Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A24AC4A015D
	for <virtualization@lists.linux.dev>; Tue, 13 Oct 2026 18:36:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791916569; cv=none; b=NBc2CXEmyPVfTM5yxAsT0s1pR38gKrqCwK23SKS7yYzVbL2AM/e6piNYzJ7MBzI/i0APpFZ2P6E66KaqFpYqsjnKvbLV/dZOYQg7jEqcmk/c+RdUS+Tp/TthT+n1h38CPDRGANg3ZpTWjSXpgLo/klZMnpC2UUsl7/ecYQVea88=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791916569; c=relaxed/simple;
	bh=MAxPv79SC7ka08t0N1OqDTI4zs64zksbZuXoiMgh/V4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=MmOPt5Nk28ArK1CiQuB9RWkm+1xV+JBHAYha8DeaLc1xUOMk6dQUg86b3QdRVDRhvqlMpjU0VDmod24WgB8Qa/zCrmlFM/IFSClZwNi9fYr6HX8T9eTr4CGpYt+dQ6ncw8x42G0SeQkAsTpEYy7p/S8GZ0S0SpGYvXLSLEPQrxI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=GF/N5LSU; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GF/N5LSU"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1791916565;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=kEbFOpHzK1vzTUUdGzQgP9nZrP1KHSfJ40m7HqU+RSk=;
	b=GF/N5LSUYjH2GDNk91c7+Rj/JgXZouMRKAM/y4y9S1rWG7M86O/m7xIwf5prpNWG8X2n/X
	4GNboZWQhwcVXYN9OBuTAWb/VkQK0fwasQfAf8H7q9cnO2JlFo1Hdn5bFZK1kMuZuNQg/W
	eF9G8nHFjatSmOUQUfzATWNSnzO556Y=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-650-mfzNuNoGM2aKaqJ88leMkA-1; Tue, 13 Oct 2026 18:36:04 +0000
X-MC-Unique: mfzNuNoGM2aKaqJ88leMkA-1
X-Mimecast-MFC-AGG-ID: mfzNuNoGM2aKaqJ88leMkA_1791916563
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-48589603501so2345900f8f.3
        for <virtualization@lists.linux.dev>; Tue, 13 Oct 2026 11:36:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791916562; x=1792521362;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=kEbFOpHzK1vzTUUdGzQgP9nZrP1KHSfJ40m7HqU+RSk=;
        b=hzFdNudPWBhN7IzuqDNojesesn8SbTB3mWg/alx0oZYmJYb8vA9ElnPLcCRoBdjfDV
         X1OYlieAm2gxpQtliRx5tplV3IUlfsQLXydrY0TC/S5bMPkLywTVbXzIpOMiaeJ0Sw00
         /A6wjRuQl0t0KXoPA7ulxfEG0qI6mtZVnNS/VW3GhlmsusEZ1rLkO0ai8h3NWASOmHBL
         kBB308tf/ZjIW+BPYHK/jdlROyhzXyWPA/xl0nUTsEtcbTciPr5tYhLuqlEPcsCnJXCk
         lcx6dqU9+iVQIqobQdwvfhOWVqTuUu7KSxeUyBVxzvx57DQ0JOynadKr6inJMuZh1/w7
         Kmtg==
X-Forwarded-Encrypted: i=1; AKwUvBwQFYJOgDjwhZI+a0d6xlHFkvAzXAFvPH0zLcebwSAtncba7tDs1yT5duI4aGhSaCp+EMuwKQw/i1vWV3l0Gw==@lists.linux.dev
X-Gm-Message-State: AFq9FYKN4qYiD013VgBlG8Vdajn9jVv/9JyF4oPl29K1h7Hqu/BB7AGU
	dYSCJIRDf3ccPzXV1EWN/9erAWSDSF6G0fttZxKeIw7upA9bIwBOyvEny5m/BcM0wC5EFGeJ0lV
	Qk5ljdsVJra0ioySrO6mToUB3wLAYh2z2ZTNYGr8niBvFltW1Z1Rju8DmCFYK2BjEkCZXZrPQxJ
	gS
X-Gm-Gg: AYBFou0efBPMrXF9jxgXRh5jV4vriLlpV+CGCti8tsKpsD5T++9y6FJWoOiA1qdIafF
	wHXgiOlJjMNDvcOiTL5fjBYLAEHpJXeBm/GJbIYdszAUNaAc6KJTuIcuacKoqRHEQfj7DAxo8qM
	+x6BbuUjCO/2KpNk5qkaefKciORqNgL5tHQps5t8mczW6x27ie/fpKpY4FgAfC3F7Xo+ZygZSzy
	jvcFsqNcg+iGgogxpnenTP9pojmmU0F0hm/HcjKJpvlcCM0+VLVSwJWHf8EHwlLdcLSOHTnPF/g
	gS3ivIlbs84kwOlDqfClrWi8kfYe2209m5RUxu8vwgRIejhtfDrgexCABkLZwUeg27BJVg==
X-Received: by 2002:a5d:5542:0:b0:487:2777:6354 with SMTP id ffacd0b85a97d-48dbaae7239mr20582212f8f.48.1791916562413;
        Tue, 13 Oct 2026 11:36:02 -0700 (PDT)
X-Received: by 2002:a5d:5542:0:b0:487:2777:6354 with SMTP id ffacd0b85a97d-48dbaae7239mr20582159f8f.48.1791916561732;
        Tue, 13 Oct 2026 11:36:01 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:3fd7:5300:3d6b:52a4:a23f:9d0b])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48de0514ab1sm8613881f8f.0.2026.10.13.11.35.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Oct 2026 11:36:01 -0700 (PDT)
Date: Tue, 13 Oct 2026 14:35:57 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: linux-kernel@vger.kernel.org, Jason Wang <jasowangio@gmail.com>,
	Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, virtualization@lists.linux.dev,
	Max Krasnyansky <maxk@qualcomm.com>,
	Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: [PATCH net-next 3/4] net: resolve uncommon partial checksums at
 ingress
Message-ID: <20261013143335-mutt-send-email-mst@kernel.org>
References: <cover.1791887415.git.mst@redhat.com>
 <e12c6a45aae251d1642af55d8d3121e554993a66.1791887415.git.mst@redhat.com>
 <20261013070549-mutt-send-email-mst@kernel.org>
 <CAF=yD-KdTn2rHyp_j8ORr9F5hpm=TzaPRan5+gvLiYBd9HP-sg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <CAF=yD-KdTn2rHyp_j8ORr9F5hpm=TzaPRan5+gvLiYBd9HP-sg@mail.gmail.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: qsiMa--Aj7EJSaU772rNDkAdJEZlW0cF9cfCJIxqL-Q_1791916563
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

On Tue, Oct 13, 2026 at 09:03:04AM -0600, Willem de Bruijn wrote:
> On Tue, Oct 13, 2026 at 5:06 AM Michael S. Tsirkin <mst@redhat.com> wrote:
> >
> > On Tue, Oct 13, 2026 at 06:58:41AM -0400, Michael S. Tsirkin wrote:
> > > A virtio net header can place CHECKSUM_PARTIAL at any in-packet
> > > offset.  If that state is retained, later checksum completion can
> > > modify the packet after protocol processing has made decisions from it.
> > >
> > > Let's fix that: let's validate csum_start and csum_offset and only keep
> > > CHECKSUM_PARTIAL when csum_start and csum_offset match a parsed TCP or
> > > UDP header, while handling VLAN headers, IPv4 options and IPv6 extension
> > > headers.  Complete other non-GSO checksums immediately, before any
> > > protocol processing runs.
> > >
> > > We can't easily "complete the checksum" for GSO we don't recognize - GSO
> > > assumes knowledge of the protocol. We could segment ignoring the
> > > checksum then do whatever csum_start and csum_offset say, but that
> > > seems like an overkill for something that should happen.
> > >
> > > UDP tunnel headers get the same handling on the inner header.
> > >
> > > Packets without VIRTIO_NET_HDR_F_NEEDS_CSUM are unaffected.
> > >
> > > Suggested-by: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
> > > Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> > > Assisted-by: LLM
> >
> >
> > I forgot reported-by tags:
> >
> > Reported-by: Paulos Yibelo <habte.yibelo@gmail.com>
> > Reported-by: Chris Arges <carges@cloudflare.com>
> >
> >
> > > ---
> > >  include/linux/virtio_net.h | 151 ++++++++++++++++++++++++++++++++-----
> > >  1 file changed, 133 insertions(+), 18 deletions(-)
> > >
> > > diff --git a/include/linux/virtio_net.h b/include/linux/virtio_net.h
> > > index d6466f96cdd00..b181183118b3a 100644
> > > --- a/include/linux/virtio_net.h
> > > +++ b/include/linux/virtio_net.h
> > > @@ -5,7 +5,11 @@
> > >  #include <linux/if_vlan.h>
> > >  #include <linux/ip.h>
> > >  #include <linux/ipv6.h>
> > > +#include <linux/netdevice.h>
> > >  #include <linux/udp.h>
> > > +#include <net/gso.h>
> > > +#include <net/ip.h>
> > > +#include <net/ipv6.h>
> > >  #include <net/tcp.h>
> > >  #include <uapi/linux/tcp.h>
> > >  #include <uapi/linux/virtio_net.h>
> > > @@ -48,15 +52,111 @@ static inline int virtio_net_hdr_set_proto(struct sk_buff *skb,
> > >       return 0;
> > >  }
> > >
> > > +/* Does checksum metadata match a known TCP or UDP header? */
> > > +static inline bool
> > > +virtio_net_csum_partial_ok_at_offset(struct sk_buff *skb, u8 hdr_gso_type,
> > > +                                  unsigned int nhoff, __be16 proto)
> > > +{
> > > +     unsigned int thoff;
> > > +     int ip_proto;
> > > +
> > > +     if (proto == htons(ETH_P_IP)) {
> > > +             const struct iphdr *iph = ip4_parse(skb, nhoff, &thoff);
> > > +
> > > +             if (!iph || ip_is_fragment(iph))
> > > +                     return false;
> > > +             ip_proto = iph->protocol;
> > > +     } else if (proto == htons(ETH_P_IPV6)) {
> > > +             const struct ipv6hdr *iph;
> > > +             int flags = 0;
> > > +
> > > +             if (!pskb_may_pull(skb, nhoff + sizeof(*iph)))
> > > +                     return false;
> > > +             iph = (const void *)(skb->data + nhoff);
> > > +             if (iph->version != 6)
> > > +                     return false;
> > > +             thoff = nhoff + sizeof(*iph);
> > > +             ip_proto = iph->nexthdr;
> > > +             if (ip_proto != IPPROTO_TCP && ip_proto != IPPROTO_UDP) {
> > > +                     thoff = nhoff;
> > > +                     ip_proto = ipv6_find_hdr(skb, &thoff, -1, NULL,
> > > +                                              &flags);
> 
> Skip this rare case of extension headers?
> 
> > > +                     if (ip_proto < 0 || flags & IP6_FH_F_FRAG)
> > > +                             return false;
> > > +             }
> > > +     } else {
> > > +             return false;
> > > +     }
> > > +
> 
> > >  static inline int __virtio_net_hdr_to_skb(struct sk_buff *skb,
> > >                                         const struct virtio_net_hdr *hdr,
> > > -                                       bool little_endian, u8 hdr_gso_type)
> > > +                                       bool little_endian, u8 hdr_gso_type,
> > > +                                       bool need_csum_check)
> > >  {
> > > -     unsigned int nh_min_len = sizeof(struct iphdr);
> > > +     typeof(skb->transport_header) old_transport = skb->transport_header;
> > >       unsigned int gso_type = 0;
> > >       unsigned int thlen = 0;
> > >       unsigned int p_off = 0;
> > >       unsigned int ip_proto;
> > > +     bool csum_partial_ok = true;
> > >
> > >       if (hdr_gso_type != VIRTIO_NET_HDR_GSO_NONE) {
> > >               switch (hdr_gso_type & ~VIRTIO_NET_HDR_GSO_ECN) {
> > > @@ -69,7 +169,6 @@ static inline int __virtio_net_hdr_to_skb(struct sk_buff *skb,
> > >                       gso_type = SKB_GSO_TCPV6;
> > >                       ip_proto = IPPROTO_TCP;
> > >                       thlen = sizeof(struct tcphdr);
> > > -                     nh_min_len = sizeof(struct ipv6hdr);
> > >                       break;
> > >               case VIRTIO_NET_HDR_GSO_UDP:
> > >                       gso_type = SKB_GSO_UDP;
> > > @@ -104,11 +203,11 @@ static inline int __virtio_net_hdr_to_skb(struct sk_buff *skb,
> > >
> > >               if (!skb_partial_csum_set(skb, start, off))
> > >                       return -EINVAL;
> > > -             if (skb_transport_offset(skb) < nh_min_len)
> > > -                     return -EINVAL;
> > > +             if (need_csum_check)
> > > +                     csum_partial_ok =
> > > +                             virtio_net_csum_partial_ok(skb, hdr_gso_type);
> > >
> > > -             nh_min_len = skb_transport_offset(skb);
> > > -             p_off = nh_min_len + thlen;
> > > +             p_off = skb_transport_offset(skb) + thlen;
> > >               if (!pskb_may_pull(skb, p_off))
> > >                       return -EINVAL;
> > >       } else if (gso_type) {
> > > @@ -158,8 +257,6 @@ static inline int __virtio_net_hdr_to_skb(struct sk_buff *skb,
> > >               case SKB_GSO_UDP_L4:
> > >                       if (!(hdr->flags & VIRTIO_NET_HDR_F_NEEDS_CSUM))
> > >                               return -EINVAL;
> > > -                     if (skb->csum_offset != offsetof(struct udphdr, check))
> > > -                             return -EINVAL;
> > >                       if (skb->len - p_off > gso_size * UDP_MAX_SEGMENTS)
> > >                               return -EINVAL;
> > >                       if (gso_type != SKB_GSO_UDP_L4)
> > > @@ -167,10 +264,6 @@ static inline int __virtio_net_hdr_to_skb(struct sk_buff *skb,
> > >                       break;
> > >               case SKB_GSO_TCPV4:
> > >               case SKB_GSO_TCPV6:
> > > -                     if (skb->ip_summed == CHECKSUM_PARTIAL &&
> > > -                         skb->csum_offset != offsetof(struct tcphdr, check))
> > > -                             return -EINVAL;
> > > -
> > >                       BUILD_BUG_ON(TCP_MIN_GSO_SIZE * GSO_MAX_SEGS < GSO_MAX_SIZE);
> > >                       gso_size = max(gso_size, TCP_MIN_GSO_SIZE);
> > >                       break;
> > > @@ -191,6 +284,17 @@ static inline int __virtio_net_hdr_to_skb(struct sk_buff *skb,
> > >               }
> > >       }
> > >
> > > +     if ((hdr->flags & VIRTIO_NET_HDR_F_NEEDS_CSUM) && !csum_partial_ok) {
> > > +             int err;
> > > +
> > > +             if (skb_is_gso(skb))
> > > +                     return -EINVAL;
> > > +
> > > +             err = skb_checksum_help(skb);
> 
> Instead of this variable csum_partial_ok and this branch, could
> virtio_net_csum_partial_ok just call skb_checksum_help directly and
> drop VIRTIO_NET_HDR_F_NEEDS_CSUM?
> 
> > > +             skb->transport_header = old_transport;
> > > +             return err;
> > > +     }
> > > +
> > >       return 0;
> > >  }
> > >
> > > @@ -198,7 +302,8 @@ static inline int virtio_net_hdr_to_skb(struct sk_buff *skb,
> > >                                       const struct virtio_net_hdr *hdr,
> > >                                       bool little_endian)
> > >  {
> > > -     return __virtio_net_hdr_to_skb(skb, hdr, little_endian, hdr->gso_type);
> > > +     return __virtio_net_hdr_to_skb(skb, hdr, little_endian,
> > > +                                    hdr->gso_type, true);
> 
> Would be great if we can avoid the extra arg and having to update the callers.
> 
> > >  }
> > >
> > >  /* This function must be called after virtio_net_hdr_from_skb(). */
> > > @@ -293,6 +398,7 @@ virtio_net_hdr_tnl_to_skb(struct sk_buff *skb,
> > >       unsigned int inner_nh, outer_th, inner_th;
> > >       unsigned int inner_l3min, outer_l3min;
> > >       u8 gso_inner_type, gso_tunnel_type;
> > > +     __be16 inner_proto;
> > >       bool outer_isv6, inner_isv6;
> > >       int ret;
> > >
> > > @@ -334,7 +440,7 @@ virtio_net_hdr_tnl_to_skb(struct sk_buff *skb,
> > >
> > >       /* Let the basic parsing deal with plain GSO features. */
> > >       ret = __virtio_net_hdr_to_skb(skb, hdr, true,
> > > -                                   hdr->gso_type & ~gso_tunnel_type);
> > > +                                   hdr->gso_type & ~gso_tunnel_type, false);
> > >       if (ret)
> > >               return ret;
> > >
> > > @@ -352,8 +458,8 @@ virtio_net_hdr_tnl_to_skb(struct sk_buff *skb,
> > >                       return -EINVAL;
> > >       }
> > >
> > > -     skb_set_inner_protocol(skb, inner_isv6 ? htons(ETH_P_IPV6) :
> > > -                                              htons(ETH_P_IP));
> > > +     inner_proto = inner_isv6 ? htons(ETH_P_IPV6) : htons(ETH_P_IP);
> > > +     skb_set_inner_protocol(skb, inner_proto);
> 
> Can drop
> 
> > >       if (hdr->flags & VIRTIO_NET_HDR_F_UDP_TUNNEL_CSUM) {
> > >               if (!tnl_csum_negotiated)
> > >                       return -EINVAL;
> > > @@ -368,7 +474,16 @@ virtio_net_hdr_tnl_to_skb(struct sk_buff *skb,
> > >       skb->inner_mac_header = inner_nh + skb_headroom(skb);
> > >       skb->transport_header = outer_th + skb_headroom(skb);
> > >       skb->encapsulation = 1;
> > > -     return 0;
> > > +
> > > +     if (virtio_net_csum_partial_ok_at_offset(skb, gso_inner_type, inner_nh,
> > > +                                            inner_proto))
> > > +             return 0;
> > > +
> > > +     if (skb_is_gso(skb))
> > > +             return -EINVAL;
> 
> This is a risk the commit message will have to call out.

I tried with this:

	> > > We can't easily "complete the checksum" for GSO we don't recognize - GSO
	> > > assumes knowledge of the protocol. We could segment ignoring the
	> > > checksum then do whatever csum_start and csum_offset say, but that
	> > > seems like an overkill for something that should happen.

I guess I can add a more detailed explanation about what the risk is?


> I don't see a simple way around it. We discussed segmenting here too,
> but that requires intrusive changes to all callers too.
> Alternatively,
> 
> 1. call segmentation, but only to see it remove the SKB_GSO_DODGY and
> thus verify that the TSO/USO packet is valid. Still drop otherwise.
> This also does not add overhead, because it would be called later
> anyway.
> 
> 2. a failsafe off-by-default sysctl + static_branch that skips the
> drop when set. Messy, but so is the situation we're dealing with.

Tack this on top or do you feel it's needed straight away.

