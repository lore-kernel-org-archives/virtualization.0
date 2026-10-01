Received: from mail-yx2-f38.google.com (mail-yx2-f38.google.com [74.125.224.166])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6CD34BD348
	for <virtualization@lists.linux.dev>; Thu,  1 Oct 2026 22:52:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.166
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790895148; cv=none; b=PowxOEgu0rbPl0OKktKrg2x8mVsOTZKuC4/sUJQcUXhmTeNqRss3kiWBGV/T3LLJV3m36Cywe6RClKf9sgFTG99wPESkmgO4KJGEbVC/iHDBLrFqqVUK8wnZv0vfFHxx/UJHTwylFc168mDfkQFTtUm7fgzShz/1ou2X6HaaQPg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790895148; c=relaxed/simple;
	bh=t5EBaXgjCtOlPReSbRxo6xipJNaIHWdHxsirSpF8mEI=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=BE6hOKEEYeFPGsNwASi/2l4rtHD/jY+HXUabMU9P/6CANiDk/AFRE/X6IRPgnJUITk7U9hyS9C6U/9iXFkknivgwT7RixDDf3vEzQo85GezYC1mOrRHEar7NjEGVPMEFyP6sJ9BYnepJRXi/xAG22Vs9qNHcI+f9El9xEfOg2Gs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bn7zi+YZ; arc=none smtp.client-ip=74.125.224.166
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bn7zi+YZ"
Received: by mail-yx2-f38.google.com with SMTP id 00721157ae682-8ac4deda6d5so28316527b3.2
        for <virtualization@lists.linux.dev>; Thu, 01 Oct 2026 15:52:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790895145; x=1791499945; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:mime-version:subject
         :references:in-reply-to:message-id:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=1r9R/81H7+7sKSQQACrmcWEff6sVFjsufZ7eFfFqfJM=;
        b=bn7zi+YZbaKu3hrtnnCAoPyug1WIL4+E/JY6VB/jEQNYqxQb+OheO2t+/ny0fxi9HN
         77E5CZVqp09Xfxb1CSBVNxGp5IKT6eDuDe/kFXqaOuuIJ3Z2hi5ZfQpVhFkrArgq1M+Y
         MouXuzDL/ivrMxsb86Mk8ZrDPQQhmZqwcxHzlAiPz6pwqGjJbyz8wTh60g9GZWuJazoN
         fFn1EBV1ieIW2uVFIK3xyF5uAnpDME5cTVmZKDZ+ATI03ACZk8O1DeOKjOYf2+myKoAY
         /0wHmOHj1eE4tREf4sIw15/i5sLv1lGiBtVwJK0NAk49ocCaTJmyc9C2o0xERnrkjCot
         V2Zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790895145; x=1791499945;
        h=content-transfer-encoding:content-type:mime-version:subject
         :references:in-reply-to:message-id:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=1r9R/81H7+7sKSQQACrmcWEff6sVFjsufZ7eFfFqfJM=;
        b=jZKxCllvJMpwlDtk3cqnid9xcZPRjiwJaZZNIIiwNBYmnAF/UG00sZR9keXAv1RFBB
         63mifOln+CBmg00sPeAPhP8ZkZDPR8TTj1zDiWEMiX+es9guQTkIcBsFV8UiCrI0uLYf
         9kPYRRgnweIN/2Aa6ZjQXiswVMoF7GFZ94vA6kuIBTY08ehy7n+IJCRHmZv5bsaZI1mq
         XBZ5rIs8MlPynxYlj+if6UGmy3VMnTcp1EBk92JP8nlSh2cSMriQNLsn9bm4TkUCU8OH
         2zpOXN3QPw7EwbozrIxe/R8LjbsJ1PDsMWw69AAoVi7rBAYrh0C/WCkCPvX3s4KtA8lg
         jq2w==
X-Forwarded-Encrypted: i=1; AKwUvBxl3Lp1bWiNmowIxfitySl8OjtbKTyl+qPWUWUhO3eTiRyM5jNA3lU7PE2hw6pfL1Ue5NJm7xBdMu0FUCHOWw==@lists.linux.dev
X-Gm-Message-State: AFq9FYJMSGLfFBwlyduerk5Cb6I/nT+hAT6htPr0TpO4rWIakJuU8k9v
	po2fkjCYtCBjtsL2zASSft0++QRRTLZEoIdr7HVsbdbUszSnc4s4tgPr
X-Gm-Gg: AYBFou1jPWmf1UshnB9iTSYRvjy0pdaX4/Z43zty9mgkAIEU2JXMapj5cEhGi3t0rnL
	lAQjYY1Td67sJ6gIQmQyAMgwbFcz0sYQYhiNK3GCTIJO8KhZHp4saqhN5BzGKwQiNL/w2MlT8SF
	MYzqz0RDKcheE432zeGU557v9sv6OzqDtOgtxyemcC5rvsRTD8jYxR3dykoRanDgodvjAjiAsAh
	sD1MMDMotLZrXHCCNzRKcB8jxgMlPyiEmvb73HANs3xSRyaCSVg3cvdm4890Z/kgVZBs/VogQjd
	gba1E+sSLjgkgkm0imQDE34Tfn5HOACLUmFHxyE2tauejO62u/fQ6nUUThXfkgtw8kNDUKuVt1b
	EEgG8LfIO0jY2n9gp13Kqax5PnfwbuCHpxeYDQMRjVtOpTLy43p2Fe9Rcs7etB2dBqwnatan5HM
	RNONaOb9zA4RcDE+0582iOKWCQ/w6dHptgmgn5EP8nLqnkdq6OkB6D6k4gT00UvfBN90FTzze3O
	zZyVlqmxYqGTh3cfKOn7fhcD4MVpZHzM8SgQf1n35UurSMAaxTR
X-Received: by 2002:a05:690c:f14:b0:8a9:543c:db7f with SMTP id 00721157ae682-8ae3abe15afmr3055557b3.49.1790895144846;
        Thu, 01 Oct 2026 15:52:24 -0700 (PDT)
Received: from gmail.com (111.46.245.35.bc.googleusercontent.com. [35.245.46.111])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-8ae333e9a0bsm2659807b3.36.2026.10.01.15.52.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Oct 2026 15:52:24 -0700 (PDT)
Date: Thu, 01 Oct 2026 18:52:23 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: "Michael S. Tsirkin" <mst@redhat.com>, 
 Eric Dumazet <edumazet@google.com>
Cc: Willem de Bruijn <willemdebruijn.kernel@gmail.com>, 
 Paulos Yibelo <habte.yibelo@gmail.com>, 
 netdev@vger.kernel.org, 
 richard@nod.at, 
 anton.ivanov@cambridgegreys.com, 
 johannes@sipsolutions.net, 
 jasowangio@gmail.com, 
 eperezma@redhat.com, 
 xuanzhuo@linux.alibaba.com, 
 andrew+netdev@lunn.ch, 
 pablo@netfilter.org, 
 fw@strlen.de, 
 phil@nwl.cc, 
 razor@blackwall.org, 
 idosch@nvidia.com, 
 dsahern@kernel.org, 
 davem@davemloft.net, 
 kuba@kernel.org, 
 pabeni@redhat.com, 
 horms@kernel.org, 
 linux-um@lists.infradead.org, 
 virtualization@lists.linux.dev, 
 netfilter-devel@vger.kernel.org, 
 coreteam@netfilter.org, 
 bridge@lists.linux.dev, 
 linux-kernel@vger.kernel.org
Message-ID: <willemdebruijn.kernel.326d14cfb0ee3@gmail.com>
In-Reply-To: <20260923081209-mutt-send-email-mst@kernel.org>
References: <20260922030310.8684-1-habte.yibelo@gmail.com>
 <20260922030310.8684-2-habte.yibelo@gmail.com>
 <willemdebruijn.kernel.259bc7096258d@gmail.com>
 <willemdebruijn.kernel.2cdfef118aa1d@gmail.com>
 <20260923061215-mutt-send-email-mst@kernel.org>
 <CANn89iJaE5UarTdg6FMEp=rZ9mG3g=xrVRLyvMS5S02iE8CwGg@mail.gmail.com>
 <20260923081209-mutt-send-email-mst@kernel.org>
Subject: Re: [PATCH net v6 1/2] net: validate virtio checksum start after
 network header
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable

Michael S. Tsirkin wrote:
> On Wed, Sep 23, 2026 at 12:46:42PM +0200, Eric Dumazet wrote:
> > On Wed, Sep 23, 2026 at 12:21=E2=80=AFPM Michael S. Tsirkin <mst@redh=
at.com> wrote:
> > >
> > > On Tue, Sep 22, 2026 at 09:27:26PM -0400, Willem de Bruijn wrote:
> > > > Willem de Bruijn wrote:
> > > > > Paulos Yibelo wrote:
> > > > > > __virtio_net_hdr_to_skb() checks a minimum network-header len=
gth for
> > > > > > CHECKSUM_PARTIAL packets. Its checksum start is relative to s=
kb->data,
> > > > > > but some callers have not established skb->network_header whe=
n they
> > > > > > convert the virtio header.
> > > > > >
> > > > > > Pass the data-relative L3 origin explicitly. Ethernet receive=
 paths
> > > > > > parse the frame and nested VLAN headers without changing skb =
state.
> > > > > > AF_PACKET uses the frame's actual L3 origin even when the soc=
ket
> > > > > > protocol is ETH_P_IP and the raw frame carries VLAN tags. Non=
-Ethernet
> > > > > > AF_PACKET devices retain their established skb network offset=
.
> > > > > >
> > > > > > Also pass the actual L3 protocol so IPv6 packets use the 40-b=
yte base
> > > > > > header minimum even without TCPv6 GSO. IFF_TUN obtains that p=
rotocol
> > > > > > from the packet before skb->protocol is set. Name the Etherne=
t parser
> > > > > > accordingly, use the same origin for tunnel validation, and p=
ropagate
> > > > > > conversion failures in UML.
> > > > > >
> > > > > > The bound remains a minimum; fragmentation paths separately v=
alidate
> > > > > > the parsed IPv4 or IPv6 header length before completing a che=
cksum.
> > > > > >
> > > > > > Fixes: 49d14b54a527 ("net: test for not too small csum_start =
in virtio_net_hdr_to_skb()")
> > > > > > Fixes: a2fb4bc4e2a6 ("net: implement virtio helpers to handle=
 UDP GSO tunneling.")
> > > > > > Reported-by: Paulos Yibelo <habte.yibelo@gmail.com>
> > > > > > Link: https://lore.kernel.org/netdev/20260920004733.6473-2-ha=
bte.yibelo@gmail.com/
> > > > > > Cc: stable@vger.kernel.org
> > > > > > Assisted-by: LLM
> > > > > > Signed-off-by: Paulos Yibelo <habte.yibelo@gmail.com>
> > > > > > ---
> > > > > >  arch/um/drivers/vector_transports.c | 13 ++++-
> > > > > >  drivers/net/tun_vnet.h              | 52 ++++++++++++++++-
> > > > > >  drivers/net/virtio_net.c            | 10 +++-
> > > > > >  include/linux/virtio_net.h          | 87 +++++++++++++++++++=
+++++-----
> > > > > >  net/packet/af_packet.c              | 24 +++++++-
> > > > > >  5 files changed, 163 insertions(+), 23 deletions(-)
> > > > >
> > > > > The fix may still miss the case IPv4 packets have options.
> > > > >
> > > > > This version is a very large patch.
> > > > >
> > > > > Untested shorter first suggestion by bot, which looks plausible=
 as a
> > > > > starting point for discussion.
> > > >
> > > > Cleaned up some more:
> > > >
> > > >     diff --git a/drivers/net/tun_vnet.h b/drivers/net/tun_vnet.h
> > > >     index f4c652b1fa44..c24607af2aad 100644
> > > >     --- a/drivers/net/tun_vnet.h
> > > >     +++ b/drivers/net/tun_vnet.h
> > > >     @@ -180,6 +180,9 @@ static inline int tun_vnet_hdr_put(int sz=
, struct iov_iter *iter,
> > > >      static inline int tun_vnet_hdr_to_skb(unsigned int flags, st=
ruct sk_buff *skb,
> > > >                            const struct virtio_net_hdr *hdr)
> > > >      {
> > > >     +    if ((flags & TUN_TYPE_MASK) =3D=3D IFF_TUN)
> > > >     +        skb_reset_network_header(skb);
> > > >     +
> > > >          return virtio_net_hdr_to_skb(skb, hdr, tun_vnet_is_littl=
e_endian(flags));
> > > >      }
> > > >
> > > >     @@ -199,6 +202,9 @@ tun_vnet_hdr_tnl_to_skb(unsigned int flag=
s, netdev_features_t features,
> > > >                  struct sk_buff *skb,
> > > >                  const struct virtio_net_hdr_v1_hash_tunnel *hdr)=

> > > >      {
> > > >     +    if ((flags & TUN_TYPE_MASK) =3D=3D IFF_TUN)
> > > >     +        skb_reset_network_header(skb);
> > > >     +
> > > >
> > > >     diff --git a/include/linux/virtio_net.h b/include/linux/virti=
o_net.h
> > > >     index c381b916c1b5..02c448de0802 100644
> > > >     --- a/include/linux/virtio_net.h
> > > >     +++ b/include/linux/virtio_net.h
> > > >     @@ -48,6 +48,42 @@ static inline int virtio_net_hdr_set_proto=
(struct sk_buff *skb,
> > > >          return 0;
> > > >      }
> > > >
> > > >     +static inline int virtio_net_hdr_nh_min_len(const struct sk_=
buff *skb,
> > > >     +                        unsigned int nh_min_len)
> > > >     +{
> > > >     +    int thoff =3D skb_transport_offset(skb);
> > > >     +    __be16 proto;
> > > >     +    int nhoff;
> > > >     +
> > > >     +    if (skb_network_header_was_set(skb)) {
> > > >     +        nhoff =3D skb_network_offset(skb);
> > > >     +        proto =3D skb->protocol;
> > > >     +    } else {
> > > >     +        if (unlikely(thoff < ETH_HLEN))
> > > >     +            return -EINVAL;
> > > >     +        nhoff =3D ETH_HLEN;
> > > >     +        proto =3D eth_hdr(skb)->h_proto;
> > > >     +    }
> > > >     +
> > > >     +    if (eth_type_vlan(proto)) {
> > > >     +        proto =3D __vlan_get_protocol(skb, proto, &nhoff);
> > > >     +        if (!proto)
> > > >     +            return -EINVAL;
> > > >     +    }
> > > >     +
> > > >     +    if (proto =3D=3D htons(ETH_P_IP)) {
> > > >     +        const struct iphdr *iph =3D (void *)(skb->data + nho=
ff);
> > > >     +
> > > >     +        if (unlikely(thoff < nhoff + sizeof(*iph)))
> > > >     +            return -EINVAL;
> > > >     +        nh_min_len =3D max_t(u32, iph->ihl * 4, sizeof(*iph)=
);
> > > >     +    } else if (proto =3D=3D htons(ETH_P_IPV6)) {
> > > >     +        nh_min_len =3D sizeof(struct ipv6hdr);
> > > >     +    }
> > > >     +
> > > >     +    return nhoff + nh_min_len;
> > > >     +}
> > > >     +
> > > >      static inline int __virtio_net_hdr_to_skb(struct sk_buff *sk=
b,
> > > >                            const struct virtio_net_hdr *hdr,
> > > >                            bool little_endian, u8 hdr_gso_type)
> > > >     @@ -98,13 +134,15 @@ static inline int __virtio_net_hdr_to_sk=
b(struct sk_buff *skb,
> > > >              u32 start =3D __virtio16_to_cpu(little_endian, hdr->=
csum_start);
> > > >              u32 off =3D __virtio16_to_cpu(little_endian, hdr->cs=
um_offset);
> > > >              u32 needed =3D start + max_t(u32, thlen, off + sizeo=
f(__sum16));
> > > >     +        int min_thoff;
> > > >
> > > >              if (!pskb_may_pull(skb, needed))
> > > >                  return -EINVAL;
> > > >
> > > >              if (!skb_partial_csum_set(skb, start, off))
> > > >                  return -EINVAL;
> > > >     -        if (skb_transport_offset(skb) < nh_min_len)
> > > >     +        min_thoff =3D virtio_net_hdr_nh_min_len(skb, nh_min_=
len);
> > > >     +        if (min_thoff < 0 || skb_transport_offset(skb) < min=
_thoff)
> > > >                  return -EINVAL;
> > >
> > >
> > > Certainly looks much better. But I'd like to ask, generally:
> > > doesn't the net stack need to protect against weird packets?
> > >
> > =

> > It does, but csum_start/csum_offset are not "weird packet" material,
> > they are skb metadata, not bytes on the wire.
> > =

> > For essentially every skb in the kernel, this metadata is produced by=

> > the kernel itself,
> > from headers it has just built or just parsed, and the rest of the
> > stack (GSO, skb_checksum_help(),
> > fragmentation, netfilter, and every driver doing TX csum offload)
> > consumes it as an invariant.
> > The only producers of attacker/guest controlled CHECKSUM_PARTIAL meta=
data are
> > the virtio_net_hdr_to_skb() callers: af_packet, tun/tap, virtio_net,
> > and the UML vector driver.
> > =

> > So this is not "virtio specific validation", this is input validation=

> > at the one trust boundary
> > where the invariant can be violated.
> =

> =

> Thanks for the explanation Eric!
> =

> > =

> > > It seems likely that not all drivers validate headers defensively,
> > > and incoming packets can easily become outgoing ones.
> > =

> > Packets coming from a real NIC are CHECKSUM_UNNECESSARY,
> > CHECKSUM_COMPLETE or CHECKSUM_NONE.
> > They do not carry a remote-provided csum_start.
> > (Remote checksum offload is the rare exception, and there the offsets=

> > are computed by the stack from headers it just parsed.)
> > =

> > Incoming packets becoming outgoing ones is precisely the problem here=
:
> > a virtio_net RX skb with VIRTIO_NET_HDR_F_NEEDS_CSUM becomes
> > an skb that can be bridged/forwarded/fragmented and then handed to a =
real NIC.
> =

> Well:
> =

> $ git grep 'skb->csum_start\ =3D'
> drivers/net/ethernet/hisilicon/hns3/hns3_enet.c:        skb->csum_start=
 =3D (unsigned char *)th - skb->head;
> drivers/net/ethernet/mellanox/mlx5/core/en_rx.c:        skb->csum_start=
 =3D (unsigned char *)uh - skb->head;
> drivers/net/ethernet/mellanox/mlx5/core/en_rx.c:        skb->csum_start=
 =3D (unsigned char *)uh - skb->head;
> drivers/net/ethernet/mellanox/mlx5/core/en_rx.c:        skb->csum_start=
 =3D (unsigned char *)tcp - skb->head;
> drivers/net/ethernet/mellanox/mlx5/core/en_rx.c:        skb->csum_start=
 =3D (unsigned char *)tcp - skb->head;
> drivers/net/ethernet/stmicro/stmmac/stmmac_selftests.c:         skb->cs=
um_start =3D skb_transport_header(skb) - skb->head;
> =

> What did I miss?
> =

> > =

> > > So do we even need virtio specific validation, or is it enough to
> > > validate everything in the net stack, where we are poking at the
> > > header anyway?
> > =

> > The core stack cannot afford it.
> > =

> > 1) Drivers program skb->csum_start / skb->csum_offset straight into
> > the TX descriptor, and the NIC will happily write two bytes wherever
> > it was told, e.g. into the IP header of the frame we put on the wire.=

> > Auditing/adding checks in every driver is not realistic, and drivers
> > must not pay for it.
> > =

> > 2) Catching this in the core would mean re-parsing L2/L3 in
> > dev_hard_start_xmit()
> > (or in every place that eventually looks at the transport header) for=

> > the 99.99+%
> > of packets that were built by the stack and are known to be consisten=
t.
> > That is far more expensive than one check at injection time.
> > =

> > 3) Failing at injection returns -EINVAL to the sendmsg()/writev() cal=
ler,
> > which is the correct and testable behavior. Failing later means dropp=
ing
> > the packet deep in the xmit path, usually with a splat: the commit be=
ing fixed
> > here (49d14b54a527) exists exactly because such a packet reached
> > skb_checksum_help() from ip_do_fragment() and hit the "offset (-6) >=3D=

> > skb_headlen() (14)" WARN.
> > =

> > >
> > > Or maybe it's more a defense in depth thing?
> > >
> > > My worries:
> > > - more poking at the header, more cache misses, where we really
> > >   do not need that
> > =

> > I do not expect anything measurable.
> > =

> > af_packet and tun: we have just copied that header from user space, i=
t is in L1.
> > virtio_net: we call eth_type_trans() right after, and GRO parses L3/L=
4
> > immediately.
> > =

> > The whole block is under the CHECKSUM_PARTIAL condition, where we alr=
eady
> > do pskb_may_pull() and skb_partial_csum_set(), i.e. we already touch
> > this cache line.
> > Reading iph->ihl from a cache line we are about to read anyway is noi=
se.
> > =

> > > - future protocol extensions that now will require surgery in
> > >   virtio, instead of just being passed through to the host
> > =

> > Fair, and this is an argument about how the check is written, not
> > about whether it exists.
> > The rule should be:
> > =

> > Only tighten the bound for the protocols we already parse (IPv4/IPv6)=
,
> > and keep the existing generic minimum for anything else.
> > =

> > Then an unknown ethertype simply keeps flowing, no surgery is needed.=

> > Willem's version does that. A new protocol would only be impacted if =
it wanted
> > csum_start to point inside what we consider the L3 header, and such a=
 packet
> > would not survive the rest of the stack anyway.
> > =

> > So: not defense in depth, but validation at the trust boundary, where=

> > it is cheapest
> > and where we can still report the error to the producer.

Just an update that I have not forgotten about this. Just staging it
after Eric's related series, which simplifies the challenge, and the patc=
h.
https://lore.kernel.org/netdev/20261001191140.2818991-1-edumazet@kernel.o=
rg/

The main complexity lies in having many callers into this path,
and whether you can trust
1. that fields initialized (e.g., skb->dev, network_header, protocol)
2. that they can be trusted (any coming from userspace: no)

The list of callers and invariants on some of the state:

Caller                  skb->dev       network_hdr  skb->protocol skb->da=
ta
-------------------------------------------------------------------------=
--
virtio_net.c            ARPHRD_ETHER   ETH_HLEN     0 (unset)     Etherne=
t
vector_transports.c     ARPHRD_ETHER   ETH_HLEN     0 (unset)     Etherne=
t
tap.c (macvtap/ipvtap)  ARPHRD_ETHER   ETH_HLEN     eth h_proto   Etherne=
t
tun.c (IFF_TAP)         ARPHRD_ETHER   ETH_HLEN     0 (unset)     Etherne=
t
tun.c (IFF_TUN)         ARPHRD_NONE    0            pi.proto      Raw L3
af_packet.c (ETHER)     ARPHRD_ETHER   14 (+vlan)   sll_protocol  Etherne=
t
af_packet.c (non-ETHER) !=3D ETHER       hard_hdr_len sll_protocol  Dev L=
2+L3

After Eric's series skb->dev, skb->network_header, and skb->protocol can
be assumed to always be set.

Though skb->protocol, for instance, can still not be trusted. Nor can
gso_type or even iphdr. Let alone that all three agree.

Goal is not to drop inconsistent packets (though I'd love to), but only
to protect the kernel.

A particularly tricky edge case is af_packet with non-ETHER protocol that=

does set VIRTIO_NET_HDR_F_NEEDS_CSUM. I'm not aware of any non-IP transpo=
rts
that use CHECKSUM_PARTIAL. But a realistic use-case is an IP in MPLS pack=
et,
for instance.

