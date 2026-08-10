Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EB5142F6FF
	for <virtualization@lists.linux.dev>; Mon, 10 Aug 2026 17:10:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786381853; cv=none; b=hZ4RqSm6bINYZi/TrMzW11WsujTOuGzjYAizLfZp/bzr/d/DZA4soVsdYXxXE3CaRdFMzdeWOijIIiDhGtpSd8WSczDuKr1ZQQuu6h/9qrg2a9wKSK9/0fxBewmfmtrUMOms3k17Ix8KlClsecM/0cX1RHOix7MAdXpkXH927f8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786381853; c=relaxed/simple;
	bh=UG8CVmhUiNXkcyAixv/sxJGkEM5W+KEMJZCoNAJk8ho=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bGrNixc2ZJjYa4aR6R9x2lblNO9sRK6T+XgVtgEBCsQxCerODuFKDhBvri1SCyZxeOE2ouRIyVUW8BA0WxZGdBOm2F+vElLgDc9OxNharpAECRNSKnb+p56JAMBxrDdmOkEku04T7snkxJpEcfD1N5Jg87M4IN/rdWgQNAxssVA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SJYHwv2J; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SJYHwv2J"
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-38e3efab7e0so130767a91.0
        for <virtualization@lists.linux.dev>; Mon, 10 Aug 2026 10:10:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786381852; x=1786986652; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=HIzXZz56o+MmOQNy7Jnj/dfQQWOM2HS0FnwvviI6E/Y=;
        b=SJYHwv2JWnYQaWo1jQHgP6di6UzcjYq61UPE1JHT2X8mlTZRGcwjpoxbTCpwui41cK
         i+L2x/9zEVG5gWz1RDdKCPJuxycMmMBiPeqJeNxK8AjPtYtWo7PZucqsH9Nv5DPfKTUM
         tKkNr8fMJhdWUIuGvvkaqaIxaEBalsedFRSOh9HaNMAhyaGHzG2wtKKSlR1tQH5f6lQN
         iGfnioXVXKrdfF2/xibjzA8RKq6Xo/ShHveKEg6FVn3l/GexgzEh9GTI7aRn8G99NIYW
         TfZKUTog5UZuv4cS7SraWZoKxiNpqSpGjb7f3QcbCc+vOUr6HTYLJC6YuiXI2MD7GVt4
         fDJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786381852; x=1786986652;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=HIzXZz56o+MmOQNy7Jnj/dfQQWOM2HS0FnwvviI6E/Y=;
        b=UhsByRdtHR9gvvNq70IAkiq+Aa+/IdxAzgAMlLwL5iWCNLVLT2JqJgulKtRLg6hYIn
         Xw3BhwaVP6aI3aUt/2VZMgf8SnU5qX413YxT72UnfY13qY/MU9Zv2wY02nI3ugZGLtew
         qDdW1K1/+ePbP/mpccxugcSrhXt8DSm6G0Oyx7ZBARmkhdwS9fLady12Rxt+cGZaiKTJ
         brMi4De/XqnzkF/8vePpI4RMAPw5IVFbB8gYdW2zlvDLYXKGZIC9BZlXm9YwDKn5hhts
         oHK7S7Hg2I59HlK0zKSt36L0LHDOJy2pqs8ZCVqxO1nN2mkDY4WDFKgRZQQnfiVJZDhs
         2ODA==
X-Forwarded-Encrypted: i=1; AHgh+RrIF48rR0+nxnsD6ziQZT8TxOH4F7zjgWPvUh9cTIDKzBMFhnDsd4rE5zfJXkGSDSZgZzWYz4qZVUJb0pCRkg==@lists.linux.dev
X-Gm-Message-State: AOJu0Yxp7dGHId37Bfvl55U0powW95VpnH/oKWg/T8YFJWoy+MCZ74tZ
	/Kukw68f23s6B+txb6mfCWvm1uOegs+zkr+KNqqpBIoi2yQpAWlQ++ma
X-Gm-Gg: AR+sD11ige8ibUgZrnLQS6rhvT3eJu2ZApZGeRyMjec2ibwANjpPpPo80RrrybNuPqb
	0wDWw/1BQ5s8b5l4RzZIAvphl/OAtLGJmnAiQyfeXETqTAYxeyfkA7Gt/eMyqOqjxe5ruDz5+PC
	API2L81WJbBh8mK2IlGFAzk7PagCrMvXIWQrE5Os538LwDpqxzcUavdeutGYZJi4OSZfV99NxEE
	tp+wWddgLYqYkwvNjyZkLFcPajut6QV2zBpwBoYFrqBQmoe7piKQk5OIHbXuYZAyiPNS2w/5Srw
	Av1r9FsSWiDGK1zEf190y/gkrxXNrNdt8Ub/FQOKFuKIO8W9OfG0SCFEJ/heQvSlaOp+QucaYn4
	BqsmkUUwtf2DiAoqM+S/GwGVBZc4nx3OpKla7284mG8JC2ou2pr/H3GdYyi5iI4FOpSVJbiGN4D
	v59idH8ofrPKpolcPOS9fTQKUwKPaFUESmxmvRCYHCWbEgK5jywdEoH7UFRLKFQQ==
X-Received: by 2002:a17:90b:4c42:b0:38f:cab0:9aa9 with SMTP id 98e67ed59e1d1-39284703808mr10229761a91.13.1786381851592;
        Mon, 10 Aug 2026 10:10:51 -0700 (PDT)
Received: from phi.nguyendp ([116.86.160.247])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1410199cf49sm37194663c88.3.2026.08.10.10.10.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Aug 2026 10:10:50 -0700 (PDT)
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
Subject: [PATCH v5 2/3] vsock: remove the now-unused rejected flag
Date: Tue, 11 Aug 2026 01:09:31 +0800
Message-ID: <20260810170935.2242314-3-phind.uet@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260810170935.2242314-1-phind.uet@gmail.com>
References: <20260810170935.2242314-1-phind.uet@gmail.com>
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
index ff507761f472..b59890bbd217 100644
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
@@ -1912,26 +1907,15 @@ static int vsock_accept(struct socket *sock, struct socket *newsock,
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

