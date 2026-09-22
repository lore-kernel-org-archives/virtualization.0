Received: from mailtransmit05.runbox.com (mailtransmit05.runbox.com [185.226.149.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19CB354A7E9;
	Tue, 22 Sep 2026 13:15:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.226.149.38
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790082942; cv=none; b=X2a3K7Dhm/IpUazHuYXgzUkARKtDKIBiUZP4TUR4/xg80IEvhFyiHjBR3QkAsqUp7in4OU+aKVU6bgrxAu9V4VEvS7D+zgq3l2h3XhxqFLek3tLf0g7tMq4WYImx4RJkYsGFnyLyaXeOS5GmmQl4WAQcHCuvUXUqPYRjpfwxZe0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790082942; c=relaxed/simple;
	bh=3e88C8MD0MTi4zk76RfIGYwE4rL5JwPj8Xe4qyLb/vs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=QEnRbJOmfow98skNyS9ajOVSCKtfNi6b+6jrj8wxpVZmFgZaOs2KhGVKQ/JqXEYjQTEOOKgnMqTwQibW7TtfdhG9UwPnwC15sQP8d0tq02d0Ix97XshGqpKySJSL9/4Mlak/1KfTcF0b8xD6T1WEv55x8ajFMW6dqrTilFyvqMA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rbox.co; spf=pass smtp.mailfrom=rbox.co; dkim=pass (2048-bit key) header.d=rbox.co header.i=@rbox.co header.b=vaZh1CK3; arc=none smtp.client-ip=185.226.149.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rbox.co
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rbox.co
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rbox.co header.i=@rbox.co header.b="vaZh1CK3"
Received: from mailtransmit03.runbox ([10.9.9.163] helo=aibo.runbox.com)
	by mailtransmit05.runbox.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.93)
	(envelope-from <mhal@rbox.co>)
	id 1x90LI-005SDL-2I; Tue, 22 Sep 2026 15:15:28 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=rbox.co;
	s=selector1; h=Cc:To:In-Reply-To:References:Message-Id:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:From;
	bh=KqEsGGQym9dCf7XblsGQZB4/Hmko4QBycE9bOomA3ng=; b=vaZh1CK3mSr6k3khPux/ezZb4p
	EhCcJx5zS0hPoO12vLl/irCRT/2cThrAteJF9SmsOqU6GTvlXOcYxpvkY452mXOwR3a42buGtvm81
	mL67kou6DWJzCD+QZ9qfpU+x4tK1lXNojXpP+znrHRljISW3M3tkFAaei6To3jIetNUTHfyslvjXF
	wpQBXzWIjkrS50FXslzGoBDDyGT/Ygev/Zxm7CzTGPaUTFXUSKOecJS0OaHkPbI5diOJllcwDT8tf
	ZDgkpGq5mY1AFs4tzHNdIreHY1VtmNol4o923PF/+L3mWG2AjJ0/pRZel7HdP3t/brAgv4mU8Z3aW
	JUYf/69Q==;
Received: from [10.9.9.72] (helo=submission01.runbox)
	by mailtransmit03.runbox with esmtp (Exim 4.86_2)
	(envelope-from <mhal@rbox.co>)
	id 1x90LC-0006Mx-0W; Tue, 22 Sep 2026 15:15:22 +0200
Received: by submission01.runbox with esmtpsa  [Authenticated ID (604044)]  (TLS1.2:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.95)
	id 1x90L5-00FyKH-OI;
	Tue, 22 Sep 2026 15:15:15 +0200
From: Michal Luczaj <mhal@rbox.co>
Date: Tue, 22 Sep 2026 15:15:02 +0200
Subject: [PATCH net v3 8/8] vsock: enforce no-transport invariant for
 TCP_LISTEN sockets
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260922-vsock-connect-reset-closing-v3-8-78907b8200d4@rbox.co>
References: <20260922-vsock-connect-reset-closing-v3-0-78907b8200d4@rbox.co>
In-Reply-To: <20260922-vsock-connect-reset-closing-v3-0-78907b8200d4@rbox.co>
To: Stefan Hajnoczi <stefanha@redhat.com>, 
 Stefano Garzarella <sgarzare@redhat.com>, 
 "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowangio@gmail.com>, 
 =?utf-8?q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
 "David S. Miller" <davem@davemloft.net>, 
 Xuan Zhuo <xuanzhuo@linux.alibaba.com>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>
Cc: kvm@vger.kernel.org, virtualization@lists.linux.dev, 
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Michal Luczaj <mhal@rbox.co>
X-Mailer: b4 0.15.2

In the past, listener socket could carry an assigned transport (uselessly,
but harmlessly, except for unnecessarily hogging the kernel module refcnt).
That's not the case anymore. Express/enforce the invariant.

Signed-off-by: Michal Luczaj <mhal@rbox.co>
---
 net/vmw_vsock/af_vsock.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/net/vmw_vsock/af_vsock.c b/net/vmw_vsock/af_vsock.c
index 56c595942456..9ba21a448cfa 100644
--- a/net/vmw_vsock/af_vsock.c
+++ b/net/vmw_vsock/af_vsock.c
@@ -1993,13 +1993,13 @@ static int vsock_listen(struct socket *sock, int backlog)
 		goto out;
 	}
 
-	if (sock->state != SS_UNCONNECTED) {
+	vsk = vsock_sk(sk);
+
+	if (sock->state != SS_UNCONNECTED || WARN_ON_ONCE(vsk->transport)) {
 		err = -EINVAL;
 		goto out;
 	}
 
-	vsk = vsock_sk(sk);
-
 	if (!vsock_addr_bound(&vsk->local_addr)) {
 		err = -EINVAL;
 		goto out;

-- 
2.55.0

