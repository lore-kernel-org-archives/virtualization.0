Received: from mailtransmit04.runbox.com (mailtransmit04.runbox.com [185.226.149.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 444FD449B21
	for <virtualization@lists.linux.dev>; Wed,  9 Sep 2026 21:59:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.226.149.37
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788991161; cv=none; b=Pxiw6AgvA0KYFj6D20wigomfO096OCpWDCo1rFUhhZzpCnmnVw21Rg51nDNw8ebHBZcr9Eyo3O0a6qoWo70A9cLNMnP4Pcy6tLeGUX8oR17mgKGG5tgtYMhV3tE+RNGf61W1spto2iKpfnD+kjGFpZqvx1xPTWriaZQc2icNsbQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788991161; c=relaxed/simple;
	bh=5AiUP0XpreXNuiA/V0MjXI98g72p+JAbAaycONJLEvU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=Ggek40kjWsGMtgO3lCPPJrOY6+EWM375bAtTQ/NkZCLgm666GOP+tv2Kz/hpqqaXx9vW2twMOximHxQnDJPQHYaeGXPRs+0qyFZILNo8JZSrRcC6tcRY0CjAwu82FrQCliO+RpVWMwYvOFCWjtF1MW9xxe52ar9d4Cc6bk5JBS4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rbox.co; spf=pass smtp.mailfrom=rbox.co; dkim=pass (2048-bit key) header.d=rbox.co header.i=@rbox.co header.b=nolRloxV; arc=none smtp.client-ip=185.226.149.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rbox.co
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rbox.co
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rbox.co header.i=@rbox.co header.b="nolRloxV"
Received: from mailtransmit02.runbox ([10.9.9.162] helo=aibo.runbox.com)
	by mailtransmit04.runbox.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.93)
	(envelope-from <mhal@rbox.co>)
	id 1x4QJp-001F22-M0; Wed, 09 Sep 2026 23:59:01 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=rbox.co;
	s=selector2; h=Cc:To:Message-Id:Content-Transfer-Encoding:Content-Type:
	MIME-Version:Subject:Date:From;
	bh=p12OuFyDhrWNEio5UJ9mzJHOxquwOKi2Y8Jo1oKEw74=; b=nolRloxVuxnP6a1/TzWOHCxNcW
	xtDVCF8XX91nLoKltZyz/zo+dfmviUeX1SJTzvGBzM7rt2fp3n7GlkC96OWy+66TR9IGhLrwusuXC
	usLIp1TpDLB22Q/UViOXfxr2OYj/9W1zVBkgQAL9Hx8IJb3viEJJ6Va5KuHQz/gx3QGQpXNfNIyJx
	lUNYefpJYLgyl2l6sl+gmd9hAMCvmKb4WOiMcKFhlt4yd7UL6hiesEZPBSwevixL27MskppUD9lsL
	cDIGf0hkZuBxbRfWlLg3nmeFpZ51642p955jH0TwnMHFiJttscv9HtS+E89bwLwSiZUaEoRYjne+D
	Agr6/WSg==;
Received: from [10.9.9.74] (helo=submission03.runbox)
	by mailtransmit02.runbox with esmtp (Exim 4.86_2)
	(envelope-from <mhal@rbox.co>)
	id 1x4QJe-0001fW-TO; Wed, 09 Sep 2026 23:58:51 +0200
Received: by submission03.runbox with esmtpsa  [Authenticated ID (604044)]  (TLS1.2:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.95)
	id 1x4QJe-000gXe-JE;
	Wed, 09 Sep 2026 23:58:50 +0200
From: Michal Luczaj <mhal@rbox.co>
Date: Wed, 09 Sep 2026 23:58:26 +0200
Subject: [PATCH net] vsock: Do not reset a TCP_CLOSING socket
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260909-vsock-connect-reset-closing-v1-1-50298b9ccfbf@rbox.co>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yXMQQ6CMBCF4auQWTtJ6QKKVyEudDrAqJmaTiUmh
 LtbZfm/5H0bGGdhg3OzQeZVTJLWaE8N0HLVmVFibfDOdy54h6sleiAlVaaCmY0L0jOZ6IxDiNG
 HvhtiP0EVXpkn+fz1EZQLXI7R3rd7ff9c2PcvCy+/PIQAAAA=
X-Change-ID: 20260820-vsock-connect-reset-closing-98dd28769d7f
To: Stefano Garzarella <sgarzare@redhat.com>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>, Dmitry Torokhov <dtor@vmware.com>, 
 Andy King <acking@vmware.com>, George Zhang <georgezhang@vmware.com>
Cc: virtualization@lists.linux.dev, netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Hyunwoo Kim <imv4bel@gmail.com>, 
 Michal Luczaj <mhal@rbox.co>
X-Mailer: b4 0.15.2

Ensure connect() resets the socket only if it has never been established.
Handle the previously overlooked TCP_ESTABLISHED -> TCP_CLOSING
transition (on VIRTIO_VSOCK_OP_RST), which could race with the connect
loop.

Resetting a socket that is still present in connected_table can lead to
memory corruption. The reporter noted lost transports for in-flight skbs,
and I have reproduced crashes caused by re-insertion into connected_table.

  list_add double add: new=, prev=, next=.
  kernel BUG at lib/list_debug.c:35!
  Oops: invalid opcode: 0000 [#1] SMP KASAN NOPTI
  Workqueue: vsock-loopback vsock_loopback_work
  RIP: 0010:__list_add_valid_or_report+0x11f/0x130
  Call Trace:
   vsock_insert_connected.cold+0xe/0x13
   virtio_transport_recv_pkt+0x10e9/0x1460
   vsock_loopback_work+0x305/0x480
   process_one_work+0xe4c/0x1560
   worker_thread+0x4f1/0xd60
   kthread+0x36e/0x470
   ret_from_fork+0x47b/0x6b0
   ret_from_fork_asm+0x1a/0x30

Drop the inaccurate comment above signal_pending(). This fix is
supplementary to commit 002541ef650b ("vsock: Ignore signal/timeout on
connect() if already established"). Details at Link.

Fixes: d021c344051a ("VSOCK: Introduce VM Sockets")
Reported-by: Hyunwoo Kim <imv4bel@gmail.com>
Link: https://lore.kernel.org/netdev/anzT1fREOSyHT99k@v4bel/
Signed-off-by: Michal Luczaj <mhal@rbox.co>
---
Note that this is not a complete fix. connect()'s schedule_timeout() can
still race with two other functions that set sk_state = TCP_CLOSE while
keeping the socket in connected_table:
1. vmci_transport_handle_detach(): no way for me to test,
2. virtio_vsock_reset_sock(): tested by unbinding the driver
   (/sys/bus/virtio/drivers/virtio_transport/unbind).
The latter appears easy to fix by adding __vsock_remove_connected() and
switching to a _safe iterator in vsock_for_each_connected_socket().
---
 net/vmw_vsock/af_vsock.c | 14 ++++++--------
 1 file changed, 6 insertions(+), 8 deletions(-)

diff --git a/net/vmw_vsock/af_vsock.c b/net/vmw_vsock/af_vsock.c
index f840498b58af..eec5dd6daebb 100644
--- a/net/vmw_vsock/af_vsock.c
+++ b/net/vmw_vsock/af_vsock.c
@@ -1834,23 +1834,20 @@ static int vsock_connect(struct socket *sock, struct sockaddr_unsized *addr,
 		timeout = schedule_timeout(timeout);
 		lock_sock(sk);
 
-		/* Connection established. Whatever happens to socket once we
-		 * release it, that's not connect()'s concern. No need to go
+		/* Connection was established. Whatever happens to socket once
+		 * we release it, that's not connect()'s concern. No need to go
 		 * into signal and timeout handling. Call it a day.
 		 *
 		 * Note that allowing to "reset" an already established socket
 		 * here is racy and insecure.
 		 */
-		if (sk->sk_state == TCP_ESTABLISHED)
+		if (sk->sk_state == TCP_ESTABLISHED ||
+		    sk->sk_state == TCP_CLOSING)
 			break;
 
 		/* If connection was _not_ established and a signal/timeout came
 		 * to be, we want the socket's state reset. User space may want
 		 * to retry.
-		 *
-		 * sk_state != TCP_ESTABLISHED implies that socket is not on
-		 * vsock_connected_table. We keep the binding and the transport
-		 * assigned.
 		 */
 		if (signal_pending(current) || timeout == 0) {
 			err = timeout == 0 ? -ETIMEDOUT : sock_intr_errno(timeout);
@@ -1875,7 +1872,8 @@ static int vsock_connect(struct socket *sock, struct sockaddr_unsized *addr,
 	}
 
 	err = sock_error(sk);
-	if (err) {
+	if (err &&
+	    sk->sk_state != TCP_ESTABLISHED && sk->sk_state != TCP_CLOSING) {
 		sk->sk_state = TCP_CLOSE;
 		sock->state = SS_UNCONNECTED;
 	}

---
base-commit: 9a1599eeb8d18a2113e4cabcbd3bec5a8377dbed
change-id: 20260820-vsock-connect-reset-closing-98dd28769d7f

Best regards,
--  
Michal Luczaj <mhal@rbox.co>

