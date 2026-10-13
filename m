Received: from mail-qk1-f174.google.com (mail-qk1-f174.google.com [209.85.222.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E03353E3163
	for <virtualization@lists.linux.dev>; Tue, 13 Oct 2026 03:25:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.222.174
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791861922; cv=pass; b=eijJapCNWZKWVtmPcwFSvhk1OYjf+++wp1egT7mh4PGRUc3mc9sCDdBgN9LaPX4TmE1vQICMVAUcb55AUYSvFn8JNP57I9Zzz6p5YExrL3jvXPvr9fXrVHVQHQ0UBY2kKvWUSswc20Ida55IlsrIiuSJTP7yAg5+5Szx6s8rKuw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791861922; c=relaxed/simple;
	bh=0b7OaC4HUufUZhIweIEW73CTwJE8jbl1XyGAQdeamgk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qoNQaAduRKuLL83Vfx6RtmVY2POLDFsmOu5jJ0i0dwBXdwOo4K0Gt0Y3gDDczGi2X2Njr+IhLIYJJ1O+z7XYkoTzQX0IZaqL6+pb9IYsMeZSp6wMEwysKx7VFHHxVHuhzS7OsjLlMJmsntQjQz/InVYKBzOjuix523HV5+keJnY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=X/JKJr2h; arc=pass smtp.client-ip=209.85.222.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X/JKJr2h"
Received: by mail-qk1-f174.google.com with SMTP id af79cd13be357-93cb1c0e851so201477185a.0
        for <virtualization@lists.linux.dev>; Mon, 12 Oct 2026 20:25:20 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791861920; cv=none;
        d=google.com; s=arc-20260327;
        b=ESrYDXH00+jUtOgXnIBeiqksseogAbx7zoEvfbTMJoIZhAN2tSsAawrXFLIGD4zxXA
         ETu1v/HGXmmTqhMLVBa1C497EUiD015eom4C8cbcAYuqJsR2Spcgu9fXan+t2CRHu2Ox
         4AJDgf6ozUANKq2soLGicrCBBg7zWuaM0+/vJxlL0CUA2SmRocGPHCwA4Th5ToyFyI4j
         IFegcAVMhIawEId3EOGQpOTy8TglOmtHDUUfnMpR8uCxXFJ9WYUev8w+/Km4c3WcmwP2
         KnSjRDLmTvqxqD+VfuFihzS5IA2n3uOzKmRH4nL2KotThoA6oDB4R+++0FIipzzrzODP
         EIPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=8btU5rJ+Pel0WPP/jtsdEEDxh2u3x4YA62OOuosbpv4=;
        fh=kR9Mmk4/9gd7GrNfiISpZONF0f8XaMtTZZMQefUHJNk=;
        b=GZ0+zua1ckkuiFp6GyvIVRY5RzpELUdxzWrb8XiHhebZU8T+/Rqnn+F24mByilHIxP
         WfaCkRS4Ys3XNInHRPy8pgdm1KmtWol68J+1o7mtTzg0YXp0kC4NgwNhoedsUHINkDnG
         js/xtbNyHklC7Cog6ngxM/3eZPWlr8iStJM0GTQPUwviFPi8GjnICuqqTGADGqqef7/W
         uSAe1ww/KfUnk05gp0Zhlnuizn6GtneC2CrzM02Y6eOWSTM8vkRBCFhwPFNCuBepUs8E
         pvEdCrRfrpCGtNG6ZRElbgn6p+AYZ5oWq6RVKbpSgvHTfeGtXfIZlnJSZG0tNOqcofAi
         oDsQ==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791861920; x=1792466720; darn=lists.linux.dev;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=8btU5rJ+Pel0WPP/jtsdEEDxh2u3x4YA62OOuosbpv4=;
        b=X/JKJr2hxvo/RHT2NZHE5LJvHjbGxCnCWyNkr5fqkHEw/Xv+KmXCgL70w1oJy4NWP3
         ylfbdZfeuqSSPtNozfD6UcNVAu/pLODRZ3oJlvAWPyZOYgIJU6pKCyJ+1ucua36NnF/Y
         JzLwvb3rsSq8dR3ftsJx2fxhgSNZGy/vPg3hdBZDXebfjnFUAKv1SrHNMDpLVNQ/zIwV
         SOBeIbr3qjWSFUJ9iRqaFP+Ul9Ux7OUwVIajKDubZ+pfAfkEMSzTkMvgD0DcVhHx3it1
         I5LiTJCKeSHa+zLopdojgcbkhzLZzZzGkx1XK0K8ITFwV8ZPxCxw7q+RjiLrlCdTiaK/
         wS7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791861920; x=1792466720;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=8btU5rJ+Pel0WPP/jtsdEEDxh2u3x4YA62OOuosbpv4=;
        b=1C1go6y1a2ZxCymgsd5ZGuPJf6zsm/Jl9GBSqeuTopWrGjF7n3WhkAjPv4ow6d1juh
         12RLvdx5lNUNJIrhW26UPaJQevOWhRzkHH/rXEPFXjj3krszesu44ManbZg60w4mSrwB
         idLyufCHlK/EGPcQ6RJF3JTK8g/KeikrfUFqns8W1oxvuVa9/Dl2HNylKOOULFHOaFdg
         bXZ5VfE90aecToKNSpRGwKhLxxm17P+XOkSolvwKbhakrw2+TgoxHfRDLH8LxHZMaxtf
         HQM1tZWomVcobWmG8/VO5ffMHlyk0qWTTw6hLBo60aVCIRQyRYjbSmYrAl/ezPbWVfLk
         IyvA==
X-Forwarded-Encrypted: i=1; AKwUvByDUws0FQw1/vtDTQas36W631thfQd+8MHINfopz15TXgDmxz5IvZMixoKkWRds5MTJschnhb6FoHz8a7ga6w==@lists.linux.dev
X-Gm-Message-State: AFq9FYJ+c0H7dD5aozLUctm7KGfuAaXvnmdOVSckQc91v64ckxGW9fhj
	dxqMUbwvfk29UKk1Yoz+Y470VHiV4vB62SujmTlyHnIT2mi8Ji0udErj3ez6R+PO2Ox3CObfm17
	eYvywsPCsowBWrbc9piPB+odmPcDIIY4=
X-Gm-Gg: AYBFou0cm36mjjkNPtsNSEHsNCaa9Wleyu5x/30Q8ndewOTjaX2T+Zo1dcuZaDI1XVB
	B637u/ct+KdjOIpGkXJZQXf7VYpfSo2Ay5NSANG5Yyf2Yj4IfXQtpu2244zBbaoE0Q8zb1PWbGi
	4HwaXadlzR4NcZZxV3URMMfQ0C1Zd5+5RDT+bx2t7qUCCHZO5rz1yJYE4HJIPGIe58vcjsvIGmu
	Zu9Pi2MysTjeufCw4jm9QWwuFK0FWKH9ePP0PIuVcxDe5HpfOgMNHqhv/sL9MKOkgm1ySP3O6F/
	2nJhvFuvSozudY/KkXjNuNBI4fhBg8hUQUVf5qV2otieZB4Vl9cG2l5Q4sMLpfjCtg==
X-Received: by 2002:a05:620a:1981:b0:93c:c7ee:8087 with SMTP id
 af79cd13be357-93ebd262586mr2063648385a.41.1791861918719; Mon, 12 Oct 2026
 20:25:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20261010142247.99223-1-physicalmtea@gmail.com>
 <20261010142247.99223-2-physicalmtea@gmail.com> <as1SWsJw2dSrPYcL@devvm29614.prn0.facebook.com>
In-Reply-To: <as1SWsJw2dSrPYcL@devvm29614.prn0.facebook.com>
From: Jia Jia <physicalmtea@gmail.com>
Date: Tue, 13 Oct 2026 11:24:42 +0800
X-Gm-Features: AclHuK8ArxSs8AN-w9MzUrVu9R026x9r6uOWM8JmPA66VFn2x0Xfdd31Fer7qUg
Message-ID: <CAJwVaMJsQs61+sCun6oJ7bW-Ob76AjdHVxLd+T1EVHvOR5e7Xw@mail.gmail.com>
Subject: Re: [PATCH net-next v2 1/5] vsock/virtio: split socket lookup from
 locked RX processing
To: Bobby Eshleman <bobbyeshleman@gmail.com>
Cc: stefanha@redhat.com, sgarzare@redhat.com, netdev@vger.kernel.org, 
	virtualization@lists.linux.dev, kvm@vger.kernel.org, mst@redhat.com, 
	jasowangio@gmail.com, eperezma@redhat.com, xuanzhuo@linux.alibaba.com, 
	davem@davemloft.net, edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com, 
	horms@kernel.org, linux-kernel@vger.kernel.org, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

>
> On Sat, Oct 10, 2026 at 10:22:43PM +0800, Jia Jia wrote:
> > Split virtio_transport_recv_pkt() so socket lookup is separate from the
> > receive state machine that runs under the socket lock.
> >
> > Keep virtio_transport_recv_pkt() on its existing per-packet locking path.
> > Pass the source and destination addresses used for lookup to the locked
> > receive path so they are decoded only once.
> >
> > Pass the network namespace and decoded address tuple through a packet
> > context to the locked receive path.
> >
> > Preserve source validation and failure handling. Keep the lookup reference
> > separate from the skb owner reference so the locked receive path can manage
> > the two lifetimes independently.
> >
> > Signed-off-by: Jia Jia <physicalmtea@gmail.com>
> > ---
> >  net/vmw_vsock/virtio_transport_common.c | 139 ++++++++++++++++--------
> >  1 file changed, 96 insertions(+), 43 deletions(-)
> >
> > diff --git a/net/vmw_vsock/virtio_transport_common.c b/net/vmw_vsock/virtio_transport_common.c
> > index f225f53..e3e75e5 100644
> > --- a/net/vmw_vsock/virtio_transport_common.c
> > +++ b/net/vmw_vsock/virtio_transport_common.c
> > @@ -1774,81 +1774,97 @@ static bool virtio_transport_valid_type(u16 type)
> >              (type == VIRTIO_VSOCK_TYPE_SEQPACKET);
> >  }
> >
> > -/* We are under the virtio-vsock's vsock->rx_lock or vhost-vsock's vq->mutex
> > - * lock.
> > - */
> > -void virtio_transport_recv_pkt(struct virtio_transport *t,
> > -                            struct sk_buff *skb, struct net *net)
> > +static void
> > +virtio_transport_recv_pkt_init_addrs(struct sk_buff *skb,
> > +                                  struct sockaddr_vm *src,
> > +                                  struct sockaddr_vm *dst)
>
> I'd prefer these calls stay inline, there is nothing complex enough here
> to justify abstracting IMHO.
>
> Could we move things around so that we don't have the arbitrary move of
> virtio_transport_recv_pkt()? It tends to create noise and makes it
> harder to focus on the more important parts of the patch.
>

Sure, I'll update this in the next version.

> >  {
> >       struct virtio_vsock_hdr *hdr = virtio_vsock_hdr(skb);
> > -     struct sockaddr_vm src, dst;
> > -     struct vsock_sock *vsk;
> > -     struct sock *sk;
> > -     bool space_available;
> >
> > -     vsock_addr_init(&src, le64_to_cpu(hdr->src_cid),
> > +     vsock_addr_init(src, le64_to_cpu(hdr->src_cid),
> >                       le32_to_cpu(hdr->src_port));
> > -     vsock_addr_init(&dst, le64_to_cpu(hdr->dst_cid),
> > +     vsock_addr_init(dst, le64_to_cpu(hdr->dst_cid),
> >                       le32_to_cpu(hdr->dst_port));
> > +}
> > +
> > +static void
> > +virtio_transport_trace_recv_pkt(struct sk_buff *skb,
> > +                             const struct sockaddr_vm *src,
> > +                             const struct sockaddr_vm *dst)
> > +{
> > +     struct virtio_vsock_hdr *hdr = virtio_vsock_hdr(skb);
> >
> > -     trace_virtio_transport_recv_pkt(src.svm_cid, src.svm_port,
> > -                                     dst.svm_cid, dst.svm_port,
> > +     trace_virtio_transport_recv_pkt(src->svm_cid, src->svm_port,
> > +                                     dst->svm_cid, dst->svm_port,
> >                                       le32_to_cpu(hdr->len),
> >                                       le16_to_cpu(hdr->type),
> >                                       le16_to_cpu(hdr->op),
> >                                       le32_to_cpu(hdr->flags),
> >                                       le32_to_cpu(hdr->buf_alloc),
> >                                       le32_to_cpu(hdr->fwd_cnt));
> > +}
>
> Any chance we can get rid of this wrapper and just call
> trace_virtio_transport_recv_pkt() directly? Even from multiple call
> sites I don't think this is a big simplification win.
>

Sure, I'll update this in the next version.

> >
> > -     if (!virtio_transport_valid_type(le16_to_cpu(hdr->type))) {
> > -             (void)virtio_transport_reset_no_sock(t, skb, net);
> > -             goto free_pkt;
> > -     }
> > +static struct sock *
> > +virtio_transport_recv_pkt_find_socket(struct sk_buff *skb,
> > +                                   struct sockaddr_vm *src,
> > +                                   struct sockaddr_vm *dst,
> > +                                   struct net *net)
> > +{
> > +     struct virtio_vsock_hdr *hdr = virtio_vsock_hdr(skb);
> > +     struct sock *sk;
> >
> > -     /* The socket must be in connected or bound table
> > -      * otherwise send reset back
> > -      */
> > -     sk = vsock_find_connected_socket_net(&src, &dst, net);
> > -     if (!sk) {
> > -             sk = vsock_find_bound_socket_net(&dst, net);
> > -             if (!sk) {
> > -                     (void)virtio_transport_reset_no_sock(t, skb, net);
> > -                     goto free_pkt;
> > -             }
> > -     }
> > +     if (!virtio_transport_valid_type(le16_to_cpu(hdr->type)))
> > +             return NULL;
> > +
> > +     sk = vsock_find_connected_socket_net(src, dst, net);
> > +     if (!sk)
> > +             sk = vsock_find_bound_socket_net(dst, net);
> > +     if (!sk)
> > +             return NULL;
> >
> >       if (virtio_transport_get_type(sk) != le16_to_cpu(hdr->type)) {
> > -             (void)virtio_transport_reset_no_sock(t, skb, net);
> >               sock_put(sk);
> > -             goto free_pkt;
> > +             return NULL;
> >       }
> >
> > -     if (!skb_set_owner_sk_safe(skb, sk)) {
> > -             WARN_ONCE(1, "receiving vsock socket has sk_refcnt == 0\n");
> > -             goto free_pkt;
> > -     }
> > +     return sk;
> > +}
>
> Similarly here, the unrelated functions blending makes for a harder
> read. Maybe worth moving things around or trying a different diff
> algorithm?
>

Sure, I'll update this in the next version

> nit: maybe we could just call this virtio_transport_find_socket()? AFAIK
> the tx side doesn't need a socket lookup since we already have the
> socket there, so we can omit the disambiguation if it lends a nicer
> name.
>

Sure, I'll update this in the next version

> >
> > -     vsk = vsock_sk(sk);
> > +struct virtio_transport_rx_pkt_ctx {
> > +     struct net *net;
> > +     const struct sockaddr_vm *src;
> > +     const struct sockaddr_vm *dst;
> > +};
>
> Let's just pass these directly too...
>

Sure, I'll update this in the next version.

> >
> > -     lock_sock(sk);
> > +/*
> > + * The caller holds sk's socket lock and must free skb if this returns true.
> > + */
> > +static bool
> > +virtio_transport_recv_pkt_locked(struct virtio_transport *t,
> > +                              struct sk_buff *skb, struct sock *sk,
> > +                              const struct virtio_transport_rx_pkt_ctx *ctx)
> > +{
> > +     const struct sockaddr_vm *src = ctx->src;
> > +     const struct sockaddr_vm *dst = ctx->dst;
> > +     struct vsock_sock *vsk = vsock_sk(sk);
> > +     struct net *net = ctx->net;
> > +     bool space_available;
> >
> > -     /* Check if sk has been closed or assigned to another transport before
> > -      * lock_sock (note: listener sockets are not assigned to any transport)
> > +     /* Check after acquiring the socket lock. Listener sockets accept packets
> > +      * from any source and are not assigned to a transport.
>
> We can probably remove the first sentence since the function-level
> comment already declares we are holding the socket lock.
>

Sure, I'll update this in the next version.

> Best,
> Bobby
>
> >        */
> >       if (sock_flag(sk, SOCK_DONE) ||
> >           (sk->sk_state != TCP_LISTEN &&
> > -          !vsock_check_source(vsk, &t->transport, &src))) {
> > +          !vsock_check_source(vsk, &t->transport, src))) {
> >               (void)virtio_transport_reset_no_sock(t, skb, net);
> > -             release_sock(sk);
> > -             sock_put(sk);
> > -             goto free_pkt;
> > +             return true;
> >       }
> >
> >       space_available = virtio_transport_space_update(sk, skb);
> >
> >       /* Update CID in case it has changed after a transport reset event */
> >       if (vsk->local_addr.svm_cid != VMADDR_CID_ANY)
> > -             vsk->local_addr.svm_cid = dst.svm_cid;
> > +             vsk->local_addr.svm_cid = dst->svm_cid;
> >
> >       if (space_available)
> >               sk->sk_write_space(sk);
> > @@ -1875,12 +1891,49 @@ void virtio_transport_recv_pkt(struct virtio_transport *t,
> >               break;
> >       }
> >
> > +     return false;
> > +}
> > +
> > +/* We are under the virtio-vsock's vsock->rx_lock or vhost-vsock's vq->mutex
> > + * lock.
> > + */
> > +void virtio_transport_recv_pkt(struct virtio_transport *t,
> > +                            struct sk_buff *skb, struct net *net)
> > +{
> > +     struct virtio_transport_rx_pkt_ctx ctx;
> > +     struct sockaddr_vm src, dst;
> > +     struct sock *sk;
> > +     bool free_pkt;
> > +
> > +     virtio_transport_recv_pkt_init_addrs(skb, &src, &dst);
> > +     virtio_transport_trace_recv_pkt(skb, &src, &dst);
> > +
> > +     sk = virtio_transport_recv_pkt_find_socket(skb, &src, &dst, net);
> > +     if (!sk) {
> > +             (void)virtio_transport_reset_no_sock(t, skb, net);
> > +             goto free_pkt;
> > +     }
> > +
> > +     if (!skb_set_owner_sk_safe(skb, sk)) {
> > +             WARN_ONCE(1, "receiving vsock socket has sk_refcnt == 0\n");
> > +             goto free_pkt;
> > +     }
> > +
> > +     lock_sock(sk);
> > +     ctx = (struct virtio_transport_rx_pkt_ctx) {
> > +             .net = net,
> > +             .src = &src,
> > +             .dst = &dst,
> > +     }
> > +     free_pkt = virtio_transport_recv_pkt_locked(t, skb, sk, &ctx);
> >       release_sock(sk);
> >
> >       /* Release refcnt obtained when we fetched this socket out of the
> >        * bound or connected list.
> >        */
> >       sock_put(sk);
> > +     if (free_pkt)
> > +             kfree_skb(skb);
> >       return;
> >
> >  free_pkt:
> > --
> > 2.34.1
> >
