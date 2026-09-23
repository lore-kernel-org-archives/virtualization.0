Received: from mail-qk2-f13.google.com (mail-qk2-f13.google.com [74.125.230.205])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21DCF471CF7
	for <virtualization@lists.linux.dev>; Wed, 23 Sep 2026 10:46:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.230.205
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790160430; cv=pass; b=OR2FDNN0ALdkfCds9ar04SQYATtLwFreOIAEDX78Ywtn+dKk8bJ7ZbxHw2ECwbEW4D+GY9f4skrB4BJsDMpiX9p6xaA7rLScRh83jQWQKXMszKKeKStIusnYJ7whiEMCPaKYFC2A/3oTYwoXkC/oq+zC0C8eL36Da3c40c/hDt8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790160430; c=relaxed/simple;
	bh=bUHg62TysYxAHoh8aYGkEd2dAu7RWFPbFjjbBJX2Bb0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BF6kaHXZrCJGJFIw3AWRwWVNaW+HElYkfWeDhzJQRRNXmzDQVdYDDXLAgRmT5SsDni91SSIHG3d0ue6jQUgory4hfBNjxs2sQ01ulxgaogj5uQVSw+mzIgARjD7UTDXamf2vhCPUb95uUR6t4fhKF7oNeorO6H794NTBRFaikZY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=hlccZw5b; arc=pass smtp.client-ip=74.125.230.205
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="hlccZw5b"
Received: by mail-qk2-f13.google.com with SMTP id d75a77b69052e-52fb766bfd6so7905951cf.1
        for <virtualization@lists.linux.dev>; Wed, 23 Sep 2026 03:46:58 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790160415; cv=none;
        d=google.com; s=arc-20260327;
        b=rkQ6TPxAQzcdNCcYOiDNxI7kHClYWQ0EsZtg9CiqCePM2uIjx7q2LJZxAluWReLLF7
         U7+fc0qOdDt96Zo6ZyjsVGSuJMeHciAbHqP16I2duljZ6w7XlK8y6+q0kWw8ys7j0V06
         23XHnCyT2CdakQyp2yk0w27Hf54vK2ct9V3eys17epS7u64GOq0dzu6ElG2fUlyFEE76
         IOXT9iQ30Vo8FduB5/vCATTyrahU+eZVkDuohSqv6/4hOczCYmh60XX3BXjXGlYZvmfV
         4KVoe/T+bm3U8CBkwVjNFtcsH7xnAyn3TnogG5J3c5kV7zjyXMK/tTug3hnIk/0uq1Bg
         UAlA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=5qQnouxMXBaz7GRH1wNAX5+8qsLPLIKgVbqXxrNNlSM=;
        fh=QXZp9+fYxNpqoDAPLB29yoHFOD6RPcmNUwnJfuPIvhM=;
        b=dfU6xPRAWvKSeMoQryWy1t7PB0JCx39FQ9LIc1beogJcEkq8q7VAmyUfQNrdo102ke
         4Qw57VCE4UEnYsRruYnkVVK9fNgVGO+rfcIK7BjbbZ9H5b1/QDH+ctt3RaWEBEMvXhfO
         iGTCirxrz7BnDJShI7csqGSpPb25y3omQoqge6agz/Cq1dBbiUImSDcLFYBX5OjJlbQx
         eM0/fhY4mJupGjucu97i+KZMsxwiDQnafNH0EiuZEwPVZeJ+s0rVQQBF1dn73UvA7VmD
         7gKpGKAaCVS7EKRA/8tySviajSGZ41w9sMEeGSICRxX2oYrMPAMh2pmrw028dOOYtbu4
         O2pA==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790160415; x=1790765215; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=5qQnouxMXBaz7GRH1wNAX5+8qsLPLIKgVbqXxrNNlSM=;
        b=hlccZw5bqO/AsCafFdAp/imt1ynuLUetq8tIZB9dkJK+kUmsJHWt/M4bcmnc2W0DFe
         6qp+kfRW5wg87WOD/aTgFvUecL+g9c4A2KbUBG/0HHf/wPHqvwjo3OoMnplmbDZzLxqX
         fYa4CVI12ZsWq2vVz33am6h27k/fBEMuMWxdbPz42buWeUQ4d7EQ63Q+QeeHm4PGxTTm
         fWoK5EfyiGWNcPhfL4x5bc+eEgztGdNT/ku5NdbZXNmFBCmyGaN4VxWFEy0ptRql4AA5
         1z6Uq6UKTuVsuGP8VUH7eQ3gYMtS1M2S14waXumWTiX1fFWx3d0HKyyALxS++srSoDdZ
         j06A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790160415; x=1790765215;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=5qQnouxMXBaz7GRH1wNAX5+8qsLPLIKgVbqXxrNNlSM=;
        b=QpgfSN559KHAxd9pC67GJZhti4989U3YqjbCRnbwVoWgMsz2Z7Yf8GYfaTB0HrVXny
         M+zIjLEuC+kzx7p4db34nBQvxnD/hMvnfr2eEd6zQoBfSPCeQ8ikPBkYcMq6AvpDfZ6n
         b6v61QHztGub8CDsk5UIRL6czBKHTBAv7XCpA3dTglzDM6CKlxNi50wTZ9Yna4ZS13Hn
         Co4RQxPIrdblZLXoX0szuLmh1wZqF1JJn8Rj4eAoxd616RFfbLEb6JpczGiYk8iFtPKR
         CT5VLB7bhdccDikBBGot4eq+0VgHD9+55cunSW9l9KsZ4BEfBcV8ULgYqyTpEg2u4feU
         uatg==
X-Forwarded-Encrypted: i=1; AKwUvBwWRFC/LxDp1t4VT4e95VzWHd4d8piM+7Tu+61pTjFu+x1pdvsWX5nw2FALvQyMvyve1sZfk3DTiz2Pi6SiFg==@lists.linux.dev
X-Gm-Message-State: AFuF++mHdsz47FsZ1NEGMqPPomoDUG79n8j3IcLmRrV/K6zCuhwBd28s
	Qq+maaz4rjS1eEXtcOKZ1mnHWJD59OBS7kIX7JijiBOwiHRsHfvKmbgI9lv5MiqOnU1qRScFQRO
	9Hci2oxrfiZPWm4Alg3CA+vTVmlFKN0omrSWmz2OZ
X-Gm-Gg: AYBFou1SDJSim2tF0KhdDS3VvWW2GaJni3KERUQSdhRZPtPtcN5rH6FLKQ6+/oVDkl9
	oB1bi3feZ9fZ2C8bXtvcFL3XEWnuXWRfOuYSm+kZiPyYN9fHz5uXdI30sF7HZa97pLLduIkzTkp
	bQuLbvlQ+AOuZDENqg+kWqUBjRabyttdlvOUyXicwAFPmyECLEYn3tL2HBSsyHlXMrAkSTPmGtx
	lD+aM/nIOqi2S66EBHLvk1dZGQxE2Tul039DwS2Nl8kexRI+b4ddBDwLbnAbVNKJcfUKC0T9CdA
	+bNyGTgVYiooQTaA/l60HZ9ve8vGj6sOFWhRu0gzSbaZGtTTOou/UoY1wGap4DouaVQ/8b+YMRJ
	XJzsHuI/Fis1duX7WSoPQKTF0uGjIIlfTUKqkGt8Y62MYjNTzuGxGFlPEDOj6zQnaFGXozlfNsp
	1PpgE=
X-Received: by 2002:a05:622a:2505:b0:530:e4fb:60fc with SMTP id
 d75a77b69052e-532eabdc770mr32673981cf.15.1790160414447; Wed, 23 Sep 2026
 03:46:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260922030310.8684-1-habte.yibelo@gmail.com> <20260922030310.8684-2-habte.yibelo@gmail.com>
 <willemdebruijn.kernel.259bc7096258d@gmail.com> <willemdebruijn.kernel.2cdfef118aa1d@gmail.com>
 <20260923061215-mutt-send-email-mst@kernel.org>
In-Reply-To: <20260923061215-mutt-send-email-mst@kernel.org>
From: Eric Dumazet <edumazet@google.com>
Date: Wed, 23 Sep 2026 12:46:42 +0200
X-Gm-Features: AcwNN1U8Ts6TWBa2uXtOoMwvm8fJd83V_C6ZYk_pSBxsCdUgnTa4az_r5gjrcY4
Message-ID: <CANn89iJaE5UarTdg6FMEp=rZ9mG3g=xrVRLyvMS5S02iE8CwGg@mail.gmail.com>
Subject: Re: [PATCH net v6 1/2] net: validate virtio checksum start after
 network header
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Willem de Bruijn <willemdebruijn.kernel@gmail.com>, Paulos Yibelo <habte.yibelo@gmail.com>, 
	netdev@vger.kernel.org, richard@nod.at, anton.ivanov@cambridgegreys.com, 
	johannes@sipsolutions.net, jasowangio@gmail.com, eperezma@redhat.com, 
	xuanzhuo@linux.alibaba.com, andrew+netdev@lunn.ch, pablo@netfilter.org, 
	fw@strlen.de, phil@nwl.cc, razor@blackwall.org, idosch@nvidia.com, 
	dsahern@kernel.org, davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, 
	horms@kernel.org, linux-um@lists.infradead.org, 
	virtualization@lists.linux.dev, netfilter-devel@vger.kernel.org, 
	coreteam@netfilter.org, bridge@lists.linux.dev, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 23, 2026 at 12:21=E2=80=AFPM Michael S. Tsirkin <mst@redhat.com=
> wrote:
>
> On Tue, Sep 22, 2026 at 09:27:26PM -0400, Willem de Bruijn wrote:
> > Willem de Bruijn wrote:
> > > Paulos Yibelo wrote:
> > > > __virtio_net_hdr_to_skb() checks a minimum network-header length fo=
r
> > > > CHECKSUM_PARTIAL packets. Its checksum start is relative to skb->da=
ta,
> > > > but some callers have not established skb->network_header when they
> > > > convert the virtio header.
> > > >
> > > > Pass the data-relative L3 origin explicitly. Ethernet receive paths
> > > > parse the frame and nested VLAN headers without changing skb state.
> > > > AF_PACKET uses the frame's actual L3 origin even when the socket
> > > > protocol is ETH_P_IP and the raw frame carries VLAN tags. Non-Ether=
net
> > > > AF_PACKET devices retain their established skb network offset.
> > > >
> > > > Also pass the actual L3 protocol so IPv6 packets use the 40-byte ba=
se
> > > > header minimum even without TCPv6 GSO. IFF_TUN obtains that protoco=
l
> > > > from the packet before skb->protocol is set. Name the Ethernet pars=
er
> > > > accordingly, use the same origin for tunnel validation, and propaga=
te
> > > > conversion failures in UML.
> > > >
> > > > The bound remains a minimum; fragmentation paths separately validat=
e
> > > > the parsed IPv4 or IPv6 header length before completing a checksum.
> > > >
> > > > Fixes: 49d14b54a527 ("net: test for not too small csum_start in vir=
tio_net_hdr_to_skb()")
> > > > Fixes: a2fb4bc4e2a6 ("net: implement virtio helpers to handle UDP G=
SO tunneling.")
> > > > Reported-by: Paulos Yibelo <habte.yibelo@gmail.com>
> > > > Link: https://lore.kernel.org/netdev/20260920004733.6473-2-habte.yi=
belo@gmail.com/
> > > > Cc: stable@vger.kernel.org
> > > > Assisted-by: LLM
> > > > Signed-off-by: Paulos Yibelo <habte.yibelo@gmail.com>
> > > > ---
> > > >  arch/um/drivers/vector_transports.c | 13 ++++-
> > > >  drivers/net/tun_vnet.h              | 52 ++++++++++++++++-
> > > >  drivers/net/virtio_net.c            | 10 +++-
> > > >  include/linux/virtio_net.h          | 87 ++++++++++++++++++++++++-=
----
> > > >  net/packet/af_packet.c              | 24 +++++++-
> > > >  5 files changed, 163 insertions(+), 23 deletions(-)
> > >
> > > The fix may still miss the case IPv4 packets have options.
> > >
> > > This version is a very large patch.
> > >
> > > Untested shorter first suggestion by bot, which looks plausible as a
> > > starting point for discussion.
> >
> > Cleaned up some more:
> >
> >     diff --git a/drivers/net/tun_vnet.h b/drivers/net/tun_vnet.h
> >     index f4c652b1fa44..c24607af2aad 100644
> >     --- a/drivers/net/tun_vnet.h
> >     +++ b/drivers/net/tun_vnet.h
> >     @@ -180,6 +180,9 @@ static inline int tun_vnet_hdr_put(int sz, stru=
ct iov_iter *iter,
> >      static inline int tun_vnet_hdr_to_skb(unsigned int flags, struct s=
k_buff *skb,
> >                            const struct virtio_net_hdr *hdr)
> >      {
> >     +    if ((flags & TUN_TYPE_MASK) =3D=3D IFF_TUN)
> >     +        skb_reset_network_header(skb);
> >     +
> >          return virtio_net_hdr_to_skb(skb, hdr, tun_vnet_is_little_endi=
an(flags));
> >      }
> >
> >     @@ -199,6 +202,9 @@ tun_vnet_hdr_tnl_to_skb(unsigned int flags, net=
dev_features_t features,
> >                  struct sk_buff *skb,
> >                  const struct virtio_net_hdr_v1_hash_tunnel *hdr)
> >      {
> >     +    if ((flags & TUN_TYPE_MASK) =3D=3D IFF_TUN)
> >     +        skb_reset_network_header(skb);
> >     +
> >
> >     diff --git a/include/linux/virtio_net.h b/include/linux/virtio_net.=
h
> >     index c381b916c1b5..02c448de0802 100644
> >     --- a/include/linux/virtio_net.h
> >     +++ b/include/linux/virtio_net.h
> >     @@ -48,6 +48,42 @@ static inline int virtio_net_hdr_set_proto(struc=
t sk_buff *skb,
> >          return 0;
> >      }
> >
> >     +static inline int virtio_net_hdr_nh_min_len(const struct sk_buff *=
skb,
> >     +                        unsigned int nh_min_len)
> >     +{
> >     +    int thoff =3D skb_transport_offset(skb);
> >     +    __be16 proto;
> >     +    int nhoff;
> >     +
> >     +    if (skb_network_header_was_set(skb)) {
> >     +        nhoff =3D skb_network_offset(skb);
> >     +        proto =3D skb->protocol;
> >     +    } else {
> >     +        if (unlikely(thoff < ETH_HLEN))
> >     +            return -EINVAL;
> >     +        nhoff =3D ETH_HLEN;
> >     +        proto =3D eth_hdr(skb)->h_proto;
> >     +    }
> >     +
> >     +    if (eth_type_vlan(proto)) {
> >     +        proto =3D __vlan_get_protocol(skb, proto, &nhoff);
> >     +        if (!proto)
> >     +            return -EINVAL;
> >     +    }
> >     +
> >     +    if (proto =3D=3D htons(ETH_P_IP)) {
> >     +        const struct iphdr *iph =3D (void *)(skb->data + nhoff);
> >     +
> >     +        if (unlikely(thoff < nhoff + sizeof(*iph)))
> >     +            return -EINVAL;
> >     +        nh_min_len =3D max_t(u32, iph->ihl * 4, sizeof(*iph));
> >     +    } else if (proto =3D=3D htons(ETH_P_IPV6)) {
> >     +        nh_min_len =3D sizeof(struct ipv6hdr);
> >     +    }
> >     +
> >     +    return nhoff + nh_min_len;
> >     +}
> >     +
> >      static inline int __virtio_net_hdr_to_skb(struct sk_buff *skb,
> >                            const struct virtio_net_hdr *hdr,
> >                            bool little_endian, u8 hdr_gso_type)
> >     @@ -98,13 +134,15 @@ static inline int __virtio_net_hdr_to_skb(stru=
ct sk_buff *skb,
> >              u32 start =3D __virtio16_to_cpu(little_endian, hdr->csum_s=
tart);
> >              u32 off =3D __virtio16_to_cpu(little_endian, hdr->csum_off=
set);
> >              u32 needed =3D start + max_t(u32, thlen, off + sizeof(__su=
m16));
> >     +        int min_thoff;
> >
> >              if (!pskb_may_pull(skb, needed))
> >                  return -EINVAL;
> >
> >              if (!skb_partial_csum_set(skb, start, off))
> >                  return -EINVAL;
> >     -        if (skb_transport_offset(skb) < nh_min_len)
> >     +        min_thoff =3D virtio_net_hdr_nh_min_len(skb, nh_min_len);
> >     +        if (min_thoff < 0 || skb_transport_offset(skb) < min_thoff=
)
> >                  return -EINVAL;
>
>
> Certainly looks much better. But I'd like to ask, generally:
> doesn't the net stack need to protect against weird packets?
>

It does, but csum_start/csum_offset are not "weird packet" material,
they are skb metadata, not bytes on the wire.

For essentially every skb in the kernel, this metadata is produced by
the kernel itself,
from headers it has just built or just parsed, and the rest of the
stack (GSO, skb_checksum_help(),
fragmentation, netfilter, and every driver doing TX csum offload)
consumes it as an invariant.

The only producers of attacker/guest controlled CHECKSUM_PARTIAL metadata a=
re
the virtio_net_hdr_to_skb() callers: af_packet, tun/tap, virtio_net,
and the UML vector driver.

So this is not "virtio specific validation", this is input validation
at the one trust boundary
where the invariant can be violated.

> It seems likely that not all drivers validate headers defensively,
> and incoming packets can easily become outgoing ones.

Packets coming from a real NIC are CHECKSUM_UNNECESSARY,
CHECKSUM_COMPLETE or CHECKSUM_NONE.
They do not carry a remote-provided csum_start.
(Remote checksum offload is the rare exception, and there the offsets
are computed by the stack from headers it just parsed.)

Incoming packets becoming outgoing ones is precisely the problem here:
a virtio_net RX skb with VIRTIO_NET_HDR_F_NEEDS_CSUM becomes
an skb that can be bridged/forwarded/fragmented and then handed to a real N=
IC.

> So do we even need virtio specific validation, or is it enough to
> validate everything in the net stack, where we are poking at the
> header anyway?

The core stack cannot afford it.

1) Drivers program skb->csum_start / skb->csum_offset straight into
the TX descriptor, and the NIC will happily write two bytes wherever
it was told, e.g. into the IP header of the frame we put on the wire.
Auditing/adding checks in every driver is not realistic, and drivers
must not pay for it.

2) Catching this in the core would mean re-parsing L2/L3 in
dev_hard_start_xmit()
(or in every place that eventually looks at the transport header) for
the 99.99+%
of packets that were built by the stack and are known to be consistent.
That is far more expensive than one check at injection time.

3) Failing at injection returns -EINVAL to the sendmsg()/writev() caller,
which is the correct and testable behavior. Failing later means dropping
the packet deep in the xmit path, usually with a splat: the commit being fi=
xed
here (49d14b54a527) exists exactly because such a packet reached
skb_checksum_help() from ip_do_fragment() and hit the "offset (-6) >=3D
skb_headlen() (14)" WARN.

>
> Or maybe it's more a defense in depth thing?
>
> My worries:
> - more poking at the header, more cache misses, where we really
>   do not need that

I do not expect anything measurable.

af_packet and tun: we have just copied that header from user space, it is i=
n L1.
virtio_net: we call eth_type_trans() right after, and GRO parses L3/L4
immediately.

The whole block is under the CHECKSUM_PARTIAL condition, where we already
do pskb_may_pull() and skb_partial_csum_set(), i.e. we already touch
this cache line.
Reading iph->ihl from a cache line we are about to read anyway is noise.

> - future protocol extensions that now will require surgery in
>   virtio, instead of just being passed through to the host

Fair, and this is an argument about how the check is written, not
about whether it exists.
The rule should be:

Only tighten the bound for the protocols we already parse (IPv4/IPv6),
and keep the existing generic minimum for anything else.

Then an unknown ethertype simply keeps flowing, no surgery is needed.
Willem's version does that. A new protocol would only be impacted if it wan=
ted
csum_start to point inside what we consider the L3 header, and such a packe=
t
would not survive the rest of the stack anyway.

So: not defense in depth, but validation at the trust boundary, where
it is cheapest
and where we can still report the error to the producer.

>
> What do others think?
>
> --
> MST
>
