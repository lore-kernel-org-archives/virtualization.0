Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.174
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794504203;
	b=ZEANC7oRr81q2GLM/GnULt5OkholIxDqV7QvUN9Z8dabJ0a0468+j22lnobi2OXjehiK
	 61BlgbgmRd4SBOuNXz3afoAP6ss8MLADAfjhXvnM/UK9EBUeB7bn9cHsni2pxqXFN+RNl
	 31kiZXnIizc1NIpY0YReQOwu+FSXgzngFTO0coFOM+2Oru42X998aVxECDdknHMl2ODpL
	 9AWSuf0+ApNf1j3Naj/WRW+QAZfWNiqhafoRALvCmTduXEylGYaI1HT3p+OvbP6a+1Rej
	 kAz7sr6W5Hp1OQBNePgT7d7l1ryeBvW4ohnAa+pmyqJYNCCFi+Q3Ebsu4UTN32bCK/Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794504203;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=NNydOJUW1Uu0hLKP/XG0kMJ5M+aQH3O72D2qUnIH2lc=;
	b=zDy0iwmaAC5MlcOFsV/hM5VBZ5j70JGd8Hlibim74qmitGqBOO9omqC2GfMd1PN3QuTZ
	 Ei/viq/OmlBUOLCz6MsiJqaYMLSE0Nuifll03SvAb51daRvxJKI2AZdxHjwTMcBaBbDCd
	 Rz5Hr3iQOyZLxRsKkjk8QFom2welEBi0hS+56+JcyIdb5xnkSWVO8hnHDFhxQh+SL4QGe
	 0KBEQcJrS1Rg2dkLMzY7IbnjnuHeT2stu6CYoPOlLvE17N9Dh9AQAKgQITDg2GR04yaea
	 Kfmr6PDAdS7p5iNYc5kcpdh0WbitDNGhVdRv1wIbkahew32XDZkUEg5FrRtl/uWCq+g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=rsg26WFd;
	arc=none smtp.remote-ip=209.85.128.174
Received: from mail-yw1-f174.google.com (mail-yw1-f174.google.com [209.85.128.174])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAE1D606A321
	for <virtualization@lists.linux.dev>; Thu, 12 Nov 2026 17:23:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org EAE1D606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=rsg26WFd
Received: by mail-yw1-f174.google.com with SMTP id 00721157ae682-8b3402105b9so1488887b3.0
        for <virtualization@lists.linux.dev>; Thu, 12 Nov 2026 09:23:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794504202; x=1795109002; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=NNydOJUW1Uu0hLKP/XG0kMJ5M+aQH3O72D2qUnIH2lc=;
        b=rsg26WFd0ZeMBtQMj01pi9gW8Ic5OaptsY2Gq4HPx++jT8uFmT1gxP+GHEqPYt79qx
         R2VycltorXTrSVtoE5Helx25Fmyf68Q3BuHXmsv12sPwqhfnHqmicFpqa7RzRpEE4moG
         LI7t994xhYpxFMZRoQzSEiOw5qYwUDZLfRuTQicL3q1tqDCMcSmPFXr8OLcd8R3lKtXt
         ZiRYYLG2cRtv/0uzA3FidcG1DhnbNW9t5f6S2NgDgqhzb9Y/uFUhCXOVzu20noT2aJ3E
         ftgjecmL5p3W0m/9ZHzZPtBgxXX8Bzjjim74mCvgNlh4ozOAYuwqkXuRY1L6kbUbGaf4
         9fpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794504202; x=1795109002;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=NNydOJUW1Uu0hLKP/XG0kMJ5M+aQH3O72D2qUnIH2lc=;
        b=zt/zzd6cMk2k6wouyuRCeqvQe8/d0GShHC7Bcdoo97MH8Ev/iUiT6oMFH3PzTlLUFP
         J3RTR4iqZ0py7ATyegz1n+rGlE094nWTZZFpCnwRxQK/eAPUQX93+QVNlq82ac978HAy
         pWQPt9b/zfDkl+tKkCI0/FVGLxF5hePQS8MPTXU/gu44RhGkbSUOV624Sc4d+46W9A1S
         XX2mQokKWMoHI/1vhSqFRRIiwymr9CMj/qoKWUumJNCZz/xCGGhhJlfcQnkkFDOlEeQ4
         EwJ0P+w6T1j6kLCx7eHc/tPwL65UZm8C3FoeoINAn652hAuw+HS1HHUkt7ef2mWQ7eQ3
         7Mfg==
X-Forwarded-Encrypted: i=1; AL+hErElmBBWjjkVIHEfr06UnH/egCL6P7dKhpcEDygw6vOrbEIwxh15QMmMLGJJsK0+6PwEhyu3Xu7Zkcw+bHy2iQ==@lists.linux.dev
X-Gm-Message-State: APuU4Z/1DtwTahbscUnqVHyiZnCckTN9JKt7e1u27rbWFaCp/i2MVqs9
	+dhA5s4RadPjnqyeBXn93ZmyK8AAMTucgIuON22tMSGpXM5t81NsIGxA
X-Gm-Gg: AYBFou0Z1X8/SAC6KHNvUUfirExflsRpPoAWvXVAkXNmUiW9qQqY8zOpirNfTsm2WT+
	o5v8u+qrG6NOmF5fZTzubvad3QlAmPtE4U69EYMlhrz91nIlyQEmv/EpZ0eVs9MBvBNk3LpaH5F
	npbq1KjkZwdO0Otxyw+uuYrHQ62eKMFkHpsV8x/51qMKEiFpxhQAVeIhh6v0U1zHdUowY5oyJlp
	frIXkKIOnj0KUPV20JWNQgidya2qoLpLH+HXp3o/8tlln/RQKFR1WC8hyXPwYgxLRdrd+fHvhtQ
	Euj03S60CiBLjAZ4Mu+WjHhkkztEG0dQU6y/+vcmEZfS6VxQORt3sobzfLJ9b8yN0KzgevR6m2f
	ueP8Bm7SDEeA+qfzRI94x6fVxsZtSqkDAK4eZRpAO3d0p4XIE2+UTinAa/YVUAQApOTVhWLa49F
	IR9KYgh9/rwmnLFETnKz+E0cVrwytDGLl+h6iq41qmuCuSs0+QUcff6NLOWI2exSrp5l9nAdemT
	D6TCvnDkHoaQE/0eukCpCCw7kiqTg/tG7rdvL3hl5F1uoJ87yI6YekTaLXDwt/Fkov/zVs0UoSe
	dE4ZNgz06Jwm5EFlG2Pzpj9ur2u0QB/wj63Gk3ysha5OlA==
X-Received: by 2002:a05:690c:f07:b0:8b1:bc81:6ffe with SMTP id 00721157ae682-8b4aa38f280mr1204937b3.94.1794504201827;
        Thu, 12 Nov 2026 09:23:21 -0800 (PST)
Received: from localhost ([2a03:2880:ff:5::])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-8b4aa9c4ffesm623097b3.32.2026.11.12.09.23.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Nov 2026 09:23:12 -0800 (PST)
Date: Thu, 12 Nov 2026 09:23:07 -0800
From: Bobby Eshleman <bobbyeshleman@gmail.com>
To: Jia Jia <physicalmtea@gmail.com>
Cc: Stefano Garzarella <sgarzare@redhat.com>, netdev@vger.kernel.org,
	stefanha@redhat.com, mst@redhat.com, jasowangio@gmail.com,
	eperezma@redhat.com, xuanzhuo@linux.alibaba.com,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, horms@kernel.org, kvm@vger.kernel.org,
	virtualization@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v5 4/5] vsock/virtio: coalesce native RX
 write-space notifications
Message-ID: <avX1+7zxl9OWGUGI@devvm29614.prn0.facebook.com>
References: <20261103041134.33310-1-physicalmtea@gmail.com>
 <20261103041134.33310-5-physicalmtea@gmail.com>
 <auxHe77Kv3tS4hjJ@sgarzare-redhat>
 <CAJwVaMK6UpxOmCbuzGK15h+DhN5H6cj6cy-=gCHtSxoVbLfzwA@mail.gmail.com>
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJwVaMK6UpxOmCbuzGK15h+DhN5H6cj6cy-=gCHtSxoVbLfzwA@mail.gmail.com>

On Fri, Nov 06, 2026 at 08:49:17PM +0800, Jia Jia wrote:
> >
> > On Tue, Nov 03, 2026 at 12:11:33PM +0800, Jia Jia wrote:
> > >Each received packet can update peer credit and call sk_write_space(). A
> > >writer cannot consume that credit while the virtio RX worker retains the
> > >socket lock, so repeated native write-space notifications in one RX batch
> > >are unnecessary.
> > >
> > >This patch coalesces write-space notifications on the native AF_VSOCK path;
> > >data-ready remains per-packet here.
> > >
> > >The batching patch establishes batch ownership before its first packet.
> > >This lets this patch record a pending notification for that packet and
> > >flush it even if the packet immediately ends the batch. Deliver it while
> > >holding the socket lock to preserve the callback context of the existing
> > >receive path. A following patch changes that timing together with
> > >data-ready handling.
> >
> > Can you report performance data related to this patch also here?
> >
> > IIUC this is not giving a lot of advantage, so my question is if this
> > more complexity really add a value for us.
> >
> 
> Sure. The performance tests currently cover patches 4 and 5 together,
> so I will include those results here.
> 
> They do not add another broad throughput improvement. I kept the
> combined notification change because of the cycles/byte results.
> 
> With P1-P3 only, against baseline:
> 
>   Buffer size  baseline cycles/B  PATCH cycles/B  cycles change (95% CI)
>   64B        66.728    61.220  -8.25% [-18.99%, +3.91%]
>   256B       14.363    14.515  +1.06% [ -4.22%, +6.64%]
>   512B        7.792     7.578  -2.74% [ -6.55%, +1.23%]
>   1K          3.988     4.032  +1.09% [ -1.64%, +3.88%]
>   4K          2.063     1.973  -4.38% [ -8.23%, -0.37%]
>   8K          1.702     1.667  -2.06% [ -7.99%, +4.25%]
>   16K         1.473     1.475  +0.17% [ -5.06%, +5.68%]
>   64K         1.385     1.358  -1.96% [-10.61%, +7.53%]
> 
> Only the 4K interval excluded zero. With the full series, against
> baseline:
> 
>   Buffer size  baseline cycles/B  PATCH cycles/B  cycles change (95% CI)
>   64B        65.282    57.843  -11.40% [-13.77%, -8.95%]
>   256B       14.710    13.813   -6.10% [ -7.89%, -4.28%]
>   512B        7.709     7.188   -6.75% [ -8.79%, -4.66%]
>   1K          4.075     3.862   -5.23% [ -6.80%, -3.63%]
>   4K          2.034     1.887   -7.21% [ -8.67%, -5.72%]
>   8K          1.664     1.568   -5.78% [ -7.83%, -3.69%]
>   16K         1.450     1.385   -4.48% [ -6.08%, -2.86%]
>   64K         1.338     1.317   -1.51% [ -3.21%, +0.22%]
> 
> From 64B through 16K those intervals stay below zero. 64B through 1K
> did not show that in the P1-P3 run.
> 
> This is also why I spent the time making this work with sockmap.
> 
> The value I see is lower RX CPU cost, not another large throughput
> gain. I am still unsure the extra code is worth it, and I would like
> your opinion.
> 
> Thanks,
> Jia
> 
> > >
> > >Capture the native write-space callback before socket publication and
> > >access it through AF_VSOCK helpers. Sockmap can change the protocol,
> > >write-space callback, and psock marker without the socket lock. Serialize
> > >each batch eligibility check with sk_callback_lock; if a packet boundary
> > >observes a replacement, finish the batch and use the regular per-packet
> > >path.
> > >
> > >Packets admitted on the native path use the saved native callback at batch
> > >finish. Reloading a current sockmap callback would not synchronize its
> > >invocation with teardown; a wrapper seen before teardown need not forward
> > >the native wakeup after its psock is gone.
> >
> > I really don't understand the goal of this patch, and why we need to
> > store the "native" sk_write_space.
> >
> 
> Actually, I kept this as a separate patch so the two notification changes
> could be tested separately. This patch provides a complete intermediate
> state: it coalesces native sk_write_space() notifications while keeping the
> callback invocation under the socket lock. Patch 5 then coalesces
> sk_data_ready() and moves both deferred callbacks after release_sock().
> 
> The coalescing is limited to packets for which can_receive() sees
> sk_write_space still set to the native callback. That callback wakes waiters.
> The sockmap wrapper can also schedule psock work before forwarding
> the saved callback, so I do not coalesce it.
> 
> Batch finish also needs the saved pointer if the callback changes before
> the batch ends. If another packet arrives, can_receive() detects the
> replacement
> and its caller finishes the batch. A write-space notification already
> recorded for
> the batch still uses the native callback.
> 
> Reloading sk->sk_write_space at finish could capture the sockmap wrapper just
> before teardown. If teardown removes the psock before the callback is invoked,
> the wrapper no longer forwards the native wakeup.

I'm not sure I understand the bug avoided by saving sk_write_space.

If it changes mid-batch to the psock callback, the work that gets
scheduled by sockmap will eventually acquire the socket lock via
sock_sendmsg(), so the present batch will become owned in whole by the
new socket anyway.

I think that is perfectly acceptable semantics (when you redirect with
sockmap, any current or later batch will be owned by the new sender). I
don't think we need pkt redirection to be exactly in sync with
installing the socket into sockmap at the exact pkt boundary if at least
the batch boundary is in sync. The batch would just be "eventually
consistent" with the new sockmap state.

WDYT?

I understand the sk_data_ready is a different matter because of the
per-skb ->read_skb callback.

My suggestion, if it works, would be to just do one sk_write_space call
per batch, whichever cb it happens to be when the batch processing is
done.

> 
> > >
> > >Signed-off-by: Jia Jia <physicalmtea@gmail.com>
> > >---
> > > include/linux/virtio_vsock.h            |  4 +-
> > > include/net/af_vsock.h                  |  7 +++
> > > net/vmw_vsock/af_vsock.c                | 16 +++++
> > > net/vmw_vsock/virtio_transport_common.c | 78 +++++++++++++++++--------
> > > 4 files changed, 81 insertions(+), 24 deletions(-)
> > >
> > >diff --git a/include/linux/virtio_vsock.h b/include/linux/virtio_vsock.h
> > >index 748633aa0cc81..bf28e8e32e280 100644
> > >--- a/include/linux/virtio_vsock.h
> > >+++ b/include/linux/virtio_vsock.h
> > >@@ -287,12 +287,14 @@ void virtio_transport_recv_pkt(struct virtio_transport *t,
> > >  * Initialize a batch to zero before use. A non-empty batch owns @sk's socket
> > >  * lock and the reference returned by vsock_find_connected_socket_net(). The
> > >  * caller retains both until it calls virtio_transport_rx_batch_finish(). An
> > >- * empty batch owns neither.
> > >+ * empty batch owns neither. A pending native write-space notification belongs
> > >+ * to the lock holder and is delivered by virtio_transport_rx_batch_finish().
> > >  */
> > > struct virtio_transport_rx_batch {
> > >       struct sock *sk;
> > >       unsigned int pkts;
> > >       size_t bytes;
> > >+      bool write_space_pending;
> > > };
> > >
> > > static inline bool
> > >diff --git a/include/net/af_vsock.h b/include/net/af_vsock.h
> > >index 5549298c1ec6b..b76ab565ea58b 100644
> > >--- a/include/net/af_vsock.h
> > >+++ b/include/net/af_vsock.h
> > >@@ -63,6 +63,11 @@ struct vsock_sock {
> > >       u32 peer_shutdown;
> > >       bool sent_request;
> > >       bool ignore_connecting_rst;
> > >+      /*
> > >+       * Captured before the socket is published. This identifies AF_VSOCK's
> > >+       * native write-space callback after a consumer has replaced it.
> > >+       */
> > >+      void (*native_write_space)(struct sock *sk);
> > >
> > >       /* Protected by lock_sock(sk) */
> > >       u64 buffer_size;
> > >@@ -78,6 +83,8 @@ s64 vsock_stream_has_data(struct vsock_sock *vsk);
> > > s64 vsock_stream_has_space(struct vsock_sock *vsk);
> > > struct sock *vsock_create_connected(struct sock *parent);
> > > void vsock_data_ready(struct sock *sk);
> > >+bool vsock_write_space_is_native(const struct sock *sk);
> > >+void vsock_call_native_write_space(struct sock *sk);
> > >
> > > /**** TRANSPORT ****/
> > >
> > >diff --git a/net/vmw_vsock/af_vsock.c b/net/vmw_vsock/af_vsock.c
> > >index 44cee74519555..e39567990539f 100644
> > >--- a/net/vmw_vsock/af_vsock.c
> > >+++ b/net/vmw_vsock/af_vsock.c
> > >@@ -958,6 +958,7 @@ static struct sock *__vsock_create(struct net *net,
> > >               sk->sk_type = type;
> > >
> > >       vsk = vsock_sk(sk);
> > >+      vsk->native_write_space = sk->sk_write_space;
> > >       vsock_addr_init(&vsk->local_addr, VMADDR_CID_ANY, VMADDR_PORT_ANY);
> > >       vsock_addr_init(&vsk->remote_addr, VMADDR_CID_ANY, VMADDR_PORT_ANY);
> > >
> > >@@ -1122,6 +1123,21 @@ void vsock_data_ready(struct sock *sk)
> > > }
> > > EXPORT_SYMBOL_GPL(vsock_data_ready);
> > >
> > >+bool vsock_write_space_is_native(const struct sock *sk)
> > >+{
> > >+      const struct vsock_sock *vsk = vsock_sk(sk);
> > >+
> > >+      return READ_ONCE(sk->sk_write_space) ==
> > >+             READ_ONCE(vsk->native_write_space);
> > >+}
> > >+EXPORT_SYMBOL_GPL(vsock_write_space_is_native);
> > >+
> > >+void vsock_call_native_write_space(struct sock *sk)
> > >+{
> > >+      vsock_sk(sk)->native_write_space(sk);
> > >+}
> > >+EXPORT_SYMBOL_GPL(vsock_call_native_write_space);
> > >+
> > > /* Dummy callback required by sockmap.
> > >  * See unconditional call of saved_close() in sock_map_close().
> > >  */
> > >diff --git a/net/vmw_vsock/virtio_transport_common.c b/net/vmw_vsock/virtio_transport_common.c
> > >index f83e5b2edce35..af26344678e41 100644
> > >--- a/net/vmw_vsock/virtio_transport_common.c
> > >+++ b/net/vmw_vsock/virtio_transport_common.c
> > >@@ -1865,31 +1865,55 @@ virtio_transport_rx_batch_can_continue(struct virtio_transport *t,
> > >              !virtio_transport_rx_buf_full(vvs);
> > > }
> > >
> > >-/* The caller holds sk's socket lock. */
> > >+/* The caller holds sk's socket and callback locks. */
> > > static bool
> > >-virtio_transport_rx_batch_can_receive(struct virtio_transport *t,
> > >-                                    struct sock *sk, u32 len)
> > >+__virtio_transport_rx_batch_can_receive(struct virtio_transport *t,
> > >+                                      struct sock *sk, u32 len)
> > > {
> > >       if (!virtio_transport_rx_batch_can_continue(t, sk, len))
> > >               return false;
> > >
> > >       /*
> > >-       * Sockmap can replace sk_prot and publish a psock without the socket lock.
> > >-       * Check both at each packet boundary; a boundary that sees a replacement
> > >-       * returns to the existing per-packet path.
> > >+       * Sockmap can replace sk_prot or sk_write_space, and publish a psock,
> > >+       * without the socket lock. Coalescing is safe only for the native
> > >+       * write-space callback, so a boundary that sees a replacement returns to
> > >+       * the existing per-packet path.
> > >        */
> > >       return READ_ONCE(sk->sk_prot) == sk->sk_prot_creator &&
> > >+             vsock_write_space_is_native(sk) &&
> >
> > I'm confused, why for sk_prot we are doing the check here, while for
> > sk_write_space we need a new API?
> >
> 
> sk_prot can be compared with sk_prot_creator. sk_write_space
> has no field like that, and sock_def_write_space() is static.
> I save the callback in __vsock_create(), after the socket is
> initialized and before it is published. The helpers compare
> against that pointer and call it.
> 
> > >              !virtio_transport_sock_has_psock(sk);
> > > }
> > >
> > >+/*
> > >+ * Sockmap teardown restores the native protocol and write-space callback
> > >+ * under sk_callback_lock. Serialize each packet admission check with those
> > >+ * updates.
> > >+ */
> > >+static bool
> > >+virtio_transport_rx_batch_can_receive(struct virtio_transport *t,
> > >+                                    struct sock *sk, u32 len)
> > >+{
> > >+      bool batchable;
> > >+
> > >+      read_lock_bh(&sk->sk_callback_lock);
> > >+      batchable = __virtio_transport_rx_batch_can_receive(t, sk, len);
> > >+      read_unlock_bh(&sk->sk_callback_lock);
> > >+
> > >+      return batchable;
> > >+}
> > >+
> > > /*
> > >  * The caller holds sk's socket lock. If @batchable is non-NULL, update it
> > >  * after processing @skb to say whether a native STREAM/RW batch can continue.
> > >+ * When @batch is non-NULL, record a native write-space notification for batch
> > >+ * finish. A writer cannot consume the updated credit until this lock is
> > >+ * released.
> > >  */
> > > static void
> > > virtio_transport_recv_pkt_locked(struct virtio_transport *t,
> > >                                struct sk_buff *skb, struct sock *sk,
> > >-                               struct net *net, bool *batchable)
> > >+                               struct net *net, bool *batchable,
> > >+                               struct virtio_transport_rx_batch *batch)
> >
> > Do we really need bot batchable and batch ?
> >
> 
> Agreed, we don't. I'll clean that up in the next version. Thanks
> 
> > > {
> > >       struct virtio_vsock_hdr *hdr = virtio_vsock_hdr(skb);
> > >       struct vsock_sock *vsk = vsock_sk(sk);
> > >@@ -1921,8 +1945,12 @@ virtio_transport_recv_pkt_locked(struct virtio_transport *t,
> > >       if (vsk->local_addr.svm_cid != VMADDR_CID_ANY)
> > >               vsk->local_addr.svm_cid = le64_to_cpu(hdr->dst_cid);
> > >
> > >-      if (space_available)
> > >-              sk->sk_write_space(sk);
> > >+      if (space_available) {
> > >+              if (batch)
> > >+                      batch->write_space_pending = true;
> > >+              else
> > >+                      sk->sk_write_space(sk);
> > >+      }
> > >
> > >       switch (sk->sk_state) {
> > >       case TCP_LISTEN:
> > >@@ -1947,7 +1975,7 @@ virtio_transport_recv_pkt_locked(struct virtio_transport *t,
> > >       }
> > >
> > >       if (batchable)
> > >-              *batchable = virtio_transport_rx_batch_can_receive(t, sk, 0);
> > >+              *batchable = virtio_transport_rx_batch_can_continue(t, sk, 0);
> >
> > Why this change?
> >
> 
> This runs after the packet has been handled. can_receive() decides
> whether a packet may be processed in the batch, so I do not call it
> again here. can_continue() checks whether the socket state, type,
> transport, and RX limits still allow the batch to remain active. If it
> returns false, the caller releases the socket lock and drops the
> connected reference.
> 
> A change to sk_prot, sk_write_space, or the psock is seen by
> can_receive() before the next packet is processed, and that packet takes
> the regular path.

I think squashing would avoid the churn.

> 
> > > }
> > >
> > > /* We are under the virtio-vsock's vsock->rx_lock or vhost-vsock's vq->mutex
> > >@@ -1991,7 +2019,7 @@ void virtio_transport_recv_pkt(struct virtio_transport *t,
> > >               goto free_pkt;
> > >
> > >       lock_sock(sk);
> > >-      virtio_transport_recv_pkt_locked(t, skb, sk, net, NULL);
> > >+      virtio_transport_recv_pkt_locked(t, skb, sk, net, NULL, NULL);
> > >
> > >       release_sock(sk);
> > >
> > >@@ -2008,20 +2036,31 @@ EXPORT_SYMBOL_GPL(virtio_transport_recv_pkt);
> > >
> > > /*
> > >  * Release an active RX batch. A non-empty batch holds the socket lock and the
> > >- * reference returned by vsock_find_connected_socket_net(). An empty batch
> > >- * holds neither.
> > >+ * reference returned by vsock_find_connected_socket_net(). Deliver any
> > >+ * deferred native write-space notification while holding the lock, preserving
> > >+ * the callback context of the regular receive path. An empty batch holds
> > >+ * neither.
> > >  */
> > > void virtio_transport_rx_batch_finish(struct virtio_transport_rx_batch *batch)
> > > {
> > >+      bool write_space_pending = batch->write_space_pending;
> > >       struct sock *sk = batch->sk;
> > >
> > >       batch->sk = NULL;
> > >       batch->pkts = 0;
> > >       batch->bytes = 0;
> > >+      batch->write_space_pending = false;
> > >
> > >       if (!sk)
> > >               return;
> > >
> > >+      /*
> > >+       * The packet was admitted with the native callback. Do not reload a current
> > >+       * callback here: sockmap can replace or remove its wrapper independently.
> > >+       */
> > >+      if (write_space_pending)
> > >+              vsock_call_native_write_space(sk);
> > >+
> > >       release_sock(sk);
> > >       sock_put(sk);
> > > }
> > >@@ -2080,7 +2119,8 @@ virtio_transport_rx_batch_process(struct virtio_transport *t,
> > >               return;
> > >       }
> > >
> > >-      virtio_transport_recv_pkt_locked(t, skb, batch->sk, net, &batchable);
> > >+      virtio_transport_recv_pkt_locked(t, skb, batch->sk, net, &batchable,
> > >+                                       batch);
> > >       if (!batchable) {
> > >               virtio_transport_rx_batch_finish(batch);
> > >               return;
> > >@@ -2158,16 +2198,8 @@ void virtio_transport_recv_pkt_batch(struct virtio_transport *t,
> > >       }
> > >
> > >       lock_sock(sk);
> > >-      /*
> > >-       * Serialize initial admission with sockmap's callback updates. Later
> > >-       * packet boundaries recheck native state and end a batch when they
> > >-       * observe a replacement.
> > >-       */
> > >-      read_lock_bh(&sk->sk_callback_lock);
> > >       batchable = virtio_transport_rx_batch_can_receive(t, sk, len);
> > >-      read_unlock_bh(&sk->sk_callback_lock);
> >
> > Can we avoid this change and do this in the previous patch?
> >
> > Please avoid as much as you can change code introduced in the same series.
> >
> 
> Sure, understood.
> 
> > >       if (!batchable) {
> > >-              /* State or receive-buffer failures keep the regular lookup path. */
> >
> > Why removing this comment just added by previous patch?
> >
> 
> This patch adds a replaced sk_write_space as another reason for
> can_receive() to return false, and that case does not take the regular
> lookup path. I removed the old comment because it no longer
> described the distinction completely, but I forgot to add the replacement.
> Sorry about that, and thanks for catching it.
> 
> > >               if (!virtio_transport_rx_batch_can_continue(t, sk, len)) {
> > >                       release_sock(sk);
> > >                       sock_put(sk);
> > >@@ -2176,7 +2208,7 @@ void virtio_transport_recv_pkt_batch(struct virtio_transport *t,
> > >
> > >               virtio_transport_trace_recv_pkt(hdr, &src, &dst);
> > >               if (virtio_transport_recv_pkt_set_owner(skb, sk))
> > >-                      virtio_transport_recv_pkt_locked(t, skb, sk, net, NULL);
> > >+                      virtio_transport_recv_pkt_locked(t, skb, sk, net, NULL, NULL);
> > >               else
> > >                       kfree_skb(skb);
> > >
> > >--
> > >2.53.0
> > >
> >


Thanks,
Bobby
