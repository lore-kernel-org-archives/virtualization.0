Received: from mailtransmit05.runbox.com (mailtransmit05.runbox.com [185.226.149.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E20E54B1B8;
	Tue, 22 Sep 2026 13:15:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.226.149.38
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790082943; cv=none; b=JawPf5LqpitkFL1Ap2bH42WfGMOwE3eKOFxANJw6rUG3aqS3JnrltJCOVWAv5Dy8UOGSADGVOVLHspBpH2KF6cYuv17AlywTCvry7pY9OsMpcr9J2UxOXf9kSsAI7WhF0Gs40fFRrAF4Wq0sTYsbxZli17FEPeqdBmljF/Gx4h0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790082943; c=relaxed/simple;
	bh=Z3JNUkcIru63O0NeHXDbc+QM3RTFQuGiytm1kM/XnFk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=RwK+eBbt7vkrVqrUZzErdPJu39PlCQ4ydcO8P8j7EKbRqFfjkER28r+5/OKgqg1zBde/qNPEUM8ASh3ApRMy0qPb82k1JoRc5SvB1QtjkBOb6hW9pFsErxNzIaXJGwOp6dxJPZKoutiJ33CTYDuPlQiqE1VyVjOaDYvdL7BSXok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rbox.co; spf=pass smtp.mailfrom=rbox.co; dkim=pass (2048-bit key) header.d=rbox.co header.i=@rbox.co header.b=DMXBSwDG; arc=none smtp.client-ip=185.226.149.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rbox.co
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rbox.co
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rbox.co header.i=@rbox.co header.b="DMXBSwDG"
Received: from mailtransmit02.runbox ([10.9.9.162] helo=aibo.runbox.com)
	by mailtransmit05.runbox.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.93)
	(envelope-from <mhal@rbox.co>)
	id 1x90LH-005SDM-Vz; Tue, 22 Sep 2026 15:15:28 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=rbox.co;
	s=selector1; h=Cc:To:In-Reply-To:References:Message-Id:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:From;
	bh=upTrSuyY4wF/GArbfk07giPQMunbifrM/wIJL3iqI5Q=; b=DMXBSwDGEyJBi5h6BGFctMc9V4
	SuD5mHAELXA+QfGqbh3gDV36Qwqym/61BdZ9rGuDyU6Koj8SKRt3gUSs0tmTJftNCD2Y5lWCnfzjm
	tteoY4Ud6DzvBTRsm+3Mcf2iqg+o1oUpr8j043NwMBzmmnAaLoKzTAy/L/rQMES4JGvBfndaqj575
	HAtnRYCE5PO3m8AoC9oqv+Ss2oMio0j9ZNyFVFQMvkZWlyET7POb0C0MUWZU2Lkj53TJtqmerL3AJ
	bI7mM64g8kiEddoAnBX6gxkzTTrbMlCmpJb0/WXZW66YvdkV/yfr7k5dRGzZQe8ZvtKnpipfyfh5X
	8Zepvl0w==;
Received: from [10.9.9.72] (helo=submission01.runbox)
	by mailtransmit02.runbox with esmtp (Exim 4.86_2)
	(envelope-from <mhal@rbox.co>)
	id 1x90LC-0004lG-Fs; Tue, 22 Sep 2026 15:15:22 +0200
Received: by submission01.runbox with esmtpsa  [Authenticated ID (604044)]  (TLS1.2:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.95)
	id 1x90Kz-00FyKH-JI;
	Tue, 22 Sep 2026 15:15:09 +0200
From: Michal Luczaj <mhal@rbox.co>
Date: Tue, 22 Sep 2026 15:14:55 +0200
Subject: [PATCH net v3 1/8] vhost/vsock: Fix socket state constant
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260922-vsock-connect-reset-closing-v3-1-78907b8200d4@rbox.co>
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

Refactor under Fixes missed one: SS_UNCONNECTED (1) -> TCP_CLOSE (7).
Until now, sk->sk_state = 1 stood for TCP_ESTABLISHED.

Fixes: 3b4477d2dcf2 ("VSOCK: use TCP state constants for sk_state")
Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>
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

