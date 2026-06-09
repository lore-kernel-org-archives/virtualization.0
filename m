Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0B1721CC58
	for <virtualization@lists.linux.dev>; Tue,  9 Jun 2026 00:48:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780966105; cv=none; b=ERPdfHEGVBb+tqhzPlhYUs72Jy6k/dL60fwJrKYJLpJSvBJA3ewl5HTkVmiYuxiT+aizjtgmkWdlBSlWKfaY+3P2PS3z+OrUDMvr5TyIhUkvk148YJKb5yvMgSogEYDJUx5P3VP4fYozNE8kjG2sdK27CUV+TsHafnpdKHHYs1U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780966105; c=relaxed/simple;
	bh=37MPcfbmxnv7oFfJE4XBHYuIXMm5oEIMI1uGgOdOOVk=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=IEAdflUrn1RgtUgEnCjgx6VcOnsWKPw5ptIJHYvN/NjBK0WYv5QjOrc+T7W9gnhy0idrGts7V/Pe0Mc7TbCJe4yuJeosjgqlVZyzaYeWuJ4IX15rDL2HjU9oFkDxKQ/nMfIe8EBILo2ScaGE31LZcZjhSRas+uCg32nKBps7Ihw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--tavip.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=XxQ3lYKv; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--tavip.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="XxQ3lYKv"
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-842cb4c62f9so1879760b3a.0
        for <virtualization@lists.linux.dev>; Mon, 08 Jun 2026 17:48:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780966104; x=1781570904; darn=lists.linux.dev;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=StLjLCmXgF4Q/Ry3fnTHjp2FbwAsDgAHQZYkD5rM9oc=;
        b=XxQ3lYKvvRG6zrHMaaEQQnGQo5pBvzUAa08MV28YU1I1fA9QfhINVSwM8Dg8h7C+/I
         8MtAv99h1vXWLRBZGcsMhB+EO6zgZjXA6lBQz3ZNsWcNplTJ5+7V/OltHXS+bYUYP1Hq
         P5AMy0vZvHXMWlBhNfoX+sUNpA6/pGd2fUUFJ7XDMqw6P0VAL5tImGkZWzfLcYStkDyd
         sR3BkAf5znwhyO5HCHBD58HeJlAy4kb5obrQJEhqPujiboMNSwXH3PRS26A7A8Y8i6st
         ow5+CHqGDepjW6nVhC1vD870n3cdVwnvt1nHJ4jbT4Pb6sNkOm3iowpwAPgRo8S8q3ta
         v2Bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780966104; x=1781570904;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=StLjLCmXgF4Q/Ry3fnTHjp2FbwAsDgAHQZYkD5rM9oc=;
        b=Nvv4U9l4zWcvE0O7BWSuaD6T8E8WSGceESH9Zn99lP3EwIPT1qRajU9JUFDhscl1kO
         sqHKa9u1a29ZVvRtU9TKIgeCXVz5RS9+SQ/BugxCNEGfFCzPYiciPbySeMlRPHEa9wxA
         c+Fcw2heG8vBGPi0KVu8fgm9ipE9OPalnEHOjOczkEVoGt4hnvoC8vCdGSD16fvXjkkA
         ew2n/gqV6IvKelgEOabLuSaG2bBpkRfFK/dkvgRZYUclkRcNUPKvj07FS5KofoMnAZio
         enrAQROe3Q4RA4zJiWgtHfGsC1EQjK5UhAH0uvvoDs+cpPvG/Cha5IQ6K82Duw6cve/9
         ULzg==
X-Forwarded-Encrypted: i=1; AFNElJ+K2IWRo2BhtUzBTptaP1K1y933kV6B3T+8IeoQ7iSPA6JFZb0kWFDCacBmelRjVi++g262qMXjSDPrAFaY0w==@lists.linux.dev
X-Gm-Message-State: AOJu0Yx6Mj8mk2GRgzf/t6+ar40oz3yzznMWh++47ys1HovEYPTm5kI/
	JkMQYDg7A9xvmkLZn/LBUM9SnaWvGCmByzJyptmmHZMi2SzyvBAYRkUxhqLOmt8xB4JGyb0+GnK
	ZIA==
X-Received: from pfjd3.prod.google.com ([2002:a05:6a00:2443:b0:842:33b9:bdf8])
 (user=tavip job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:a201:b0:842:6293:fc43
 with SMTP id d2e1a72fcca58-842b66aa645mr12846516b3a.15.1780966103837; Mon, 08
 Jun 2026 17:48:23 -0700 (PDT)
Date: Tue,  9 Jun 2026 00:48:05 +0000
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
X-Mailer: git-send-email 2.54.0.1064.gd145956f57-goog
Message-ID: <20260609004809.1285028-1-tavip@google.com>
Subject: [PATCH net] vsock/virtio: restore msg_iter on transmission failure
From: Octavian Purdila <tavip@google.com>
To: netdev@vger.kernel.org
Cc: Octavian Purdila <tavip@google.com>, syzbot+28e5f3d207b14bae122a@syzkaller.appspotmail.com, 
	Stefan Hajnoczi <stefanha@redhat.com>, Stefano Garzarella <sgarzare@redhat.com>, 
	"Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, 
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
	"=?UTF-8?q?Eugenio=20P=C3=A9rez?=" <eperezma@redhat.com>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Simon Horman <horms@kernel.org>, Arseniy Krasnov <avkrasnov@salutedevices.com>, kvm@vger.kernel.org, 
	virtualization@lists.linux.dev, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

When transmission fails in virtio_transport_send_pkt_info, the msg_iter
might have been partially advanced. If we don't restore it, the next
attempt to send data will use an incorrect iterator state, leading to
desync and warnings like "send_pkt() returns 0, but X expected".

Specifically, this can happen in the following scenario, triggered by
the syzkaller repro:

1. A write-only VMA (PROT_WRITE only) is partially populated by a
   prior TUN write that failed with -EIO but still faulted in some
   pages).
2. A vsock sendmmsg call with MSG_ZEROCOPY requests transmission of a
   buffer from this VMA.
3. The first packet (64KB) is sent successfully because the pages are
   populated.
4. The second packet allocation fails because GUP fast pins the first page
   but GUP slow fails on the next unpopulated page due to PROT_WRITE-only
   permissions.
5. The iterator is advanced by the partially successful GUP (68KB total
   advanced: 64KB from first packet + 4KB from second), but the send loop
   breaks and only reports 64KB sent. This creates a 4KB desync.
6. The next retry starts with a non-zero iov_offset, disabling zerocopy
   and falling back to copy mode.
7. In copy mode, the transmission succeeds for the next packets but
   exhausts the iterator early because of the desync.
8. The final retry sees an empty iterator but zerocopy is re-enabled
   (offset resets). It attempts to send the remaining bytes with zerocopy
   but pins 0 pages, creating an empty packet.
9. The transport sends the empty packet, triggering the warning because
   the returned bytes (header only) do not match the expected payload size.
10. The loop continues to spin, allocating ubuf_info each time, eventually
    exhausting sysctl_optmem_max and returning -ENOMEM to userspace.

Restore msg_iter to its original state before the packet allocation
and transmission attempt if they fail.

Fixes: e0718bd82e27 ("vsock: enable setting SO_ZEROCOPY")
Reported-by: syzbot+28e5f3d207b14bae122a@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=28e5f3d207b14bae122a
Assisted-by: gemini:gemini-3.1-pro
Signed-off-by: Octavian Purdila <tavip@google.com>
---
 net/vmw_vsock/virtio_transport_common.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/net/vmw_vsock/virtio_transport_common.c b/net/vmw_vsock/virtio_transport_common.c
index b10666937c490..588623a3e2bbc 100644
--- a/net/vmw_vsock/virtio_transport_common.c
+++ b/net/vmw_vsock/virtio_transport_common.c
@@ -367,6 +367,10 @@ static int virtio_transport_send_pkt_info(struct vsock_sock *vsk,
 	do {
 		struct sk_buff *skb;
 		size_t skb_len;
+		struct iov_iter saved_iter;
+
+		if (info->msg)
+			saved_iter = info->msg->msg_iter;
 
 		skb_len = min(max_skb_len, rest_len);
 
@@ -375,6 +379,8 @@ static int virtio_transport_send_pkt_info(struct vsock_sock *vsk,
 						 src_cid, src_port,
 						 dst_cid, dst_port);
 		if (!skb) {
+			if (info->msg)
+				info->msg->msg_iter = saved_iter;
 			ret = -ENOMEM;
 			break;
 		}
@@ -382,8 +388,11 @@ static int virtio_transport_send_pkt_info(struct vsock_sock *vsk,
 		virtio_transport_inc_tx_pkt(vvs, skb);
 
 		ret = t_ops->send_pkt(skb, info->net);
-		if (ret < 0)
+		if (ret < 0) {
+			if (info->msg)
+				info->msg->msg_iter = saved_iter;
 			break;
+		}
 
 		/* Both virtio and vhost 'send_pkt()' returns 'skb_len',
 		 * but for reliability use 'ret' instead of 'skb_len'.
-- 
2.54.0.1064.gd145956f57-goog

