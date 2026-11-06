Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.219.44
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793969396;
	b=EiryxkUnvU7v3zGHbjx2d3sLzOKhYWvPI08tEiqHF6zIeQOyPAB96BadVuNYBOBMsIuC
	 QJ1u5h2Cr9mEIWBGT0GQjyxkklUJGNKFcPN76a1aAOR8lVljZFVvLokdO96Fz7IxAmff5
	 6GsNN5NEjzw101CQpc2n0+CiGXpoEolzuHnysQpHAAhX9OgPo0Dk62FmEaWfWfdvJ5aUp
	 ZJ67assYdmpLvZPpqWSweuAlqmvQ3wZz/8UtrsG5APtyvBqQhtiGm8hfqqvurYW3pTTEA
	 2hn9qnHGq6Lt5Erlf234IFhFg/xbuXCoX+tyoSR80GRQW6SO0DqGH+foaPFJPH0NpVA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793969396;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type;
	bh=Ql1vweFXSSIABJRGgCKJ7ySaThUqod8WTR7/LezFQMM=;
	b=L+sRSA8r6BzA1kmVdhdoGsrFgmX5eXXj02W7r5y1oInC2Okt3+VFFiWMLcdv1MwQ1pRn
	 /rl92pAxpU7cWdPVNDmayAc5FN/Ogyfs1S8VUPVv62O6rdSvTEAqRvBe8Tj+WocmKq6bK
	 lvjE4jmNTnLPDtum+3s8ZtcWljnAV7GsEpK0ZOwzmMzgILp4ePOq+i3tqGSitSdgTnVR7
	 M+G4ZFSFDzWoYAsqt+EqJ10Mu6cVeVYlzxZGg1ws1Phhyo5u75Q4Bj8kh+/p+q6ND7/0k
	 C7crYhQ5qa3n1DFCkSFyzO88zBbNt9Pnni5RzHqvWtqprcFpTxgNlJI2OK+5aSJJUoQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=OFp1bPbC;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.219.44
Received: from mail-qv1-f44.google.com (mail-qv1-f44.google.com [209.85.219.44])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97DD6606A336
	for <virtualization@lists.linux.dev>; Fri,  6 Nov 2026 12:49:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 97DD6606A336
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=OFp1bPbC
Received: by mail-qv1-f44.google.com with SMTP id 6a1803df08f44-91ea3f6a506so5066526d6.0
        for <virtualization@lists.linux.dev>; Fri, 06 Nov 2026 04:49:55 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793969394; cv=none;
        d=google.com; s=arc-20260327;
        b=N3w39XormIN8cxGk33AF5TDWsGUGWWccEqjF/fzvF/7vgShiZWVOhVFzLbFMU/smeg
         k0WmgBP6/vRAOOFrYiDfIZIbuEKBycXWyEjouaJTBYQBJszyCqEZQvmndm/7i0+HNWeD
         bZ37Jzz8fbt4tDSY5tKj1vuHbNNDzqc/iz5xwg/A5AaSM02d2rj8Y/F2+DtX1Ni4CW4z
         TlYSTEQI0DXeFdbfrThqcIpCs5S5BvkIF6s64LXpHB9qV1FJtf/ueW/ck8SnBdreaYOu
         U/WtSUGzr0Idx38qEh2r7quYafQpb5ctbG/ZiAOdw3QXOAJ2ldQeuGv5aqLDn3QbnJDi
         J4/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=Ql1vweFXSSIABJRGgCKJ7ySaThUqod8WTR7/LezFQMM=;
        fh=fbVNP92qpFMGV3wlEPWWQChfxbWebhXrrZ05QRu2pjI=;
        b=esw7UGHo3Oo08VHRy9gxLYU5h0YSQk+6h1P28mhzVO+1CJ9BjZGmb+kSsINqvV91f1
         zttyX0UeoYjWfaZ4iIrdRJN+Z+AXBA6z7iMSzZdDZm+yyqR/RB9maQ+t9GuictwUaojU
         a7tvrLe7WfjwyR2fXH4v8KT6YgGZTBBnr7gZ5j8fs97Om4+/1gwCQ5AlOZyJEjixLhb8
         Zcy0ft9rPgYvlitfPJvQNyjFJh8ebBb/YkyhuupGlz3MiYpjxZbR7v6vOyiAKHWcCnpU
         EfL6Sm5DKYHUTKtGhI3D8Q4ms++aDnKtn5axlfzprgQBtwAsUk3p1p4Qfq3AYc4Xonh7
         DOoA==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793969394; x=1794574194; darn=lists.linux.dev;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Ql1vweFXSSIABJRGgCKJ7ySaThUqod8WTR7/LezFQMM=;
        b=OFp1bPbCXnlsSEJjNySC6ANB6oj4ZXqIaXAXT5OGmSQIIHTfxASHjRlLadsO4T9ZpN
         J/s3w8LMEpsTcrie+FB+b5J1XAsgo6Ckas2gU2xHpI3UYcRKmf1202BVXf0CkFc/GHJI
         3yKrmCp+QV7Dldvb7nCRjQfUc7joG8rqLVAc/9uexlXyLaAdwEId5UmQlOMR8dM8UM9A
         BsPImVmYyRANRSAy5DmsbKbjoFVWVx16GQLDN7FSA9yZrsHOVXXAzpl+ua5N/zgBckse
         XLFHHHSkJG1/9jtaaqFZe+2/owkNXankIBt3fH3zlDVBINTRMcXY5MYzEdX751oVOqEA
         z1xQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793969394; x=1794574194;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=Ql1vweFXSSIABJRGgCKJ7ySaThUqod8WTR7/LezFQMM=;
        b=hsp7xIpZLB3OzrZhL5EbBRx2/A3vi7siw/trIx2HUl/+rQJ0SOmR0wEkCLMSt8zImp
         NM7tqPssZ/8cDmJde4AbFOymm9nlshIuG7xgMPV6xEEfN1aupHyQ3fdAJg8Mi2uqbe+Z
         QnJnPxqtJF8RULx84Ae3bbPcNRHlMv4EH73+dpt3r3AnXUkXVYEWgLLSUauQ4OK0Mmxb
         YijZhnr+DkVTh44kjBZMy+MT3L683UJholzEOCMIeUeL+FpzivCG9FYXvLvW3eq6ThsF
         tCRK8lBYqBYJRb310BBhN+UGh7EKSykjyve9BsyLK2RtVXXAhcP9h/qNCqgEI3iI9IVo
         I0uA==
X-Forwarded-Encrypted: i=1; AKwUvBwEbxCJKCJkW8m4gCIJ7MVBrkPZ9OyaqH8J3DJVTMOSwMEZGpvz1CmHMe8LWay9AN0QEOKpdN+DUGCIg1J5zQ==@lists.linux.dev
X-Gm-Message-State: APuU4Z9XZcJ7/8Q1rEE0G2JLLY5sbIH7IZPuRvFmQwJKS5ocunK1XHAY
	SF5LSOjfJldhq8TqQUuU4IwRMzZbT979vKJUYqyEk+vbczx0D3Vejbr01+rLruCQYnIg+g0f5jb
	714VRRRJhRb7IIftH+atxNpTbXvxeZRY=
X-Gm-Gg: AYBFou32au1j5/21oaTjJjsoGvGlua+swZvUSCeNx6rKCbV0cQbk23vJWJLw1bAzoz9
	b3fZ/ML8uk5dftw2KAG7GfrW3q3/cWXxwbvyhDnUGfPMxqC7wXtuKiIcxOQ9sgSJmWzmbKy1jPy
	KI8RgiiElGSxGDG0mtrLqiYBtGOw7zGyGq4j0f7AMLbtxKt6bq68N+1eaqfTOzKiFAv9J4Ucc8L
	t0x3wGQmUK180J1QE4MutkLO2s9BXK1rOUQlaMhFM0LOx05o199DP68MVPjSlssX7A2jhKHzQ9u
	M6kBX2bSAzfX8OukAignEQRMocrHlGxB1mJnGKcWR70idSDGLztNqd1j+CjF2yHMCSldVBdZGIF
	gkNeo+0FgdiPeW637yriRQ60B3NcYlUEcR7Px9jHywVCGtkT+D3o1T36g/prbqAL8aH6MVmI=
X-Received: by 2002:a05:620a:4625:b0:93c:b6db:8c with SMTP id
 af79cd13be357-945f30f6664mr336286985a.0.1793969393559; Fri, 06 Nov 2026
 04:49:53 -0800 (PST)
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
In-Reply-To: <auxHe77Kv3tS4hjJ@sgarzare-redhat>
From: Jia Jia <physicalmtea@gmail.com>
Date: Fri, 6 Nov 2026 20:49:17 +0800
X-Gm-Features: AclHuK_QtueXaRNewXH7OKM_lsXfBvblIkUbLisG9xyL696W5gCFim8GYHYdd4g
Message-ID: <CAJwVaMK6UpxOmCbuzGK15h+DhN5H6cj6cy-=gCHtSxoVbLfzwA@mail.gmail.com>
Subject: Re: [PATCH net-next v5 4/5] vsock/virtio: coalesce native RX
 write-space notifications
To: Stefano Garzarella <sgarzare@redhat.com>
Cc: netdev@vger.kernel.org, stefanha@redhat.com, bobbyeshleman@gmail.com, 
	mst@redhat.com, jasowangio@gmail.com, eperezma@redhat.com, 
	xuanzhuo@linux.alibaba.com, davem@davemloft.net, edumazet@google.com, 
	kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, kvm@vger.kernel.org, 
	virtualization@lists.linux.dev, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

>
> On Tue, Nov 03, 2026 at 12:11:33PM +0800, Jia Jia wrote:
> >Each received packet can update peer credit and call sk_write_space(). A
> >writer cannot consume that credit while the virtio RX worker retains the
> >socket lock, so repeated native write-space notifications in one RX batch
> >are unnecessary.
> >
> >This patch coalesces write-space notifications on the native AF_VSOCK path;
> >data-ready remains per-packet here.
> >
> >The batching patch establishes batch ownership before its first packet.
> >This lets this patch record a pending notification for that packet and
> >flush it even if the packet immediately ends the batch. Deliver it while
> >holding the socket lock to preserve the callback context of the existing
> >receive path. A following patch changes that timing together with
> >data-ready handling.
>
> Can you report performance data related to this patch also here?
>
> IIUC this is not giving a lot of advantage, so my question is if this
> more complexity really add a value for us.
>

Sure. The performance tests currently cover patches 4 and 5 together,
so I will include those results here.

They do not add another broad throughput improvement. I kept the
combined notification change because of the cycles/byte results.

With P1-P3 only, against baseline:

  Buffer size  baseline cycles/B  PATCH cycles/B  cycles change (95% CI)
  64B        66.728    61.220  -8.25% [-18.99%, +3.91%]
  256B       14.363    14.515  +1.06% [ -4.22%, +6.64%]
  512B        7.792     7.578  -2.74% [ -6.55%, +1.23%]
  1K          3.988     4.032  +1.09% [ -1.64%, +3.88%]
  4K          2.063     1.973  -4.38% [ -8.23%, -0.37%]
  8K          1.702     1.667  -2.06% [ -7.99%, +4.25%]
  16K         1.473     1.475  +0.17% [ -5.06%, +5.68%]
  64K         1.385     1.358  -1.96% [-10.61%, +7.53%]

Only the 4K interval excluded zero. With the full series, against
baseline:

  Buffer size  baseline cycles/B  PATCH cycles/B  cycles change (95% CI)
  64B        65.282    57.843  -11.40% [-13.77%, -8.95%]
  256B       14.710    13.813   -6.10% [ -7.89%, -4.28%]
  512B        7.709     7.188   -6.75% [ -8.79%, -4.66%]
  1K          4.075     3.862   -5.23% [ -6.80%, -3.63%]
  4K          2.034     1.887   -7.21% [ -8.67%, -5.72%]
  8K          1.664     1.568   -5.78% [ -7.83%, -3.69%]
  16K         1.450     1.385   -4.48% [ -6.08%, -2.86%]
  64K         1.338     1.317   -1.51% [ -3.21%, +0.22%]

From 64B through 16K those intervals stay below zero. 64B through 1K
did not show that in the P1-P3 run.

This is also why I spent the time making this work with sockmap.

The value I see is lower RX CPU cost, not another large throughput
gain. I am still unsure the extra code is worth it, and I would like
your opinion.

Thanks,
Jia

> >
> >Capture the native write-space callback before socket publication and
> >access it through AF_VSOCK helpers. Sockmap can change the protocol,
> >write-space callback, and psock marker without the socket lock. Serialize
> >each batch eligibility check with sk_callback_lock; if a packet boundary
> >observes a replacement, finish the batch and use the regular per-packet
> >path.
> >
> >Packets admitted on the native path use the saved native callback at batch
> >finish. Reloading a current sockmap callback would not synchronize its
> >invocation with teardown; a wrapper seen before teardown need not forward
> >the native wakeup after its psock is gone.
>
> I really don't understand the goal of this patch, and why we need to
> store the "native" sk_write_space.
>

Actually, I kept this as a separate patch so the two notification changes
could be tested separately. This patch provides a complete intermediate
state: it coalesces native sk_write_space() notifications while keeping the
callback invocation under the socket lock. Patch 5 then coalesces
sk_data_ready() and moves both deferred callbacks after release_sock().

The coalescing is limited to packets for which can_receive() sees
sk_write_space still set to the native callback. That callback wakes waiters.
The sockmap wrapper can also schedule psock work before forwarding
the saved callback, so I do not coalesce it.

Batch finish also needs the saved pointer if the callback changes before
the batch ends. If another packet arrives, can_receive() detects the
replacement
and its caller finishes the batch. A write-space notification already
recorded for
the batch still uses the native callback.

Reloading sk->sk_write_space at finish could capture the sockmap wrapper just
before teardown. If teardown removes the psock before the callback is invoked,
the wrapper no longer forwards the native wakeup.

> >
> >Signed-off-by: Jia Jia <physicalmtea@gmail.com>
> >---
> > include/linux/virtio_vsock.h            |  4 +-
> > include/net/af_vsock.h                  |  7 +++
> > net/vmw_vsock/af_vsock.c                | 16 +++++
> > net/vmw_vsock/virtio_transport_common.c | 78 +++++++++++++++++--------
> > 4 files changed, 81 insertions(+), 24 deletions(-)
> >
> >diff --git a/include/linux/virtio_vsock.h b/include/linux/virtio_vsock.h
> >index 748633aa0cc81..bf28e8e32e280 100644
> >--- a/include/linux/virtio_vsock.h
> >+++ b/include/linux/virtio_vsock.h
> >@@ -287,12 +287,14 @@ void virtio_transport_recv_pkt(struct virtio_transport *t,
> >  * Initialize a batch to zero before use. A non-empty batch owns @sk's socket
> >  * lock and the reference returned by vsock_find_connected_socket_net(). The
> >  * caller retains both until it calls virtio_transport_rx_batch_finish(). An
> >- * empty batch owns neither.
> >+ * empty batch owns neither. A pending native write-space notification belongs
> >+ * to the lock holder and is delivered by virtio_transport_rx_batch_finish().
> >  */
> > struct virtio_transport_rx_batch {
> >       struct sock *sk;
> >       unsigned int pkts;
> >       size_t bytes;
> >+      bool write_space_pending;
> > };
> >
> > static inline bool
> >diff --git a/include/net/af_vsock.h b/include/net/af_vsock.h
> >index 5549298c1ec6b..b76ab565ea58b 100644
> >--- a/include/net/af_vsock.h
> >+++ b/include/net/af_vsock.h
> >@@ -63,6 +63,11 @@ struct vsock_sock {
> >       u32 peer_shutdown;
> >       bool sent_request;
> >       bool ignore_connecting_rst;
> >+      /*
> >+       * Captured before the socket is published. This identifies AF_VSOCK's
> >+       * native write-space callback after a consumer has replaced it.
> >+       */
> >+      void (*native_write_space)(struct sock *sk);
> >
> >       /* Protected by lock_sock(sk) */
> >       u64 buffer_size;
> >@@ -78,6 +83,8 @@ s64 vsock_stream_has_data(struct vsock_sock *vsk);
> > s64 vsock_stream_has_space(struct vsock_sock *vsk);
> > struct sock *vsock_create_connected(struct sock *parent);
> > void vsock_data_ready(struct sock *sk);
> >+bool vsock_write_space_is_native(const struct sock *sk);
> >+void vsock_call_native_write_space(struct sock *sk);
> >
> > /**** TRANSPORT ****/
> >
> >diff --git a/net/vmw_vsock/af_vsock.c b/net/vmw_vsock/af_vsock.c
> >index 44cee74519555..e39567990539f 100644
> >--- a/net/vmw_vsock/af_vsock.c
> >+++ b/net/vmw_vsock/af_vsock.c
> >@@ -958,6 +958,7 @@ static struct sock *__vsock_create(struct net *net,
> >               sk->sk_type = type;
> >
> >       vsk = vsock_sk(sk);
> >+      vsk->native_write_space = sk->sk_write_space;
> >       vsock_addr_init(&vsk->local_addr, VMADDR_CID_ANY, VMADDR_PORT_ANY);
> >       vsock_addr_init(&vsk->remote_addr, VMADDR_CID_ANY, VMADDR_PORT_ANY);
> >
> >@@ -1122,6 +1123,21 @@ void vsock_data_ready(struct sock *sk)
> > }
> > EXPORT_SYMBOL_GPL(vsock_data_ready);
> >
> >+bool vsock_write_space_is_native(const struct sock *sk)
> >+{
> >+      const struct vsock_sock *vsk = vsock_sk(sk);
> >+
> >+      return READ_ONCE(sk->sk_write_space) ==
> >+             READ_ONCE(vsk->native_write_space);
> >+}
> >+EXPORT_SYMBOL_GPL(vsock_write_space_is_native);
> >+
> >+void vsock_call_native_write_space(struct sock *sk)
> >+{
> >+      vsock_sk(sk)->native_write_space(sk);
> >+}
> >+EXPORT_SYMBOL_GPL(vsock_call_native_write_space);
> >+
> > /* Dummy callback required by sockmap.
> >  * See unconditional call of saved_close() in sock_map_close().
> >  */
> >diff --git a/net/vmw_vsock/virtio_transport_common.c b/net/vmw_vsock/virtio_transport_common.c
> >index f83e5b2edce35..af26344678e41 100644
> >--- a/net/vmw_vsock/virtio_transport_common.c
> >+++ b/net/vmw_vsock/virtio_transport_common.c
> >@@ -1865,31 +1865,55 @@ virtio_transport_rx_batch_can_continue(struct virtio_transport *t,
> >              !virtio_transport_rx_buf_full(vvs);
> > }
> >
> >-/* The caller holds sk's socket lock. */
> >+/* The caller holds sk's socket and callback locks. */
> > static bool
> >-virtio_transport_rx_batch_can_receive(struct virtio_transport *t,
> >-                                    struct sock *sk, u32 len)
> >+__virtio_transport_rx_batch_can_receive(struct virtio_transport *t,
> >+                                      struct sock *sk, u32 len)
> > {
> >       if (!virtio_transport_rx_batch_can_continue(t, sk, len))
> >               return false;
> >
> >       /*
> >-       * Sockmap can replace sk_prot and publish a psock without the socket lock.
> >-       * Check both at each packet boundary; a boundary that sees a replacement
> >-       * returns to the existing per-packet path.
> >+       * Sockmap can replace sk_prot or sk_write_space, and publish a psock,
> >+       * without the socket lock. Coalescing is safe only for the native
> >+       * write-space callback, so a boundary that sees a replacement returns to
> >+       * the existing per-packet path.
> >        */
> >       return READ_ONCE(sk->sk_prot) == sk->sk_prot_creator &&
> >+             vsock_write_space_is_native(sk) &&
>
> I'm confused, why for sk_prot we are doing the check here, while for
> sk_write_space we need a new API?
>

sk_prot can be compared with sk_prot_creator. sk_write_space
has no field like that, and sock_def_write_space() is static.
I save the callback in __vsock_create(), after the socket is
initialized and before it is published. The helpers compare
against that pointer and call it.

> >              !virtio_transport_sock_has_psock(sk);
> > }
> >
> >+/*
> >+ * Sockmap teardown restores the native protocol and write-space callback
> >+ * under sk_callback_lock. Serialize each packet admission check with those
> >+ * updates.
> >+ */
> >+static bool
> >+virtio_transport_rx_batch_can_receive(struct virtio_transport *t,
> >+                                    struct sock *sk, u32 len)
> >+{
> >+      bool batchable;
> >+
> >+      read_lock_bh(&sk->sk_callback_lock);
> >+      batchable = __virtio_transport_rx_batch_can_receive(t, sk, len);
> >+      read_unlock_bh(&sk->sk_callback_lock);
> >+
> >+      return batchable;
> >+}
> >+
> > /*
> >  * The caller holds sk's socket lock. If @batchable is non-NULL, update it
> >  * after processing @skb to say whether a native STREAM/RW batch can continue.
> >+ * When @batch is non-NULL, record a native write-space notification for batch
> >+ * finish. A writer cannot consume the updated credit until this lock is
> >+ * released.
> >  */
> > static void
> > virtio_transport_recv_pkt_locked(struct virtio_transport *t,
> >                                struct sk_buff *skb, struct sock *sk,
> >-                               struct net *net, bool *batchable)
> >+                               struct net *net, bool *batchable,
> >+                               struct virtio_transport_rx_batch *batch)
>
> Do we really need bot batchable and batch ?
>

Agreed, we don't. I'll clean that up in the next version. Thanks

> > {
> >       struct virtio_vsock_hdr *hdr = virtio_vsock_hdr(skb);
> >       struct vsock_sock *vsk = vsock_sk(sk);
> >@@ -1921,8 +1945,12 @@ virtio_transport_recv_pkt_locked(struct virtio_transport *t,
> >       if (vsk->local_addr.svm_cid != VMADDR_CID_ANY)
> >               vsk->local_addr.svm_cid = le64_to_cpu(hdr->dst_cid);
> >
> >-      if (space_available)
> >-              sk->sk_write_space(sk);
> >+      if (space_available) {
> >+              if (batch)
> >+                      batch->write_space_pending = true;
> >+              else
> >+                      sk->sk_write_space(sk);
> >+      }
> >
> >       switch (sk->sk_state) {
> >       case TCP_LISTEN:
> >@@ -1947,7 +1975,7 @@ virtio_transport_recv_pkt_locked(struct virtio_transport *t,
> >       }
> >
> >       if (batchable)
> >-              *batchable = virtio_transport_rx_batch_can_receive(t, sk, 0);
> >+              *batchable = virtio_transport_rx_batch_can_continue(t, sk, 0);
>
> Why this change?
>

This runs after the packet has been handled. can_receive() decides
whether a packet may be processed in the batch, so I do not call it
again here. can_continue() checks whether the socket state, type,
transport, and RX limits still allow the batch to remain active. If it
returns false, the caller releases the socket lock and drops the
connected reference.

A change to sk_prot, sk_write_space, or the psock is seen by
can_receive() before the next packet is processed, and that packet takes
the regular path.

> > }
> >
> > /* We are under the virtio-vsock's vsock->rx_lock or vhost-vsock's vq->mutex
> >@@ -1991,7 +2019,7 @@ void virtio_transport_recv_pkt(struct virtio_transport *t,
> >               goto free_pkt;
> >
> >       lock_sock(sk);
> >-      virtio_transport_recv_pkt_locked(t, skb, sk, net, NULL);
> >+      virtio_transport_recv_pkt_locked(t, skb, sk, net, NULL, NULL);
> >
> >       release_sock(sk);
> >
> >@@ -2008,20 +2036,31 @@ EXPORT_SYMBOL_GPL(virtio_transport_recv_pkt);
> >
> > /*
> >  * Release an active RX batch. A non-empty batch holds the socket lock and the
> >- * reference returned by vsock_find_connected_socket_net(). An empty batch
> >- * holds neither.
> >+ * reference returned by vsock_find_connected_socket_net(). Deliver any
> >+ * deferred native write-space notification while holding the lock, preserving
> >+ * the callback context of the regular receive path. An empty batch holds
> >+ * neither.
> >  */
> > void virtio_transport_rx_batch_finish(struct virtio_transport_rx_batch *batch)
> > {
> >+      bool write_space_pending = batch->write_space_pending;
> >       struct sock *sk = batch->sk;
> >
> >       batch->sk = NULL;
> >       batch->pkts = 0;
> >       batch->bytes = 0;
> >+      batch->write_space_pending = false;
> >
> >       if (!sk)
> >               return;
> >
> >+      /*
> >+       * The packet was admitted with the native callback. Do not reload a current
> >+       * callback here: sockmap can replace or remove its wrapper independently.
> >+       */
> >+      if (write_space_pending)
> >+              vsock_call_native_write_space(sk);
> >+
> >       release_sock(sk);
> >       sock_put(sk);
> > }
> >@@ -2080,7 +2119,8 @@ virtio_transport_rx_batch_process(struct virtio_transport *t,
> >               return;
> >       }
> >
> >-      virtio_transport_recv_pkt_locked(t, skb, batch->sk, net, &batchable);
> >+      virtio_transport_recv_pkt_locked(t, skb, batch->sk, net, &batchable,
> >+                                       batch);
> >       if (!batchable) {
> >               virtio_transport_rx_batch_finish(batch);
> >               return;
> >@@ -2158,16 +2198,8 @@ void virtio_transport_recv_pkt_batch(struct virtio_transport *t,
> >       }
> >
> >       lock_sock(sk);
> >-      /*
> >-       * Serialize initial admission with sockmap's callback updates. Later
> >-       * packet boundaries recheck native state and end a batch when they
> >-       * observe a replacement.
> >-       */
> >-      read_lock_bh(&sk->sk_callback_lock);
> >       batchable = virtio_transport_rx_batch_can_receive(t, sk, len);
> >-      read_unlock_bh(&sk->sk_callback_lock);
>
> Can we avoid this change and do this in the previous patch?
>
> Please avoid as much as you can change code introduced in the same series.
>

Sure, understood.

> >       if (!batchable) {
> >-              /* State or receive-buffer failures keep the regular lookup path. */
>
> Why removing this comment just added by previous patch?
>

This patch adds a replaced sk_write_space as another reason for
can_receive() to return false, and that case does not take the regular
lookup path. I removed the old comment because it no longer
described the distinction completely, but I forgot to add the replacement.
Sorry about that, and thanks for catching it.

> >               if (!virtio_transport_rx_batch_can_continue(t, sk, len)) {
> >                       release_sock(sk);
> >                       sock_put(sk);
> >@@ -2176,7 +2208,7 @@ void virtio_transport_recv_pkt_batch(struct virtio_transport *t,
> >
> >               virtio_transport_trace_recv_pkt(hdr, &src, &dst);
> >               if (virtio_transport_recv_pkt_set_owner(skb, sk))
> >-                      virtio_transport_recv_pkt_locked(t, skb, sk, net, NULL);
> >+                      virtio_transport_recv_pkt_locked(t, skb, sk, net, NULL, NULL);
> >               else
> >                       kfree_skb(skb);
> >
> >--
> >2.53.0
> >
>
