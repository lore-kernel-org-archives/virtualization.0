Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.222.181
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794705398;
	b=p9Iby7XOaAmd3yy12MpUWLljkFbAa/gFC5hD53JQHD2PStBvg/iVbVSIekso23h7hdfv
	 fGqralyilpYzR2s3Ran4B2LoFK1xa8FV+b+zAWzd8wVVeNB4GWkAwcjzQjs1ldsU2JLJB
	 VX0zaHRIkmOOFIIZEttlaMZO4fVn5UjbIghCk4sTWfOQx3KBMyN2uXgoi9GTAfdagwGBI
	 oZPs2LzzH50a9IFFtajlDPRv7KUzXHAAnC1FK4i9e9IvtVaYVZbTVEelkfc0ldx86kXcO
	 anx/35UjTC+ssjkg+YlEqv3aSoeaBJCOrJAbTTSn8C2Zygw7oDHf6DMoZqkhXdTiIcA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794705398;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type;
	bh=F8dpUgzOoxPx+Jh3a8nIBQMmsbWct5uSooKKOFeDY9U=;
	b=p8MuGrc+/L/LAbONCkLRQmXmUl9d58KSJW2UwUxYZZwTOM0pvJFXYr4OZV6VX6g8CgLA
	 XatPae0CL+jZXdAU49eTvEH94Juz6UTrIJ100zjZige4guQT8maA9IHD8Zsxaj8BHoAvo
	 0tC6RrrDuaaK/4kZF+k8FG/KN+KnZVeH+8tSnAF2hJzBjNtvIvU6emjPnTOkUkchwwrCA
	 PQtrM4rboMIwC6p0MRLLEjhx8lI0O6snlla1EpzIOVUJaFIBKDiAP+3S8Y1TxM4WU8WNx
	 E+Y0g3sME8WF6eEqFGJWPUZpS98iARxf2y65tTHX/a9q3ynt292QF2Fild8zWY8QWNw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="i/f8pCts";
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.222.181
Received: from mail-qk1-f181.google.com (mail-qk1-f181.google.com [209.85.222.181])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD5FA606A32D
	for <virtualization@lists.linux.dev>; Sun, 15 Nov 2026 01:16:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BD5FA606A32D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=i/f8pCts
Received: by mail-qk1-f181.google.com with SMTP id af79cd13be357-9495e8ae23aso140343685a.2
        for <virtualization@lists.linux.dev>; Sat, 14 Nov 2026 17:16:37 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794705397; cv=none;
        d=google.com; s=arc-20260327;
        b=BTJNY7XjVRHKc32Vzhqc+ASxAO3WBU/BreMk7VfQ2fJ6QYoyYX0cGb0heFtSkyZk/J
         nnPmLn/hnOjp7835aSFkUdBGYLN/c762y+ulBMGqb5cQcsw/QVb/kn0JE9JlMYrFPftt
         c/I64X+mPS0Su2uzZaz/WcTE1uiUNonnsmnywiGjZ6t9IEytV7hTBiCE6eBf4nAPPFaC
         5UXRALQs0DFZKruRRPnzAA3Ert81fUE64ptO3M0ssEHBo9zCXozcIsObT8DqdgedYv7G
         Nq8YsdVpXPoh2l+CogM6cjbp+wr9SigH7U3b9jPxlXaiWuTsevCKq+Cb8iMWao44xsbS
         r9zg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=F8dpUgzOoxPx+Jh3a8nIBQMmsbWct5uSooKKOFeDY9U=;
        fh=IiG9XALqvXUgTx40O3J+U7G//BHMGO37Wg1Nts0s+t4=;
        b=LKonG0OzPgPuAmFOgnRHibIm50E6+5ax6GFeIrZ7Kigv+NaNbAJCQEvxeVVdtTwtva
         0hK56BXH5ZxIJVO/Oav/oclAskepUkVjb1dToTgcmSTNt0Sxdde9Hl9VlOuxg5J6kUeg
         i6lCnbIy56l8phLl7EvMPfNpVIewV7xWJJB9rBngZOOslarc4lBX7DWY7sabzkq/V0zX
         vHHKhT5B2yFMeBbU92qaTPeGMxI3Fgnab58y0RFaA3OwUizwcXXKnQajIOU71SXbs09k
         mBqSdppSgB4VWVFwBwimYRMG/HSzMFxaJcB3Q2LAUP7NhyYhio8UHn6lkJnYql+gUgD8
         i3Tg==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794705397; x=1795310197; darn=lists.linux.dev;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=F8dpUgzOoxPx+Jh3a8nIBQMmsbWct5uSooKKOFeDY9U=;
        b=i/f8pCtsS3lRAv7JEqZ8n7BWcpiob4ZlSrTUZtbMwLgHso3SNxRwt4PZ73OTLSOB+k
         LfFOBlQ2uRPjJctYOoL/VjZ7RELHnani4jon5UQWHBi/KwwSrO7oDlYZM18WN+1idQRj
         x9NexHPc7T5UBcyvC7wr6SrpT6/oI4KRkFVTUJrtCw5qaWZSh/tk38urzhahvx/rxoLp
         v0OuqIsUHBaxWHDgHz+JZL0mCfbi3aOxfyieDt96TazF+K4sSygLO6jXVFtQD+yBjCSt
         79AzX9h3zDa19ySJZGs0dYQKw1xssklRpGgcxSNNI9ko8ONGMrGAoVo5TypcfIy9kLfB
         sqTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794705397; x=1795310197;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=F8dpUgzOoxPx+Jh3a8nIBQMmsbWct5uSooKKOFeDY9U=;
        b=XQ/oi48DDWcVvcp+ER8gWm2DHHa3zuZKQyC/5G+oCUOgv13K4beyiQpkl9XXedLvWK
         qsJYweyLy9QWAyHGjIJz4iZ35rHbZHUOEsyxEhcdP9ODYsWQjePzwzfMy1xgWYsmZE1f
         DZ7Oo7DLFOXNydlllj45WmlBaGgVobOj+5tNBD5wS0yCVRt47HzizEe5U/o24V0E9RIl
         nxaAhDD7nUaBgTlWYQeqzoEI4qpWOomHQMhMEwrJjFOf3KoM+cv+WQCfZjIhKJLaze02
         4gGJz3vnYkc1fCGmTULnKceGdYKCvqWWMrnk+iYI06KcYeSv14lZRMIKpzFYtQNnkOeI
         i27g==
X-Forwarded-Encrypted: i=1; AL+hErHtnDvuURN3aAbCquM8IMFQZTMGTXEPCR+y4bhPit2Q+I/pqzdzmiTefkk7jZYp/XLmtFxFZylxNJaDm52afg==@lists.linux.dev
X-Gm-Message-State: APuU4Z/BDpnyEEp0bYqsdZUmur5E7jseWKkc9TuX8QDaiOyAIwQAP51j
	7n7WcwzbW5bgZ61bZ17sC5G3Qd/Y79l8uEUVWsQkpoog7IfmcyqEBXo5DO1lcanSv1ly98kbAHV
	n8ofQUXfDeaR2XSaenRVd2xIqn4j59Jg=
X-Gm-Gg: AYBFou0tXNnWFsuZZZMHxYaM6FVY0JHfVg5eqIvvt/H3ADX00hUqPxUie03M56qJNg5
	rxZnIxjTslO24lEZVkpljP/eSzCZQ+J38ki9yo9XmrlIHGYQbqZrc7Duf7T0sEHhHIbBuA00JT/
	SfHl6TSaQ0xuZzSD64GswJ/FujIYM/xXielZuFVdpzr8TaOVV2W6HKUzl7innX0fhrNv0/cFpaE
	a9HEmM545USH/Dp+RMberVssjqiP2LgfHF+O8a5Hz+0sOj5T1SFgTYc/NnvsdKwEGlzFa7+w+TB
	ktWL4FQ0h+0/oCyjRwMkSZ+ISLlsUlNAdOJ34zh+Jlr7TKCQ71gLUv80HWxdl3/ANmi8IZ/8pdy
	SHL/6qyl6pICnKBd6Uh2EV+ll4vRkQX8dIwa8/OyXgzwP/xoPjbdDN0JmHvgQig1hOfGAnhI=
X-Received: by 2002:a05:620a:3194:b0:93f:1e3c:4a31 with SMTP id
 af79cd13be357-9494bc489cemr1205984085a.61.1794705396536; Sat, 14 Nov 2026
 17:16:36 -0800 (PST)
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
References: <20261103041134.33310-1-physicalmtea@gmail.com>
 <20261103041134.33310-5-physicalmtea@gmail.com> <auxHe77Kv3tS4hjJ@sgarzare-redhat>
 <CAJwVaMK6UpxOmCbuzGK15h+DhN5H6cj6cy-=gCHtSxoVbLfzwA@mail.gmail.com> <avX1+7zxl9OWGUGI@devvm29614.prn0.facebook.com>
In-Reply-To: <avX1+7zxl9OWGUGI@devvm29614.prn0.facebook.com>
From: Jia Jia <physicalmtea@gmail.com>
Date: Sun, 15 Nov 2026 09:15:58 +0800
X-Gm-Features: AclHuK-T0MEDdJ39kG7QgYlQtmmMpMQfQ5G4jecRDwhf-cJbDIFNw63bcWzZktY
Message-ID: <CAJwVaMK8_HxMjCVQwmwet+sphKHSM-L0eCogdzu1tZfLqCukSA@mail.gmail.com>
Subject: Re: [PATCH net-next v5 4/5] vsock/virtio: coalesce native RX
 write-space notifications
To: Bobby Eshleman <bobbyeshleman@gmail.com>
Cc: Stefano Garzarella <sgarzare@redhat.com>, netdev@vger.kernel.org, stefanha@redhat.com, 
	mst@redhat.com, jasowangio@gmail.com, eperezma@redhat.com, 
	xuanzhuo@linux.alibaba.com, davem@davemloft.net, edumazet@google.com, 
	kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, kvm@vger.kernel.org, 
	virtualization@lists.linux.dev, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

>
> On Fri, Nov 06, 2026 at 08:49:17PM +0800, Jia Jia wrote:
> > >
> > > On Tue, Nov 03, 2026 at 12:11:33PM +0800, Jia Jia wrote:
> > > >Each received packet can update peer credit and call sk_write_space(). A
> > > >writer cannot consume that credit while the virtio RX worker retains the
> > > >socket lock, so repeated native write-space notifications in one RX batch
> > > >are unnecessary.
> > > >
> > > >This patch coalesces write-space notifications on the native AF_VSOCK path;
> > > >data-ready remains per-packet here.
> > > >
> > > >The batching patch establishes batch ownership before its first packet.
> > > >This lets this patch record a pending notification for that packet and
> > > >flush it even if the packet immediately ends the batch. Deliver it while
> > > >holding the socket lock to preserve the callback context of the existing
> > > >receive path. A following patch changes that timing together with
> > > >data-ready handling.
> > >
> > > Can you report performance data related to this patch also here?
> > >
> > > IIUC this is not giving a lot of advantage, so my question is if this
> > > more complexity really add a value for us.
> > >
> >
> > Sure. The performance tests currently cover patches 4 and 5 together,
> > so I will include those results here.
> >
> > They do not add another broad throughput improvement. I kept the
> > combined notification change because of the cycles/byte results.
> >
> > With P1-P3 only, against baseline:
> >
> >   Buffer size  baseline cycles/B  PATCH cycles/B  cycles change (95% CI)
> >   64B        66.728    61.220  -8.25% [-18.99%, +3.91%]
> >   256B       14.363    14.515  +1.06% [ -4.22%, +6.64%]
> >   512B        7.792     7.578  -2.74% [ -6.55%, +1.23%]
> >   1K          3.988     4.032  +1.09% [ -1.64%, +3.88%]
> >   4K          2.063     1.973  -4.38% [ -8.23%, -0.37%]
> >   8K          1.702     1.667  -2.06% [ -7.99%, +4.25%]
> >   16K         1.473     1.475  +0.17% [ -5.06%, +5.68%]
> >   64K         1.385     1.358  -1.96% [-10.61%, +7.53%]
> >
> > Only the 4K interval excluded zero. With the full series, against
> > baseline:
> >
> >   Buffer size  baseline cycles/B  PATCH cycles/B  cycles change (95% CI)
> >   64B        65.282    57.843  -11.40% [-13.77%, -8.95%]
> >   256B       14.710    13.813   -6.10% [ -7.89%, -4.28%]
> >   512B        7.709     7.188   -6.75% [ -8.79%, -4.66%]
> >   1K          4.075     3.862   -5.23% [ -6.80%, -3.63%]
> >   4K          2.034     1.887   -7.21% [ -8.67%, -5.72%]
> >   8K          1.664     1.568   -5.78% [ -7.83%, -3.69%]
> >   16K         1.450     1.385   -4.48% [ -6.08%, -2.86%]
> >   64K         1.338     1.317   -1.51% [ -3.21%, +0.22%]
> >
> > From 64B through 16K those intervals stay below zero. 64B through 1K
> > did not show that in the P1-P3 run.
> >
> > This is also why I spent the time making this work with sockmap.
> >
> > The value I see is lower RX CPU cost, not another large throughput
> > gain. I am still unsure the extra code is worth it, and I would like
> > your opinion.
> >
> > Thanks,
> > Jia
> >
> > > >
> > > >Capture the native write-space callback before socket publication and
> > > >access it through AF_VSOCK helpers. Sockmap can change the protocol,
> > > >write-space callback, and psock marker without the socket lock. Serialize
> > > >each batch eligibility check with sk_callback_lock; if a packet boundary
> > > >observes a replacement, finish the batch and use the regular per-packet
> > > >path.
> > > >
> > > >Packets admitted on the native path use the saved native callback at batch
> > > >finish. Reloading a current sockmap callback would not synchronize its
> > > >invocation with teardown; a wrapper seen before teardown need not forward
> > > >the native wakeup after its psock is gone.
> > >
> > > I really don't understand the goal of this patch, and why we need to
> > > store the "native" sk_write_space.
> > >
> >
> > Actually, I kept this as a separate patch so the two notification changes
> > could be tested separately. This patch provides a complete intermediate
> > state: it coalesces native sk_write_space() notifications while keeping the
> > callback invocation under the socket lock. Patch 5 then coalesces
> > sk_data_ready() and moves both deferred callbacks after release_sock().
> >
> > The coalescing is limited to packets for which can_receive() sees
> > sk_write_space still set to the native callback. That callback wakes waiters.
> > The sockmap wrapper can also schedule psock work before forwarding
> > the saved callback, so I do not coalesce it.
> >
> > Batch finish also needs the saved pointer if the callback changes before
> > the batch ends. If another packet arrives, can_receive() detects the
> > replacement
> > and its caller finishes the batch. A write-space notification already
> > recorded for
> > the batch still uses the native callback.
> >
> > Reloading sk->sk_write_space at finish could capture the sockmap wrapper just
> > before teardown. If teardown removes the psock before the callback is invoked,
> > the wrapper no longer forwards the native wakeup.
>
> I'm not sure I understand the bug avoided by saving sk_write_space.
>
> If it changes mid-batch to the psock callback, the work that gets
> scheduled by sockmap will eventually acquire the socket lock via
> sock_sendmsg(), so the present batch will become owned in whole by the
> new socket anyway.
>
> I think that is perfectly acceptable semantics (when you redirect with
> sockmap, any current or later batch will be owned by the new sender). I
> don't think we need pkt redirection to be exactly in sync with
> installing the socket into sockmap at the exact pkt boundary if at least
> the batch boundary is in sync. The batch would just be "eventually
> consistent" with the new sockmap state.
>
> WDYT?
>
> I understand the sk_data_ready is a different matter because of the
> per-skb ->read_skb callback.
>
> My suggestion, if it works, would be to just do one sk_write_space call
> per batch, whichever cb it happens to be when the batch processing is
> done.
>

Thanks for the suggestion. I'll look into it.

The pointer is there because sk_psock_write_space() forwards its saved
callback only when it still finds a psock. With no psock it returns, and the
writer is not woken. sk_psock_drop() restores sk_write_space and clears
the psock under the write side of sk_callback_lock, without the socket lock.
If finish loads the current callback and calls it outside that lock, RX can load
the wrapper, drop can clear the psock, and the wrapper then finds nothing
to forward.

What I can see so far is that, without the saved pointer, that call would
need to run under read_lock_bh(&sk->sk_callback_lock). drop takes the
write side, so it cannot enter between the load and the call. The saved
pointer would then have nothing left to do. I'll check that.

Thanks

> >
> > > >
> > > >Signed-off-by: Jia Jia <physicalmtea@gmail.com>
> > > >---
> > > > include/linux/virtio_vsock.h            |  4 +-
> > > > include/net/af_vsock.h                  |  7 +++
> > > > net/vmw_vsock/af_vsock.c                | 16 +++++
> > > > net/vmw_vsock/virtio_transport_common.c | 78 +++++++++++++++++--------
> > > > 4 files changed, 81 insertions(+), 24 deletions(-)
> > > >
> > > >diff --git a/include/linux/virtio_vsock.h b/include/linux/virtio_vsock.h
> > > >index 748633aa0cc81..bf28e8e32e280 100644
> > > >--- a/include/linux/virtio_vsock.h
> > > >+++ b/include/linux/virtio_vsock.h
> > > >@@ -287,12 +287,14 @@ void virtio_transport_recv_pkt(struct virtio_transport *t,
> > > >  * Initialize a batch to zero before use. A non-empty batch owns @sk's socket
> > > >  * lock and the reference returned by vsock_find_connected_socket_net(). The
> > > >  * caller retains both until it calls virtio_transport_rx_batch_finish(). An
> > > >- * empty batch owns neither.
> > > >+ * empty batch owns neither. A pending native write-space notification belongs
> > > >+ * to the lock holder and is delivered by virtio_transport_rx_batch_finish().
> > > >  */
> > > > struct virtio_transport_rx_batch {
> > > >       struct sock *sk;
> > > >       unsigned int pkts;
> > > >       size_t bytes;
> > > >+      bool write_space_pending;
> > > > };
> > > >
> > > > static inline bool
> > > >diff --git a/include/net/af_vsock.h b/include/net/af_vsock.h
> > > >index 5549298c1ec6b..b76ab565ea58b 100644
> > > >--- a/include/net/af_vsock.h
> > > >+++ b/include/net/af_vsock.h
> > > >@@ -63,6 +63,11 @@ struct vsock_sock {
> > > >       u32 peer_shutdown;
> > > >       bool sent_request;
> > > >       bool ignore_connecting_rst;
> > > >+      /*
> > > >+       * Captured before the socket is published. This identifies AF_VSOCK's
> > > >+       * native write-space callback after a consumer has replaced it.
> > > >+       */
> > > >+      void (*native_write_space)(struct sock *sk);
> > > >
> > > >       /* Protected by lock_sock(sk) */
> > > >       u64 buffer_size;
> > > >@@ -78,6 +83,8 @@ s64 vsock_stream_has_data(struct vsock_sock *vsk);
> > > > s64 vsock_stream_has_space(struct vsock_sock *vsk);
> > > > struct sock *vsock_create_connected(struct sock *parent);
> > > > void vsock_data_ready(struct sock *sk);
> > > >+bool vsock_write_space_is_native(const struct sock *sk);
> > > >+void vsock_call_native_write_space(struct sock *sk);
> > > >
> > > > /**** TRANSPORT ****/
> > > >
> > > >diff --git a/net/vmw_vsock/af_vsock.c b/net/vmw_vsock/af_vsock.c
> > > >index 44cee74519555..e39567990539f 100644
> > > >--- a/net/vmw_vsock/af_vsock.c
> > > >+++ b/net/vmw_vsock/af_vsock.c
> > > >@@ -958,6 +958,7 @@ static struct sock *__vsock_create(struct net *net,
> > > >               sk->sk_type = type;
> > > >
> > > >       vsk = vsock_sk(sk);
> > > >+      vsk->native_write_space = sk->sk_write_space;
> > > >       vsock_addr_init(&vsk->local_addr, VMADDR_CID_ANY, VMADDR_PORT_ANY);
> > > >       vsock_addr_init(&vsk->remote_addr, VMADDR_CID_ANY, VMADDR_PORT_ANY);
> > > >
> > > >@@ -1122,6 +1123,21 @@ void vsock_data_ready(struct sock *sk)
> > > > }
> > > > EXPORT_SYMBOL_GPL(vsock_data_ready);
> > > >
> > > >+bool vsock_write_space_is_native(const struct sock *sk)
> > > >+{
> > > >+      const struct vsock_sock *vsk = vsock_sk(sk);
> > > >+
> > > >+      return READ_ONCE(sk->sk_write_space) ==
> > > >+             READ_ONCE(vsk->native_write_space);
> > > >+}
> > > >+EXPORT_SYMBOL_GPL(vsock_write_space_is_native);
> > > >+
> > > >+void vsock_call_native_write_space(struct sock *sk)
> > > >+{
> > > >+      vsock_sk(sk)->native_write_space(sk);
> > > >+}
> > > >+EXPORT_SYMBOL_GPL(vsock_call_native_write_space);
> > > >+
> > > > /* Dummy callback required by sockmap.
> > > >  * See unconditional call of saved_close() in sock_map_close().
> > > >  */
> > > >diff --git a/net/vmw_vsock/virtio_transport_common.c b/net/vmw_vsock/virtio_transport_common.c
> > > >index f83e5b2edce35..af26344678e41 100644
> > > >--- a/net/vmw_vsock/virtio_transport_common.c
> > > >+++ b/net/vmw_vsock/virtio_transport_common.c
> > > >@@ -1865,31 +1865,55 @@ virtio_transport_rx_batch_can_continue(struct virtio_transport *t,
> > > >              !virtio_transport_rx_buf_full(vvs);
> > > > }
> > > >
> > > >-/* The caller holds sk's socket lock. */
> > > >+/* The caller holds sk's socket and callback locks. */
> > > > static bool
> > > >-virtio_transport_rx_batch_can_receive(struct virtio_transport *t,
> > > >-                                    struct sock *sk, u32 len)
> > > >+__virtio_transport_rx_batch_can_receive(struct virtio_transport *t,
> > > >+                                      struct sock *sk, u32 len)
> > > > {
> > > >       if (!virtio_transport_rx_batch_can_continue(t, sk, len))
> > > >               return false;
> > > >
> > > >       /*
> > > >-       * Sockmap can replace sk_prot and publish a psock without the socket lock.
> > > >-       * Check both at each packet boundary; a boundary that sees a replacement
> > > >-       * returns to the existing per-packet path.
> > > >+       * Sockmap can replace sk_prot or sk_write_space, and publish a psock,
> > > >+       * without the socket lock. Coalescing is safe only for the native
> > > >+       * write-space callback, so a boundary that sees a replacement returns to
> > > >+       * the existing per-packet path.
> > > >        */
> > > >       return READ_ONCE(sk->sk_prot) == sk->sk_prot_creator &&
> > > >+             vsock_write_space_is_native(sk) &&
> > >
> > > I'm confused, why for sk_prot we are doing the check here, while for
> > > sk_write_space we need a new API?
> > >
> >
> > sk_prot can be compared with sk_prot_creator. sk_write_space
> > has no field like that, and sock_def_write_space() is static.
> > I save the callback in __vsock_create(), after the socket is
> > initialized and before it is published. The helpers compare
> > against that pointer and call it.
> >
> > > >              !virtio_transport_sock_has_psock(sk);
> > > > }
> > > >
> > > >+/*
> > > >+ * Sockmap teardown restores the native protocol and write-space callback
> > > >+ * under sk_callback_lock. Serialize each packet admission check with those
> > > >+ * updates.
> > > >+ */
> > > >+static bool
> > > >+virtio_transport_rx_batch_can_receive(struct virtio_transport *t,
> > > >+                                    struct sock *sk, u32 len)
> > > >+{
> > > >+      bool batchable;
> > > >+
> > > >+      read_lock_bh(&sk->sk_callback_lock);
> > > >+      batchable = __virtio_transport_rx_batch_can_receive(t, sk, len);
> > > >+      read_unlock_bh(&sk->sk_callback_lock);
> > > >+
> > > >+      return batchable;
> > > >+}
> > > >+
> > > > /*
> > > >  * The caller holds sk's socket lock. If @batchable is non-NULL, update it
> > > >  * after processing @skb to say whether a native STREAM/RW batch can continue.
> > > >+ * When @batch is non-NULL, record a native write-space notification for batch
> > > >+ * finish. A writer cannot consume the updated credit until this lock is
> > > >+ * released.
> > > >  */
> > > > static void
> > > > virtio_transport_recv_pkt_locked(struct virtio_transport *t,
> > > >                                struct sk_buff *skb, struct sock *sk,
> > > >-                               struct net *net, bool *batchable)
> > > >+                               struct net *net, bool *batchable,
> > > >+                               struct virtio_transport_rx_batch *batch)
> > >
> > > Do we really need bot batchable and batch ?
> > >
> >
> > Agreed, we don't. I'll clean that up in the next version. Thanks
> >
> > > > {
> > > >       struct virtio_vsock_hdr *hdr = virtio_vsock_hdr(skb);
> > > >       struct vsock_sock *vsk = vsock_sk(sk);
> > > >@@ -1921,8 +1945,12 @@ virtio_transport_recv_pkt_locked(struct virtio_transport *t,
> > > >       if (vsk->local_addr.svm_cid != VMADDR_CID_ANY)
> > > >               vsk->local_addr.svm_cid = le64_to_cpu(hdr->dst_cid);
> > > >
> > > >-      if (space_available)
> > > >-              sk->sk_write_space(sk);
> > > >+      if (space_available) {
> > > >+              if (batch)
> > > >+                      batch->write_space_pending = true;
> > > >+              else
> > > >+                      sk->sk_write_space(sk);
> > > >+      }
> > > >
> > > >       switch (sk->sk_state) {
> > > >       case TCP_LISTEN:
> > > >@@ -1947,7 +1975,7 @@ virtio_transport_recv_pkt_locked(struct virtio_transport *t,
> > > >       }
> > > >
> > > >       if (batchable)
> > > >-              *batchable = virtio_transport_rx_batch_can_receive(t, sk, 0);
> > > >+              *batchable = virtio_transport_rx_batch_can_continue(t, sk, 0);
> > >
> > > Why this change?
> > >
> >
> > This runs after the packet has been handled. can_receive() decides
> > whether a packet may be processed in the batch, so I do not call it
> > again here. can_continue() checks whether the socket state, type,
> > transport, and RX limits still allow the batch to remain active. If it
> > returns false, the caller releases the socket lock and drops the
> > connected reference.
> >
> > A change to sk_prot, sk_write_space, or the psock is seen by
> > can_receive() before the next packet is processed, and that packet takes
> > the regular path.
>
> I think squashing would avoid the churn.
>

Sure, understood. Thanks.

> >
> > > > }
> > > >
> > > > /* We are under the virtio-vsock's vsock->rx_lock or vhost-vsock's vq->mutex
> > > >@@ -1991,7 +2019,7 @@ void virtio_transport_recv_pkt(struct virtio_transport *t,
> > > >               goto free_pkt;
> > > >
> > > >       lock_sock(sk);
> > > >-      virtio_transport_recv_pkt_locked(t, skb, sk, net, NULL);
> > > >+      virtio_transport_recv_pkt_locked(t, skb, sk, net, NULL, NULL);
> > > >
> > > >       release_sock(sk);
> > > >
> > > >@@ -2008,20 +2036,31 @@ EXPORT_SYMBOL_GPL(virtio_transport_recv_pkt);
> > > >
> > > > /*
> > > >  * Release an active RX batch. A non-empty batch holds the socket lock and the
> > > >- * reference returned by vsock_find_connected_socket_net(). An empty batch
> > > >- * holds neither.
> > > >+ * reference returned by vsock_find_connected_socket_net(). Deliver any
> > > >+ * deferred native write-space notification while holding the lock, preserving
> > > >+ * the callback context of the regular receive path. An empty batch holds
> > > >+ * neither.
> > > >  */
> > > > void virtio_transport_rx_batch_finish(struct virtio_transport_rx_batch *batch)
> > > > {
> > > >+      bool write_space_pending = batch->write_space_pending;
> > > >       struct sock *sk = batch->sk;
> > > >
> > > >       batch->sk = NULL;
> > > >       batch->pkts = 0;
> > > >       batch->bytes = 0;
> > > >+      batch->write_space_pending = false;
> > > >
> > > >       if (!sk)
> > > >               return;
> > > >
> > > >+      /*
> > > >+       * The packet was admitted with the native callback. Do not reload a current
> > > >+       * callback here: sockmap can replace or remove its wrapper independently.
> > > >+       */
> > > >+      if (write_space_pending)
> > > >+              vsock_call_native_write_space(sk);
> > > >+
> > > >       release_sock(sk);
> > > >       sock_put(sk);
> > > > }
> > > >@@ -2080,7 +2119,8 @@ virtio_transport_rx_batch_process(struct virtio_transport *t,
> > > >               return;
> > > >       }
> > > >
> > > >-      virtio_transport_recv_pkt_locked(t, skb, batch->sk, net, &batchable);
> > > >+      virtio_transport_recv_pkt_locked(t, skb, batch->sk, net, &batchable,
> > > >+                                       batch);
> > > >       if (!batchable) {
> > > >               virtio_transport_rx_batch_finish(batch);
> > > >               return;
> > > >@@ -2158,16 +2198,8 @@ void virtio_transport_recv_pkt_batch(struct virtio_transport *t,
> > > >       }
> > > >
> > > >       lock_sock(sk);
> > > >-      /*
> > > >-       * Serialize initial admission with sockmap's callback updates. Later
> > > >-       * packet boundaries recheck native state and end a batch when they
> > > >-       * observe a replacement.
> > > >-       */
> > > >-      read_lock_bh(&sk->sk_callback_lock);
> > > >       batchable = virtio_transport_rx_batch_can_receive(t, sk, len);
> > > >-      read_unlock_bh(&sk->sk_callback_lock);
> > >
> > > Can we avoid this change and do this in the previous patch?
> > >
> > > Please avoid as much as you can change code introduced in the same series.
> > >
> >
> > Sure, understood.
> >
> > > >       if (!batchable) {
> > > >-              /* State or receive-buffer failures keep the regular lookup path. */
> > >
> > > Why removing this comment just added by previous patch?
> > >
> >
> > This patch adds a replaced sk_write_space as another reason for
> > can_receive() to return false, and that case does not take the regular
> > lookup path. I removed the old comment because it no longer
> > described the distinction completely, but I forgot to add the replacement.
> > Sorry about that, and thanks for catching it.
> >
> > > >               if (!virtio_transport_rx_batch_can_continue(t, sk, len)) {
> > > >                       release_sock(sk);
> > > >                       sock_put(sk);
> > > >@@ -2176,7 +2208,7 @@ void virtio_transport_recv_pkt_batch(struct virtio_transport *t,
> > > >
> > > >               virtio_transport_trace_recv_pkt(hdr, &src, &dst);
> > > >               if (virtio_transport_recv_pkt_set_owner(skb, sk))
> > > >-                      virtio_transport_recv_pkt_locked(t, skb, sk, net, NULL);
> > > >+                      virtio_transport_recv_pkt_locked(t, skb, sk, net, NULL, NULL);
> > > >               else
> > > >                       kfree_skb(skb);
> > > >
> > > >--
> > > >2.53.0
> > > >
> > >
>
>
> Thanks,
> Bobby
