Received: from mail-qk1-f179.google.com (mail-qk1-f179.google.com [209.85.222.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCD8F331EB2
	for <virtualization@lists.linux.dev>; Sun, 18 Oct 2026 04:55:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.222.179
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792299331; cv=pass; b=gpGAbvWZR8C3CDjvRS4uvw0PZ7Y+xW50abe+VkfHLuwMVGQszJZ/5qV7gi0ZMxTNYj8G0+dNs9mhqlDcfpw1eeC4KPH13Gknd0TNhDpB6GmbnsEVoFXCIfRvwRHwrztQ8hVSsAyvnBzEy1iO57i0zKar+ZkFxfWm+Ug47c8CUKY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792299331; c=relaxed/simple;
	bh=vJ0XlC9E0fdcdQlJihE1W1WZE7aunAwAdldaODn6lns=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=odZOitwclTF2Cn/DGG8wFNvNARTZqpCCGsf5FcA74ryXdH/saWNoVMeBJLt3c6qy9JL07mDECZFmQBIYfaq6oWfGrDjb25epM/Fbms2R+T6cMrrt61EaXaee37IbNNhH+nrjrux2JiLLqX+2EhVnjSPyXda/dRG7CNDRKjP1Aqw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=s7c/McIo; arc=pass smtp.client-ip=209.85.222.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="s7c/McIo"
Received: by mail-qk1-f179.google.com with SMTP id af79cd13be357-93f2f2edb19so72612485a.0
        for <virtualization@lists.linux.dev>; Sat, 17 Oct 2026 21:55:29 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792299329; cv=none;
        d=google.com; s=arc-20260327;
        b=Az5BbR1SN7Iqy89AnUkJ+bhKTh2VclF9+yFiywo97O3k61cc6vO6YimVqDHOpEX/nR
         QYO2sMwxnHuaBL108k8DTpNf8ahw14/1vVYFLJvFXLDpgMMKH0i9SN6T1Zf1ykp/lqDS
         Kba36bbvBd3gfiQO5AGX/5EgKoETqo6EuSG+WBKU5MHojx8amSZ2ODgMUO2GHqCeIfHs
         aomVl3+GRNEf8mjUeV+yiLSMJjrzK2gbqpSeW9yYZ1IrEWR+mW59SxEVcFV2UfEETSAB
         Ca8WmARHR565vLL9G5enCqcxzfQgZVnUyi04cGbQ5ugpuQOQSODryGfwmZDqG37yLD9S
         dmRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=bYCOQPKKGVy8fPGXpaEBI8h8VBuBnlivmYliH6luJbQ=;
        fh=qRvMKyQ4CnyFGg503QweSxe+DMKuUwD5R0EtxdHYcQw=;
        b=fDz+4s2ozaDvvU3Tb4KwnGGJZZ0wX7VgjgC/7Gc2nKI7HbfdI+ICm5Xo2WIKpZ/sIf
         QrpvfnyMchRr+c5rCjerbinEhDGt/pM901i3Fm0+Acia+Q79X7s+iVuXPOFBpadd0qUp
         8Ful2xOqHKeSFALrNlD+s0YiX5OcWsYeCsjMINKycyyGtZzM5ImV638vXS2bEyqrX1tP
         idpN521ZVKqi/LQpXz2TA9epM67kIoy/ly5PnSa0UAHGBWpK9Jexeb896kDFvYzETkc9
         Y8nV3/pBKPmFTGUiK8TET++EWu3z7tgS/7K+RkIWzok/81q6r857bKYRqy3v6eHspcsx
         InyQ==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792299329; x=1792904129; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=bYCOQPKKGVy8fPGXpaEBI8h8VBuBnlivmYliH6luJbQ=;
        b=s7c/McIoZGTKzCeUafSFdaASfTxbsVKjUPEisXeoazGgVEscTd+RPi9aBXyrr+i4v/
         sOewpPcYienuxZBQkOk3UTerFXSb8JznA9+vZFrdHNPow1NfVmBRkDZtGHDefniUBDEu
         QDIaQMMcraBJxjtPKkw9ZW8kBpeqrC/yWnLNbjdm4+pcvtkJ1JaCnW0fxf/lfhmO8nGL
         xDW+o6YzZK9X7XkunQIDgC0+X9aiyCkfJfMeQwGGJBQFhOgM5H5o0u67sFbhEYHMbLan
         vCZCSyj3qfg9VPZoDlIfdjxXG5J9rdt6elzcJkj4d1waE5/pNQz+TUilHHmC0DASUMTt
         +7zA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792299329; x=1792904129;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=bYCOQPKKGVy8fPGXpaEBI8h8VBuBnlivmYliH6luJbQ=;
        b=kVNebMpWdw7bBRYb+LvfFVgTN+Twvlj1vQp2LA/DXSsEU/7It3enWWMGaPQYdwRfdb
         0iaxzTodns6R9m1iX3f/kQXEjMZMRLjeNcHWdSj8EemT4jfAvlOlVBZ5R5O0ABs0W7wM
         HQ8BZibK3w9FE/UbXveu5Ph0A3i4PKoAsIwA5K+7jqNzZFyNWRxSr5XSotyzCTcyG4T9
         mrIwQE/BMasTRzPX9lxiAzmabV8avnZxtgb6QavKsxvAiJyl91FZJoYXl6LyicAvaJSb
         llOthLfzSDDaDdoiCJWA7fZBXuJBVZlxrqqT+Mk//CIiRlJl+dzOCDIS3jVSPMok5cYw
         hyqA==
X-Forwarded-Encrypted: i=1; AKwUvBwmQSjYspWy+YWY2ppCucENsAH4JCuxwvO2ZFI924jCQTTNIziuy02FMU6FaSgOnFhM4ZLt6M4CWYg34coWxQ==@lists.linux.dev
X-Gm-Message-State: AFq9FYIcPmVDAoOXOi0n45BnpvB6WcU6WkBh0hL1kKBb2nNgCN8TWGFX
	yRtYAIhDTtF3IWoBuh3W6fJo5LJbsvuPrinzWi1YBkBTxtiMNgf8wjYBoyCYjH2F3dttnzLCmL6
	izkrGWx1z7ka7rBXeCLjZ+1ThcNb+36Y=
X-Gm-Gg: AYBFou0sHlkPOI6Yu6SIk9bTg8Uhb0asD8/oxFtji9PkC0S38N4yupIAPFG8wJceR6E
	xc5B//N8Twehia2aON5+3kBlRUbet0Im5ZTOAEs6w2PX5z1vJz3jcdKG4nR7ilBlFVatoLJMzAY
	lqSiQoEROs7z5mw8L0Chyd4TSJ9b6sAim3ia4JDvKZg0aHwYHqVuzfqtwScupgu4uLa6LyRxhH+
	dcreuzJXXwnkfdLJyhXg9viG1DYIeSDvxm9bVAZJEFU6TPr189E2ehZcc8NhrGIQntdEQBKdb9p
	2Ukdsnpb9UZFjkXQFj/BOw1y7n6zmVTCHsVAUHHCfXpmSGD/8IpY0B4=
X-Received: by 2002:a05:620a:1a1b:b0:93e:c12c:43f7 with SMTP id
 af79cd13be357-93f29de8891mr766305685a.68.1792299328021; Sat, 17 Oct 2026
 21:55:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20261014115640.184286-1-physicalmtea@gmail.com>
 <20261014115640.184286-4-physicalmtea@gmail.com> <atI1-_FAri2x-k2p@sgarzare-redhat>
In-Reply-To: <atI1-_FAri2x-k2p@sgarzare-redhat>
From: Jia Jia <physicalmtea@gmail.com>
Date: Sun, 18 Oct 2026 12:54:50 +0800
X-Gm-Features: AclHuK8rUKtB0xYKNcEmUFPkpYtDIc-ulJfoqsQrKFF0ied1vAJsqlYVpZCxhek
Message-ID: <CAJwVaM+syOjuJ-Vk3dfvZv7WLJ=s2ne3WaFf+jHY1JQY0mc+2Q@mail.gmail.com>
Subject: Re: [PATCH net-next v4 3/4] vsock/virtio: coalesce RX write-space
 notifications in lock batches
To: Stefano Garzarella <sgarzare@redhat.com>
Cc: stefanha@redhat.com, mst@redhat.com, jasowangio@gmail.com, 
	eperezma@redhat.com, xuanzhuo@linux.alibaba.com, davem@davemloft.net, 
	edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, 
	virtualization@lists.linux.dev, kvm@vger.kernel.org, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, bobbyeshleman@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

>
> On Wed, Oct 14, 2026 at 07:56:39PM +0800, Jia Jia wrote:
> >Each received packet updates peer credit and may call sk_write_space().
> >A writer cannot use that credit until the batch releases the socket lock=
,
> >so one notification at batch finish is sufficient.
> >
> >Save the initial sk_write_space callback when the AF_VSOCK socket is
> >created and require it to remain installed for batching. This lets the
> >transport module deliver the deferred notification without referring to
> >the unexported default callback. Sockets with replaced callbacks retain
> >their per-packet behavior.
> >
> >Record the batch socket before processing its first packet so a batch th=
at
> >ends on that packet cannot lose the pending notification.
>
> mmm, is this a fix of the previous patch?
>

No. Patch 2 preserves the existing per-packet sk_write_space()
behavior, so Patch 3 is not a correctness fix for it. Patch 3 only
coalesces the native/ default notifications.

Moving batch->sk earlier is required only after the deferred state is
introduced here: the socket must already be recorded before the first
packet can set write_space_pending, so the notification can still be
delivered if that packet immediately ends the batch. Sorry, the commit
message did not make this distinction clear.

> >
> >Signed-off-by: Jia Jia <physicalmtea@gmail.com>
> >---
> > include/linux/virtio_vsock.h            |  1 +
> > include/net/af_vsock.h                  |  5 +++
> > net/vmw_vsock/af_vsock.c                |  1 +
> > net/vmw_vsock/virtio_transport_common.c | 53 +++++++++++++++++--------
> > 4 files changed, 44 insertions(+), 16 deletions(-)
> >
> >diff --git a/include/linux/virtio_vsock.h b/include/linux/virtio_vsock.h
> >index 26dde6909c4ed..bf077ee0ded88 100644
> >--- a/include/linux/virtio_vsock.h
> >+++ b/include/linux/virtio_vsock.h
> >@@ -287,6 +287,7 @@ struct virtio_transport_rx_batch {
> >       struct sock *sk;
> >       unsigned int pkts;
> >       size_t bytes;
> >+      bool write_space_pending;
> > };
> >
> > void virtio_transport_recv_pkt_batch(struct virtio_transport *t,
> >diff --git a/include/net/af_vsock.h b/include/net/af_vsock.h
> >index 5549298c1ec6b..9a40960d10cbe 100644
> >--- a/include/net/af_vsock.h
> >+++ b/include/net/af_vsock.h
> >@@ -63,6 +63,11 @@ struct vsock_sock {
> >       u32 peer_shutdown;
> >       bool sent_request;
> >       bool ignore_connecting_rst;
> >+      /*
> >+       * Initial callback, used to identify replacements and deliver de=
ferred
> >+       * write-space notifications.
> >+       */
> >+      void (*default_write_space)(struct sock *sk);
>
> This is kind of virtio-vsock specific, why need to be here?
>

I stored this state here because __vsock_create() can capture the
native callback before the socket is exposed or any callback
replacement occurs, and the transport cannot directly reference the
unexported default callback. However, I agree that exposing this
virtio-specific state directly in struct vsock_sock is not ideal. I'll
look at hiding it behind an AF_VSOCK helper in v5 while preserving the
capture point and the lifetime required by deferred callbacks.


> >
> >       /* Protected by lock_sock(sk) */
> >       u64 buffer_size;
> >diff --git a/net/vmw_vsock/af_vsock.c b/net/vmw_vsock/af_vsock.c
> >index 44cee74519555..fe7f49da6c4bc 100644
> >--- a/net/vmw_vsock/af_vsock.c
> >+++ b/net/vmw_vsock/af_vsock.c
> >@@ -958,6 +958,7 @@ static struct sock *__vsock_create(struct net *net,
> >               sk->sk_type =3D type;
> >
> >       vsk =3D vsock_sk(sk);
> >+      vsk->default_write_space =3D sk->sk_write_space;
> >       vsock_addr_init(&vsk->local_addr, VMADDR_CID_ANY, VMADDR_PORT_ANY=
);
> >       vsock_addr_init(&vsk->remote_addr, VMADDR_CID_ANY, VMADDR_PORT_AN=
Y);
> >
> >diff --git a/net/vmw_vsock/virtio_transport_common.c b/net/vmw_vsock/vir=
tio_transport_common.c
> >index ff74e805527a5..f4b5f0230493e 100644
> >--- a/net/vmw_vsock/virtio_transport_common.c
> >+++ b/net/vmw_vsock/virtio_transport_common.c
> >@@ -1820,6 +1820,7 @@ virtio_transport_recv_pkt_batchable(struct virtio_=
transport *t,
> >       return sk->sk_state =3D=3D TCP_ESTABLISHED &&
> >              sk->sk_type =3D=3D SOCK_STREAM &&
> >              READ_ONCE(sk->sk_prot) =3D=3D sk->sk_prot_creator &&
> >+             READ_ONCE(sk->sk_write_space) =3D=3D vsk->default_write_sp=
ace &&
>
> Why?
>

I believe this check is necessary because notification coalescing is
only safe for the original native sk_write_space callback. Sockmap can
replace this callback under sk_callback_lock, which is independent of
the socket lock held across the batch, and the replacement may require
per-packet handling. Comparing it with the callback captured at socket
creation lets us fall back to the existing per-packet behavior when it
has been replaced. I'll add a comment explaining this.


> >              !sock_flag(sk, SOCK_DONE) &&
> >              vsk->transport =3D=3D &t->transport &&
> >              vvs && virtio_transport_rx_skb_has_headroom(vvs) &&
> >@@ -1828,13 +1829,15 @@ virtio_transport_recv_pkt_batchable(struct virti=
o_transport *t,
> >
> > /*
> >  * The caller holds sk's socket lock.  Set @batchable if the socket can=
 remain
> >- * locked for another ordinary STREAM/RW packet.  Return true if the ca=
ller
> >- * must free @skb.
> >+ * locked for another ordinary STREAM/RW packet.  When @batch is non-NU=
LL,
> >+ * record a default write-space notification for batch finish instead o=
f
> >+ * delivering it immediately.  Return true if the caller must free @skb=
.
> >  */
> > static bool
> > virtio_transport_recv_pkt_locked(struct virtio_transport *t,
> >                                struct sk_buff *skb, struct sock *sk,
> >-                               bool *batchable)
> >+                               bool *batchable,
> >+                               struct virtio_transport_rx_batch *batch)
> > {
> >       struct virtio_vsock_hdr *hdr =3D virtio_vsock_hdr(skb);
> >       struct sockaddr_vm src;
> >@@ -1863,8 +1866,12 @@ virtio_transport_recv_pkt_locked(struct virtio_tr=
ansport *t,
> >       if (vsk->local_addr.svm_cid !=3D VMADDR_CID_ANY)
> >               vsk->local_addr.svm_cid =3D le64_to_cpu(hdr->dst_cid);
> >
> >-      if (space_available)
> >-              sk->sk_write_space(sk);
> >+      if (space_available) {
> >+              if (batch)
> >+                      batch->write_space_pending =3D true;
> >+              else
> >+                      sk->sk_write_space(sk);
> >+      }
> >
> >       switch (sk->sk_state) {
> >       case TCP_LISTEN:
> >@@ -1931,7 +1938,7 @@ void virtio_transport_recv_pkt(struct virtio_trans=
port *t,
> >       }
> >
> >       lock_sock(sk);
> >-      free_pkt =3D virtio_transport_recv_pkt_locked(t, skb, sk, NULL);
> >+      free_pkt =3D virtio_transport_recv_pkt_locked(t, skb, sk, NULL, N=
ULL);
> >       release_sock(sk);
> >
> >       /* Release refcnt obtained when we fetched this socket out of the
> >@@ -1949,22 +1956,27 @@ EXPORT_SYMBOL_GPL(virtio_transport_recv_pkt);
> >
> > /*
> >  * Finish the RX batch.
> >- * For a non-empty batch, the caller must hold the socket lock acquired=
 with
> >- * lock_sock(). This function releases the lock and the batch's lookup
> >- * reference.
> >+ * For a non-empty batch, the caller holds the socket lock acquired wit=
h
> >+ * lock_sock(). Deliver any deferred write-space notification while the=
 lock
> >+ * is held, then release the lock and the batch's lookup reference.
> >  * An empty batch is a no-op.
> >  */
> > void virtio_transport_rx_batch_finish(struct virtio_transport_rx_batch =
*batch)
> > {
> >+      bool write_space_pending =3D batch->write_space_pending;
> >       struct sock *sk =3D batch->sk;
> >
> >       batch->sk =3D NULL;
> >       batch->pkts =3D 0;
> >       batch->bytes =3D 0;
> >+      batch->write_space_pending =3D false;
> >
> >       if (!sk)
> >               return;
> >
> >+      if (write_space_pending)
> >+              vsock_sk(sk)->default_write_space(sk);
> >+
> >       release_sock(sk);
> >       sock_put(sk);
> > }
> >@@ -2019,7 +2031,8 @@ void virtio_transport_recv_pkt_batch(struct virtio=
_transport *t,
> >                       }
> >
> >                       free_pkt =3D virtio_transport_recv_pkt_locked(t, =
skb, sk,
> >-                                                                  &batc=
hable);
> >+                                                                  &batc=
hable,
> >+                                                                  batch=
);
> >                       if (!batchable)
> >                               virtio_transport_rx_batch_finish(batch);
> >                       if (free_pkt)
> >@@ -2059,23 +2072,31 @@ void virtio_transport_recv_pkt_batch(struct virt=
io_transport *t,
> >
> >       lock_sock(sk);
> >       /*
> >-       * Sockmap removal restores the native protocol under sk_callback=
_lock.
> >-       * Serialize this initial eligibility check with that update.
> >+       * Sockmap teardown restores callbacks under sk_callback_lock. Ke=
ep the
> >+       * initial eligibility check consistent with that update.
> >        */
>
> Unrelated change?
>

This is related to the new callback eligibility check, but I agree
that the original rewrite was unnecessary. I=E2=80=99ll keep the original
serialization wording and only extend the comment to mention both the
native protocol and callbacks.

> BTW if you are assisted by AI, please read https://docs.kernel.org/proces=
s/coding-assistants.html
>

Thanks for the reminder. I read the document when you mentioned it
previously.  take responsibility for every change in it. As this
review has shown, I missed some netdev conventions, and the patch
organization can also be improved; those are my mistakes, and I=E2=80=99ll
address them in v5.

I used an LLM to help set up the test environment, translate and
polish the English text, and review the series. I ran and verified the
tests myself. I=E2=80=99ll
disclose that assistance in v5 as described in the documentation.


> >       read_lock_bh(&sk->sk_callback_lock);
> >       start_batch =3D virtio_transport_recv_pkt_batchable(t, sk);
> >       read_unlock_bh(&sk->sk_callback_lock);
> >
> >+      if (start_batch)
> >+              batch->sk =3D sk;
> >+
> >       free_pkt =3D virtio_transport_recv_pkt_locked(t, skb, sk,
> >-                                                  start_batch ? &batcha=
ble : NULL);
> >+                                                  start_batch ? &batcha=
ble : NULL,
> >+                                                  start_batch ? batch :=
 NULL);
> >       if (start_batch && batchable) {
> >               /* Keep the lookup reference until the batch is released.=
 */
> >-              batch->sk =3D sk;
> >               return;
> >       }
> >
> >-      release_sock(sk);
> >-      sock_put(sk);
> >+      if (start_batch) {
> >+              virtio_transport_rx_batch_finish(batch);
> >+      } else {
> >+              release_sock(sk);
> >+              sock_put(sk);
> >+      }
> >+
> >       if (free_pkt)
> >               kfree_skb(skb);
> > }
> >--
> >2.53.0
> >
>
