Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A988D148857
	for <virtualization@lists.linux-foundation.org>; Fri, 31 Jan 2025 08:40:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738312848; cv=none; b=hMIF7tY8XKfJyOGXfskfnwLA9Yu+fYzMGLkWbwW8sDEuGi+metOBtnPggL1IR5a4/ewBxS9n+NklAOgLbpAjBoPvcY/i0/Wvv5xjB+fL5Tliec4Y55AFTE3j+y4JNmfrZDzNOSG0djLDZFSf1kS7mxSbfjssU9YnS9pDIyNt9VQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738312848; c=relaxed/simple;
	bh=xHm2s7P70JY5Qu0aXhp98li90tCIbVggrWS8QRB9X1Q=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=sYRorGolooCsaIXLv6bRmrYf0GcdvaWxMrsuVF6t56JtP3+AUXaCA5xgr/j8cfk/mvZqzbF6SJXsh/eE2TNHRegcmV1aVV/XqHPlZab0OHuL9M3eRRbO7iJOntk9dz2brnQdKF354eNgPFLB+fCCRKYipjG9ZG6eh9doMjPEyII=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=swemel.ru header.i=@swemel.ru header.b=NSWoLVvD; arc=none smtp.client-ip=140.211.166.136
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=swemel.ru header.i=@swemel.ru header.b="NSWoLVvD"
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 40C066078C
	for <virtualization@lists.linux-foundation.org>; Fri, 31 Jan 2025 08:40:47 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -5.791
X-Spam-Level:
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id nwxiTZWnLFio for <virtualization@lists.linux-foundation.org>;
 Fri, 31 Jan 2025 08:40:46 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=95.143.211.150; helo=mx.swemel.ru; envelope-from=arefev@swemel.ru; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org A224860617
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=quarantine dis=none) header.from=swemel.ru
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org A224860617
Authentication-Results: smtp3.osuosl.org;
	dkim=pass (1024-bit key) header.d=swemel.ru header.i=@swemel.ru header.a=rsa-sha256 header.s=mail header.b=NSWoLVvD
Received: from mx.swemel.ru (mx.swemel.ru [95.143.211.150])
	by smtp3.osuosl.org (Postfix) with ESMTPS id A224860617
	for <virtualization@lists.linux-foundation.org>; Fri, 31 Jan 2025 08:40:45 +0000 (UTC)
From: Denis Arefev <arefev@swemel.ru>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=swemel.ru; s=mail;
	t=1738312299;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=aUhOHhddK40aufy6oIKd+VzJHIiJYORZ9iVNCbnihug=;
	b=NSWoLVvDGPhzZ9LS9ht63RTy35t7o1RJojJcjeBFHO4pniUvL3XmHtjLKOYwMCmD0a9Vec
	O20x9AWuyOKdaKlTnZdwLHy9nGwvgffvhVphLXD1UVXXGdehltuWOhDgsz34jDBGBzSWLg
	L4gpBMgxiGdR79SbzWU8SujhFlhMf7s=
To: stable@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: "Michael S. Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	"David S. Miller" <davem@davemloft.net>,
	Willem de Bruijn <willemb@google.com>,
	Eric Dumazet <edumazet@google.com>,
	virtualization@lists.linux-foundation.org,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	lvc-project@linuxtesting.org,
	syzbot+7f4d0ea3df4d4fa9a65f@syzkaller.appspotmail.com
Subject: [PATCH 5.10 4/5] net: add more sanity check in virtio_net_hdr_to_skb()
Date: Fri, 31 Jan 2025 11:31:37 +0300
Message-ID: <20250131083138.4221-1-arefev@swemel.ru>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Eric Dumazet <edumazet@google.com>

commit 9181d6f8a2bb32d158de66a84164fac05e3ddd18 upstream.

syzbot/KMSAN reports access to uninitialized data from gso_features_check() [1]

The repro use af_packet, injecting a gso packet and hdrlen == 0.

We could fix the issue making gso_features_check() more careful
while dealing with NETIF_F_TSO_MANGLEID in fast path.

Or we can make sure virtio_net_hdr_to_skb() pulls minimal network and
transport headers as intended.

Note that for GSO packets coming from untrusted sources, SKB_GSO_DODGY
bit forces a proper header validation (and pull) before the packet can
hit any device ndo_start_xmit(), thus we do not need a precise disection
at virtio_net_hdr_to_skb() stage.

[1]
BUG: KMSAN: uninit-value in skb_gso_segment include/net/gso.h:83 [inline]
BUG: KMSAN: uninit-value in validate_xmit_skb+0x10f2/0x1930 net/core/dev.c:3629
 skb_gso_segment include/net/gso.h:83 [inline]
 validate_xmit_skb+0x10f2/0x1930 net/core/dev.c:3629
 __dev_queue_xmit+0x1eac/0x5130 net/core/dev.c:4341
 dev_queue_xmit include/linux/netdevice.h:3134 [inline]
 packet_xmit+0x9c/0x6b0 net/packet/af_packet.c:276
 packet_snd net/packet/af_packet.c:3087 [inline]
 packet_sendmsg+0x8b1d/0x9f30 net/packet/af_packet.c:3119
 sock_sendmsg_nosec net/socket.c:730 [inline]
 __sock_sendmsg net/socket.c:745 [inline]
 ____sys_sendmsg+0x9c2/0xd60 net/socket.c:2584
 ___sys_sendmsg+0x28d/0x3c0 net/socket.c:2638
 __sys_sendmsg net/socket.c:2667 [inline]
 __do_sys_sendmsg net/socket.c:2676 [inline]
 __se_sys_sendmsg net/socket.c:2674 [inline]
 __x64_sys_sendmsg+0x307/0x490 net/socket.c:2674
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0x44/0x110 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x63/0x6b

Uninit was created at:
 slab_post_alloc_hook+0x129/0xa70 mm/slab.h:768
 slab_alloc_node mm/slub.c:3478 [inline]
 kmem_cache_alloc_node+0x5e9/0xb10 mm/slub.c:3523
 kmalloc_reserve+0x13d/0x4a0 net/core/skbuff.c:560
 __alloc_skb+0x318/0x740 net/core/skbuff.c:651
 alloc_skb include/linux/skbuff.h:1286 [inline]
 alloc_skb_with_frags+0xc8/0xbd0 net/core/skbuff.c:6334
 sock_alloc_send_pskb+0xa80/0xbf0 net/core/sock.c:2780
 packet_alloc_skb net/packet/af_packet.c:2936 [inline]
 packet_snd net/packet/af_packet.c:3030 [inline]
 packet_sendmsg+0x70e8/0x9f30 net/packet/af_packet.c:3119
 sock_sendmsg_nosec net/socket.c:730 [inline]
 __sock_sendmsg net/socket.c:745 [inline]
 ____sys_sendmsg+0x9c2/0xd60 net/socket.c:2584
 ___sys_sendmsg+0x28d/0x3c0 net/socket.c:2638
 __sys_sendmsg net/socket.c:2667 [inline]
 __do_sys_sendmsg net/socket.c:2676 [inline]
 __se_sys_sendmsg net/socket.c:2674 [inline]
 __x64_sys_sendmsg+0x307/0x490 net/socket.c:2674
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0x44/0x110 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x63/0x6b

CPU: 0 PID: 5025 Comm: syz-executor279 Not tainted 6.7.0-rc7-syzkaller-00003-gfbafc3e621c3 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 11/17/2023

Reported-by: syzbot+7f4d0ea3df4d4fa9a65f@syzkaller.appspotmail.com
Link: https://lore.kernel.org/netdev/0000000000005abd7b060eb160cd@google.com/
Fixes: 9274124f023b ("net: stricter validation of untrusted gso packets")
Signed-off-by: Eric Dumazet <edumazet@google.com>
Cc: Willem de Bruijn <willemb@google.com>
Reviewed-by: Willem de Bruijn <willemb@google.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
[Denis: minor fix to resolve merge conflict.]                                           
Signed-off-by: Denis Arefev <arefev@swemel.ru>                                    
---
Backport fix for CVE-2024-43817
Link: https://nvd.nist.gov/vuln/detail/cve-2024-43817
---
 include/linux/virtio_net.h | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/include/linux/virtio_net.h b/include/linux/virtio_net.h
index 62613d4d84b7..e9e681fab607 100644
--- a/include/linux/virtio_net.h
+++ b/include/linux/virtio_net.h
@@ -3,6 +3,8 @@
 #define _LINUX_VIRTIO_NET_H
 
 #include <linux/if_vlan.h>
+#include <linux/ip.h>
+#include <linux/ipv6.h>
 #include <linux/udp.h>
 #include <uapi/linux/tcp.h>
 #include <uapi/linux/virtio_net.h>
@@ -47,6 +49,7 @@ static inline int virtio_net_hdr_to_skb(struct sk_buff *skb,
 					const struct virtio_net_hdr *hdr,
 					bool little_endian)
 {
+	unsigned int nh_min_len = sizeof(struct iphdr);
 	unsigned int gso_type = 0;
 	unsigned int thlen = 0;
 	unsigned int p_off = 0;
@@ -63,6 +66,7 @@ static inline int virtio_net_hdr_to_skb(struct sk_buff *skb,
 			gso_type = SKB_GSO_TCPV6;
 			ip_proto = IPPROTO_TCP;
 			thlen = sizeof(struct tcphdr);
+			nh_min_len = sizeof(struct ipv6hdr);
 			break;
 		case VIRTIO_NET_HDR_GSO_UDP:
 			gso_type = SKB_GSO_UDP;
@@ -93,7 +97,8 @@ static inline int virtio_net_hdr_to_skb(struct sk_buff *skb,
 		if (!skb_partial_csum_set(skb, start, off))
 			return -EINVAL;
 
-		p_off = skb_transport_offset(skb) + thlen;
+		nh_min_len = max_t(u32, nh_min_len, skb_transport_offset(skb));
+		p_off = nh_min_len + thlen;
 		if (!pskb_may_pull(skb, p_off))
 			return -EINVAL;
 	} else {
@@ -133,7 +138,7 @@ static inline int virtio_net_hdr_to_skb(struct sk_buff *skb,
 
 			skb_set_transport_header(skb, keys.control.thoff);
 		} else if (gso_type) {
-			p_off = thlen;
+			p_off = nh_min_len + thlen;
 			if (!pskb_may_pull(skb, p_off))
 				return -EINVAL;
 		}
-- 
2.43.0

