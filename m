Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98D9230170F
	for <virtualization@lists.linux.dev>; Thu, 11 Dec 2025 12:51:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765457512; cv=none; b=kN13D8wlowNoEZhjS146GJloHZZXXfImjAOXYrMJZu7ubsWOwkDnYHh+SA+dGiZVaFcCIJzGJoEWn0m+PmvaWkZpQG6jOHs6eiC4QBjl27l1431q7Ug2ah+HjN013L9QL/8coeJEL8z1aubS3Rjo3hFqR42wZOXgJwGLGbxNL+c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765457512; c=relaxed/simple;
	bh=UtcSCFo4lcJ+VNXPCswEjoKkIm8zmXXMCuHRDIRT/lI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=m2jl1MiSfVSS2qN+aMB4qZ2EUB6f5GwtcY/6fM8alGzvdObfpfxarm5jXyXrxej+j2VE94mRpbuq+J2P4gP4hS5BzyNO5HPuAVX8XRjMtuatkJmhnrM/lVEAoMNydOdXurUu1JTdY4208jhmy6eglcbUuX5fEtX8j4wbsG7SfRA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ijoULUMQ; arc=none smtp.client-ip=209.85.167.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ijoULUMQ"
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-5959d9a8eceso47418e87.3
        for <virtualization@lists.linux.dev>; Thu, 11 Dec 2025 04:51:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765457509; x=1766062309; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=wUQdXYP6pOfCpe/+KEFALT6gCZMNZ8lZXJxhEyfJhoM=;
        b=ijoULUMQAWNY3GORdUshTC1y9xvS2jDyOTLB59aEwgfLZdkAFCc9WuR/N8++zsFj7K
         LEYqrX3/fwPsHeYGVRb4xTCeWAtoeLEN8SZufAXr5jXsGgjJPDIxwffOCC54jpr5/wly
         h7eo0bwJEm5yKPyzohD2M4hQqghBcswtwjpIuDckfSQ+XQWTbdrvb86Oq4oVqgKgZfw5
         lWzoWuKUuYraUwEjgdV3KTbq44SMLyAWPAJ/ERHn5aGKr+1KJsbV2DIwIzcKqWfUWrx1
         0v0tRTqq225uPvDSKcybO4d22BzAaqNbXmxc69DweVtzgW9WC/qlSGHEb0mPS6PH9wUZ
         arCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765457509; x=1766062309;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wUQdXYP6pOfCpe/+KEFALT6gCZMNZ8lZXJxhEyfJhoM=;
        b=Cn9wgDVyBisvuSrbISV73I84N1LdaPUqaZgwP8OxfE3+wBNNx/T8HHuza0h0+7c33a
         dBQmuTbDS2CZNPISiJgJcyn1DCJcskcJ8Ia8wZJUWKcPB/5LC9GZr5J2IWtPzBEdmC2R
         YwsGdbUlW9R4cOVNQPxpC9+Y/fa2wPvcdxPVxAqo7Q1KJAzAKZhAe1ugjsl3Ju5eH0Xp
         WbFpQ4bXSv1tWoRQ2jHZITPStiyjHUibiwOZgF68y0qm5hwUvh9fMZ5XWR7WY8cTSgsX
         R9ERF3cIk/3JKtVlE27+lqUcCZFXvSCcdllycbHbRjb1feX562ALWTKcEI6Rq+k+NupF
         hthg==
X-Forwarded-Encrypted: i=1; AJvYcCW6yVMkIKBAlDKmA2o9ATGjcgYotsELHD7F2zpaKZHy4WDXHMrrBBfr/GepVrhUYuwIYQivd+hmRmQqbg3Zdw==@lists.linux.dev
X-Gm-Message-State: AOJu0Yzp4OpL4OZCDFNwoCvZQCqLkPfiVdX8EKAUfKVwzJoM+ChdoAEm
	5BYbS9fzVx6x2vp9kSt1uh/kdZulau5xqo1Tk6qTMW6r2B43KyOLpQr0
X-Gm-Gg: AY/fxX6AJPu6xFKA1AFEMhg9T8k+oM7sqgq12B8vXUR2A8BYUMmKoVdLMrV8zbl15VL
	Olndqj8+YCf8GCIN7JKybHbuTYhWETQIAzwk1CaATN9F25BzkjCc867RUHgL0c9o5Gq12yw/LRZ
	EyaHcRdzpBHcWlS/W8PUxWc+U5tcVpyGT3sRL4QezA7HA/tKP3xWRZoETeq1+vsUelVBpO3GC56
	1wvA/XLAdRdIf33Y1xm5IB0WVULlE5ptRYEHMCgzbK4llS3vJPZesl5q0JSjwW3AXjnQrlBWtnb
	QhnkATIKaNNE0Q8J4jb/lKJjBDzAgq10hAhcQJfuuBLIP67xI/cLtkwutWPtZRE8RHsyrv/SA+w
	Tv25xi1rGNF2EFsIDxb6RiEjXsXeB336CrzO9ICOT046wxMRfAgWsGnJu5YNXfxSkZsbEDzXkji
	+qOTiSRp30vJ8=
X-Google-Smtp-Source: AGHT+IGENgtK1gusynnKiA94NWiQgv3EAxKkdXwr/sY+k3BPHQ54cU7oSPuV1/QDYEzaMtvI1s0nZQ==
X-Received: by 2002:a05:6512:2316:b0:595:81ce:ff83 with SMTP id 2adb3069b0e04-598ee527456mr2125540e87.25.1765457508314;
        Thu, 11 Dec 2025 04:51:48 -0800 (PST)
Received: from Ubuntu-2204-jammy-amd64-base.. ([2a01:4f9:6a:4e9f::2])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-598f2f379d4sm835021e87.21.2025.12.11.04.51.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Dec 2025 04:51:47 -0800 (PST)
From: Melbin K Mathew <mlbnkm1@gmail.com>
To: stefanha@redhat.com,
	sgarzare@redhat.com
Cc: kvm@vger.kernel.org,
	netdev@vger.kernel.org,
	virtualization@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	mst@redhat.com,
	jasowang@redhat.com,
	xuanzhuo@linux.alibaba.com,
	eperezma@redhat.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	Melbin K Mathew <mlbnkm1@gmail.com>
Subject: [PATCH net v3] vsock/virtio: cap TX credit to local buffer size
Date: Thu, 11 Dec 2025 13:51:04 +0100
Message-Id: <20251211125104.375020-1-mlbnkm1@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The virtio vsock transport currently derives its TX credit directly from
peer_buf_alloc, which is populated from the remote endpoint's
SO_VM_SOCKETS_BUFFER_SIZE value.

On the host side, this means the amount of data we are willing to queue
for a given connection is scaled purely by a peer-chosen value, rather
than by the host's own vsock buffer configuration. A guest that
advertises a very large buffer and reads slowly can cause the host to
allocate a correspondingly large amount of sk_buff memory for that
connection.

In practice, a malicious guest can:

  - set a large AF_VSOCK buffer size (e.g. 2 GiB) with
    SO_VM_SOCKETS_BUFFER_MAX_SIZE / SO_VM_SOCKETS_BUFFER_SIZE, and

  - open multiple connections to a host vsock service that sends data
    while the guest drains slowly.

On an unconstrained host this can drive Slab/SUnreclaim into the tens of
GiB range, causing allocation failures and OOM kills in unrelated host
processes while the offending VM remains running.

On non-virtio transports and compatibility:

  - VMCI uses the AF_VSOCK buffer knobs to size its queue pairs per
    socket based on the local vsk->buffer_* values; the remote side
    can’t enlarge those queues beyond what the local endpoint
    configured.

  - Hyper-V’s vsock transport uses fixed-size VMBus ring buffers and
    an MTU bound; there is no peer-controlled credit field comparable
    to peer_buf_alloc, and the remote endpoint can’t drive in-flight
    kernel memory above those ring sizes.

  - The loopback path reuses virtio_transport_common.c, so it
    naturally follows the same semantics as the virtio transport.

Make virtio-vsock consistent with that model by intersecting the peer’s
advertised receive window with the local vsock buffer size when
computing TX credit. We introduce a small helper and use it in
virtio_transport_get_credit(), virtio_transport_has_space() and
virtio_transport_seqpacket_enqueue(), so that:

    effective_tx_window = min(peer_buf_alloc, buf_alloc)

This prevents a remote endpoint from forcing us to queue more data than
our own configuration allows, while preserving the existing credit
semantics and keeping virtio-vsock compatible with the other transports.

On an unpatched Ubuntu 22.04 host (~64 GiB RAM), running a PoC with
32 guest vsock connections advertising 2 GiB each and reading slowly
drove Slab/SUnreclaim from ~0.5 GiB to ~57 GiB and the system only
recovered after killing the QEMU process.

With this patch applied, rerunning the same PoC yields:

  Before:
    MemFree:        ~61.6 GiB
    MemAvailable:   ~62.3 GiB
    Slab:           ~142 MiB
    SUnreclaim:     ~117 MiB

  After 32 high-credit connections:
    MemFree:        ~61.5 GiB
    MemAvailable:   ~62.3 GiB
    Slab:           ~178 MiB
    SUnreclaim:     ~152 MiB

i.e. only ~35 MiB increase in Slab/SUnreclaim, no host OOM, and the
guest remains responsive.

Fixes: 06a8fc78367d ("VSOCK: Introduce virtio_vsock_common.ko")
Suggested-by: Stefano Garzarella <sgarzare@redhat.com>
Signed-off-by: Melbin K Mathew <mlbnkm1@gmail.com>
---
 net/vmw_vsock/virtio_transport_common.c | 27 ++++++++++++++++++++++---
 1 file changed, 24 insertions(+), 3 deletions(-)

diff --git a/net/vmw_vsock/virtio_transport_common.c b/net/vmw_vsock/virtio_transport_common.c
index dcc8a1d58..02eeb96dd 100644
--- a/net/vmw_vsock/virtio_transport_common.c
+++ b/net/vmw_vsock/virtio_transport_common.c
@@ -491,6 +491,25 @@ void virtio_transport_consume_skb_sent(struct sk_buff *skb, bool consume)
 }
 EXPORT_SYMBOL_GPL(virtio_transport_consume_skb_sent);
 
+/* Return the effective peer buffer size for TX credit computation.
+ *
+ * The peer advertises its receive buffer via peer_buf_alloc, but we
+ * cap that to our local buf_alloc (derived from
+ * SO_VM_SOCKETS_BUFFER_SIZE and already clamped to buffer_max_size)
+ * so that a remote endpoint cannot force us to queue more data than
+ * our own configuration allows.
+ */
+static u32 virtio_transport_tx_buf_alloc(struct virtio_vsock_sock *vvs)
+{
+	return min(vvs->peer_buf_alloc, vvs->buf_alloc);
+}
+
 u32 virtio_transport_get_credit(struct virtio_vsock_sock *vvs, u32 credit)
 {
 	u32 ret;
@@ -499,7 +518,8 @@ u32 virtio_transport_get_credit(struct virtio_vsock_sock *vvs, u32 credit)
 		return 0;
 
 	spin_lock_bh(&vvs->tx_lock);
-	ret = vvs->peer_buf_alloc - (vvs->tx_cnt - vvs->peer_fwd_cnt);
+	ret = virtio_transport_tx_buf_alloc(vvs) -
+		(vvs->tx_cnt - vvs->peer_fwd_cnt);
 	if (ret > credit)
 		ret = credit;
 	vvs->tx_cnt += ret;
@@ -831,7 +851,7 @@ virtio_transport_seqpacket_enqueue(struct vsock_sock *vsk,
 
 	spin_lock_bh(&vvs->tx_lock);
 
-	if (len > vvs->peer_buf_alloc) {
+	if (len > virtio_transport_tx_buf_alloc(vvs)) {
 		spin_unlock_bh(&vvs->tx_lock);
 		return -EMSGSIZE;
 	}
@@ -882,7 +902,8 @@ static s64 virtio_transport_has_space(struct vsock_sock *vsk)
 	struct virtio_vsock_sock *vvs = vsk->trans;
 	s64 bytes;
 
-	bytes = (s64)vvs->peer_buf_alloc - (vvs->tx_cnt - vvs->peer_fwd_cnt);
+	bytes = (s64)virtio_transport_tx_buf_alloc(vvs) -
+		(vvs->tx_cnt - vvs->peer_fwd_cnt);
 	if (bytes < 0)
 		bytes = 0;
 
-- 
2.34.1

