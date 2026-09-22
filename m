Received: from mailtransmit04.runbox.com (mailtransmit04.runbox.com [185.226.149.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D38555409A;
	Tue, 22 Sep 2026 13:15:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.226.149.37
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790082964; cv=none; b=DHe9nOiuvbwxP9jSKLL92hfxbMx5ksS9sYeEjaGEY2Ge+9FZRXlrzHba+S8PlJe5AQJ+G0XzLXbkssMG66/ujq7a2EL791Jw4+SrkFqjtYfVfMhPyI2kg98MN+6G+vwH28BJEtWjZ4G5plMEInFcc1CRQS7gJYHXP6evynk0o1Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790082964; c=relaxed/simple;
	bh=LY8LmPKAONxW9j4eK8b29/UnBFRwaSSytBU8oXUdKjg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=mNbDclQvthK4GtyDEb1yadC6z+wnK96ZO9r+PPIHJXbhpYGpPRxWFxuRpOtF46eMQc3fUgFkOmomqQOf6KmW1O+GBArPtOA4TjY8VtULmIj7wCnAhRTo+HwF+qU8yjUtwQfdadBZDAy468u80O3VcoLV72d4+8PoDWARd4EJwmI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rbox.co; spf=pass smtp.mailfrom=rbox.co; dkim=pass (2048-bit key) header.d=rbox.co header.i=@rbox.co header.b=rAbQgO3t; arc=none smtp.client-ip=185.226.149.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rbox.co
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rbox.co
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rbox.co header.i=@rbox.co header.b="rAbQgO3t"
Received: from mailtransmit02.runbox ([10.9.9.162] helo=aibo.runbox.com)
	by mailtransmit04.runbox.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.93)
	(envelope-from <mhal@rbox.co>)
	id 1x90LM-0038Q0-C4; Tue, 22 Sep 2026 15:15:32 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=rbox.co;
	s=selector1; h=Cc:To:In-Reply-To:References:Message-Id:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:From;
	bh=ilNAZyblMrw/p18wPajPZWU+KdUJfZ5kiK/NIQQUstY=; b=rAbQgO3ts0fnccl9zDnD1KwhxK
	vv7Gkgw3OYOrSKFRpYQcIx4N2v6/ShwDGAOr00poGK7HGbWFshq8ppokDUBjBLkxDxrp5uZmNE36D
	w9EduDcSgylbcp4c5OjBl55SSg9PrKRLy21z4rJV00xJtLjIF+4ptnFXFEnHqGP4xhvKb/bjh85iE
	tMasyExklO6ZC53keGN6bCk2h3iAQCn0fhEiI00G19Nx3U6wbbJ7m94Rg4d15k+vISKu+fWS7lt0u
	5Kkxojde3JGN8nBVl18VfVh8HTtQLaxZW5nLUXoHlYLRV1OKM/iFe/Ny8shBbwuOqZ9XegH7ZQjOb
	nGk2lgrA==;
Received: from [10.9.9.72] (helo=submission01.runbox)
	by mailtransmit02.runbox with esmtp (Exim 4.86_2)
	(envelope-from <mhal@rbox.co>)
	id 1x90LG-0004oC-Pf; Tue, 22 Sep 2026 15:15:27 +0200
Received: by submission01.runbox with esmtpsa  [Authenticated ID (604044)]  (TLS1.2:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.95)
	id 1x90L3-00FyKH-3l;
	Tue, 22 Sep 2026 15:15:13 +0200
From: Michal Luczaj <mhal@rbox.co>
Date: Tue, 22 Sep 2026 15:14:59 +0200
Subject: [PATCH net v3 5/8] vsock: treat TCP_CLOSING as once-established
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260922-vsock-connect-reset-closing-v3-5-78907b8200d4@rbox.co>
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
 Hyunwoo Kim <imv4bel@gmail.com>, Michal Luczaj <mhal@rbox.co>
X-Mailer: b4 0.15.2

When connect() is scheduled out awaiting TCP_SYN_SENT -> TCP_ESTABLISHED,
socket may already transition TCP_ESTABLISHED -> TCP_CLOSING
(VIRTIO_VSOCK_OP_RST) or have sk_err set (VIRTIO_VSOCK_OP_RW). Short
circuit the logic; do not assume a non-zero sk_err signifies a failed
connect. connect() should return the status of connection attempt itself,
not what followed.

Fixes: d021c344051a ("VSOCK: Introduce VM Sockets")
Reported-by: Hyunwoo Kim <imv4bel@gmail.com>
Link: https://lore.kernel.org/netdev/anzT1fREOSyHT99k@v4bel/
Signed-off-by: Michal Luczaj <mhal@rbox.co>
---
 net/vmw_vsock/af_vsock.c | 15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

diff --git a/net/vmw_vsock/af_vsock.c b/net/vmw_vsock/af_vsock.c
index 5cecd1c9c6e5..ff4140aaf1f3 100644
--- a/net/vmw_vsock/af_vsock.c
+++ b/net/vmw_vsock/af_vsock.c
@@ -1846,15 +1846,19 @@ static int vsock_connect(struct socket *sock, struct sockaddr_unsized *addr,
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
+			finish_wait(sk_sleep(sk), &wait);
+			goto out;
+		}
 
 		/* If connection was _not_ established and a signal/timeout came
 		 * to be, we want the socket's state reset. We keep the binding.
@@ -1877,8 +1881,7 @@ static int vsock_connect(struct socket *sock, struct sockaddr_unsized *addr,
 out_wait:
 	finish_wait(sk_sleep(sk), &wait);
 out_reset:
-	if (err)
-		vsock_unconnected_reset(sk);
+	vsock_unconnected_reset(sk);
 out:
 	release_sock(sk);
 	return err;

-- 
2.55.0

