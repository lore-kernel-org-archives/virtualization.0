Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A45028A72F
	for <virtualization@lists.linux.dev>; Thu, 11 Dec 2025 14:52:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765464724; cv=none; b=ghTcLigu7KYzlbxxgoZfAj35VmNB0WDH8LmTGdmlS3YZrGrQ4y1vDWRiDF5EfGNfTl2pKGEstvrYPF+hyAXDCgqopquyju3GL7pJoZvVqwshtQD5iXlaoWin80IDiQpuAoK8XwldiLMOcUvZw30ASfl9VQ+pkELbHMwVLSvQS88=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765464724; c=relaxed/simple;
	bh=Y83a+pWqa9SCSVS9irqS7Ysh9P+/KOUgBQg17r98qAk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iyLSf2u4Ub0tOBx1S5ARmiWDRCR7SchVmmaV9/LeZmGimsvFbYKroVG/8y1wZyKeWd7OWo/EGoFRwIqRsxPqxoB0igvKKeqRB+K/f+PjoUMV3HDYtU/uoNXNYT3OaecF7HDezMfyqtLN2BJKjDbb7yMgNeNB1i89xWc/Gx6b1Uk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=PpLgbBVq; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PpLgbBVq"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1765464721;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=mqQHq8ZjuioMTjqSleVpkDQkArjekNzO2+JyD4evAlo=;
	b=PpLgbBVqneTW63zxcwI2tBCPQNSrGD6yXiuyjkoPGqremD+g/e++EpU/cRlfxlCJNQcgUP
	/JWW5tWIckEXcu5bC/7GD8aFo/4YvrrsAQXCjR+s3HtAdWbW9i5ZqCDwrHsRTWih15dSPq
	Ulo66V/fuUa8h6mGWBU1vyFZ20q1o1Q=
Received: from mail-yx1-f70.google.com (mail-yx1-f70.google.com
 [74.125.224.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-624-8dzlQO0ENouu6ftn6hiy0Q-1; Thu, 11 Dec 2025 09:51:59 -0500
X-MC-Unique: 8dzlQO0ENouu6ftn6hiy0Q-1
X-Mimecast-MFC-AGG-ID: 8dzlQO0ENouu6ftn6hiy0Q_1765464719
Received: by mail-yx1-f70.google.com with SMTP id 956f58d0204a3-644652a5875so419396d50.1
        for <virtualization@lists.linux.dev>; Thu, 11 Dec 2025 06:51:59 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765464719; x=1766069519;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=mqQHq8ZjuioMTjqSleVpkDQkArjekNzO2+JyD4evAlo=;
        b=NoGQnbqu2jktatcSfZTEbL+b3qpBUFDpDSgdgyYk0aEWY4XwfrWw4UA1JrKQfSYKrG
         BrDpCGXbHaEHK7crSi2MZsnQT9ZIdZDRA36Uqeduu7YEHhy+mwUIpV6MY+L2S6/Po7bz
         PuPwY8NzFn2xfGHm/wILGcrQ1vjWk6Yx8HrB5pEavuemKtJEkrL6hL/mNSE3WsYuA5YI
         0yzjarKLqNabKoptnDLVAnSBth4MsktCPZuwfrly4KhIt4T97qnHYZZ4LGjfkITKLK2G
         KZiFMInaA9vQ/blKkIJrJwkFPq6o+c+B+lrZ46WkeHAMZYjPdlS4YobKmw4f/PafTn0R
         8I4Q==
X-Forwarded-Encrypted: i=1; AJvYcCUHv0RKAF/oO3Ov/ewYx0jmyWSDLbyF7Ic5L/Rs52+oP0NlDUB0KMkOmV303RhqJtj21o02U4mRwi1ldAt//A==@lists.linux.dev
X-Gm-Message-State: AOJu0YwjVS39JgmXMugOVCt2hMAhrkUqsyvYCx1ugJum6Lpmd56o1fiK
	qBevFFEWcwR/3RbqTIWsyW50euSmTZNukjaGIbeKLa5ELjP9ulQQwPq2RGNyUCIPBM/xX6IYJyM
	hYyZrA+QM4yZTzxSWw4AUaxcF174FRICYjs8lv3Vvp6fkTBnhiqkT3iRDBluasarjgDk3Elbk42
	mjp5ZI+bXWX36xnlj2hL1exDe5LNC4gs9gje1vJTysQuI=
X-Gm-Gg: AY/fxX4gw5upi8sqCg5d6vs/znqbKgCML0jTcL6FnokoZGQbjcCSQhPjE3DjMucllDp
	+1bN/lh7nmB0p03NMYBD0VsZ4Q/XgrLtl0hqtQIpJvRQgOkIT/oVKR3ELaOdxKJaSDUvkRKCTPs
	rz7DjUaFiyYBWmpE2952ASc9R1Nr7tYR9Vc9qxxhIXq5OUY0nJ6PFsQYwvvhQKLy/V
X-Received: by 2002:a05:690e:1554:10b0:644:60d9:7513 with SMTP id 956f58d0204a3-6446eb45126mr4104574d50.87.1765464719087;
        Thu, 11 Dec 2025 06:51:59 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEY7OAW7Iub7HfRjaep9Kwv7mbXKF7yavtvtMRDPzW/n4pEQVQlq5rllhznb0aWYw7dtPa2cqUkhRqHR2sVM1o=
X-Received: by 2002:a05:690e:1554:10b0:644:60d9:7513 with SMTP id
 956f58d0204a3-6446eb45126mr4104543d50.87.1765464718465; Thu, 11 Dec 2025
 06:51:58 -0800 (PST)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20251211125104.375020-1-mlbnkm1@gmail.com> <20251211080251-mutt-send-email-mst@kernel.org>
 <zlhixzduyindq24osaedkt2xnukmatwhugfkqmaugvor6wlcol@56jsodxn4rhi> <CAMKc4jDpMsk1TtSN-GPLM1M_qp_jpoE1XL1g5qXRUiB-M0BPgQ@mail.gmail.com>
In-Reply-To: <CAMKc4jDpMsk1TtSN-GPLM1M_qp_jpoE1XL1g5qXRUiB-M0BPgQ@mail.gmail.com>
From: Stefano Garzarella <sgarzare@redhat.com>
Date: Thu, 11 Dec 2025 15:51:46 +0100
X-Gm-Features: AQt7F2pDNg-PqY51BpbMRcRuX5BRNC1ZpaReUag8SYMVebNfY7-W-s69lHtB17E
Message-ID: <CAGxU2F7WOLs7bDJao-7Qd=GOqj_tOmS+EptviMphGqSrgsadqg@mail.gmail.com>
Subject: Re: [PATCH net v3] vsock/virtio: cap TX credit to local buffer size
To: Melbin Mathew Antony <mlbnkm1@gmail.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, stefanha@redhat.com, kvm@vger.kernel.org, 
	netdev@vger.kernel.org, virtualization@lists.linux.dev, 
	linux-kernel@vger.kernel.org, jasowang@redhat.com, xuanzhuo@linux.alibaba.com, 
	eperezma@redhat.com, davem@davemloft.net, edumazet@google.com, 
	kuba@kernel.org, pabeni@redhat.com, horms@kernel.org
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: dn-SLQaZdpUcc9nmf8DaRWuYOykWeQVtNVd1ITjveN0_1765464719
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, 11 Dec 2025 at 15:44, Melbin Mathew Antony <mlbnkm1@gmail.com> wrot=
e:
>
> Hi Stefano, Michael,
>
> Thanks for the feedback and for pointing out the s64 issue in
> virtio_transport_get_credit() and the vsock_test regression.
>
> I can take this up and send a small series:
>
>   1/2 =E2=80=93 vsock/virtio: cap TX credit to local buffer size
>         - use a helper to bound peer_buf_alloc by buf_alloc
>         - compute available credit in s64 like has_space(), and clamp
>           negative values to zero before applying the caller=E2=80=99s cr=
edit

IMO they should be fixed in 2 different patches.

I think we can easily reuse virtio_transport_has_space() in
virtio_transport_get_credit().

>
>   2/2 =E2=80=93 vsock/test: fix seqpacket message bounds test
>         - include your vsock_test.c change so the seqpacket bounds test
>           keeps working with the corrected TX credit handling
>
> I=E2=80=99ll roll these into a [PATCH net v4 0/2] series and send it out =
shortly.

Please, wait a bit also for other maintainers comments.
See https://www.kernel.org/doc/html/latest/process/submitting-patches.html#=
don-t-get-discouraged-or-impatient

So, to recap I'd do the following:
Patch 1: fix virtio_transport_get_credit() maybe using
virtio_transport_has_space() to calculate the space
Patch 2: (this one) cap TX credit to local buffer size
Patch 3: vsock/test: fix seqpacket message bounds test
Patch 4 (if you have time): add a new test for TX credit on stream socket

Stefano

>
> Thanks again for all the guidance,
> Melbin
>
>
> On Thu, Dec 11, 2025 at 1:57=E2=80=AFPM Stefano Garzarella <sgarzare@redh=
at.com> wrote:
> >
> > On Thu, Dec 11, 2025 at 08:05:11AM -0500, Michael S. Tsirkin wrote:
> > >On Thu, Dec 11, 2025 at 01:51:04PM +0100, Melbin K Mathew wrote:
> > >> The virtio vsock transport currently derives its TX credit directly =
from
> > >> peer_buf_alloc, which is populated from the remote endpoint's
> > >> SO_VM_SOCKETS_BUFFER_SIZE value.
> > >>
> > >> On the host side, this means the amount of data we are willing to qu=
eue
> > >> for a given connection is scaled purely by a peer-chosen value, rath=
er
> > >> than by the host's own vsock buffer configuration. A guest that
> > >> advertises a very large buffer and reads slowly can cause the host t=
o
> > >> allocate a correspondingly large amount of sk_buff memory for that
> > >> connection.
> > >>
> > >> In practice, a malicious guest can:
> > >>
> > >>   - set a large AF_VSOCK buffer size (e.g. 2 GiB) with
> > >>     SO_VM_SOCKETS_BUFFER_MAX_SIZE / SO_VM_SOCKETS_BUFFER_SIZE, and
> > >>
> > >>   - open multiple connections to a host vsock service that sends dat=
a
> > >>     while the guest drains slowly.
> > >>
> > >> On an unconstrained host this can drive Slab/SUnreclaim into the ten=
s of
> > >> GiB range, causing allocation failures and OOM kills in unrelated ho=
st
> > >> processes while the offending VM remains running.
> > >>
> > >> On non-virtio transports and compatibility:
> > >>
> > >>   - VMCI uses the AF_VSOCK buffer knobs to size its queue pairs per
> > >>     socket based on the local vsk->buffer_* values; the remote side
> > >>     can=E2=80=99t enlarge those queues beyond what the local endpoin=
t
> > >>     configured.
> > >>
> > >>   - Hyper-V=E2=80=99s vsock transport uses fixed-size VMBus ring buf=
fers and
> > >>     an MTU bound; there is no peer-controlled credit field comparabl=
e
> > >>     to peer_buf_alloc, and the remote endpoint can=E2=80=99t drive i=
n-flight
> > >>     kernel memory above those ring sizes.
> > >>
> > >>   - The loopback path reuses virtio_transport_common.c, so it
> > >>     naturally follows the same semantics as the virtio transport.
> > >>
> > >> Make virtio-vsock consistent with that model by intersecting the pee=
r=E2=80=99s
> > >> advertised receive window with the local vsock buffer size when
> > >> computing TX credit. We introduce a small helper and use it in
> > >> virtio_transport_get_credit(), virtio_transport_has_space() and
> > >> virtio_transport_seqpacket_enqueue(), so that:
> > >>
> > >>     effective_tx_window =3D min(peer_buf_alloc, buf_alloc)
> > >>
> > >> This prevents a remote endpoint from forcing us to queue more data t=
han
> > >> our own configuration allows, while preserving the existing credit
> > >> semantics and keeping virtio-vsock compatible with the other transpo=
rts.
> > >>
> > >> On an unpatched Ubuntu 22.04 host (~64 GiB RAM), running a PoC with
> > >> 32 guest vsock connections advertising 2 GiB each and reading slowly
> > >> drove Slab/SUnreclaim from ~0.5 GiB to ~57 GiB and the system only
> > >> recovered after killing the QEMU process.
> > >>
> > >> With this patch applied, rerunning the same PoC yields:
> > >>
> > >>   Before:
> > >>     MemFree:        ~61.6 GiB
> > >>     MemAvailable:   ~62.3 GiB
> > >>     Slab:           ~142 MiB
> > >>     SUnreclaim:     ~117 MiB
> > >>
> > >>   After 32 high-credit connections:
> > >>     MemFree:        ~61.5 GiB
> > >>     MemAvailable:   ~62.3 GiB
> > >>     Slab:           ~178 MiB
> > >>     SUnreclaim:     ~152 MiB
> > >>
> > >> i.e. only ~35 MiB increase in Slab/SUnreclaim, no host OOM, and the
> > >> guest remains responsive.
> > >>
> > >> Fixes: 06a8fc78367d ("VSOCK: Introduce virtio_vsock_common.ko")
> > >> Suggested-by: Stefano Garzarella <sgarzare@redhat.com>
> > >> Signed-off-by: Melbin K Mathew <mlbnkm1@gmail.com>
> > >> ---
> > >>  net/vmw_vsock/virtio_transport_common.c | 27 ++++++++++++++++++++++=
---
> > >>  1 file changed, 24 insertions(+), 3 deletions(-)
> > >>
> > >> diff --git a/net/vmw_vsock/virtio_transport_common.c b/net/vmw_vsock=
/virtio_transport_common.c
> > >> index dcc8a1d58..02eeb96dd 100644
> > >> --- a/net/vmw_vsock/virtio_transport_common.c
> > >> +++ b/net/vmw_vsock/virtio_transport_common.c
> > >> @@ -491,6 +491,25 @@ void virtio_transport_consume_skb_sent(struct s=
k_buff *skb, bool consume)
> > >>  }
> > >>  EXPORT_SYMBOL_GPL(virtio_transport_consume_skb_sent);
> > >>
> > >> +/* Return the effective peer buffer size for TX credit computation.
> > >> + *
> > >> + * The peer advertises its receive buffer via peer_buf_alloc, but w=
e
> > >> + * cap that to our local buf_alloc (derived from
> > >> + * SO_VM_SOCKETS_BUFFER_SIZE and already clamped to buffer_max_size=
)
> > >> + * so that a remote endpoint cannot force us to queue more data tha=
n
> > >> + * our own configuration allows.
> > >> + */
> > >> +static u32 virtio_transport_tx_buf_alloc(struct virtio_vsock_sock *=
vvs)
> > >> +{
> > >> +    return min(vvs->peer_buf_alloc, vvs->buf_alloc);
> > >> +}
> > >> +
> > >>  u32 virtio_transport_get_credit(struct virtio_vsock_sock *vvs, u32 =
credit)
> > >>  {
> > >>      u32 ret;
> > >> @@ -499,7 +518,8 @@ u32 virtio_transport_get_credit(struct virtio_vs=
ock_sock *vvs, u32 credit)
> > >>              return 0;
> > >>
> > >>      spin_lock_bh(&vvs->tx_lock);
> > >> -    ret =3D vvs->peer_buf_alloc - (vvs->tx_cnt - vvs->peer_fwd_cnt)=
;
> > >> +    ret =3D virtio_transport_tx_buf_alloc(vvs) -
> > >> +            (vvs->tx_cnt - vvs->peer_fwd_cnt);
> > >>      if (ret > credit)
> > >>              ret =3D credit;
> > >>      vvs->tx_cnt +=3D ret;
> > >> @@ -831,7 +851,7 @@ virtio_transport_seqpacket_enqueue(struct vsock_=
sock *vsk,
> > >>
> > >>      spin_lock_bh(&vvs->tx_lock);
> > >>
> > >> -    if (len > vvs->peer_buf_alloc) {
> > >> +    if (len > virtio_transport_tx_buf_alloc(vvs)) {
> > >>              spin_unlock_bh(&vvs->tx_lock);
> > >>              return -EMSGSIZE;
> > >>      }
> > >> @@ -882,7 +902,8 @@ static s64 virtio_transport_has_space(struct vso=
ck_sock *vsk)
> > >>      struct virtio_vsock_sock *vvs =3D vsk->trans;
> > >>      s64 bytes;
> > >>
> > >> -    bytes =3D (s64)vvs->peer_buf_alloc - (vvs->tx_cnt - vvs->peer_f=
wd_cnt);
> > >> +    bytes =3D (s64)virtio_transport_tx_buf_alloc(vvs) -
> > >> +            (vvs->tx_cnt - vvs->peer_fwd_cnt);
> > >>      if (bytes < 0)
> > >>              bytes =3D 0;
> > >>
> > >
> > >Acked-by: Michael S. Tsirkin <mst@redhat.com>
> > >
> > >
> > >Looking at this, why is one place casting to s64 the other is not?
> >
> > Yeah, I pointed out that too in previous interactions. IMO we should fi=
x
> > virtio_transport_get_credit() since the peer can reduce `peer_buf_alloc=
`
> > so it will overflow. Fortunately, we are limited by the credit requeste=
d
> > by the caller, but we are still sending stuff when we shouldn't be.
> >
> > @Melbin let me know if you will fix it, otherwise I can do that, but I'=
d
> > like to do in a single series (multiple patches), since they depends on
> > each other.
> >
> > So if you prefer, I can pickup this patch and post a series with this +
> > the other fix + the fix on the test I posted on the v2.
> >
> > Stefano
> >
>

