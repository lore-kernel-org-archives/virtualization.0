Received: from mail-yx1-f49.google.com (mail-yx1-f49.google.com [74.125.224.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACFB34F96D9
	for <virtualization@lists.linux.dev>; Tue, 13 Oct 2026 15:03:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791903824; cv=pass; b=soLXAxJ09JqTeG/sqmQPv+zNvkxg9vI0cV6cEH3LgO2j9aKHlmdeXiLg5mTYYWI5lje2ZQ/PAIIshHzJtn17HWsC4Csl7TAsL45zpnXEtIlPTz27HVoPzGbcTbhuILwX2g8dwWMGo2zYUrFvGDZ1sw0Hws5Zh0eazn5HaZuBrL4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791903824; c=relaxed/simple;
	bh=+eij/G2Lm+NMEdrFlAebvXiQrLdEbAv/JU7usPIRAvk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=b4RzXxf3U9iz0BZaLB51e4C0eUnj1jbo9dL9EKo9/wvXjQmx3R21BhihMRYsdwzXOIBu2ee9Brqp4bUfc/KFXPU5y7pnrhc6TsdELwQ+4fAyOpxM+yuoXLMecSdap2FEDE7zzGXeVz39CCmToinnF7c1IMcvhsZ1cqBBgyp2Wzk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ITcuafj2; arc=pass smtp.client-ip=74.125.224.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ITcuafj2"
Received: by mail-yx1-f49.google.com with SMTP id 956f58d0204a3-67583c777abso3114398d50.1
        for <virtualization@lists.linux.dev>; Tue, 13 Oct 2026 08:03:42 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791903822; cv=none;
        d=google.com; s=arc-20260327;
        b=rwfSWZ4flaS2xq7JDo23MYyZNr9dypy6vA+QNfKMhO8WxnaPn8/gNm8AKyUsz2VDT/
         NF7UGVjYbOociQyr7wjqeo8/DgCXwHpXAAvE6EJT7fhbmGaShZpJSe/8BYoQKjkgQ6jW
         TLxL1DkJCeTiYm0eBw2lrFC+LPaKNvtl6BEY1V9zcWV8QrS7z3sFHmt5nqwg6Bxx87rA
         4FLBLQ/UJxQrlfkIYZa0KWkiolh1PWjsc+UpsSVn4mJZCgeKkRrc7Jd6XpxJUyyD/Wvz
         g0OAFc9jxrB9C88wq2FwvBxMjwAZou+8h1kOtcNFi2bqEgVr+PNmAqk4xw0ImHG3l4n0
         3anA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=8bVCWyXyAJ87Bpk+/KBAvFqd9dRCgnolvbDj0gw9Hsg=;
        fh=RziqimAHL06Ewos96pcwPOMyTILkbiFn13WHHiPSNro=;
        b=YP3K2rEzRe+O5/QRuhBcpIxqZRnQ4SRvrR7HakrTGuqtTq4mtpk7IRWIbZ/C3PLrOH
         7kgiQcbh5WLmsgDB6dPtzLUpos5vGgor7b18hpbVSLRsa5THQC4LTw/hVfNcA2aH+Bsq
         9Bq9SBo/m6dUkn4OW9ET/7zIexkNf8dY+E1aNyRwJSuMv7SD1pt6WUQcwVloVbwN6dE7
         nnM8a9VDwB39Olh3xuF5PregIMKATdy7xUe4hMPwa/BKVcyORD+/ty+a2RbVx8wK2u6H
         rbkCR6yZxtDyJaBChrERxIwL0qqscmGS0bDvTYRVy8VoZPYd8oK+q7hlcjInomAZvt9F
         m7cA==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791903822; x=1792508622; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=8bVCWyXyAJ87Bpk+/KBAvFqd9dRCgnolvbDj0gw9Hsg=;
        b=ITcuafj2Ig/n5sV+3gpCaCeIJDquBvk7e8hsbOaogzXc5xHpesHHrUsmFHL4xrDyc7
         ju/uicsdDsHrmmJUfmyBRzw003UX+ZyewtOZ10igL/uLlqETHA8Pi60XVlT7HjaB0Kg6
         ldIc5ViXH81d5qaztA3AYY44txPuP5Quf3I0O+7NkhyP1pa2yOuSBlb2jXniRDXqGIib
         tVBFZeC1hIHkIqyWstzdYYeY08MDebFT0Y+sJVgjiq9gzILaRFPG1x94KkXER9ZTVGDX
         blqWfAcUGvZZwdlgd6kGSW5teSrKgZW7KK8xUsQCaYkYcDAukfwfQb3c8MLGR+XkKf4Z
         Ndcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791903822; x=1792508622;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=8bVCWyXyAJ87Bpk+/KBAvFqd9dRCgnolvbDj0gw9Hsg=;
        b=O9V+pOik0KQOFLS/3Um++kU85jwfrSDGpLJaaySFcgRimR6D10Z4G2E1csExu54LmG
         0tfOez1DRtohNdi2eocVIwvWZnkQxPCrOWTScHcKKlzBHmmBewOsJxMnbeNiEnFTRbJg
         eckkLXzbu94pSf3W0Dkn+XBgp0Apso/tDgWG+MvbKkPVtr+AJ7waDQvBGn6I2qEHSZk4
         bJ/tdM9wcoAka/gNqplpZRDsu8bH6MbfCoqnQ6BjRugj8uvGbim6ZARJVyAoSPhtB3d8
         M0X49huVSU4Al+XXTEpcfP91k8YEsjWXlT22+40Sne0xuBPyeLxqUHGFBPtA5aNmjSdH
         iB7Q==
X-Forwarded-Encrypted: i=1; AKwUvBxTrN0CprfkjSPmqOACQd7HjjP6aE/0gYkVWqJIH0naVwyl6X4nnpPr6gHWZPNKova3r2PYtlX3skvHAgAgZA==@lists.linux.dev
X-Gm-Message-State: AFq9FYJ074sy+AJD34cU3IQ0u9P3w12EqITyBiF4hJLw/xFMGguLutlf
	YhVFg0wRZIL1NGzV1FGjYry6N9m/z4PiaFXb+3KoU9w8NfaDpJVTZhSad4jQW+2+UZE+f3IuNro
	U+bX+9FE0sPthJODMtFPaFDn4o4QF05o=
X-Gm-Gg: AYBFou2x6Uowtd5ghZkdrAaOXvuIuLAUTSNXf/0WDjvy2V+xL2U7XW8McFESRz4b9NX
	MoWBJEM0IuNrr8eCl8lAs7JmytXkVh+hXxK21FPxIuSZx8pytuKJw+OmcvLQakwWEPnYV4rWlC8
	IRqZos6YlBw5gXcdUBnkw8Ax40bVO4nHcz5YhxyXKzDIfZZlleQMBe1tDNQax/nLRutmD4l3H/z
	m6vmONrqIauXq3saUwAxqIWplefp7Zbi5WRlJBzTU62e6TZAFp0VDzG3W8FA1gD0nMAqTBSXqsq
	NECvk/R3/4Odos+DnWN1Hle/l+RJezK7C14hIA12dzywMk+MYuerAMwFE+q0XNZi8601jlYH3ub
	xNH7EBGUWjiRKmLSiRACULFq1Vq2w2Nlm9MGz8ieI6fAk0on6M1IHEBRFYyRQJ6bStcmhDZE/xg
	==
X-Received: by 2002:a05:690e:4006:b0:676:a451:56c1 with SMTP id
 956f58d0204a3-679389761b3mr4524606d50.18.1791903821598; Tue, 13 Oct 2026
 08:03:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <cover.1791887415.git.mst@redhat.com> <e12c6a45aae251d1642af55d8d3121e554993a66.1791887415.git.mst@redhat.com>
 <20261013070549-mutt-send-email-mst@kernel.org>
In-Reply-To: <20261013070549-mutt-send-email-mst@kernel.org>
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Date: Tue, 13 Oct 2026 09:03:04 -0600
X-Gm-Features: AclHuK8snF8YE0eqA9W8zewtwfsVp9_Bp6rl047NuKz25jav8f4v7tPrgiX8INI
Message-ID: <CAF=yD-KdTn2rHyp_j8ORr9F5hpm=TzaPRan5+gvLiYBd9HP-sg@mail.gmail.com>
Subject: Re: [PATCH net-next 3/4] net: resolve uncommon partial checksums at ingress
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: linux-kernel@vger.kernel.org, Jason Wang <jasowangio@gmail.com>, 
	=?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org, 
	virtualization@lists.linux.dev, Max Krasnyansky <maxk@qualcomm.com>, 
	Rusty Russell <rusty@rustcorp.com.au>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 13, 2026 at 5:06=E2=80=AFAM Michael S. Tsirkin <mst@redhat.com>=
 wrote:
>
> On Tue, Oct 13, 2026 at 06:58:41AM -0400, Michael S. Tsirkin wrote:
> > A virtio net header can place CHECKSUM_PARTIAL at any in-packet
> > offset.  If that state is retained, later checksum completion can
> > modify the packet after protocol processing has made decisions from it.
> >
> > Let's fix that: let's validate csum_start and csum_offset and only keep
> > CHECKSUM_PARTIAL when csum_start and csum_offset match a parsed TCP or
> > UDP header, while handling VLAN headers, IPv4 options and IPv6 extensio=
n
> > headers.  Complete other non-GSO checksums immediately, before any
> > protocol processing runs.
> >
> > We can't easily "complete the checksum" for GSO we don't recognize - GS=
O
> > assumes knowledge of the protocol. We could segment ignoring the
> > checksum then do whatever csum_start and csum_offset say, but that
> > seems like an overkill for something that should happen.
> >
> > UDP tunnel headers get the same handling on the inner header.
> >
> > Packets without VIRTIO_NET_HDR_F_NEEDS_CSUM are unaffected.
> >
> > Suggested-by: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
> > Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> > Assisted-by: LLM
>
>
> I forgot reported-by tags:
>
> Reported-by: Paulos Yibelo <habte.yibelo@gmail.com>
> Reported-by: Chris Arges <carges@cloudflare.com>
>
>
> > ---
> >  include/linux/virtio_net.h | 151 ++++++++++++++++++++++++++++++++-----
> >  1 file changed, 133 insertions(+), 18 deletions(-)
> >
> > diff --git a/include/linux/virtio_net.h b/include/linux/virtio_net.h
> > index d6466f96cdd00..b181183118b3a 100644
> > --- a/include/linux/virtio_net.h
> > +++ b/include/linux/virtio_net.h
> > @@ -5,7 +5,11 @@
> >  #include <linux/if_vlan.h>
> >  #include <linux/ip.h>
> >  #include <linux/ipv6.h>
> > +#include <linux/netdevice.h>
> >  #include <linux/udp.h>
> > +#include <net/gso.h>
> > +#include <net/ip.h>
> > +#include <net/ipv6.h>
> >  #include <net/tcp.h>
> >  #include <uapi/linux/tcp.h>
> >  #include <uapi/linux/virtio_net.h>
> > @@ -48,15 +52,111 @@ static inline int virtio_net_hdr_set_proto(struct =
sk_buff *skb,
> >       return 0;
> >  }
> >
> > +/* Does checksum metadata match a known TCP or UDP header? */
> > +static inline bool
> > +virtio_net_csum_partial_ok_at_offset(struct sk_buff *skb, u8 hdr_gso_t=
ype,
> > +                                  unsigned int nhoff, __be16 proto)
> > +{
> > +     unsigned int thoff;
> > +     int ip_proto;
> > +
> > +     if (proto =3D=3D htons(ETH_P_IP)) {
> > +             const struct iphdr *iph =3D ip4_parse(skb, nhoff, &thoff)=
;
> > +
> > +             if (!iph || ip_is_fragment(iph))
> > +                     return false;
> > +             ip_proto =3D iph->protocol;
> > +     } else if (proto =3D=3D htons(ETH_P_IPV6)) {
> > +             const struct ipv6hdr *iph;
> > +             int flags =3D 0;
> > +
> > +             if (!pskb_may_pull(skb, nhoff + sizeof(*iph)))
> > +                     return false;
> > +             iph =3D (const void *)(skb->data + nhoff);
> > +             if (iph->version !=3D 6)
> > +                     return false;
> > +             thoff =3D nhoff + sizeof(*iph);
> > +             ip_proto =3D iph->nexthdr;
> > +             if (ip_proto !=3D IPPROTO_TCP && ip_proto !=3D IPPROTO_UD=
P) {
> > +                     thoff =3D nhoff;
> > +                     ip_proto =3D ipv6_find_hdr(skb, &thoff, -1, NULL,
> > +                                              &flags);

Skip this rare case of extension headers?

> > +                     if (ip_proto < 0 || flags & IP6_FH_F_FRAG)
> > +                             return false;
> > +             }
> > +     } else {
> > +             return false;
> > +     }
> > +

> >  static inline int __virtio_net_hdr_to_skb(struct sk_buff *skb,
> >                                         const struct virtio_net_hdr *hd=
r,
> > -                                       bool little_endian, u8 hdr_gso_=
type)
> > +                                       bool little_endian, u8 hdr_gso_=
type,
> > +                                       bool need_csum_check)
> >  {
> > -     unsigned int nh_min_len =3D sizeof(struct iphdr);
> > +     typeof(skb->transport_header) old_transport =3D skb->transport_he=
ader;
> >       unsigned int gso_type =3D 0;
> >       unsigned int thlen =3D 0;
> >       unsigned int p_off =3D 0;
> >       unsigned int ip_proto;
> > +     bool csum_partial_ok =3D true;
> >
> >       if (hdr_gso_type !=3D VIRTIO_NET_HDR_GSO_NONE) {
> >               switch (hdr_gso_type & ~VIRTIO_NET_HDR_GSO_ECN) {
> > @@ -69,7 +169,6 @@ static inline int __virtio_net_hdr_to_skb(struct sk_=
buff *skb,
> >                       gso_type =3D SKB_GSO_TCPV6;
> >                       ip_proto =3D IPPROTO_TCP;
> >                       thlen =3D sizeof(struct tcphdr);
> > -                     nh_min_len =3D sizeof(struct ipv6hdr);
> >                       break;
> >               case VIRTIO_NET_HDR_GSO_UDP:
> >                       gso_type =3D SKB_GSO_UDP;
> > @@ -104,11 +203,11 @@ static inline int __virtio_net_hdr_to_skb(struct =
sk_buff *skb,
> >
> >               if (!skb_partial_csum_set(skb, start, off))
> >                       return -EINVAL;
> > -             if (skb_transport_offset(skb) < nh_min_len)
> > -                     return -EINVAL;
> > +             if (need_csum_check)
> > +                     csum_partial_ok =3D
> > +                             virtio_net_csum_partial_ok(skb, hdr_gso_t=
ype);
> >
> > -             nh_min_len =3D skb_transport_offset(skb);
> > -             p_off =3D nh_min_len + thlen;
> > +             p_off =3D skb_transport_offset(skb) + thlen;
> >               if (!pskb_may_pull(skb, p_off))
> >                       return -EINVAL;
> >       } else if (gso_type) {
> > @@ -158,8 +257,6 @@ static inline int __virtio_net_hdr_to_skb(struct sk=
_buff *skb,
> >               case SKB_GSO_UDP_L4:
> >                       if (!(hdr->flags & VIRTIO_NET_HDR_F_NEEDS_CSUM))
> >                               return -EINVAL;
> > -                     if (skb->csum_offset !=3D offsetof(struct udphdr,=
 check))
> > -                             return -EINVAL;
> >                       if (skb->len - p_off > gso_size * UDP_MAX_SEGMENT=
S)
> >                               return -EINVAL;
> >                       if (gso_type !=3D SKB_GSO_UDP_L4)
> > @@ -167,10 +264,6 @@ static inline int __virtio_net_hdr_to_skb(struct s=
k_buff *skb,
> >                       break;
> >               case SKB_GSO_TCPV4:
> >               case SKB_GSO_TCPV6:
> > -                     if (skb->ip_summed =3D=3D CHECKSUM_PARTIAL &&
> > -                         skb->csum_offset !=3D offsetof(struct tcphdr,=
 check))
> > -                             return -EINVAL;
> > -
> >                       BUILD_BUG_ON(TCP_MIN_GSO_SIZE * GSO_MAX_SEGS < GS=
O_MAX_SIZE);
> >                       gso_size =3D max(gso_size, TCP_MIN_GSO_SIZE);
> >                       break;
> > @@ -191,6 +284,17 @@ static inline int __virtio_net_hdr_to_skb(struct s=
k_buff *skb,
> >               }
> >       }
> >
> > +     if ((hdr->flags & VIRTIO_NET_HDR_F_NEEDS_CSUM) && !csum_partial_o=
k) {
> > +             int err;
> > +
> > +             if (skb_is_gso(skb))
> > +                     return -EINVAL;
> > +
> > +             err =3D skb_checksum_help(skb);

Instead of this variable csum_partial_ok and this branch, could
virtio_net_csum_partial_ok just call skb_checksum_help directly and
drop VIRTIO_NET_HDR_F_NEEDS_CSUM?

> > +             skb->transport_header =3D old_transport;
> > +             return err;
> > +     }
> > +
> >       return 0;
> >  }
> >
> > @@ -198,7 +302,8 @@ static inline int virtio_net_hdr_to_skb(struct sk_b=
uff *skb,
> >                                       const struct virtio_net_hdr *hdr,
> >                                       bool little_endian)
> >  {
> > -     return __virtio_net_hdr_to_skb(skb, hdr, little_endian, hdr->gso_=
type);
> > +     return __virtio_net_hdr_to_skb(skb, hdr, little_endian,
> > +                                    hdr->gso_type, true);

Would be great if we can avoid the extra arg and having to update the calle=
rs.

> >  }
> >
> >  /* This function must be called after virtio_net_hdr_from_skb(). */
> > @@ -293,6 +398,7 @@ virtio_net_hdr_tnl_to_skb(struct sk_buff *skb,
> >       unsigned int inner_nh, outer_th, inner_th;
> >       unsigned int inner_l3min, outer_l3min;
> >       u8 gso_inner_type, gso_tunnel_type;
> > +     __be16 inner_proto;
> >       bool outer_isv6, inner_isv6;
> >       int ret;
> >
> > @@ -334,7 +440,7 @@ virtio_net_hdr_tnl_to_skb(struct sk_buff *skb,
> >
> >       /* Let the basic parsing deal with plain GSO features. */
> >       ret =3D __virtio_net_hdr_to_skb(skb, hdr, true,
> > -                                   hdr->gso_type & ~gso_tunnel_type);
> > +                                   hdr->gso_type & ~gso_tunnel_type, f=
alse);
> >       if (ret)
> >               return ret;
> >
> > @@ -352,8 +458,8 @@ virtio_net_hdr_tnl_to_skb(struct sk_buff *skb,
> >                       return -EINVAL;
> >       }
> >
> > -     skb_set_inner_protocol(skb, inner_isv6 ? htons(ETH_P_IPV6) :
> > -                                              htons(ETH_P_IP));
> > +     inner_proto =3D inner_isv6 ? htons(ETH_P_IPV6) : htons(ETH_P_IP);
> > +     skb_set_inner_protocol(skb, inner_proto);

Can drop

> >       if (hdr->flags & VIRTIO_NET_HDR_F_UDP_TUNNEL_CSUM) {
> >               if (!tnl_csum_negotiated)
> >                       return -EINVAL;
> > @@ -368,7 +474,16 @@ virtio_net_hdr_tnl_to_skb(struct sk_buff *skb,
> >       skb->inner_mac_header =3D inner_nh + skb_headroom(skb);
> >       skb->transport_header =3D outer_th + skb_headroom(skb);
> >       skb->encapsulation =3D 1;
> > -     return 0;
> > +
> > +     if (virtio_net_csum_partial_ok_at_offset(skb, gso_inner_type, inn=
er_nh,
> > +                                            inner_proto))
> > +             return 0;
> > +
> > +     if (skb_is_gso(skb))
> > +             return -EINVAL;

This is a risk the commit message will have to call out.

I don't see a simple way around it. We discussed segmenting here too,
but that requires intrusive changes to all callers too.

Alternatively,

1. call segmentation, but only to see it remove the SKB_GSO_DODGY and
thus verify that the TSO/USO packet is valid. Still drop otherwise.
This also does not add overhead, because it would be called later
anyway.

2. a failsafe off-by-default sysctl + static_branch that skips the
drop when set. Messy, but so is the situation we're dealing with.
