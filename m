Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B4BD3806A7
	for <virtualization@lists.linux.dev>; Wed, 13 May 2026 10:54:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778669676; cv=none; b=KBmuL/nO4oq4z3XO5QQ+1UMWdezrr7mot7Fo57WchIkZyMPbnUsX7hxunZvEbISXCWoFM12ZiYuoCu+EnQpQIavXKEam9uOXXkcHkxql5Fy7gNUbIYGqCuDjHD23JSbVSNf2R0HuQP6884QXsCXNfnU+xtRoPSYW6/3igClW3a8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778669676; c=relaxed/simple;
	bh=ttq2nGPLIE/1il8H5a57hLhcGZjBjCwtRxosBU4xsEM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:content-type; b=cKwei7FE7SpktdVsOaqdgjzOieyEW0TWHPy1TuuXNnuTAKHiLECjiiwDNkOBvi7jE4IKXNWafFVFD+Mn2OBJAQ379tqjB/MecAobipyui3cJA8W1cFo5uS7nLjiWaeyzhBfJaYbP6Cdh1TH92KDVfJzaTJ6u91n1mqdEPNcmKMg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Beja0nS8; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Beja0nS8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1778669671;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PAFSeIkpvfQYT7wQ2CerCQBM43nlr6dVNS3iNHBRyXI=;
	b=Beja0nS8adiWT0QQXdCduJqnPwt9V3ihgpG5reMWhahw3R/+aCID+OFm/FjVJFM6Ojht3W
	ok8BXQE81GPdOp8dwudNUS/cmpTdxreyK/aeZxJuI+UmF2WVs97aKZwlQ9O4DieEJURSYH
	RvHyOvHNHo2TJSSzjkG1ZI/Zi/+pA6Q=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-444-XXbsC-tXM0WvJLlbT6KwJA-1; Wed, 13 May 2026 06:54:27 -0400
X-MC-Unique: XXbsC-tXM0WvJLlbT6KwJA-1
X-Mimecast-MFC-AGG-ID: XXbsC-tXM0WvJLlbT6KwJA_1778669667
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-48fb4ffebe7so5955465e9.0
        for <virtualization@lists.linux.dev>; Wed, 13 May 2026 03:54:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778669666; x=1779274466;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=PAFSeIkpvfQYT7wQ2CerCQBM43nlr6dVNS3iNHBRyXI=;
        b=J3a0c19W4nFiq6vq7RMeS43dnC1M8+3KcnxpQD90o3d37B9WyDTQ7smg79kqhopwjI
         lTwxwive9UY/zuDk0hJu8/N3GprIzJoYNEQf2HFKjCfMTnFFNg0sCyyXtWUfCeB2Y95z
         +TON8ophHxZzVwGdYXc467lPK/VIjEHALBPrhng8bfDzfPr7fDL2qQ28dDgv3h11KBEI
         cSfkWxmrO2iAmFcTg/cgQvS7CGftmqA+Apd3ChX4ubXNTirZuzWKuXylVV4O9RHvtLxV
         JhMFh2HJTBjiyRfNFCKEx+bRKhPtZ7rMyxfqIMiHHEOw/l5gD8vFfd/ZKyO8Q8e/mYuf
         VMPg==
X-Forwarded-Encrypted: i=1; AFNElJ/pl5nwXcw3Zlj8rNEVVgKySpsRrb/3f1qMFgRdKRrW7ME8720wMzHCj0zTITJCRGivRymhQ9QdSAxc+st3GQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YxLW5xT1BVkkVtUPgztjBJEmH77T4L9Q7pSDgS0dx7KHtMbq8tA
	Pbdz0HiIgCKVLMK/QHegXgcIbWnrhFzNT5kQ5scxt5xy9T9z/Yr+5YK0LCdy1od62jA4Ke2ECqb
	LYeYWzaiE6+NtpA9fPgjdOrGhd6+GAl2i1aejPshE2DcRg5ZluRGxl8bzu076AlkcOsw0
X-Gm-Gg: Acq92OH5HbTFWzgnptaMcS0yBTbWlo5TpE/y8wKO14OjOR4Vdc5C5vIiuENKQRs/O2O
	bIHA426FtyZWGv0HHvOZsICag8zcwdCO1sPUXclUYTKxuxHkorh8qMvLTk8/41GWwDnmANpGOau
	F8GX+J2Fjd2gHjUEs0E749FU38fcRESIUUIxBkrW+PLI88jphDsdTMDHmsQgTXhx6JQ01ApZYxc
	/yzVJ7J9WfCDkTt0Gnnls6lT7o0pBowFzYfWG+/GuVgNJnyXunIy34AYP4H8uJE0iCdDIKrAopE
	sI//BAIwBUoHWJVlmI8dAv/cdkN90OZh4pAK83BP7QThQqfxC9eOQ8sDR488iyNEzOupneknl6T
	xgpbfikJDMWOHj65rG1BfUjXo9yOPQ3Dh/tmqDd4BxxxFabAcajz/4ocNNWDC
X-Received: by 2002:a05:600c:4f54:b0:488:ab1d:dcc5 with SMTP id 5b1f17b1804b1-48fc9a4b276mr40460155e9.27.1778669666576;
        Wed, 13 May 2026 03:54:26 -0700 (PDT)
X-Received: by 2002:a05:600c:4f54:b0:488:ab1d:dcc5 with SMTP id 5b1f17b1804b1-48fc9a4b276mr40459645e9.27.1778669666028;
        Wed, 13 May 2026 03:54:26 -0700 (PDT)
Received: from stex1 (host-87-16-204-231.retail.telecomitalia.it. [87.16.204.231])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48fc8d27d31sm106419235e9.8.2026.05.13.03.54.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 May 2026 03:54:24 -0700 (PDT)
From: Stefano Garzarella <sgarzare@redhat.com>
To: netdev@vger.kernel.org
Cc: Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	=?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>,
	linux-kernel@vger.kernel.org,
	Simon Horman <horms@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Stefano Garzarella <sgarzare@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	kvm@vger.kernel.org,
	Stefan Hajnoczi <stefanha@redhat.com>,
	virtualization@lists.linux.dev,
	Eric Dumazet <edumazet@google.com>,
	"David S. Miller" <davem@davemloft.net>
Subject: [PATCH net v3 1/2] vsock/virtio: reset connection on receiving queue overflow
Date: Wed, 13 May 2026 12:54:16 +0200
Message-ID: <20260513105417.56761-2-sgarzare@redhat.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260513105417.56761-1-sgarzare@redhat.com>
References: <20260513105417.56761-1-sgarzare@redhat.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: wMZmWspJRqzi7qHjMpv3DgSmzEP8fN5pNm6fdVBRWa8_1778669667
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

From: Stefano Garzarella <sgarzare@redhat.com>

When there is no more space to queue an incoming packet, the packet is
silently dropped. This causes data loss without any notification to
either peer, since there is no retransmission.

Under normal circumstances, this should never happen. However, it could
happen if the other peer doesn't respect the credit, or if the skb
overhead, which we recently began to take into account with commit
059b7dbd20a6 ("vsock/virtio: fix potential unbounded skb queue"),
is too high.

Fix this by resetting the connection and setting the local socket error
to ENOBUFS when virtio_transport_recv_enqueue() can no longer queue a
packet, so both peers are explicitly notified of the failure rather than
silently losing data.

Fixes: ae6fcfbf5f03 ("vsock/virtio: discard packets if credit is not respected")
Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
---
 net/vmw_vsock/virtio_transport_common.c | 19 ++++++++++++++-----
 1 file changed, 14 insertions(+), 5 deletions(-)

diff --git a/net/vmw_vsock/virtio_transport_common.c b/net/vmw_vsock/virtio_transport_common.c
index 989cc252d3d3..4a4ac69d1ad1 100644
--- a/net/vmw_vsock/virtio_transport_common.c
+++ b/net/vmw_vsock/virtio_transport_common.c
@@ -1350,7 +1350,7 @@ virtio_transport_recv_connecting(struct sock *sk,
 	return err;
 }
 
-static void
+static bool
 virtio_transport_recv_enqueue(struct vsock_sock *vsk,
 			      struct sk_buff *skb)
 {
@@ -1365,10 +1365,8 @@ virtio_transport_recv_enqueue(struct vsock_sock *vsk,
 	spin_lock_bh(&vvs->rx_lock);
 
 	can_enqueue = virtio_transport_inc_rx_pkt(vvs, len);
-	if (!can_enqueue) {
-		free_pkt = true;
+	if (!can_enqueue)
 		goto out;
-	}
 
 	if (le32_to_cpu(hdr->flags) & VIRTIO_VSOCK_SEQ_EOM)
 		vvs->msg_count++;
@@ -1408,6 +1406,8 @@ virtio_transport_recv_enqueue(struct vsock_sock *vsk,
 	spin_unlock_bh(&vvs->rx_lock);
 	if (free_pkt)
 		kfree_skb(skb);
+
+	return can_enqueue;
 }
 
 static int
@@ -1420,7 +1420,16 @@ virtio_transport_recv_connected(struct sock *sk,
 
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

