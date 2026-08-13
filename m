Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CC2E37E5DC
	for <virtualization@lists.linux.dev>; Thu, 13 Aug 2026 17:31:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786642313; cv=none; b=tT9+ClP2Vpvl8/11xxO0O/67wMyd3aiOXiHEwItmIbHXBoc0hdEP+mY/+BvlEhtoUS7gSw/3W7xPGQQ5rn/U/ud+L5So0i9tIauamBUV0QYYSeLK8RRFxgGUsIdKP0jdrqg3gvLGuqQ1WJoS0hJ4wEFeGKOPe4UZzHe1TZtiQF0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786642313; c=relaxed/simple;
	bh=sCm4JC/C/nrh5towOjwGQMmxpw99/kz1n1+sjCZg3OM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Asr8Tm4P21dHzmfLB8IrT+k9uxNPHwJ5h2J594hPpco6hcwwP0PiaInruiFv2RiiA/4H8e8ONR96dStojnriXCA2IYia1OHetvU/GR78nJVXcfc0UpSHfEG2fydMVUh2JJRZioXJSqjFtW9owr/XHy0SBk0n24kOu220I6QEOJQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=X6YjdMps; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X6YjdMps"
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-38dfe7eb825so93259a91.0
        for <virtualization@lists.linux.dev>; Thu, 13 Aug 2026 10:31:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786642311; x=1787247111; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=PMBuQPRPUkDIdWcPkANLnrxOobcaxz+FksX3Qk8GmDY=;
        b=X6YjdMps1/DJGDz+cFql6kE/ZcKc28lkjtcZt58j1+GAMjCqAjPKqabMv5zUOtQ3bE
         zlJ7Yj7s37wpu4zqsCrsXS1+E1JMllByqLELjAirLpehm+Fl/p0Qbnql86upV3rUhvlh
         41XIuvIlHJ0d8+IMUPw/plmcriMKzn0pjo2CR/a3GXBL6soo8kOae8sc2Be3wKXMT2wX
         TXtmyxek5iBi5eLb6umkhtd78Nh9s8tKWVOcdQTStCmuuFXMKmzjKqvl5p9yOsGNtW32
         USgjuHFV8DJ1SIGVsvCWKTEYdoQ0zMJCi0cuOZOqhFTvddG3TjH+GourUtuZfrooLQFJ
         jlKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786642311; x=1787247111;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=PMBuQPRPUkDIdWcPkANLnrxOobcaxz+FksX3Qk8GmDY=;
        b=MbWQdiwvlK9zkUf2Eg4ba8jxi/QMW3jlnZiMut8KeJxTmoHj3jtzwkWEyk/eQS8Rw6
         b9+GQXZ+K+pOWjLy9x/PBQ0l4cwbHSUymbW2yyS9zOHTC389fiW+p4S0RTLpVejrnC2G
         XTf8ZyLG0HgBUQ7gkVPuGN4G/WPDy5UTyKJaElrw0R/iTSKX78V3nrLufsoK7Lsssx8q
         BJ8oKb+HxilpSNburYALwdEvfxTkVseM3L4OVmUdaCRX5V3AV/Od2Ig7wDNaQS7UNbVQ
         TgkMqz5iTF3AKH+dt0LFVuJ5f5GwduVN5nmIqWOO+ZoYJ0TnDLYNL4I2p+3bnNGFDaOM
         bB1Q==
X-Forwarded-Encrypted: i=1; AHgh+RpWxRae9s0qFA7J1dHSojeRdswwW/D3FwNvoqz0Q/jZjco3Ppe2Ca7pecTcjYLucajntyATziaS4swWZzg7Sg==@lists.linux.dev
X-Gm-Message-State: AOJu0YxYU7Ly3idOc0gUsX80visntiqUnPIZ829mDCdqgU0MJl6XqiRi
	XKllP4hkBodLf5mBFaGBt5wCcndeFT186EnrxFrwgBXILmwxS9oZSVdh
X-Gm-Gg: AR+sD10arfiXSqhKDFuftF+A2UmgzFyn0oXxOQ8eBO6ZBPTcx29PCTuqkUVhkJQ21Nm
	oUrN2JNRKPOzutGjMHbpG5ej3Z8iXiWoRUbu4Qt2SjidyviligwyRiy+mb0NjEzQPWbw+vjnkXC
	op6+N09OdWpxbxXJuf1tOsBSlcdDTDrHSAj8RrP6oM/5MoWaI+xos0CZG9sD9zatOZA0HEGgFav
	0E5wI1BHPSmC1dxgqYvmD1Q/DD+MdJBGpK+JDAnQK3bFogc/lGBSMToAbdflCFZVUmGIeOTKVsh
	0b1GidDAeR+HVBdDEAIXkweDCvkzM15eDaqfzHA781yCDcrL7piA+SINSftl9WkwNupCq1qp4R3
	/2GTXdQ/tdcWVyIzJ8w5bNKHdOO9apqUJDcujLqpwOAXf7emGGIa0O4gIU+K06svKPM8PxpxbTD
	aTGkb8nh3idZh4k9dzeaDlqLz1DwoigsOJATBm2kyax2/oaVjoWrH8p80K3bRvDQ==
X-Received: by 2002:a17:90b:4d01:b0:381:528a:808c with SMTP id 98e67ed59e1d1-3931e0fd153mr7752510a91.12.1786642311225;
        Thu, 13 Aug 2026 10:31:51 -0700 (PDT)
Received: from phi.nguyendp ([116.86.160.247])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-31ebc75d8casm10961169eec.3.2026.08.13.10.31.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Aug 2026 10:31:50 -0700 (PDT)
From: Nguyen Dinh Phi <phind.uet@gmail.com>
To: Stefano Garzarella <sgarzare@redhat.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>
Cc: Nguyen Dinh Phi <phind.uet@gmail.com>,
	virtualization@lists.linux.dev,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v6 2/3] vsock: remove the now-unused rejected flag
Date: Fri, 14 Aug 2026 01:30:19 +0800
Message-ID: <20260813173024.2362935-3-phind.uet@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260813173024.2362935-1-phind.uet@gmail.com>
References: <20260813173024.2362935-1-phind.uet@gmail.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

After previous patch, the branch marking a socket rejected in
vsock_accept() is unreachable, and nothing ever sets vsk->rejected
elsewhere.

In fact, since commit d021c344051a ("VSOCK: Introduce VM Sockets"),
where `rejected` was introduced, there has never been a path that sets
sk_err on a listening socket, so that branch has been dead code since
the beginning.

Therefore, we can remove the `rejected` field from vsock_sock structure.

Suggested-by: Stefano Garzarella <sgarzare@redhat.com>
Signed-off-by: Nguyen Dinh Phi <phind.uet@gmail.com>
---
 include/net/af_vsock.h   |  5 +----
 net/vmw_vsock/af_vsock.c | 46 +++++++++++++---------------------------
 2 files changed, 16 insertions(+), 35 deletions(-)

diff --git a/include/net/af_vsock.h b/include/net/af_vsock.h
index 30046a3c20f7..3357ee62d10b 100644
--- a/include/net/af_vsock.h
+++ b/include/net/af_vsock.h
@@ -52,13 +52,10 @@ struct vsock_sock {
 	 * The listening socket is the head for both lists.  Sockets created
 	 * for connection requests are placed in the pending list until they
 	 * are connected, at which point they are put in the accept queue list
-	 * so they can be accepted in accept().  If accept() cannot accept the
-	 * connection, it is marked as rejected so the cleanup function knows
-	 * to clean up the socket.
+	 * so they can be accepted in accept().
 	 */
 	struct list_head pending_links;
 	struct list_head accept_queue;
-	bool rejected;
 	struct delayed_work connect_work;
 	struct delayed_work pending_work;
 	struct delayed_work close_work;
diff --git a/net/vmw_vsock/af_vsock.c b/net/vmw_vsock/af_vsock.c
index 3cd5c3561be3..62e22c4b13c0 100644
--- a/net/vmw_vsock/af_vsock.c
+++ b/net/vmw_vsock/af_vsock.c
@@ -38,10 +38,9 @@
  * pending socket.  When that socket reaches the connected state, it is removed
  * from the listener socket's pending list and enqueued in the listener
  * socket's accept queue.  Callers of accept(2) will accept connected sockets
- * from the listener socket's accept queue.  If the socket cannot be accepted
- * for some reason then it is marked rejected.  Once the connection is
- * accepted, it is owned by the user process and the responsibility for cleanup
- * falls with that user process.
+ * from the listener socket's accept queue. Once the connection is accepted,
+ * it is owned by the user process and the responsibility for cleanup falls
+ * with that user process.
  *
  * - It is possible that these pending sockets will never reach the connected
  * state; in fact, we may never receive another packet after the connection
@@ -49,9 +48,7 @@
  * future, after some amount of time passes where a connection should have been
  * established.  This function ensures that the socket is off all lists so it
  * cannot be retrieved, then drops all references to the socket so it is cleaned
- * up (sock_put() -> sk_free() -> our sk_destruct implementation).  Note this
- * function will also cleanup rejected sockets, those that reach the connected
- * state but leave it before they have been accepted.
+ * up (sock_put() -> sk_free() -> our sk_destruct implementation).
  *
  * - Lock ordering for pending or accept queue sockets is:
  *
@@ -774,11 +771,10 @@ static void vsock_pending_work(struct work_struct *work)
 
 	if (vsock_is_pending(sk)) {
 		vsock_remove_pending(listener, sk);
-	} else if (!vsk->rejected) {
-		/* We are not on the pending list and accept() did not reject
-		 * us, so we must have been accepted by our user process.  We
-		 * just need to drop our references to the sockets and be on
-		 * our way.
+	} else {
+		/* We are not on the pending list so we must have been accepted
+		 * by our user process. We just need to drop our references to
+		 * the sockets and be on our way.
 		 */
 		cleanup = false;
 		goto out;
@@ -942,7 +938,6 @@ static struct sock *__vsock_create(struct net *net,
 	vsk->listener = NULL;
 	INIT_LIST_HEAD(&vsk->pending_links);
 	INIT_LIST_HEAD(&vsk->accept_queue);
-	vsk->rejected = false;
 	vsk->sent_request = false;
 	vsk->ignore_connecting_rst = false;
 	WRITE_ONCE(vsk->peer_shutdown, 0);
@@ -1914,26 +1909,15 @@ static int vsock_accept(struct socket *sock, struct socket *newsock,
 		lock_sock_nested(connected, SINGLE_DEPTH_NESTING);
 		vconnected = vsock_sk(connected);
 
-		/* If the listener socket has received an error, then we should
-		 * reject this socket and return.  Note that we simply mark the
-		 * socket rejected, drop our reference, and let the cleanup
-		 * function handle the cleanup; the fact that we found it in
-		 * the listener's accept queue guarantees that the cleanup
-		 * function hasn't run yet.
-		 */
-		if (err) {
-			vconnected->rejected = true;
-		} else {
-			newsock->state = SS_CONNECTED;
-			sock_graft(connected, newsock);
+		newsock->state = SS_CONNECTED;
+		sock_graft(connected, newsock);
 
-			set_bit(SOCK_CUSTOM_SOCKOPT,
-				&connected->sk_socket->flags);
+		set_bit(SOCK_CUSTOM_SOCKOPT,
+			&connected->sk_socket->flags);
 
-			if (vsock_msgzerocopy_allow(vconnected->transport))
-				set_bit(SOCK_SUPPORT_ZC,
-					&connected->sk_socket->flags);
-		}
+		if (vsock_msgzerocopy_allow(vconnected->transport))
+			set_bit(SOCK_SUPPORT_ZC,
+				&connected->sk_socket->flags);
 
 		release_sock(connected);
 		sock_put(connected);
-- 
2.53.0

