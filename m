Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D63533D515
	for <virtualization@lists.linux.dev>; Fri,  8 May 2026 09:23:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778232219; cv=none; b=WiAiJRM0qth4Udcy0X0eyYWn2qVQhhYRsNAnd9TC+kOAa7XU2dABgMCHzHsD2SDR/u3CLAQ7DHxK+oikPX1JeA17RVYswbeE1k7zeGiR1GYYq1UNC/3f85tH7unOehnwgM9l03Vq0UFsHIwE2r+YCOJSTN+4VxuMjLmkdQ8+P3I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778232219; c=relaxed/simple;
	bh=8LRSStW2VoNApjyq7vcaSmNuz5Qon/i9zONda+7Hib4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:content-type; b=Jv+rOzKCAnFAoe0MZqd45ATw2AuWXiva/uFF+p3qr+1qyVuKcfWM5WRjGYjrAKReMy/60Spc/gh0MVo7fyVnDFwa1qGiyMUhMksBziZKh+DSdSiCNthVBDdxImhp0+VfwUB17veLsdxzTiJAdmmwhPFE1E1QP6P1NxhLjK7CIYI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=a9ha2DUR; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="a9ha2DUR"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1778232216;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=yASdWjRr9O1Fv1pSyMZ8vcPjBnLsiRkgqyUNKE6lF10=;
	b=a9ha2DUR80B3GdvVstqyctsbObxx3bOKnsPtQxcHvKsmfkwI4Ikft3m4wpygvBh4gZuCwl
	k27XDmpxyvbdLYnvj7mEj+HRd+2cxgKAoHgH8Nu2X4lYi908HQW4HhL0YwHXdySWvp1ujq
	MwIrxZehsoc9tNJ/8vLshGaGbvrDRtw=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-381-2xWdg2SJMyCiCyp-nwJfYw-1; Fri, 08 May 2026 05:23:35 -0400
X-MC-Unique: 2xWdg2SJMyCiCyp-nwJfYw-1
X-Mimecast-MFC-AGG-ID: 2xWdg2SJMyCiCyp-nwJfYw_1778232214
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-48a589c7879so20888125e9.1
        for <virtualization@lists.linux.dev>; Fri, 08 May 2026 02:23:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778232214; x=1778837014;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yASdWjRr9O1Fv1pSyMZ8vcPjBnLsiRkgqyUNKE6lF10=;
        b=msFdLiSS05phwI70I4lTQ56lLzGYmLD8eIwfnPTP0kRKBrFXwcvcrwIoDsgKYE6Xom
         t209iMtdXfhmg/WkBCWBGpzOc3jbTtZ8NYRfubNvQn2tnak0Lli/lWYmkJHoGi4qezVl
         zMH/78EyJ9Wjav9WBK26xWhNxdmhZN/995XbX5tzxGf7yquBYj16863yrrxVq8BTFOMY
         SIkdnsMFhZtjNjCf/dQNu0xb6C9SnQjTp47IUQ1qzpHAL0ehGndLzQhRDr4R0hWldicJ
         FowwNAu3u5T6dGmc9suG2EpJMBpKliWVMwP5TkDIGH2ipLN07a8m4nrWKmTgBcQ1BiEr
         XgAA==
X-Forwarded-Encrypted: i=1; AFNElJ8fTEP7YAvoJQgGl0e6FDzJxvUR2MnDIxZ+CPPWt10Gi4qQZOut7dThgBi28LHHPVnQ3SvhOPiFBmPDkuXpEA==@lists.linux.dev
X-Gm-Message-State: AOJu0YwWr55hy3d0XA5Y/t8XSBHI70CqtQiLv6iNgqes/RlL+eL3L97e
	Ey7UYSuRgH0vKUa9yJygMvntyANUh64KOhU2jMbeML8DnjLMfjQJp4N7HTZbFzkoMYOXTeBbcJM
	KqWVBM0YNt4nbgG11Us9l287ntQlv/KHz5xnaro1Eu2Utgm93qRrzW5HBJ3d/RzJzfCQe
X-Gm-Gg: AeBDiet0Sk9k3AEBPfkNcPH1ljvMMfXTkRj64VIfUpbn/ppkBsmbUmiNa4yxWmnMSfB
	RB78SLrPVxBhmmDpY/Vl45W3tkFBmxy9Q+oEYlRpJLFOJRoIYd9bWTDKKnOy7JYXVtDhWaUfVta
	zS+naNdpj9ekMDTA8oCi9qsNjRlA+DUxn7TysvAIUhxn0FxEwuu98jU1ybCv3d3MjJIdLHDnGrY
	nL2MYZ48/8kPqKh51hoDl1Se9zW1pIvMOVba6v4EmjUF4by05RP1hUsS1DxZ0FMsxcKk4Tq5RjK
	/zF1DmtZSK0KxiAzraxYLRL3tmQXooBacZaVt2mdO4gzD7+dt+lsYY+Aaf1TPaUmA6FGCZ1cztu
	UfHGhvjnLV0OdJLLqI6OjkLQpziBUPy9RxU1EGtYb1OeY2cyngzzZya+upOKleBdVqg==
X-Received: by 2002:a05:600c:3e86:b0:48a:5339:a46 with SMTP id 5b1f17b1804b1-48e5dffabcamr92546845e9.9.1778232213896;
        Fri, 08 May 2026 02:23:33 -0700 (PDT)
X-Received: by 2002:a05:600c:3e86:b0:48a:5339:a46 with SMTP id 5b1f17b1804b1-48e5dffabcamr92546285e9.9.1778232213361;
        Fri, 08 May 2026 02:23:33 -0700 (PDT)
Received: from stex1.redhat.corp (host-87-11-6-2.retail.telecomitalia.it. [87.11.6.2])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48e642e5805sm15776295e9.7.2026.05.08.02.23.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 May 2026 02:23:32 -0700 (PDT)
From: Stefano Garzarella <sgarzare@redhat.com>
To: netdev@vger.kernel.org
Cc: Eric Dumazet <edumazet@google.com>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Stefan Hajnoczi <stefanha@redhat.com>,
	virtualization@lists.linux.dev,
	"David S. Miller" <davem@davemloft.net>,
	Jason Wang <jasowang@redhat.com>,
	Simon Horman <horms@kernel.org>,
	linux-kernel@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	kvm@vger.kernel.org,
	Jakub Kicinski <kuba@kernel.org>,
	Stefano Garzarella <sgarzare@redhat.com>,
	=?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>
Subject: [PATCH net] vsock/virtio: fix skb overhead accounting to preserve full buf_alloc
Date: Fri,  8 May 2026 11:23:30 +0200
Message-ID: <20260508092330.69690-1-sgarzare@redhat.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: Epe4D1uLXfQQEZc8x6LvPvgUuraN6YRjVBEqVJMSySY_1778232214
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

This also causes failures in tools/testing/vsock/vsock_test.c.
Test 18 sometimes fails, while test 22 always fails in this way:
    18 - SOCK_STREAM MSG_ZEROCOPY...hash mismatch

    22 - SOCK_STREAM virtio credit update + SO_RCVLOWAT...send failed:
    Resource temporarily unavailable

Fix this by introducing virtio_transport_rx_buf_size() to calculate the
size of the RX buffer based on the overhead. Using it in the acceptance
check, the advertised buf_alloc, and the credit update decision.
Use buf_alloc * 2 as total budget (payload + overhead), similar to how
SO_RCVBUF is doubled to reserve space for sk_buff metadata.
The function returns buf_alloc as long as overhead fits within the
reservation, then gradually reduces toward 0 as overhead exceeds
buf_alloc (e.g. under small-packet flooding), informing the peer to
slow down.

Fixes: 059b7dbd20a6 ("vsock/virtio: fix potential unbounded skb queue")
Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
---
 net/vmw_vsock/virtio_transport_common.c | 31 +++++++++++++++++++++----
 1 file changed, 27 insertions(+), 4 deletions(-)

diff --git a/net/vmw_vsock/virtio_transport_common.c b/net/vmw_vsock/virtio_transport_common.c
index 9b8014516f4f..94a4beb8fd61 100644
--- a/net/vmw_vsock/virtio_transport_common.c
+++ b/net/vmw_vsock/virtio_transport_common.c
@@ -444,12 +444,32 @@ static int virtio_transport_send_pkt_info(struct vsock_sock *vsk,
 	return ret;
 }
 
+/* vvs->rx_lock held by the caller */
+static u32 virtio_transport_rx_buf_size(struct virtio_vsock_sock *vvs)
+{
+	u64 skb_overhead = (skb_queue_len(&vvs->rx_queue) + 1) * SKB_TRUESIZE(0);
+	/* Use buf_alloc * 2 as total budget (payload + overhead), similar to
+	 * how SO_RCVBUF is doubled to reserve space for sk_buff metadata.
+	 */
+	u64 total_budget = (u64)vvs->buf_alloc * 2;
+
+	/* Overhead within buf_alloc: full buf_alloc available for payload */
+	if (skb_overhead < vvs->buf_alloc)
+		return vvs->buf_alloc;
+
+	/* Overhead exceeded buf_alloc: gradually reduce to bound skb queue */
+	if (skb_overhead < total_budget)
+		return total_budget - skb_overhead;
+
+	return 0;
+}
+
 static bool virtio_transport_inc_rx_pkt(struct virtio_vsock_sock *vvs,
 					u32 len)
 {
-	u64 skb_overhead = (skb_queue_len(&vvs->rx_queue) + 1) * SKB_TRUESIZE(0);
+	u32 rx_buf_size = virtio_transport_rx_buf_size(vvs);
 
-	if (skb_overhead + vvs->buf_used + len > vvs->buf_alloc)
+	if (!rx_buf_size || vvs->buf_used + len > rx_buf_size)
 		return false;
 
 	vvs->rx_bytes += len;
@@ -472,7 +492,7 @@ void virtio_transport_inc_tx_pkt(struct virtio_vsock_sock *vvs, struct sk_buff *
 	spin_lock_bh(&vvs->rx_lock);
 	vvs->last_fwd_cnt = vvs->fwd_cnt;
 	hdr->fwd_cnt = cpu_to_le32(vvs->fwd_cnt);
-	hdr->buf_alloc = cpu_to_le32(vvs->buf_alloc);
+	hdr->buf_alloc = cpu_to_le32(virtio_transport_rx_buf_size(vvs));
 	spin_unlock_bh(&vvs->rx_lock);
 }
 EXPORT_SYMBOL_GPL(virtio_transport_inc_tx_pkt);
@@ -594,6 +614,7 @@ virtio_transport_stream_do_dequeue(struct vsock_sock *vsk,
 	bool low_rx_bytes;
 	int err = -EFAULT;
 	size_t total = 0;
+	u32 rx_buf_size;
 	u32 free_space;
 
 	spin_lock_bh(&vvs->rx_lock);
@@ -639,7 +660,9 @@ virtio_transport_stream_do_dequeue(struct vsock_sock *vsk,
 	}
 
 	fwd_cnt_delta = vvs->fwd_cnt - vvs->last_fwd_cnt;
-	free_space = vvs->buf_alloc - fwd_cnt_delta;
+	rx_buf_size = virtio_transport_rx_buf_size(vvs);
+	free_space = rx_buf_size > fwd_cnt_delta ?
+		     rx_buf_size - fwd_cnt_delta : 0;
 	low_rx_bytes = (vvs->rx_bytes <
 			sock_rcvlowat(sk_vsock(vsk), 0, INT_MAX));
 
-- 
2.54.0

