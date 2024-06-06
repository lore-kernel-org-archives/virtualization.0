Received: from mx.swemel.ru (mx.swemel.ru [95.143.211.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33F33197537
	for <virtualization@lists.linux.dev>; Thu,  6 Jun 2024 14:14:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.143.211.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717683302; cv=none; b=RrqgSDRYpEC/VUKSctGMme74ZuUUZC6/dPw5YhBVapsaRMPR87Vy7pt0QXhY81qLdbgXSuT3r4ubkdZjyroJKMvSyP1hF1vAZbK2svifWI0+SL6yF0l7czpivLXGKQrueqE5oOe2bGjUyx2hXETeQIeOvg8Gd+5i5K9LhUtx9VY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717683302; c=relaxed/simple;
	bh=ZUbLJWzrVFp5hRr3gjeeVs7ODqsrEQjN+fQEaarZvnU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=BHQHiQskZ8v5/jP6M8oXj0mdbvlGpDzyUUb6h7KPG+YeI2q7q2E4169EoRay656D543amn0voEnBlQvC5pr3YyE8pZnlXdOhfxO0NPyBY14Q8ZFDvK9WVNyMmfDgj4MwpeNMLbA4GGw0NIYAf58aHSKFngdkkzo9QOK7eWllC+4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=swemel.ru; spf=pass smtp.mailfrom=swemel.ru; dkim=pass (1024-bit key) header.d=swemel.ru header.i=@swemel.ru header.b=UNkLxppg; arc=none smtp.client-ip=95.143.211.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=swemel.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=swemel.ru
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=swemel.ru header.i=@swemel.ru header.b="UNkLxppg"
From: Denis Arefev <arefev@swemel.ru>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=swemel.ru; s=mail;
	t=1717683290;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=+yI3L0DiCjO1k/d0iEefXHLYJTNXUYNikkROyQYFDhQ=;
	b=UNkLxppgn2wl6TMeleifbtKzoyEL6fmlzyUwnUEU+X4VQqCLsx3BpYeE9pWByUGoGG647/
	VKcUjiAEe+DzpQvU2DWMLB4UlJpsaEYVwcolOD5iFbvoNFVN5qYWM5n2qCeQrIkF+A0RiI
	mpFKuQWiBpRqPoRH8+LLK/uTQBhJDok=
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	=?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>,
	virtualization@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Eric Dumazet <edumazet@google.com>,
	lvc-project@linuxtesting.org
Subject: [PATCH] net: missing check
Date: Thu,  6 Jun 2024 17:14:50 +0300
Message-Id: <20240606141450.44709-1-arefev@swemel.ru>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Two missing check in virtio_net_hdr_to_skb() allowed syzbot 
to crash kernels again 

1. After the skb_segment function the buffer may become non-linear 
(nr_frags != 0), but since the SKBTX_SHARED_FRAG flag is not set anywhere
the __skb_linearize function will not be executed, then the buffer will 
remain non-linear. Then the condition (offset >= skb_headlen(skb))
becomes true, which causes WARN_ON_ONCE in skb_checksum_help.

2. The struct sk_buff and struct virtio_net_hdr members must be 
mathematically related.
(gso_size) must be greater than (needed) otherwise WARN_ON_ONCE.
(remainder) must be greater than (needed) otherwise WARN_ON_ONCE.
(remainder) may be 0 if division is without remainder.

offset+2 (4191) > skb_headlen() (1116)
WARNING: CPU: 1 PID: 5084 at net/core/dev.c:3303 skb_checksum_help+0x5e2/0x740 net/core/dev.c:3303
Modules linked in:
CPU: 1 PID: 5084 Comm: syz-executor336 Not tainted 6.7.0-rc3-syzkaller-00014-gdf60cee26a2e #0
Hardware name: Google Compute Engine/Google Compute Engine, BIOS Google 11/10/2023
RIP: 0010:skb_checksum_help+0x5e2/0x740 net/core/dev.c:3303
Code: 89 e8 83 e0 07 83 c0 03 38 d0 7c 08 84 d2 0f 85 52 01 00 00 44 89 e2 2b 53 74 4c 89 ee 48 c7 c7 40 57 e9 8b e8 af 8f dd f8 90 <0f> 0b 90 90 e9 87 fe ff ff e8 40 0f 6e f9 e9 4b fa ff ff 48 89 ef
RSP: 0018:ffffc90003a9f338 EFLAGS: 00010286
RAX: 0000000000000000 RBX: ffff888025125780 RCX: ffffffff814db209
RDX: ffff888015393b80 RSI: ffffffff814db216 RDI: 0000000000000001
RBP: ffff8880251257f4 R08: 0000000000000001 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000001 R12: 000000000000045c
R13: 000000000000105f R14: ffff8880251257f0 R15: 000000000000105d
FS:  0000555555c24380(0000) GS:ffff8880b9900000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 000000002000f000 CR3: 0000000023151000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 ip_do_fragment+0xa1b/0x18b0 net/ipv4/ip_output.c:777
 ip_fragment.constprop.0+0x161/0x230 net/ipv4/ip_output.c:584
 ip_finish_output_gso net/ipv4/ip_output.c:286 [inline]
 __ip_finish_output net/ipv4/ip_output.c:308 [inline]
 __ip_finish_output+0x49c/0x650 net/ipv4/ip_output.c:295
 ip_finish_output+0x31/0x310 net/ipv4/ip_output.c:323
 NF_HOOK_COND include/linux/netfilter.h:303 [inline]
 ip_output+0x13b/0x2a0 net/ipv4/ip_output.c:433
 dst_output include/net/dst.h:451 [inline]
 ip_local_out+0xaf/0x1a0 net/ipv4/ip_output.c:129
 iptunnel_xmit+0x5b4/0x9b0 net/ipv4/ip_tunnel_core.c:82
 ipip6_tunnel_xmit net/ipv6/sit.c:1034 [inline]
 sit_tunnel_xmit+0xed2/0x28f0 net/ipv6/sit.c:1076
 __netdev_start_xmit include/linux/netdevice.h:4940 [inline]
 netdev_start_xmit include/linux/netdevice.h:4954 [inline]
 xmit_one net/core/dev.c:3545 [inline]
 dev_hard_start_xmit+0x13d/0x6d0 net/core/dev.c:3561
 __dev_queue_xmit+0x7c1/0x3d60 net/core/dev.c:4346
 dev_queue_xmit include/linux/netdevice.h:3134 [inline]
 packet_xmit+0x257/0x380 net/packet/af_packet.c:276
 packet_snd net/packet/af_packet.c:3087 [inline]
 packet_sendmsg+0x24ca/0x5240 net/packet/af_packet.c:3119
 sock_sendmsg_nosec net/socket.c:730 [inline]
 __sock_sendmsg+0xd5/0x180 net/socket.c:745
 __sys_sendto+0x255/0x340 net/socket.c:2190
 __do_sys_sendto net/socket.c:2202 [inline]
 __se_sys_sendto net/socket.c:2198 [inline]
 __x64_sys_sendto+0xe0/0x1b0 net/socket.c:2198
 do_syscall_x64 arch/x86/entry/common.c:51 [inline]
 do_syscall_64+0x40/0x110 arch/x86/entry/common.c:82
 entry_SYSCALL_64_after_hwframe+0x63/0x6b

Signed-off-by: Denis Arefev <arefev@swemel.ru>
---
 include/linux/virtio_net.h | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/include/linux/virtio_net.h b/include/linux/virtio_net.h
index 4dfa9b69ca8d..77ebe908d746 100644
--- a/include/linux/virtio_net.h
+++ b/include/linux/virtio_net.h
@@ -56,6 +56,7 @@ static inline int virtio_net_hdr_to_skb(struct sk_buff *skb,
 	unsigned int thlen = 0;
 	unsigned int p_off = 0;
 	unsigned int ip_proto;
+	u64 ret, remainder;
 
 	if (hdr->gso_type != VIRTIO_NET_HDR_GSO_NONE) {
 		switch (hdr->gso_type & ~VIRTIO_NET_HDR_GSO_ECN) {
@@ -98,6 +99,15 @@ static inline int virtio_net_hdr_to_skb(struct sk_buff *skb,
 		u32 off = __virtio16_to_cpu(little_endian, hdr->csum_offset);
 		u32 needed = start + max_t(u32, thlen, off + sizeof(__sum16));
 
+		if (hdr->gso_size) {
+			ret = div64_u64_rem(skb->len, hdr->gso_size, &remainder);
+			if (!(ret && (hdr->gso_size > needed) &&
+						((remainder > needed) || (remainder == 0)))) {
+				return -EINVAL;
+			}
+			skb_shinfo(skb)->tx_flags |= SKBFL_SHARED_FRAG;
+		}
+
 		if (!pskb_may_pull(skb, needed))
 			return -EINVAL;
 
-- 
2.25.1

