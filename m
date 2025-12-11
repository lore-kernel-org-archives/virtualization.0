Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AB9328312F
	for <virtualization@lists.linux.dev>; Thu, 11 Dec 2025 14:44:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765464254; cv=none; b=Eh6xy3UKsMkM9R3e1cuMMiEorsMIl7Weh5GNfMO7OtN138b+QXkzGrlQd7UcTXtVOkdckI3ZOK777XDWqY0OuAi9rXt8ksnpBrHo0F+y8Bp2wYE/yS+6sbvrCYlMUzBDwoRx9I7qqety1LeoPOCkfs9IMwXB/dV0zMoMiRbG/ug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765464254; c=relaxed/simple;
	bh=HcERldN4lWho/JUPnC5sIgD6t5G2cLBp2BqazKe5Jrg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=V6s/U8flnkRw7j4DC8f6UFyQ1RCSwieWRXVQ0+Ahq+0B9KUGYZ2XfaZsSOsAVDeLfJegGTBaGzbW05mbSxkGOlf/RE7GnYmRAXSXgwaKyYM4BiDp+Du8ym2X7kQV/MusWPIHHJn56fm1C8gqVrC20n5zmlgn6Lu7XIFFHHQUlQY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AOGFbC68; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AOGFbC68"
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-343dd5aa6e7so147960a91.0
        for <virtualization@lists.linux.dev>; Thu, 11 Dec 2025 06:44:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765464252; x=1766069052; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EtINVVL3vB+IyxNj9ffA7lSqV98wLbUBVSb7OBPZY6U=;
        b=AOGFbC68L05ekbPOIRrPvPB4/utoZgtVnGdjE/EKj+ksvKrX8aYdADwLQQNw5D7cEV
         +ZGRLodbjaSsXAesUsd77dyjzKTqZbHu844P7sz/7LsZrnj+HNf3+tNzZOi+ax7ji24H
         DRqX/dL9t3HAkcDROwenCdxCHfkWVnvYuzszAsR1pusVOIVCxEa1pGEANhBJabS2t3yC
         1VZcUPts0J7r0DJHrNFQVmzWtrJAPmn+9qyBr59EUV0n2QvUdRQIEC170sES4uBnc3Ml
         X6/WQPPMrWzuOCbGH4MxSpKBAcP6jjLxj3kOT7AD+3E66tpkNAQrVqYqTdnVqRWUPsod
         UNpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765464252; x=1766069052;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=EtINVVL3vB+IyxNj9ffA7lSqV98wLbUBVSb7OBPZY6U=;
        b=UcxVl0rZ0KIVRqe0X98TXL0lmqPC169MnVRSD0WLpaIXgLas4yayM+2fnTFNgyW4tl
         fObMpRrF9PCW0VD6nTUp+5/H8jn+dyAle5Mjt3XE7Vc85a7PJh2aWarzobPhZNDc6FVd
         1dGYtfV2SfhNpH5Fg0ky10vLSzOxjcKNCg6OAPQi081vEQp3y0uEZToF7lCWYvUGG0dq
         msNRkP7uanCnjLjvj+DjDWFB1pwJMlpM+IYZW8Ylt9MbJeD2ank158c0Z3rEiqTWCSkV
         6TkgAXDFPBR3udsvQvA3FRtR9/DBJVjXaoyW/gs0u0J2RXAdhxautxcf6L6Xlmqe/fi8
         U5xQ==
X-Forwarded-Encrypted: i=1; AJvYcCXS+xfJji6AF46YsQ2S7dsVYQLWyuE6Z+WQb75KL9fQhb2Y45ZDOD3eZz9ERjwoxYU6A3Ewi+8ladjDDlaCyQ==@lists.linux.dev
X-Gm-Message-State: AOJu0Yy46rx+G+MYz3bYek1ggo4UwoYesmtvHOHklvgT66TMLLyICKhf
	fAX1dy/IGaK9c9bEDs48a0gYuEh/JM7FNJOldy3gHg6ZVX/tjW76eYSKiiAKZrMC+taey/CwQXk
	h6bg///9IKH92DDBII8xFrRXbZgeKTww=
X-Gm-Gg: AY/fxX6wBjKE84RvnVei/1o/qXKx0DOVlOLa9BH4TcQjoTjnEXRQo0RUveL4nScPB0E
	Z1l7uMB17LrHAWPSpdaU+18PBjUBueUArgL6mfvpgSdOAXOoSOILkZep2OumN8T0a9eMsQz1CxH
	HUNTAm6+d8mt2qK8E2qTm42ATMeCqCbn8D9Pdgyxs9GGH25oh4PtFdG65WSyUKl7wsy+jT0SaDs
	WQ2QuhVe8fqJg3uSMAcMDh2QpP+sUS+/F7bS22Nqh4sf7lCcoaLuwwa2AmEl1fwJwsL2WU=
X-Google-Smtp-Source: AGHT+IEmEFQlvbBlRShmDnefLZIZSx5DWO8WmdgzaULARHGEfaymct8sV/4h93v5RD8D4YSxFwM3CJl04SW4WB5B9eI=
X-Received: by 2002:a17:903:3205:b0:295:5625:7e41 with SMTP id
 d9443c01a7336-29ec2319bfdmr70617415ad.22.1765464251582; Thu, 11 Dec 2025
 06:44:11 -0800 (PST)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20251211125104.375020-1-mlbnkm1@gmail.com> <20251211080251-mutt-send-email-mst@kernel.org>
 <zlhixzduyindq24osaedkt2xnukmatwhugfkqmaugvor6wlcol@56jsodxn4rhi>
In-Reply-To: <zlhixzduyindq24osaedkt2xnukmatwhugfkqmaugvor6wlcol@56jsodxn4rhi>
From: Melbin Mathew Antony <mlbnkm1@gmail.com>
Date: Thu, 11 Dec 2025 14:43:59 +0000
X-Gm-Features: AQt7F2pnwvtOPbnMcrHx8A-PKFVB-JfGrhIlVSiOwVGrW6Eib51aDnzbmR7nZ7M
Message-ID: <CAMKc4jDpMsk1TtSN-GPLM1M_qp_jpoE1XL1g5qXRUiB-M0BPgQ@mail.gmail.com>
Subject: Re: [PATCH net v3] vsock/virtio: cap TX credit to local buffer size
To: Stefano Garzarella <sgarzare@redhat.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, stefanha@redhat.com, kvm@vger.kernel.org, 
	netdev@vger.kernel.org, virtualization@lists.linux.dev, 
	linux-kernel@vger.kernel.org, jasowang@redhat.com, xuanzhuo@linux.alibaba.com, 
	eperezma@redhat.com, davem@davemloft.net, edumazet@google.com, 
	kuba@kernel.org, pabeni@redhat.com, horms@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Stefano, Michael,

Thanks for the feedback and for pointing out the s64 issue in
virtio_transport_get_credit() and the vsock_test regression.

I can take this up and send a small series:

  1/2 =E2=80=93 vsock/virtio: cap TX credit to local buffer size
        - use a helper to bound peer_buf_alloc by buf_alloc
        - compute available credit in s64 like has_space(), and clamp
          negative values to zero before applying the caller=E2=80=99s cred=
it

  2/2 =E2=80=93 vsock/test: fix seqpacket message bounds test
        - include your vsock_test.c change so the seqpacket bounds test
          keeps working with the corrected TX credit handling

I=E2=80=99ll roll these into a [PATCH net v4 0/2] series and send it out sh=
ortly.

Thanks again for all the guidance,
Melbin


On Thu, Dec 11, 2025 at 1:57=E2=80=AFPM Stefano Garzarella <sgarzare@redhat=
.com> wrote:
>
> On Thu, Dec 11, 2025 at 08:05:11AM -0500, Michael S. Tsirkin wrote:
> >On Thu, Dec 11, 2025 at 01:51:04PM +0100, Melbin K Mathew wrote:
> >> The virtio vsock transport currently derives its TX credit directly fr=
om
> >> peer_buf_alloc, which is populated from the remote endpoint's
> >> SO_VM_SOCKETS_BUFFER_SIZE value.
> >>
> >> On the host side, this means the amount of data we are willing to queu=
e
> >> for a given connection is scaled purely by a peer-chosen value, rather
> >> than by the host's own vsock buffer configuration. A guest that
> >> advertises a very large buffer and reads slowly can cause the host to
> >> allocate a correspondingly large amount of sk_buff memory for that
> >> connection.
> >>
> >> In practice, a malicious guest can:
> >>
> >>   - set a large AF_VSOCK buffer size (e.g. 2 GiB) with
> >>     SO_VM_SOCKETS_BUFFER_MAX_SIZE / SO_VM_SOCKETS_BUFFER_SIZE, and
> >>
> >>   - open multiple connections to a host vsock service that sends data
> >>     while the guest drains slowly.
> >>
> >> On an unconstrained host this can drive Slab/SUnreclaim into the tens =
of
> >> GiB range, causing allocation failures and OOM kills in unrelated host
> >> processes while the offending VM remains running.
> >>
> >> On non-virtio transports and compatibility:
> >>
> >>   - VMCI uses the AF_VSOCK buffer knobs to size its queue pairs per
> >>     socket based on the local vsk->buffer_* values; the remote side
> >>     can=E2=80=99t enlarge those queues beyond what the local endpoint
> >>     configured.
> >>
> >>   - Hyper-V=E2=80=99s vsock transport uses fixed-size VMBus ring buffe=
rs and
> >>     an MTU bound; there is no peer-controlled credit field comparable
> >>     to peer_buf_alloc, and the remote endpoint can=E2=80=99t drive in-=
flight
> >>     kernel memory above those ring sizes.
> >>
> >>   - The loopback path reuses virtio_transport_common.c, so it
> >>     naturally follows the same semantics as the virtio transport.
> >>
> >> Make virtio-vsock consistent with that model by intersecting the peer=
=E2=80=99s
> >> advertised receive window with the local vsock buffer size when
> >> computing TX credit. We introduce a small helper and use it in
> >> virtio_transport_get_credit(), virtio_transport_has_space() and
> >> virtio_transport_seqpacket_enqueue(), so that:
> >>
> >>     effective_tx_window =3D min(peer_buf_alloc, buf_alloc)
> >>
> >> This prevents a remote endpoint from forcing us to queue more data tha=
n
> >> our own configuration allows, while preserving the existing credit
> >> semantics and keeping virtio-vsock compatible with the other transport=
s.
> >>
> >> On an unpatched Ubuntu 22.04 host (~64 GiB RAM), running a PoC with
> >> 32 guest vsock connections advertising 2 GiB each and reading slowly
> >> drove Slab/SUnreclaim from ~0.5 GiB to ~57 GiB and the system only
> >> recovered after killing the QEMU process.
> >>
> >> With this patch applied, rerunning the same PoC yields:
> >>
> >>   Before:
> >>     MemFree:        ~61.6 GiB
> >>     MemAvailable:   ~62.3 GiB
> >>     Slab:           ~142 MiB
> >>     SUnreclaim:     ~117 MiB
> >>
> >>   After 32 high-credit connections:
> >>     MemFree:        ~61.5 GiB
> >>     MemAvailable:   ~62.3 GiB
> >>     Slab:           ~178 MiB
> >>     SUnreclaim:     ~152 MiB
> >>
> >> i.e. only ~35 MiB increase in Slab/SUnreclaim, no host OOM, and the
> >> guest remains responsive.
> >>
> >> Fixes: 06a8fc78367d ("VSOCK: Introduce virtio_vsock_common.ko")
> >> Suggested-by: Stefano Garzarella <sgarzare@redhat.com>
> >> Signed-off-by: Melbin K Mathew <mlbnkm1@gmail.com>
> >> ---
> >>  net/vmw_vsock/virtio_transport_common.c | 27 ++++++++++++++++++++++--=
-
> >>  1 file changed, 24 insertions(+), 3 deletions(-)
> >>
> >> diff --git a/net/vmw_vsock/virtio_transport_common.c b/net/vmw_vsock/v=
irtio_transport_common.c
> >> index dcc8a1d58..02eeb96dd 100644
> >> --- a/net/vmw_vsock/virtio_transport_common.c
> >> +++ b/net/vmw_vsock/virtio_transport_common.c
> >> @@ -491,6 +491,25 @@ void virtio_transport_consume_skb_sent(struct sk_=
buff *skb, bool consume)
> >>  }
> >>  EXPORT_SYMBOL_GPL(virtio_transport_consume_skb_sent);
> >>
> >> +/* Return the effective peer buffer size for TX credit computation.
> >> + *
> >> + * The peer advertises its receive buffer via peer_buf_alloc, but we
> >> + * cap that to our local buf_alloc (derived from
> >> + * SO_VM_SOCKETS_BUFFER_SIZE and already clamped to buffer_max_size)
> >> + * so that a remote endpoint cannot force us to queue more data than
> >> + * our own configuration allows.
> >> + */
> >> +static u32 virtio_transport_tx_buf_alloc(struct virtio_vsock_sock *vv=
s)
> >> +{
> >> +    return min(vvs->peer_buf_alloc, vvs->buf_alloc);
> >> +}
> >> +
> >>  u32 virtio_transport_get_credit(struct virtio_vsock_sock *vvs, u32 cr=
edit)
> >>  {
> >>      u32 ret;
> >> @@ -499,7 +518,8 @@ u32 virtio_transport_get_credit(struct virtio_vsoc=
k_sock *vvs, u32 credit)
> >>              return 0;
> >>
> >>      spin_lock_bh(&vvs->tx_lock);
> >> -    ret =3D vvs->peer_buf_alloc - (vvs->tx_cnt - vvs->peer_fwd_cnt);
> >> +    ret =3D virtio_transport_tx_buf_alloc(vvs) -
> >> +            (vvs->tx_cnt - vvs->peer_fwd_cnt);
> >>      if (ret > credit)
> >>              ret =3D credit;
> >>      vvs->tx_cnt +=3D ret;
> >> @@ -831,7 +851,7 @@ virtio_transport_seqpacket_enqueue(struct vsock_so=
ck *vsk,
> >>
> >>      spin_lock_bh(&vvs->tx_lock);
> >>
> >> -    if (len > vvs->peer_buf_alloc) {
> >> +    if (len > virtio_transport_tx_buf_alloc(vvs)) {
> >>              spin_unlock_bh(&vvs->tx_lock);
> >>              return -EMSGSIZE;
> >>      }
> >> @@ -882,7 +902,8 @@ static s64 virtio_transport_has_space(struct vsock=
_sock *vsk)
> >>      struct virtio_vsock_sock *vvs =3D vsk->trans;
> >>      s64 bytes;
> >>
> >> -    bytes =3D (s64)vvs->peer_buf_alloc - (vvs->tx_cnt - vvs->peer_fwd=
_cnt);
> >> +    bytes =3D (s64)virtio_transport_tx_buf_alloc(vvs) -
> >> +            (vvs->tx_cnt - vvs->peer_fwd_cnt);
> >>      if (bytes < 0)
> >>              bytes =3D 0;
> >>
> >
> >Acked-by: Michael S. Tsirkin <mst@redhat.com>
> >
> >
> >Looking at this, why is one place casting to s64 the other is not?
>
> Yeah, I pointed out that too in previous interactions. IMO we should fix
> virtio_transport_get_credit() since the peer can reduce `peer_buf_alloc`
> so it will overflow. Fortunately, we are limited by the credit requested
> by the caller, but we are still sending stuff when we shouldn't be.
>
> @Melbin let me know if you will fix it, otherwise I can do that, but I'd
> like to do in a single series (multiple patches), since they depends on
> each other.
>
> So if you prefer, I can pickup this patch and post a series with this +
> the other fix + the fix on the test I posted on the v2.
>
> Stefano
>
