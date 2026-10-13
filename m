Received: from mail-qk1-f182.google.com (mail-qk1-f182.google.com [209.85.222.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B49337CD40
	for <virtualization@lists.linux.dev>; Tue, 13 Oct 2026 03:29:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.222.182
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791862174; cv=pass; b=q0kP61o6nW67ArhZ5qqq1GWxdlF8zUFiA1V15v0jcuSTeSRg+63f5/0NxvuFNW6Ql7EcoS8yxKldgMfx07eXY7D7NVL78q6nTdpLjrKw2Vux5X8untwhySIf+Fx57RkkDR1+XnkvKLKdqNjasZ67TiUjQJjMnIXmG3enOQwuFRY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791862174; c=relaxed/simple;
	bh=+tf5KT/LBLH9dUzbsqRGcwYkkoel0brUJOereQ+cnFQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FvduEfx49BFJ2jdziMYCcKrL9FU5AdZF5qYCLglx0XpfTFCnh6wbbsfi6O3RR1KYeJP8/iYklVeuUIT2zV5oYa9quih9UPjSm+cuX0ZoVY+3LnZpa3TsieYLCisjzh1qWxCzub28uQGGoqggx45zEI96fyaHUuNv+QHnJQ6rMh0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ovytd3YL; arc=pass smtp.client-ip=209.85.222.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ovytd3YL"
Received: by mail-qk1-f182.google.com with SMTP id af79cd13be357-93e7457349eso236623885a.1
        for <virtualization@lists.linux.dev>; Mon, 12 Oct 2026 20:29:31 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791862170; cv=none;
        d=google.com; s=arc-20260327;
        b=RINT84EwzLLIMWdkf2QyQRopqWnvi7mPpoZOxsu6UU0XfEAHaC6qH0iNbQrsqmccqW
         +/kmO5BmIjPZGDpVFMSg+1WCqBwb5qtFlCQLrHIDoKVOyTrS5YX35HCAnjDsImb0BLSv
         KgaqHqTJ74gIZ1hFJSvnv5lLTQub2qks5jyWXodjLUfydRVgc/Ud6rCWO/+F7mQl6xt8
         MHf5X19JEE+Tj2HoTkgqjIUn4q6Hp3ZKiI1VmhILkKQi1S5wdWIL1bFMInbRnKxk4IN4
         0dLcRvkEFL9nuzgScMy1e79dpGwg98uNipOPoi/sKyrh2AY3K5ainFy9fRNfs95vM1Wt
         c1kQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=pjpZB2jPs3cIEERlTXUY/rEvSbEEM3b+tieI1aC2ttk=;
        fh=H/iV3DfpUiC850nv98yfwEKbASbcirgrz9gNGXsBO+E=;
        b=b0I6fUqypoNrRcOG+3bWdaRjSvc7KwBUh56mbNSLjySj1bRRt6211evzVIJnSsG6pL
         KFuApmtCjS0c4IMvhOooqZXDd/Fk0M1tTSWAaytav4xq2E4eUrtWrth89JE6ZhR9fE1G
         8UJY+QKIcwwNSRmPlzxyDN6MZ0E2e0SIzw9JLVDma/IIuqA2rmxuQvxkOJVb3rXj//p+
         p0b+UllV3zjbRloq6yT9huxTNXYDk9Ix4nF3GaYG1YKvedbkDsJKPqqMyRxB+sz6Jlj1
         hT2vVYv/7wF2+8rE7NzPGt3Cd9qqN2D2DU0lw6QWCMy+fNAQNa28G/Fr4BJFlkfyIvmz
         BbNQ==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791862170; x=1792466970; darn=lists.linux.dev;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=pjpZB2jPs3cIEERlTXUY/rEvSbEEM3b+tieI1aC2ttk=;
        b=Ovytd3YLVcwU6dE0MkcKFw2q8oCepWTopxiunDissNMiyoij1tXlyzvyUYA2SgksAN
         2Qf/ivyZwK1k5Da2mh1/z0HqVu2bmfSPAO1c/49phS1LyMHZQvzlyhgGjq4auiNERB6U
         XgbswN/tjTAV3CaI8ugZWeyqnc2CRoprDTvYf3GY2CvfhuKKr0P0q+V/Lt05SOSRTtJ6
         UtGYNjF9xSbhA7LCUdo/cXIu5qmTpOuw7+SBtLw1kAx555bF7kMfGcgEE9ss92k/adDA
         bwX9HQ3AOp8rWKBJhSbDA6czE2cpd0oYtS+4Cz5D4dEmV15/yNePzyf8AzMHXSjW5jDQ
         dvEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791862170; x=1792466970;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=pjpZB2jPs3cIEERlTXUY/rEvSbEEM3b+tieI1aC2ttk=;
        b=ngZNzVhZKCjmLVMuQ7e0RJyrUhvwgqS4K2GiJRw/2pfXFd8QfolBGYPxGBZJBcA+7J
         KrH1v86tjO98xr4KoA+Y91Gy6e2FTMQuaN3Zse7HRe1gJXzqZq/fn0rppc+cBvz92XBZ
         R71bRxIsVHej122dxi3Krp65w346tVF0HZ5WOBODvOwCDoXX2PqvOzxMoP4/bSQR2X9C
         vd7drs7ueLa+u26Sf4o5SDncrApgkecQXVpt8Oa0T5vTczUeashACudh4mDvp10m6Kdc
         wZ4GIbi9O+h9w0yd2LhGwgGJ0lY7/7ZuGO5RNsBZ0C9tO1z0elHGY0+F+utXk7Tdr5Lh
         5xkw==
X-Forwarded-Encrypted: i=1; AKwUvBweAf/65kBlvwj7jsSOeHCSCPgn9paL4biL7PqyCLkO0m+61NG93Qyr8PKYtaEz8iGybSCSRATPDKcuBay3PA==@lists.linux.dev
X-Gm-Message-State: AFq9FYIA2NWDlMdNyqzrhS6e0qSeYNwPN6HTcq5lhIisno4tS+w88jPL
	b5YLKMKawYmr2Vd+oH8YPqthFheJNHNKcgU/51joLpesSDkF4ixcMX8y+n/Zm/iA/nhfaSUseTT
	kKN6MUCXodd64YtpNBV8bqNv3ufiCOiU=
X-Gm-Gg: AYBFou3M1FXwN7sDD89AisE0SvJCRlv0XPIWTmz23FbOjDZCmVm6ZUQQQuiPD07aW0v
	X25nGeR4JJbrxYV0gQvQnDR8raj+frxLNjeluYPcwSIKrM3Doa2USlC/xMZYnZ0vSR89rGDRFUj
	4woFxPBiwWDMHkjoBANetrWvGj0/FruWU1at3AtfAi7xzuowOFAOf9l37ImMG+IYzvJI6yKjDhf
	TGkOAPIpwFnjjHEUWNo+aXbP+5LuoVqTonSTGSK8FRK5mHwZ03WYK7y1x6k5Ere0VIzV4rkbl6/
	WYWCbu8CZMXLSEwcrz02c14gI2wSIKlZYe5ihn1u7XXGXW3YCfyT9Do=
X-Received: by 2002:a05:620a:2591:b0:93b:d7a3:45d4 with SMTP id
 af79cd13be357-93ebd29c0bcmr1838496485a.61.1791862169689; Mon, 12 Oct 2026
 20:29:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20261010142247.99223-1-physicalmtea@gmail.com>
 <20261010142247.99223-3-physicalmtea@gmail.com> <as1b8+vIy8K8J5cN@devvm29614.prn0.facebook.com>
In-Reply-To: <as1b8+vIy8K8J5cN@devvm29614.prn0.facebook.com>
From: Jia Jia <physicalmtea@gmail.com>
Date: Tue, 13 Oct 2026 11:28:53 +0800
X-Gm-Features: AclHuK8y1cO0AT-SrEL4DpgMypGTtpHkPFcgXXXujBQ_ReOHft-UeQLoN7blnMU
Message-ID: <CAJwVaM+Mht=DiODUJHzokkpGMjcBW9caHh6+Em1+-J-C-_25Yw@mail.gmail.com>
Subject: Re: [PATCH net-next v2 2/5] vsock/virtio: amortize RX socket locking
 for stream packets
To: Bobby Eshleman <bobbyeshleman@gmail.com>
Cc: stefanha@redhat.com, sgarzare@redhat.com, netdev@vger.kernel.org, 
	virtualization@lists.linux.dev, kvm@vger.kernel.org, mst@redhat.com, 
	jasowangio@gmail.com, eperezma@redhat.com, xuanzhuo@linux.alibaba.com, 
	davem@davemloft.net, edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com, 
	horms@kernel.org, linux-kernel@vger.kernel.org, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

>
> On Sat, Oct 10, 2026 at 10:22:44PM +0800, Jia Jia wrote:
> > The virtio-vsock RX worker currently acquires and releases the socket lock
> > for every received packet. Keep the lock held while processing a bounded
> > run of packets that belongs to the same socket.
> >
> > Only ordinary RW packets for an established STREAM socket whose transport
> > and protocol remain unchanged are eligible. Control packets, SEQPACKET
> > traffic, state or transport changes, malformed packets, and sockets whose
> > protocol has been replaced end the active batch and retain their existing
> > handling.
> >
> > Serialize the initial eligibility check with sk_callback_lock because
> > sockmap removal restores the protocol without taking the socket lock.
> >
> > Limit each batch to 64 packets or 64KB of payload, bounding the work under
> > one socket lock. Keep the lookup reference until the batch finishes.
> >
> > Keep a batch only while another skb metadata charge fits in the receive
> > buffer. Share this predicate with virtio_transport_inc_rx_pkt(). When an
> > enqueued skb consumes the final metadata slot, finish the batch and release
> > the socket lock before processing another packet, restoring the reader's
> > scheduling opportunity from the per-packet path.
> >
> > The virtqueue callback remains a queue_work() callback. Batching runs only
> > in the process-context RX worker.
> >
> > Introduce virtio_transport_rx_batch_finish() to tear down the batch and
> > release the socket lock and lookup reference.
> >
> > Signed-off-by: Jia Jia <physicalmtea@gmail.com>
> > ---
> >  include/linux/virtio_vsock.h            |  11 ++
> >  net/vmw_vsock/virtio_transport.c        |  29 ++++-
> >  net/vmw_vsock/virtio_transport_common.c | 147 +++++++++++++++++++++++-
> >  3 files changed, 183 insertions(+), 4 deletions(-)
> >
> > diff --git a/include/linux/virtio_vsock.h b/include/linux/virtio_vsock.h
> > index f91704731057..26dde6909c4e 100644
> > --- a/include/linux/virtio_vsock.h
> > +++ b/include/linux/virtio_vsock.h
> > @@ -282,6 +282,17 @@ void virtio_transport_destruct(struct vsock_sock *vsk);
> >
> >  void virtio_transport_recv_pkt(struct virtio_transport *t,
> >                              struct sk_buff *skb, struct net *net);
> > +
> > +struct virtio_transport_rx_batch {
> > +     struct sock *sk;
> > +     unsigned int pkts;
> > +     size_t bytes;
> > +};
> > +
> > +void virtio_transport_recv_pkt_batch(struct virtio_transport *t,
> > +                                  struct sk_buff *skb, struct net *net,
> > +                                  struct virtio_transport_rx_batch *batch);
> > +void virtio_transport_rx_batch_finish(struct virtio_transport_rx_batch *batch);
> >  void virtio_transport_inc_tx_pkt(struct virtio_vsock_sock *vvs, struct sk_buff *skb);
> >  u32 virtio_transport_get_credit(struct virtio_vsock_sock *vvs, u32 wanted);
> >  void virtio_transport_put_credit(struct virtio_vsock_sock *vvs, u32 credit);
> > diff --git a/net/vmw_vsock/virtio_transport.c b/net/vmw_vsock/virtio_transport.c
> > index 4f9aa9c4c3aa..ef076732158d 100644
> > --- a/net/vmw_vsock/virtio_transport.c
> > +++ b/net/vmw_vsock/virtio_transport.c
> > @@ -629,8 +629,16 @@ virtio_transport_seqpacket_allow(struct vsock_sock *vsk, u32 remote_cid)
> >       return seqpacket_allow;
> >  }
> >
> > +/*
> > + * Keep a bounded run of packets for one socket under a single socket lock.
> > + * Limit packet count and payload size to bound the work done while locked.
> > + */
> > +#define VIRTIO_TRANSPORT_RX_BATCH_MAX_PKTS   64
> > +#define VIRTIO_TRANSPORT_RX_BATCH_MAX_BYTES  (64 * 1024)
>
> Why both? Seems like MAX_PKTS would sufficiently bound the lock hold
> time.
>
> > +
> >  static void virtio_transport_rx_work(struct work_struct *work)
> >  {
> > +     struct virtio_transport_rx_batch batch = {};
> >       struct virtio_vsock *vsock =
> >               container_of(work, struct virtio_vsock, rx_work);
> >       struct virtqueue *vq;
> > @@ -666,6 +674,7 @@ static void virtio_transport_rx_work(struct work_struct *work)
> >                       /* Drop short/long packets */
> >                       if (unlikely(len < sizeof(*hdr) ||
> >                                    len > virtio_vsock_skb_len(skb))) {
> > +                             virtio_transport_rx_batch_finish(&batch);
> >                               kfree_skb(skb);
> >                               continue;
> >                       }
> > @@ -673,6 +682,7 @@ static void virtio_transport_rx_work(struct work_struct *work)
> >                       hdr = virtio_vsock_hdr(skb);
> >                       payload_len = le32_to_cpu(hdr->len);
> >                       if (unlikely(payload_len > len - sizeof(*hdr))) {
> > +                             virtio_transport_rx_batch_finish(&batch);
> >                               kfree_skb(skb);
> >                               continue;
> >                       }
> > @@ -680,16 +690,33 @@ static void virtio_transport_rx_work(struct work_struct *work)
> >                       if (payload_len)
> >                               virtio_vsock_skb_put(skb, payload_len);
> >
> > +                     if (batch.sk &&
> > +                         payload_len > VIRTIO_TRANSPORT_RX_BATCH_MAX_BYTES -
> > +                                       batch.bytes) {
> > +                             virtio_transport_rx_batch_finish(&batch);
> > +                     }
> > +
> >                       virtio_transport_deliver_tap_pkt(skb);
> >
> >                       /* Force virtio-transport into global mode since it
> >                        * does not yet support local-mode namespacing.
> >                        */
> > -                     virtio_transport_recv_pkt(&virtio_transport, skb, NULL);
> > +                     virtio_transport_recv_pkt_batch(&virtio_transport, skb, NULL,
> > +                                                     &batch);
> > +
> > +                     if (batch.sk) {
> > +                             batch.pkts++;
> > +                             batch.bytes += payload_len;
> > +                             if (batch.pkts >= VIRTIO_TRANSPORT_RX_BATCH_MAX_PKTS ||
> > +                                 batch.bytes >= VIRTIO_TRANSPORT_RX_BATCH_MAX_BYTES) {
> > +                                     virtio_transport_rx_batch_finish(&batch);
>
> I'm not fundamentally opposed to the batch struct, but I wonder if its
> needed?

With the byte limit retained, the batch still needs to carry the
socket and both counters across calls. A batch may also be finished
inside the receive helper, so
keeping that state together avoids having the worker maintain a
separate counter that can get out of sync. The later notification
patches add their pending state to the
same object as well, so I would prefer to keep the batch struct.

> If we can get rid of BATCH_MAX_BYTES, then we only need to do
> pkts++ in a local var, and can pass an &sk ptr-ptr to
> virtio_transport_recv_pkt_batch()?
>

My thinking was that the two limits bound different things. The
64-packet limit bounds per-packet work for small packets, while the
64K limit bounds how much data can
be queued while the reader cannot acquire the socket lock. A single
packet can carry up to 64K, so a packet-only limit could let one batch
cover as much as 4M. Since
the receive buffer can be enlarged, I do not think the default 256K
buffer is a substitute for the byte limit. I would prefer to keep
both.

> Best,
> Bobby
>
> > +                             }
> > +                     }
> >               }
> >       } while (!virtqueue_enable_cb(vq));
> >
> >  out:
> > +     virtio_transport_rx_batch_finish(&batch);
> >       if (vsock->rx_buf_nr < vsock->rx_buf_max_nr / 2)
> >               virtio_vsock_rx_fill(vsock);
> >  out_nofill:
> > diff --git a/net/vmw_vsock/virtio_transport_common.c b/net/vmw_vsock/virtio_transport_common.c
> > index e3e75e59896f..a73e37b3fa62 100644
> > --- a/net/vmw_vsock/virtio_transport_common.c
> > +++ b/net/vmw_vsock/virtio_transport_common.c
> > @@ -576,10 +576,16 @@ virtio_transport_collapse_rx_queue(struct virtio_vsock_sock *vvs,
> >       skb_queue_splice(&new_queue, &vvs->rx_queue);
> >  }
> >
> > +static bool
> > +virtio_transport_rx_skb_has_headroom(struct virtio_vsock_sock *vvs)
> > +{
> > +     return (u64)(skb_queue_len(&vvs->rx_queue) + 1) * SKB_TRUESIZE(0) <=
> > +             vvs->buf_alloc;
> > +}
> > +
> >  static bool virtio_transport_inc_rx_pkt(struct virtio_vsock_sock *vvs,
> >                                       u32 len)
> >  {
> > -     u64 skb_overhead = (skb_queue_len(&vvs->rx_queue) + 1) * SKB_TRUESIZE(0);
> >
> >       /* Allow at most buf_alloc * 2 total budget (payload + overhead),
> >        * similar to how SO_RCVBUF is doubled to reserve space for sk_buff
> > @@ -588,7 +594,7 @@ static bool virtio_transport_inc_rx_pkt(struct virtio_vsock_sock *vvs,
> >        * queue growth.
> >        */
> >       if ((u64)vvs->buf_used + len > vvs->buf_alloc ||
> > -         skb_overhead > vvs->buf_alloc)
> > +         !virtio_transport_rx_skb_has_headroom(vvs))
> >               return false;
> >
> >       vvs->rx_bytes += len;
> > @@ -1834,10 +1840,28 @@ struct virtio_transport_rx_pkt_ctx {
> >       struct net *net;
> >       const struct sockaddr_vm *src;
> >       const struct sockaddr_vm *dst;
> > +     bool *batchable;
> >  };
> >
> > +static bool
> > +virtio_transport_recv_pkt_batchable(struct virtio_transport *t,
> > +                                 struct sock *sk)
> > +{
> > +     struct vsock_sock *vsk = vsock_sk(sk);
> > +     struct virtio_vsock_sock *vvs = vsk->trans;
> > +
> > +     return sk->sk_state == TCP_ESTABLISHED &&
> > +            sk->sk_type == SOCK_STREAM &&
> > +            READ_ONCE(sk->sk_prot) == sk->sk_prot_creator &&
> > +            !sock_flag(sk, SOCK_DONE) &&
> > +            vsk->transport == &t->transport &&
> > +            vvs && virtio_transport_rx_skb_has_headroom(vvs);
> > +}
> > +
> >  /*
> > - * The caller holds sk's socket lock and must free skb if this returns true.
> > + * The caller holds sk's socket lock.  Set @batchable if the socket can remain
> > + * locked for another ordinary STREAM/RW packet.  Return true if the caller
> > + * must free @skb.
> >   */
> >  static bool
> >  virtio_transport_recv_pkt_locked(struct virtio_transport *t,
> > @@ -1850,6 +1874,9 @@ virtio_transport_recv_pkt_locked(struct virtio_transport *t,
> >       struct net *net = ctx->net;
> >       bool space_available;
> >
> > +     if (ctx->batchable)
> > +             *ctx->batchable = false;
> > +
> >       /* Check after acquiring the socket lock. Listener sockets accept packets
> >        * from any source and are not assigned to a transport.
> >        */
> > @@ -1891,6 +1918,9 @@ virtio_transport_recv_pkt_locked(struct virtio_transport *t,
> >               break;
> >       }
> >
> > +     if (ctx->batchable)
> > +             *ctx->batchable = virtio_transport_recv_pkt_batchable(t, sk);
> > +
> >       return false;
> >  }
> >
> > @@ -1941,6 +1971,117 @@ void virtio_transport_recv_pkt(struct virtio_transport *t,
> >  }
> >  EXPORT_SYMBOL_GPL(virtio_transport_recv_pkt);
> >
> > +/*
> > + * Finish the RX batch.
> > + * For a non-empty batch, the caller must hold the socket lock acquired with
> > + * lock_sock(). This function releases the lock and the batch's lookup
> > + * reference.
> > + * An empty batch is a no-op.
> > + */
> > +void virtio_transport_rx_batch_finish(struct virtio_transport_rx_batch *batch)
> > +{
> > +     struct sock *sk = batch->sk;
> > +
> > +     batch->sk = NULL;
> > +     batch->pkts = 0;
> > +     batch->bytes = 0;
> > +
> > +     if (!sk)
> > +             return;
> > +
> > +     release_sock(sk);
> > +     sock_put(sk);
> > +}
> > +EXPORT_SYMBOL_GPL(virtio_transport_rx_batch_finish);
> > +
> > +void virtio_transport_recv_pkt_batch(struct virtio_transport *t,
> > +                                  struct sk_buff *skb, struct net *net,
> > +                                  struct virtio_transport_rx_batch *batch)
> > +{
> > +     struct virtio_vsock_hdr *hdr = virtio_vsock_hdr(skb);
> > +     struct virtio_transport_rx_pkt_ctx ctx;
> > +     struct sockaddr_vm src, dst;
> > +     bool batchable, start_batch;
> > +     struct sock *sk;
> > +     bool free_pkt;
> > +
> > +     /* Only STREAM/RW packets can share a socket lock. */
> > +     if (le16_to_cpu(hdr->type) != VIRTIO_VSOCK_TYPE_STREAM ||
> > +         le16_to_cpu(hdr->op) != VIRTIO_VSOCK_OP_RW) {
> > +             virtio_transport_rx_batch_finish(batch);
> > +             virtio_transport_recv_pkt(t, skb, net);
> > +             return;
> > +     }
> > +
> > +     virtio_transport_recv_pkt_init_addrs(skb, &src, &dst);
> > +     virtio_transport_trace_recv_pkt(skb, &src, &dst);
> > +
> > +     sk = virtio_transport_recv_pkt_find_socket(skb, &src, &dst, net);
> > +     if (!sk) {
> > +             virtio_transport_rx_batch_finish(batch);
> > +             (void)virtio_transport_reset_no_sock(t, skb, net);
> > +             kfree_skb(skb);
> > +             return;
> > +     }
> > +
> > +     if (!skb_set_owner_sk_safe(skb, sk)) {
> > +             WARN_ONCE(1, "receiving vsock socket has sk_refcnt == 0\n");
> > +             virtio_transport_rx_batch_finish(batch);
> > +             kfree_skb(skb);
> > +             return;
> > +     }
> > +
> > +     if (batch->sk && batch->sk != sk) {
> > +             /* Never acquire a second socket lock. */
> > +             virtio_transport_rx_batch_finish(batch);
> > +     }
> > +
> > +     if (batch->sk == sk) {
> > +             /* Keep the batch reference; drop this packet's lookup reference. */
> > +             sock_put(sk);
> > +             ctx = (struct virtio_transport_rx_pkt_ctx) {
> > +                     .net = net,
> > +                     .src = &src,
> > +                     .dst = &dst,
> > +                     .batchable = &batchable,
> > +             };
> > +             free_pkt = virtio_transport_recv_pkt_locked(t, skb, sk, &ctx);
> > +             if (!batchable)
> > +                     virtio_transport_rx_batch_finish(batch);
> > +             if (free_pkt)
> > +                     kfree_skb(skb);
> > +             return;
> > +     }
> > +
> > +     lock_sock(sk);
> > +     /*
> > +      * Sockmap removal restores the native protocol under sk_callback_lock.
> > +      * Serialize this initial eligibility check with that update.
> > +      */
> > +     read_lock_bh(&sk->sk_callback_lock);
> > +     start_batch = virtio_transport_recv_pkt_batchable(t, sk);
> > +     read_unlock_bh(&sk->sk_callback_lock);
> > +
> > +     ctx = (struct virtio_transport_rx_pkt_ctx) {
> > +             .net = net,
> > +             .src = &src,
> > +             .dst = &dst,
> > +             .batchable = start_batch ? &batchable : NULL,
> > +     };
> > +     free_pkt = virtio_transport_recv_pkt_locked(t, skb, sk, &ctx);
> > +     if (start_batch && batchable) {
> > +             /* Keep the lookup reference until the batch is released. */
> > +             batch->sk = sk;
> > +             return;
> > +     }
> > +
> > +     release_sock(sk);
> > +     sock_put(sk);
> > +     if (free_pkt)
> > +             kfree_skb(skb);
> > +}
> > +EXPORT_SYMBOL_GPL(virtio_transport_recv_pkt_batch);
> > +
> >  /* Remove skbs found in a queue that have a vsk that matches.
> >   *
> >   * Each skb is freed.
> > --
> > 2.34.1
