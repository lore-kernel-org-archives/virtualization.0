Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=165.173.180.15
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793170364;
	b=GsF0AeQdx2qyqhM0BpCz5IP/cl2qqOZxzKO/plLZSbEPwnSKKhUDMpdQpFnSixID0WlP
	 YyTwWBRYVgDzy8VvKpCKzYVGyMpnEMt8sNQGvz+h4o7NBtRYaA2uw2D6Xj8drCSuYTJkK
	 YVQ4I/9SUXB0ST2CbbVLfd/WbmAUEk/5HERSybPK86ckGWvr8UYnPV7+KEaP7klUIHSsh
	 ENvOsHK4n+tI7jt0hebYVdSWVgmprwK5cj5sr3l/c+H52QJrvQsNyBFYBb1t+PfILCuR4
	 HQBmelDIlHALOlfyR0oI09eGtYJCUqHGjdRFyo6TpASwHWItxbVaCMcjohL2/CROnUA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793170364;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=Lzr9r/kB9PGsjX+/QhWa77JRthkHZLmh08VLPaFIXyw=;
	b=BExslPz28HlrDXqjmij0Tz0WtO6EbCFz18Wsi5/1nTRR1QwRbxGAiWmP4BAWFKfFYwMe
	 WfIXcjKXFehZehTqObb/DzItXP5JAVXyS8zyuvBrM5RaYc56oGkPIw+fVSW2+paXrIORd
	 yMvSBtRlACbq9qrLhdgG+n1jNhas59Re+NMSN3Sz4dlFRUdhrCUcgSiySH7qNWBnYaoF+
	 rhr/NJoUU0JWy0fEwrAflPqAW99zd/nmaeHD2dnAw491G/CwtVYy9rsPGe3jL5bcyCYX7
	 z+uNN1cN8i5x9OaNMaV6sCuEZiR2Zir4agCppv29b6BE9JOenN1ClEk4q/BYr53bWlw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=ikuyo.dev;
	spf=pass smtp.mailfrom=ikuyo.dev;
	dkim=pass header.d=ikuyo.dev header.i=eritque-arcus@ikuyo.dev header.a=rsa-sha256 header.s=zmail header.b=VXlWZuyn;
	arc=pass header.oldest-pass=0 smtp.remote-ip=165.173.180.15
Received: from sender6-op-o15.zoho.com (sender6-op-o15.zoho.com [165.173.180.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E7E6606A31A
	for <virtualization@lists.linux.dev>; Wed, 28 Oct 2026 06:52:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8E7E6606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ikuyo.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ikuyo.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=ikuyo.dev header.i=eritque-arcus@ikuyo.dev header.a=rsa-sha256 header.s=zmail header.b=VXlWZuyn
ARC-Seal: i=1; a=rsa-sha256; t=1793170355; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=HT1Xz+ofkMStnXESpgd/h0Uo2sePaeKv9eWHFat0YifYx+Qhb3A7jwcyfZo9DCXbDid2LoUoe7DVEaJUlDPaPZAds8nj2I8quTMHikCOVbAdj8Lwn048z2ewgg6IlSPo4g7aB1cru21w1IrT+/cw+8v6CgAyq3b8zRJQfd+yVAk=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1793170355; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=Lzr9r/kB9PGsjX+/QhWa77JRthkHZLmh08VLPaFIXyw=; 
	b=Sw1lLQ0dAkpUN4R3uHTrsZ2K1OnmsKIQOyPqWD3GxCAlVu85s0EfrTVmCY4u1cxOow9cOcatBLpjPvGlNi+AkXudIgWXqpPGHJFrOGQJ41vuDtVJdcW5eQKyNFlmLlqCQBUCWfC14irTprcJl4P017TZqtrLD/HBjuIZT5TxuaE=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=ikuyo.dev;
	spf=pass  smtp.mailfrom=eritque-arcus@ikuyo.dev;
	dmarc=pass header.from=<eritque-arcus@ikuyo.dev>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1793170355;
	s=zmail; d=ikuyo.dev; i=eritque-arcus@ikuyo.dev;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:MIME-Version:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=Lzr9r/kB9PGsjX+/QhWa77JRthkHZLmh08VLPaFIXyw=;
	b=VXlWZuynhRqZ9ap4ImqLVuWEMW+kDdyouUFeDEmZ3D+qwOxLVkAvFMtoDZ1m1Oi2
	Jq9oVzyMNKnLzunyCQD1e/TjbcWyrFGY1lzExXOeQlkdBhHs7NgyZXLraLmn07o/Bye
	FbtsAJU3Nhd8Rj4t5ZckKK1PWff53tVxnVO+3b8A=
Received: by smtp.zohomail.com with SMTPS id 1793170353223347.53982264335957;
	Tue, 27 Oct 2026 23:52:33 -0700 (PDT)
From: Yiran Qiu <eritque-arcus@ikuyo.dev>
To: Stefano Garzarella <sgarzare@redhat.com>
Cc: Bobby Eshleman <bobbyeshleman@meta.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Stefan Hajnoczi <stefanha@redhat.com>,
	virtualization@lists.linux.dev,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH RFC net] vsock: make local-transport CIDs conflict on the same port
Date: Wed, 28 Oct 2026 02:52:31 -0400
Message-ID: <20261028065231.655701-1-eritque-arcus@ikuyo.dev>
X-Mailer: git-send-email 2.56.0
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The local transport serves VMADDR_CID_LOCAL and the guest->host
transport's CID (VMADDR_CID_HOST if there is none), and sends every
packet with source CID VMADDR_CID_LOCAL.  A port bound on either CID is
therefore one port on the wire, but the bind conflict check compares
full addresses, so (guest_cid, P) and (VMADDR_CID_LOCAL, P) can both be
bound.  Because __vsock_find_connected_socket_net() compares only the
destination port (deliberately, since 990454b5a48b), a child accepted
on one CID then matches packets addressed to the other.
vsock_check_source() already treats these CIDs as aliases
(dee44f41f206); bind() does not.

An unprivileged process can use this to reset another process's
connect() when that client is bound to a specific local CID.  Comparing
the destination CID in the lookup instead turns the reset into data
injection, as vsock_check_source() accepts the rewritten source CID.

Reject a bind whose port is already held on another local-transport
CID.  User-visible change: a guest can no longer serve the host on
(guest_cid, P) and local clients on (VMADDR_CID_LOCAL, P) at once; the
second bind fails with EADDRINUSE.

Found with afb-afl, an LLM-driven kernel audit/repro pipeline; the fix
and this changelog were also drafted with LLM assistance.

Fixes: 408624af4c89 ("vsock: use local transport when it is loaded")
Signed-off-by: Yiran Qiu <eritque-arcus@ikuyo.dev>
---
Tested on net/main 4dca97647a3e (vsock unchanged through net/main
5d7f3375cd57 and mainline 65ba8f34ec88) in a QEMU/KVM guest with
vhost-vsock (guest CID 3) and vsock_loopback; 3 runs per case:

  case                                  before      after
  peer on (LOCAL, P), attacker listener ECONNRESET  attacker bind fails,
                                                    victim connects
  same, attacker at another uid         ECONNRESET  victim connects
  peer on (ANY, P), no attacker listen. ECONNRESET  victim connects
  no attacker                           connects    connects

With only a destination-CID compare instead: no reset, but the victim
read 18 attacker bytes (3/3).  vsock_test 44/44 with --peer-cid=1 and 3,
before and after; no WARN/BUG (KASAN off).  Not tested: VMCI, the
host-side alias.  RFC: bind time vs. lookup is your call.  Reproducer
available on request.

 net/vmw_vsock/af_vsock.c | 63 +++++++++++++++++++++++++++++++++++++++++++-----
 1 file changed, 57 insertions(+), 6 deletions(-)

diff --git a/net/vmw_vsock/af_vsock.c b/net/vmw_vsock/af_vsock.c
index d0508887a2fb..47fd00fdac6d 100644
--- a/net/vmw_vsock/af_vsock.c
+++ b/net/vmw_vsock/af_vsock.c
@@ -294,8 +294,31 @@ static void __vsock_remove_connected(struct vsock_sock *vsk)
 	sock_put(&vsk->sk);
 }
 
+/*
+ * CIDs served by the local transport are aliases of one another on the wire:
+ * an outgoing packet uses transport->get_local_cid() as its source CID, no
+ * matter which of those CIDs the socket was bound to.  Two binds of the same
+ * port on different local CIDs therefore reach the same peer and must
+ * conflict, just like a VMADDR_CID_ANY bind conflicts with any CID.
+ *
+ * @local_cid is the second local CID (the guest->host transport's own CID, or
+ * VMADDR_CID_HOST when there is no guest->host transport), or
+ * VMADDR_CID_ANY when the local transport is not loaded.
+ */
+static bool vsock_addr_aliases_local(const struct sockaddr_vm *a,
+				     const struct sockaddr_vm *b,
+				     u32 local_cid)
+{
+	return local_cid != VMADDR_CID_ANY &&
+	       a->svm_port == b->svm_port &&
+	       a->svm_cid != b->svm_cid &&
+	       (a->svm_cid == VMADDR_CID_LOCAL || a->svm_cid == local_cid) &&
+	       (b->svm_cid == VMADDR_CID_LOCAL || b->svm_cid == local_cid);
+}
+
 static struct sock *__vsock_find_bound_socket_net(struct sockaddr_vm *addr,
-						  struct net *net)
+						  struct net *net,
+						  u32 local_cid)
 {
 	struct vsock_sock *vsk;
 
@@ -311,6 +334,10 @@ static struct sock *__vsock_find_bound_socket_net(struct sockaddr_vm *addr,
 		     addr->svm_cid == VMADDR_CID_ANY) &&
 		     vsock_net_check_mode(sock_net(sk), net))
 			return sk;
+
+		if (vsock_addr_aliases_local(addr, &vsk->local_addr, local_cid) &&
+		    vsock_net_check_mode(sock_net(sk), net))
+			return sk;
 	}
 
 	return NULL;
@@ -383,7 +410,7 @@ struct sock *vsock_find_bound_socket_net(struct sockaddr_vm *addr,
 	struct sock *sk;
 
 	spin_lock_bh(&vsock_table_lock);
-	sk = __vsock_find_bound_socket_net(addr, net);
+	sk = __vsock_find_bound_socket_net(addr, net, VMADDR_CID_ANY);
 	if (sk)
 		sock_hold(sk);
 
@@ -727,6 +754,27 @@ static u32 vsock_registered_transport_cid(const struct vsock_transport **transpo
 	return cid;
 }
 
+/*
+ * Return the CID that the local transport aliases with VMADDR_CID_LOCAL, or
+ * VMADDR_CID_ANY when the local transport is not loaded or has no second CID.
+ * Must be called before taking vsock_table_lock.
+ */
+static u32 vsock_local_alias_cid(void)
+{
+	u32 cid = VMADDR_CID_ANY;
+
+	mutex_lock(&vsock_register_mutex);
+	if (transport_local) {
+		if (transport_g2h)
+			cid = transport_g2h->get_local_cid();
+		else
+			cid = VMADDR_CID_HOST;
+	}
+	mutex_unlock(&vsock_register_mutex);
+
+	return cid;
+}
+
 bool vsock_find_cid(unsigned int cid)
 {
 	if (cid == vsock_registered_transport_cid(&transport_g2h))
@@ -833,7 +881,8 @@ static void vsock_pending_work(struct work_struct *work)
 /**** SOCKET OPERATIONS ****/
 
 static int __vsock_bind_connectible(struct vsock_sock *vsk,
-				    struct sockaddr_vm *addr)
+				    struct sockaddr_vm *addr,
+				    u32 local_cid)
 {
 	struct net *net = sock_net(sk_vsock(vsk));
 	struct sockaddr_vm new_addr;
@@ -854,7 +903,7 @@ static int __vsock_bind_connectible(struct vsock_sock *vsk,
 
 			new_addr.svm_port = net->vsock.port++;
 
-			if (!__vsock_find_bound_socket_net(&new_addr, net)) {
+			if (!__vsock_find_bound_socket_net(&new_addr, net, local_cid)) {
 				found = true;
 				break;
 			}
@@ -871,7 +920,7 @@ static int __vsock_bind_connectible(struct vsock_sock *vsk,
 			return -EACCES;
 		}
 
-		if (__vsock_find_bound_socket_net(&new_addr, net))
+		if (__vsock_find_bound_socket_net(&new_addr, net, local_cid))
 			return -EADDRINUSE;
 	}
 
@@ -897,6 +946,7 @@ static int __vsock_bind_dgram(struct vsock_sock *vsk,
 static int __vsock_bind(struct sock *sk, struct sockaddr_vm *addr)
 {
 	struct vsock_sock *vsk = vsock_sk(sk);
+	u32 local_cid;
 	int retval;
 
 	/* First ensure this socket isn't already bound. */
@@ -914,8 +964,9 @@ static int __vsock_bind(struct sock *sk, struct sockaddr_vm *addr)
 	switch (sk->sk_socket->type) {
 	case SOCK_STREAM:
 	case SOCK_SEQPACKET:
+		local_cid = vsock_local_alias_cid();
 		spin_lock_bh(&vsock_table_lock);
-		retval = __vsock_bind_connectible(vsk, addr);
+		retval = __vsock_bind_connectible(vsk, addr, local_cid);
 		spin_unlock_bh(&vsock_table_lock);
 		break;
 
-- 
2.56.0

