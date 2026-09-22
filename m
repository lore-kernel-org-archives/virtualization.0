Received: from mailtransmit04.runbox.com (mailtransmit04.runbox.com [185.226.149.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8676560AA5;
	Tue, 22 Sep 2026 13:16:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.226.149.37
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790082977; cv=none; b=UxkZIXRWKZtCRm8US3YvjilxE4IYWaTIUhYsRRN7rP6nByvNP1LctiWi1UZXr6Sor2nOf635qUomHxZfcmtLjp03kx5NDM6LHveOVq2LA7smezQUeaKK6aZJKHHnGkbN/59PbavYWvfQoOXytA2+zZQ+ATCzRejdrkzkI3lTEuY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790082977; c=relaxed/simple;
	bh=r8NN3NsziCexxlU2xLKrqIKiEyrwoVWHBd7Ms4fyzWM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=FIRXDtT1vtjwyc/tWrMPsT8u+tVGdtTeyVzaP+ZcT9pRVaVfUDlT79DSv/lkSVCXii5Jsm4FC39sQayhtuJHee6c5W9wJ2mEsbc7QjFDQBLF+qR0aHOhf3f+yib2qN+g1cBuLLH8VfdkJ8DSOJFZBkzcElQmmV7gmYVhT/SDawg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rbox.co; spf=pass smtp.mailfrom=rbox.co; dkim=pass (2048-bit key) header.d=rbox.co header.i=@rbox.co header.b=bRntzqzK; arc=none smtp.client-ip=185.226.149.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rbox.co
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rbox.co
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rbox.co header.i=@rbox.co header.b="bRntzqzK"
Received: from mailtransmit03.runbox ([10.9.9.163] helo=aibo.runbox.com)
	by mailtransmit04.runbox.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.93)
	(envelope-from <mhal@rbox.co>)
	id 1x90LN-0038Q8-9i; Tue, 22 Sep 2026 15:15:33 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=rbox.co;
	s=selector1; h=Cc:To:In-Reply-To:References:Message-Id:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:From;
	bh=lbdOrdNqth7S8nRKENaJcwv9RjD3QxuDxfCngDXfIPk=; b=bRntzqzKvoBagHMsTC+KL8N1+Y
	5G5wN4PpvjlYY92nlX0p/P4/UZUWaaOL3nx/K9/F3XMHR3pb4JUHax0opYEGJzNbNDeKnVwPKW8t7
	tYHJFcFxsSo5VAwMyeAuIfamjvwAl/8kzLAGyqnuK1V+q/Tb5OUP+50oXrTtMQFqt4wkCszFH6xbO
	8h8wvsWBhw5ZVtMnxGRPO12hAtQ6pXUDrd+Boy5MUV+Y+OjLZpEaxJUQxCXyn8GJ4IHWsD0aSKQpF
	OmkeaTD2b58woFb1d/hDRCAUz7jKkMDIjVVuk0jyepl4rC3pP73POrIGjGWDs/C33sYJASns8d30U
	NSJGMf5g==;
Received: from [10.9.9.72] (helo=submission01.runbox)
	by mailtransmit03.runbox with esmtp (Exim 4.86_2)
	(envelope-from <mhal@rbox.co>)
	id 1x90LC-0006N1-L6; Tue, 22 Sep 2026 15:15:22 +0200
Received: by submission01.runbox with esmtpsa  [Authenticated ID (604044)]  (TLS1.2:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.95)
	id 1x90L1-00FyKH-Ab;
	Tue, 22 Sep 2026 15:15:11 +0200
From: Michal Luczaj <mhal@rbox.co>
Date: Tue, 22 Sep 2026 15:14:57 +0200
Subject: [PATCH net v3 3/8] vsock: do not preserve transport assignment
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260922-vsock-connect-reset-closing-v3-3-78907b8200d4@rbox.co>
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

Introduce vsock_unconnected_reset() and adapt vsock_connect().

Change transport assignment life cycle. On connect(), socket gets a
transport assigned. If connection fails (init went wrong, peer
misbehaviour, time out, signal), transport is de-assigned and socket state
is re-initialized. Once the connection is established, transport remains
assigned until close().

Signed-off-by: Michal Luczaj <mhal@rbox.co>
---
 net/vmw_vsock/af_vsock.c | 74 ++++++++++++++++++++++++++++++------------------
 1 file changed, 47 insertions(+), 27 deletions(-)

diff --git a/net/vmw_vsock/af_vsock.c b/net/vmw_vsock/af_vsock.c
index 5c8e7e7d35b4..20181ddde114 100644
--- a/net/vmw_vsock/af_vsock.c
+++ b/net/vmw_vsock/af_vsock.c
@@ -1679,6 +1679,42 @@ static int vsock_transport_cancel_pkt(struct vsock_sock *vsk)
 	return transport->cancel_pkt(vsk);
 }
 
+static void vsock_unconnected_reset(struct sock *sk)
+{
+	struct vsock_sock *vsk = vsock_sk(sk);
+
+	sock_owned_by_me(sk);
+
+	/*
+	 * Only connected socks may have peer_shutdown or SOCK_DONE set.
+	 *
+	 * Once established (TCP_ESTABLISHED, TCP_CLOSING), a socket can be
+	 * de-assigned only on close(). But we can narrow the check down to
+	 * states we actually expect (TCP_SYN_SENT, TCP_CLOSE).
+	 */
+	if (WARN_ON_ONCE(vsk->peer_shutdown) ||
+	    WARN_ON_ONCE(sock_flag(sk, SOCK_DONE)) ||
+	    WARN_ON_ONCE(sk->sk_state != TCP_SYN_SENT &&
+			 sk->sk_state != TCP_CLOSE))
+		return;
+
+	/*
+	 * Try to cancel a VIRTIO_VSOCK_OP_REQUEST skb that may have been sent
+	 * out by transport->connect().
+	 */
+	vsock_transport_cancel_pkt(vsk);
+
+	/*
+	 * No need to invoke transport->release() for unconnected connectible
+	 * sockets. Go straight for transport deassign.
+	 */
+	vsock_deassign_transport(vsk);
+
+	/* Revert socket to initial state. Keep sk_err. */
+	WRITE_ONCE(sk->sk_state, TCP_CLOSE);
+	sk->sk_socket->state = SS_UNCONNECTED;
+}
+
 static void vsock_connect_timeout(struct work_struct *work)
 {
 	struct sock *sk;
@@ -1690,11 +1726,9 @@ static void vsock_connect_timeout(struct work_struct *work)
 	lock_sock(sk);
 	if (sk->sk_state == TCP_SYN_SENT &&
 	    (sk->sk_shutdown != SHUTDOWN_MASK)) {
-		sk->sk_state = TCP_CLOSE;
-		sk->sk_socket->state = SS_UNCONNECTED;
 		sk->sk_err = ETIMEDOUT;
 		sk_error_report(sk);
-		vsock_transport_cancel_pkt(vsk);
+		vsock_unconnected_reset(sk);
 	}
 	release_sock(sk);
 
@@ -1760,7 +1794,7 @@ static int vsock_connect(struct socket *sock, struct sockaddr_unsized *addr,
 		if (!transport->stream_allow(vsk, remote_addr->svm_cid,
 					     remote_addr->svm_port)) {
 			err = -ENETUNREACH;
-			goto out;
+			goto out_reset;
 		}
 
 		if (vsock_msgzerocopy_allow(transport)) {
@@ -1771,18 +1805,18 @@ static int vsock_connect(struct socket *sock, struct sockaddr_unsized *addr,
 			 * feature is supported here.
 			 */
 			err = -EOPNOTSUPP;
-			goto out;
+			goto out_reset;
 		}
 
 		err = vsock_auto_bind(vsk);
 		if (err)
-			goto out;
+			goto out_reset;
 
 		sk->sk_state = TCP_SYN_SENT;
 
 		err = transport->connect(vsk);
 		if (err < 0)
-			goto out;
+			goto out_reset;
 
 		/* sk_err might have been set as a result of an earlier
 		 * (failed) connect attempt.
@@ -1825,8 +1859,9 @@ static int vsock_connect(struct socket *sock, struct sockaddr_unsized *addr,
 					     timeout))
 				sock_put(sk);
 
+			finish_wait(sk_sleep(sk), &wait);
 			/* Skip ahead to preserve error code set above. */
-			goto out_wait;
+			goto out;
 		}
 
 		release_sock(sk);
@@ -1844,12 +1879,7 @@ static int vsock_connect(struct socket *sock, struct sockaddr_unsized *addr,
 			break;
 
 		/* If connection was _not_ established and a signal/timeout came
-		 * to be, we want the socket's state reset. User space may want
-		 * to retry.
-		 *
-		 * sk_state != TCP_ESTABLISHED implies that socket is not on
-		 * vsock_connected_table. We keep the binding and the transport
-		 * assigned.
+		 * to be, we want the socket's state reset. We keep the binding.
 		 */
 		if (signal_pending(current) || timeout == 0) {
 			err = timeout == 0 ? -ETIMEDOUT : sock_intr_errno(timeout);
@@ -1859,14 +1889,6 @@ static int vsock_connect(struct socket *sock, struct sockaddr_unsized *addr,
 			 * sk_state == TCP_SYN_SENT, which hereby we break.
 			 * In such case VIRTIO_VSOCK_OP_RST will follow.
 			 */
-			sk->sk_state = TCP_CLOSE;
-			sock->state = SS_UNCONNECTED;
-
-			/* Try to cancel VIRTIO_VSOCK_OP_REQUEST skb sent out by
-			 * transport->connect().
-			 */
-			vsock_transport_cancel_pkt(vsk);
-
 			goto out_wait;
 		}
 
@@ -1874,13 +1896,11 @@ static int vsock_connect(struct socket *sock, struct sockaddr_unsized *addr,
 	}
 
 	err = sock_error(sk);
-	if (err) {
-		sk->sk_state = TCP_CLOSE;
-		sock->state = SS_UNCONNECTED;
-	}
-
 out_wait:
 	finish_wait(sk_sleep(sk), &wait);
+out_reset:
+	if (err)
+		vsock_unconnected_reset(sk);
 out:
 	release_sock(sk);
 	return err;

-- 
2.55.0

