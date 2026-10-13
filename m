Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C835395AE2
	for <virtualization@lists.linux.dev>; Tue, 13 Oct 2026 03:27:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.177
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791862038; cv=pass; b=kZlVB5m19G/FcjrDfe2rGtZ3FUYjzpSsx80yD0NLzHnHCPzdF6OnPrKSIVPMoWb/8bDv/3kjULKJ6W45a2VyCyBh9O3k49giyOrdxaBclUWKjYjb9zOw7uu524KCIbUo4tbiJnXYqB3Cb0whmBrPMRFAtsQfvWL1wHjLeqdGNsw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791862038; c=relaxed/simple;
	bh=skfSan0+1XZB1gCLut2T846bBKf4wrfvYxze6DiUgyw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QrvMz0aWKfjj/HGQBUWBte19p/0uI2tS+85WNAUuAVXcQjPmoglMKYawC/F25FltwFftGVUuQKlj+tUXHyPyC8hs2wbpr0wRGEoRIzxghPt8yKtlRmwRzmEGTWe3LvXrUKjqRKK1baLw4eCsOM9nBEnSDad9sq1RFGdcnp/+rQ8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nvM98gtT; arc=pass smtp.client-ip=209.85.160.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nvM98gtT"
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-53391022dc0so29396691cf.2
        for <virtualization@lists.linux.dev>; Mon, 12 Oct 2026 20:27:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791862036; cv=none;
        d=google.com; s=arc-20260327;
        b=oXciHPX2kUmx/2nZvF7yBEmsg5+hFuFDOhIiQMwL+nbbGBiM4zb/lGBFyKvgWLFiwI
         SJApNblRSaJ2IsGDfbL1ktz9kdAVcFsyGuC7KG8+25nQJeN7ONaHARbUonWKRIDkyaR1
         q3XZaV60Oi+LnJUvolKKn25zVTo85RTtVcvRHkagFdt7+2D92sH5SDcTX6mBsYnPHYIr
         hX0hQ9PMHVA3lET5GkrKLczYFUgTN+K+iJhmjm9Rm3cy1hIlVRx5lvidBwAIluTM/EMT
         gbKfMorKHBzJwYYvgQW/8uQCvbInYf5OYPJjrwLVjSXDSwsLAfhQhkKWI/jeu+8E+eTY
         fgMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=GnoX8iRBAWCVauZf/sBd0GnSZBf0BiraG31WKJrHpzA=;
        fh=y+5+xOKf0AX7kCNc3mbZ8RZVb0l6pb4qZPp3yb3DOJE=;
        b=eUWe1cbqUluIlzk72d4mxemclLDLk7EB8RPPrtZogQ0hCAKqQ9ytIPNUl3ah/fvVZC
         QmcrSCz3FCiJmJzINAH2Tdi98Dzn++Q+0LP+5rGBie3dl1sASQV0KZEMlGV1MlOrzyg4
         OwIh5C2/Ox7r3uhRjNvXnML+z04Pt27XwO3cWFDDEKl/c3oi2mkZCscpAN3SWZADEWpi
         Ad1xV0senwjE5c0ELxmKrca67HwFmSi/U9l0WgTDHmKs2WllG/P5MxGuCz35wYS6XoXu
         K2AHhZYlSVHxfe6m0Qg3gDgw3olLfwUfIrQU/oav2SVDO7zQrnDLJNziB/erRHl9T6cT
         VVpA==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791862036; x=1792466836; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=GnoX8iRBAWCVauZf/sBd0GnSZBf0BiraG31WKJrHpzA=;
        b=nvM98gtTnehEU0WOz+vowjcYFkJrc3EnDySzKN9yxEbQe5uspxnkhDc3C4oqMaSfiR
         /LJCN/9AoU06NrvFs3tbXusAVDjrc37Vf4BBYSScg/48tjrFOQWLGhXnCw49O0HBNQv+
         sBE7Re69Uz0x+rAVWkr8Rv4S9AuPLRk92DQ4hk70vllcOSg9GI6Wn1OeRAPXHOg7VVlJ
         vo/pkt5y0AKcRgHhbJ1Bz6Z9/c9CAtpmn4zmqFKlKiuNAB7bZTdv+lQgCwC9/NJJSmnS
         9dLoO+eGbsHYE1zhIGPTLlOlOREYSR6b4cX3yMpd9pvN1TcaliBBRC0OOZZy6Qb/qu9U
         5Hwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791862036; x=1792466836;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=GnoX8iRBAWCVauZf/sBd0GnSZBf0BiraG31WKJrHpzA=;
        b=z1gDbn9B1hVfWdfSuWedUiVS8EhxQC0edJUZDRy7m4a3HCIk0YpEfbDGkcwqjEAnWs
         fPpbELWDk7Lr7JTQoPqsIYahn1KwJzC3tklBmYbmijUur9pnjPElSrSQIe6SypGfJguB
         Nw7cnXbTLE9xPwReoa9HiQh72cjM7wnbc1PM54x85U87Y5TXvankChnlIkIKV9zYM+5l
         aZTSAG8qv85Toy0EiCpBnd24nBZnEfAzg/VSOLYEg92nTYumOE2DlZRqNJkedQkN6Hz5
         fZfCtY+YwFcIAe+RfGNej7OgAD4cdmbzpWpbOUqggMPzbPd9cR60MUJTNMhkOAH2jQEp
         c5lA==
X-Forwarded-Encrypted: i=1; AKwUvBy3iPKSgC7S6VW3CKU2EilLz3Gq2/godcUhzuHwBX5ofqlqmQ6q3G6yBDj1ENcpS8RLcZdJBjhPwcVeQkp2AA==@lists.linux.dev
X-Gm-Message-State: AFq9FYJ9c+NdoBmKQ4Lj1fupPWyW7dHCHHhMFVghatu8iYBB5F1Hdyt2
	ba9jkzQbnDI8vANJv/R9j5k4YIuJfzwPRXbyac8bNjRkxPj51AoLwFzc9id0sbGqxbJG7iP4Urh
	WfETxnxjzjEFDvaO74V2gEUjCmmIE62w=
X-Gm-Gg: AYBFou0Qlr0OTWBsYNO2o94Zahua41+AdZ80XDnVZXOyyfXZ3UWGvXq3McXRDWNpzqx
	QsqG8YMs8XCcyEevFKK38SHcAe4K0imEJKJ/cg96pOEbVk+flD5OEnYlLb+UvJEubtGDUHVaIos
	c+PXSXPffIT1CoAe5g2ztSUonktbB7yCU5enoBeCjR3ixhQB5oJfeUMfqLMfnQ5ZROSZyw0nKa6
	Y1kjnhyQsTd0EixCiEDtvdPSLR5lk1wonXjqoZkYcvjvD4+lu95MIbNBKPZPSYTdgSj6sPGopWB
	/Yt/Zcg9X28JvyzA3HyHb9NL4085bPbJ6Nx2TnJSngVtAtB6V807KFo=
X-Received: by 2002:a05:620a:19a2:b0:934:ab73:ac53 with SMTP id
 af79cd13be357-93ebcc1186emr1807392585a.0.1791862035540; Mon, 12 Oct 2026
 20:27:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20261010142247.99223-1-physicalmtea@gmail.com>
 <20261010142247.99223-2-physicalmtea@gmail.com> <as1ZCkbya2jn72ip@devvm29614.prn0.facebook.com>
In-Reply-To: <as1ZCkbya2jn72ip@devvm29614.prn0.facebook.com>
From: Jia Jia <physicalmtea@gmail.com>
Date: Tue, 13 Oct 2026 11:26:38 +0800
X-Gm-Features: AclHuK-0Vr6L1DTitDJsFP7Cyfe2EIaVm5DyDLTJkZtt76nbyfmG1WpYEm38C3s
Message-ID: <CAJwVaMJL4FFYLq523VY014oa4u7RWD0WUY0+seP1xh3GY5peiQ@mail.gmail.com>
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
> On Sat, Oct 10, 2026 at 10:22:43PM +0800, Jia Jia wrote:
> > Split virtio_transport_recv_pkt() so socket lookup is separate from the
> > receive state machine that runs under the socket lock.
> >
> > Keep virtio_transport_recv_pkt() on its existing per-packet locking pat=
h.
> > Pass the source and destination addresses used for lookup to the locked
> > receive path so they are decoded only once.
> >
> > Pass the network namespace and decoded address tuple through a packet
> > context to the locked receive path.
> >
> > Preserve source validation and failure handling. Keep the lookup refere=
nce
> > separate from the skb owner reference so the locked receive path can ma=
nage
> > the two lifetimes independently.
> >
> > Signed-off-by: Jia Jia <physicalmtea@gmail.com>
> > ---
> >  net/vmw_vsock/virtio_transport_common.c | 139 ++++++++++++++++--------
> >  1 file changed, 96 insertions(+), 43 deletions(-)
> >
>
> [...]
>
> > +/*
> > + * The caller holds sk's socket lock and must free skb if this returns=
 true.
> > + */
> > +static bool
> > +virtio_transport_recv_pkt_locked(struct virtio_transport *t,
> > +                              struct sk_buff *skb, struct sock *sk,
> > +                              const struct virtio_transport_rx_pkt_ctx=
 *ctx)
> > +{
> > +     const struct sockaddr_vm *src =3D ctx->src;
> > +     const struct sockaddr_vm *dst =3D ctx->dst;
> > +     struct vsock_sock *vsk =3D vsock_sk(sk);
> > +     struct net *net =3D ctx->net;
> > +     bool space_available;
> >
> > -     /* Check if sk has been closed or assigned to another transport b=
efore
> > -      * lock_sock (note: listener sockets are not assigned to any tran=
sport)
> > +     /* Check after acquiring the socket lock. Listener sockets accept=
 packets
> > +      * from any source and are not assigned to a transport.
> >        */
> >       if (sock_flag(sk, SOCK_DONE) ||
> >           (sk->sk_state !=3D TCP_LISTEN &&
> > -          !vsock_check_source(vsk, &t->transport, &src))) {
> > +          !vsock_check_source(vsk, &t->transport, src))) {
> >               (void)virtio_transport_reset_no_sock(t, skb, net);
> > -             release_sock(sk);
> > -             sock_put(sk);
> > -             goto free_pkt;
> > +             return true;
> >       }
> >
> >       space_available =3D virtio_transport_space_update(sk, skb);
> >
> >       /* Update CID in case it has changed after a transport reset even=
t */
> >       if (vsk->local_addr.svm_cid !=3D VMADDR_CID_ANY)
> > -             vsk->local_addr.svm_cid =3D dst.svm_cid;
> > +             vsk->local_addr.svm_cid =3D dst->svm_cid;
> >
> >       if (space_available)
> >               sk->sk_write_space(sk);
> > @@ -1875,12 +1891,49 @@ void virtio_transport_recv_pkt(struct virtio_tr=
ansport *t,
> >               break;
> >       }
> >
> > +     return false;
> > +}
> > +
> > +/* We are under the virtio-vsock's vsock->rx_lock or vhost-vsock's vq-=
>mutex
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
> > +     sk =3D virtio_transport_recv_pkt_find_socket(skb, &src, &dst, net=
);
> > +     if (!sk) {
> > +             (void)virtio_transport_reset_no_sock(t, skb, net);
> > +             goto free_pkt;
> > +     }
> > +
> > +     if (!skb_set_owner_sk_safe(skb, sk)) {
> > +             WARN_ONCE(1, "receiving vsock socket has sk_refcnt =3D=3D=
 0\n");
> > +             goto free_pkt;
> > +     }
> > +
> > +     lock_sock(sk);
> > +     ctx =3D (struct virtio_transport_rx_pkt_ctx) {
> > +             .net =3D net,
> > +             .src =3D &src,
> > +             .dst =3D &dst,
> > +     };
> > +     free_pkt =3D virtio_transport_recv_pkt_locked(t, skb, sk, &ctx);
>
> At this point the socket lookup succeeded with src/dst/net, why not just
> pass sk which already has all of them?
>

If I understand this correctly, a successful lookup is not enough to
recover all of this from sk. The lookup may fall back from the
connected table to the bound
table, so the packet source must still be validated under the socket
lock; otherwise that check would become ineffective. The packet
destination is also needed after
a transport reset, and the RX namespace used for a reset reply is not
necessarily sock_net(sk) in global mode. I=E2=80=99ll remove the context
struct and pass src, dst, and
net directly.

> Best,
> Bobby
