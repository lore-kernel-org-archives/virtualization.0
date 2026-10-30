Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=165.173.182.12
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793342862;
	b=KfaYMyOEKJMTXY4lsKJsDPR7zljERZkHNd+w439GnRVfkRi9aJeSJZVo51o0/e0D2Shu
	 cr+fXVXqcfCBy5uhqJMv0TLmgXmoSyuI2wOgiXGQEiKINqOGS92I0y29LZRlKSSwlnUOO
	 ee+yVSKdx1LpmzvTRc4P/HWsNYwsSshaT3LEOe1eflIUqw2NtF27JZekmut1wwwD8EAsN
	 1QuMQ07imWCTez4fnfB+oZZHgiibrPJo+iIziP5lta5s1fvFtk4fmTPa1nnDZTqldSyZs
	 gjci6BZgJsyn5wJyKGW9Q0NW2UZASD+drcwEue6w0ikrpx2HQVRjm8hhWYIg9iGgCKQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793342862;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=jSNCuWQInnB4aTqSt/QqhCYYoxsHtezivvgpUv5+8rE=;
	b=0IqUpg83dPqy+6dZlCLDAU9UdBh+h4gbMiyMX3WCSbAQG5AOUbYmqp0u8y2M4YXtQXJU
	 gfyHqFDLi/x/1CrE4YQKjBHuNaMXuEO8/H93xsEg1xOMQeLcLl9G44XGVBuWwyWpgNkAJ
	 ItOJZ2mOx2H6Dpzp328w7sEiEgIk9K24MP7DUZF1K8S8ZKXn3BRMgE09zq1POzItV0C3c
	 FKSjgef/DK4RwozMCAInZPoZMS7VogpXXyymYKI9/sLnwrjaaHLIUvaMB447iF/vCsRCh
	 /Wb0oogf7syF9tHz3AVABR1Rx26l3XG6rIuOzuJa1ZfWdG1LZY4D6wC3MY3qY7V0qrw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=ikuyo.dev;
	spf=pass smtp.mailfrom=ikuyo.dev;
	dkim=pass header.d=ikuyo.dev header.i=@ikuyo.dev header.a=rsa-sha256 header.s=s1 header.b=E98jXeGq;
	arc=pass header.oldest-pass=0 smtp.remote-ip=165.173.182.12
Received: from sender5-op-o12.zoho.com (sender5-op-o12.zoho.com [165.173.182.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A04F606A333
	for <virtualization@lists.linux.dev>; Fri, 30 Oct 2026 06:47:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8A04F606A333
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ikuyo.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ikuyo.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=ikuyo.dev header.i=@ikuyo.dev header.a=rsa-sha256 header.s=s1 header.b=E98jXeGq
ARC-Seal: i=1; a=rsa-sha256; t=1793342818; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=NykSCv8xszM0rcbcli9swwgB4qcQp3pl9NVtUMCmn4YJuao73EDqT1tuyAHJUaWmd1iIwkz6oQ7cG4Dr3GCR0zvjPrF5LK2yk7qDJvPUUchz/dVVw31SZX0TiAPifiF7YKCMBj0JDgbeIasaQP7tmWncRuEq2+1iMNRkO273iuE=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1793342818; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=jSNCuWQInnB4aTqSt/QqhCYYoxsHtezivvgpUv5+8rE=; 
	b=htGtByCqWghsZgFpqJtFIyD8+emCzrrrMwh4/7ebgmmZ6xOvUVzL8P4C16/ONo+qgpdsPccM2+N1yMOTTVItk+TDdKLwmG+Ayj5NOPGnHbqIr5+3vCrYDZmFsXWQRiox73H9JOGf55n+fpae1IK7GFj0+i76YikY8B0nagPN9kU=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=ikuyo.dev;
	spf=pass  smtp.mailfrom=eritque-arcus@ikuyo.dev;
	dmarc=pass header.from=<eritque-arcus@ikuyo.dev>
DKIM-Signature: a=rsa-sha256; b=E98jXeGqGHPI5K8Sl59gZfybQYCl/S1MKzCrFkvCfHr/Jf00U9pa4WxXBYzH9eCL7cZPXhqqOQMhJwKlxii8SWjqPGgYwjzCLm/EELRofIcH1tVC04HQp7sB2dl1Q1xb+wQf5Iyop3XFAnTIvfIB8BniposL4FZg/5Bnn8lQOjayJesHkkgnuK83DLDYwo5fEIKXBi0dRj7QIHZzRzwt/EFD+J+wPzZpYKT1UG3L98Y3y4UPcmftdBVKHOvgOUnb52qAGHcFMHQcstH50bjF2oAPquzorLweOIyx+MMd8htaVDh6mrxo5rqTNBvEWuaTtsDPIYHtCgOG5DCcUO29nw==; c=relaxed/relaxed; s=s1; d=ikuyo.dev; v=1; bh=jSNCuWQInnB4aTqSt/QqhCYYoxsHtezivvgpUv5+8rE=; h=Content-Description:Content-ID:Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:List-Subscribe:List-Post:List-Owner:List-Id:List-Archive:List-Help:List-Unsubscribe:MIME-Version:Message-ID:Resent-Sender:Resent-Cc:Resent-Date:Resent-To:Reply-To:Resent-Message-ID:Resent-From:Sender:Subject:To:Date:From:Message-Id:Reply-To:Subject:To:Cc;
Received: by smtp.zohomail.com with SMTPS id 1793342815719234.33637440490043;
	Thu, 29 Oct 2026 23:46:55 -0700 (PDT)
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
	Yiran Qiu <eritque-arcus@ikuyo.dev>,
	Sashiko <sashiko-bot@kernel.org>
Subject: [PATCH RFC net v2 3/3] vsock/virtio: only update a socket's local CID to the transport's CID
Date: Fri, 30 Oct 2026 02:44:18 -0400
Message-ID: <20261030064418.133349-4-eritque-arcus@ikuyo.dev>
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

virtio_transport_recv_pkt() copies a packet's destination CID into the
local address of the socket it reaches, so that sockets follow a guest
CID change after a transport reset.  But the bound-socket lookup also
delivers packets addressed to VMADDR_CID_ANY, and vsock_loopback can
carry them: a connect() to VMADDR_CID_ANY goes over loopback when the
guest->host transport has no CID (no virtio-vsock device, or hv_sock).
The socket bound to that port then ends up with VMADDR_CID_ANY as its
local CID: a listener on (VMADDR_CID_LOCAL, P) turns into a wildcard
listener, and a socket whose connect() was refused for its CID would
pass the check in virtio_transport_connect() on the next try.

Only take the destination CID if it differs from the socket's current
one, is not VMADDR_CID_ANY, and is the transport's own CID.  The
VMADDR_CID_ANY test is still needed: get_local_cid() itself returns
VMADDR_CID_ANY while the virtio-vsock device is removed or frozen.

In a guest without a virtio-vsock device, after a loopback connect() to
(VMADDR_CID_ANY, P), getsockname() on a listener bound to
(VMADDR_CID_LOCAL, P) returns VMADDR_CID_ANY on unmodified kernels and
VMADDR_CID_LOCAL with this patch; vsock_test passes.  Drafted with
Claude.

Fixes: 408624af4c89 ("vsock: use local transport when it is loaded")
Reported-by: Sashiko <sashiko-bot@kernel.org>
Closes: https://lore.kernel.org/all/sashiko-outbox-188830@kernel.org/
Signed-off-by: Yiran Qiu <eritque-arcus@ikuyo.dev>
---
Since 36c5b48b91ac ("vsock: fix bind() behaviour taking care of CID")
the CID update no longer helps listeners, and connected sockets are
reset on a transport reset, so the update could be dropped instead;
would you prefer that?  Refusing connect() to VMADDR_CID_ANY in
vsock_use_local_transport() would also work, but would stop guests
without a guest->host CID from reaching local listeners.

 net/vmw_vsock/virtio_transport_common.c |  5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/net/vmw_vsock/virtio_transport_common.c b/net/vmw_vsock/virtio_transport_common.c
index 4d0511629044..b276009efab9 100644
--- a/net/vmw_vsock/virtio_transport_common.c
+++ b/net/vmw_vsock/virtio_transport_common.c
@@ -1861,7 +1861,10 @@ void virtio_transport_recv_pkt(struct virtio_transport *t,
 	space_available = virtio_transport_space_update(sk, skb);
 
 	/* Update CID in case it has changed after a transport reset event */
-	if (vsk->local_addr.svm_cid != VMADDR_CID_ANY)
+	if (vsk->local_addr.svm_cid != VMADDR_CID_ANY &&
+	    vsk->local_addr.svm_cid != dst.svm_cid &&
+	    dst.svm_cid != VMADDR_CID_ANY &&
+	    dst.svm_cid == t->transport.get_local_cid())
 		vsk->local_addr.svm_cid = dst.svm_cid;
 
 	if (space_available)
-- 
2.56.0

