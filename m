Received: from mail-qv1-f49.google.com (mail-qv1-f49.google.com [209.85.219.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A39913A3E7A
	for <virtualization@lists.linux.dev>; Wed, 14 Oct 2026 04:18:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.219.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791951483; cv=pass; b=nQl6rYIaxsYOehtpf7z6LJo7m+jnejcdpOjYAArOoiwM28pCLpd/rD0Bwo0jHwPsg4sxjSJKzEDoAg/O1zjeZ216aGSMLT4VbEg+vt3wgqqDP2qfnNz/LNWQoRIG9okVrmQ3XP8vysIgrla4WBLOavMMZlT5g+glI4CAJC84dp0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791951483; c=relaxed/simple;
	bh=FCFoyOy4qvXMnUzHelNH4AHBinUUgJXQyV47QXx+bBQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GS5E4UNjB2Y29jqlGVvoX59nzwiGZ57uxZhlwfuGLWqdUJrbLIb/IPTQ8L/xUS/C6Ezjy+SxPLbOy3ybcJFc+gaDPtJWPjVapP8rTC51eWEs+oo+ZSQCu0J68FuagKMrXvTwn3Sd6/Skp+Ob/KxnK5/bewxBgHqy14S560kSASU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fkXCI7Uv; arc=pass smtp.client-ip=209.85.219.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fkXCI7Uv"
Received: by mail-qv1-f49.google.com with SMTP id 6a1803df08f44-917d595138fso27929176d6.3
        for <virtualization@lists.linux.dev>; Tue, 13 Oct 2026 21:18:00 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791951479; cv=none;
        d=google.com; s=arc-20260327;
        b=NkknTPFLyKgkpEWApVNOTh6TscfTCUdifB802q4jt7F8XXOgM8KfiyAPiyoFkgHwiw
         8RZAuaC9h77UNgRTju1Y7VrJlkQ53zb5pgw0sc30ZNIYUGs4faC0Q4XCGFGTr5rqiE9y
         Pgn3l9gfMY0UhW5TLKkMrIFV2s7p0K8gdOmSZYHHaln3FC86EyTEh0GEzSWH5QiqGT2p
         ubp5JCkIEyNdDzdENmVdlg8GDqf/cENa+WjDvVRClIw9Xmnnd6he90iCFYGCr87G2UYG
         meFnJ2eO0b0b9JQ77OLCZA1xseheUpc3vKLLIaaaHXc6wkq441pQw9S7lHULRnDyowsj
         2bwA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=5ZCjIb9MTs997peH+Jf+AEs7X4vp3T30edvZQYk3nBA=;
        fh=WldT02geGlnrI7+mKVk2jNtE9yfvuup2V4xS/W4+maw=;
        b=g5lYgSXlW3NNiXWj6ztWfTh/hpBlk+/7Ll0tG77WhGPp7AkIWsE1m1X1wvRMp5u5Zv
         G2wJ4VlMaR7rZ7DnhCG9LjSbIUxVcQu/EPverUHpB+QasRjRCpe31fs95lG4eebLq0Py
         PoVNIkY7eKq5ixHVH5sG65qYUc0zUdxgWwbEymstxKkTdw6DyTvj2D4Tz3Fd79q2eO05
         OehJx/PLiQ14laxYzYz+9kmJKqOifhbLfzsFO1OcCsykYV+v6CZhX3iR6QDq4T94sQBS
         D5IbDMP2q+fuDUsUkFEgq3/kYfwasOT5ErfQ9mas2gi+FyfbbNUEk/u4q7LMsyG7iOQS
         mVWQ==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791951479; x=1792556279; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=5ZCjIb9MTs997peH+Jf+AEs7X4vp3T30edvZQYk3nBA=;
        b=fkXCI7UvoKzl+uPmXcoppnAD3c53JW+yo+8L3qWnNZNcI1jUlwI7lyydaN2Ecto7/n
         tHchkm34+tTdJqexdH3mpsnmK8sGxR5MQ8I/fQL+G9RhmgXy6AljXCJQeMRF5mNSkrol
         VT/7eqPXOjge6hgYViLAMpPia/boUpM2q6PrJflOAFA+ztBKRcovrqUrnrOFZDPvzTeE
         zLqoFlHjshOtsKoAAapCdYfGK0YToif+udf4tMqlQ+RBG4J4f8D4PGEXzdCFVcSkRsKT
         iXOL6uHwim/z5Up2evoeKa0HYCh+8X4rAzeC7JOHGx1iAhj1tzIRfNGkGos3Et/M42vI
         VzCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791951479; x=1792556279;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=5ZCjIb9MTs997peH+Jf+AEs7X4vp3T30edvZQYk3nBA=;
        b=GUq/HNa1DWdobjZtnG6ncR3nXMl+cKQGhBhntCwPPTkRm/c4IJarBZix1W9HjpffkK
         ItnW6f+5M6qLDF4fCi12EOZLFkiCDufL+pHh21wuuybvxkCbAlJjQmclxLngHjkAXigX
         lUgIzXVqirOD82hAfWvfov44nehImz/PZbHgLN7isrTiG+c9E+MoxfQQabeCeXuQswRa
         ybOO74XlE2ctzrBkz/ITQPS49go2ZU82Qas+3iHW5LK1b1OykKdF1NvmoCzDxJg4nYJ1
         MDgZZVT14Qo+whpvYKqHHfQn8s5NKBdFvVoFGZf6JEatpuXT0X32u24VIe13DR6WgXu+
         09uA==
X-Forwarded-Encrypted: i=1; AKwUvBwGPxONK41hUbamxzs7Cddd+dldVUfxTly8Ph4MAGDwCBOKZPtX3HhR+Ei5Au0PsDr2EmjSub9cv28oX0kdMg==@lists.linux.dev
X-Gm-Message-State: AFq9FYL3fYqs0SuoHic2VYLmtfbB0M2iscv7uoHrKWCM+JTk/OIVPlr2
	cJkegYgP7xewflQtv7dq325niK/w/GzxcrBtGNMbwNnZytvSwfaAKmq1RIFGMUczDjXl9agjo7P
	ZNEdxZe/VBfmS39Cgu0IpPUu/baggpoI=
X-Gm-Gg: AYBFou0F8WewaI7+vLmu0+Dns21BLPLVcdxUd4XSXUVsm1jtuf5m9MyJDBRFNmXrkix
	27/3yflWDBimGfvOdzhwcJrsv+miU+yKh4kOZy698E5DVNkY6HWbxyTjXNAt6hFawQd3/47DjkF
	fK3nSP+KB++PR8Nuc6AvNkR3X2T85U7yBnG5OdeONaVtPwvIonKsBHNfvu0YbmAhkB6bS5DYUog
	Yleeb/NyzloRCQsL4iBtnS4b/VT9BCMoT8lvr7p16ci+xuRt2yYk+NT6Qf4cB8kbnApth34ZJDm
	KnAE6gkHfQWyTt2XG8aInvZoaj9YVEIjD0s267JsXb5fsZMoY6Fom3s=
X-Received: by 2002:a05:620a:4449:b0:93b:e9db:1bab with SMTP id
 af79cd13be357-93ebd27cc75mr2258515585a.56.1791951478672; Tue, 13 Oct 2026
 21:17:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20261010142247.99223-1-physicalmtea@gmail.com>
 <20261010142247.99223-2-physicalmtea@gmail.com> <as1ZCkbya2jn72ip@devvm29614.prn0.facebook.com>
 <CAJwVaMJL4FFYLq523VY014oa4u7RWD0WUY0+seP1xh3GY5peiQ@mail.gmail.com> <as5nfI0qfqD64dc1@devvm29614.prn0.facebook.com>
In-Reply-To: <as5nfI0qfqD64dc1@devvm29614.prn0.facebook.com>
From: Jia Jia <physicalmtea@gmail.com>
Date: Wed, 14 Oct 2026 12:17:22 +0800
X-Gm-Features: AclHuK-Tjj0vL8jiV-17JnHCHultMYwdnuqEsTpaVilZ25EnMCMFZNG1gR08W4M
Message-ID: <CAJwVaM+SHuidjUeKD8-MX2ErbkaBUKE8cPYH2fzNJR+jH-oWZw@mail.gmail.com>
Subject: Re: [PATCH net-next v2 1/5] vsock/virtio: split socket lookup from
 locked RX processing
To: Bobby Eshleman <bobbyeshleman@gmail.com>
Cc: stefanha@redhat.com, sgarzare@redhat.com, netdev@vger.kernel.org, 
	virtualization@lists.linux.dev, kvm@vger.kernel.org, mst@redhat.com, 
	jasowangio@gmail.com, eperezma@redhat.com, xuanzhuo@linux.alibaba.com, 
	davem@davemloft.net, edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com, 
	horms@kernel.org, linux-kernel@vger.kernel.org, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

>
> On Tue, Oct 13, 2026 at 11:26:38AM +0800, Jia Jia wrote:
> > >
> > > On Sat, Oct 10, 2026 at 10:22:43PM +0800, Jia Jia wrote:
> > > > Split virtio_transport_recv_pkt() so socket lookup is separate from=
 the
> > > > receive state machine that runs under the socket lock.
> > > >
> > > > Keep virtio_transport_recv_pkt() on its existing per-packet locking=
 path.
> > > > Pass the source and destination addresses used for lookup to the lo=
cked
> > > > receive path so they are decoded only once.
> > > >
> > > > Pass the network namespace and decoded address tuple through a pack=
et
> > > > context to the locked receive path.
> > > >
> > > > Preserve source validation and failure handling. Keep the lookup re=
ference
> > > > separate from the skb owner reference so the locked receive path ca=
n manage
> > > > the two lifetimes independently.
> > > >
> > > > Signed-off-by: Jia Jia <physicalmtea@gmail.com>
> > > > ---
> > > >  net/vmw_vsock/virtio_transport_common.c | 139 ++++++++++++++++----=
----
> > > >  1 file changed, 96 insertions(+), 43 deletions(-)
> > > >
> > >
> > > [...]
> > >
> > > > +/*
> > > > + * The caller holds sk's socket lock and must free skb if this ret=
urns true.
> > > > + */
> > > > +static bool
> > > > +virtio_transport_recv_pkt_locked(struct virtio_transport *t,
> > > > +                              struct sk_buff *skb, struct sock *sk=
,
> > > > +                              const struct virtio_transport_rx_pkt=
_ctx *ctx)
> > > > +{
> > > > +     const struct sockaddr_vm *src =3D ctx->src;
> > > > +     const struct sockaddr_vm *dst =3D ctx->dst;
> > > > +     struct vsock_sock *vsk =3D vsock_sk(sk);
> > > > +     struct net *net =3D ctx->net;
> > > > +     bool space_available;
> > > >
> > > > -     /* Check if sk has been closed or assigned to another transpo=
rt before
> > > > -      * lock_sock (note: listener sockets are not assigned to any =
transport)
> > > > +     /* Check after acquiring the socket lock. Listener sockets ac=
cept packets
> > > > +      * from any source and are not assigned to a transport.
> > > >        */
> > > >       if (sock_flag(sk, SOCK_DONE) ||
> > > >           (sk->sk_state !=3D TCP_LISTEN &&
> > > > -          !vsock_check_source(vsk, &t->transport, &src))) {
> > > > +          !vsock_check_source(vsk, &t->transport, src))) {
> > > >               (void)virtio_transport_reset_no_sock(t, skb, net);
> > > > -             release_sock(sk);
> > > > -             sock_put(sk);
> > > > -             goto free_pkt;
> > > > +             return true;
> > > >       }
> > > >
> > > >       space_available =3D virtio_transport_space_update(sk, skb);
> > > >
> > > >       /* Update CID in case it has changed after a transport reset =
event */
> > > >       if (vsk->local_addr.svm_cid !=3D VMADDR_CID_ANY)
> > > > -             vsk->local_addr.svm_cid =3D dst.svm_cid;
> > > > +             vsk->local_addr.svm_cid =3D dst->svm_cid;
> > > >
> > > >       if (space_available)
> > > >               sk->sk_write_space(sk);
> > > > @@ -1875,12 +1891,49 @@ void virtio_transport_recv_pkt(struct virti=
o_transport *t,
> > > >               break;
> > > >       }
> > > >
> > > > +     return false;
> > > > +}
> > > > +
> > > > +/* We are under the virtio-vsock's vsock->rx_lock or vhost-vsock's=
 vq->mutex
> > > > + * lock.
> > > > + */
> > > > +void virtio_transport_recv_pkt(struct virtio_transport *t,
> > > > +                            struct sk_buff *skb, struct net *net)
> > > > +{
> > > > +     struct virtio_transport_rx_pkt_ctx ctx;
> > > > +     struct sockaddr_vm src, dst;
> > > > +     struct sock *sk;
> > > > +     bool free_pkt;
> > > > +
> > > > +     virtio_transport_recv_pkt_init_addrs(skb, &src, &dst);
> > > > +     virtio_transport_trace_recv_pkt(skb, &src, &dst);
> > > > +
> > > > +     sk =3D virtio_transport_recv_pkt_find_socket(skb, &src, &dst,=
 net);
> > > > +     if (!sk) {
> > > > +             (void)virtio_transport_reset_no_sock(t, skb, net);
> > > > +             goto free_pkt;
> > > > +     }
> > > > +
> > > > +     if (!skb_set_owner_sk_safe(skb, sk)) {
> > > > +             WARN_ONCE(1, "receiving vsock socket has sk_refcnt =
=3D=3D 0\n");
> > > > +             goto free_pkt;
> > > > +     }
> > > > +
> > > > +     lock_sock(sk);
> > > > +     ctx =3D (struct virtio_transport_rx_pkt_ctx) {
> > > > +             .net =3D net,
> > > > +             .src =3D &src,
> > > > +             .dst =3D &dst,
> > > > +     };
> > > > +     free_pkt =3D virtio_transport_recv_pkt_locked(t, skb, sk, &ct=
x);
> > >
> > > At this point the socket lookup succeeded with src/dst/net, why not j=
ust
> > > pass sk which already has all of them?
> > >
> >
> > If I understand this correctly, a successful lookup is not enough to
> > recover all of this from sk. The lookup may fall back from the
> > connected table to the bound
> > table, so the packet source must still be validated under the socket
> > lock; otherwise that check would become ineffective. The packet
> > destination is also needed after
> > a transport reset, and the RX namespace used for a reset reply is not
> > necessarily sock_net(sk) in global mode. I=E2=80=99ll remove the contex=
t
> > struct and pass src, dst, and
> > net directly.
>
> True that the lookup may fallback to the bound table, but this begs the
> question, why bother with the bound table here? If a socket hasn't
> landed in the connected table yet, then OP_RW is -EINVAL and we respond
> with RST anyway... so I'd guess we shouldn't even be trying to batch for
> those sockets.
>
> For connected sockets, the sk has the destination (vsk->remote_addr)
> needed by the reset. And yes, sock_net(sk) does not necessarily equal
> the net ptr used for a reset reply in global mode, but we don't really
> expect that for global mode in vsock, we only expect that
> vsock_net_check_mode() rules are followed. In this case where
> !net_eq(n0, n1), the RST reply will be routed correctly across
> namespaces following global mode rules.
>
> I could certainly be missing something and happy to be pointed to an
> instance of sk being insufficient here. In general, I think its nice to
> avoid new data structures if possible.
>

You're right. Although virtio_transport_recv_pkt_batchable() requires
TCP_ESTABLISHED and excludes other states from batching, the
bound-table fallback is
unnecessary there; batch admission can use only the connected lookup
and leave a miss to the normal path.

I also overlooked what the existing vsock_net_check_mode(sock_net(sk),
net) check guarantees. If the namespaces differ and the lookup
succeeds, both are
in global mode, so sock_net(sk) is sufficient for routing the RST. The
extra context is therefore unnecessary. Thanks for pointing this out.

I'll update this in the next version.

> Best,
> Bobby
