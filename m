Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2414379C20
	for <virtualization@lists.linux.dev>; Tue, 12 May 2026 08:07:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778573266; cv=none; b=IjuflXnL3t1Hg+Y22V4SF2ytvIfrQlL+ZhUk/rVtjMG7A0q091vDBHjk7m6IASaPTG9UIHJ9DaRl/IIqUTHAE2KKCdV56n2iG9szJQqrlP/KxRrfTrD1Un6reK9CT6tnadGGt58o+ffMnWvlf7sziG7subUwHyqvGFJOcfoL4jY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778573266; c=relaxed/simple;
	bh=sDobT2Y3suLHnIc3YUUU79mcvRr9manOsYeGpx1/XLs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:content-type; b=hXfN9gbw6dsBJBw4Rpe/ZCv3PKZvnK9ZL5uFm5Ny+rPbBwZgouHDSaeHFb5gtNzRmrri83ArBVh3yS6EXNQL3GtDk5mfwPnngaZwtuU7ZasRbNSyWwrvar9WBmxYIEvZvivmgd/3uHNAXdxwHCDCWE4u0Onb2oSzEEOi2dkLkaA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=bk/kUYev; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bk/kUYev"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1778573263;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=aAlloYEZDF1UlqHHhoebVA5d4jsXxGoTRkEIcdVVNEs=;
	b=bk/kUYevfM5shlC6N2OqSJ6Uu5+NpPQpwIrVjSADfY+AcIQggQ8pKgSh/EBhNVf9RGdTOD
	7IG3WPWMyKXH4N5iUEsu3Sp/JkXAUHvymZqiz97aI/gx09fcb0LsiJL1mxNFShKFH65WHd
	enrUCXXsOJqkZFpYdWYl9nThBYc8mg8=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-93-18NGlVtDNl-pJ4fUUIz3zQ-1; Tue, 12 May 2026 04:07:42 -0400
X-MC-Unique: 18NGlVtDNl-pJ4fUUIz3zQ-1
X-Mimecast-MFC-AGG-ID: 18NGlVtDNl-pJ4fUUIz3zQ_1778573261
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-488c2aa6becso42576115e9.2
        for <virtualization@lists.linux.dev>; Tue, 12 May 2026 01:07:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778573261; x=1779178061;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aAlloYEZDF1UlqHHhoebVA5d4jsXxGoTRkEIcdVVNEs=;
        b=LUf00CrRa2ItWEJltXsJ6XMX9Amd0O+PB9ZcB2FX+A6BYX8ypRFzgwTCt+4YPrUf6R
         HFZnzILc77kkpK1ucofjDwvlHSRxYoNlkwIOnWoik3QzqsJL9zrn4ruHhyqGsVCQKrHZ
         /9gXOgQ2PsG0UNLnyoQZZFFJVld1Nha0wzgRPfYDZOb27JUWjvC4IAr0zcPN/pEoC31H
         sgUztqtJx6fl+QPN9e1DX3+wHyd4ODFJtTzehuHpPS0wUo+1qfdAgwr00omg90ZTfKSc
         heQi+sBgIyC/t43Wo0epHvUaoQyXD7pgtgY5CgU0dCAzjUfEp4RaJmo5V2FcJiGV46EL
         SJIA==
X-Forwarded-Encrypted: i=1; AFNElJ8KbuuY4KjuxWKvg48Frq5edhNXUzivERKQKWGnnMVmt2PqzqXL2pu01oUDzSZTUhXBXetE9pmY+q+8WfcUGQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YzqyXzBrBG/0LBFwyVOpg05pQxRs43z7L+mIYHdyDOFjwps9vsp
	CovEukg1Dk4lZSB20BR1v3nPqNhEsi4hriFd1696hMYv03tJssqQ27crfQ0J6pf+hNKhaC/veWp
	hvTMy1necB5cO42kCPuQsK8YP3kuDm2dnbpSa+MP6XXDhJCClv4U6gw+gSe3MHWJil5ti
X-Gm-Gg: Acq92OHf5mLNeoWegCEC2YpGYmtsBSm2i+MDzkTSI2ihZ9m51zSW0X6EWlsI4hBOx6X
	3FH5qRMRZpvh++xentJRMw+UmQ+KgYKAlOGV1l7VXedx5y2UKrjgSODvG5SL8mgjRJ5Dyze2Sj1
	4xWmAmCiDbvqbE2k/yeTI8gLXrhI8y+ix0lDlwARlN3VoMw5zne+PkgoeX4f3qeKbwtNsHG2H6b
	AYCCtPHwdNR6jj0OgSao2wX2oeT8Pht7L6X3qJhQzjlFIXXgfmpo+b7oyODPx2Iav7rgwiBKGaV
	3CpEWq7O42Sw0FxDFIh8+a+uBkr4yeQwj1Dj3T0fpkYsP5dcmNd3ONlDaLEjd4fsJpxx0W4LL4R
	a1d900Tpth4sTr9NDeqUQb8AmN/9G+DXXKI7K/p11FBWcObrMn6+HfO5nSnUd
X-Received: by 2002:a05:600c:83c5:b0:488:9fb7:376d with SMTP id 5b1f17b1804b1-48e8fe834f0mr28134015e9.28.1778573260832;
        Tue, 12 May 2026 01:07:40 -0700 (PDT)
X-Received: by 2002:a05:600c:83c5:b0:488:9fb7:376d with SMTP id 5b1f17b1804b1-48e8fe834f0mr28133145e9.28.1778573260301;
        Tue, 12 May 2026 01:07:40 -0700 (PDT)
Received: from stex1 (host-87-16-204-231.retail.telecomitalia.it. [87.16.204.231])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48e90677b04sm26948005e9.11.2026.05.12.01.07.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 May 2026 01:07:39 -0700 (PDT)
From: Stefano Garzarella <sgarzare@redhat.com>
To: netdev@vger.kernel.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	=?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>,
	Eric Dumazet <edumazet@google.com>,
	"David S. Miller" <davem@davemloft.net>,
	kvm@vger.kernel.org,
	Stefano Garzarella <sgarzare@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	virtualization@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Simon Horman <horms@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Stefan Hajnoczi <stefanha@redhat.com>
Subject: [PATCH net v2] vsock/virtio: fix skb overhead accounting to preserve full buf_alloc
Date: Tue, 12 May 2026 10:07:37 +0200
Message-ID: <20260512080737.36787-1-sgarzare@redhat.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: _ic02OYubHgYaXZrOmAKBD7DnM3b3vGdNkwqmVvxjfk_1778573261
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

From: Stefano Garzarella <sgarzare@redhat.com>

After commit 059b7dbd20a6 ("vsock/virtio: fix potential unbounded skb
queue"), virtio_transport_inc_rx_pkt() subtracts per-skb overhead from
buf_alloc when checking whether a new packet fits. This reduces the
effective receive buffer below what the user configured via
SO_VM_SOCKETS_BUFFER_SIZE, causing legitimate data packets to be
silently dropped and applications that rely on the full buffer size
to deadlock.

Also, the reduced space is not communicated to the remote peer, so
its credit calculation accounts more credit than the receiver will
actually accept, causing data loss (there is no retransmission).

With this approach we currently have failures in
tools/testing/vsock/vsock_test.c. Test 18 sometimes fails, while
test 22 always fails in this way:
    18 - SOCK_STREAM MSG_ZEROCOPY...hash mismatch

    22 - SOCK_STREAM virtio credit update + SO_RCVLOWAT...send failed:
    Resource temporarily unavailable

Fix this by using `buf_alloc * 2` as the total budget for payload plus
skb overhead in virtio_transport_inc_rx_pkt(), similar to how SO_RCVBUF
is doubled to reserve space for sk_buff metadata. This preserves the
full buf_alloc for payload under normal operation, while still bounding
the skb queue growth.

When the total budget (buf_alloc * 2) is exceeded (e.g. under small-packet
flooding where overhead dominates), the connection is reset and local
socket error set to ENOBUFS, so both peers are explicitly notified of
the failure rather than silently losing data.

With this patch, all tests in tools/testing/vsock/vsock_test.c are
now passing again.

A solution to handle small-packet overhead efficiently also for
SEQPACKET (we already do that for STREAM) is planned as follow-up work.
This patch is needed in any case to prevent silent data loss, because
even if we reduce the overhead, we can't eliminate it entirely.

Fixes: 059b7dbd20a6 ("vsock/virtio: fix potential unbounded skb queue")
Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
---
v2:
- Close the connection when we can no longer queue new packets instead
  of losing data.
- No longer announce the reduced buf_alloc to avoid violating the
  spec. [MST]

v1: https://lore.kernel.org/netdev/20260508092330.69690-1-sgarzare@redhat.com/
---
 net/vmw_vsock/virtio_transport_common.c | 24 ++++++++++++++++++------
 1 file changed, 18 insertions(+), 6 deletions(-)

diff --git a/net/vmw_vsock/virtio_transport_common.c b/net/vmw_vsock/virtio_transport_common.c
index 9b8014516f4f..f23bf8a11319 100644
--- a/net/vmw_vsock/virtio_transport_common.c
+++ b/net/vmw_vsock/virtio_transport_common.c
@@ -449,7 +449,10 @@ static bool virtio_transport_inc_rx_pkt(struct virtio_vsock_sock *vvs,
 {
 	u64 skb_overhead = (skb_queue_len(&vvs->rx_queue) + 1) * SKB_TRUESIZE(0);
 
-	if (skb_overhead + vvs->buf_used + len > vvs->buf_alloc)
+	/* Use buf_alloc * 2 as total budget (payload + overhead), similar to
+	 * how SO_RCVBUF is doubled to reserve space for sk_buff metadata.
+	 */
+	if (skb_overhead + vvs->buf_used + len > (u64)vvs->buf_alloc * 2)
 		return false;
 
 	vvs->rx_bytes += len;
@@ -1365,7 +1368,7 @@ virtio_transport_recv_connecting(struct sock *sk,
 	return err;
 }
 
-static void
+static bool
 virtio_transport_recv_enqueue(struct vsock_sock *vsk,
 			      struct sk_buff *skb)
 {
@@ -1380,10 +1383,8 @@ virtio_transport_recv_enqueue(struct vsock_sock *vsk,
 	spin_lock_bh(&vvs->rx_lock);
 
 	can_enqueue = virtio_transport_inc_rx_pkt(vvs, len);
-	if (!can_enqueue) {
-		free_pkt = true;
+	if (!can_enqueue)
 		goto out;
-	}
 
 	if (le32_to_cpu(hdr->flags) & VIRTIO_VSOCK_SEQ_EOM)
 		vvs->msg_count++;
@@ -1423,6 +1424,8 @@ virtio_transport_recv_enqueue(struct vsock_sock *vsk,
 	spin_unlock_bh(&vvs->rx_lock);
 	if (free_pkt)
 		kfree_skb(skb);
+
+	return can_enqueue;
 }
 
 static int
@@ -1435,7 +1438,16 @@ virtio_transport_recv_connected(struct sock *sk,
 
 	switch (le16_to_cpu(hdr->op)) {
 	case VIRTIO_VSOCK_OP_RW:
-		virtio_transport_recv_enqueue(vsk, skb);
+		if (!virtio_transport_recv_enqueue(vsk, skb)) {
+			/* There is no more space to queue the packet, so let's
+			 * close the connection; otherwise, we'll lose data.
+			 */
+			(void)virtio_transport_reset(vsk, skb);
+			sk->sk_state = TCP_CLOSE;
+			sk->sk_err = ENOBUFS;
+			sk_error_report(sk);
+			break;
+		}
 		vsock_data_ready(sk);
 		return err;
 	case VIRTIO_VSOCK_OP_CREDIT_REQUEST:
-- 
2.54.0

