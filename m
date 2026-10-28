Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.129.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793203500;
	b=IhUE7cWp7/f97TawVXDGGj5PX0HwisnbbKQx/ItOKm7EV29lVsTFv5u61KvFqNPQag/b
	 Bq7n1mmrw6eyglUUNe7EbGCkY1TtpZEbfxQWLHqojiAZfBiyfPYTaUPseuCrx+Qcy3drt
	 lh+pIjRWm7GZksZGBggBU6WA6z2++ziTVDiNQGAYW+FlCTqDkIqEhu0wsSlfywHWrVHZ/
	 hvPVHa5Si+cpRoNSOUbNkkBBPaFb0vobdQ69b5oHIqUQOKoe496fnRkVpqewauieI27F9
	 7B4bxkggv7Ixqb7lzH/Qu5BNR/0H4CDZzFise2rRgy+Q5Uc4CldC/pfk1m3AgFLhS6g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793203500;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:Date:
	 Subject:MIME-Version:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Mimecast-Spam-Score:
	 X-Mimecast-MFC-PROC-ID:X-Mimecast-Originator:Content-Type:
	 Content-Transfer-Encoding;
	bh=SSkPhi8dGQVlMB+aYtf/PbRbQYkLH9iaxEtJasH6Snw=;
	b=g6rGD+oCTUM4vr/alm9H0pYyJPR+7IbQ9m3lK8Q7f1D+1ymWzHJHWwxYCGlJiv4Yo2d3
	 qXn/vZVapAnWQfcJHgjti9j/frgJbPiyMd7rZQdSUll+mczBGwLi4AeAdND2rL9sgVCh+
	 wqTDk3SZ2CMekA4rfRaRvlBNJYbb8QXxPs/dZoMH0hmb3ruVVyFcPKHj95qrKzwEbO1t2
	 3dU07c9gh49HzpYWfx/b5pCH9qDiItKW3F2eyLYw81voHv5EtOLoW7BUEpD+/qDd2m7OA
	 aS0o/Y+MJsgY0Cx8D6WDQGSx5RyZMSlbkLhpsAkSCVHbiAGMxIUbpBJuv+Z3vMKXGHQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=Zb8L6sNC;
	arc=none smtp.remote-ip=170.10.129.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC9B5606A336
	for <virtualization@lists.linux.dev>; Wed, 28 Oct 2026 16:04:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AC9B5606A336
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=Zb8L6sNC
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1793203498;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SSkPhi8dGQVlMB+aYtf/PbRbQYkLH9iaxEtJasH6Snw=;
	b=Zb8L6sNCGZ8l3RnNYaGNV6Uyjrq7wLfFdlBr1esAzSJhK6K+KPZnvfBG6aqBF/oIT3sqRI
	vbmoy7TvIlsOo2hyW7QxhcbjMOyfZevOyV+RfaOQgxM6GvWSAEt/I+o9P5HHpDOMjlUnP1
	Z8YptAo8FyT+d+ECNWf+ME+OSMBqRig=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-145-StC_BiKXOyeAzlRIIAfhLA-1; Wed, 28 Oct 2026 12:04:57 -0400
X-MC-Unique: StC_BiKXOyeAzlRIIAfhLA-1
X-Mimecast-MFC-AGG-ID: StC_BiKXOyeAzlRIIAfhLA_1793203496
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-48e20ed362aso52709f8f.2
        for <virtualization@lists.linux.dev>; Wed, 28 Oct 2026 09:04:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793203496; x=1793808296;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=SSkPhi8dGQVlMB+aYtf/PbRbQYkLH9iaxEtJasH6Snw=;
        b=u8JoTQMhk7VhET+hGM9Nb7i6sH2BNZNTQFV/j4sYuiTqjCBBYzG6l7XY1kN9H2xSoI
         TuyKHL50sUxJHLJj/9SRNT/dq2L0hZnvM6tIPnarfO3v/kctz8PfSChU+iD6E3i5j+01
         JzLYazsBHYKC+zsJxxMsr5q/SSYoQMfYU2x9rbHUmFcDPk4x30hebEysPhN/l9RUAw9/
         wSJWdF1yyHab2aPjTi36Uhn7mSBAZELzgao4uF/17KjsbmM3MHZcRf3goM9eKXfycwwK
         oZJmomRRf3HrNtE3r1EFYvyb27Gsct6CCzIcgKpcQ+qfSrHBQFZNLoDmuQCKGx+T2nMK
         TiHA==
X-Gm-Message-State: AFq9FYLad1sc7UXdyIoIQ3MczsYDSwftUIlqt+sh4lAg7GaTeCH7BpgY
	WyKlVO/UNNI73Fj5++fjY2RmxWItIcCFn09CX1H0EFDh+fYVBii5iMIi5Y/JX6i5e2lzwXhJ83k
	+uv04N3Kq6pI4F5HsvSUZ0ZwSaghlANM8IU1fkpJ3NxpEx9VcOdg9Gqq/0oGGOffWGh+w
X-Gm-Gg: AYBFou0oWnyeVtCZvZ/yB5pWqSWDii7INXnIoowmA7+Fg9ISrDBSK0DD5EBUlwwnNnc
	cTkJQwBWLBkxL5tm8A9RmVcQbX9YI1s8rmAkhA6OXcy8sWS1Gm7XASWFfpBKJuXdnq/0hQfEjV4
	tUHqt107tGU5vpt8/aX/zoZhzRBtgsdA/WTdP/Do6Jr/BHEk2Wto3HnZsOAzfu1KLnj8DEGdkmi
	Oxka7QAFgqdedp6ypEVDGybFlNYbmAz8wJwGDiedalz2+rAFOVdfA4jdm5EpS2CJgOoNMGi4DLe
	92y0KEG0jIQ7SdOyoyrKyuEFfDs2reXnRpXRs2FdH0LyYoF63MZhqI4WymslYXu4XUEIlaHkq59
	l+qDky4qjA2pUsHNRtMVj7ZAtTNtR5wzePunbZNhfeERnjUlNhoVozh8uiKI9SfXRZJNZxEmRvd
	iM58ZE9TrQQOs=
X-Received: by 2002:a05:6000:716:b0:48b:a21:87f7 with SMTP id ffacd0b85a97d-48e5d5c9c95mr6585809f8f.44.1793203496223;
        Wed, 28 Oct 2026 09:04:56 -0700 (PDT)
X-Received: by 2002:a05:6000:716:b0:48b:a21:87f7 with SMTP id ffacd0b85a97d-48e5d5c9c95mr6585714f8f.44.1793203495734;
        Wed, 28 Oct 2026 09:04:55 -0700 (PDT)
Received: from [192.168.0.19] (217.red-88-4-146.dynamicip.rima-tde.net. [88.4.146.217])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e3ebd47basm31898410f8f.32.2026.10.28.09.04.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Oct 2026 09:04:53 -0700 (PDT)
From: Sergio Lopez <slp@redhat.com>
Date: Wed, 28 Oct 2026 17:04:30 +0100
Subject: [PATCH RFC 1/8] vsock: expose the core port allocator to
 transports
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Message-Id: <20261028-vsock-dgram-support-v1-1-e457cf7cee78@sinrega.org>
References: <20261028-vsock-dgram-support-v1-0-e457cf7cee78@sinrega.org>
In-Reply-To: <20261028-vsock-dgram-support-v1-0-e457cf7cee78@sinrega.org>
To: Stefano Garzarella <sgarzare@redhat.com>, 
 Bobby Eshleman <bobbyeshleman@meta.com>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>, Bryan Tan <bryan-bt.tan@broadcom.com>, 
 Vishnu Dasa <vishnu.dasa@broadcom.com>, 
 Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, 
 Stefan Hajnoczi <stefanha@redhat.com>, 
 "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowangio@gmail.com>, 
 =?utf-8?q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
 Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
 Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>, 
 Dexuan Cui <decui@microsoft.com>
Cc: virtualization@lists.linux.dev, netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, kvm@vger.kernel.org, bpf@vger.kernel.org, 
 linux-hyperv@vger.kernel.org, Sergio Lopez <slp@redhat.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=3348; i=slp@sinrega.org;
 h=from:subject:message-id; bh=ZVfitmWvovEVraPH2yKqVmQ45Xs6izvUaaK6WM4R6S4=;
 b=owEBbQKS/ZANAwAKAfRpJ40vDAI1AcsmYgBq4h0bLdtFFdUt+9phG13qqSnimHyJCpaDLG0Z5
 DiYDKILoSGJAjMEAAEKAB0WIQS+1fz3US2GgJFC6KL0aSeNLwwCNQUCauIdGwAKCRD0aSeNLwwC
 NTUUD/99aty+2+zABLMczLqyMyImvg9HHzvlVIclUDMBbDktLeL2OztcC/MZksZsXkAUEdFBdWK
 0BtutrnOl4mzj1rWPhwYG/pp41y+h5TmCbAfxbjRR8bXOWxBQU0wVrc2quDODDzfHZDHyAXR7wo
 3LZp7Ay9NvGAntY+DzJHDPdxeP+1+E7iqHQfDreVxQ0hyIKjec54U2qQENi0azxnYEwFw+uKT0d
 jjEcHq/8a1TKE/SejNJym7lat/wuTdr8V2Mwq7Z7LRvmLEKcQyUQv30oqZhX2KEqMQ873sSlW+g
 RXXpvHL9YwnTslLEaIEs436kjS7UOp2CQTYhP+GF6uoXGSk/cnjMmganPiFHLq0fZc5ofSXVrkh
 zTliYit2e2PxL3pylrdaGx2W57aMdQyGp2hgue/bzqD85ThvXa9D2LrH+fRuyQ5PjAFHapqRM2R
 TzevKHS7x98iO81NnlokdPUspNroi1b1AA2+t8IehSSVQmylHeKHx6LWyRt9NzeFHEF24kn1LMq
 NMeH1GtWIHj/hdoL46Sbu2xRLhhmVq9HIis3035qr6iV1I5G6PXYrDmsaUzvPQvA2aWn+FqICqX
 D5RR9CLCgbWQ8Yng0ceht3SCEu9YwI7kqptm8uKFZsXke0qLkASugHYjkMc7UbQZUGx96jTXpSf
 jhAW+SoluQExiRg==
X-Developer-Key: i=slp@sinrega.org; a=openpgp;
 fpr=BED5FCF7512D86809142E8A2F469278D2F0C0235
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: lxrfCRUAvDoVMEDzKJgZ-szfojKnxEuZRli9sxEq3B8_1793203496
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The core port allocator is currently private to connection-oriented
sockets. Virtio datagrams need the same bound-socket lookup tables and
port allocation, while VMCI datagrams must keep their own endpoint
creation and port namespace.

Export vsock_bind_common() with the bound-table locking inside the
helper, and use it for stream and SEQPACKET binds. Keep datagram binds
delegated to the transport so a transport can opt into the core
allocator without changing other transports' binding behavior.

Signed-off-by: Sergio Lopez <slp@redhat.com>
---
 include/net/af_vsock.h   |  1 +
 net/vmw_vsock/af_vsock.c | 31 ++++++++++++++++++++++---------
 2 files changed, 23 insertions(+), 9 deletions(-)

diff --git a/include/net/af_vsock.h b/include/net/af_vsock.h
index e8481f12312e..19bd9c1c3e5b 100644
--- a/include/net/af_vsock.h
+++ b/include/net/af_vsock.h
@@ -220,6 +220,7 @@ void vsock_remove_pending(struct sock *listener, struct sock *pending);
 void vsock_enqueue_accept(struct sock *listener, struct sock *connected);
 void vsock_pending_to_accept(struct sock *listener, struct sock *pending);
 void vsock_insert_connected(struct vsock_sock *vsk);
+int vsock_bind_common(struct vsock_sock *vsk, struct sockaddr_vm *addr);
 void vsock_remove_bound(struct vsock_sock *vsk);
 void vsock_remove_connected(struct vsock_sock *vsk);
 struct sock *vsock_find_bound_socket(struct sockaddr_vm *addr);
diff --git a/net/vmw_vsock/af_vsock.c b/net/vmw_vsock/af_vsock.c
index d0508887a2fb..5d1d85e5f519 100644
--- a/net/vmw_vsock/af_vsock.c
+++ b/net/vmw_vsock/af_vsock.c
@@ -832,8 +832,8 @@ static void vsock_pending_work(struct work_struct *work)
 
 /**** SOCKET OPERATIONS ****/
 
-static int __vsock_bind_connectible(struct vsock_sock *vsk,
-				    struct sockaddr_vm *addr)
+static int __vsock_bind_common(struct vsock_sock *vsk,
+			       struct sockaddr_vm *addr)
 {
 	struct net *net = sock_net(sk_vsock(vsk));
 	struct sockaddr_vm new_addr;
@@ -888,11 +888,26 @@ static int __vsock_bind_connectible(struct vsock_sock *vsk,
 	return 0;
 }
 
-static int __vsock_bind_dgram(struct vsock_sock *vsk,
-			      struct sockaddr_vm *addr)
+/**
+ * vsock_bind_common - bind a socket using the core port allocator
+ * @vsk: socket to bind
+ * @addr: local address to bind to
+ *
+ * The caller must hold the socket lock.
+ *
+ * Return: 0 on success or a negative error code on failure.
+ */
+int vsock_bind_common(struct vsock_sock *vsk, struct sockaddr_vm *addr)
 {
-	return vsk->transport->dgram_bind(vsk, addr);
+	int ret;
+
+	spin_lock_bh(&vsock_table_lock);
+	ret = __vsock_bind_common(vsk, addr);
+	spin_unlock_bh(&vsock_table_lock);
+
+	return ret;
 }
+EXPORT_SYMBOL_GPL(vsock_bind_common);
 
 static int __vsock_bind(struct sock *sk, struct sockaddr_vm *addr)
 {
@@ -914,13 +929,11 @@ static int __vsock_bind(struct sock *sk, struct sockaddr_vm *addr)
 	switch (sk->sk_socket->type) {
 	case SOCK_STREAM:
 	case SOCK_SEQPACKET:
-		spin_lock_bh(&vsock_table_lock);
-		retval = __vsock_bind_connectible(vsk, addr);
-		spin_unlock_bh(&vsock_table_lock);
+		retval = vsock_bind_common(vsk, addr);
 		break;
 
 	case SOCK_DGRAM:
-		retval = __vsock_bind_dgram(vsk, addr);
+		retval = vsk->transport->dgram_bind(vsk, addr);
 		break;
 
 	default:

-- 
2.56.0

