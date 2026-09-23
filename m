Received: from mail-ej2-f12.google.com (mail-ej2-f12.google.com [74.125.228.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAD9A51814A
	for <virtualization@lists.linux.dev>; Wed, 23 Sep 2026 18:40:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790188826; cv=none; b=U1EOXXnGJ3SBtZrdQhWk9RSll5kaNBP0UQxipec3wu5E3OTijXT4h5plAvr6nWSmJd0XZYvGndfBqJFAoTX2Y0R33Pi1JP5q3bydvs0jsJtOiWGDV1hjPZDQh1nSepG9StS8L0+mqy6BJ211zM8bgMULI8vMQCgzcGTIl9CAa70=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790188826; c=relaxed/simple;
	bh=EvUQuL+9sEfu/yTDDsYynyczprpLsvtenWv1NJgsNFM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VsydSN3/oOmSxhnFew4VgfyLZxqeZ2dXm5gdbggamk6A3E44znCg4IRxAXQbbuQ3iYLggJmpOj2YX6YXymTJ/OZbAN7ZhhPGFGWkvp0KC6zEiakfNfFdzU/rxVqngwdabIquhGMk6Lov/RUxCs33Z/uRCGMEr/9dzm09/kzRFjI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=e7dyagHX; arc=none smtp.client-ip=74.125.228.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e7dyagHX"
Received: by mail-ej2-f12.google.com with SMTP id a640c23a62f3a-c2940ef15c1so158537366b.1
        for <virtualization@lists.linux.dev>; Wed, 23 Sep 2026 11:40:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790188812; x=1790793612; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=JlVZpnAHAmHOvMabqqtARGu8SxbZU7qizTP5GLSJRM8=;
        b=e7dyagHXIf7/FRyiBmG288MmbVxBMMoqEacAATnqtEzbAkdSYo46Y4PV+ma0E5klIm
         6hJL9eJAZ2WKW981xKeQviKXObS1d6Hha2IAH0N+kYL4ufHdDkvHFODzPlUTploZWA2s
         Gqjp6JiBk+aGnV/XHoarc5owpJHjeW51IsfpE6gWkdNgAcSe3H0dNetdBf+gbCBNR+Th
         SBqne+3Lp35jgKf5xiReRMQGcvUJFY8Rs97+pf/gszFuc1/J9Jb0nXof6X6Tll8kRSaA
         Hy1VQxw6ZUJ+CL4FrvPZZFJe1y3v4Gy7i2J5jvsVxChptLEpqCLJ5HMxCMCZBiLJfMDw
         gLlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790188812; x=1790793612;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=JlVZpnAHAmHOvMabqqtARGu8SxbZU7qizTP5GLSJRM8=;
        b=NoVOPuzhuEh+aWasAZN80F0COmaN/E0KPtoUEOugS2rb1y7uiBuCGaFUmctGtVc/C5
         XIeFiSK5bhhuZg64dQ1HZBqe2FY7aOj+vFzz13Q7h9C1hAs3xrdCDt8f5V0o4UTErI9t
         NU/FwvNC37CiP+B/dGHVlsOMPt2hwKxJhiXPixkN6mQ/smDhv3mBFUjbdsXdiHHU2j5g
         7wp6K2HXx+jNW2PPokUqSqiLfyV7ag6vv6xehi4jEhqnaTq6NF0KndrslY//aTtCJe6P
         M7IHADZqrt7fusMZuhBiFjsNWXyKnKPn438W3N/062bMJFWwJ6PqGNWsdeY/UVeBkwYs
         lx/Q==
X-Forwarded-Encrypted: i=1; AKwUvByQvUSO7JGXvdv4pn3McIGFA9yajFK9F+gzv+kuOBoq23xwD2NOrz2Pp1A2kikliDgNmuGB1p9J3CNa+855/Q==@lists.linux.dev
X-Gm-Message-State: AFuF++mXBOqfvv6Gc42W/1Ey7KDHvr+JTC+rtUZXbt7NmbM4d0wmeh0j
	tU/9yTk6XGEK9zXRd5wrl/Kc1r+b7sAWR2fOeeKWcPYS1RrKfqxG/o8n
X-Gm-Gg: AYBFou2j+EgWUakvoK9ekCOZ64kqTTpEOqhlG7U6F8tGcygfwoXN30FtNwYSlXq6kvj
	aatK/fnaZapnp0N5lciw9P2A1ykEjgCdyty8net41FznTw2lpvCQV8J7SBc9F2Vwsb4cg0nRRIq
	+7qBc60VjC95CcEHekhXfGcWXjvrk/F6i4JbkzM7aTLOQaz9hhHAn8KOyJMa+wUOOIt2aWMbxNx
	USEYWUp6TnvoKSvsgiD5FCJmePwymDhZrPbyqmsqfSwD/sCZAz9R9aISvcnOlmfKuY5hPFofCUv
	qmmU3/qOCybxysAfg6Y3MuV5ibKgLnULKB//uNHlKFS3GR8NcgiDOuzSS6GHzx7GpYPaUyvIE9G
	+3XWGvjzZjCIi15aUI9y3pqKNC3p1A4oJ8DciU8Lh8u44mcJYkNSLpYi4Tll0IcQ1pU1ZpoR9C/
	lI5AxYzQewhL2FAwFVjNwbhbeK5uHwX2Vl9B8s6gg84RjGpPmf936Yy2vrlYI+4qGfoAK1aYcIL
	4nBp8hgHFWRP41Vzsu7zyqElEQ81zBKCDYKMt5neWd/QIYGmHvPvOqBa8I=
X-Received: by 2002:a17:907:c71b:b0:c29:53eb:9913 with SMTP id a640c23a62f3a-c2ac2531dafmr836366b.38.1790188812262;
        Wed, 23 Sep 2026 11:40:12 -0700 (PDT)
Received: from dohko.chello.ie (188-141-5-72.dynamic.upc.ie. [188.141.5.72])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c2aae33faf4sm173417566b.3.2026.09.23.11.40.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Sep 2026 11:40:11 -0700 (PDT)
From: David Carlier <devnexen@gmail.com>
To: netdev@vger.kernel.org
Cc: sgarzare@redhat.com,
	bobbyeshleman@gmail.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	virtualization@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	David Carlier <devnexen@gmail.com>
Subject: [PATCH net-next v2 1/2] vsock: report pending receive data to io_uring
Date: Wed, 23 Sep 2026 19:40:07 +0100
Message-ID: <20260923184008.153541-2-devnexen@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260923184008.153541-1-devnexen@gmail.com>
References: <20260923184008.153541-1-devnexen@gmail.com>
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
 net/vmw_vsock/af_vsock.c | 35 +++++++++++++++++++++++++++++++++++
 1 file changed, 35 insertions(+)

diff --git a/net/vmw_vsock/af_vsock.c b/net/vmw_vsock/af_vsock.c
index f840498b58af..20d6f9ca6a96 100644
--- a/net/vmw_vsock/af_vsock.c
+++ b/net/vmw_vsock/af_vsock.c
@@ -2543,6 +2543,35 @@ static int __vsock_seqpacket_recvmsg(struct sock *sk, struct msghdr *msg,
 	return err;
 }
 
+/* Bytes a following receive can consume, 1 if it would only see EOF, or -1
+ * if the transport cannot tell.
+ *
+ * Called under the socket lock after a nonnegative stream receive, so a NULL
+ * transport implies SOCK_DONE.
+ */
+static int vsock_stream_inq_hint(struct sock *sk)
+{
+	struct vsock_sock *vsk = vsock_sk(sk);
+	s64 data;
+
+	if ((sk->sk_shutdown & RCV_SHUTDOWN) || !vsk->transport ||
+	    (sock_flag(sk, SOCK_DONE) && sk->sk_state != TCP_ESTABLISHED))
+		return 1;
+
+	data = vsock_stream_has_data(vsk);
+	if (data < 0)
+		return -1;
+	if (data > 0)
+		return min_t(s64, data, INT_MAX);
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
@@ -2606,6 +2635,12 @@ __vsock_connectible_recvmsg(struct socket *sock, struct msghdr *msg, size_t len,
 		err = __vsock_seqpacket_recvmsg(sk, msg, len, flags);
 
 out:
+	/* Seqpacket has_data counts messages, while io_uring treats msg_inq as
+	 * a byte length when sizing retries, so only streams report a hint.
+	 */
+	if (msg->msg_get_inq && err >= 0 && sk->sk_type == SOCK_STREAM)
+		msg->msg_inq = vsock_stream_inq_hint(sk);
+
 	release_sock(sk);
 	return err;
 }
-- 
2.55.0

