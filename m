Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF0AE3CF21B
	for <virtualization@lists.linux.dev>; Fri,  5 Jun 2026 19:19:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780687192; cv=none; b=JoWdN+xYtHpktExzjwHo2n84YQX467tYfI4/rPeIw6WEN9KbqUkON6UdD+vmPEIlQh45g+pP/WWc3ekVWQ4pjI8rSdy1TYczKvT/lcnE4EXVoy8hoeXOBkcHOY5FvVB4IZzCbPN9xJFYiCEbsf2kPekt6P0iiTOqTa+WiXLy4CE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780687192; c=relaxed/simple;
	bh=lQyeoEHvPDcTd8UBfI28l1PrKOeUuXwWGO6rNePL3aM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=fQYuOI3d0pU922V0id3oLpHsYlqUJXcit864abWfmjBqo2lsxj3MuYQ0rOFKPUcyENM6HzE2SFVznoToanOZTjJCBgy86LufLIpIJqU9MfMbR6t9gxCblCgumufCXHJY88jNgpikNu2a43ob3i/AJZ0EcLjnFsshYOLP56/M5Qs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cs.unc.edu; spf=pass smtp.mailfrom=cs.unc.edu; dkim=pass (2048-bit key) header.d=cs.unc.edu header.i=@cs.unc.edu header.b=n146oxER; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cs.unc.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cs.unc.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cs.unc.edu header.i=@cs.unc.edu header.b="n146oxER"
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-36bc065c298so271562a91.2
        for <virtualization@lists.linux.dev>; Fri, 05 Jun 2026 12:19:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cs.unc.edu; s=google; t=1780687184; x=1781291984; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=B0vJH8NNd0RF41K/4FCBtez2ytaf4nIFe3x4aSA4G5w=;
        b=n146oxERsrouszLJJjAv2F/Q34ULh2sf7JwFvCvGwo46iMXjXlubvyRZ0ykd70c0t0
         0TPANaV4LPk2HGwRVbOtJr0ZKoNY/B4AJ0nqOHMaLEoV5WGr1+LaQhYIKTADAWLUsI38
         K2bhzoWViRh5TAFNMnIxlDSUt45kL3K6u6f2Nq0PFOUvkMLV2Yf5VZXIqCrZ6L9xiQg8
         NyOW/IpGs3Pvz6Aj04dnWhiulYIvVp6t3vvg0H7h1c4Hig3PrcyOJf+oj2Y/6BQMb5X8
         dB85ezF2U5QwBMUaSctrzc+ANXlObooiMD0NfzB+yyk3qI4bLIAtPKGIMg4APhYqd3EY
         4pYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780687184; x=1781291984;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=B0vJH8NNd0RF41K/4FCBtez2ytaf4nIFe3x4aSA4G5w=;
        b=WpHI91EkHsWRNAp7e0DzyUe6W5oZurNpTggSF953subnzsdydH3SgGps8z86eUX5q6
         ykRrO4AKHEKNjL7aiCH43QnxVYoLN7bAEJtbIXn5vNS0IWIbp7moACUFDIfRQmSpwR8R
         lrc5XXBc63TLJ9F2nuXSzBXX956souuN9P/mdE/4E/KI+5o9EBShha05vTw5BjA3AJk+
         sdCTdsMujmrfCsH4OjptTi3/IKx8mN8X4hJu/TbhLkcZF6azBIYZnbfyAgK19ytU93v/
         Exnv/J8cQmTtEi8OpsDpav/5B4omDniFvNRWJP1fBxFH00OiBLUipVVfbyak2rMirYxV
         uy/Q==
X-Forwarded-Encrypted: i=1; AFNElJ+PTVUOUnt4Qn0ZtlY+H3aio3lrbcxOVf0gij91Gcom0njIsa8oiqmuGoQMUEJtQRuj9EQ/rnJ5BoMkQjYCmA==@lists.linux.dev
X-Gm-Message-State: AOJu0YwxXBN2kcKA955wvMQ6gW2Bnfr7PL3jKKzQlVVENX/k07S4u5yO
	Woq+6vFBsvwksE5qZws9jYZ1aiUSM+FTwMF1Xr07ovKOup7IbOpo53WSe/r9d/Hn/w==
X-Gm-Gg: Acq92OG1PnRZdI+gv7AGtWuXInDGo+Hn5ZwbcIyfbK25WR61rNIu7a/F8z7iQgy+p6U
	P9qHfGDMEwlwIoCPnuUEDtNznPXi0hQIIGEc6J2D3tE0F1f9BmHT8LexL9Tq34yjHIY3xnVipFC
	sS0YG3z7dYQvJzpuPGGY+tdq77QyKqnwOBXhNuCR2CKDyV9nOILjg7KkWiMqm2ZFZsSuZWlKCy0
	VK0DwaKXoJDGTneqHrFqdAcQdOkJOM7a6m062YZejqm/GCnFXkxg899mPAd7D3RfxGJAYC2xkn+
	k2A4vQGIqETbVh1ERafUXrPRjOnxe5D7tdney+XZ2lQWhBrrK3OCS1nr2OWg6u5072UgEDX4cYT
	5V0igDCRsm4EmwnkLb284fXS/Dt3nKq80ObuaZHsIE/wsL3NNOWlTVvy35R5jTOcwf3w3JMJAbE
	q/Pisee0Q/wtsbSCFcU+SYTD2CBaugkaqA6XXXv4xgrNS9/q2BvSTUIDbvNCE6Ug==
X-Received: by 2002:a17:90b:3dcf:b0:36b:3ecd:88d7 with SMTP id 98e67ed59e1d1-370ef0f50ffmr2677491a91.2.1780687183832;
        Fri, 05 Jun 2026 12:19:43 -0700 (PDT)
Received: from localhost.localdomain ([106.51.195.148])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-842820e8e6asm9757737b3a.0.2026.06.05.12.19.39
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 05 Jun 2026 12:19:43 -0700 (PDT)
From: Divya Mankani <divyakm@cs.unc.edu>
X-Google-Original-From: Divya Mankani <divyakm@unc.edu>
To: kuba@kernel.org,
	pabeni@redhat.com
Cc: horms@kernel.org,
	virtualization@lists.linux.dev,
	kvm@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	syzbot+1b2c9c4a0f8708082678@syzkaller.appspotmail.com,
	Divya Mankani <divyakm@unc.edu>
Subject: [PATCH] vsock/virtio: fix memory leak in virtio_transport_recv_listen
Date: Sat,  6 Jun 2026 00:49:22 +0530
Message-ID: <20260605191922.12720-1-divyakm@unc.edu>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Syzbot reported a memory leak inside virtio_transport_recv_listen
caused by a race condition when the parent listener socket shuts down
while an incoming packet is being enqueued.

Fix this by locking the parent socket and verifying its shutdown
state under the lock before executing vsock_enqueue_accept().

Fixes: a478546a782a ("vsock/virtio: add support for listen sockets")
Reported-by: syzbot+1b2c9c4a0f8708082678@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=1b2c9c4a0f8708082678
Signed-off-by: Divya Mankani <divyakm@unc.edu>
---
 net/vmw_vsock/virtio_transport_common.c | 17 ++++++++++++-----
 1 file changed, 12 insertions(+), 5 deletions(-)

diff --git a/net/vmw_vsock/virtio_transport_common.c b/net/vmw_vsock/virtio_transport_common.c
index 3b294164b..8006a13bb 100644
--- a/net/vmw_vsock/virtio_transport_common.c
+++ b/net/vmw_vsock/virtio_transport_common.c
@@ -1571,15 +1571,20 @@ virtio_transport_recv_listen(struct sock *sk, struct sk_buff *skb,
 	vsock_addr_init(&vchild->remote_addr, le64_to_cpu(hdr->src_cid),
 			le32_to_cpu(hdr->src_port));
 
-	ret = vsock_assign_transport(vchild, vsk);
-	/* Transport assigned (looking at remote_addr) must be the same
-	 * where we received the request.
+	/* Lock the parent listener socket to synchronize with a potential
+	 * simultaneous shutdown thread running __vsock_release().
 	 */
-	if (ret || vchild->transport != &t->transport) {
+	lock_sock(sk);
+
+	/* Check if the listener socket was shut down while we were
+	 * creating and configuring the child socket.
+	 */
+	if (sk->sk_shutdown == SHUTDOWN_MASK) {
+		release_sock(sk);
 		release_sock(child);
 		virtio_transport_reset_no_sock(t, skb, sock_net(sk));
 		sock_put(child);
-		return ret;
+		return -ESHUTDOWN;
 	}
 
 	sk_acceptq_added(sk);
@@ -1590,6 +1595,8 @@ virtio_transport_recv_listen(struct sock *sk, struct sk_buff *skb,
 	vsock_enqueue_accept(sk, child);
 	virtio_transport_send_response(vchild, skb);
 
+	/* Safely release both locked objects */
+	release_sock(sk);
 	release_sock(child);
 
 	sk->sk_data_ready(sk);
-- 
2.50.1 (Apple Git-155)

