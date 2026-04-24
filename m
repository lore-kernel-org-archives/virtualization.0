Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84C6A282F35
	for <virtualization@lists.linux.dev>; Fri, 24 Apr 2026 15:03:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777043024; cv=none; b=Un68Xwgd/tSbtvuyufkT7J7htvg13Z+Z2oIH4DbTd6lJG+khAFhOxv2cGkyW94vHeMoifsz899AF5CmLk40ynTiQOyd2nYFFMW32HZ1Az+xLXBSz+fCbXYlgmqakXNpswU2gDUtkRBNd/ZFDuWzFgg5mWXHW7nxWBSFzK0OJIxk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777043024; c=relaxed/simple;
	bh=sam5CzX7hUFWo2rSuIUY9jL5rVRI1ZwRvCUUTaLpc/8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=YYWXTzcbUJ06AFn4ZzK2kIyUZoIy0BdBWPtQtWhjgoyRN3VCtb5jaEpbtBOj5jBZKI/d3S3b1yvyPx8kJgvZSn6vVWNtxJNEN0mPC+wNC36WuRDpnVHUPpLeSq9I/olfyQA/w8UNKc/E/jOpFtFNPmckcfjk5ctBHxwNFuScl7I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OXedOKCl; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OXedOKCl"
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-2b24fede2acso52973715ad.3
        for <virtualization@lists.linux.dev>; Fri, 24 Apr 2026 08:03:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777043023; x=1777647823; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=gdnOmdvYkq1xF25fAEazaVF6DIg+bGDl6V2EYI1zKDU=;
        b=OXedOKClpTy+n6x1KAHsWsEln4HZdgt7tlgxUStkUtPx3MxZoY+BvaOtbaICZH74Zm
         uh6k42Xd3IU3mc/xIXxebJWRNhjen4xw4A/V++w7LSkJyDiU1j28yl/cB+WKtUcKka80
         JWIc/ygbcti4tqlkFCaFs5etX5ePympRC4/c5+vGGnp6ZYe9WDUnrzi0glofndOuaYFu
         pVaXeUvu7bR7UVi5f/ynLuAgYKsiZa2JcJOH1v2Ht2/GNRzAJcRXQSrTgBsc0hBoF5Sv
         QWrALP9yOhMxVDvHs4B9MTQ6KoHTeLcn9z2op80LNDLLHCeroAK7M2lpyDZXr6wBjjgk
         H9cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777043023; x=1777647823;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gdnOmdvYkq1xF25fAEazaVF6DIg+bGDl6V2EYI1zKDU=;
        b=jXvi6HzPbiPBYhyTevthb6jh8pA9p3u27VqiFzDC2pATNPpmcvgB38jY+Anab9MvDa
         MrlUEpruP0qrGvUdpN9W8GmV69WaCK2EpB1FQnsSBnJzqNXft/SONbY6q4U0zSKZ0mGz
         QAm1/shzaUOgGH13I8rTjD1lgx9KimI5S2KtvCo9exTTgzGiXWXyrvzU0lli6/hroBxQ
         Au+I1ucTe/PRexuQSDhIfMJmRat7el/ppmZrWzZiywF4BhA9oljC3dy5bZ89m40f7Q0E
         D+5c93U3l0tHTCJWpko7dLnVZiKZzNGAMecqCFQfD+AYYiSl/c8BWwfggBZopvb0kxHx
         M4gw==
X-Gm-Message-State: AOJu0YzO+4ln8mmM4dF2mbRcTVjmEhU+c0mWKB5GcJisx9HZ0Zu1hmEs
	Ex2l+eQIW3bVgRvLp2ozahg8Ztlal1jqrH3lgdjCnapkan3LBtDkdadL
X-Gm-Gg: AeBDietgia2u3W6hbDqFWZwirZIduFMovFNDifDGEKI1XTZmUokI1QYoYiPKeALgcNZ
	y5jumskb3aUTdz9maS6A1a8gXBAUWvMxkQcgkNFxL5Vyrt9i4fAHezY9wW+XLGbi0zBa/aJAvpT
	WYAg3NZWhyVsoI2QH+1wR/H1DjUxQ3g2dw6kiRISybrF6ogCQ7BodWCibVYjbvuCrc7SOeCpNCy
	NExA59B5tCP5Og/QhEsINZrQnd5H+jBay77yWYA1XiIX7TuMEdGo5Q/ASoIHeOW1AjXjmEJ5rWD
	Mu0hMdxC7dbE6s++9wvxmsFGO5PUtdrfqS9efYGHttJNPNRp8bOhuDj9YydP+TcJfvKKNmXiDGl
	3Pw65sbLZpNc42HnJ3OwBykq6CyvNgRysmzDbTztFfycgdOxDlh4M7xIbHO6E+ETxgKqg2csoxQ
	4tbeca94y9LRXp4g1F3AQI4GCf//nh614WBNejsomyjrkrB4XD+a4R/ggdEWrJ7kZM9658wJYCi
	aZ6ZyZFujNUesco
X-Received: by 2002:a17:903:286:b0:2b2:680c:2193 with SMTP id d9443c01a7336-2b5f9f64affmr349377755ad.31.1777043022350;
        Fri, 24 Apr 2026 08:03:42 -0700 (PDT)
Received: from deepanshu-kernel-hacker.. ([2405:201:682f:383f:ba99:851:d885:8271])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b5fab4cc47sm233257465ad.82.2026.04.24.08.03.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Apr 2026 08:03:41 -0700 (PDT)
From: Deepanshu Kartikey <kartikey406@gmail.com>
To: mst@redhat.com,
	jasowang@redhat.com,
	xuanzhuo@linux.alibaba.com,
	eperezma@redhat.com,
	stefanha@redhat.com,
	sgarzare@redhat.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org
Cc: virtualization@lists.linux.dev,
	kvm@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Deepanshu Kartikey <kartikey406@gmail.com>,
	syzbot+1b2c9c4a0f8708082678@syzkaller.appspotmail.com
Subject: [PATCH] vsock/virtio: fix memory leak in virtio_transport_recv_listen()
Date: Fri, 24 Apr 2026 20:33:10 +0530
Message-ID: <20260424150310.57228-1-kartikey406@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Two bugs exist in virtio_transport_recv_listen():

1. On the transport assignment error path, sk_acceptq_added() is called
   but sk_acceptq_removed() is never called when vsock_assign_transport()
   fails or assigns a different transport than expected. This causes the
   parent listener's accept backlog counter to be permanently inflated,
   eventually causing sk_acceptq_is_full() to reject legitimate incoming
   connections.

2. There is a race between __vsock_release() and vsock_enqueue_accept().
   __vsock_release() sets sk->sk_shutdown to SHUTDOWN_MASK and flushes
   the accept queue under the parent socket lock. However,
   virtio_transport_recv_listen() checks sk_shutdown and subsequently
   calls vsock_enqueue_accept() without holding the parent socket lock.
   This means a child socket can be enqueued after __vsock_release() has
   already flushed the queue, causing the child socket and its associated
   resources to leak
   permanently. The existing comment in the code hints at this race but
   the fix was never implemented.

Fix both issues: add sk_acceptq_removed() on the transport error path,
and re-check sk->sk_shutdown under the parent socket lock before calling
vsock_enqueue_accept() to close the race window. The child socket lock
is released before acquiring the parent socket lock to maintain correct
lock ordering (parent before child).

Reported-by: syzbot+1b2c9c4a0f8708082678@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=1b2c9c4a0f8708082678
Tested-by: syzbot+1b2c9c4a0f8708082678@syzkaller.appspotmail.com
Signed-off-by: Deepanshu Kartikey <kartikey406@gmail.com>
---
 net/vmw_vsock/virtio_transport_common.c | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/net/vmw_vsock/virtio_transport_common.c b/net/vmw_vsock/virtio_transport_common.c
index 416d533f493d..fad5fa4a4296 100644
--- a/net/vmw_vsock/virtio_transport_common.c
+++ b/net/vmw_vsock/virtio_transport_common.c
@@ -1578,6 +1578,7 @@ virtio_transport_recv_listen(struct sock *sk, struct sk_buff *skb,
 	 */
 	if (ret || vchild->transport != &t->transport) {
 		release_sock(child);
+		sk_acceptq_removed(sk);
 		virtio_transport_reset_no_sock(t, skb, sock_net(sk));
 		sock_put(child);
 		return ret;
@@ -1588,11 +1589,19 @@ virtio_transport_recv_listen(struct sock *sk, struct sk_buff *skb,
 		child->sk_write_space(child);
 
 	vsock_insert_connected(vchild);
+	release_sock(child);
+	lock_sock(sk);
+	if (sk->sk_shutdown == SHUTDOWN_MASK) {
+		release_sock(sk);
+		sk_acceptq_removed(sk);
+		virtio_transport_reset_no_sock(t, skb, sock_net(sk));
+		sock_put(child);
+		return -ESHUTDOWN;
+	}
 	vsock_enqueue_accept(sk, child);
+	release_sock(sk);
 	virtio_transport_send_response(vchild, skb);
 
-	release_sock(child);
-
 	sk->sk_data_ready(sk);
 	return 0;
 }
-- 
2.43.0

