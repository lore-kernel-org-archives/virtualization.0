Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E320E22A80D
	for <virtualization@lists.linux.dev>; Wed, 26 Aug 2026 00:40:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787704806; cv=none; b=YQ3VbwRPE5RDlnTOryIfe9ojGZZqHDrlM9OPXYGp1opZbAj3BQBKBsuc3FY+1YVfqqOY09HD0vOm48M6VMUkKm4bNv/2+Ruk28df4cUdxofgiweToXjiDJ0HRvkg868tC6VSpRTjOWLNekR6kTGgAnq/utBNZw0ZSSZ/lAPrDRQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787704806; c=relaxed/simple;
	bh=QX/vn9JHBDF1P5ti7air7BXUMt6TE73hYnNrwXMaVVM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dXY1jQmn9VLTNsUIf6Zo8BX83J+cGJL9IK1iX4gnupGhfD4SfSvVUJJWu7q+Lp55/3E9+4ADB11mzYcT5UN9AwHFZw//P0zpPdo5cGPsctUdMyN2fQS/zMGf4uiCeoxVApmzGESOSqB0dzcj8Coqp6NfsN265z9d1NoJePHvWJc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GwfPKetd; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GwfPKetd"
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-84f38f3b36eso401717b3a.1
        for <virtualization@lists.linux.dev>; Tue, 25 Aug 2026 17:40:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787704804; x=1788309604; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=a/eP+e7q3408itBdeYjBe53xJJY4zYLdPkL6W0uiwF0=;
        b=GwfPKetdUSLpTP35bhs2MRDSSDJEwPAFHvxZbehENEHERQDna/2DQypuzfU3nVUBD/
         EP9A+xev+4av1xnMo57bqR8sk1l6JaczZbpetpc0D+DqvccB5s9S1dVY5O77G5MaRnVp
         fxlSiBzvIAG2E5oGl0ihauwzNc/5FesCBYc4/vYtHbKkKlfjAaV3TKddVNs1x51oJQr4
         4ewirwPmXvym9+W2g19uAa4y0jrrrcYwZ4XdYg+sqiAMdaj4wci/krJ7Qjcmnm58+HXY
         Y84+/ofzogfv+i+5Z78FEsR/Y8inAWJ9GeWUMzyYgtXgfB2s/5H+VR9q+8fUK9aslZ+C
         y/Jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787704804; x=1788309604;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=a/eP+e7q3408itBdeYjBe53xJJY4zYLdPkL6W0uiwF0=;
        b=oCDZb6JfTZl0+1iinvsst/+BvVcXhFCEZdN9WS5qx1XNJXoXabjUNXeC6nEX+Mqd9X
         u7a+W6w8tSSMg2tyrtC3wHP+HVmO0bowWwPIK+LJjS3aEg7tjMjxWvKwHpS11JUI/p1e
         7Swl4aDb1gQ2/MibszXS20XQKB9zsg8pIcxuGVPBWb/xlqxaDbNaU+K4n2g4hNK70CfF
         EC6WSbRAoSY9gJxHnxbI7XIzgaPA0RL9qJ3BICIHee/JVJz1lNxwb5zwzpQW7bVBcgOv
         vLG/5KJELz+K/oFed+3gbWvb1IAUllIqeeLe2kXSO2xGeMvXQ8Jo+CJ8bvcPVnJO/yj4
         ZXmw==
X-Forwarded-Encrypted: i=1; AHgh+Rp3C08u1cOSZ4RQra8u0jauPEt6Td0Y9tNwQ84wD/+xiXeSVkkeurHjwqoVaelM7JIOmEOgPgaRE4qzmylHzg==@lists.linux.dev
X-Gm-Message-State: AFuF++n5E6XRKKXSCE91IrbdMw6FPI4CMWGuKO2Jc5kPsq4ZdOgbucn3
	yS39wRugJXqwbdL9y+tbuKFxFATFuXXX7Im925gOlcpEQ70Rla/IKr7S
X-Gm-Gg: AR+sD13TA6r2x0/CIVKf8qoPAoRiinKPf+CyIaf9UzQh09g7fxKyCPl41uDEyLfYNW+
	AE/pjJ4ApW6an2jBEWsDqIik2Lkc3yBsB6ebWK0NngIkojooK0k+APSRFWG574BcFW9achgeV5F
	NVfh+8FO2tYkibzNO2iLtWQ2jJm9m7ReLlI7F97+wTpZjN4pcIwctay+DVYuqWX6jSlkc6DgJQ/
	6zjotxJqBBfcJwvaPwQTSsdTgUNYRsjTKUeSy17VIDXTmTP3swDdV7TllU/PW+QD30zAbTyG8vD
	erCNh83SuWHo0hbzDCpFBwwZB6XL0CACsHsDIaTIxIuh2xpxo+EqqSfuFldu30Ppi2jVvXk2PMR
	brhJLvVw6xz+3BVD3U3ZrgujXZ81HwzZvdzNpP1PzeGfkNtTadmw8TRTN/MchyfVEfMAYoqG+5m
	x7SKn050XVQIWvUm1eRM42fkDlYDVwDr3lNyIwFbmkBf+JRFmT82QRMNbKe3rj60a867/7vl2n
X-Received: by 2002:a05:6a00:4f92:b0:848:2e3c:9955 with SMTP id d2e1a72fcca58-85371fa599amr4496713b3a.4.1787704804199;
        Tue, 25 Aug 2026 17:40:04 -0700 (PDT)
Received: from ancienth-X870E-Nova-WiFi ([125.186.72.2])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8535cdc038dsm339377b3a.38.2026.08.25.17.39.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Aug 2026 17:40:03 -0700 (PDT)
From: Daehyeon Ko <4ncienth@gmail.com>
To: netdev@vger.kernel.org
Cc: sgarzare@redhat.com,
	stefanha@redhat.com,
	bobbyeshleman@gmail.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	mst@redhat.com,
	jasowangio@gmail.com,
	xuanzhuo@linux.alibaba.com,
	eperezma@redhat.com,
	bryan-bt.tan@broadcom.com,
	vishnu.dasa@broadcom.com,
	bcm-kernel-feedback-list@broadcom.com,
	virtualization@lists.linux.dev,
	kvm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net v4 1/2] vsock/virtio: validate packet source for connected sockets
Date: Wed, 26 Aug 2026 09:39:27 +0900
Message-ID: <20260826003929.966160-2-4ncienth@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260826003929.966160-1-4ncienth@gmail.com>
References: <20260826003929.966160-1-4ncienth@gmail.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

virtio_transport_recv_pkt() looks up sockets first by the full source and
destination tuple, then by destination only in the bound table. The
fallback is needed for listening and connecting sockets, but sockets remain
in the bound table after connect(), so it can also return a non-listening
socket.

The fallback does not validate the source address. In TCP_SYN_SENT, a
RESPONSE from an unrelated source can transition the victim socket to
TCP_ESTABLISHED while its stored remote address remains unchanged.
Subsequent RW packets from that source are delivered through the same
destination-only fallback.

This was reproduced with capability-empty processes under different UIDs.
The attacker discovered the target tuple through unprivileged AF_VSOCK
sock_diag and caused the victim socket to read 16 attacker-chosen bytes;
the intended peer-side socket read 0 of those 16 bytes.

Add vsock_check_source() to validate the transport, source port and source
CID against the peer stored in a non-listening socket. The local transport
is the CID exception because its packets are generated internally with
VMADDR_CID_LOCAL as their source, including connections using CID aliases.

Use the helper after lock_sock() in the virtio receive path.

Fixes: 06a8fc78367d ("VSOCK: Introduce virtio_vsock_common.ko")
Closes: https://lore.kernel.org/netdev/20260813121236.2328599-1-4ncienth@gmail.com/
Cc: stable@vger.kernel.org
Suggested-by: Stefano Garzarella <sgarzare@redhat.com>
Reviewed-by: Bobby Eshleman <bobbyeshleman@meta.com>
Assisted-by: Codex:gpt-5.6-sol
Signed-off-by: Daehyeon Ko <4ncienth@gmail.com>
---
 include/net/af_vsock.h                  |  3 +++
 net/vmw_vsock/af_vsock.c                | 32 +++++++++++++++++++++++++
 net/vmw_vsock/virtio_transport_common.c |  3 ++-
 3 files changed, 37 insertions(+), 1 deletion(-)

diff --git a/include/net/af_vsock.h b/include/net/af_vsock.h
index 3357ee62d..5549298c1 100644
--- a/include/net/af_vsock.h
+++ b/include/net/af_vsock.h
@@ -229,6 +229,9 @@ struct sock *vsock_find_bound_socket_net(struct sockaddr_vm *addr,
 struct sock *vsock_find_connected_socket_net(struct sockaddr_vm *src,
 					     struct sockaddr_vm *dst,
 					     struct net *net);
+bool vsock_check_source(const struct vsock_sock *vsk,
+			const struct vsock_transport *transport,
+			const struct sockaddr_vm *src);
 void vsock_remove_sock(struct vsock_sock *vsk);
 void vsock_for_each_connected_socket(struct vsock_transport *transport,
 				     void (*fn)(struct sock *sk));
diff --git a/net/vmw_vsock/af_vsock.c b/net/vmw_vsock/af_vsock.c
index a33b2a2d3..f840498b5 100644
--- a/net/vmw_vsock/af_vsock.c
+++ b/net/vmw_vsock/af_vsock.c
@@ -438,6 +438,38 @@ struct sock *vsock_find_connected_socket(struct sockaddr_vm *src,
 }
 EXPORT_SYMBOL_GPL(vsock_find_connected_socket);
 
+/**
+ * vsock_check_source - validate a packet source against a socket peer
+ * @vsk: socket receiving the packet
+ * @transport: transport receiving the packet
+ * @src: source address from the packet
+ *
+ * Return: true if the packet arrived on the socket's assigned transport and
+ * its source matches the stored peer. Loopback packets are generated
+ * internally and always use the local CID as their source, including
+ * connections using a valid CID alias.
+ *
+ * The caller must hold the socket lock and must not call this for listening
+ * sockets, which accept packets from any source and have no assigned
+ * transport.
+ */
+bool vsock_check_source(const struct vsock_sock *vsk,
+			const struct vsock_transport *transport,
+			const struct sockaddr_vm *src)
+{
+	if (vsk->transport != transport)
+		return false;
+
+	if (src->svm_port != vsk->remote_addr.svm_port)
+		return false;
+
+	if (src->svm_cid == vsk->remote_addr.svm_cid)
+		return true;
+
+	return transport->get_local_cid() == VMADDR_CID_LOCAL;
+}
+EXPORT_SYMBOL_GPL(vsock_check_source);
+
 void vsock_remove_sock(struct vsock_sock *vsk)
 {
 	/* Transport reassignment must not remove the binding. */
diff --git a/net/vmw_vsock/virtio_transport_common.c b/net/vmw_vsock/virtio_transport_common.c
index e4ebaa70f..6301c108a 100644
--- a/net/vmw_vsock/virtio_transport_common.c
+++ b/net/vmw_vsock/virtio_transport_common.c
@@ -1823,7 +1823,8 @@ void virtio_transport_recv_pkt(struct virtio_transport *t,
 	 * lock_sock (note: listener sockets are not assigned to any transport)
 	 */
 	if (sock_flag(sk, SOCK_DONE) ||
-	    (sk->sk_state != TCP_LISTEN && vsk->transport != &t->transport)) {
+	    (sk->sk_state != TCP_LISTEN &&
+	     !vsock_check_source(vsk, &t->transport, &src))) {
 		(void)virtio_transport_reset_no_sock(t, skb, net);
 		release_sock(sk);
 		sock_put(sk);

base-commit: dc4b95b8fee95113587e93ca116356032d271371
