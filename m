Received: from out30-131.freemail.mail.aliyun.com (out30-131.freemail.mail.aliyun.com [115.124.30.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F180C2C0F81
	for <virtualization@lists.linux.dev>; Tue, 10 Mar 2026 08:40:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773132061; cv=none; b=eqqdgJsrUUzI0qNV6I8jsko2Fi/JgZAXfwOgorEm3P2/FtoPuR/LG3+4Om5kDWgFObpdvyNPpS3el3/DG0RdYZe/DJnadnlgxagDctYIi9ywHJ4d4wezq3R2MZ8f0KQO1vssXo3U6PE5cUQybwkwUmZPsO1jI/RMzJtPp6u6n4A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773132061; c=relaxed/simple;
	bh=//cC0mocz8jaym8o8kY642f5CJM1C+CpTyJbcTFrSAk=;
	h=Message-ID:Subject:Date:From:To:Cc:References:In-Reply-To:
	 Content-Type; b=JrZ8ZzyExA8lHzap8JaP6MhqLNRZ25wkr5TN7PJ4ntUe8anGrcAejYcE1DI1S2M/KNXA8XbQAPgsaWZDudkOVfLzj4jihDaqKxH2drepb4hUbrHvr6PkwGjAh3sBaCOSqSrS/7AOWV7EBIrKAEs6SK3z9sl1KhLBBz8NUN+31vc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=gZXiqb3e; arc=none smtp.client-ip=115.124.30.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="gZXiqb3e"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1773132052; h=Message-ID:Subject:Date:From:To:Content-Type;
	bh=rujYVY5Fv98QolAP6Cl6fC/eHgCxMjVW9dNmmnp+dLQ=;
	b=gZXiqb3e3LLMrO0N/2HngeY2gvlJ/1IcsS18OUqQJjeF7FSMCi/zIHzQKZseoaY8CnAyo9H3Vne06CNB7yONlH9nFC8IQKg5xAwUO3aYkaW5rz7UY09GIv3nISkBAB4NcoMuxEOXnEHE7ApY2sNq1ntEmEUSszTS7EwxGq7QCdw=
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com fp:SMTPD_---0X-fWRCW_1773132051 cluster:ay36)
          by smtp.aliyun-inc.com;
          Tue, 10 Mar 2026 16:40:51 +0800
Message-ID: <1773132028.5063865-1-xuanzhuo@linux.alibaba.com>
Subject: Re: [PATCH net v8 1/2] virtio-net: correct hdr_len handling for VIRTIO_NET_F_GUEST_HDRLEN
Date: Tue, 10 Mar 2026 16:40:28 +0800
From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
To: Jason Wang <jasowang@redhat.com>
Cc: netdev@vger.kernel.org,
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 =?utf-8?q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>,
 Jiri Pirko <jiri@resnulli.us>,
 Alvaro Karsz <alvaro.karsz@solid-run.com>,
 virtualization@lists.linux.dev
References: <20260305031938.24518-1-xuanzhuo@linux.alibaba.com>
 <20260305031938.24518-2-xuanzhuo@linux.alibaba.com>
 <CACGkMEsmDiTP1tz1hur_tduOUFU1bYqNzQm9nQgPUfdfHrmcKw@mail.gmail.com>
In-Reply-To: <CACGkMEsmDiTP1tz1hur_tduOUFU1bYqNzQm9nQgPUfdfHrmcKw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>

On Tue, 10 Mar 2026 11:05:46 +0800, Jason Wang <jasowang@redhat.com> wrote:
> On Thu, Mar 5, 2026 at 11:19=E2=80=AFAM Xuan Zhuo <xuanzhuo@linux.alibaba=
.com> wrote:
> >
> > The commit be50da3e9d4a ("net: virtio_net: implement exact header length
> > guest feature") introduces support for the VIRTIO_NET_F_GUEST_HDRLEN
> > feature in virtio-net.
> >
> > This feature requires virtio-net to set hdr_len to the actual header
> > length of the packet when transmitting, the number of
> > bytes from the start of the packet to the beginning of the
> > transport-layer payload.
> >
> > However, in practice, hdr_len was being set using skb_headlen(skb),
> > which is clearly incorrect. This commit fixes that issue.
> >
> > Fixes: be50da3e9d4a ("net: virtio_net: implement exact header length gu=
est feature")
> > Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> > ---
> >  drivers/net/tun_vnet.h     |  2 +-
> >  drivers/net/virtio_net.c   |  6 +++-
> >  include/linux/virtio_net.h | 58 ++++++++++++++++++++++++++++++--------
> >  3 files changed, 53 insertions(+), 13 deletions(-)
> >
> > diff --git a/drivers/net/tun_vnet.h b/drivers/net/tun_vnet.h
> > index a5f93b6c4482..fa5cab9d3e55 100644
> > --- a/drivers/net/tun_vnet.h
> > +++ b/drivers/net/tun_vnet.h
> > @@ -244,7 +244,7 @@ tun_vnet_hdr_tnl_from_skb(unsigned int flags,
> >
> >         if (virtio_net_hdr_tnl_from_skb(skb, tnl_hdr, has_tnl_offload,
> >                                         tun_vnet_is_little_endian(flags=
),
> > -                                       vlan_hlen, true)) {
> > +                                       vlan_hlen, true, false)) {
> >                 struct virtio_net_hdr_v1 *hdr =3D &tnl_hdr->hash_hdr.hd=
r;
> >                 struct skb_shared_info *sinfo =3D skb_shinfo(skb);
> >
> > diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> > index 72d6a9c6a5a2..7106333ef904 100644
> > --- a/drivers/net/virtio_net.c
> > +++ b/drivers/net/virtio_net.c
> > @@ -3267,8 +3267,12 @@ static int xmit_skb(struct send_queue *sq, struc=
t sk_buff *skb, bool orphan)
> >         struct virtio_net_hdr_v1_hash_tunnel *hdr;
> >         int num_sg;
> >         unsigned hdr_len =3D vi->hdr_len;
> > +       bool feature_hdrlen;
> >         bool can_push;
> >
> > +       feature_hdrlen =3D virtio_has_feature(vi->vdev,
> > +                                           VIRTIO_NET_F_GUEST_HDRLEN);
> > +
> >         pr_debug("%s: xmit %p %pM\n", vi->dev->name, skb, dest);
> >
> >         /* Make sure it's safe to cast between formats */
> > @@ -3288,7 +3292,7 @@ static int xmit_skb(struct send_queue *sq, struct=
 sk_buff *skb, bool orphan)
> >
> >         if (virtio_net_hdr_tnl_from_skb(skb, hdr, vi->tx_tnl,
> >                                         virtio_is_little_endian(vi->vde=
v), 0,
> > -                                       false))
> > +                                       false, feature_hdrlen))
> >                 return -EPROTO;
> >
> >         if (vi->mergeable_rx_bufs)
> > diff --git a/include/linux/virtio_net.h b/include/linux/virtio_net.h
> > index 75dabb763c65..23f42bb8ece0 100644
> > --- a/include/linux/virtio_net.h
> > +++ b/include/linux/virtio_net.h
> > @@ -207,20 +207,40 @@ static inline int virtio_net_hdr_to_skb(struct sk=
_buff *skb,
> >         return __virtio_net_hdr_to_skb(skb, hdr, little_endian, hdr->gs=
o_type);
> >  }
> >
> > -static inline int virtio_net_hdr_from_skb(const struct sk_buff *skb,
> > -                                         struct virtio_net_hdr *hdr,
> > -                                         bool little_endian,
> > -                                         bool has_data_valid,
> > -                                         int vlan_hlen)
> > +static inline void virtio_net_set_hdrlen(const struct sk_buff *skb,
> > +                                        struct virtio_net_hdr *hdr,
> > +                                        bool little_endian,
> > +                                        bool feature_hdrlen)
> > +{
> > +       u16 hdr_len;
> > +
> > +       if (feature_hdrlen) {
> > +               hdr_len =3D skb_transport_offset(skb);
> > +
> > +               if (hdr->gso_type =3D=3D VIRTIO_NET_HDR_GSO_UDP_L4)
> > +                       hdr_len +=3D sizeof(struct udphdr);
> > +               else
> > +                       hdr_len +=3D tcp_hdrlen(skb);
>
> I may miss soemthing but this still looks wrong as we could have e.g
> USO and other UDP GSO packets.

Could you say more?

Thanks.


>
> > +       } else {
> > +               /* This is a hint as to how much should be linear. */
> > +               hdr_len =3D skb_headlen(skb);
> > +       }
> > +
> > +       hdr->hdr_len =3D __cpu_to_virtio16(little_endian, hdr_len);
> > +}
> > +
> > +static inline int __virtio_net_hdr_from_skb(const struct sk_buff *skb,
> > +                                           struct virtio_net_hdr *hdr,
> > +                                           bool little_endian,
> > +                                           bool has_data_valid,
> > +                                           bool feature_hdrlen,
> > +                                           int vlan_hlen)
> >  {
> >         memset(hdr, 0, sizeof(*hdr));   /* no info leak */
> >
> >         if (skb_is_gso(skb)) {
> >                 struct skb_shared_info *sinfo =3D skb_shinfo(skb);
> >
> > -               /* This is a hint as to how much should be linear. */
> > -               hdr->hdr_len =3D __cpu_to_virtio16(little_endian,
> > -                                                skb_headlen(skb));
> >                 hdr->gso_size =3D __cpu_to_virtio16(little_endian,
> >                                                   sinfo->gso_size);
> >                 if (sinfo->gso_type & SKB_GSO_TCPV4)
> > @@ -231,6 +251,10 @@ static inline int virtio_net_hdr_from_skb(const st=
ruct sk_buff *skb,
> >                         hdr->gso_type =3D VIRTIO_NET_HDR_GSO_UDP_L4;
> >                 else
> >                         return -EINVAL;
> > +
> > +               virtio_net_set_hdrlen(skb, hdr, little_endian,
> > +                                     feature_hdrlen);
> > +
> >                 if (sinfo->gso_type & SKB_GSO_TCP_ECN)
> >                         hdr->gso_type |=3D VIRTIO_NET_HDR_GSO_ECN;
> >         } else
> > @@ -250,6 +274,16 @@ static inline int virtio_net_hdr_from_skb(const st=
ruct sk_buff *skb,
> >         return 0;
> >  }
> >
> > +static inline int virtio_net_hdr_from_skb(const struct sk_buff *skb,
> > +                                         struct virtio_net_hdr *hdr,
> > +                                         bool little_endian,
> > +                                         bool has_data_valid,
> > +                                         int vlan_hlen)
> > +{
> > +       return __virtio_net_hdr_from_skb(skb, hdr, little_endian,
> > +                                        has_data_valid, false, vlan_hl=
en);
> > +}
> > +
> >  static inline unsigned int virtio_l3min(bool is_ipv6)
> >  {
> >         return is_ipv6 ? sizeof(struct ipv6hdr) : sizeof(struct iphdr);
> > @@ -385,7 +419,8 @@ virtio_net_hdr_tnl_from_skb(const struct sk_buff *s=
kb,
> >                             bool tnl_hdr_negotiated,
> >                             bool little_endian,
> >                             int vlan_hlen,
> > -                           bool has_data_valid)
> > +                           bool has_data_valid,
> > +                           bool feature_hdrlen)
> >  {
> >         struct virtio_net_hdr *hdr =3D (struct virtio_net_hdr *)vhdr;
> >         unsigned int inner_nh, outer_th;
> > @@ -395,8 +430,9 @@ virtio_net_hdr_tnl_from_skb(const struct sk_buff *s=
kb,
> >         tnl_gso_type =3D skb_shinfo(skb)->gso_type & (SKB_GSO_UDP_TUNNE=
L |
> >                                                     SKB_GSO_UDP_TUNNEL_=
CSUM);
> >         if (!tnl_gso_type)
> > -               return virtio_net_hdr_from_skb(skb, hdr, little_endian,
> > -                                              has_data_valid, vlan_hle=
n);
> > +               return __virtio_net_hdr_from_skb(skb, hdr, little_endia=
n,
> > +                                                has_data_valid,
> > +                                                feature_hdrlen, vlan_h=
len);
> >
> >         /* Tunnel support not negotiated but skb ask for it. */
> >         if (!tnl_hdr_negotiated)
> > --
> > 2.32.0.3.g01195cf9f
> >
>
> Thanks
>
