Received: from mailtransmit05.runbox.com (mailtransmit05.runbox.com [185.226.149.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DFE43B42F3;
	Tue, 15 Sep 2026 13:15:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.226.149.38
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789478159; cv=none; b=rn0N1KJbLwoGXivsfwGdS9NOjjmMZO+iaoHr5AKZC9ulKeUBVwLGa5PKcvUM4ARvr9SUOn1Pn8TPZI9YfgvfHp3NNXUBpKAzwE3FkZpKIrlc3FgGWVwtD6rXiGS2igF4M+FnRNIKJzZ4wb6qKtx9MutEg9oOdQ/o5cfmDQYsoX0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789478159; c=relaxed/simple;
	bh=830GKS+GZtQTrD/nVgYFtmMVvy37u5IuYvM2ZtboDHs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=cd5R/VShCBqXq2S0q8cYwNB4jRDGNLbD77xQx+KoKcQ8lB8aYoCDRyzNfW8E76T6it+cR/RKSPZ3Hhgrysnf2LxMbYT70e2JxtN4mpS9U+u+DWxgMFsnlYt49Mxk2KG97d5bYhiEEnY8/StYSdC/eF0QZzfRpZokJEXKfFDehNc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rbox.co; spf=pass smtp.mailfrom=rbox.co; dkim=pass (2048-bit key) header.d=rbox.co header.i=@rbox.co header.b=AO5TaTGi; arc=none smtp.client-ip=185.226.149.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rbox.co
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rbox.co
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rbox.co header.i=@rbox.co header.b="AO5TaTGi"
Received: from mailtransmit03.runbox ([10.9.9.163] helo=aibo.runbox.com)
	by mailtransmit05.runbox.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.93)
	(envelope-from <mhal@rbox.co>)
	id 1x6T0c-000wLI-N5; Tue, 15 Sep 2026 15:15:38 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=rbox.co;
	s=selector2; h=Cc:To:In-Reply-To:References:Message-Id:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:From;
	bh=b3mQkrs76zO1JPC/v9TSuze2uQXUW1ZUbIhJvl/5BfQ=; b=AO5TaTGidN0NdVy5auvyz5Cq7u
	kBWUMLOtvHB46UBw9CVhmeRvCyWijmK2sLNRmMFUfqi45R+C+1fMlUXYQT2va8nD0PSTnv6U51+Y+
	/q2BcS7iUuUScWgGv/MUtsFuEUvXCz+xi6JNVrt3oDdZ3hF+eztrkNeI1VhaLb1p3xbMR1MyBfKbq
	STilCmF2ZZikq0wSzIlYPRJAIkcX0vKEh0b30gMLPfqFXNm8VeTKUtrm/U+E0aVvwCAxBcm2rlqSK
	MKVJ5qwky4BrDXnkYSCw59TJ78Na4sSIOW9FcVt+WSWGXt1PuiqdMTND9WAljRjCjvEErWj5bx7KP
	dqz3lazg==;
Received: from [10.9.9.72] (helo=submission01.runbox)
	by mailtransmit03.runbox with esmtp (Exim 4.86_2)
	(envelope-from <mhal@rbox.co>)
	id 1x6T0W-0002ty-OE; Tue, 15 Sep 2026 15:15:32 +0200
Received: by submission01.runbox with esmtpsa  [Authenticated ID (604044)]  (TLS1.2:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.95)
	id 1x6T0K-00EUxD-QM;
	Tue, 15 Sep 2026 15:15:20 +0200
From: Michal Luczaj <mhal@rbox.co>
Date: Tue, 15 Sep 2026 15:15:15 +0200
Subject: [PATCH net v2 4/5] vsock: Do not reset a TCP_CLOSING socket
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260915-vsock-connect-reset-closing-v2-4-a1d9abb472f7@rbox.co>
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
 Hyunwoo Kim <imv4bel@gmail.com>, Michal Luczaj <mhal@rbox.co>
X-Mailer: b4 0.15.2

Handle the previously overlooked TCP_ESTABLISHED -> TCP_CLOSING
transition (on VIRTIO_VSOCK_OP_RST), which could race with the connect
loop.

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

Drop the redundant err=0 and the inaccurate comment above signal_pending().
This fix is supplementary to commit 002541ef650b ("vsock: Ignore
signal/timeout on connect() if already established"). Details under Link.

Fixes: d021c344051a ("VSOCK: Introduce VM Sockets")
Reported-by: Hyunwoo Kim <imv4bel@gmail.com>
Link: https://lore.kernel.org/netdev/anzT1fREOSyHT99k@v4bel/
Signed-off-by: Michal Luczaj <mhal@rbox.co>
---
 net/vmw_vsock/af_vsock.c | 20 +++++++++-----------
 1 file changed, 9 insertions(+), 11 deletions(-)

diff --git a/net/vmw_vsock/af_vsock.c b/net/vmw_vsock/af_vsock.c
index 499e902becfa..adf3f018347e 100644
--- a/net/vmw_vsock/af_vsock.c
+++ b/net/vmw_vsock/af_vsock.c
@@ -1712,7 +1712,6 @@ static int vsock_connect(struct socket *sock, struct sockaddr_unsized *addr,
 	long timeout;
 	DEFINE_WAIT(wait);
 
-	err = 0;
 	sk = sock->sk;
 	vsk = vsock_sk(sk);
 
@@ -1834,23 +1833,22 @@ static int vsock_connect(struct socket *sock, struct sockaddr_unsized *addr,
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
 		 * to retry.
-		 *
-		 * sk_state != TCP_ESTABLISHED implies that socket is not on
-		 * vsock_connected_table. We keep the binding and the transport
-		 * assigned.
 		 */
 		if (signal_pending(current) || timeout == 0) {
 			err = timeout == 0 ? -ETIMEDOUT : sock_intr_errno(timeout);
@@ -1874,8 +1872,8 @@ static int vsock_connect(struct socket *sock, struct sockaddr_unsized *addr,
 		prepare_to_wait(sk_sleep(sk), &wait, TASK_INTERRUPTIBLE);
 	}
 
-	err = sock_error(sk);
-	if (err) {
+	if (sk->sk_state != TCP_ESTABLISHED && sk->sk_state != TCP_CLOSING) {
+		err = sock_error(sk);
 		sk->sk_state = TCP_CLOSE;
 		sock->state = SS_UNCONNECTED;
 	}

-- 
2.55.0

