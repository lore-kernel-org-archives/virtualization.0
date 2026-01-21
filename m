Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D47A047DFB2
	for <virtualization@lists.linux.dev>; Wed, 21 Jan 2026 09:36:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768988212; cv=none; b=NN+Ej8a2roh1Iz0dvdLHZKpulj6lxxSiYMaR9mtEQZXWK5r1W0FlpDK861kiP+heF8R0eS2hHQyxECsyg0Q8BfEHCdiv+35RsP4M3FsqN6mJCyFQRkfRTDX7v/UoiaRAM0PbBLVXbc9SHP67FyblIdGehWXu1CoYkRMI/N0SFlg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768988212; c=relaxed/simple;
	bh=8FWDPO7w394Nl7XKsuUojlhzUFs0e7ivz29bXEwBdFU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:content-type; b=HICfyN+ZBDIe5xeI6OKy77FpLlSdmDY6e6knt45qURjUyP8+TiL+UzFnM2lFWxZB2MZONx/JD9lIkbfXtv4RqbjDYClzBPUQADz+oPrcZ9A0yhLdijG9NV8sT/zBCPnzCCmGtj9ujOhvZKoCuJeBVgsGLMlKJbgf8JynnMeyCMM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=QpXxFKE8; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QpXxFKE8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1768988209;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xGM0zHbdn0V12NgombpaBR+rEA6S/BsSNVQrMd4WoM4=;
	b=QpXxFKE8pUQo+oWA1IBEaDOmyPj5IAzcoOKi5qMYOMpmxnAKVPpvo16gUBErIC+yGdSByh
	T1cEp/AedSlH34Cl5yYRm0EiRoezmKK4lgsPwvonlyHoLl1yc4inGIRnXQOz0helFS3oh0
	9vLnQBnpYnrzH+7Us+DkBXXYEIxYPxw=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-343-8ajqzP-cPnKnB-FX0g2k1A-1; Wed, 21 Jan 2026 04:36:48 -0500
X-MC-Unique: 8ajqzP-cPnKnB-FX0g2k1A-1
X-Mimecast-MFC-AGG-ID: 8ajqzP-cPnKnB-FX0g2k1A_1768988207
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-435a2de6ec0so44004f8f.0
        for <virtualization@lists.linux.dev>; Wed, 21 Jan 2026 01:36:48 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768988207; x=1769593007;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=xGM0zHbdn0V12NgombpaBR+rEA6S/BsSNVQrMd4WoM4=;
        b=NEtSLvEYB4coOy+xPEQ+K+7hwVZazYBiVvjZPqYloHxOy1/YilIlMclzco8Nd5TMgz
         xmiR9eWnWhKlJm0DmETV8VU6iN30bsHFwPnQZEhILvjxxAbiAYd7Sp65da06k8DGH4qg
         CLdZoebKrGhaNA0nPa6smIH1ZqxXCrFoe4qdiIkOza0W7fQiO+iaywKpKik+gHcrinBh
         fUCYJWyk73pqHOT/JDkQshJfDHvve0RubbLlMw9c6ov2WVPkSHiw8PXDfVVBq0LobydL
         VUwbWeVfW7qoMpi6d9Tq6+Qu3/rUzyfgQWcllOIbKUCk9zZs78/9HVMHFHMylCjl+Yg2
         v8aA==
X-Forwarded-Encrypted: i=1; AJvYcCV7NppBJXzQ/QZKthsEMpqwWmYRZXxvH8r4XFfE9qzShJOCBk1Zhja/WP6z3qrSdQxgnsi7L2PViUiEYqNlhQ==@lists.linux.dev
X-Gm-Message-State: AOJu0Yw8GBMMFiQCRSxx4uOlJFYlYoXNb58oIbW3Z4zCa3FZNvfptPLH
	sc1cbT822wFHDldUEMNnH+oJYUceRMWjuN0eZaJ9hDM8R7z+woJpDszzIm4bUpHACNGLyz3SNnn
	X+KY4pNbojw50ot/FWxigKLAJ8n722DF7raDGKLkIhIkQysOJ+zGoEnDaSZcU6VKkUGvA
X-Gm-Gg: AZuq6aLG51pNtjyD2uLl2S74flCAmii2Qn8Zq+BKKedgACPt/LNjd6YoF9hcIuan0xc
	2CcfJzhgJ/l6bO2rEal5y8I0dCsxEWAy9wD6e41OZ42UOexX7H/vI29Nyj+Q6pIqgKPgiehscBw
	iaEx5S80Virv9py/wIJr4zTASTX8RHIpKrd8PcGQrlAtNw95wiwLI5Jw5SPpj0dypmUIkg71lNw
	+l+ZPoaWlQhQksRpPNhJ8Pg6Ni2NL5c18QTX5hXk/t0e2hbdIYOaEpioSMIIb8xW4j7eAmUSXnD
	v2FTdB0eZSvOFPl8oPF4MvCHrbGrPhtE3WuLP5DYKArT7JHsiR4qnmuibI5SHxbEO0lcROSODWr
	uRhGrurzv6qPaIhwwBfFEcqCECMNxAcn5/izu10zCgrHsXwdqO6y5CrXKEemL
X-Received: by 2002:a05:6000:18b:b0:435:94c4:649c with SMTP id ffacd0b85a97d-43594c4658bmr4628408f8f.30.1768988207202;
        Wed, 21 Jan 2026 01:36:47 -0800 (PST)
X-Received: by 2002:a05:6000:18b:b0:435:94c4:649c with SMTP id ffacd0b85a97d-43594c4658bmr4628374f8f.30.1768988206674;
        Wed, 21 Jan 2026 01:36:46 -0800 (PST)
Received: from stex1.redhat.com (host-82-53-134-58.retail.telecomitalia.it. [82.53.134.58])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43569921da2sm35389534f8f.1.2026.01.21.01.36.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Jan 2026 01:36:45 -0800 (PST)
From: Stefano Garzarella <sgarzare@redhat.com>
To: netdev@vger.kernel.org
Cc: Simon Horman <horms@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Arseniy Krasnov <AVKrasnov@sberdevices.ru>,
	"David S. Miller" <davem@davemloft.net>,
	Stefano Garzarella <sgarzare@redhat.com>,
	virtualization@lists.linux.dev,
	Paolo Abeni <pabeni@redhat.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Stefan Hajnoczi <stefanha@redhat.com>,
	kvm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Claudio Imbrenda <imbrenda@linux.vnet.ibm.com>,
	Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	=?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>,
	Asias He <asias@redhat.com>,
	Melbin K Mathew <mlbnkm1@gmail.com>
Subject: [PATCH net v6 3/4] vsock/virtio: cap TX credit to local buffer size
Date: Wed, 21 Jan 2026 10:36:27 +0100
Message-ID: <20260121093628.9941-4-sgarzare@redhat.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260121093628.9941-1-sgarzare@redhat.com>
References: <20260121093628.9941-1-sgarzare@redhat.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: VMle-KD2mfzvQ1yKuvypTppOriSrETbr5taJcE9WQAg_1768988207
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
index 6175124d63d3..d3e26025ef58 100644
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

