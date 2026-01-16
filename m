Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD3B13A4AC7
	for <virtualization@lists.linux.dev>; Fri, 16 Jan 2026 20:15:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768594541; cv=none; b=bcMqHVeGcHuCacdw8nTiy4ENNsyvsQD+nudOlkGMklEkr1tRV25nnGvg6Na0cntuA6IghJIhclK8ONed++rlmhQSogrlfIJjYoGUP8m3SXhaGJeIQyKixc+6z9zbACqPhlvZ3/7S5kwhjKlaIc6uYQK+GSOUx52Rn5H1py9CQ3Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768594541; c=relaxed/simple;
	bh=vfLaZ/x6PhPiKKL/eiQKsaUIp8fH+OSFlnq0nAGw7+Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:content-type; b=bG5XltuOWpaKOQO7xMCo6hHb80Zix78LMWQtoRD/ZLXu7Y0vPFtxdzd0KAqrpnEDoP9NkMOdvUifcPirPd+neGXDhsKnUAEmaZyNdYXljFNdD3V5gbxjBOsFP8wGNpUj69j/ywdQpgDpq15A8EXoBJFOCjGwfWVfn/kYwVKJGWY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=YkgMAkgX; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YkgMAkgX"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1768594538;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=JOY0EgIBRqk7jAnNyMBWfVkbAAKnvpv7/putmSk3IKk=;
	b=YkgMAkgXbKbpwDbt3TeUKO/yLUAvLtM8c/BCQWdK9yhYZTLLXrjnduGEcFkp88gDoGtBDE
	RQWJmh+bOjJ/IRmzRkruGrvcwt1z9KuDKMHfIVD2OnroWFk99+niyQrCvaIOH0bAs3PIiu
	HWm43NSWSsTYP8OOywLJlXCfaXmjaQ4=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-333-AHWfmU_dNd60mrlY_NFWNg-1; Fri, 16 Jan 2026 15:15:37 -0500
X-MC-Unique: AHWfmU_dNd60mrlY_NFWNg-1
X-Mimecast-MFC-AGG-ID: AHWfmU_dNd60mrlY_NFWNg_1768594536
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-47edf8ba319so23885105e9.2
        for <virtualization@lists.linux.dev>; Fri, 16 Jan 2026 12:15:36 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768594535; x=1769199335;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=JOY0EgIBRqk7jAnNyMBWfVkbAAKnvpv7/putmSk3IKk=;
        b=s6rXVi49ud2OgHTdlnL2odK/kDXQDZtwkRkeczzHcULrMZ+kBE4+ByXyYPdkaDhUE+
         XNR5RqaGr33eLASSZRLAKkb8VXt9BVC+3jarnH16gQ2fHYX7/RLpnHcaLjFURMC/5tdd
         HQJY0eIq+n1f9zH5LjyeW4kDv5LhO0svzAzrBZ54AlnqKz+/gTR1qebH1bkFZ0yntq3t
         vy9TsJZL2AkKntM4wQveBmzpiBM6e8t6+eQ5mXo/iTlxDq6AJKyAJt4VO+E0psGouVps
         ycEQ8JSy8AhzR40jpV4WRWwPZPoVAxWMk7q5c4+6eEASbCClt5m6zbFUbxGvq+Wquh8p
         lfqA==
X-Gm-Message-State: AOJu0YwB3SEZJtsAE7/V0ZWDDpFM0jz678KxpLL1RBE9EryU6/geOd6c
	Zds5jM8sib9uLvwP+Xw8RBo5kmt1aUNw/icE9619DfhL3avkraYcI8ANsB7OH3H0rQQu2keyZ5I
	2WXmULcZspmX+jCR2etXfpQFtpW7IjjSo0JGXdnLoZGeUA1s6s2sZafiRgm/Fm7ZGr6KE
X-Gm-Gg: AY/fxX4fk2g1p6agINJbx/eCz2PXhL9c0qzfV2gofhaqldcMnNm5KtAiRFhzOyoCpfR
	A8sqQo8N2/ZOa/hfnENFIu5iXEusIVxZAJIZ7lYXf3IOlRjQ4ZzvucaOABQKxA6PRbTg0Tbkru8
	Wwnzf9rHiwXhhPWZEXnqIPGsEB8rI0+A5sGqg+wLL3AqNI1ENTJEC0bnST0rAkDOD9Yb87S6vB6
	p1E/qJtOF09R70YK0xVRtSe9jT33gE5vs8wQMpbZt/lRxpcuWljh+6PHlBUW/XApuC8X/wWThFk
	52zfuFWyNgwlVSd+PeELArqOFK1iCEnjJtnfrIKtDuyMou5EHtnMd4UYbOqtNM5SK2iwIMWB9+d
	jxzMzxNTTQDerM5eBDVCt2IKCZQB6KqrIo1aqJE94RzYC+KZvfMOKcEB4s52g
X-Received: by 2002:a05:600c:3495:b0:477:7975:30ea with SMTP id 5b1f17b1804b1-4801e343a9fmr50017525e9.29.1768594535513;
        Fri, 16 Jan 2026 12:15:35 -0800 (PST)
X-Received: by 2002:a05:600c:3495:b0:477:7975:30ea with SMTP id 5b1f17b1804b1-4801e343a9fmr50017195e9.29.1768594535065;
        Fri, 16 Jan 2026 12:15:35 -0800 (PST)
Received: from stex1.redhat.com (host-82-53-134-58.retail.telecomitalia.it. [82.53.134.58])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4801fe65883sm22287425e9.15.2026.01.16.12.15.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Jan 2026 12:15:34 -0800 (PST)
From: Stefano Garzarella <sgarzare@redhat.com>
To: netdev@vger.kernel.org
Cc: virtualization@lists.linux.dev,
	"Michael S. Tsirkin" <mst@redhat.com>,
	=?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>,
	Stefan Hajnoczi <stefanha@redhat.com>,
	Paolo Abeni <pabeni@redhat.com>,
	kvm@vger.kernel.org,
	Eric Dumazet <edumazet@google.com>,
	linux-kernel@vger.kernel.org,
	Jason Wang <jasowang@redhat.com>,
	Claudio Imbrenda <imbrenda@linux.vnet.ibm.com>,
	Simon Horman <horms@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Arseniy Krasnov <AVKrasnov@sberdevices.ru>,
	Asias He <asias@redhat.com>,
	Stefano Garzarella <sgarzare@redhat.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Melbin K Mathew <mlbnkm1@gmail.com>
Subject: [PATCH RESEND net v5 3/4] vsock/virtio: cap TX credit to local buffer size
Date: Fri, 16 Jan 2026 21:15:16 +0100
Message-ID: <20260116201517.273302-4-sgarzare@redhat.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260116201517.273302-1-sgarzare@redhat.com>
References: <20260116201517.273302-1-sgarzare@redhat.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: CpzilZFjtMyLQ9bXtzZy_1QJswa2YFhPNgSL4m3jBGs_1768594536
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

From: Melbin K Mathew <mlbnkm1@gmail.com>

The virtio transports derives its TX credit directly from peer_buf_alloc,
which is set from the remote endpoint's SO_VM_SOCKETS_BUFFER_SIZE value.

On the host side this means that the amount of data we are willing to
queue for a connection is scaled by a guest-chosen buffer size, rather
than the host's own vsock configuration. A malicious guest can advertise
a large buffer and read slowly, causing the host to allocate a
correspondingly large amount of sk_buff memory.
The same thing would happen in the guest with a malicious host, since
virtio transports share the same code base.

Introduce a small helper, virtio_transport_tx_buf_size(), that
returns min(peer_buf_alloc, buf_alloc), and use it wherever we consume
peer_buf_alloc.

This ensures the effective TX window is bounded by both the peer's
advertised buffer and our own buf_alloc (already clamped to
buffer_max_size via SO_VM_SOCKETS_BUFFER_MAX_SIZE), so a remote peer
cannot force the other to queue more data than allowed by its own
vsock settings.

On an unpatched Ubuntu 22.04 host (~64 GiB RAM), running a PoC with
32 guest vsock connections advertising 2 GiB each and reading slowly
drove Slab/SUnreclaim from ~0.5 GiB to ~57 GiB; the system only
recovered after killing the QEMU process. That said, if QEMU memory is
limited with cgroups, the maximum memory used will be limited.

With this patch applied:

  Before:
    MemFree:        ~61.6 GiB
    Slab:           ~142 MiB
    SUnreclaim:     ~117 MiB

  After 32 high-credit connections:
    MemFree:        ~61.5 GiB
    Slab:           ~178 MiB
    SUnreclaim:     ~152 MiB

Only ~35 MiB increase in Slab/SUnreclaim, no host OOM, and the guest
remains responsive.

Compatibility with non-virtio transports:

  - VMCI uses the AF_VSOCK buffer knobs to size its queue pairs per
    socket based on the local vsk->buffer_* values; the remote side
    cannot enlarge those queues beyond what the local endpoint
    configured.

  - Hyper-V's vsock transport uses fixed-size VMBus ring buffers and
    an MTU bound; there is no peer-controlled credit field comparable
    to peer_buf_alloc, and the remote endpoint cannot drive in-flight
    kernel memory above those ring sizes.

  - The loopback path reuses virtio_transport_common.c, so it
    naturally follows the same semantics as the virtio transport.

This change is limited to virtio_transport_common.c and thus affects
virtio-vsock, vhost-vsock, and loopback, bringing them in line with the
"remote window intersected with local policy" behaviour that VMCI and
Hyper-V already effectively have.

Fixes: 06a8fc78367d ("VSOCK: Introduce virtio_vsock_common.ko")
Suggested-by: Stefano Garzarella <sgarzare@redhat.com>
Signed-off-by: Melbin K Mathew <mlbnkm1@gmail.com>
[Stefano: small adjustments after changing the previous patch]
[Stefano: tweak the commit message]
Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
---
 net/vmw_vsock/virtio_transport_common.c | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/net/vmw_vsock/virtio_transport_common.c b/net/vmw_vsock/virtio_transport_common.c
index 2fe341be6ce2..00f4cf86beac 100644
--- a/net/vmw_vsock/virtio_transport_common.c
+++ b/net/vmw_vsock/virtio_transport_common.c
@@ -821,6 +821,15 @@ virtio_transport_seqpacket_dequeue(struct vsock_sock *vsk,
 }
 EXPORT_SYMBOL_GPL(virtio_transport_seqpacket_dequeue);
 
+static u32 virtio_transport_tx_buf_size(struct virtio_vsock_sock *vvs)
+{
+	/* The peer advertises its receive buffer via peer_buf_alloc, but we
+	 * cap it to our local buf_alloc so a remote peer cannot force us to
+	 * queue more data than our own buffer configuration allows.
+	 */
+	return min(vvs->peer_buf_alloc, vvs->buf_alloc);
+}
+
 int
 virtio_transport_seqpacket_enqueue(struct vsock_sock *vsk,
 				   struct msghdr *msg,
@@ -830,7 +839,7 @@ virtio_transport_seqpacket_enqueue(struct vsock_sock *vsk,
 
 	spin_lock_bh(&vvs->tx_lock);
 
-	if (len > vvs->peer_buf_alloc) {
+	if (len > virtio_transport_tx_buf_size(vvs)) {
 		spin_unlock_bh(&vvs->tx_lock);
 		return -EMSGSIZE;
 	}
@@ -884,7 +893,8 @@ static s64 virtio_transport_has_space(struct virtio_vsock_sock *vvs)
 	 * we have bytes in flight (tx_cnt - peer_fwd_cnt), the subtraction
 	 * does not underflow.
 	 */
-	bytes = (s64)vvs->peer_buf_alloc - (vvs->tx_cnt - vvs->peer_fwd_cnt);
+	bytes = (s64)virtio_transport_tx_buf_size(vvs) -
+		(vvs->tx_cnt - vvs->peer_fwd_cnt);
 	if (bytes < 0)
 		bytes = 0;
 
-- 
2.52.0

