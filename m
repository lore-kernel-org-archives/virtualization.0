Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 256B23A35DB
	for <virtualization@lists.linux.dev>; Fri, 16 Jan 2026 20:15:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768594529; cv=none; b=F2fC5wfBv2Pyk+48JoB7EOj5RqKc2WwgF+XaWuJRd47jHLdBzdF4SRez0XmpwTMajx8h9QdEy097V3itIRsli/C0YsAu3Q9/4NiOsokh/C+ThbdrFNbzPfw+6B0a/1sXf+3LVkAIYpH69xqMbtLO/uaXiSCivPjYtPLJ5Ff7Px0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768594529; c=relaxed/simple;
	bh=A/Z6X724OpOjH0JR1tZITqCXaxlg20lb95ngLUoUj2w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:content-type; b=e6woNjrccnPyfxkMdmFhqFEFi6wJ7D8gnTyPa+6YANmZ4vWk+aqoGxK530z3zCgfu/Z0OhGcFo0KHpyrmuEiBsPW3wR73S0hJWvjpKz7zBgMfHtzrPJvOsbFBbrK5cE6N5hhjyPmLqEmTgOeUqvnRlduLDrvn1ccpyVU7qhN49g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ZWYJ4Z5g; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZWYJ4Z5g"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1768594527;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ArUbsQ+kNBjAUv+ApSXUG5Hd0kEcrS3qPgkd0OoiEwI=;
	b=ZWYJ4Z5ghFJA1eR0IVQZKKii8hfXPUZbhE9rTix5fEjIKERQnqyb6D4DDWskCQYq5M5jmz
	ImqlUzAuhlNrecUe+RRcuGxw18fSWaG6KUR1kPCx+vXhxrFzo9fSJj15GbOiGFeH7oyYyl
	FXxu0X3uucBHvZnVnXrAepOWrr/uphE=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-355-b42a54nzO0i7awHTrUadvQ-1; Fri, 16 Jan 2026 15:15:26 -0500
X-MC-Unique: b42a54nzO0i7awHTrUadvQ-1
X-Mimecast-MFC-AGG-ID: b42a54nzO0i7awHTrUadvQ_1768594525
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-47ed980309aso17488255e9.0
        for <virtualization@lists.linux.dev>; Fri, 16 Jan 2026 12:15:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768594525; x=1769199325;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ArUbsQ+kNBjAUv+ApSXUG5Hd0kEcrS3qPgkd0OoiEwI=;
        b=AqcxO5KrzKNAE1BPcPmjTonLCGQZ5buCLnra6VhqLVlaqOt/0I50Hj7g84kv2t5R5D
         WfjW9w8bQsb1DVD2fbXV0J7PzdPOIHWeLWc+pyj/XOXbs7E+jnseS5/PISGUUOQEUMov
         yh0IHzipYVS7YAxF5VWgL9hlyJCdKkPnWatBOCD8+XooZ96rhsU1fTr/uTV0d6a4E7Lg
         yeaI8nHLQsrzX39VZt1DWusq62sVNci/w+BcoYk5DbJ9oZ4lNnMRwSmJyUhIYBAD5Y8J
         ps2lC1MqImFy+Tst4fyMFKPOMq7H01/ntvCst6HBYe0cXx1VPWCNKAMu1baDRLKdzQu+
         tbwA==
X-Gm-Message-State: AOJu0YxWWiWCVPnDRMycuuG3oLU3RzwhTEicZjCpw6mRvbAVG+tqClLy
	e4YtsAs2c0Iw8yrE2cKSC6g+wfHmozFZ7iLy2iNFRHKA9hI3JjF37QU4kYXfbS6kFCwtj4f+LgC
	tAj+FrpgylrvOEqMA8jZYQrJplt8SjW+x5liQX0TyJLasQ7yvg9kRNkbmHZkKDlUOAIMV
X-Gm-Gg: AY/fxX7TGN3TeBdb8VDGL/tNva6+djwPYm2QWTV+9atND/LIgqUW7XqrntJsjHEzQqh
	hgM4cP79H2mcwT+4avfq+OzroSGY3OS7yFoQB+OwM4e+PQWwmiXzAvS27ujlyJa1HgUKozAiZc0
	BU6iEjY/65dmVYwyoQXGmBylL3iBZ+dRWLahRANY69aClgdhR9VHRdh5erIQEpE9E0ft5rCk6Oy
	pStv/z/pvyNZfF2GSoPHALtD5YNfxpATjjvfIBgMtnlvllMeYN5dDD/C2pY0rLa8J2gslMQzhd7
	RBmS823CpLHX2tQMpem98FcvldNP6YKDF1Y8JSbvyFa7M7jT7ZIujVBP9mavw2RsmdBhB+jefV5
	Vvj8VR8nIr+Yz89GVEz+jMbhS5H1VYz2qXUWyT7/W4ReFq2OID0ASVRg64feL
X-Received: by 2002:a05:600c:1f86:b0:477:a289:d854 with SMTP id 5b1f17b1804b1-4801e53ca36mr57538705e9.5.1768594524930;
        Fri, 16 Jan 2026 12:15:24 -0800 (PST)
X-Received: by 2002:a05:600c:1f86:b0:477:a289:d854 with SMTP id 5b1f17b1804b1-4801e53ca36mr57538465e9.5.1768594524424;
        Fri, 16 Jan 2026 12:15:24 -0800 (PST)
Received: from stex1.redhat.com (host-82-53-134-58.retail.telecomitalia.it. [82.53.134.58])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4801e879537sm57802005e9.5.2026.01.16.12.15.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Jan 2026 12:15:23 -0800 (PST)
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
Subject: [PATCH RESEND net v5 1/4] vsock/virtio: fix potential underflow in virtio_transport_get_credit()
Date: Fri, 16 Jan 2026 21:15:14 +0100
Message-ID: <20260116201517.273302-2-sgarzare@redhat.com>
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
X-Mimecast-MFC-PROC-ID: fUN0oH9EU8pymlWwQ5ZQk0NG6jFBnIlHCsOh8jwcDns_1768594525
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

From: Melbin K Mathew <mlbnkm1@gmail.com>

The credit calculation in virtio_transport_get_credit() uses unsigned
arithmetic:

  ret = vvs->peer_buf_alloc - (vvs->tx_cnt - vvs->peer_fwd_cnt);

If the peer shrinks its advertised buffer (peer_buf_alloc) while bytes
are in flight, the subtraction can underflow and produce a large
positive value, potentially allowing more data to be queued than the
peer can handle.

Reuse virtio_transport_has_space() which already handles this case and
add a comment to make it clear why we are doing that.

Fixes: 06a8fc78367d ("VSOCK: Introduce virtio_vsock_common.ko")
Suggested-by: Stefano Garzarella <sgarzare@redhat.com>
Signed-off-by: Melbin K Mathew <mlbnkm1@gmail.com>
[Stefano: use virtio_transport_has_space() instead of duplicating the code]
[Stefano: tweak the commit message]
Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
---
 net/vmw_vsock/virtio_transport_common.c | 16 +++++++++-------
 1 file changed, 9 insertions(+), 7 deletions(-)

diff --git a/net/vmw_vsock/virtio_transport_common.c b/net/vmw_vsock/virtio_transport_common.c
index dcc8a1d5851e..2fe341be6ce2 100644
--- a/net/vmw_vsock/virtio_transport_common.c
+++ b/net/vmw_vsock/virtio_transport_common.c
@@ -28,6 +28,7 @@
 
 static void virtio_transport_cancel_close_work(struct vsock_sock *vsk,
 					       bool cancel_timeout);
+static s64 virtio_transport_has_space(struct virtio_vsock_sock *vvs);
 
 static const struct virtio_transport *
 virtio_transport_get_ops(struct vsock_sock *vsk)
@@ -499,9 +500,7 @@ u32 virtio_transport_get_credit(struct virtio_vsock_sock *vvs, u32 credit)
 		return 0;
 
 	spin_lock_bh(&vvs->tx_lock);
-	ret = vvs->peer_buf_alloc - (vvs->tx_cnt - vvs->peer_fwd_cnt);
-	if (ret > credit)
-		ret = credit;
+	ret = min_t(u32, credit, virtio_transport_has_space(vvs));
 	vvs->tx_cnt += ret;
 	vvs->bytes_unsent += ret;
 	spin_unlock_bh(&vvs->tx_lock);
@@ -877,11 +876,14 @@ u32 virtio_transport_seqpacket_has_data(struct vsock_sock *vsk)
 }
 EXPORT_SYMBOL_GPL(virtio_transport_seqpacket_has_data);
 
-static s64 virtio_transport_has_space(struct vsock_sock *vsk)
+static s64 virtio_transport_has_space(struct virtio_vsock_sock *vvs)
 {
-	struct virtio_vsock_sock *vvs = vsk->trans;
 	s64 bytes;
 
+	/* Use s64 arithmetic so if the peer shrinks peer_buf_alloc while
+	 * we have bytes in flight (tx_cnt - peer_fwd_cnt), the subtraction
+	 * does not underflow.
+	 */
 	bytes = (s64)vvs->peer_buf_alloc - (vvs->tx_cnt - vvs->peer_fwd_cnt);
 	if (bytes < 0)
 		bytes = 0;
@@ -895,7 +897,7 @@ s64 virtio_transport_stream_has_space(struct vsock_sock *vsk)
 	s64 bytes;
 
 	spin_lock_bh(&vvs->tx_lock);
-	bytes = virtio_transport_has_space(vsk);
+	bytes = virtio_transport_has_space(vvs);
 	spin_unlock_bh(&vvs->tx_lock);
 
 	return bytes;
@@ -1490,7 +1492,7 @@ static bool virtio_transport_space_update(struct sock *sk,
 	spin_lock_bh(&vvs->tx_lock);
 	vvs->peer_buf_alloc = le32_to_cpu(hdr->buf_alloc);
 	vvs->peer_fwd_cnt = le32_to_cpu(hdr->fwd_cnt);
-	space_available = virtio_transport_has_space(vsk);
+	space_available = virtio_transport_has_space(vvs);
 	spin_unlock_bh(&vvs->tx_lock);
 	return space_available;
 }
-- 
2.52.0

