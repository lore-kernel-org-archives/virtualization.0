Received: from mailtransmit05.runbox.com (mailtransmit05.runbox.com [185.226.149.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C6C338422E
	for <virtualization@lists.linux.dev>; Tue, 15 Sep 2026 13:15:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.226.149.38
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789478152; cv=none; b=u86az0ptViqOQeUyLVWAeaSi2Yjy8V4uETvjUWl68+VKAT8ubJb/6QClAjCc5vWeVwYec/hzDdX0EBVrsOu5IgK/F3D2JL1JSWxYZbiet/jkRcaE5S49g3qf5WLy6LU1k46iQEMFS3QOSHT9XrXMfYAH+a3xtPjQd6QP/Vygi/c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789478152; c=relaxed/simple;
	bh=OW/j0OV6/KFGgiFnuDflzDHt28f867c5Hch7mrGWrqo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=PAjUKaBPhJk1TV11apj40/nsOh05nRZcBbjo1pFNSJyQhtZfaazDTEq+0s9/gXhoIZvpWfBGjm08GgrYi9cQOww4+zqKo/dqrI2eaqGWGlDxIVS3k5fe5ODv1n0AEigraxv9dS2u5xAgRD31PUfOZJRYCf4sU6wBey3icqvg1+I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rbox.co; spf=pass smtp.mailfrom=rbox.co; dkim=pass (2048-bit key) header.d=rbox.co header.i=@rbox.co header.b=g9yMXBMG; arc=none smtp.client-ip=185.226.149.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rbox.co
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rbox.co
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rbox.co header.i=@rbox.co header.b="g9yMXBMG"
Received: from mailtransmit02.runbox ([10.9.9.162] helo=aibo.runbox.com)
	by mailtransmit05.runbox.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.93)
	(envelope-from <mhal@rbox.co>)
	id 1x6T0c-000wLH-M4; Tue, 15 Sep 2026 15:15:38 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=rbox.co;
	s=selector2; h=Cc:To:In-Reply-To:References:Message-Id:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:From;
	bh=J6FJXLnbQMTSTvXFFwXmON3Rzv+eNvV2Q3NtjngzJY4=; b=g9yMXBMG8bE9YUnCJlIfgZmdA1
	SD1b07fCA8JfcpmPFrbthPLdeUdvsCYYh7zFzT6w50UgM3jkAVXdUnc3mtXhvx343pV1oHXiHKzYN
	ejGv4vHQiEeU8Asv2GoXRCBuyPMB1AR/+euFdVo0iF9MaZMkRtXipv97iMVO9dbGpilTo3LLiGf2U
	T5NVsMai/GuKVhwPliOkOKIiU8vXEQUiE+p0c5KqiJKXYpUHwGTy4LRD6z/y5kKvSCLrc89B9OQYl
	2VYKrvu6AecSd2xQxSeQqSeu04OCR7PkIJ9ml90GwHdgSJqvCLJc6PDuIz4QvHa0g27f0TCV7RaR6
	yROKDoog==;
Received: from [10.9.9.72] (helo=submission01.runbox)
	by mailtransmit02.runbox with esmtp (Exim 4.86_2)
	(envelope-from <mhal@rbox.co>)
	id 1x6T0W-0003iI-B1; Tue, 15 Sep 2026 15:15:32 +0200
Received: by submission01.runbox with esmtpsa  [Authenticated ID (604044)]  (TLS1.2:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.95)
	id 1x6T0J-00EUxD-21;
	Tue, 15 Sep 2026 15:15:19 +0200
From: Michal Luczaj <mhal@rbox.co>
Date: Tue, 15 Sep 2026 15:15:13 +0200
Subject: [PATCH net v2 2/5] vsock/virtio: Streamline socket reset on
 transport/PM event
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260915-vsock-connect-reset-closing-v2-2-a1d9abb472f7@rbox.co>
References: <20260915-vsock-connect-reset-closing-v2-0-a1d9abb472f7@rbox.co>
In-Reply-To: <20260915-vsock-connect-reset-closing-v2-0-a1d9abb472f7@rbox.co>
To: Stefan Hajnoczi <stefanha@redhat.com>, 
 Stefano Garzarella <sgarzare@redhat.com>, 
 "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowangio@gmail.com>, 
 =?utf-8?q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
 "David S. Miller" <davem@davemloft.net>, 
 Xuan Zhuo <xuanzhuo@linux.alibaba.com>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>, Asias He <asias@redhat.com>
Cc: kvm@vger.kernel.org, virtualization@lists.linux.dev, 
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Michal Luczaj <mhal@rbox.co>
X-Mailer: b4 0.15.2

Follow vhost's vhost_vsock_reset_orphans() and VMCI's
vmci_transport_handle_detach(): set SHUTDOWN_MASK, which will come handy
later in the series.

Note that commit c38f57da428b ("vhost/vsock: fix reset orphans race with
close timeout") fixed a race between pending close timer, i.e.
virtio_transport_close_timeout(), and a transport/PM reset. But here we
never set SOCK_DONE, hence no race.

Fixes: 0ea9e1d3a9e3 ("VSOCK: Introduce virtio_transport.ko")
Signed-off-by: Michal Luczaj <mhal@rbox.co>
---
 net/vmw_vsock/virtio_transport.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/net/vmw_vsock/virtio_transport.c b/net/vmw_vsock/virtio_transport.c
index 4f9aa9c4c3aa..4d6991321699 100644
--- a/net/vmw_vsock/virtio_transport.c
+++ b/net/vmw_vsock/virtio_transport.c
@@ -413,11 +413,14 @@ static void virtio_vsock_event_fill(struct virtio_vsock *vsock)
 
 static void virtio_vsock_reset_sock(struct sock *sk)
 {
+	struct vsock_sock *vsk = vsock_sk(sk);
+
 	/* vmci_transport.c doesn't take sk_lock here either.  At least we're
 	 * under vsock_table_lock so the sock cannot disappear while we're
 	 * executing.
 	 */
 
+	vsk->peer_shutdown = SHUTDOWN_MASK;
 	sk->sk_state = TCP_CLOSE;
 	sk->sk_err = ECONNRESET;
 	sk_error_report(sk);

-- 
2.55.0

