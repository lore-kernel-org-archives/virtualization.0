Received: from mail-qk1-f175.google.com (mail-qk1-f175.google.com [209.85.222.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 280DA3E3163
	for <virtualization@lists.linux.dev>; Tue, 13 Oct 2026 03:31:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.222.175
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791862290; cv=pass; b=LSTc1IpjfsnKgTT11GU8DjSzhj3QY6DHVJC9rUguSz2hEDMHxoFlUf2Apo0Hcnyd7/b6TuzSO3vORUc1ce70BfRLgzKTMFd7LwRmLrLkEg5N6VAoHogHm34eLdBYpAPrNmS71EJD/KhEOUvbnfuZv6lKm/6hzP9X664TsJlN6v0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791862290; c=relaxed/simple;
	bh=zCSEKIAPKVwVSGY4GyE3kxLa1knCjzTA3Y/jvMzWxiw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pL/NjQ2lAdwAc1Be7CD0huL0SRpr/3AIHtIlyCvKPpQu6/HkudxWLc9W5UW2Sz1Ta10mtArbMzfexF1tBYe4krlQpetjM37NgqPtLLPpLT9lmw5r22GdtI03tlfKmckHN/zDZvjFg5kUe+SUa2lNXJIFUajlARyYyRzgaq67oQI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=diCdf6RR; arc=pass smtp.client-ip=209.85.222.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="diCdf6RR"
Received: by mail-qk1-f175.google.com with SMTP id af79cd13be357-93e55db58cfso256606485a.1
        for <virtualization@lists.linux.dev>; Mon, 12 Oct 2026 20:31:28 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791862288; cv=none;
        d=google.com; s=arc-20260327;
        b=O4vuvtOUHsh0X8QmNmDXOOhxKjQ3d2Kr3noteD2mvmDoTSZcoGNs4grVh/aaH3mRsk
         RkazLUVNO1ZBJJdNu806AnN/7aC+G2n998i1qoNUWkz+5dUk+QHPNq3rH2LtI9diRLqe
         wi6B/dvZC7c055rBSKPN6ud0wt7u94MN/HREgnIQtZ61EOSYrtflSJQEnJgAwxEXn1vQ
         b+ShB3UHCW1+u5b1UB4QH2K431W8VO/8vCZomH/EU2rYikvAkgP+u1dvQATdsbXYWiD5
         e/dFvzGZZyOSGd+kp2XxjPa+kQZ5psWPvn1CMBpTpcXBITKwZ5SJlHgNeTp6ZeW1AB5l
         ZYUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=oKth/1jAUk8y73FB5cD2ux1SjiU3FjqeBdt11b7UR8k=;
        fh=5/9VRCkzgePBeeBhl+kNKidl91lwCfZNoxiaH5ggp6k=;
        b=stP1R5clX1eYDGuWAHi3JUXzcaVyakpYlcwj3QhuQoQqXV5dPeJjB80FD+CmXwgIcD
         hESlxVdCwQv39Pbqw58/kilfEK9ot/JRJWZb67iQ0ONlj6TlZCmuKfxMCnr/EpanVjUI
         pm+N5vrXxafR540DYg2yYIyMXBd5ZlHK8H64gwRtzzwFESUTwacw/gnIrRCGkgmncBOp
         Rr7fzwKA0TJgGNoNRJmWKBlPo4w9ECyl016jv9jtSu7UIdFBdFbU5fWsbzJfw1XRMa2P
         Z+hHBi5up8mwtE30v67/RYtTDlvqKomGX9lHjIEBvnzSqpE/zisFYAUdYNQ4ENi6dWbG
         pFAg==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791862288; x=1792467088; darn=lists.linux.dev;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=oKth/1jAUk8y73FB5cD2ux1SjiU3FjqeBdt11b7UR8k=;
        b=diCdf6RRNXb0+CY0MMroNtnozNlYuc3lUOKLbAIiFdyWq6q7TQjXSegIPni2iEaChq
         Y6TPhd4HWQcXAlXPowkwlYTNLuN06eQWrvww+aaJn/3WjTCkyuWZCsc6BQz/+RwKxOTG
         ww0Xk6PEhHFnlOywM3p/xgp6e5g1KZ0rB8rvYqYkvemRvlOm6qEG21sG9ZKJfYAwADU2
         6YPtauUWx3I0i91cTlWxFVefq2+tTxWnhDlMjnV51ls7pGSqxIy7su15sXL7rw5QKvzz
         oiQy7lu00o2PSGFWQeScJlZpic8uHurUhM8wpZdH5p/H0ICJPnHhJeYbD/+Q72xDlIV7
         oXzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791862288; x=1792467088;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=oKth/1jAUk8y73FB5cD2ux1SjiU3FjqeBdt11b7UR8k=;
        b=v8vWkVpm7q5JUUuXsII7CqWbFsW55y8QNF3N4qyU7ViZGuxHD130JTqvRm9fJlS+wC
         h9HhGd7XYC/EN9K4uw7PWkuR3uHhufqtNjM/1tZMIjeWj/Xb3XUDZrupeAXVwynHNHZH
         fUp4AoTH8PLBl5DqHo2U2EaXr/iBAv40rPedujrZx3c8klz11oAKMQ7p/CAmCIrUXcAv
         /wbhx791o+i9niI6JI/iW6Qlwxf0BAT5QdDLjTBXjNc4SbDiJYPk7Js0f9bQ/pOKEkYE
         COmxT9zZbrHJhNYyd+9K59xEEx3HAuWEHg8ibPB73oFTfcHxTCljjcmbDCAnEfFHPo8S
         e3HQ==
X-Forwarded-Encrypted: i=1; AKwUvBz2KD5LDWoeUmR7XWMdrBISXjM8mZCCQ7unNwiEfeyE+wdAkfYvEcV/x80+Iuc59hfaU54Y9xmcTDYnzqUgIA==@lists.linux.dev
X-Gm-Message-State: AFq9FYJSWzjq/259Rf8BwzxveGDgSwWKwh/h0kHbbwlUP4BUBwgDBaWg
	Md7mOc0aWQwi2I7+10aua1jsdPD5kSKwxw0mAZ69D+70MCEfgBH0bFAm7EDUORyfjPTa6I0oyxq
	1t45ANQ6wjpk5a4mYJmjztSbKo9Fv9KM=
X-Gm-Gg: AYBFou2sWRm+Vgb2v/fnwCnjpN3NI6diacpx1ca5Rmtf3ykneJTw3Kf36h5cIVH0Yeb
	S/UrD22J3hDIMyZRsyhlNtEh5/bsKrR/4Xc8vNVIT++0kPQkQLULAKHTz6ix5YiWfBqMEn9rFts
	E3OUXvKs1XuOyfeCk9bHoc1kLpBHI1s62Dd4LEnGz6rUIpP9ZXFxBtNszU9ldvICUutdOmLbf4E
	GlrEzM6AVtV3nU0hThgeJx37ycJZXSjxUjgjGU2PMONjWH2O9ZeIk5wI5WeWPMlNowDplVhqFuf
	fLWU2IDDLH/nH5K7tma2vZBVgO8P98hEbg+ggIn02mJX1S6IsPIWPNU=
X-Received: by 2002:a05:620a:44c8:b0:939:1222:b9f1 with SMTP id
 af79cd13be357-93ebcd2b3d1mr1818738285a.0.1791862287366; Mon, 12 Oct 2026
 20:31:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20261010142247.99223-1-physicalmtea@gmail.com>
 <20261010142247.99223-4-physicalmtea@gmail.com> <as1ciTHT2O40E/Uq@devvm29614.prn0.facebook.com>
In-Reply-To: <as1ciTHT2O40E/Uq@devvm29614.prn0.facebook.com>
From: Jia Jia <physicalmtea@gmail.com>
Date: Tue, 13 Oct 2026 11:30:51 +0800
X-Gm-Features: AclHuK82x5TMJTU3P4uV1cGGZ695rdTmYCG-meYcWlEm97kH4rrDUYXGHuCS2tM
Message-ID: <CAJwVaMJxgjbEXk8LW+wYbmfPYA2anNcRtitB=G1=kNv-WXm4TQ@mail.gmail.com>
Subject: Re: [PATCH net-next v2 3/5] vsock/virtio: reuse same-flow socket
 lookup in RX batches
To: Bobby Eshleman <bobbyeshleman@gmail.com>
Cc: stefanha@redhat.com, sgarzare@redhat.com, netdev@vger.kernel.org, 
	virtualization@lists.linux.dev, kvm@vger.kernel.org, mst@redhat.com, 
	jasowangio@gmail.com, eperezma@redhat.com, xuanzhuo@linux.alibaba.com, 
	davem@davemloft.net, edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com, 
	horms@kernel.org, linux-kernel@vger.kernel.org, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

>
> On Sat, Oct 10, 2026 at 10:22:45PM +0800, Jia Jia wrote:
> > An RX lock batch still looks up the socket for every packet and takes a
> > temporary lookup reference, even though the batch already holds a reference
> > to the locked socket.
> >
> > Record the network namespace and packet address tuple when a batch starts.
> > Reuse the batch socket for later STREAM/RW packets with the same tuple, and
> > release the batch before looking up a different flow.
> >
> > The cached path still traces every packet, takes an skb owner reference,
> > validates socket state, source and transport, updates credit, and runs the
> > receive state machine. Only the socket table lookup and its temporary
> > reference are skipped.
> >
> > Signed-off-by: Jia Jia <physicalmtea@gmail.com>
> > ---
> >  include/linux/virtio_vsock.h            |  3 ++
> >  net/vmw_vsock/virtio_transport_common.c | 58 +++++++++++++++----------
> >  2 files changed, 38 insertions(+), 23 deletions(-)
> >
> > diff --git a/include/linux/virtio_vsock.h b/include/linux/virtio_vsock.h
> > index 26dde6909c4e..d6528681e052 100644
> > --- a/include/linux/virtio_vsock.h
> > +++ b/include/linux/virtio_vsock.h
> > @@ -287,6 +287,9 @@ struct virtio_transport_rx_batch {
> >       struct sock *sk;
> >       unsigned int pkts;
> >       size_t bytes;
> > +     struct net *net;
> > +     struct sockaddr_vm src;
> > +     struct sockaddr_vm dst;
> >  };
> >
> >  void virtio_transport_recv_pkt_batch(struct virtio_transport *t,
> > diff --git a/net/vmw_vsock/virtio_transport_common.c b/net/vmw_vsock/virtio_transport_common.c
> > index e67dfcaa279c..73e5c7dfe8b4 100644
> > --- a/net/vmw_vsock/virtio_transport_common.c
> > +++ b/net/vmw_vsock/virtio_transport_common.c
> > @@ -1977,6 +1977,7 @@ void virtio_transport_rx_batch_finish(struct virtio_transport_rx_batch *batch)
> >       batch->sk = NULL;
> >       batch->pkts = 0;
> >       batch->bytes = 0;
> > +     batch->net = NULL;
> >
> >       if (!sk)
> >               return;
> > @@ -2008,6 +2009,37 @@ void virtio_transport_recv_pkt_batch(struct virtio_transport *t,
> >       virtio_transport_recv_pkt_init_addrs(skb, &src, &dst);
> >       virtio_transport_trace_recv_pkt(skb, &src, &dst);
> >
> > +     if (batch->sk) {
> > +             if (batch->net == net &&
> > +                 vsock_addr_equals_addr(&batch->src, &src) &&
> > +                 vsock_addr_equals_addr(&batch->dst, &dst) &&
> > +                 virtio_transport_recv_pkt_batchable(t, batch->sk)) {
> > +                     sk = batch->sk;
> > +                     if (!skb_set_owner_sk_safe(skb, sk)) {
> > +                             WARN_ONCE(1, "receiving vsock socket has sk_refcnt == 0\n");
> > +                             virtio_transport_rx_batch_finish(batch);
> > +                             kfree_skb(skb);
> > +                             return;
> > +                     }
> > +
> > +                     ctx = (struct virtio_transport_rx_pkt_ctx) {
> > +                             .net = net,
> > +                             .src = &src,
> > +                             .dst = &dst,
> > +                             .batchable = &batchable,
> > +                     };
> > +                     free_pkt = virtio_transport_recv_pkt_locked(t, skb, sk, &ctx);
> > +
> > +                     if (!batchable)
> > +                             virtio_transport_rx_batch_finish(batch);
> > +                     if (free_pkt)
> > +                             kfree_skb(skb);
> > +                     return;
> > +             }
> > +
> > +             virtio_transport_rx_batch_finish(batch);
> > +     }
> > +
> >       sk = virtio_transport_recv_pkt_find_socket(skb, &src, &dst, net);
> >       if (!sk) {
> >               virtio_transport_rx_batch_finish(batch);
> > @@ -2018,33 +2050,10 @@ void virtio_transport_recv_pkt_batch(struct virtio_transport *t,
> >
> >       if (!skb_set_owner_sk_safe(skb, sk)) {
> >               WARN_ONCE(1, "receiving vsock socket has sk_refcnt == 0\n");
> > -             virtio_transport_rx_batch_finish(batch);
> >               kfree_skb(skb);
> >               return;
> >       }
> >
> > -     if (batch->sk && batch->sk != sk) {
> > -             /* Never acquire a second socket lock. */
> > -             virtio_transport_rx_batch_finish(batch);
> > -     }
> > -
> > -     if (batch->sk == sk) {
> > -             /* Keep the batch reference; drop this packet's lookup reference. */
> > -             sock_put(sk);
> > -             ctx = (struct virtio_transport_rx_pkt_ctx) {
> > -                     .net = net,
> > -                     .src = &src,
> > -                     .dst = &dst,
> > -                     .batchable = &batchable,
> > -             };
> > -             free_pkt = virtio_transport_recv_pkt_locked(t, skb, sk, &ctx);
> > -             if (!batchable)
> > -                     virtio_transport_rx_batch_finish(batch);
> > -             if (free_pkt)
> > -                     kfree_skb(skb);
> > -             return;
> > -     }
> > -
>
> Not sure I love adding code and then removing it in the same series.
> Seems like these are asking to be squashed?
>

I'll fold patch 3 into patch 2 so batching is introduced with
same-flow lookup reuse from the start.

> >       lock_sock(sk);
> >       /*
> >        * Sockmap removal restores the native protocol under sk_callback_lock.
> > @@ -2063,6 +2072,9 @@ void virtio_transport_recv_pkt_batch(struct virtio_transport *t,
> >       free_pkt = virtio_transport_recv_pkt_locked(t, skb, sk, &ctx);
> >       if (start_batch && batchable) {
> >               /* Keep the lookup reference until the batch is released. */
> > +             batch->net = net;
> > +             batch->src = src;
> > +             batch->dst = dst;
>
> Similar to my comment in the other patch, seems these are all in sk
> already?
>

For the batch cache, yes. I'll use the locked socket state for the
same-flow check. The packet values still need to be passed to the
locked receive path for source validation and reset handling.

> Best,
> Bobby
