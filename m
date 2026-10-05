Received: from mailtransmit05.runbox.com (mailtransmit05.runbox.com [185.226.149.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DB6E1F12FB;
	Mon,  5 Oct 2026 01:05:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.226.149.38
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791162361; cv=none; b=f6ALM2jnBzhGWCZ06yrKvxRDUs7AySXRu0+WXqNRJLHwm7aW5MZLJL/D/LNG8oIpT+fCie2NJtfVpfTQSNYJNHDaMhIcCCq6ai+ip3ycPi6U70syBovyy3swj4PJQSy4Lqn4XBpR/TJ9oSTjCWKRzHotgTTJlgHuL0prnmo4qgI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791162361; c=relaxed/simple;
	bh=6hKZyAxMsAcaXlL1jQNmLGPEHssZUOfzDofJ9l3AAYs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=f/EJxTspQegO1JDBpC0AWvMrP3lVUMxxlX0m8fZUcW4dk6SoR1Mq9HqSxUUzksbT31rBBMy6QDowZx4QTbRn2+ywSP3Yps2tLdVyjLLQ636vRzRhkA0rinXs0dkRDj7iyUdok4tsDnnnaWQBXL4Ktb6QxMlAnaxirVgxzquJxBc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rbox.co; spf=pass smtp.mailfrom=rbox.co; dkim=pass (2048-bit key) header.d=rbox.co header.i=@rbox.co header.b=f/7fNSml; arc=none smtp.client-ip=185.226.149.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rbox.co
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rbox.co
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rbox.co header.i=@rbox.co header.b="f/7fNSml"
Received: from mailtransmit02.runbox ([10.9.9.162] helo=aibo.runbox.com)
	by mailtransmit05.runbox.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.93)
	(envelope-from <mhal@rbox.co>)
	id 1xDWXr-00BeDO-IT; Mon, 05 Oct 2026 02:27:07 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=rbox.co;
	s=selector1; h=Cc:To:In-Reply-To:References:Message-Id:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:From;
	bh=jPeu6T7GcllC8FvZxJ+u0tfvoOw0GMjN0KPHe/0xo9A=; b=f/7fNSmlGhH7nEcWnhDBuZzxLi
	4lOsnQ4H4OON59k0kuS6tUydl1nKO9pMhnCZq2mSyvjuVxA41sssatUVGtQeqa1uneZpnnyT2s1ph
	Q3v7Yu5mYUJ6kg4VSpI7xc7+4KqTXXTo3Syd3Y06g4M9CSJyyuD5KRNG9Ou6p00+utr/tossk2yWP
	EDyO6l8Vi/QKn7QdSZTAK1AS2daYRIx/efcJgNYe+rN+zbMp4ELw7NsOOpjJaV8L2tEVdP7hM8CQ9
	HxsP/ZrD3julwogz4d86CacmCcpwSW5y0QRcBw+sWrNdt93RJF9ZjE+6R+0qb0c1+Gfll9rr/CeKR
	504ICkDw==;
Received: from [10.9.9.72] (helo=submission01.runbox)
	by mailtransmit02.runbox with esmtp (Exim 4.86_2)
	(envelope-from <mhal@rbox.co>)
	id 1xDWXd-0002qY-EG; Mon, 05 Oct 2026 02:26:55 +0200
Received: by submission01.runbox with esmtpsa  [Authenticated ID (604044)]  (TLS1.2:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.95)
	id 1xDWXL-00AQqX-TB;
	Mon, 05 Oct 2026 02:26:36 +0200
From: Michal Luczaj <mhal@rbox.co>
Date: Mon, 05 Oct 2026 02:26:22 +0200
Subject: [PATCH net v4] vsock: treat TCP_CLOSING as once-established
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261005-vsock-connect-reset-closing-v4-1-15d41cfda3ed@rbox.co>
References: <20261005-vsock-connect-reset-closing-v4-0-15d41cfda3ed@rbox.co>
In-Reply-To: <20261005-vsock-connect-reset-closing-v4-0-15d41cfda3ed@rbox.co>
To: Stefan Hajnoczi <stefanha@redhat.com>, 
 Stefano Garzarella <sgarzare@redhat.com>, 
 "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowangio@gmail.com>, 
 =?utf-8?q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
 "David S. Miller" <davem@davemloft.net>, 
 Xuan Zhuo <xuanzhuo@linux.alibaba.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
 Eric Dumazet <edumazet@kernel.org>
Cc: kvm@vger.kernel.org, virtualization@lists.linux.dev, 
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Hyunwoo Kim <imv4bel@gmail.com>, Michal Luczaj <mhal@rbox.co>
X-Mailer: b4 0.15.2

Handle the TCP_ESTABLISHED -> TCP_CLOSING transition on OP_RST, which can
race with the connect loop. Immediately break and return 0 on
ESTABLISHED/CLOSING. The return value of connect() should reflect what
happened up to the point the connection was established or failed. Events
that occur afterwards must not affect it. E.g. even if OP_RW has already
set sk_err, connect() should still return 0, not ENOBUFS because of it.
Adapt the inaccurate comment above signal_pending().

Resetting a socket that is still present in connected_table can lead to
memory corruption. The reporter noted lost transports for in-flight skbs,
and I have reproduced crashes caused by re-insertion into connected_table.

  list_add double add: new=, prev=, next=.
  kernel BUG at lib/list_debug.c:35!
  Oops: invalid opcode: 0000 [#1] SMP KASAN NOPTI
  Workqueue: vsock-loopback vsock_loopback_work
  RIP: 0010:__list_add_valid_or_report+0x11f/0x130
  Call Trace:
   vsock_insert_connected.cold+0xe/0x13
   virtio_transport_recv_pkt+0x10e9/0x1460
   vsock_loopback_work+0x305/0x480
   process_one_work+0xe4c/0x1560
   worker_thread+0x4f1/0xd60
   kthread+0x36e/0x470
   ret_from_fork+0x47b/0x6b0
   ret_from_fork_asm+0x1a/0x30

This fix is supplementary to commit 002541ef650b ("vsock: Ignore
signal/timeout on connect() if already established"). Details under Link.

Fixes: d021c344051a ("VSOCK: Introduce VM Sockets")
Reported-by: Hyunwoo Kim <imv4bel@gmail.com>
Link: https://lore.kernel.org/netdev/anzT1fREOSyHT99k@v4bel/
Signed-off-by: Michal Luczaj <mhal@rbox.co>
---
 net/vmw_vsock/af_vsock.c | 17 ++++++++---------
 1 file changed, 8 insertions(+), 9 deletions(-)

diff --git a/net/vmw_vsock/af_vsock.c b/net/vmw_vsock/af_vsock.c
index 9b71479a2b29..14fe24b05f9c 100644
--- a/net/vmw_vsock/af_vsock.c
+++ b/net/vmw_vsock/af_vsock.c
@@ -1834,23 +1834,22 @@ static int vsock_connect(struct socket *sock, struct sockaddr_unsized *addr,
 		timeout = schedule_timeout(timeout);
 		lock_sock(sk);
 
-		/* Connection established. Whatever happens to socket once we
-		 * release it, that's not connect()'s concern. No need to go
+		/* Connection was established. Whatever happens to socket once
+		 * we release it, that's not connect()'s concern. No need to go
 		 * into signal and timeout handling. Call it a day.
 		 *
 		 * Note that allowing to "reset" an already established socket
 		 * here is racy and insecure.
 		 */
-		if (sk->sk_state == TCP_ESTABLISHED)
-			break;
+		if (sk->sk_state == TCP_ESTABLISHED ||
+		    sk->sk_state == TCP_CLOSING) {
+			err = 0;
+			goto out_wait;
+		}
 
 		/* If connection was _not_ established and a signal/timeout came
 		 * to be, we want the socket's state reset. User space may want
-		 * to retry.
-		 *
-		 * sk_state != TCP_ESTABLISHED implies that socket is not on
-		 * vsock_connected_table. We keep the binding and the transport
-		 * assigned.
+		 * to retry, so we keep the binding and the transport assigned.
 		 */
 		if (signal_pending(current) || timeout == 0) {
 			err = timeout == 0 ? -ETIMEDOUT : sock_intr_errno(timeout);

-- 
2.56.0

