Received: from mail-ej2-f12.google.com (mail-ej2-f12.google.com [74.125.228.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64D5347277C
	for <virtualization@lists.linux.dev>; Sun, 20 Sep 2026 19:47:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789933639; cv=none; b=bs3R5ALAaC6gBXKZO1OeywGBrkGbEhYduBMg92WLBmFlyWWbfpnQM+mE/WtHad/LO/4W7uCdOTLC1BYk03b7q7ec1WJ3xc/eksL2YYtt0gpa6hWp1HZl17FIQzbchM7DQVg0T5gjQ6/DPc2ZfplDYFWjPiG96VQdv1argWNspQ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789933639; c=relaxed/simple;
	bh=P2kW8ATtvkNqZncHYca4L+gsqhgusrW42yBbrkJoSd8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XJQBpHUGom3MU98xL9h8b8DBluK/RXoTaWQO2MAA0bY4gfekJJZkzFAfWxTop3KWsZf8cRiRBGxVoBu0UeQjMSs5rnVZRLXkUrueOwzNSskRy/1wPFq5QBqNfXRLiezVNYTfNc6yffpSo5UMescOLyJ7TGNcMhujpsl/fcZUA/k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ETiFO4mj; arc=none smtp.client-ip=74.125.228.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ETiFO4mj"
Received: by mail-ej2-f12.google.com with SMTP id a640c23a62f3a-c2940ef15c1so282905366b.1
        for <virtualization@lists.linux.dev>; Sun, 20 Sep 2026 12:47:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789933635; x=1790538435; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Ecyy9bn6zcz7JfajH979ClHOPnn+4eN95YmsvJYzOX0=;
        b=ETiFO4mjal5Q+IAo9unwxgdXmMtoIbVNPcAIwAdJdzilqDJuwErpTQdF9/WjE6gfOL
         OdAsAz2MKyCFyn1FwiNjsswY+LWQqJ4I6xNX42Bux41WvR/YlnEKgp+RUVbYBnik8wTX
         r8saTJzO3UnzTrQXx0dW4Rv1Y0Vz14+uYTtTdlFt0DAoM73WjafHWd0+UYLpKQelUsnd
         A++wRTJQFPauMEc2xTkoCYLnpA9LLBwFs7GMK4g+rik0D/hIzn/Us3q1fl8Ihiqyaqt7
         wRAExOeK5GUWwuqvw9vQL6/5/HHUC+slxVNs0nXejUiLjtx0L0G7L+GCnO9hQq84c+gV
         euCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789933635; x=1790538435;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Ecyy9bn6zcz7JfajH979ClHOPnn+4eN95YmsvJYzOX0=;
        b=n29YITqV6Wenuo1o0q3xcyZI/TArw716Su01d8hms1LDE0/iBr1R0ED9LE10Tln6cS
         bSJt9gW/ykTlQ/XlapfA9wCwuFRXlnzOVQUbwV3dWJLrDtb47I6XLnoaoO27pmDXIy3B
         HItwGWxl/IKHCN+iwK3YIfnjNvz0Z5CfE+vSjWc3iTsUcM8mXzbqk3YM928I1MlCfPJv
         ugmojBc07lsfb+ZfMbB6+SPIcKxoRb1zQAjYMeLHP0IkSIMMeovMz+UveTviJdXLdhxM
         bTOTLomP1WD7dPyO0vugF1JjRKAZNBwMDFvF5LvGm993KpOZWu1EOcE4PlikikjCMQiH
         WRaA==
X-Forwarded-Encrypted: i=1; AKwUvBySecDMCsOQrC+tjAAvTbmCy2YctkCI1yXaTHkcomZUposuYTHKAW6tJdFfBVv3Q+XFoEE17WJT2iMxwvmQ1Q==@lists.linux.dev
X-Gm-Message-State: AFuF++nGWXEwHrSvI/DYFHMyKO+VMnnhG/dPS4DdD3kGBnSiyv0jP7/f
	C2XDF73uIAiia1A/J2aiXrGkoYlKbz807hxDii/3YoZrX/nc7B8mdV6B
X-Gm-Gg: AYBFou0lkC+AWCaGWbTs3hu15IEZRPigV5A+Roa5iZiEstbLR3rtIFC3hvrMDOk7P/q
	ZaCpJllczVTvXjYjpk4WQkH+30xGByhUeCGFLFqN5N/yb6wbru7bTzEvIIwQ4BCTHkAXOxDi9k+
	E3xtzz3ZC5HBsI3036fSXNrX/eHRZBhVo99m+fJPATOx1fmBFZpfmiK/J7f72Jkc04X8zw9Hjjc
	uzpChIXLNaRoZOaqybjaOZxFMNgHZYi/uEaL9PfjlVgTlOnDfi5/uAUDI4yJBarmTkHBpPEbvVa
	ZbeYpKIuAyJiqiDOC3xgOwekbY9QS0cDoMlq/DVYUfN94vKSRtLTboKDmtE5P93mp7wgA5FRp6W
	vsh0nLYUqo5Egrp4N4MdSFnyZeryLBW9nH7uUxROxyKdTtLJZLFVdaV12YeFoWxNF5zQjjlxtMs
	K9RfvDtTeBPypoEfK2598WRa9PLzLIHVOpyZ6mGqjzL9dAB2Qeb6Ok008Mbz4uwW9xRxWS1Ya63
	sN4BDSGyfcEUve3AQj4pe6yBStGpxzdPMdWpMIMYXqJJ2eSUJNQBCXklaE=
X-Received: by 2002:a17:907:3cd4:b0:c29:4d59:9833 with SMTP id a640c23a62f3a-c2a1569a4b8mr756590066b.15.1789933635349;
        Sun, 20 Sep 2026 12:47:15 -0700 (PDT)
Received: from dohko.chello.ie (188-141-5-72.dynamic.upc.ie. [188.141.5.72])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c2a358ff8edsm211768466b.61.2026.09.20.12.47.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Sep 2026 12:47:14 -0700 (PDT)
From: David Carlier <devnexen@gmail.com>
To: netdev@vger.kernel.org
Cc: sgarzare@redhat.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	virtualization@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	David Carlier <devnexen@gmail.com>
Subject: [PATCH net-next 1/2] vsock: report pending receive data to io_uring
Date: Sun, 20 Sep 2026 20:47:09 +0100
Message-ID: <20260920194710.1114748-2-devnexen@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260920194710.1114748-1-devnexen@gmail.com>
References: <20260920194710.1114748-1-devnexen@gmail.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

AF_VSOCK stream receives never fill msghdr.msg_inq, so io_uring cannot set
IORING_CQE_F_SOCK_NONEMPTY and retries a multishot receive even after the
queue has been drained.

Fill the hint at the common receive exit using the transport callback that
SIOCINQ already uses, and report 1 once the connection is finished so the
caller performs the receive which observes EOF, as TCP does after a FIN.

A vsock loopback ping-pong with io_uring multishot receive drops entries
into __vsock_connectible_recvmsg from 1.97 to 1.00 per delivered message,
and receiver CPU time by about 3% (25 runs of 50000 messages, p=0.006).

Signed-off-by: David Carlier <devnexen@gmail.com>
---
 net/vmw_vsock/af_vsock.c | 39 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 39 insertions(+)

diff --git a/net/vmw_vsock/af_vsock.c b/net/vmw_vsock/af_vsock.c
index f840498b58af..63309708c916 100644
--- a/net/vmw_vsock/af_vsock.c
+++ b/net/vmw_vsock/af_vsock.c
@@ -2543,6 +2543,38 @@ static int __vsock_seqpacket_recvmsg(struct sock *sk, struct msghdr *msg,
 	return err;
 }
 
+/* Bytes a following receive can consume, 1 if it would only see EOF, or a
+ * negative value to leave the caller's hint alone.
+ *
+ * Called under the socket lock after a nonnegative stream receive, so a NULL
+ * transport implies SOCK_DONE.
+ */
+static int vsock_inq_hint(struct sock *sk)
+{
+	struct vsock_sock *vsk = vsock_sk(sk);
+	s64 data;
+
+	if ((sk->sk_shutdown & RCV_SHUTDOWN) ||
+	    (sock_flag(sk, SOCK_DONE) && sk->sk_state != TCP_ESTABLISHED))
+		return 1;
+
+	if (!vsk->transport)
+		return 1;
+
+	data = vsock_stream_has_data(vsk);
+	if (data < 0)
+		return -1;
+	if (data > 0)
+		return (int)min_t(s64, data, INT_MAX);
+
+	/* Empty but finished: keep the caller reading so it sees EOF. */
+	if (sock_flag(sk, SOCK_DONE) ||
+	    (READ_ONCE(vsk->peer_shutdown) & SEND_SHUTDOWN))
+		return 1;
+
+	return 0;
+}
+
 int
 __vsock_connectible_recvmsg(struct socket *sock, struct msghdr *msg, size_t len,
 			    int flags)
@@ -2606,6 +2638,13 @@ __vsock_connectible_recvmsg(struct socket *sock, struct msghdr *msg, size_t len,
 		err = __vsock_seqpacket_recvmsg(sk, msg, len, flags);
 
 out:
+	if (msg->msg_get_inq && err >= 0 && sk->sk_type == SOCK_STREAM) {
+		int inq = vsock_inq_hint(sk);
+
+		if (inq >= 0)
+			msg->msg_inq = inq;
+	}
+
 	release_sock(sk);
 	return err;
 }
-- 
2.55.0

