Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C4E33E4119
	for <virtualization@lists.linux.dev>; Mon, 12 Oct 2026 23:55:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791849334; cv=none; b=Ayosu7/YocNkqx35icI0lEUM44hlbQfyugd9i5KLgt/MJ/wtOG41LyWNoOmWgalMqfy7KSDoUuCqnkHCWvps6sipMCdXPrGgn6HaZhelzyCCSCvMiZXAroXEZL1qGtD0f3zUeUA/iDAFdcxCn8l/xdLruzikEi/hqYmARxS0j0s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791849334; c=relaxed/simple;
	bh=7Jppg6yM4EgF1LiDYJeOE79I8PpMZq9yJUvSKhHYuQk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QMJfwdKCiwyel6Z8VjdwJtMchmheU9BmvvnqyxGwEP6KYS7ctOFHaaUBAP77Zn9BvxEzf0SqLACV/yDm1t3eQwk0zVXhV0cNDBzTthC4BUpeXBMplPzUenFece4DcMyvLoVAr9MNyZWaqcIarn5Wl97FU2zW9bJouNXslRi2TyI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OidXR6H+; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OidXR6H+"
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-48c4207ac26so2259970f8f.0
        for <virtualization@lists.linux.dev>; Mon, 12 Oct 2026 16:55:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791849331; x=1792454131; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=gBDjfcYpOnFL2AwGB62aVDEEQFBwxjTJIGQXAUNz3X8=;
        b=OidXR6H+sYgUIsYhYqGg4kC95sAyGCOEqvAs7uGTRZRRnUwbkOrlg2rmHgUkZ77bP/
         d/Qvo51o4m2UxdC7L8eewPPcr2bR86Mzc76jnwLdwNC5lSe4DEz9qJZvEG/Q3a7FU0k+
         Z5RBTid9QfODihigzWuasiAEqzg3qFxVZbe9Hz7nMUMfWIvasQlrd3Ar9EcJni6OdYj3
         crq7YamNewktuyR02u1ZBRmQiQMfL1feiJB6YWXaHglbRWx0X+2BfpNq24HoVLU6ofqi
         FcIaTFHXKYqceMb1yUXxIiYLFJQf68Hc5zQhUy3ljNp+qiuap+8BbGvx23rkdG0H+a6F
         azLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791849331; x=1792454131;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=gBDjfcYpOnFL2AwGB62aVDEEQFBwxjTJIGQXAUNz3X8=;
        b=xHH9kdiuvQeOmG176gXEhayQGtE7g1OkPL9jkBJP/5QLdAsKav/LnXNglWdzbEGpLq
         qq84uHm2VuK0w5ZAZjEfVjIn84kIVz2/lVf6Lq4ZVfPTwfoFzN57uf4f0avMSd4u3ger
         8x5XD0FC5cdqd51tLDtrBeqvMJ3fg1p+7BJDJjQFMPRD4i4ZFB33UL9RXZrKTfVnzyPP
         FfMtPcAh0DLL33zCfqo7HQ2Zg+/nQkhR80GoW/JBp35UASezw+FxDPZj3aY+4EnV5H07
         rLYnR+yyVAFBeOJokfW9edKSLON+VS8xWk2wWDcijrH4xTrSOKIPoiJ+MNgpH8GPHdSM
         USVQ==
X-Forwarded-Encrypted: i=1; AKwUvBzw4CxByKokFNP3o1zwCG5d12asBTtpFf2JFHy6PaIjJFBsTShEeY8CjhcNUtX4tVdeP5vyCGDti+ebAuDsdw==@lists.linux.dev
X-Gm-Message-State: AFq9FYIIoE3xAGoPLYAw4eeh33GJb79lSv9wrYw/Xy+7u/p/kOQPnXFV
	FIYvjj4zTpycZS/6Ru9snUnrZIHhayAit/voqJCPTbN4QK+ORL07caZ7
X-Gm-Gg: AYBFou0BYajWYWnitHTannIqOjyNoXCCsGRBNIkod8V7daX5gE4hlramKOBthHVGZck
	yr5zI7ToPlAekZT6tO4ayuSa7RnFaJd8go5RGt9OhLZ734ucrmBB43RHfDK7DuH/f86494pHAQ5
	w43+R6483UfMzB1O/xtWSiFUz58XzCBmOKGCPn3txSkldXckJGMl0nVAJXlWd/7I/0OBL3v8y8a
	8m0WPePxXWTmFwYkDa/Glrn5fDqfrg4nOrpPxygV37Fxvpdu3P2RE5VOIXp6fSHjFnXX8p0wKds
	530r27e9wFqUVJWTb1IBdT78LW8CXETi5ekzM84wiIltSVMR7Pqe/UhdfZEsIP2nk0qtheGrUOK
	dMoiFppPGq7ybELtfam7tFV5zYq2p+WxH14qjJM7ZRZ62EeTqnyL8uBNEuDyAjSubAc4ECcSJAz
	m7Zq3YWt5JMJsTNHi9x7HXqdqtEDr8SoMobj6O5GUNjQIzXwYx0xAA4BuXqqYfJqRL7wOlQofQ8
	xRvY8dYkDtHnsMTNIEdJ+2omTd/XxkPrczKovY1fstku+aQJt0sadn5kKwI
X-Received: by 2002:a05:6000:290b:b0:487:2805:6834 with SMTP id ffacd0b85a97d-48dbace156emr19400809f8f.42.1791849331313;
        Mon, 12 Oct 2026 16:55:31 -0700 (PDT)
Received: from dohko.chello.ie (188-141-5-72.dynamic.upc.ie. [188.141.5.72])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48de0967a0dsm1933762f8f.3.2026.10.12.16.55.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Oct 2026 16:55:30 -0700 (PDT)
From: David Carlier <devnexen@gmail.com>
To: netdev@vger.kernel.org
Cc: sgarzare@redhat.com,
	bobbyeshleman@gmail.com,
	davem@davemloft.net,
	edumazet@kernel.org,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	virtualization@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	David Carlier <devnexen@gmail.com>
Subject: [PATCH net-next 1/2] vsock: support SO_INQ on stream sockets
Date: Tue, 13 Oct 2026 00:55:23 +0100
Message-ID: <20261012235524.41468-2-devnexen@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261012235524.41468-1-devnexen@gmail.com>
References: <20261012235524.41468-1-devnexen@gmail.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

SO_INQ makes recvmsg() return the bytes left in the receive queue in an
SCM_INQ cmsg, saving a SIOCINQ call per receive. AF_UNIX stream sockets
support it, AF_VSOCK fails with ENOPROTOOPT.

Add it for SOCK_STREAM, reusing the hint already computed for io_uring.
As with TCP_INQ, 1 is reported once the stream is finished so the caller
reads again and sees EOF. No cmsg is sent when the transport cannot
report the queue length.

SOCK_SEQPACKET is refused, as on AF_UNIX: its transport callback counts
messages, not bytes.

Signed-off-by: David Carlier <devnexen@gmail.com>
---
 include/net/af_vsock.h   |  1 +
 net/vmw_vsock/af_vsock.c | 41 +++++++++++++++++++++++++++++++---------
 2 files changed, 33 insertions(+), 9 deletions(-)

diff --git a/include/net/af_vsock.h b/include/net/af_vsock.h
index 5549298c1ec6..e8481f12312e 100644
--- a/include/net/af_vsock.h
+++ b/include/net/af_vsock.h
@@ -68,6 +68,7 @@ struct vsock_sock {
 	u64 buffer_size;
 	u64 buffer_min_size;
 	u64 buffer_max_size;
+	bool recvmsg_inq;
 
 	/* Private to transport. */
 	void *trans;
diff --git a/net/vmw_vsock/af_vsock.c b/net/vmw_vsock/af_vsock.c
index 1c2d1cea67f4..874dc1545a35 100644
--- a/net/vmw_vsock/af_vsock.c
+++ b/net/vmw_vsock/af_vsock.c
@@ -2050,29 +2050,38 @@ static int vsock_connectible_setsockopt(struct socket *sock,
 	transport = vsk->transport;
 
 	if (level == SOL_SOCKET) {
-		int zerocopy;
+		int v;
 
-		if (optname != SO_ZEROCOPY) {
+		if (optname != SO_ZEROCOPY && optname != SO_INQ) {
 			release_sock(sk);
 			return sock_setsockopt(sock, level, optname, optval, optlen);
 		}
 
 		/* Use 'int' type here, because variable to
-		 * set this option usually has this type.
+		 * set these options usually has this type.
 		 */
-		COPY_IN(zerocopy);
+		COPY_IN(v);
 
-		if (zerocopy < 0 || zerocopy > 1) {
+		if (v < 0 || v > 1) {
 			err = -EINVAL;
 			goto exit;
 		}
 
+		if (optname == SO_INQ) {
+			if (sk->sk_type != SOCK_STREAM) {
+				err = -ENOPROTOOPT;
+				goto exit;
+			}
+			vsk->recvmsg_inq = v;
+			goto exit;
+		}
+
 		if (transport && !vsock_msgzerocopy_allow(transport)) {
 			err = -EOPNOTSUPP;
 			goto exit;
 		}
 
-		sock_valbool_flag(sk, SOCK_ZEROCOPY, zerocopy);
+		sock_valbool_flag(sk, SOCK_ZEROCOPY, v);
 		goto exit;
 	}
 
@@ -2581,6 +2590,7 @@ __vsock_connectible_recvmsg(struct socket *sock, struct msghdr *msg, size_t len,
 	struct sock *sk;
 	struct vsock_sock *vsk;
 	const struct vsock_transport *transport;
+	bool do_cmsg = false;
 	int err;
 
 	sk = sock->sk;
@@ -2637,13 +2647,26 @@ __vsock_connectible_recvmsg(struct socket *sock, struct msghdr *msg, size_t len,
 		err = __vsock_seqpacket_recvmsg(sk, msg, len, flags);
 
 out:
-	/* Seqpacket has_data counts messages, while io_uring treats msg_inq as
-	 * a byte length when sizing retries, so only streams report a hint.
+	/* Seqpacket has_data counts messages, while SCM_INQ reports bytes and
+	 * io_uring treats msg_inq as a byte length when sizing retries, so
+	 * only streams report it.
 	 */
-	if (msg->msg_get_inq && err >= 0 && sk->sk_type == SOCK_STREAM)
+	if ((vsk->recvmsg_inq | msg->msg_get_inq) && err >= 0 &&
+	    sk->sk_type == SOCK_STREAM) {
 		msg->msg_inq = vsock_stream_inq_hint(sk);
 
+		/* A negative hint means the transport could not tell. SCM_INQ
+		 * has no encoding for that, so report nothing.
+		 */
+		do_cmsg = vsk->recvmsg_inq && msg->msg_inq >= 0;
+	}
+
 	release_sock(sk);
+
+	if (do_cmsg)
+		put_cmsg(msg, SOL_SOCKET, SCM_INQ, sizeof(msg->msg_inq),
+			 &msg->msg_inq);
+
 	return err;
 }
 
-- 
2.55.0

