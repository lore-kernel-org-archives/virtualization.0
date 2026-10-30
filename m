Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=165.173.182.15
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793342834;
	b=VeAQeTJMiqIu8gKa5BdPK4D2N6lLGnTp3kuX1V/BX+laKvWoCv0FtzqCUxV2qbFvMdeh
	 rsMg7UBweW7uYITcHIIrTta00K03oCQN4lBiEPgT/lg+3NBIHCal8rauzqQFmkJiANgBe
	 xd3kOd12G16COjpRhIqqoxcn4/vB6TZwEe+OAh+j3XrgXmM0nHc5Tb6X7KN8nh+HBrzog
	 8UXV34B4RTeYrNY/PTFWDHotuoZ5nqsXQFhBc3EaTGB+Sv0c9Q0yktmzeqBn5VG9FCeii
	 MapEoDSiQEXR4cxgJki1v3yEzqh4xihpb+9l2ck36uGfTJ6Ne4AMDu5rQF/WT3I5ksg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793342834;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=04SE4LEeyp7+SQ8UHHRqJwESRfgg8wqCBHrHnp67pSU=;
	b=Lzy/nOt/IZd0Kf1apMi0N60QEY9ZA85T4aCkGFOK7uH22yngWcW8L760XZ0VzJa6FYkY
	 UlBmrXnlGscQXQFewL+RlcbAGMRorKswWtAPEGZ4miI3MR63GABiY+8pvUIjvrV64iYy0
	 lf6XSLhiZgBoWuEye3hDL+qtfxhaRVU2EJuF7AQGndeYfSwe/qk3j0WcU1ZmSW6/ooah8
	 9340nyR+7DlS1MSulxJql79i8WIY8pRNeknJl1V5a+KN1iCb5Tr0+EUdbK7GLsccNLfSw
	 eAcBpPKMIvx0sH53a6Pfeh3gj7fdWEDWpMMN2Utz0EnWLDy/C5MkHwAh/U4+wYs0WeA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=ikuyo.dev;
	spf=pass smtp.mailfrom=ikuyo.dev;
	dkim=pass header.d=ikuyo.dev header.i=@ikuyo.dev header.a=rsa-sha256 header.s=s1 header.b=Jxf5OliT;
	arc=pass header.oldest-pass=0 smtp.remote-ip=165.173.182.15
Received: from sender5-op-o15.zoho.com (sender5-op-o15.zoho.com [165.173.182.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98C1F606A327
	for <virtualization@lists.linux.dev>; Fri, 30 Oct 2026 06:47:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 98C1F606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ikuyo.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ikuyo.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=ikuyo.dev header.i=@ikuyo.dev header.a=rsa-sha256 header.s=s1 header.b=Jxf5OliT
ARC-Seal: i=1; a=rsa-sha256; t=1793342812; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=djOO5H+jxQZT3M4jF8ZijcRcTHEkkqb5jSiUQ9stqobac4SyZzKveKs57K+tAF8rFHRtJe5LhLZyTNa235QlHafbYsRZYMRygNWeYZ63oQH0P/6ZI+tNv+AolnUjR6ab7VNzx/ORvmq55vVM54r44uVvPjFdRetlS7gGoB1/1uw=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1793342812; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=04SE4LEeyp7+SQ8UHHRqJwESRfgg8wqCBHrHnp67pSU=; 
	b=mAqUiwe+0ZCbM9qr2hX8Hbert9DpcP/aEdkY/CRfePd7/o9BRWN/FJRplBqa3Kf6qVUm46IMLnjXa6MgiBsAPLAKV1Z+/EtwWdqU3j5qHsXaujPfVSXNq5M26hAfoDPUyr7AlVbOKXY0zAQBT5oBfo1pQvNlz1aaFW4V7V99N5k=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=ikuyo.dev;
	spf=pass  smtp.mailfrom=eritque-arcus@ikuyo.dev;
	dmarc=pass header.from=<eritque-arcus@ikuyo.dev>
DKIM-Signature: a=rsa-sha256; b=Jxf5OliTPHq400Fx+ySTW2xnPq4GT9I/6jm1O8uRCv9ET1rZsQdNKr8HbhqKxix8xxrbEy9GqIGz3iCFeZuir+HUuLoUqsdsMoNMm2njrBVa4+f8pXzEJ0Bt1vI1du1VcWv6rr2l/S83YOeX+FKrySo9MAwaWM8P8QGV5ah2zfZZZWafAYwrhla5LVpjDa41b9KcwG46Z4hfwRMH1naHQUwR3bP037AggUA/nhzJAYTpqUqLISpy4zqLmStT4+fRiKK+ZjNCnv/aPWLQ4IB/kkHpQEdeQFsHnKZ8HqsOXAGt1E86KcEqS9YOn4C9SUuM8XOsLSw8M5P4RQ9GJQ58JQ==; c=relaxed/relaxed; s=s1; d=ikuyo.dev; v=1; bh=04SE4LEeyp7+SQ8UHHRqJwESRfgg8wqCBHrHnp67pSU=; h=Content-Description:Content-ID:Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:List-Subscribe:List-Post:List-Owner:List-Id:List-Archive:List-Help:List-Unsubscribe:MIME-Version:Message-ID:Resent-Sender:Resent-Cc:Resent-Date:Resent-To:Reply-To:Resent-Message-ID:Resent-From:Sender:Subject:To:Date:From:Message-Id:Reply-To:Subject:To:Cc;
Received: by smtp.zohomail.com with SMTPS id 1793342810725207.69729346785073;
	Thu, 29 Oct 2026 23:46:50 -0700 (PDT)
From: Yiran Qiu <eritque-arcus@ikuyo.dev>
To: Stefano Garzarella <sgarzare@redhat.com>
Cc: Stefan Hajnoczi <stefanha@redhat.com>,
	Bobby Eshleman <bobbyeshleman@meta.com>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowangio@gmail.com>,
	=?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	kvm@vger.kernel.org,
	virtualization@lists.linux.dev,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Yiran Qiu <eritque-arcus@ikuyo.dev>
Subject: [PATCH RFC net v2 1/3] vsock/virtio: refuse connect() from a CID the transport does not own
Date: Fri, 30 Oct 2026 02:44:16 -0400
Message-ID: <20261030064418.133349-2-eritque-arcus@ikuyo.dev>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261030064418.133349-1-eritque-arcus@ikuyo.dev>
References: <20261030064418.133349-1-eritque-arcus@ikuyo.dev>
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Since commit c0cfa2d8a788 ("vsock: add multi-transports support"),
bind() accepts any local CID, but connect() picks the transport from the
remote CID only.  The virtio transports send from the transport's CID,
so a socket bound to another local CID sends as if it were bound to
the same port on the transport's CID, and its connect() never
completes.

Over vsock_loopback, one process can use this against another that is
bound to (VMADDR_CID_LOCAL, P):
 1. it binds to (guest CID, P) and connects to a local listener; the
    request arrives from (VMADDR_CID_LOCAL, P) and leaves behind a
    child socket for that address, which stays until the listener
    accepts and closes it;
 2. the other process's connect() to the same listener matches that
    child and fails with ECONNRESET.

Refuse such a connect() with EADDRNOTAVAIL, as bind() does for a CID
that is not local.  And whenever the virtio connect() fails, set the
socket to TCP_CLOSE, as vmci_transport_connect() does, instead of
leaving it in TCP_SYN_SENT.

Found by an LLM-driven code audit.  I reproduced it on unmodified
kernels with the two processes running as different users, without
error injection, and tested the fix with the reproducer and vsock_test
in guests and on a host.  Drafted with Claude.

Fixes: c0cfa2d8a788 ("vsock: add multi-transports support")
Signed-off-by: Yiran Qiu <eritque-arcus@ikuyo.dev>
---
 net/vmw_vsock/virtio_transport_common.c | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/net/vmw_vsock/virtio_transport_common.c b/net/vmw_vsock/virtio_transport_common.c
index 1e762a480df4..8f524d073ae1 100644
--- a/net/vmw_vsock/virtio_transport_common.c
+++ b/net/vmw_vsock/virtio_transport_common.c
@@ -1219,8 +1219,20 @@ int virtio_transport_connect(struct vsock_sock *vsk)
 		.vsk = vsk,
 		.net = sock_net(sk_vsock(vsk)),
 	};
+	u32 local_cid;
+	int ret;
 
-	return virtio_transport_send_pkt_info(vsk, &info);
+	local_cid = vsk->transport->get_local_cid();
+	if (local_cid != VMADDR_CID_ANY &&
+	    vsk->local_addr.svm_cid != VMADDR_CID_ANY &&
+	    vsk->local_addr.svm_cid != local_cid)
+		ret = -EADDRNOTAVAIL;
+	else
+		ret = virtio_transport_send_pkt_info(vsk, &info);
+
+	if (ret < 0)
+		sk_vsock(vsk)->sk_state = TCP_CLOSE;
+	return ret;
 }
 EXPORT_SYMBOL_GPL(virtio_transport_connect);
 
-- 
2.56.0

