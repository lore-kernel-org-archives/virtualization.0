Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DB87411A04
	for <virtualization@lists.linux.dev>; Fri,  7 Aug 2026 11:48:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786103323; cv=none; b=tRAmGUnHxyyUb6KI5ohyyMLDRMUm9fFEFQGNVUX26lYEzIgP6PbnQrklzMB4St4hvnPXysRrIwefJ1paDg32Ri1JJodwqktRuMvXQd8b2t5A58ISUBo2zEQ+1wF02jAP+lFXLvAixK4Gaa4t2osU74B3guutK1CjnKx5I3/cPns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786103323; c=relaxed/simple;
	bh=dBRcctB1HbE1wp3EANcrd4ceGJoZwfhb665DWjmN70M=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=o4dfIxiYxRr9ycSTZ1Y0X+hKIPOksBjtQZIktLPyqajfDaZsGRSn01cevz3KeNj/Kh4vfYWcNR+nufti+z49Dfp7EcHDfzj4V9/Yepq7+jGKu89hTj7830cH6xm21ol7EmOq91XGlaCyNoXwuCzWaX4a/wLMORTk60Vu++B+UAI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=du7aO6vt; arc=none smtp.client-ip=209.85.215.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="du7aO6vt"
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-cbb8b54fcf8so2998882a12.0
        for <virtualization@lists.linux.dev>; Fri, 07 Aug 2026 04:48:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786103309; x=1786708109; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=n7mwOnPyfiCCwq729LgAnh/HsggJnMmpUOleEikcENM=;
        b=du7aO6vtFtsbxE7TlAbRFC9dDM4120CGTEV/kb7JaLNLNlnAS92jAmltoRriD7dPZf
         AQoQ/stQ5m1lHvHP8wFz2Y8twQ4Vij88UEXxNIyLG6865gbtJNWFvqiq7MAtiqJr0zpa
         O6dfY9gNU993EwRpxurq5hcVRc3SDoFALg+ZIW0arBab+5nVnIDEUjz39q8kZ24h+svE
         vcay3KrHdEQHAO8es1jXrOqV0wosSYBrxxvG+ujXEr5+EzN0F+hCLMH69zYiiBycrIPA
         JwRe80Bgn6+4eODeK3ESIc5TCtkYUYtqS2Rc5e650hphpweWn1SaWN9tnAymkrclVtdj
         tjCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786103309; x=1786708109;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=n7mwOnPyfiCCwq729LgAnh/HsggJnMmpUOleEikcENM=;
        b=G7SDJOlSNDFTY4raozIPDByN8IUhc2nkb0jNpmCdhX6p4ehlcDK/fJLFDfh0Zi2nHu
         Ux5fXCCimKL2lAZ1HHr44fRs4g9zzAkSJ7Q+zopwakjyezxiat4lUOHYJx3syg9dFSwh
         7BI9DojBRfPuUvLquXRyT8oGWinrTdek7gcepSFCV0RPH6L554qtLvCymQhmhKScns4I
         dYurIZ5z2FcXns/ZXH/peWsNtye7viT58FeDTO5Anl2ycXIxSuselnBs1FTAPgUPvnwk
         uSdwXy9m+p4CjefH3YdmokwJ4LPw2sKXhj4H+XQtZMSQH2wqDRNBnouIjF0MgX5xGgLz
         IKwA==
X-Forwarded-Encrypted: i=1; AHgh+RrEh3Owz1rVBMPd+iq1Syh2UcYgNWlvwTCHcZwt1CNx1WAiMZoNdy99qMFAtGSFpeO5pDb2WL22uzU9rvqw8Q==@lists.linux.dev
X-Gm-Message-State: AOJu0YzyxJHWs63ptvCkoCLib5SjLNXmsyK5MrKzBqYZQqJM39N9zTMk
	UXDz1E+5Oa/T8FnzqRBTea33qO/2edNN2txdQOD77zVnH83GI1S00pzN
X-Gm-Gg: AR+sD135QXboi2DPqkk/IUigN+hXCia5VbDbM4+u53VRSZn0OqT/HuW56Hf/uUV+b+Z
	DaRRklznQRqzSz9CWvVj9FJMGe3q8cKgRQ8JduRbfRVLPIcF/Ns9qcgdnq+xOnps+T6EgOEqwe1
	p2M4hnf7pN28o2F8RB4uWyCsLMOaJM9Ashg8qVIvHrsSehe3VxHfHL05W84do1KpFvGGPHy9mvZ
	5y8vDcV7+J5NptPfeBGgc7K/Mv9sQdafop8DTlXrBl71jxL5YsamJMKPzKN2uVuqPSPEjPSK8m1
	3dTh801v3hz1uR1vJkcp/0wk928r0wRe+XJM05wGnCtFPjls9HNoKU/FX51moenmue0Bt/rus57
	x6q0f5yvl3deFmPYWEmZxXqXA4ls39z+XIsPmcq3R+L3R3ER7E9Hwyhv+cbhbkplsCXsATtJ+VP
	8HH/DPfkmyFn2iuVApO+UifvitFIYvNO8Vohm0Ua8FNZ8su5yohZdjzoQK9fLaUJ9tOvZV7PTkx
	A==
X-Received: by 2002:a05:6a20:3d1a:b0:3c3:719d:dfe2 with SMTP id adf61e73a8af0-3cb85f4e179mr25112695637.36.1786103308527;
        Fri, 07 Aug 2026 04:48:28 -0700 (PDT)
Received: from amd.ban-spse ([165.204.217.251])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-315be86fc7bsm7011180eec.1.2026.08.07.04.48.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Aug 2026 04:48:28 -0700 (PDT)
From: Chaithanya Lagisetty <nagachaithanya9911@gmail.com>
To: Stefano Garzarella <sgarzare@redhat.com>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>,
	"Michael S . Tsirkin" <mst@redhat.com>,
	Claudio Imbrenda <imbrenda@linux.vnet.ibm.com>,
	Asias He <asias@redhat.com>,
	Stefan Hajnoczi <stefanha@redhat.com>,
	virtualization@lists.linux.dev,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Chaithanya Lagisetty <nagachaithanya9911@gmail.com>,
	syzbot+53515d23498d641e21ea@syzkaller.appspotmail.com
Subject: [PATCH] vsock: fix memory leak of rejected child sockets in vsock_accept()
Date: Fri,  7 Aug 2026 11:48:04 +0000
Message-ID: <20260807114804.320862-1-nagachaithanya9911@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When a listener socket carries an error (e.g. sk_err set by a connect()
issued on the socket before listen()), vsock_accept() dequeues the child
from the accept queue but rejects it. Previously it only marked the child
as rejected and relied on vsock_pending_work() to clean it up. However,
rejected child sockets created through virtio_transport and vsock_loopback
never reach that cleanup path, causing the child socket, along with its
LSM blob and transport-specific state, to leak permanently.

Fix this by releasing the child's references directly in vsock_accept()
on the reject path: remove it from the connected table and drop the
references taken by sk_alloc(), __vsock_insert_connected() and
vsock_enqueue_accept(), so the socket reaches vsock_sk_destruct() and is
freed. The now-unused 'rejected' flag and its handling in
vsock_pending_work() are removed.

Fixes: 06a8fc78367d ("VSOCK: Introduce virtio_vsock_common.ko")
Reported-by: syzbot+53515d23498d641e21ea@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=53515d23498d641e21ea
Signed-off-by: Chaithanya Lagisetty <nagachaithanya9911@gmail.com>
---
 include/net/af_vsock.h   |  4 +---
 net/vmw_vsock/af_vsock.c | 38 ++++++++++++++++++++------------------
 2 files changed, 21 insertions(+), 21 deletions(-)

diff --git a/include/net/af_vsock.h b/include/net/af_vsock.h
index 30046a3c20f7..b70cea7f754f 100644
--- a/include/net/af_vsock.h
+++ b/include/net/af_vsock.h
@@ -53,12 +53,10 @@ struct vsock_sock {
 	 * for connection requests are placed in the pending list until they
 	 * are connected, at which point they are put in the accept queue list
 	 * so they can be accepted in accept().  If accept() cannot accept the
-	 * connection, it is marked as rejected so the cleanup function knows
-	 * to clean up the socket.
+	 * connection, the child is cleaned up directly in vsock_accept().
 	 */
 	struct list_head pending_links;
 	struct list_head accept_queue;
-	bool rejected;
 	struct delayed_work connect_work;
 	struct delayed_work pending_work;
 	struct delayed_work close_work;
diff --git a/net/vmw_vsock/af_vsock.c b/net/vmw_vsock/af_vsock.c
index 622dbd046799..2084c88ac836 100644
--- a/net/vmw_vsock/af_vsock.c
+++ b/net/vmw_vsock/af_vsock.c
@@ -39,9 +39,9 @@
  * from the listener socket's pending list and enqueued in the listener
  * socket's accept queue.  Callers of accept(2) will accept connected sockets
  * from the listener socket's accept queue.  If the socket cannot be accepted
- * for some reason then it is marked rejected.  Once the connection is
- * accepted, it is owned by the user process and the responsibility for cleanup
- * falls with that user process.
+ * for some reason then it is cleaned up directly in vsock_accept().  Once the
+ * connection is accepted, it is owned by the user process and the
+ * responsibility for cleanup falls with that user process.
  *
  * - It is possible that these pending sockets will never reach the connected
  * state; in fact, we may never receive another packet after the connection
@@ -49,9 +49,7 @@
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
@@ -774,11 +772,11 @@ static void vsock_pending_work(struct work_struct *work)
 
 	if (vsock_is_pending(sk)) {
 		vsock_remove_pending(listener, sk);
-	} else if (!vsk->rejected) {
-		/* We are not on the pending list and accept() did not reject
-		 * us, so we must have been accepted by our user process.  We
-		 * just need to drop our references to the sockets and be on
-		 * our way.
+	} else {
+		/* We are not on the pending list, so we must have been accepted
+		 * by our user process (rejected sockets are cleaned up directly
+		 * in vsock_accept()).  We just need to drop our references to
+		 * the sockets and be on our way.
 		 */
 		cleanup = false;
 		goto out;
@@ -942,7 +940,6 @@ static struct sock *__vsock_create(struct net *net,
 	vsk->listener = NULL;
 	INIT_LIST_HEAD(&vsk->pending_links);
 	INIT_LIST_HEAD(&vsk->accept_queue);
-	vsk->rejected = false;
 	vsk->sent_request = false;
 	vsk->ignore_connecting_rst = false;
 	WRITE_ONCE(vsk->peer_shutdown, 0);
@@ -1919,14 +1916,19 @@ static int vsock_accept(struct socket *sock, struct socket *newsock,
 		vconnected = vsock_sk(connected);
 
 		/* If the listener socket has received an error, then we should
-		 * reject this socket and return.  Note that we simply mark the
-		 * socket rejected, drop our reference, and let the cleanup
-		 * function handle the cleanup; the fact that we found it in
-		 * the listener's accept queue guarantees that the cleanup
-		 * function hasn't run yet.
+		 * reject this socket and return.  The child was found on the
+		 * listener's accept queue, so it still holds the references
+		 * taken by sk_alloc(), __vsock_insert_connected() and
+		 * vsock_enqueue_accept().  Drop them here so the socket is
+		 * destroyed.  We cannot defer this to vsock_pending_work():
+		 * rejected child sockets created through virtio_transport and
+		 * vsock_loopback are not cleaned up by that worker, so the
+		 * child would otherwise leak permanently.
 		 */
 		if (err) {
-			vconnected->rejected = true;
+			vsock_remove_connected(vconnected);
+			connected->sk_state = TCP_CLOSE;
+			sock_put(connected);
 		} else {
 			newsock->state = SS_CONNECTED;
 			sock_graft(connected, newsock);
-- 
2.43.0

