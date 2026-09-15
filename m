Received: from mailtransmit05.runbox.com (mailtransmit05.runbox.com [185.226.149.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 469CE3B27E9;
	Tue, 15 Sep 2026 13:15:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.226.149.38
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789478156; cv=none; b=e23uNdU0UD7YSx0OBWOhP6nNep04gOqqy+qlBQrWm/i8MySzOo0JW6+/eA/oAcBzTL2d7buG1Wv/jF1Xxe9RGgRzebMpnN41j4/+1CHS/ZCkAGAel6NWo1cnz/kCLNM61yD6Os5XGH+U3ZDrcfL1E9xVUgZTLVlU9p+lvsPTAdU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789478156; c=relaxed/simple;
	bh=xu+mDwt11NCm5xRoNZThMHFCHRLE2/JxywDp9WKY6vw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=PCMdhdxw6O9Y81n2nT8zWD4VBbp0bw3ZZPrKZlTQ9YCF2uahQAQ+MeYZi8SD3exiqBUS/x56QtU2efFyT8otvI8ecyP7DaXD8tFQ/fwh5yczy0xHdBeA9+Uc0vkJSb6KhsSZNvy+xRvFFwI6QWFZvn5teqWCJO+9CpWTOr481Vg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rbox.co; spf=pass smtp.mailfrom=rbox.co; dkim=pass (2048-bit key) header.d=rbox.co header.i=@rbox.co header.b=aJD5Q34H; arc=none smtp.client-ip=185.226.149.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rbox.co
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rbox.co
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rbox.co header.i=@rbox.co header.b="aJD5Q34H"
Received: from mailtransmit02.runbox ([10.9.9.162] helo=aibo.runbox.com)
	by mailtransmit05.runbox.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.93)
	(envelope-from <mhal@rbox.co>)
	id 1x6T0h-000wMC-Ce; Tue, 15 Sep 2026 15:15:43 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=rbox.co;
	s=selector2; h=Cc:To:In-Reply-To:References:Message-Id:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:From;
	bh=8hwGE6w8mUrcO/P9PNHHaz5xdc2BUDZks6W/X0E3xyc=; b=aJD5Q34HCHzAwM1s86lNQ/xEtJ
	AWKboTjIr54kd45eGpigum/lpJ1hJlADxzti8SmGZ6jlm24ym+60KvUc98yeFdYErfWD6XySTF1rx
	0QgW1S3Fzc+xI37c3yzc2Ud6ZfDzvsE4/QMR3K6DgtvmbOBrOMjs4k3fUpiPqb2oiljmhTIYzS6Lx
	jEcNPHG+aWkCFGWDH2HvL/aFTsx7GicRI7/SYsoBkdHr0WiqUS/FpHOlAevFgefDYJ2AYy8Kczm10
	4G48ALCDmO0v+a+1uOTzJeTpr6QMtgBv0W+BPC28fsa4G3+xf4Z98iERM5XsGKumJ/sm7UR7Ru/tm
	dGp3KOEA==;
Received: from [10.9.9.72] (helo=submission01.runbox)
	by mailtransmit02.runbox with esmtp (Exim 4.86_2)
	(envelope-from <mhal@rbox.co>)
	id 1x6T0W-0003iR-WC; Tue, 15 Sep 2026 15:15:33 +0200
Received: by submission01.runbox with esmtpsa  [Authenticated ID (604044)]  (TLS1.2:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.95)
	id 1x6T0L-00EUxD-Mo;
	Tue, 15 Sep 2026 15:15:21 +0200
From: Michal Luczaj <mhal@rbox.co>
Date: Tue, 15 Sep 2026 15:15:16 +0200
Subject: [PATCH net v2 5/5] vsock: Handle sudden TCP_CLOSE during connect
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260915-vsock-connect-reset-closing-v2-5-a1d9abb472f7@rbox.co>
References: <20260915-vsock-connect-reset-closing-v2-0-a1d9abb472f7@rbox.co>
In-Reply-To: <20260915-vsock-connect-reset-closing-v2-0-a1d9abb472f7@rbox.co>
To: Stefan Hajnoczi <stefanha@redhat.com>, 
 Stefano Garzarella <sgarzare@redhat.com>, 
 "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowangio@gmail.com>, 
 =?utf-8?q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
 "David S. Miller" <davem@davemloft.net>, 
 Xuan Zhuo <xuanzhuo@linux.alibaba.com>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>, Asias He <asias@redhat.com>
Cc: kvm@vger.kernel.org, virtualization@lists.linux.dev, 
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Michal Luczaj <mhal@rbox.co>
X-Mailer: b4 0.15.2

Virtio/PM events are serviced by virtio_vsock_reset_sock(), which resets
each connected socket. The reset is done under vsock_table_lock but without
taking lock_sock(), so from the point of view of vsock_connect() -
locklessly. The same pattern exists in VMCI's
vmci_transport_handle_detach() and vhost's vhost_vsock_reset_orphans().

The complexity of connect() comes from the fact that:
1. the virtio transport can be reassigned, so the old transport must be
   safely released;
2. a failed connect can be followed by a retry, so the socket must be
   reverted to a sensible state.
Both cases apply only as long as the socket has not yet established a
connection.

While connect() waits for TCP_SYN_SENT -> TCP_ESTABLISHED, other
transitions can also occur:

  TCP_SYN_SENT -> TCP_CLOSE on connection failure, timeout or signal
  TCP_SYN_SENT -> TCP_ESTABLISHED -> TCP_CLOSING on VIRTIO_VSOCK_OP_RST
  TCP_SYN_SENT -> TCP_ESTABLISHED -> [TCP_CLOSING ->] TCP_CLOSE on event

This further complicates connect(). Rather than making every event handler
drop the socket from connected_table or adapting connect() to handle more
transitions (while missing proper locking), use vsk->peer_shutdown as a
poison flag. Whatever state an event leaves the socket in, the flag bricks
it and prevents suspicious transport reassignments or TCP_SYN_SENT
retransmissions.

Fixes: d021c344051a ("VSOCK: Introduce VM Sockets")
Signed-off-by: Michal Luczaj <mhal@rbox.co>
---
 net/vmw_vsock/af_vsock.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/net/vmw_vsock/af_vsock.c b/net/vmw_vsock/af_vsock.c
index adf3f018347e..972952d04a81 100644
--- a/net/vmw_vsock/af_vsock.c
+++ b/net/vmw_vsock/af_vsock.c
@@ -1743,6 +1743,12 @@ static int vsock_connect(struct socket *sock, struct sockaddr_unsized *addr,
 			goto out;
 		}
 
+		/* Virtio/PM events are serviced locklessly. */
+		if (READ_ONCE(vsk->peer_shutdown)) {
+			err = -ECONNRESET;
+			goto out;
+		}
+
 		/* Set the remote address that we are connecting to. */
 		memcpy(&vsk->remote_addr, remote_addr,
 		       sizeof(vsk->remote_addr));

-- 
2.55.0

