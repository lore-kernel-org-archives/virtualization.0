Received: from mail-qk1-f179.google.com (mail-qk1-f179.google.com [209.85.222.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B2C93D4108
	for <virtualization@lists.linux.dev>; Sun, 18 Oct 2026 04:56:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.222.179
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792299376; cv=pass; b=kqKuWr4NZmkkUv/1yluzqw+TuYnZPdt7G2wArc/U99Ihan7R7N+eOeC3qCCEYREuxIiQ0VRfI3gIqeb3xLinfdWelUz9Iu/ANapwLUt8lAworr4HOuJhwlyTLzr433xPBsaBzJEzMuHOToa7Fbv0Yj721r8n+fEzKxVdKfbclpQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792299376; c=relaxed/simple;
	bh=MUEoAola7xyeL8jdr8fQAQfZf/diWg/Fw9X+u3QZMEM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=X4V8m7p+dgxwoL+suwWKlysymmklzYZcEwyNmtgaMnCi7mCaMa5k2ziT+b/R0VUoLX3iCCfSVxx62UJ0Jph1z1jGbF2aR9t+YKC1SU1HrHeH7yGlcejs7P5CNG3fv6Kblucp+EOoxyrY4c6/a752+j2QM9BWo6qxDy/oFu/LP/I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XJvQX+8S; arc=pass smtp.client-ip=209.85.222.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XJvQX+8S"
Received: by mail-qk1-f179.google.com with SMTP id af79cd13be357-93f079a63b8so105751785a.3
        for <virtualization@lists.linux.dev>; Sat, 17 Oct 2026 21:56:14 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792299374; cv=none;
        d=google.com; s=arc-20260327;
        b=cJMigzHUfTxobdCcqVAQekXNusohvrbfA1+SdQx/2rK7oZGDgrGF74jqypRmJSQenE
         g7FubhZBg/xXPdE7zJkxCJuPS+UWTcA7uh26FS+sLXvfhrX6SrD3eN5TDwLbnRsMJY5y
         WK3DICpfF6yOwFtaYH7SXSgcA01uRw4/Wu5F65mWF9p3reuXJRKOp+CmYgisCBj8FKg6
         SY2bL9q5rTc7ek9DPafC1hhUnnEc+xMcOgiGuzIDNbPq4AJud5T1Os7EGtfx4ITWBHjQ
         ZoRJLqkF0GRe5KIYD+IHEY70eXv85MPNiuy57j4ygP/6laWroMQ7UEWi3iwoQCU2JpKR
         7w8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=2mQWxR6q9iheemcDETg0gh7emahGPmRGuMQCH/R1v9s=;
        fh=X0Hg6teKPrkg3OEnX4x6BqKnym4cSvi7o7uBVZhfeRo=;
        b=AoYwq1cUvorTHhEggFfzoxFKGjM1J69gASy0/xrFVMoJ+ZEK6dZREctsjM+1B2IsTa
         0UDsF2vXVMXMpbJ91oOyY2U1JKGeNPDrd0K14CaFtJ2Q4vUtOExkA1M3nDKpKcPn0mSl
         wjmKHYijcy9NoeHxnnOuZ24Ur++dPe8AZMV3ib/u2wzPZPgKFJhkiCkpG2R3ECk7i8H7
         QdJUA2t27HM4KyR/eM+HU0OhbkEB54Ykru4F5l5iPQwcrMMLWz0lr5e882iNUM8Zn/yX
         wx5dgNXCx+bjhOxQyGQ9bVn9Rjrq0ZpEIFI4ZPy41IO69w4hm7yE5zDpPVR20orQr/3+
         5uuw==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792299374; x=1792904174; darn=lists.linux.dev;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=2mQWxR6q9iheemcDETg0gh7emahGPmRGuMQCH/R1v9s=;
        b=XJvQX+8SvgxCce9K5AZzoo1CDGvbWXynQ4eIpV9klqZ8t95St685qHI4HzWIrUCVOz
         em3bNQk/7xuC7f0run+AcNqw7DoNg9oRIz8bS/7fmkr13i06U0zZ7ci5BpMkP//OB4Wi
         IqvhjbM5IsRDe08uEm8K/10qjNvAQ38QkmRNOZ7DYEVuEBAoQO7W0ahFsV+YiggnygAE
         T8QXzmwdawyG78zIL0gMGAQAtPalaY+/T8lgppfUaLBeeIMopadtbw/LH4wn+rJkhemV
         iYeVwaonXDTgQPZbRONnggsI6FW6M4yS9Bqrh+89GtNFp8ZqpE3y+Aa+gyImFRYP05FF
         WjxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792299374; x=1792904174;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=2mQWxR6q9iheemcDETg0gh7emahGPmRGuMQCH/R1v9s=;
        b=mCBPy4QQd9iVs2r50vYRCYYVdbOE4txrVRBXerd8akE5ecRoTnFdZi7mrkGEKCIbNg
         YOmGxAWzJZsVYtGaBt6Xbx+HpPza4UcNkhufvOV6tkRW6TONq2viFZo7YZw2ADrhwWY9
         wvLLrY8xeSot8J4sFS7BT/r4j8VaWauHJbgoqX4jyX9cF7hzrqMPs4FUMai6Rn4KR53e
         Tc+qUvNXG15ay0b2FAQltWml6CtXrcDuzcny/0xyE23p4TjGocxt2DbUt+gW0RT/xLPO
         5NgbKMIY+Ibpy7MrYYP3viVDklvKCQ44rfkuro5jB2XvZcqLaeYPu9U0ZWA4pfWQMFz9
         9vvQ==
X-Forwarded-Encrypted: i=1; AKwUvBxZjUenr/04fEy9v4wrFfU+wZRSk4osKPpl9WSi4kZlEtqAmptXcqgmwHNUx8npa8ARbSDWhv6xt5aNBQ9f/Q==@lists.linux.dev
X-Gm-Message-State: AFq9FYIeSIml9g3lKF+6T1tb9Co6d/bKPL/3BUiu70qldZR+cUkVY333
	xmvdu+2lKAvIJJaouNKM20soptbFks9u08MDn1jMiWaRNOR+aNNYMjUGEWuAOHKCUg3ruRBVYr8
	F+/gir50IvSC8oBq0rNkdrmI6BoS5+YI=
X-Gm-Gg: AYBFou2aSPvpOEmYNdYRhn8+QX6HqzpNohED5q2QFVDOsiuRfcLdtvjVkP2UNJz69gk
	EPMFqD2gOIc5P6A6+oPC1AAGqBs4kdyVyVUQUm4hasiUBM+D7daZQsMv4bHMfHeXJHZYFE68H1s
	B7FtZWrerbIjE0aD9mJZ0MM22nTTKpiL/GjO526mkB83P5eXXm54ZCm9Xbj1ajlv93iwE5VobX5
	Mhz9Vyyqsm1iPYgXtmMD5MCWRi4Ln0DJ7W8y7XZB96bCVOnvQmpiSjYn1niXOJd9VegQ1kjQXYV
	e9FYK8iU08QL1/t4irWl50R8bvkxc9aJunr9sPAjdICfv8W/QkVZeFs=
X-Received: by 2002:a05:620a:319a:b0:93c:5958:9de9 with SMTP id
 af79cd13be357-93f29d0113dmr748988685a.33.1792299372805; Sat, 17 Oct 2026
 21:56:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20261014115640.184286-1-physicalmtea@gmail.com>
 <20261014115640.184286-5-physicalmtea@gmail.com> <atI3neoHXhgiEpYJ@sgarzare-redhat>
In-Reply-To: <atI3neoHXhgiEpYJ@sgarzare-redhat>
From: Jia Jia <physicalmtea@gmail.com>
Date: Sun, 18 Oct 2026 12:55:35 +0800
X-Gm-Features: AclHuK8ZjEQAvoPM-RXyUG0NK0crmCQ-P3Tq8bClk6mg9VpnN4cPAvs-UmxgqI4
Message-ID: <CAJwVaMLmMf1iyWmoZMAJuS2551DsSWSkcRsUVz3M5xi9AXWsWg@mail.gmail.com>
Subject: Re: [PATCH net-next v4 4/4] vsock/virtio: defer RX notifications
 until batch unlock
To: Stefano Garzarella <sgarzare@redhat.com>
Cc: stefanha@redhat.com, mst@redhat.com, jasowangio@gmail.com, 
	eperezma@redhat.com, xuanzhuo@linux.alibaba.com, davem@davemloft.net, 
	edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, 
	virtualization@lists.linux.dev, kvm@vger.kernel.org, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, bobbyeshleman@gmail.com
Content-Type: text/plain; charset="UTF-8"

>
> On Wed, Oct 14, 2026 at 07:56:40PM +0800, Jia Jia wrote:
> >An RX batch can make a socket readable while the worker still holds its
> >socket lock. Waking a blocking reader then only moves it to waiting for
> >the same lock.
> >
> >Record the existing low-watermark condition and notify once after
> >release_sock(). Move the coalesced write-space notification after the
> >unlock as well, since both callbacks wake sk_sleep(sk). Deliver
> >write-space before data-ready and keep the lookup reference until both
> >callbacks complete.
> >
> >As with write-space, save the initial sk_data_ready callback and batch only
> >while both saved callbacks remain installed. Sockets with replaced
> >callbacks retain their per-packet behavior.
> >
> >The existing psock-marker check also covers a concurrent sockmap attach:
> >at most the already admitted packet completes on the native path, and the
> >next packet ends the batch.
> >
> >Signed-off-by: Jia Jia <physicalmtea@gmail.com>
> >---
> > include/linux/virtio_vsock.h            |  1 +
> > include/net/af_vsock.h                  |  5 ++--
> > net/vmw_vsock/af_vsock.c                |  1 +
> > net/vmw_vsock/virtio_transport_common.c | 35 ++++++++++++++++++-------
> > 4 files changed, 31 insertions(+), 11 deletions(-)
> >
> >diff --git a/include/linux/virtio_vsock.h b/include/linux/virtio_vsock.h
> >index bf077ee0ded88..f1396ca3ad9b5 100644
> >--- a/include/linux/virtio_vsock.h
> >+++ b/include/linux/virtio_vsock.h
> >@@ -288,6 +288,7 @@ struct virtio_transport_rx_batch {
> >       unsigned int pkts;
> >       size_t bytes;
> >       bool write_space_pending;
> >+      bool data_ready_pending;
> > };
> >
> > void virtio_transport_recv_pkt_batch(struct virtio_transport *t,
> >diff --git a/include/net/af_vsock.h b/include/net/af_vsock.h
> >index 9a40960d10cbe..78bab5820f528 100644
> >--- a/include/net/af_vsock.h
> >+++ b/include/net/af_vsock.h
> >@@ -64,9 +64,10 @@ struct vsock_sock {
> >       bool sent_request;
> >       bool ignore_connecting_rst;
> >       /*
> >-       * Initial callback, used to identify replacements and deliver deferred
> >-       * write-space notifications.
> >+       * Initial callbacks, used to identify replacements and deliver deferred
> >+       * notifications.
> >        */
> >+      void (*default_data_ready)(struct sock *sk);
> >       void (*default_write_space)(struct sock *sk);
> >
> >       /* Protected by lock_sock(sk) */
> >diff --git a/net/vmw_vsock/af_vsock.c b/net/vmw_vsock/af_vsock.c
> >index fe7f49da6c4bc..f40659ec29df0 100644
> >--- a/net/vmw_vsock/af_vsock.c
> >+++ b/net/vmw_vsock/af_vsock.c
> >@@ -958,6 +958,7 @@ static struct sock *__vsock_create(struct net *net,
> >               sk->sk_type = type;
> >
> >       vsk = vsock_sk(sk);
> >+      vsk->default_data_ready = sk->sk_data_ready;
> >       vsk->default_write_space = sk->sk_write_space;
> >       vsock_addr_init(&vsk->local_addr, VMADDR_CID_ANY, VMADDR_PORT_ANY);
> >       vsock_addr_init(&vsk->remote_addr, VMADDR_CID_ANY, VMADDR_PORT_ANY);
> >diff --git a/net/vmw_vsock/virtio_transport_common.c b/net/vmw_vsock/virtio_transport_common.c
> >index f4b5f0230493e..8b62b789b71c5 100644
> >--- a/net/vmw_vsock/virtio_transport_common.c
> >+++ b/net/vmw_vsock/virtio_transport_common.c
> >@@ -1588,7 +1588,8 @@ virtio_transport_recv_enqueue(struct vsock_sock *vsk,
> >
> > static int
> > virtio_transport_recv_connected(struct sock *sk,
> >-                              struct sk_buff *skb)
> >+                              struct sk_buff *skb,
> >+                              bool *data_ready_pending)
> > {
> >       struct virtio_vsock_hdr *hdr = virtio_vsock_hdr(skb);
> >       struct vsock_sock *vsk = vsock_sk(sk);
> >@@ -1607,7 +1608,13 @@ virtio_transport_recv_connected(struct sock *sk,
> >                       vsock_remove_sock(vsk);
> >                       break;
> >               }
> >-              vsock_data_ready(sk);
> >+              if (!data_ready_pending) {
> >+                      vsock_data_ready(sk);
> >+              } else if (!*data_ready_pending &&
> >+                         (vsock_stream_has_data(vsk) >= sk->sk_rcvlowat ||
> >+                          sock_flag(sk, SOCK_DONE))) {
> >+                      *data_ready_pending = true;
> >+              }
> >               return err;
> >       case VIRTIO_VSOCK_OP_CREDIT_REQUEST:
> >               virtio_transport_send_credit_update(vsk);
> >@@ -1820,6 +1827,7 @@ virtio_transport_recv_pkt_batchable(struct virtio_transport *t,
> >       return sk->sk_state == TCP_ESTABLISHED &&
> >              sk->sk_type == SOCK_STREAM &&
> >              READ_ONCE(sk->sk_prot) == sk->sk_prot_creator &&
> >+             READ_ONCE(sk->sk_data_ready) == vsk->default_data_ready &&
> >              READ_ONCE(sk->sk_write_space) == vsk->default_write_space &&
> >              !sock_flag(sk, SOCK_DONE) &&
> >              vsk->transport == &t->transport &&
> >@@ -1830,8 +1838,9 @@ virtio_transport_recv_pkt_batchable(struct virtio_transport *t,
> > /*
> >  * The caller holds sk's socket lock.  Set @batchable if the socket can remain
> >  * locked for another ordinary STREAM/RW packet.  When @batch is non-NULL,
> >- * record a default write-space notification for batch finish instead of
> >- * delivering it immediately.  Return true if the caller must free @skb.
> >+ * record default write-space and data-ready notifications for batch finish
> >+ * instead of delivering them immediately.  Return true if the caller must
> >+ * free @skb.
> >  */
> > static bool
> > virtio_transport_recv_pkt_locked(struct virtio_transport *t,
> >@@ -1883,7 +1892,9 @@ virtio_transport_recv_pkt_locked(struct virtio_transport *t,
> >               kfree_skb(skb);
> >               break;
> >       case TCP_ESTABLISHED:
> >-              virtio_transport_recv_connected(sk, skb);
> >+              virtio_transport_recv_connected(sk, skb,
> >+                                              batch ?
> >+                                              &batch->data_ready_pending : NULL);
> >               break;
> >       case TCP_CLOSING:
> >               virtio_transport_recv_disconnecting(sk, skb);
> >@@ -1957,27 +1968,33 @@ EXPORT_SYMBOL_GPL(virtio_transport_recv_pkt);
> > /*
> >  * Finish the RX batch.
> >  * For a non-empty batch, the caller holds the socket lock acquired with
> >- * lock_sock(). Deliver any deferred write-space notification while the lock
> >- * is held, then release the lock and the batch's lookup reference.
> >- * An empty batch is a no-op.
> >+ * lock_sock(). Release the lock, deliver any deferred write-space and
> >+ * data-ready notifications in that order, then drop the batch's lookup
> >+ * reference. An empty batch is a no-op.
> >  */
> > void virtio_transport_rx_batch_finish(struct virtio_transport_rx_batch *batch)
> > {
> >       bool write_space_pending = batch->write_space_pending;
> >+      bool data_ready_pending = batch->data_ready_pending;
> >       struct sock *sk = batch->sk;
> >
> >       batch->sk = NULL;
> >       batch->pkts = 0;
> >       batch->bytes = 0;
> >       batch->write_space_pending = false;
> >+      batch->data_ready_pending = false;
> >
> >       if (!sk)
> >               return;
> >
> >+      release_sock(sk);
> >+
>
> Why in the previous patch we release the socket after calling
> default_write_space() and now we are moving before?
>

My intention was to keep the two behavioral changes separately
testable. Patch 3 is a complete intermediate state: it coalesces
repeated sk_write_space()
notifications while preserving the existing under-lock callback
context. Patch 4 then adds data-ready coalescing and moves both
deferred notifications
after release_sock(). Patch 4 therefore builds on Patch 3 rather than fixing it.

> >       if (write_space_pending)
> >               vsock_sk(sk)->default_write_space(sk);
> >
> >-      release_sock(sk);
> >+      if (data_ready_pending)
> >+              vsock_sk(sk)->default_data_ready(sk);
> >+
> >       sock_put(sk);
> > }
> > EXPORT_SYMBOL_GPL(virtio_transport_rx_batch_finish);
> >--
> >2.53.0
> >
>
