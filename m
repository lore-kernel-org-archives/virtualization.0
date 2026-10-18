Received: from mail-qv1-f53.google.com (mail-qv1-f53.google.com [209.85.219.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AE3C3BFE3C
	for <virtualization@lists.linux.dev>; Sun, 18 Oct 2026 04:58:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.219.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792299530; cv=pass; b=XOWK2UVFHtJxg4mz5kuTPitu4Ja6hil+0f4t70ztOtNc7CyolKDUTix0J8IOvLlI6qRYrRep/1WwcYC9Wu2VMHR1eYMxpwjlQYDBt32tI22Z2MbwVblf7HEj8qCstezxwsi2raVOHG0FBVqxpnDd/JNP+S24ZKh7nBLS3MSPzds=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792299530; c=relaxed/simple;
	bh=2jacn7S1Q9FlxeVvnvAIlfCi8jr+ktJM+dSbhY55nxk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FGm4nDeLEyUkfpaHhVxbc9w2vEaRo4NUw6Dn4wJ1fGyumWzwfgofHu8B5COOSpuRACpnHvEfw+jDNsbjMfU2EALdordgGvP1Q+WDIz5Owk4NXWLaOT0D0gwvKWk93ZsZj3bnWBBw3PWj6UNr+H9H4c+1XRC/urPZ82tlAuVPoJs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=S73JN0VL; arc=pass smtp.client-ip=209.85.219.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S73JN0VL"
Received: by mail-qv1-f53.google.com with SMTP id 6a1803df08f44-91ba8fcc684so11957656d6.3
        for <virtualization@lists.linux.dev>; Sat, 17 Oct 2026 21:58:48 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792299527; cv=none;
        d=google.com; s=arc-20260327;
        b=iax4Mrd54tgFnA7PZl1azDj0w0payK7AGqn5XEcE21GxcztHMbrnJubvGWmVkMi3B4
         zFe2vDp6VcXnckg0U3G60Df4u6nt1/aFlwjvmQL+1ZVnEWjDaU1Ukny185IIUYc7LqMf
         3hoMM7pkSrd5u4XiZN8L4N/QvdROG4HBxpYxrIcR/EFgCwZXL9N9+fr+4ozIsLUHtSGH
         nFU3E3uhF1FtDty3U/KOjuKKVKu+67428fZk7c6opk0hyd/ewuhsQJJge/K0nlwv35J9
         cQe5a48wnjlxOC7I22ZkDsJyyy+Duvatf4AjbOTR42UqwtuBKuLXKNnWX4aDmREv11qB
         qsbA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=SVpEQObwWOIqtaAcnO44zwnUu1XsD27+z0cFMp5vI8I=;
        fh=QY7rsss1a0KhqwkPkh7NOdhMsBS6MPOTHxQwRfZiRgo=;
        b=gxmSImMP/udeM9WYi8blNgPbISxyCc77VmSuDnmir0G6IMGE/QQjP9fp+SJnXzUtpH
         D3gUlOfshWRdKSCFUDjXDXRsSJbrLd5lAlnp2TyirQzexUxLUEKDhIEohIzmt+mBg5bb
         tksB358czTHRryOl+F60GS5Wstyg/7UhNiEpxeogNnXyeskuShxzA3hRniYdauJNkXaw
         ZKPFqpjYiIHrqu9AbtaI8S8TLIJtS+Atq6j626kAl0HaePIJgVhVBGm0iQG1Hb/FA4MO
         74hnuc9wCd5CCt/0+/6whMhzXvG6gaeTrGJkya2IUslO47UZH6bIVY8SyK6GR8A1285E
         r+rg==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792299527; x=1792904327; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=SVpEQObwWOIqtaAcnO44zwnUu1XsD27+z0cFMp5vI8I=;
        b=S73JN0VLoa8ifcwYUHUFAQhVQ4RNYfkIkkC1pUhG8tWZRZNdQ7Sk2aWVf3XFkFfVa8
         QbxmtNuTGYlgA9kxPrrlf7Nd5/N2Ea4mxljavmLXsFj0m5hNuL4tE5KMcSsprgywEmR8
         Jqrnju9xkDUN3x5m1HMd61fUVhLZ4Y0w3pADr+LeR09ZYp800ib2cxAt5iHuAPdmIp9H
         3J4W8R4gWJ9xvuEen/U3mHSUcECIzYJuTaZeItooAypWqLRDt26SJu5b5aij25HAuSkN
         svfyZ/b+vha4S4fdF2aQztigYdPOF0MRzbpCA01n1i0qmk96LGi0Nl6LtmeVl0BXi//L
         zwSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792299527; x=1792904327;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=SVpEQObwWOIqtaAcnO44zwnUu1XsD27+z0cFMp5vI8I=;
        b=tgnWsSLyg/e2Xe2/6akA3Z4d9Skg1YNVsQTMHUz0+SXPRKdVubVEYmlSEBYhFTmGf9
         Yw8C9tme+1zGA4EuHqgHLv80lk4y/pW7meYaIETyuPxW22+D6wzm0z1JTs5DYD+21lYV
         b85zrf1C4AYRbYPmY5pfrwlS+25VcezhCmrEfzArKeM0Mp+mV7BpiPc8aP3jEn84NucL
         jUvgUYg0sZ8xku5E7fhNWaRCfa3puv4AxNBUle2opV2fKAmqHVXnXs74jeVE51gg1+kG
         Hm4+sHw0nBYyWnliLJoltQERWDUjCeGCa2neL28RZKrE5RxIVg1URAMZPcfhF6jWEb3A
         fphA==
X-Forwarded-Encrypted: i=1; AKwUvBysX68qtaB8YAXwm8FZRaIDczfijG9Zm0WN1ncx4OteUxfwcsjLPpKkii7HoCDHPZ2xCOHMtqJWXmPMZzWmXA==@lists.linux.dev
X-Gm-Message-State: AFq9FYJ88rI0c3G/2u+xiJQ+zYq0ghWNvweppUFLC5xfkNYfrf9WcIIB
	Jcu77Zx+ICe3VJD8OwbyuGHlFCmz3xSVEgMejD1mGJS23/NnKL+EPq9xFxmKWcBFCORWgC1jehX
	/ESNZfafRkM122Uc3vcY0XnbeYtyukMNFmEYk/lE=
X-Gm-Gg: AYBFou3sRD4nqgaHAdse5uyYyIQGsMYVnJ5KjCyJ8UCUGWtMw2wqW7tHIR4nVM+iTVz
	2rq7Fqotvua/gSIc8Z9zUH8T3OflT7yAY2NByJf1DAYZzRYWha9GRWvkyqiGHPekLSn8NtUmbZo
	Vs7NUua1VDbeFx4WJnP2zAcHQyRayGWRGp/Ehwj5jR2TWBgmeT3inMSVEq5hbPLp1PZa9rn5z7V
	GTo2v4mH/W1UbT9ms6hxrzUJOyXEVUDMg3Zo+ASGORcJvxqGoCTujhu7sx4ncm6I/80N+x7SmeC
	bUHF31Qzm0U1kOggZm5wJxsPVmH6kxpwH0QECW37TxnfR99TGregpK4=
X-Received: by 2002:a05:620a:171e:b0:93f:5ac:14a0 with SMTP id
 af79cd13be357-93f29de3496mr751682285a.67.1792299526279; Sat, 17 Oct 2026
 21:58:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20261014115640.184286-1-physicalmtea@gmail.com>
 <20261014115640.184286-4-physicalmtea@gmail.com> <atIvkN7GJTpsczu8@devvm29614.prn0.facebook.com>
In-Reply-To: <atIvkN7GJTpsczu8@devvm29614.prn0.facebook.com>
From: Jia Jia <physicalmtea@gmail.com>
Date: Sun, 18 Oct 2026 12:58:09 +0800
X-Gm-Features: AclHuK9AelIjvjLZl8EdKC4WfogWCvECErnvcMt1QyfPdt0mduLoNaQolEZS0YM
Message-ID: <CAJwVaMK-KYZyOkYyuH-CnPG=urE53hGXexVn_ezd6icdKFJ=-Q@mail.gmail.com>
Subject: Re: [PATCH net-next v4 3/4] vsock/virtio: coalesce RX write-space
 notifications in lock batches
To: Bobby Eshleman <bobbyeshleman@gmail.com>
Cc: stefanha@redhat.com, sgarzare@redhat.com, mst@redhat.com, 
	jasowangio@gmail.com, eperezma@redhat.com, xuanzhuo@linux.alibaba.com, 
	davem@davemloft.net, edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com, 
	horms@kernel.org, virtualization@lists.linux.dev, kvm@vger.kernel.org, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

>
> On Wed, Oct 14, 2026 at 07:56:39PM +0800, Jia Jia wrote:
> > Each received packet updates peer credit and may call sk_write_space().
> > A writer cannot use that credit until the batch releases the socket loc=
k,
> > so one notification at batch finish is sufficient.
> >
> > Save the initial sk_write_space callback when the AF_VSOCK socket is
> > created and require it to remain installed for batching. This lets the
> > transport module deliver the deferred notification without referring to
> > the unexported default callback. Sockets with replaced callbacks retain
> > their per-packet behavior.
> >
> > Record the batch socket before processing its first packet so a batch t=
hat
> > ends on that packet cannot lose the pending notification.
> >
> > Signed-off-by: Jia Jia <physicalmtea@gmail.com>
> > ---
> >  include/linux/virtio_vsock.h            |  1 +
> >  include/net/af_vsock.h                  |  5 +++
> >  net/vmw_vsock/af_vsock.c                |  1 +
> >  net/vmw_vsock/virtio_transport_common.c | 53 +++++++++++++++++--------
> >  4 files changed, 44 insertions(+), 16 deletions(-)
> >
> > diff --git a/include/linux/virtio_vsock.h b/include/linux/virtio_vsock.=
h
> > index 26dde6909c4ed..bf077ee0ded88 100644
> > --- a/include/linux/virtio_vsock.h
> > +++ b/include/linux/virtio_vsock.h
> > @@ -287,6 +287,7 @@ struct virtio_transport_rx_batch {
> >       struct sock *sk;
> >       unsigned int pkts;
> >       size_t bytes;
> > +     bool write_space_pending;
> >  };
> >
> >  void virtio_transport_recv_pkt_batch(struct virtio_transport *t,
> > diff --git a/include/net/af_vsock.h b/include/net/af_vsock.h
> > index 5549298c1ec6b..9a40960d10cbe 100644
> > --- a/include/net/af_vsock.h
> > +++ b/include/net/af_vsock.h
> > @@ -63,6 +63,11 @@ struct vsock_sock {
> >       u32 peer_shutdown;
> >       bool sent_request;
> >       bool ignore_connecting_rst;
> > +     /*
> > +      * Initial callback, used to identify replacements and deliver de=
ferred
> > +      * write-space notifications.
> > +      */
> > +     void (*default_write_space)(struct sock *sk);
> >
> >       /* Protected by lock_sock(sk) */
> >       u64 buffer_size;
> > diff --git a/net/vmw_vsock/af_vsock.c b/net/vmw_vsock/af_vsock.c
> > index 44cee74519555..fe7f49da6c4bc 100644
> > --- a/net/vmw_vsock/af_vsock.c
> > +++ b/net/vmw_vsock/af_vsock.c
> > @@ -958,6 +958,7 @@ static struct sock *__vsock_create(struct net *net,
> >               sk->sk_type =3D type;
> >
> >       vsk =3D vsock_sk(sk);
> > +     vsk->default_write_space =3D sk->sk_write_space;
> >       vsock_addr_init(&vsk->local_addr, VMADDR_CID_ANY, VMADDR_PORT_ANY=
);
> >       vsock_addr_init(&vsk->remote_addr, VMADDR_CID_ANY, VMADDR_PORT_AN=
Y);
> >
> > diff --git a/net/vmw_vsock/virtio_transport_common.c b/net/vmw_vsock/vi=
rtio_transport_common.c
> > index ff74e805527a5..f4b5f0230493e 100644
> > --- a/net/vmw_vsock/virtio_transport_common.c
> > +++ b/net/vmw_vsock/virtio_transport_common.c
> > @@ -1820,6 +1820,7 @@ virtio_transport_recv_pkt_batchable(struct virtio=
_transport *t,
> >       return sk->sk_state =3D=3D TCP_ESTABLISHED &&
> >              sk->sk_type =3D=3D SOCK_STREAM &&
> >              READ_ONCE(sk->sk_prot) =3D=3D sk->sk_prot_creator &&
> > +            READ_ONCE(sk->sk_write_space) =3D=3D vsk->default_write_sp=
ace &&
> >              !sock_flag(sk, SOCK_DONE) &&
> >              vsk->transport =3D=3D &t->transport &&
> >              vvs && virtio_transport_rx_skb_has_headroom(vvs) &&
> > @@ -1828,13 +1829,15 @@ virtio_transport_recv_pkt_batchable(struct virt=
io_transport *t,
> >
> >  /*
> >   * The caller holds sk's socket lock.  Set @batchable if the socket ca=
n remain
> > - * locked for another ordinary STREAM/RW packet.  Return true if the c=
aller
> > - * must free @skb.
> > + * locked for another ordinary STREAM/RW packet.  When @batch is non-N=
ULL,
> > + * record a default write-space notification for batch finish instead =
of
> > + * delivering it immediately.  Return true if the caller must free @sk=
b.
> >   */
> >  static bool
> >  virtio_transport_recv_pkt_locked(struct virtio_transport *t,
> >                                struct sk_buff *skb, struct sock *sk,
> > -                              bool *batchable)
> > +                              bool *batchable,
> > +                              struct virtio_transport_rx_batch *batch)
> >  {
> >       struct virtio_vsock_hdr *hdr =3D virtio_vsock_hdr(skb);
> >       struct sockaddr_vm src;
> > @@ -1863,8 +1866,12 @@ virtio_transport_recv_pkt_locked(struct virtio_t=
ransport *t,
> >       if (vsk->local_addr.svm_cid !=3D VMADDR_CID_ANY)
> >               vsk->local_addr.svm_cid =3D le64_to_cpu(hdr->dst_cid);
> >
> > -     if (space_available)
> > -             sk->sk_write_space(sk);
> > +     if (space_available) {
> > +             if (batch)
> > +                     batch->write_space_pending =3D true;
> > +             else
> > +                     sk->sk_write_space(sk);
> > +     }
> >
> >       switch (sk->sk_state) {
> >       case TCP_LISTEN:
> > @@ -1931,7 +1938,7 @@ void virtio_transport_recv_pkt(struct virtio_tran=
sport *t,
> >       }
> >
> >       lock_sock(sk);
> > -     free_pkt =3D virtio_transport_recv_pkt_locked(t, skb, sk, NULL);
> > +     free_pkt =3D virtio_transport_recv_pkt_locked(t, skb, sk, NULL, N=
ULL);
> >       release_sock(sk);
> >
> >       /* Release refcnt obtained when we fetched this socket out of the
> > @@ -1949,22 +1956,27 @@ EXPORT_SYMBOL_GPL(virtio_transport_recv_pkt);
> >
> >  /*
> >   * Finish the RX batch.
> > - * For a non-empty batch, the caller must hold the socket lock acquire=
d with
> > - * lock_sock(). This function releases the lock and the batch's lookup
> > - * reference.
> > + * For a non-empty batch, the caller holds the socket lock acquired wi=
th
> > + * lock_sock(). Deliver any deferred write-space notification while th=
e lock
> > + * is held, then release the lock and the batch's lookup reference.
> >   * An empty batch is a no-op.
> >   */
> >  void virtio_transport_rx_batch_finish(struct virtio_transport_rx_batch=
 *batch)
> >  {
> > +     bool write_space_pending =3D batch->write_space_pending;
> >       struct sock *sk =3D batch->sk;
> >
> >       batch->sk =3D NULL;
> >       batch->pkts =3D 0;
> >       batch->bytes =3D 0;
> > +     batch->write_space_pending =3D false;
> >
> >       if (!sk)
> >               return;
> >
> > +     if (write_space_pending)
> > +             vsock_sk(sk)->default_write_space(sk);
>
> Any reason not to just do READ_ONCE(sk->sk_write_space)(sk) instead of
> storing this for later? If we setup the socket in a sockmap program
> mid-batch, doesn't this and sk_data_ready (from the next patch) go
> stale?
>

Thanks for the review, I tried loading the current callback in an
earlier version, but READ_ONCE() does not synchronize the load and
invocation with sockmap attach or teardown.
For example, it could load sk_psock_write_space, then invoke it after
the psock has been removed, in which case the wrapper would no longer
forward the
native wakeup. The sk_data_ready case is more serious: the stale
sockmap wrapper can dequeue a native skb and then drop it when its
actor finds no psock.

There is also an attach-side semantic issue: one deferred data-ready
notification may represent several native skbs, while one invocation
of the sockmap
callback consumes only one skb. The saved callbacks are therefore
intentional and represent the native path at packet admission, rather
than the callback
installed at batch finish. A packet boundary that observes a callback,
protocol, or psock change terminates the batch. I=E2=80=99ll document this
admission-time
rule more clearly and add sockmap attach/detach stress coverage.


> > +
> >       release_sock(sk);
> >       sock_put(sk);
> >  }
> > @@ -2019,7 +2031,8 @@ void virtio_transport_recv_pkt_batch(struct virti=
o_transport *t,
> >                       }
> >
> >                       free_pkt =3D virtio_transport_recv_pkt_locked(t, =
skb, sk,
> > -                                                                 &batc=
hable);
> > +                                                                 &batc=
hable,
> > +                                                                 batch=
);
> >                       if (!batchable)
> >                               virtio_transport_rx_batch_finish(batch);
> >                       if (free_pkt)
> > @@ -2059,23 +2072,31 @@ void virtio_transport_recv_pkt_batch(struct vir=
tio_transport *t,
> >
> >       lock_sock(sk);
> >       /*
> > -      * Sockmap removal restores the native protocol under sk_callback=
_lock.
> > -      * Serialize this initial eligibility check with that update.
> > +      * Sockmap teardown restores callbacks under sk_callback_lock. Ke=
ep the
> > +      * initial eligibility check consistent with that update.
>
> Why reword here?
>
> >        */
> >       read_lock_bh(&sk->sk_callback_lock);
> >       start_batch =3D virtio_transport_recv_pkt_batchable(t, sk);
> >       read_unlock_bh(&sk->sk_callback_lock);
> >
> > +     if (start_batch)
> > +             batch->sk =3D sk;
> > +
> >       free_pkt =3D virtio_transport_recv_pkt_locked(t, skb, sk,
> > -                                                 start_batch ? &batcha=
ble : NULL);
> > +                                                 start_batch ? &batcha=
ble : NULL,
> > +                                                 start_batch ? batch :=
 NULL);
> >       if (start_batch && batchable) {
> >               /* Keep the lookup reference until the batch is released.=
 */
> > -             batch->sk =3D sk;
>
> Seems like `batch->sk =3D sk` is moving around between patches?
>
> I don't know, feels like if the batching patch introduces
> sk_write_space/sk_data_ready bugs, then that patch should probably
> contain these patches too. Should minimize churn too?
>
>

My intention was to structure the series in two stages. Patches 1 and
2 form a complete batching change while retaining the existing
per-packet
notification behavior. Patches 3 and 4 then add notification
coalescing and after-unlock delivery. Therefore, Patch 3 is not a
correctness fix for Patch
2; the series through Patch 2 remains functional on its own.

The batch->sk assignment moves because Patch 3 introduces pending
notification state. Once the first packet can record a deferred
notification, the batch
must record its socket before processing that packet, even if the
packet subsequently ends the batch.

I agree, however, that this split causes avoidable churn.


> >               return;
> >       }
> >
> > -     release_sock(sk);
> > -     sock_put(sk);
> > +     if (start_batch) {
> > +             virtio_transport_rx_batch_finish(batch);
> > +     } else {
> > +             release_sock(sk);
> > +             sock_put(sk);
> > +     }
> > +
> >       if (free_pkt)
> >               kfree_skb(skb);
> >  }
> > --
> > 2.53.0
> >
>
> Best,
> Bobby
