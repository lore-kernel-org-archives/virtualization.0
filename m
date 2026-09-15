Received: from mailtransmit04.runbox.com (mailtransmit04.runbox.com [185.226.149.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE2A73B47DF;
	Tue, 15 Sep 2026 13:16:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.226.149.37
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789478195; cv=none; b=ncImXzMqDfhSMYGFjyw38VRCHWITZ4FKDVDAefnMwye1R2hu/wtpUwRvlnZxRcndpz5qbu4zud4zRV+4WxqI2ESojMtx2XpdnIPe11zU05ZNzMlBj3XZVY+1N/VHSjhiDyE2WaP0Oo10K66DpSuQa1hbey0TqdbMij0QJ/M9ZfM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789478195; c=relaxed/simple;
	bh=DxEAvBYs0BJ/VwmHJw7e2YAIz8OzlYW20LcmBo40dPQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=VvjzOm+/5AgiQEzoXri63InCFzx+ftVvCzLppCa0u+sGkqKC+Q+Br3QNYlPWENZVfjLmsrP2rhBNT+A958gTqDnUDH3+HbdGCcWonPI8WXpKsVlbqGSJTvlqJJx/tgDt8aKXwHiQPOZey/RP2yBEJ3yCZsUdKgVT6Bx4mKZoL8c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rbox.co; spf=pass smtp.mailfrom=rbox.co; dkim=pass (2048-bit key) header.d=rbox.co header.i=@rbox.co header.b=ZONxWi8G; arc=none smtp.client-ip=185.226.149.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rbox.co
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rbox.co
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rbox.co header.i=@rbox.co header.b="ZONxWi8G"
Received: from mailtransmit02.runbox ([10.9.9.162] helo=aibo.runbox.com)
	by mailtransmit04.runbox.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.93)
	(envelope-from <mhal@rbox.co>)
	id 1x6T0c-00HRCg-Od; Tue, 15 Sep 2026 15:15:38 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=rbox.co;
	s=selector2; h=Cc:To:In-Reply-To:References:Message-Id:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:From;
	bh=96jbmB9W+tKz2zIt1w43a9vt7j7LmrljAaRgMAl32vs=; b=ZONxWi8GXwK6TzSwTtChwprtbY
	UwlxnfPaFRHHrxSxI7AXXXlVFl51Ba4vwdDS86aL5rgkIFDg4D6Ysycw2XswTpp5BZ6Yb5F3zuKAN
	3su2DUF4aOvhKNpTqSTsjLzRqdCp3/eh9YHJjw7J+nJAtlsK3j2UyIhvZxpDDx6sHXa20uXf+qSdL
	xbFJB1BCTvWg42UtwxK5Tq/EaaCzWlsCaX2cnuMYJ32P9Lji2j0WBcRn6KmgxAh/mABUKQ+RfBdEz
	PwJCPCOjn819Fi/XJ7y5GQgin7bypO4yKxMlsB9N26uLVGJvC3CuEa+r+wsau2aTsbFRN1UTIKO7D
	A1RJZLiA==;
Received: from [10.9.9.72] (helo=submission01.runbox)
	by mailtransmit02.runbox with esmtp (Exim 4.86_2)
	(envelope-from <mhal@rbox.co>)
	id 1x6T0X-0003iV-4p; Tue, 15 Sep 2026 15:15:33 +0200
Received: by submission01.runbox with esmtpsa  [Authenticated ID (604044)]  (TLS1.2:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.95)
	id 1x6T0I-00EUxD-5j;
	Tue, 15 Sep 2026 15:15:18 +0200
From: Michal Luczaj <mhal@rbox.co>
Date: Tue, 15 Sep 2026 15:15:12 +0200
Subject: [PATCH net v2 1/5] vhost/vsock: Fix socket state constant
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260915-vsock-connect-reset-closing-v2-1-a1d9abb472f7@rbox.co>
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

Refactor under Fixes missed one: SS_UNCONNECTED (1) -> TCP_CLOSE (7).
Until now, sk->sk_state = 1 stood for TCP_ESTABLISHED.

Fixes: 3b4477d2dcf2 ("VSOCK: use TCP state constants for sk_state")
Signed-off-by: Michal Luczaj <mhal@rbox.co>
---
 drivers/vhost/vsock.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/vhost/vsock.c b/drivers/vhost/vsock.c
index abed1fbcf66c..6051533456f6 100644
--- a/drivers/vhost/vsock.c
+++ b/drivers/vhost/vsock.c
@@ -774,7 +774,7 @@ static void vhost_vsock_reset_orphans(struct sock *sk)
 
 	sock_set_flag(sk, SOCK_DONE);
 	vsk->peer_shutdown = SHUTDOWN_MASK;
-	sk->sk_state = SS_UNCONNECTED;
+	sk->sk_state = TCP_CLOSE;
 	sk->sk_err = ECONNRESET;
 	sk_error_report(sk);
 }

-- 
2.55.0

