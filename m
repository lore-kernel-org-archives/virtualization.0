Received: from mail-qk1-f172.google.com (mail-qk1-f172.google.com [209.85.222.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61C16418361
	for <virtualization@lists.linux.dev>; Sun, 18 Oct 2026 04:43:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.222.172
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792298592; cv=pass; b=OsDO8aLOqOpohCG6y37PSL50wjh4w6pedWueucxpDsMWfcYjM0m32aPiyuE/7NHOeh3LcUDMYWUkKeN6WL0n5bX/hKdH0QMF/va5/uh3e+/H0jHzmiooFNmHrudOcNc6wvurKh2mzSP69hnuZ6nFhUOI2o0aWaTHpz9X1aXtBTA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792298592; c=relaxed/simple;
	bh=DHpt0emLBDEXhg01inCWP8u2BhRmbxlc7aC04HKyBeE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=moXoR8Q2FrgVdNVXCKEkW5t62Odt2VAOit6FmGs9sf64/nur0lpClBj7xrpD291/csBF/+qgNNYbtiraoZCoyqDBV8ITqSQGvC4f3FTHPt09NUWaYxAXKcVBNPSn9qL7vFP+GGesUi83wuDczdAmFY35krDbyZJA6rKlIpPsASk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ks2p7gnH; arc=pass smtp.client-ip=209.85.222.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ks2p7gnH"
Received: by mail-qk1-f172.google.com with SMTP id af79cd13be357-93e64d52949so111289685a.1
        for <virtualization@lists.linux.dev>; Sat, 17 Oct 2026 21:43:08 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792298587; cv=none;
        d=google.com; s=arc-20260327;
        b=QYbA5JJmNhlfRgeL+Kz4QGfi+Ri2lTBlf1huMM7on4RUzK8ty5xE0H+PBJhO5EDpji
         oXj7QV4FTluTCdHf1pWapPw8zABrNuYVOt0FA3o88OfcHHpQRcGc/AG23KoT+3D7VxD+
         UmPpI6LcHTqcCthaVbV46p8+TB7/CM5FkoSPTmwZhv7G5KTm/+ZybkwJaG9GgkDKi3n5
         RJEIScCuwkabDEis84zQA/hsEvCkq12ps8qLy2xfjkBXKm9lFedUJkH7q7E2SFjEV0+z
         xbOQPN2ePSyccJU/vPrpyYJrRx939tv66Ts3yAz6HV1e8gkL/3HTHNwzdYB3QoAaRBUH
         5vIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=TCd4vJVysPs+rmx1m3RvczNkQ2iSpfMjw8JApMQr1io=;
        fh=R+bXBvT2ry9ij4NeFiempa1ed3f5lC7/ZMR3ybYOFXw=;
        b=roAf3w8JHNCcizrECu8Tt7DzZgqn55xTJCZyhcU/U84nBJI4PKwfcUHPZQlCkAqkKy
         w4unQ7Aj7N+KIjer2+zIMnvKJ9s+YQgtj7cQWL0qDN/0lX3wfmMw0fScbHzwcDiUw+gc
         esY8VuQXu8WQW+isBTBzHcEMzHrsKTZLHE0J60Ix07yMQd4ZgmrklGwmgDb4PeLxPcBX
         hjmqwgZi0ViAAj4gvXEZz4X5DK6JRBuwmuEyeF8Z9Z1rk9ZYvZGdErjb0YbcreUGl7Su
         nEYFaUDhOzDRlZYO99/Q9rgGjSzfcuZoUoQauDSmJ18SXHl7qP3sKtiGWWAu6om8cERy
         p2vg==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792298587; x=1792903387; darn=lists.linux.dev;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=TCd4vJVysPs+rmx1m3RvczNkQ2iSpfMjw8JApMQr1io=;
        b=ks2p7gnHGh8rA0GqGRXge7z6GFRH5meh47lfW99Irfm0Ygu+D2wj/sd6/uiNFUpUYM
         jPnd8g5xYKhfk05almZHYvdXRL+mNDjPhPA6EqnIRZntBkluTuJJ3WmmaomV6mY4OsBb
         EKedX5W0ZA2oUDazdBS9goLGFO26kdlaqXnUKmpvMMjhWR5hKsnzmiymxxZIBroUdL26
         JXlZLyC1YxHQA5iNABzxAOWgnzDlBQQQijpilO6FwJgjVDvWryt+HyPvH3NA6NmMfOxT
         f2PRUKK87pkqilsSfn3anWu9ymmQnXVZmydH/GmX0buX+7FVr7PGY7w6x70fkxfAfyfs
         tXjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792298587; x=1792903387;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=TCd4vJVysPs+rmx1m3RvczNkQ2iSpfMjw8JApMQr1io=;
        b=jdyW6ZbeseQtIbXo6djBiHtiHW9GhYWVeSfsiu+GM5Ap6XCB5ImAf/8sHeePUSu+pp
         qpVv+mewn4mhcbAw/HC+POSryJr7tbe5QE0pO0rZxGhazOcYTDrflAtwVnMcF95F57Um
         pT7tplnk3jXjvz2HX4c3Mtm2R9X7bxODnyN+L3ZE06WeOvQNtjSvzcjYzum7TCkHzHdt
         8r9RbmE51yl1fwyyKxof5qhk3RLbXzu3zKnQjWkylZwvwMwaH2cTOXP6CNmG8W1MaRqS
         bsMYzNKLrZXkeugVY/EzpPwSlRqD1GX2S3OKF2xDOP4Ks6bGswx/K0bpcIr1ysk8ggrp
         pBSg==
X-Forwarded-Encrypted: i=1; AKwUvBzTtbqafqAbZcmajVCzZkewLhWR6Sv6Y022AsxbMqQ2WzQmT7Q2Zh+nSOV4yHvZVK0XOeIdr8K7KvCvpugJJg==@lists.linux.dev
X-Gm-Message-State: AFq9FYKiic2yXPjas6u9SpEZZO1pUcQ0fzZtMudSSqqI2KD1uxoVFYId
	3RbOk9XqjEaiQe8b/P4jh//X1DrrAT0U0m+Gs8xVxYi29cshvu/Kxh6ryE/aLGqU17ejDX10GJD
	Vj/qvX92Biycrel7sUod8AAikUc4hQZY=
X-Gm-Gg: AYBFou0L17vvFY+Sq4UmbdOHUNYWQ9Al7fzrk3aMQ8BmTbexlVM3D883rzKPyoBYNLO
	sCW7d8ohqS8ru3jjcCAwXzk5/EADG3LMbM5YXhNTN0ZAJThfRcE0ArT0cD7NUJbK0mexCw/TnQM
	p7GO1K558SbAsvxGYzUunzVKoFoq3yGedZ3B7jhu4aXtXeruzKJgKVpDrVaqTKumCdGtQiQ/R2U
	tmqEUkb5Nkg55RwGuWAyEnoCwkyRiTBnlqpUhxEs/KAav1ftPDed88JPwHeYjABlboYnL1p+zXk
	zp3/0G2f0LhC99bdKf/CUTcCF6plKr8gSYCeWRnvpJhM1lgKBp33I58=
X-Received: by 2002:a05:620a:260a:b0:93c:b6db:8c with SMTP id
 af79cd13be357-93f299f3829mr676090985a.0.1792298586112; Sat, 17 Oct 2026
 21:43:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20261014115640.184286-1-physicalmtea@gmail.com>
 <20261014115640.184286-2-physicalmtea@gmail.com> <atImp74JbTbEb0d_@sgarzare-redhat>
In-Reply-To: <atImp74JbTbEb0d_@sgarzare-redhat>
From: Jia Jia <physicalmtea@gmail.com>
Date: Sun, 18 Oct 2026 12:42:29 +0800
X-Gm-Features: AclHuK8Ob-l6fq4mltZ_vIa4jBsMb_PwAPuMxfSzbBTGRIF1RfJPYptCeSCMlpA
Message-ID: <CAJwVaML2F6vN5xGsmvd1PwD3ToLOeV_PfzJrArvan8gvbveKuA@mail.gmail.com>
Subject: Re: [PATCH net-next v4 1/4] vsock/virtio: split socket lookup from
 locked RX processing
To: Stefano Garzarella <sgarzare@redhat.com>
Cc: stefanha@redhat.com, mst@redhat.com, jasowangio@gmail.com, 
	eperezma@redhat.com, xuanzhuo@linux.alibaba.com, davem@davemloft.net, 
	edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, 
	virtualization@lists.linux.dev, kvm@vger.kernel.org, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, bobbyeshleman@gmail.com
Content-Type: text/plain; charset="UTF-8"

>
> On Wed, Oct 14, 2026 at 07:56:37PM +0800, Jia Jia wrote:
> >Split virtio_transport_recv_pkt() so socket lookup is separate from
> >receive state machine processing under the socket lock. This prepares the
> >receive path to keep a looked-up socket across multiple packets in a later
> >change.
> >
> >Keep virtio_transport_recv_pkt() on its existing per-packet locking path.
> >The locked helper obtains packet-specific addresses from the skb and uses
> >the matched socket namespace for reset replies. Preserve source validation
> >and failure handling.
> >
> >No functional change intended.
> >
> >Signed-off-by: Jia Jia <physicalmtea@gmail.com>
> >---
> > net/vmw_vsock/virtio_transport_common.c | 128 ++++++++++++++----------
> > 1 file changed, 75 insertions(+), 53 deletions(-)
> >
> >diff --git a/net/vmw_vsock/virtio_transport_common.c b/net/vmw_vsock/virtio_transport_common.c
> >index f225f53ed4bab..61ee3bc205d5d 100644
> >--- a/net/vmw_vsock/virtio_transport_common.c
> >+++ b/net/vmw_vsock/virtio_transport_common.c
> >@@ -1774,81 +1774,60 @@ static bool virtio_transport_valid_type(u16 type)
> >              (type == VIRTIO_VSOCK_TYPE_SEQPACKET);
> > }
> >
> >-/* We are under the virtio-vsock's vsock->rx_lock or vhost-vsock's vq->mutex
> >- * lock.
> >- */
> >-void virtio_transport_recv_pkt(struct virtio_transport *t,
> >-                             struct sk_buff *skb, struct net *net)
> >+static struct sock *
> >+virtio_transport_find_socket(struct sk_buff *skb, struct sockaddr_vm *src,
> >+                           struct sockaddr_vm *dst, struct net *net)
> > {
> >       struct virtio_vsock_hdr *hdr = virtio_vsock_hdr(skb);
> >-      struct sockaddr_vm src, dst;
> >-      struct vsock_sock *vsk;
> >       struct sock *sk;
> >-      bool space_available;
> >-
> >-      vsock_addr_init(&src, le64_to_cpu(hdr->src_cid),
> >-                      le32_to_cpu(hdr->src_port));
> >-      vsock_addr_init(&dst, le64_to_cpu(hdr->dst_cid),
> >-                      le32_to_cpu(hdr->dst_port));
> >-
> >-      trace_virtio_transport_recv_pkt(src.svm_cid, src.svm_port,
> >-                                      dst.svm_cid, dst.svm_port,
> >-                                      le32_to_cpu(hdr->len),
> >-                                      le16_to_cpu(hdr->type),
> >-                                      le16_to_cpu(hdr->op),
> >-                                      le32_to_cpu(hdr->flags),
> >-                                      le32_to_cpu(hdr->buf_alloc),
> >-                                      le32_to_cpu(hdr->fwd_cnt));
> >
> >-      if (!virtio_transport_valid_type(le16_to_cpu(hdr->type))) {
> >-              (void)virtio_transport_reset_no_sock(t, skb, net);
> >-              goto free_pkt;
> >-      }
> >+      if (!virtio_transport_valid_type(le16_to_cpu(hdr->type)))
> >+              return NULL;
> >
> >-      /* The socket must be in connected or bound table
> >-       * otherwise send reset back
> >-       */
> >-      sk = vsock_find_connected_socket_net(&src, &dst, net);
> >-      if (!sk) {
> >-              sk = vsock_find_bound_socket_net(&dst, net);
> >-              if (!sk) {
> >-                      (void)virtio_transport_reset_no_sock(t, skb, net);
> >-                      goto free_pkt;
> >-              }
> >-      }
> >+      sk = vsock_find_connected_socket_net(src, dst, net);
> >+      if (!sk)
> >+              sk = vsock_find_bound_socket_net(dst, net);
> >+      if (!sk)
> >+              return NULL;
> >
> >       if (virtio_transport_get_type(sk) != le16_to_cpu(hdr->type)) {
> >-              (void)virtio_transport_reset_no_sock(t, skb, net);
> >               sock_put(sk);
> >-              goto free_pkt;
> >+              return NULL;
> >       }
> >
> >-      if (!skb_set_owner_sk_safe(skb, sk)) {
> >-              WARN_ONCE(1, "receiving vsock socket has sk_refcnt == 0\n");
> >-              goto free_pkt;
> >-      }
> >+      return sk;
> >+}
> >
> >-      vsk = vsock_sk(sk);
> >+/*
> >+ * The caller holds sk's socket lock and must free skb if this returns true.
>
> Why the skb must be freed by the caller and not by this function itself?
>

You're right, it doesn't have to be. I originally left the skb cleanup
to the caller so it could unwind either per-packet or batch state
while preserving
the existing error-path order (release_sock() -> drop the lookup
reference -> kfree_skb()).

However, that distinction does not require skb ownership to escape the
helper, and the resulting ownership contract is confusing since the
other paths
consume the skb internally. I'll make the helper consume it directly in v5.


> >+ */
> >+static bool
> >+virtio_transport_recv_pkt_locked(struct virtio_transport *t,
> >+                               struct sk_buff *skb, struct sock *sk)
> >+{
> >+      struct virtio_vsock_hdr *hdr = virtio_vsock_hdr(skb);
> >+      struct sockaddr_vm src;
> >+      struct vsock_sock *vsk = vsock_sk(sk);
> >+      bool space_available;
>
> Please, follow the netdev convection for ordering local variables:
> https://www.kernel.org/doc/html/v7.2/process/maintainer-netdev.html#local-variable-ordering-reverse-xmas-tree-rcs
>

Sorry about that. You had pointed me to this guideline before, and I
missed this during the final preparation. That's entirely my
oversight, and I will fix the declaration ordering throughout the
series in v5.


> >
> >-      lock_sock(sk);
> >+      vsock_addr_init(&src, le64_to_cpu(hdr->src_cid),
> >+                      le32_to_cpu(hdr->src_port));
> >
> >-      /* Check if sk has been closed or assigned to another transport before
> >-       * lock_sock (note: listener sockets are not assigned to any transport)
> >+      /* Listener sockets accept packets from any source and are not assigned to
> >+       * a transport.
> >        */
>
> Why changing this comment in this commit?
>
> Oh because we moved out lock_sock, right?
>
> I think we should keep in some way the old info that was much more
> informative that the current comment that just say what the check is
> doing and not why.
>

Yes, I changed it because lock_sock() moved to the caller, so the old
wording no longer read clearly at that location. But I over-shortened
it and dropped the important reason for the recheck. I'll restore that
explanation:


> >       if (sock_flag(sk, SOCK_DONE) ||
> >           (sk->sk_state != TCP_LISTEN &&
> >            !vsock_check_source(vsk, &t->transport, &src))) {
> >-              (void)virtio_transport_reset_no_sock(t, skb, net);
> >-              release_sock(sk);
> >-              sock_put(sk);
> >-              goto free_pkt;
> >+              (void)virtio_transport_reset_no_sock(t, skb, sock_net(sk));
>
> We need to be careful here, IIRC Bobby used the net from the caller for
> a reason.
>
> Are you sure it's fine this change? Why not passing net as parameter and
> minimize changes?
>

I assumed sock_net(sk) was interchangeable with the caller's net after
a successful lookup, but I took that equivalence for granted. I'll
change this in v5.

> >+              return true;
> >       }
> >
> >       space_available = virtio_transport_space_update(sk, skb);
> >
> >       /* Update CID in case it has changed after a transport reset event */
> >       if (vsk->local_addr.svm_cid != VMADDR_CID_ANY)
> >-              vsk->local_addr.svm_cid = dst.svm_cid;
> >+              vsk->local_addr.svm_cid = le64_to_cpu(hdr->dst_cid);
> >
> >       if (space_available)
> >               sk->sk_write_space(sk);
> >@@ -1870,17 +1849,60 @@ void virtio_transport_recv_pkt(struct virtio_transport *t,
> >               kfree_skb(skb);
> >               break;
> >       default:
> >-              (void)virtio_transport_reset_no_sock(t, skb, net);
> >+              (void)virtio_transport_reset_no_sock(t, skb, sock_net(sk));
> >               kfree_skb(skb);
> >               break;
> >       }
> >
> >+      return false;
> >+}
> >+
> >+/* We are under the virtio-vsock's vsock->rx_lock or vhost-vsock's vq->mutex
> >+ * lock.
> >+ */
> >+void virtio_transport_recv_pkt(struct virtio_transport *t,
> >+                             struct sk_buff *skb, struct net *net)
> >+{
> >+      struct virtio_vsock_hdr *hdr = virtio_vsock_hdr(skb);
> >+      struct sockaddr_vm src, dst;
> >+      struct sock *sk;
> >+      bool free_pkt;
> >+
> >+      vsock_addr_init(&src, le64_to_cpu(hdr->src_cid),
> >+                      le32_to_cpu(hdr->src_port));
> >+      vsock_addr_init(&dst, le64_to_cpu(hdr->dst_cid),
> >+                      le32_to_cpu(hdr->dst_port));
> >+
> >+      trace_virtio_transport_recv_pkt(src.svm_cid, src.svm_port,
> >+                                      dst.svm_cid, dst.svm_port,
> >+                                      le32_to_cpu(hdr->len),
> >+                                      le16_to_cpu(hdr->type),
> >+                                      le16_to_cpu(hdr->op),
> >+                                      le32_to_cpu(hdr->flags),
> >+                                      le32_to_cpu(hdr->buf_alloc),
> >+                                      le32_to_cpu(hdr->fwd_cnt));
> >+
> >+      sk = virtio_transport_find_socket(skb, &src, &dst, net);
> >+      if (!sk) {
> >+              (void)virtio_transport_reset_no_sock(t, skb, net);
> >+              goto free_pkt;
> >+      }
> >+
> >+      if (!skb_set_owner_sk_safe(skb, sk)) {
> >+              WARN_ONCE(1, "receiving vsock socket has sk_refcnt == 0\n");
> >+              goto free_pkt;
> >+      }
> >+
> >+      lock_sock(sk);
> >+      free_pkt = virtio_transport_recv_pkt_locked(t, skb, sk);
> >       release_sock(sk);
> >
> >       /* Release refcnt obtained when we fetched this socket out of the
> >        * bound or connected list.
> >        */
> >       sock_put(sk);
> >+      if (free_pkt)
> >+              kfree_skb(skb);
> >       return;
> >
> > free_pkt:
> >--
> >2.53.0
> >
>
