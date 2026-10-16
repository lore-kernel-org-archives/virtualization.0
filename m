Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42AD84A4843
	for <virtualization@lists.linux.dev>; Fri, 16 Oct 2026 13:27:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792157244; cv=none; b=Pjz+iB6FeEUO+XrG2AFs2+3eJ0ymyCEOeMc4rrYz8JmgfXlFJ9guQjV0KCGGtTROIhsv+zYBK28ZlCvzoAgXaOpo4s2coPbs+qoBMz9a8ussiUx/3C8Xto46VaUCg0yYpMtl6MA4/FT/w4OK6ur508hGZXZxA0VRWc1fFhLKuyA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792157244; c=relaxed/simple;
	bh=7lJhbyjirH5zCJmTumSnG3oHiNd4/m1148HN9wMGhoU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Knja7S23zQD79dEu8tUQYgOBwNP/zegosYVX+f6fiMfzsTFF6ppPY70WWUulMMbizgNMIVKR6VNsbG/DYuUAEEz0X0etX8nxYZg2Fig1toVQLIXB9EUCbnIUPe9WdpJ55ks9mukJlCQ3FzZxFCyp0XmdbVlVq4O4PR5BfNPD4jM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FbOtq0+S; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FbOtq0+S"
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-4a1698ea378so52579095e9.2
        for <virtualization@lists.linux.dev>; Fri, 16 Oct 2026 06:27:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792157241; x=1792762041; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=MIGsi8yoMefpYRASR5cNSIMFZDXgY+eEY8Ausj37ByM=;
        b=FbOtq0+SIfZdmPZ7fSSCe+JSnwm+6Z+7hq05HoVdcpkxC9JPzwMRJwGLav9+8Yk2FW
         eeqPT2VXQAPSD0E2TSQBmBHaNoa7Ydse/et4VnICWppVUuNfqH1eGbAbdtjyacb3pl+q
         MV9Kt7Yvyf8zHEWNXip4snU/OeiJcPO285RVP2J1x+gT+MkFZAu8EkhhKYhi8y67ypt1
         LNlJ120k+nsn7sqE4r8XXmq9uFUIrRdu2sXrm3KkL4l6tnnkdYrLgkENLwvJ7f+Xx46A
         XC8KQsMDdREPHm/1t9kc5OIbpEteAs1tnc4xQQPU/yqoariUcNEwvM1LpQNuis/n/gri
         DFmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792157241; x=1792762041;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=MIGsi8yoMefpYRASR5cNSIMFZDXgY+eEY8Ausj37ByM=;
        b=HIrLZt6eLq8OyVA0njah6jThhHNmxVYNwBvYwc6wZOW16baaIjqyK5sAEjQx+o4s39
         gsbeaExGMyTaAivdrzI5r2QZ9/WI2yDz1YeuSP5gzq14mqWQjiQ0egJ8fZ6M5NfP+ZCK
         UGGZl680Tfye2Q3qf51O+Ww7EBZbAUjnQvK9ueqD5avXoFZVbVjDox3+OKDk+N/mN6Sy
         da16+O6miifi0PHX3eECQglbckrKs5Qk4ZAoLepSKrDX92ni2KnykmjmMS5XB6EzUW38
         jfuvXthNzob2SFFQaMHf3V0rfzrTCLlNMW2Dni7nbeD6QOdiXVr4ZI4xsjSCWCjKYIO/
         bmFw==
X-Forwarded-Encrypted: i=1; AKwUvBycmBAXUsjU2lSvh2GZkh9mh/W88DUrUmKjNpFJLZfdRwsM2ATNrQWTIlxl8TH1efsxn72sfIdZnFtoJHinwg==@lists.linux.dev
X-Gm-Message-State: AFq9FYLEyIQ4Q2JjOq8PkHltSjbByyQvjw6OVmK3RvkMer7NaBks63s5
	Brvsqp/m07t+Js1iJc3SRWe4f8OEZmwU2KTxNTrN1NM/jdNKSFdyXBws
X-Gm-Gg: AYBFou03eu4bbRmFu+YOZdlDVwGv5rnq1BJ1vLZD6dPDRLKjdFKzEovSYwArTmKbKBK
	WVOjuuRskSg1Tmdn7Q8mBbXqcFFd/l8zC7755Dy5hlgtvJFatBghtUjNrAmoxzf+kWPoWB9pA9/
	vHD2IVvz9t+JREas0FCwuSwIyO4qUWFnc9uPSuaF7KIRFj9GFGtIzEKfUT5Y9PNxRH+9eYXlLr7
	9vRuSBGvdZP0Qj96aQuNovwn5tCdgSlUCqo2opvMrXS5RIOgD+9rkU4fjrfjQdzx1uCVY5RHNft
	mCzUQPG0vSK92fbXlws92/Pup8orYUBMfW0Cenyza1CmnSGZUz+Lbx7hC4oHyvD2E9CaBnQIuLT
	tWUpQNMOu+GlJfcPEWWCM7Nm+TynAEcL7jOUu4W0b4nDPsLu3KofqGitNJwSh/06FONoRKc4/y5
	tHsUh+C3r3pSffOam1Cz0vaNzSwqD89QtnXbQ9jCCI8lhHJnkE+t5N7MHNTtrzWn7B8ViUiFxMg
	sJy/WyFn9VyemKeQNwBU7LOqQOHFBuP/tA3mUnQrqTwsq4mdla+5iP28QY=
X-Received: by 2002:a05:600c:3e0f:b0:4a0:1b21:2628 with SMTP id 5b1f17b1804b1-4a18e4b60d8mr444663565e9.23.1792157241254;
        Fri, 16 Oct 2026 06:27:21 -0700 (PDT)
Received: from dohko.chello.ie (188-141-5-72.dynamic.upc.ie. [188.141.5.72])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a1c8de7230sm58114275e9.14.2026.10.16.06.27.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Oct 2026 06:27:20 -0700 (PDT)
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
Subject: [PATCH net-next v3 1/3] vsock: move SOL_SOCKET options to vsock_sol_socket_setsockopt()
Date: Fri, 16 Oct 2026 14:27:14 +0100
Message-ID: <20261016132716.272018-2-devnexen@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261016132716.272018-1-devnexen@gmail.com>
References: <20261016132716.272018-1-devnexen@gmail.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

SO_ZEROCOPY is handled inline in vsock_connectible_setsockopt(). Move it
to a helper with a switch on optname, so other SOL_SOCKET options can be
added as new cases. The value parsing goes to its own helper too, so each
option can do its own checks before it.

No functional change.

Signed-off-by: David Carlier <devnexen@gmail.com>
---
 net/vmw_vsock/af_vsock.c | 90 +++++++++++++++++++++++++++++-----------
 1 file changed, 65 insertions(+), 25 deletions(-)

diff --git a/net/vmw_vsock/af_vsock.c b/net/vmw_vsock/af_vsock.c
index 1c2d1cea67f4..ac2faac97462 100644
--- a/net/vmw_vsock/af_vsock.c
+++ b/net/vmw_vsock/af_vsock.c
@@ -2014,6 +2014,66 @@ static void vsock_update_buffer_size(struct vsock_sock *vsk,
 	vsk->buffer_size = val;
 }
 
+static bool vsock_sol_socket_custom(int optname)
+{
+	switch (optname) {
+	case SO_ZEROCOPY:
+		return true;
+	default:
+		return false;
+	}
+}
+
+static int vsock_sol_socket_get_bool(sockptr_t optval, unsigned int optlen,
+				     int *val)
+{
+	/* Use 'int' type here, because variable to set these options usually
+	 * has this type.
+	 */
+	if (optlen < sizeof(*val))
+		return -EINVAL;
+
+	if (copy_from_sockptr(val, optval, sizeof(*val)))
+		return -EFAULT;
+
+	if (*val < 0 || *val > 1)
+		return -EINVAL;
+
+	return 0;
+}
+
+static int vsock_sol_socket_setsockopt(struct sock *sk, int optname,
+				       sockptr_t optval, unsigned int optlen)
+{
+	struct vsock_sock *vsk = vsock_sk(sk);
+	int err;
+	int val;
+
+	lock_sock(sk);
+
+	switch (optname) {
+	case SO_ZEROCOPY:
+		err = vsock_sol_socket_get_bool(optval, optlen, &val);
+		if (err)
+			break;
+
+		if (vsk->transport && !vsock_msgzerocopy_allow(vsk->transport)) {
+			err = -EOPNOTSUPP;
+			break;
+		}
+
+		sock_valbool_flag(sk, SOCK_ZEROCOPY, val);
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
@@ -2045,36 +2105,16 @@ static int vsock_connectible_setsockopt(struct socket *sock,
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
+		if (!vsock_sol_socket_custom(optname))
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
-- 
2.55.0

