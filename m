Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BD3B1624DF
	for <virtualization@lists.linux.dev>; Wed, 10 Dec 2025 13:33:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765373606; cv=none; b=VlhtkFuYyZCmvr0hA+UznTuqLB2zw7fsqVafXTZlBUfXSn+ZXUG4n6Jx5lLBxxWzArm+RPXPvebFMExOTPK3H5GRHlKY6fiWTmVAwBNylQgoZxYnLsVS+FFYjYh/txyDNNRva/16jeNDQg0TwppryZrAiwCPwlxrmCfujCZkg8M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765373606; c=relaxed/simple;
	bh=0wLH31HDwfSTe/1EuiWHtYsukRblUE1QRCxb3uKciDA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=pRiIoX7R8gfbMq3m6YZ3jXOS7LTmCIPLLWYEAdRbF6Rn0+nUscMUvgGuHlbFUwLDGoD4v9X8xAB5/4RSKPlqCcSjlkLieF4p5N4WpV3nELe71Snr66mKvhg1zuG27Mt95d6EwlOIVpfHKkNzIBbRG+GRN1ngLzwpOmXrSl8F9Jo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=R1Hm7q0r; arc=none smtp.client-ip=209.85.167.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R1Hm7q0r"
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-5957e017378so8680886e87.3
        for <virtualization@lists.linux.dev>; Wed, 10 Dec 2025 05:33:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765373602; x=1765978402; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=oD5ipYc8BirTwTUNyp9GQ08Nz/lO30YuP7q1nZr2KbU=;
        b=R1Hm7q0rCqLiT7tFHLuN3N1ERnqOaVgvVHGzvRhzmFVFKGoYGSfeuVZhMA3K/ZwzB4
         kyb+CbuhTfLEHxpJDUKdl/5mvvRwRLTQZGQ+N8t7PghZEm5RfEyKHEY5UEYfxwmjFAmN
         QKRBu6IKaoJzvM87GF+Sy3n0c1JRuBLLE7w2rY+svFSRz5AUehQUEfx4Jw9cQN7cIWUe
         4moabVnfmTIwgyNgjhqKvn9aa1YxttZTPPNh0/UzZ5GJugopbMFvtppGBhKVKUYptkDj
         sEk2i0/8c10rGm36Docfv1iagR7Q0ZhdJAY/kA17uO/AH+xaxuvlgiGoNCzmDoDAkgSl
         Hu+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765373602; x=1765978402;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oD5ipYc8BirTwTUNyp9GQ08Nz/lO30YuP7q1nZr2KbU=;
        b=HeJDcGfL1E/GtGjuoblxZOjh3ypr8d42aCWlNLYpbBG5ABPpOd3oH74GrMwhHza+oQ
         65bjAGyWsYUcH1lGowqBoPj63VlgJ9rR+YxbUJVdW3QbZbVKSoabTiiOw6lv4VrBbQxW
         w2Y4CJNOXcqpyWQCxAitAybfyQ15eQVmJcZIdmh9znccSmxE8QkfGvk4iLPdGSV4UTfO
         960Klnc9tg5k4fUPm/hBvFbvqArWjhP4SgimOEKVjwnD8fRpvs1QuqCxydvx1xmzTGDF
         h9Zw5d34kW5tlNdiM4yTXy8AtYObk/1B6APHr/z2mVBlcXYAVE/4WeJFxOx5PA/2Z9Aa
         6SRQ==
X-Gm-Message-State: AOJu0YzuEutZrOcJnpHaIa+PrMoY4cF/DCea+6NiA8RZ1F0nrSkXasbg
	e0rkrKvLdXFnxwRIcWVlplttx/57Exk1OYXUkCGkMfWaSXntuEC9EwHK
X-Gm-Gg: AY/fxX5bzJ5ywejq7zCZLQnY57tQDZgCiWWhdLmn6WsXXDOiQeKrhhgv8GjPL0N9EoQ
	tfGMTQJkOjGxIzVw7tCBkMut4uUFWBsOpHzXvi02ffjL37bL+wnfdu1W39iHOwWZDZ7DioH1UZ1
	EnTOxLKyo0gdHtAy70jzmU4kudvFYoucNbQXJnRG3smRyvb/SzLf/8/lM3keVk/eYfqpiwLl4zu
	NEJn6PqyjuIFGpeLrC3Ohy9TvXyqv+cm3gV3l11h//fB92xrYSq7S8OvNGloKebmDv0fHuAKb8z
	5+DEtr8ErA1bCTNAfFLBFCmIBDxv/RQpbX+gqKACrcqdJMAbIVEsRM/tPZW/NUsgwEgYIUUQuNU
	vC15XuKn74Y34BM2FLQYfbcrhAF7OE0dVbUmC96ZTnbjXdpb2VZEmvITVOCZrlPrp1iNG/4Dfn3
	bDUWwAinPdfNw=
X-Google-Smtp-Source: AGHT+IGuUo6ZoxmOLPJELy4E+MQsRaQCeY8UlKN8xDwSV5aN/WHR1k1qW9H8XravEGuc7+/9yStW0A==
X-Received: by 2002:a05:6512:3d8c:b0:595:9d90:5dc6 with SMTP id 2adb3069b0e04-598ee4e6446mr990906e87.19.1765373602129;
        Wed, 10 Dec 2025 05:33:22 -0800 (PST)
Received: from Ubuntu-2204-jammy-amd64-base.. ([2a01:4f9:6a:4e9f::2])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-597d7c1e2acsm6473621e87.61.2025.12.10.05.33.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Dec 2025 05:33:21 -0800 (PST)
From: Melbin K Mathew <mlbnkm1@gmail.com>
To: netdev@vger.kernel.org
Cc: virtualization@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	sgarzare@redhat.com,
	stefanha@redhat.com,
	mst@redhat.com,
	jasowang@redhat.com,
	Melbin K Mathew <mlbnkm1@gmail.com>
Subject: [PATCH net] vsock/virtio: cap TX credit to local buffer size
Date: Wed, 10 Dec 2025 14:32:59 +0100
Message-Id: <20251210133259.16238-1-mlbnkm1@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The virtio vsock transport currently derives its TX credit directly
from peer_buf_alloc, which is set from the remote endpoint's
SO_VM_SOCKETS_BUFFER_SIZE value.

On the host side this means that the amount of data we are willing to
queue for a connection is scaled by a guest-chosen buffer size,
rather than the host's own vsock configuration. A malicious guest can
advertise a large buffer and read slowly, causing the host to allocate
a correspondingly large amount of sk_buff memory.

Introduce a small helper, virtio_transport_peer_buf_alloc(), that
returns min(peer_buf_alloc, buf_alloc), and use it wherever we consume
peer_buf_alloc:

  - virtio_transport_get_credit()
  - virtio_transport_has_space()
  - virtio_transport_seqpacket_enqueue()

This ensures the effective TX window is bounded by both the peer's
advertised buffer and our own buf_alloc (already clamped to
buffer_max_size via SO_VM_SOCKETS_BUFFER_MAX_SIZE), so a remote guest
cannot force the host to queue more data than allowed by the host's
own vsock settings.

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

Fixes: d021c344051a ("VSOCK: Introduce VM Sockets")
Reported-by: Melbin K Mathew <mlbnkm1@gmail.com>
Signed-off-by: Melbin K Mathew <mlbnkm1@gmail.com>
---
 net/vmw_vsock/virtio_transport_common.c | 27 ++++++++++++++++++++++---
 1 file changed, 24 insertions(+), 3 deletions(-)

diff --git a/net/vmw_vsock/virtio_transport_common.c b/net/vmw_vsock/virtio_transport_common.c
index dcc8a1d58..f5afedf01 100644
--- a/net/vmw_vsock/virtio_transport_common.c
+++ b/net/vmw_vsock/virtio_transport_common.c
@@ -491,6 +491,25 @@ void virtio_transport_consume_skb_sent(struct sk_buff *skb, bool consume)
 }
 EXPORT_SYMBOL_GPL(virtio_transport_consume_skb_sent);
 
+/*
+ * Return the effective peer buffer size for TX credit computation.
+ *
+ * The peer advertises its receive buffer via peer_buf_alloc, but we
+ * cap that to our local buf_alloc (derived from
+ * SO_VM_SOCKETS_BUFFER_SIZE and already clamped to buffer_max_size)
+ * so that a remote endpoint cannot force us to queue more data than
+ * our own configuration allows.
+ */
+static u32 virtio_transport_peer_buf_alloc(struct virtio_vsock_sock *vvs)
+{
+	u32 peer  = vvs->peer_buf_alloc;
+	u32 local = vvs->buf_alloc;
+
+	if (peer > local)
+		return local;
+	return peer;
+}
+
 u32 virtio_transport_get_credit(struct virtio_vsock_sock *vvs, u32 credit)
 {
 	u32 ret;
@@ -499,7 +518,8 @@ u32 virtio_transport_get_credit(struct virtio_vsock_sock *vvs, u32 credit)
 		return 0;
 
 	spin_lock_bh(&vvs->tx_lock);
-	ret = vvs->peer_buf_alloc - (vvs->tx_cnt - vvs->peer_fwd_cnt);
+	ret = virtio_transport_peer_buf_alloc(vvs) -
+             (vvs->tx_cnt - vvs->peer_fwd_cnt);
 	if (ret > credit)
 		ret = credit;
 	vvs->tx_cnt += ret;
@@ -831,7 +851,7 @@ virtio_transport_seqpacket_enqueue(struct vsock_sock *vsk,
 
 	spin_lock_bh(&vvs->tx_lock);
 
-	if (len > vvs->peer_buf_alloc) {
+	if (len > virtio_transport_peer_buf_alloc(vvs)) {
 		spin_unlock_bh(&vvs->tx_lock);
 		return -EMSGSIZE;
 	}
@@ -882,7 +902,8 @@ static s64 virtio_transport_has_space(struct vsock_sock *vsk)
 	struct virtio_vsock_sock *vvs = vsk->trans;
 	s64 bytes;
 
-	bytes = (s64)vvs->peer_buf_alloc - (vvs->tx_cnt - vvs->peer_fwd_cnt);
+	bytes = (s64)virtio_transport_peer_buf_alloc(vvs) -
+               (vvs->tx_cnt - vvs->peer_fwd_cnt);
 	if (bytes < 0)
 		bytes = 0;
 
-- 
2.34.1

