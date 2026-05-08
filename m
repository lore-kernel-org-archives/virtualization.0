Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE7EA40F8D9
	for <virtualization@lists.linux.dev>; Fri,  8 May 2026 16:44:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778258672; cv=none; b=b1z+9Y9wmG36ejlP/QRTM4gyST4JaiaVXpSF+5DsVbp8f0/cpWy46/8Fbx9iu7HxZk2DTWgyPVT6+EtV2arzxKhj5StfnpAWxVvxLUlUpG5hzxDi9KfPSF7EOL/VGwA6xrJEmyElrM94YFdMma2Fc8Ul+qwOpzdU6ekvZ46vqws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778258672; c=relaxed/simple;
	bh=nI6jWfcws3jDGKtVHmRZ+UhUUSG86pLokLto4S1xK2Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:content-type; b=AOLkzZkjOjpjWA9WajGC3/BRFYEQI+IOqHqPNHMwTuTClspLUf8A7auXFiMQcCMBUvitBOOXxSP/5DLT30xqOo7LFFqrv0t8HRxbyZF3WtvJ2XxeSFKFhWGu/Nbr99qfE2gI7z0gkj4yp72erIxhFX5dptUctPmWX2S2KnNsF1g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ALXpApLn; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ALXpApLn"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1778258670;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1SGD4ybYlVxcQvNSSgCT46FZDKdy4y6czHmnn+pucYo=;
	b=ALXpApLnR6vEF/pnH/bMKXKwVNfeSZYLyFRFIwzuP8KNHP4GRkFjtvYszyKgDUrk3sS4mt
	iAnBpYl9jdGfWOhl5TCtRMV4T4qsF2O08ZvkfvhpV7QXTf+YlI8s4/ousldHpZpxKUcQyz
	g84A70Md9L1eVGHduWNLwKwRSRgR0lM=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-316-dQyxZDuKP8Cix4mc1N_ZtQ-1; Fri, 08 May 2026 12:44:28 -0400
X-MC-Unique: dQyxZDuKP8Cix4mc1N_ZtQ-1
X-Mimecast-MFC-AGG-ID: dQyxZDuKP8Cix4mc1N_ZtQ_1778258667
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-44cc3c9b2feso1905546f8f.1
        for <virtualization@lists.linux.dev>; Fri, 08 May 2026 09:44:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778258667; x=1778863467;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=1SGD4ybYlVxcQvNSSgCT46FZDKdy4y6czHmnn+pucYo=;
        b=XUipAg4HhGZZ3qaZOQ0JCzJpbNnqbawxQnIY5O1WEkEXeYhnI/a86UEAIU1OHh+OC7
         aIBYxaoSXrjXDhR4YgtjABnJjKZLZB9sPOYmVZ2LxIWoW4hZ3HgMsFPPifloJrmJ1SDp
         Ej1JOY1odsk5JM13dAo8oprtetVGCXCBMa2TViMzkMox88gX2YrIg3RhyPPgPxkZ68Oz
         sG0NdWyc04q9s3gBzGrDL9oTyk0UjRc5FTSEsio4EN7h3NM8y2KXq5sZtImOLJ/+Uz7q
         5aU1BbOgPiKA14JfNf4rQudJVk2rbImEIx1cKDC3l8+LiSMSQNADVC49CqOEoZgqjTaW
         JQBw==
X-Forwarded-Encrypted: i=1; AFNElJ9qfV3eRfHmp5KTq8AsPxZIWm/gCoLaH0KxGRDPA89s/0sywas1xgFVqD0eShB6U9hl0J8Y7iujyyFNoS8T1w==@lists.linux.dev
X-Gm-Message-State: AOJu0Yyhj8p++T0jxVBRdVVfri99zEv35IkPR9dH7P4UP2SKG9ybh8r1
	fFqQL52sGAhpwacPz57BUpyaA9cyduVvFIlemtcrpsaXWSY0atRYV/shEIGAlEYXtZfLtiXpsKz
	kNG2f6OMTLdsR4UKggG0vopZbRYpZLFH52cf/E6b4s+SwTGj78rgsC+Yv8oSFMefp4rfI
X-Gm-Gg: Acq92OFH49omTSt0RPU/ID32Nt9uzp/pLz/BFBtpnDkdoVVjsWYi3BF3TW1SJDKUc+a
	MVHc6RjOadYQOiOL680FS902M74NjrpuxGCz2oTpeemVX4bVvjSy9/C6S0wddNBEh7VfFwY3ZMG
	IFR9B/71/7v/WyY45gwZ4/p/WSJpZ4eQRd6hNqr9K9Z9UQKqWZoalR3ajs3Sds2bs2BjjTBcwEr
	/K5NDo5RyhIHdAUXWwEH7TMKJmW4Z7O2dDkMiQoQPgGroLTvBWbX3j0m8t2HaWxPN5OBql1AUIe
	etv8G4tOnWmddZKdkFvJuAZramq2FUXO88C1phBy7wVjSLOcwnpWXeaCzMbtSzjTXDF7MC/DvnN
	ZyIyPVIcnoAaK3BZvIVHGE4J+uJlv5zdX6m58Rgk9NOemxyk1TyuQqaGQTDnZoZ0Yjg==
X-Received: by 2002:a5d:5d08:0:b0:44e:1984:5f3e with SMTP id ffacd0b85a97d-4515d3dc343mr20223722f8f.31.1778258665064;
        Fri, 08 May 2026 09:44:25 -0700 (PDT)
X-Received: by 2002:a5d:5d08:0:b0:44e:1984:5f3e with SMTP id ffacd0b85a97d-4515d3dc343mr20223444f8f.31.1778258662937;
        Fri, 08 May 2026 09:44:22 -0700 (PDT)
Received: from stex1.redhat.corp (host-87-11-6-2.retail.telecomitalia.it. [87.11.6.2])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4548e6a5b65sm5572801f8f.8.2026.05.08.09.44.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 May 2026 09:44:22 -0700 (PDT)
From: Stefano Garzarella <sgarzare@redhat.com>
To: netdev@vger.kernel.org
Cc: Yiqi Sun <sunyiqixm@gmail.com>,
	Stefano Garzarella <sgarzare@redhat.com>,
	linux-kernel@vger.kernel.org,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Stefan Hajnoczi <stefanha@redhat.com>,
	kvm@vger.kernel.org,
	Simon Horman <horms@kernel.org>,
	Bobby Eshleman <bobbyeshleman@meta.com>,
	Jason Wang <jasowang@redhat.com>,
	Jakub Kicinski <kuba@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	virtualization@lists.linux.dev,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Arseniy Krasnov <avkrasnov@salutedevices.com>,
	=?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>,
	Bobby Eshleman <bobby.eshleman@bytedance.com>
Subject: [PATCH net 2/2] vsock/virtio: fix empty payload in tap skb for non-linear buffers
Date: Fri,  8 May 2026 18:44:11 +0200
Message-ID: <20260508164411.261440-3-sgarzare@redhat.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260508164411.261440-1-sgarzare@redhat.com>
References: <20260508164411.261440-1-sgarzare@redhat.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: YeP5VreXDk12ANt10WbqR_KSpNucJCvwB1tJRwobprk_1778258667
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

From: Stefano Garzarella <sgarzare@redhat.com>

For non-linear skbs, virtio_transport_build_skb() goes through
virtio_transport_copy_nonlinear_skb() to copy the original payload
in the new skb to be delivered to the vsockmon tap device.
This manually initializes an iov_iter but does not set iov_iter.count.
Since the iov_iter is zero-initialized, the copy length is zero and no
payload is actually copied to the monitor interface, leaving data
un-initialized.

Fix this by removing the linear vs non-linear split and using
skb_copy_datagram_iter() with iov_iter_kvec() for all cases, as
vhost-vsock already does. This handles both linear and non-linear skbs,
properly initializes the iov_iter, and removes the now unused
virtio_transport_copy_nonlinear_skb().

While touching this code, let's also check the return value of
skb_copy_datagram_iter(), even though it's unlikely to fail.

Fixes: 4b0bf10eb077 ("vsock/virtio: non-linear skb handling for tap")
Reported-by: Yiqi Sun <sunyiqixm@gmail.com>
Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
---
 net/vmw_vsock/virtio_transport_common.c | 40 ++++++++-----------------
 1 file changed, 12 insertions(+), 28 deletions(-)

diff --git a/net/vmw_vsock/virtio_transport_common.c b/net/vmw_vsock/virtio_transport_common.c
index a678d5d75704..989cc252d3d3 100644
--- a/net/vmw_vsock/virtio_transport_common.c
+++ b/net/vmw_vsock/virtio_transport_common.c
@@ -136,27 +136,6 @@ static void virtio_transport_init_hdr(struct sk_buff *skb,
 	hdr->fwd_cnt	= cpu_to_le32(0);
 }
 
-static void virtio_transport_copy_nonlinear_skb(const struct sk_buff *skb,
-						void *dst,
-						size_t len)
-{
-	struct iov_iter iov_iter = { 0 };
-	struct kvec kvec;
-	size_t to_copy;
-
-	kvec.iov_base = dst;
-	kvec.iov_len = len;
-
-	iov_iter.iter_type = ITER_KVEC;
-	iov_iter.kvec = &kvec;
-	iov_iter.nr_segs = 1;
-
-	to_copy = min_t(size_t, len, skb->len);
-
-	skb_copy_datagram_iter(skb, VIRTIO_VSOCK_SKB_CB(skb)->offset,
-			       &iov_iter, to_copy);
-}
-
 /* Packet capture */
 static struct sk_buff *virtio_transport_build_skb(void *opaque)
 {
@@ -214,13 +193,18 @@ static struct sk_buff *virtio_transport_build_skb(void *opaque)
 	skb_put_data(skb, pkt_hdr, sizeof(*pkt_hdr));
 
 	if (payload_len) {
-		if (skb_is_nonlinear(pkt)) {
-			void *data = skb_put(skb, payload_len);
-
-			virtio_transport_copy_nonlinear_skb(pkt, data, payload_len);
-		} else {
-			skb_put_data(skb, pkt->data + VIRTIO_VSOCK_SKB_CB(pkt)->offset,
-				     payload_len);
+		struct iov_iter iov_iter;
+		struct kvec kvec;
+		void *data = skb_put(skb, payload_len);
+
+		kvec.iov_base = data;
+		kvec.iov_len = payload_len;
+		iov_iter_kvec(&iov_iter, ITER_DEST, &kvec, 1, payload_len);
+
+		if (skb_copy_datagram_iter(pkt, VIRTIO_VSOCK_SKB_CB(pkt)->offset,
+					   &iov_iter, payload_len)) {
+			kfree_skb(skb);
+			return NULL;
 		}
 	}
 
-- 
2.54.0

