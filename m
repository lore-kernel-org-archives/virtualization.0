Received: from mailtransmit04.runbox.com (mailtransmit04.runbox.com [185.226.149.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38BE85540A6;
	Tue, 22 Sep 2026 13:16:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.226.149.37
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790082972; cv=none; b=lr00bDPkiU2nxtSFBGumMHFLdFqrwNO3Vjt9pgumK6fA4mRwuwx9W7IXUTiSmk6HZ7sdh9ZlWxVsLEx/5y8fQhktHf4dLKLVxxD2BtaelvxBKlvc8RsDH9HDEurkhAKvlEqvSxrf2/AVqlQa55yaxCLuw9xxBsed0Wket3eu2oQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790082972; c=relaxed/simple;
	bh=aSBDtneI0GuyWrBLnzihtMTMp8WnnGR7PRiFlojtJc8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=DJiUWAxfw5GXdAq307sYH4UStSHV3lBHPvF3+OKu2a7iRJbL9+P1yfTiG0CpAxHW9hPtKYh8FCpeeIvx/F7j48Es/f8Qq+ag1lW2oAxt4vfZTnZdA1WDcH0pMwYAQymGHPKlC2wdX/5Hp2nyKAvF/WDYNW9HUe1ukP/gxCL0Ic4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rbox.co; spf=pass smtp.mailfrom=rbox.co; dkim=pass (2048-bit key) header.d=rbox.co header.i=@rbox.co header.b=S7L+X9Mx; arc=none smtp.client-ip=185.226.149.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rbox.co
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rbox.co
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rbox.co header.i=@rbox.co header.b="S7L+X9Mx"
Received: from mailtransmit03.runbox ([10.9.9.163] helo=aibo.runbox.com)
	by mailtransmit04.runbox.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.93)
	(envelope-from <mhal@rbox.co>)
	id 1x90LL-0038Px-Ml; Tue, 22 Sep 2026 15:15:31 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=rbox.co;
	s=selector1; h=Cc:To:In-Reply-To:References:Message-Id:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:From;
	bh=iShgG+Cn+uv/wW9kXnl4imuLrgb+gLoBGKjVnssyxu4=; b=S7L+X9MxI6kjXKMsY1UPAwxDIs
	AVpYM9GsZJeHZP5oRA1bveuR1Z08unYX9LKrHDWjpw1ltUt2Os6FB6vufYtz/P1l3LmCoj5Z4hwLY
	reS8j7/oRPZkTKE28mqSHEn/vb4x8pYCYCh8x0iwa2Rzj8IRoVkoB8Yxf6l0chEDMIryFSvj9472Q
	gaoBTj9gQCs7+Cx36OBPbeiNoCIVjI4T75jckOf/CXFd20/mZdg/bm8em5OtDc5PJlNjNoZxiO7NV
	r3mL80HR2px52rYISGMbqt2unZz3q5N5xObS7jF/CXziAjqOIEFL93zIPZdJ4AmOH2nIbzAlrugAG
	Rk8n9tWQ==;
Received: from [10.9.9.72] (helo=submission01.runbox)
	by mailtransmit03.runbox with esmtp (Exim 4.86_2)
	(envelope-from <mhal@rbox.co>)
	id 1x90LF-0006NX-5s; Tue, 22 Sep 2026 15:15:26 +0200
Received: by submission01.runbox with esmtpsa  [Authenticated ID (604044)]  (TLS1.2:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.95)
	id 1x90L4-00FyKH-SV;
	Tue, 22 Sep 2026 15:15:15 +0200
From: Michal Luczaj <mhal@rbox.co>
Date: Tue, 22 Sep 2026 15:15:01 +0200
Subject: [PATCH net v3 7/8] vsock: handle listen() racing connect()
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260922-vsock-connect-reset-closing-v3-7-78907b8200d4@rbox.co>
References: <20260922-vsock-connect-reset-closing-v3-0-78907b8200d4@rbox.co>
In-Reply-To: <20260922-vsock-connect-reset-closing-v3-0-78907b8200d4@rbox.co>
To: Stefan Hajnoczi <stefanha@redhat.com>, 
 Stefano Garzarella <sgarzare@redhat.com>, 
 "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowangio@gmail.com>, 
 =?utf-8?q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
 "David S. Miller" <davem@davemloft.net>, 
 Xuan Zhuo <xuanzhuo@linux.alibaba.com>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>
Cc: kvm@vger.kernel.org, virtualization@lists.linux.dev, 
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Michal Luczaj <mhal@rbox.co>
X-Mailer: b4 0.15.2

Socket can flip to TCP_LISTEN when connect() schedules out. Respect
listen() winning the race: let connect() time out, but don't reset the
socket.

sk is CLOSE UNCONNECTED
non-blocking connect():
  sk := SYN_SENT CONNECTING
  enqueue vsock_connect_timeout()
                                   blocking connect():
                                     release_sock()
                                     schedule_timeout()
vsock_connect_timeout():
  sk := CLOSE UNCONNECTED
listen():
  sk := LISTEN UNCONNECTED
                                     lock_sock()
                                     sk is TCP_LISTEN UNCONNECTED

Signed-off-by: Michal Luczaj <mhal@rbox.co>
---
 net/vmw_vsock/af_vsock.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/net/vmw_vsock/af_vsock.c b/net/vmw_vsock/af_vsock.c
index 5a2d7e10ecb8..56c595942456 100644
--- a/net/vmw_vsock/af_vsock.c
+++ b/net/vmw_vsock/af_vsock.c
@@ -1663,6 +1663,13 @@ static void vsock_unconnected_reset(struct sock *sk)
 
 	sock_owned_by_me(sk);
 
+	/*
+	 * listen() can race connect() on schedule_timeout().
+	 * Don't reset TCP_LISTEN.
+	 */
+	if (sk->sk_state == TCP_LISTEN)
+		return;
+
 	/*
 	 * Transport events are serviced by resetting each connected socket to
 	 * TCP_CLOSE. The reset is done under vsock_table_lock but without

-- 
2.55.0

