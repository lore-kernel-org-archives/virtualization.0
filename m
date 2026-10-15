Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D84432F0C48
	for <virtualization@lists.linux.dev>; Thu, 15 Oct 2026 15:43:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792079043; cv=none; b=Lwmqqc0L/i8qqL1MJGrAwFH01AAejY1z6wBcdI6VQ3Jpg+CQ6JMeeYCJmE/7exn/tfbwdTUtyl3F6NXx/EPitNO1OFZcKqmpDc1Ozc+ldNp7ruSISijXoW3IDCO7/+cr7VazbjZih90L1Ai5xSZBv0zdOCijHldUsgttF57zQBk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792079043; c=relaxed/simple;
	bh=QPUr45PzMu/8RpW9lNwZfx8Bpv3qdCpILxrSxT0z04s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=h3TtsZAMjb/Yd7l0uNICFwkbkTNBBlU1rlWyNk/xNdq5iWU6xWO1pP8Gk8w5wmlOWWXABdyGzgHHexFKqQ4qsSBXwDaTtb+S5CWqMqmA6u2Uck4mANR9gINO+5XJe8KG+fOg15muH+J+frcgX+1Daz9c8f85T6wo1SPmMDf+cr4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CByzWUz1; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CByzWUz1"
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-4a022fee0caso51643105e9.1
        for <virtualization@lists.linux.dev>; Thu, 15 Oct 2026 08:43:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792079021; x=1792683821; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=HffmXfJKy6j0voVhf7+euRmSr6xXXF4Ar0m+br65Sq0=;
        b=CByzWUz1gDUD+LmNJCo5x5UFN2ZZSY16Vb9FH2nJNhu2r+iYz9cQA7ezae8ZTtXhYS
         J1CR6M8tZLZtyjzvRcC8JGRZcpncu766cnQJ0eb7zHpbiz/toVwr7MAw0+TNYDdGVuEF
         BONbW2y5s3NUZmj1JmzRab/4Lm5cu7geIc7I//Wh0VAF4ezxo7lAeTU0LRrYkoY/BxA1
         r2ViKucCDDX5WDNdWCq74h+fdX5gZG3eI+TJupsFUdh0y40UZHP9K4EGIkK+1VjHl8AI
         c6lprKhueUDOVQEuLY7AwhRlhAwqGypfK7C7PAv30pZtj/6yGqi7xdqmPNLLkrJhRGGI
         ZmGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792079021; x=1792683821;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=HffmXfJKy6j0voVhf7+euRmSr6xXXF4Ar0m+br65Sq0=;
        b=266PzX8vBLdvvr9oZtuPnLD1zD03MTJOSRw/+rJb8XpkIjlwxFqkezxv2NA/+4Pq1L
         Oth7UqGerMXAyNtgBx8mjP3eoFWtrQSgc4peFkm5vO6sfhENLqoLGyquAmbiS5JJGdFb
         yahtqV5zGVrtPAAE+KwsvNjrLrFrtUBiYBHRu6g2M1siyMnBd98xAN0j2Jp+upkCSUfW
         ZqCI4y7Vsd8vrKReqcXK8fmRtdyobXnDzR+MtTItXZsebOqp2/mmL7bz6dzryCSJzZjo
         owo3+4XW09EpuA4L35LIRNLZF8sB/hzsCGUwx8dr4HtkKwQ2MQFtNWwz+Ae+qsBNVz7a
         Y6gw==
X-Forwarded-Encrypted: i=1; AKwUvByGf6B0H9P464K2HZvXiC42twjaLITb4fwvoUUXD1yOpvoPRLroC7WESr+fh+PXnarxU58Tuq1IJVoi9cZpmw==@lists.linux.dev
X-Gm-Message-State: AFq9FYL3D4UeUSe88HrIXFxb001pNufvJAjMX5Q3uV/qzz6GOLTrL0N/
	i6BQhPOeV//tHO27PQR6aOsxzB9X23IhDg5hI7BhVMeB11OLbINJIVww
X-Gm-Gg: AYBFou0PZlWukOltCq1esArJN5iK6LPddiOtY3ZfEYwP4riyyxkz7tdV5NuO62EpoKQ
	dqN0n6T1YkzCbr8wumNQP7oIE+/Z5ImCi6RPEYI8OoNOzJc2oZ/7Dh9tFSEL+esrr/BVWQIoEvY
	z1oKozYaVux3fKdxkGqoSIZRqrSVz0YzP5QF48E5Z07egXNA6nMHtfXDRHigzlBK3Q0TvKGkSp1
	IFePL4TLkNr4wi9irkSqk4tu9hTQueA/ZgbYPmWwMHLe74+84vjgpi8PmejaTvOM2q5L5+gcUMX
	uwrgZ6WMci5I+Iou2REzlG9sHIITwqleyoqz6p79MXmHGoLjZ4ZzqowADzjZ2rmcOKSAQr3kvjK
	+JN/LbgturkSq+44fDdACy9vlt8G2YZCDy15gWmwSGzg7mUgtyB1idP7DsHn5qNtAEK9FMCnwOB
	rSITrYYzoV1aFYzPpc/ZpyQ//WYDV5efk2bs5RBn76w2JctRVddU5sRGV/8iJpG3bS2kOAhivkx
	/jJTey+SMAG9+H/yuLJJm3fT3lRmC98aDQmkAfIe++NzEENCXFzSs3htcVd
X-Received: by 2002:a05:600c:350b:b0:4a1:ad01:f8dc with SMTP id 5b1f17b1804b1-4a1ad01f924mr184426785e9.21.1792079020615;
        Thu, 15 Oct 2026 08:43:40 -0700 (PDT)
Received: from dohko.chello.ie (188-141-5-72.dynamic.upc.ie. [188.141.5.72])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a1bd640be0sm61940825e9.1.2026.10.15.08.43.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Oct 2026 08:43:40 -0700 (PDT)
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
Subject: [PATCH net-next v2 1/2] vsock: support SO_INQ on stream sockets
Date: Thu, 15 Oct 2026 16:43:33 +0100
Message-ID: <20261015154334.3217358-2-devnexen@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261015154334.3217358-1-devnexen@gmail.com>
References: <20261015154334.3217358-1-devnexen@gmail.com>
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
reads again and sees EOF, and accepted sockets inherit the setting from
the listener. No cmsg is sent when the transport cannot report the queue
length.

SOCK_SEQPACKET is refused, as on AF_UNIX: its transport callback counts
messages, not bytes.

Signed-off-by: David Carlier <devnexen@gmail.com>
---
 include/net/af_vsock.h   |   1 +
 net/vmw_vsock/af_vsock.c | 111 +++++++++++++++++++++++++++++----------
 2 files changed, 84 insertions(+), 28 deletions(-)

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
index 1c2d1cea67f4..186ed57fd797 100644
--- a/net/vmw_vsock/af_vsock.c
+++ b/net/vmw_vsock/af_vsock.c
@@ -984,6 +984,7 @@ static struct sock *__vsock_create(struct net *net,
 		vsk->buffer_size = psk->buffer_size;
 		vsk->buffer_min_size = psk->buffer_min_size;
 		vsk->buffer_max_size = psk->buffer_max_size;
+		vsk->recvmsg_inq = psk->recvmsg_inq;
 		security_sk_clone(parent, sk);
 	} else {
 		vsk->trusted = ns_capable_noaudit(&init_user_ns, CAP_NET_ADMIN);
@@ -2014,6 +2015,66 @@ static void vsock_update_buffer_size(struct vsock_sock *vsk,
 	vsk->buffer_size = val;
 }
 
+static bool vsock_custom_sockopt(int optname)
+{
+	switch (optname) {
+	case SO_ZEROCOPY:
+	case SO_INQ:
+		return true;
+	default:
+		return false;
+	}
+}
+
+static int vsock_sol_socket_setsockopt(struct sock *sk, int optname,
+				       sockptr_t optval, unsigned int optlen)
+{
+	struct vsock_sock *vsk = vsock_sk(sk);
+	int err = 0;
+	int val;
+
+	/* Use 'int' type here, because variable to
+	 * set these options usually has this type.
+	 */
+	if (optlen < sizeof(val))
+		return -EINVAL;
+
+	if (copy_from_sockptr(&val, optval, sizeof(val)))
+		return -EFAULT;
+
+	if (val < 0 || val > 1)
+		return -EINVAL;
+
+	lock_sock(sk);
+
+	switch (optname) {
+	case SO_ZEROCOPY:
+		if (vsk->transport && !vsock_msgzerocopy_allow(vsk->transport)) {
+			err = -EOPNOTSUPP;
+			break;
+		}
+
+		sock_valbool_flag(sk, SOCK_ZEROCOPY, val);
+		break;
+
+	case SO_INQ:
+		if (sk->sk_type != SOCK_STREAM) {
+			err = -ENOPROTOOPT;
+			break;
+		}
+
+		vsk->recvmsg_inq = val;
+		break;
+
+	default:
+		err = -ENOPROTOOPT;
+		break;
+	}
+
+	release_sock(sk);
+	return err;
+}
+
 static int vsock_connectible_setsockopt(struct socket *sock,
 					int level,
 					int optname,
@@ -2045,36 +2106,16 @@ static int vsock_connectible_setsockopt(struct socket *sock,
 	sk = sock->sk;
 	vsk = vsock_sk(sk);
 
-	lock_sock(sk);
-
-	transport = vsk->transport;
-
 	if (level == SOL_SOCKET) {
-		int zerocopy;
-
-		if (optname != SO_ZEROCOPY) {
-			release_sock(sk);
+		if (!vsock_custom_sockopt(optname))
 			return sock_setsockopt(sock, level, optname, optval, optlen);
-		}
-
-		/* Use 'int' type here, because variable to
-		 * set this option usually has this type.
-		 */
-		COPY_IN(zerocopy);
 
-		if (zerocopy < 0 || zerocopy > 1) {
-			err = -EINVAL;
-			goto exit;
-		}
+		return vsock_sol_socket_setsockopt(sk, optname, optval, optlen);
+	}
 
-		if (transport && !vsock_msgzerocopy_allow(transport)) {
-			err = -EOPNOTSUPP;
-			goto exit;
-		}
+	lock_sock(sk);
 
-		sock_valbool_flag(sk, SOCK_ZEROCOPY, zerocopy);
-		goto exit;
-	}
+	transport = vsk->transport;
 
 	switch (optname) {
 	case SO_VM_SOCKETS_BUFFER_SIZE:
@@ -2581,6 +2622,7 @@ __vsock_connectible_recvmsg(struct socket *sock, struct msghdr *msg, size_t len,
 	struct sock *sk;
 	struct vsock_sock *vsk;
 	const struct vsock_transport *transport;
+	bool do_cmsg = false;
 	int err;
 
 	sk = sock->sk;
@@ -2637,13 +2679,26 @@ __vsock_connectible_recvmsg(struct socket *sock, struct msghdr *msg, size_t len,
 		err = __vsock_seqpacket_recvmsg(sk, msg, len, flags);
 
 out:
-	/* Seqpacket has_data counts messages, while io_uring treats msg_inq as
-	 * a byte length when sizing retries, so only streams report a hint.
+	/* Seqpacket has_data counts messages, while SCM_INQ reports bytes and
+	 * io_uring treats msg_inq as a byte length when sizing retries, so
+	 * only streams report it.
 	 */
-	if (msg->msg_get_inq && err >= 0 && sk->sk_type == SOCK_STREAM)
+	if ((vsk->recvmsg_inq || msg->msg_get_inq) && err >= 0 &&
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

