Received: from mail-oi1-f178.google.com (mail-oi1-f178.google.com [209.85.167.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADE4F5226A2
	for <virtualization@lists.linux.dev>; Tue, 13 Oct 2026 17:16:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791911813; cv=none; b=PQ+0JbX5esKuURHA0XLcDdmsuNSPmIxfpqGW73d3lqhO1pT/lAS6e08GEWdoIrpPr0kTfPjHGtIVV4kSumGpmpybQl/cfMo0YY0v8yGZyxQGfe2RE/fglsmahjg2468h7uFwKNICmvkQkKSUYNCtv9rGyQDeWzSCmY3gV5X0KX4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791911813; c=relaxed/simple;
	bh=E0y7u+KR3xF/a4fcPKHidebxgCLhqgP2K/Rv6TPbOiQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BGO/3o9waGRT4FbsfbmyDCq+wUUiPGozBGJVehR2v4GfqnIuDWGtZcEcaHzaUgG7wLbzETenxFS6GchImnJprj/cl96qqiSyzUCk6yDcbeTOzV9rFZ5zaIvf9cOKuHES9SfIgzv4SfSKomzxahfnB5AUO8NS8xjz+ExyQ+S28Ow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PZdmE8/R; arc=none smtp.client-ip=209.85.167.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PZdmE8/R"
Received: by mail-oi1-f178.google.com with SMTP id 5614622812f47-4f488ba6e90so1467674b6e.3
        for <virtualization@lists.linux.dev>; Tue, 13 Oct 2026 10:16:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791911808; x=1792516608; darn=lists.linux.dev;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=Rh8zSXbKHc5uCKze2IT1wznFx+pVYTz0bfvRk4C07S4=;
        b=PZdmE8/R8jDMKJ9i+03t8cTbVxIP/KQ2hXnBK9Va+GBT67Gz9SyipW0KQUAnY8DOTx
         bPafQKrs81KtaDlK+MrfyH3CwzKauBLoOnOhOF0hhwCIV5mjpe68Xdud2J9oteJM6Dyj
         14MhptY916/K8w0nTdiOPzl8IhJwg4lu+fqU7YnVlY8U4JUePa5mcqlzFXSK/MsLs+nA
         TrhODnJrbEIVOFL8wOZodS4QiHN7L7Vi1f0jkf+GGBeXfA6/G/1mp3dj3oPSMlLFa2Cz
         QHM/PQAzxPODLXp1X8worhMtKpVJwq/Xc6kAowl6ZeDlWmOCNQRhiRmuZ03tQA7Gkcj5
         JvEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791911808; x=1792516608;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=Rh8zSXbKHc5uCKze2IT1wznFx+pVYTz0bfvRk4C07S4=;
        b=G6T2KUnNYfuzG+ccpJgyHtwCCmRojNb3l+ZodiOHI1gRoSU0rZOLmjtevf/8bz8SYt
         yJlIaFecXXxHmct/EcqKrF8F5cxWC4iWNNolEmAmYA8hUzt0vhNlrxIj+wq02XeocWvH
         8afGENARXXKcbuFLJ/YYIF4auLfnTDolFE6FMyxxa+qdvVY3t/EHoxk0hDtCxxkReq9/
         JWYS7ImDeFMSh7n570nogvNI3P5xok/hbx7evSCcfZlaIxrrmgmhF2VHLgBvcAj11bQp
         FXldELp7lb/X0Vth1QKlEHe1H+fmL3tYxkMzXz3lZE8bcc/iI5pzi/qR+45NHpkxoZC7
         xb4g==
X-Forwarded-Encrypted: i=1; AKwUvBz19PRsDsB7kbSPW9X2br41wlniDneN9aiSY2nM7QUbV7xeRCgq216h3t1Zg+MG5ejmg/XVoRtZNxujALsv9w==@lists.linux.dev
X-Gm-Message-State: AFq9FYJVbGuUFU0ZpB1MLxJx0/+uRnTziO11L8+LpKEmLWfW3xJ8ft8N
	I/73yvLwjRWRs8gApf6HrEur38LG3fXVXmxihmGdiK1CK1azoTh5LlaFAN2nMA==
X-Gm-Gg: AYBFou2V7lLYKiFxEC+DIJvXou23XuvW/uXSS0M5B/Tii5/dTG09u0oMXQuLUirYBTO
	yy1b3WLA8/ALTWjkRIi5QailXEM+4JYJi4bMa5HvvMVwm+q+yH4nuaG8jgwwR8hDSfT0uuMjW92
	T2nyoZDSA510oeeAk74Vl3JNvhW5eACNHd0bD7olA1lMaLOKLBP7hcT4tVCszabbHVBjGJ7V9Qs
	g0LYFPIuqM4j0mkWMFqjPcdqTvysSW4Cu5hVURvmT4nkcsez5OG77yEa8uBrG5VqwH7rINXcsFu
	Fk1t12F2NtiMuiY8iZF+hlZynrUHNgG2nZu9jbE8lkMOi6Qjtm6BH2VyJlgGjvKiI7NBKud3V0X
	EDJjQD58YdXuv5f3/GpwdggYa5Hil+zrsdTLWGko/frZxpPoyDJ+/wWYYswWz7qDcbxQ0kanRzw
	7ZOtUISblaEBAB143gzVKbpCfPBVroFbuPuZ7H6HG+BCaMq60KLMGJtMD2WiW1ZPTbROo=
X-Received: by 2002:a05:6808:13c3:b0:4d6:93e2:5bc4 with SMTP id 5614622812f47-50c59f38b43mr14625456b6e.64.1791911808288;
        Tue, 13 Oct 2026 10:16:48 -0700 (PDT)
Received: from localhost ([2a03:2880:ff:41::])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-50c1c0248fbsm15142233b6e.15.2026.10.13.10.16.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Oct 2026 10:16:46 -0700 (PDT)
Date: Tue, 13 Oct 2026 10:16:44 -0700
From: Bobby Eshleman <bobbyeshleman@gmail.com>
To: Jia Jia <physicalmtea@gmail.com>
Cc: stefanha@redhat.com, sgarzare@redhat.com, netdev@vger.kernel.org,
	virtualization@lists.linux.dev, kvm@vger.kernel.org, mst@redhat.com,
	jasowangio@gmail.com, eperezma@redhat.com,
	xuanzhuo@linux.alibaba.com, davem@davemloft.net,
	edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com,
	horms@kernel.org, linux-kernel@vger.kernel.org, bpf@vger.kernel.org
Subject: Re: [PATCH net-next v2 1/5] vsock/virtio: split socket lookup from
 locked RX processing
Message-ID: <as5nfI0qfqD64dc1@devvm29614.prn0.facebook.com>
References: <20261010142247.99223-1-physicalmtea@gmail.com>
 <20261010142247.99223-2-physicalmtea@gmail.com>
 <as1ZCkbya2jn72ip@devvm29614.prn0.facebook.com>
 <CAJwVaMJL4FFYLq523VY014oa4u7RWD0WUY0+seP1xh3GY5peiQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJwVaMJL4FFYLq523VY014oa4u7RWD0WUY0+seP1xh3GY5peiQ@mail.gmail.com>

On Tue, Oct 13, 2026 at 11:26:38AM +0800, Jia Jia wrote:
> >
> > On Sat, Oct 10, 2026 at 10:22:43PM +0800, Jia Jia wrote:
> > > Split virtio_transport_recv_pkt() so socket lookup is separate from the
> > > receive state machine that runs under the socket lock.
> > >
> > > Keep virtio_transport_recv_pkt() on its existing per-packet locking path.
> > > Pass the source and destination addresses used for lookup to the locked
> > > receive path so they are decoded only once.
> > >
> > > Pass the network namespace and decoded address tuple through a packet
> > > context to the locked receive path.
> > >
> > > Preserve source validation and failure handling. Keep the lookup reference
> > > separate from the skb owner reference so the locked receive path can manage
> > > the two lifetimes independently.
> > >
> > > Signed-off-by: Jia Jia <physicalmtea@gmail.com>
> > > ---
> > >  net/vmw_vsock/virtio_transport_common.c | 139 ++++++++++++++++--------
> > >  1 file changed, 96 insertions(+), 43 deletions(-)
> > >
> >
> > [...]
> >
> > > +/*
> > > + * The caller holds sk's socket lock and must free skb if this returns true.
> > > + */
> > > +static bool
> > > +virtio_transport_recv_pkt_locked(struct virtio_transport *t,
> > > +                              struct sk_buff *skb, struct sock *sk,
> > > +                              const struct virtio_transport_rx_pkt_ctx *ctx)
> > > +{
> > > +     const struct sockaddr_vm *src = ctx->src;
> > > +     const struct sockaddr_vm *dst = ctx->dst;
> > > +     struct vsock_sock *vsk = vsock_sk(sk);
> > > +     struct net *net = ctx->net;
> > > +     bool space_available;
> > >
> > > -     /* Check if sk has been closed or assigned to another transport before
> > > -      * lock_sock (note: listener sockets are not assigned to any transport)
> > > +     /* Check after acquiring the socket lock. Listener sockets accept packets
> > > +      * from any source and are not assigned to a transport.
> > >        */
> > >       if (sock_flag(sk, SOCK_DONE) ||
> > >           (sk->sk_state != TCP_LISTEN &&
> > > -          !vsock_check_source(vsk, &t->transport, &src))) {
> > > +          !vsock_check_source(vsk, &t->transport, src))) {
> > >               (void)virtio_transport_reset_no_sock(t, skb, net);
> > > -             release_sock(sk);
> > > -             sock_put(sk);
> > > -             goto free_pkt;
> > > +             return true;
> > >       }
> > >
> > >       space_available = virtio_transport_space_update(sk, skb);
> > >
> > >       /* Update CID in case it has changed after a transport reset event */
> > >       if (vsk->local_addr.svm_cid != VMADDR_CID_ANY)
> > > -             vsk->local_addr.svm_cid = dst.svm_cid;
> > > +             vsk->local_addr.svm_cid = dst->svm_cid;
> > >
> > >       if (space_available)
> > >               sk->sk_write_space(sk);
> > > @@ -1875,12 +1891,49 @@ void virtio_transport_recv_pkt(struct virtio_transport *t,
> > >               break;
> > >       }
> > >
> > > +     return false;
> > > +}
> > > +
> > > +/* We are under the virtio-vsock's vsock->rx_lock or vhost-vsock's vq->mutex
> > > + * lock.
> > > + */
> > > +void virtio_transport_recv_pkt(struct virtio_transport *t,
> > > +                            struct sk_buff *skb, struct net *net)
> > > +{
> > > +     struct virtio_transport_rx_pkt_ctx ctx;
> > > +     struct sockaddr_vm src, dst;
> > > +     struct sock *sk;
> > > +     bool free_pkt;
> > > +
> > > +     virtio_transport_recv_pkt_init_addrs(skb, &src, &dst);
> > > +     virtio_transport_trace_recv_pkt(skb, &src, &dst);
> > > +
> > > +     sk = virtio_transport_recv_pkt_find_socket(skb, &src, &dst, net);
> > > +     if (!sk) {
> > > +             (void)virtio_transport_reset_no_sock(t, skb, net);
> > > +             goto free_pkt;
> > > +     }
> > > +
> > > +     if (!skb_set_owner_sk_safe(skb, sk)) {
> > > +             WARN_ONCE(1, "receiving vsock socket has sk_refcnt == 0\n");
> > > +             goto free_pkt;
> > > +     }
> > > +
> > > +     lock_sock(sk);
> > > +     ctx = (struct virtio_transport_rx_pkt_ctx) {
> > > +             .net = net,
> > > +             .src = &src,
> > > +             .dst = &dst,
> > > +     };
> > > +     free_pkt = virtio_transport_recv_pkt_locked(t, skb, sk, &ctx);
> >
> > At this point the socket lookup succeeded with src/dst/net, why not just
> > pass sk which already has all of them?
> >
> 
> If I understand this correctly, a successful lookup is not enough to
> recover all of this from sk. The lookup may fall back from the
> connected table to the bound
> table, so the packet source must still be validated under the socket
> lock; otherwise that check would become ineffective. The packet
> destination is also needed after
> a transport reset, and the RX namespace used for a reset reply is not
> necessarily sock_net(sk) in global mode. I’ll remove the context
> struct and pass src, dst, and
> net directly.

True that the lookup may fallback to the bound table, but this begs the
question, why bother with the bound table here? If a socket hasn't
landed in the connected table yet, then OP_RW is -EINVAL and we respond
with RST anyway... so I'd guess we shouldn't even be trying to batch for
those sockets.

For connected sockets, the sk has the destination (vsk->remote_addr)
needed by the reset. And yes, sock_net(sk) does not necessarily equal
the net ptr used for a reset reply in global mode, but we don't really
expect that for global mode in vsock, we only expect that
vsock_net_check_mode() rules are followed. In this case where
!net_eq(n0, n1), the RST reply will be routed correctly across
namespaces following global mode rules.

I could certainly be missing something and happy to be pointed to an
instance of sk being insufficient here. In general, I think its nice to
avoid new data structures if possible.

Best,
Bobby
