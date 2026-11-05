Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793879840;
	b=YFFxHKnGONy5YJGcrI8zJoiorXC5S9Bfw+8VBossXfdXPNOzxS2miRUaZ7Gmvi51HjmX
	 KuoWjiCYkfBTJzNrlwG/HyV5RzFCogZdWesta8ZglkWiVEJDSJg0LcGneCmr5jabOWsDs
	 pcfmk0TWMUIi9wgeBWazL13NhsI2o0XseB9j1wqy1JQKw2Xlx14LaYX7xCn037CKC/s3m
	 Xto2PT9MVylpHz75gvz+MkSei0rR+e5IygETBXWYQxtFRyixdF79PpgtVwz68YJ5VY/hC
	 odkFUUFWwN1WRNZo/U6+Xzu++wPuT5HHjmxtCiy7X/Hyh/T8SRW++c+Q/MRfe37GDIw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793879840;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding;
	bh=F6G9t9GJ7DVLr9Njw9/XT7m63JOY/MgP9W42o8JEQqg=;
	b=cRXbzPGqSGV8c1zEtvNoPFmTCkrXON4EnqVauDQ6JhEenQPwxZEg6zZl3lXc/uoYkOPI
	 eX800LJBB9OIKBVHca43GYNbbx0cyvHvaDd/zAvo0febsFlRGA5q35Z98V5M7mk4VWOUJ
	 7sPimZrHxZZh4DHGe4kmyUGdXbCjXuzfk53pvo0y0GGboK4Fs8rOepVDnWsJ7xQeLoltV
	 /TvLnNVdwh7Ho4K4plSZWmocsqnI3dj5tu9hDIlMrtlVAOGvUzf/zERnkwKJEkE0jl5o0
	 ZHQgTzaFklIUBARhRlJ8wYIqvH31tdhlmG0Sli1O+5E2SE8rlNu7G8wWhms1bEchKHw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=gNol07mm;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 424F4606A330;
	Thu,  5 Nov 2026 11:57:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=gNol07mm
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4BF671F0093A;
	Thu,  5 Nov 2026 11:57:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793879839;
	bh=F6G9t9GJ7DVLr9Njw9/XT7m63JOY/MgP9W42o8JEQqg=;
	h=From:To:Cc:Subject:Date;
	b=gNol07mm/1BVzOdNyQhgGB3oV51tTU10WzVuTQQ3MBY7MyaEehB5gIDvi8YQK+pQY
	 fZHCG35unbbbwEb0OtzkQEXhKkMUl3bYEzVTIgiXm00YHkMdzbISpwSYEY39ANnv06
	 FB0IluJpQqLyrH3Pngf+GyVQsz+dREFbDLMyTMtH5+qibnlYuqftUSqAwz3NTZL5Hj
	 34bEmVIVZm+EKHThjZWOGliWdnV/lrv6cd/ePOZ6oYLQr45lLvJJqHJYLffOB5C2i9
	 XKhDvMgc0WLPsoKXi9rZLZXPhnqfDVwDniU5U//bDbFuHyLqe9FGnrb9aTkhy+KE0y
	 QP80PBKZBi3Sw==
From: Eric Dumazet <edumazet@kernel.org>
To: netdev@vger.kernel.org,
	"David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Eric Dumazet <edumazet@kernel.org>,
	Simon Horman <horms@kernel.org>,
	Willem de Bruijn <willemb@google.com>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowangio@gmail.com>,
	=?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>,
	Hassan Sultan <hassansultan@google.com>,
	virtualization@lists.linux.dev
Subject: [PATCH net v3 0/8] net: virtio: validate outer protocol of UDP tunnel GSO packets
Date: Thu,  5 Nov 2026 12:57:07 +0100
Message-ID: <20261105115715.1466924-1-edumazet@kernel.org>
X-Mailer: git-send-email 2.53.0
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

virtio_net_hdr_tnl_to_skb() does not check that a UDP tunnel GSO
packet really has outer IPv4/IPv6 and UDP headers matching the
declared tunnel type. A guest, or any tap writer, can send a frame
with another outer ethertype (NSH in the report), and the GSO stack
then builds segments with skb->data before skb->head. The host
crashes in skb_under_panic() as soon as a header is pushed.

Patch 1 validates the outer headers, using the parsing helpers from
Michael's series "net: resolve uncommon partial checksums at ingress",
as Willem suggested. The rest of that series (checksum validation and
completion) is left to Michael.

Patch 2 lets the callers tell whether frames start with an Ethernet
header, instead of using the device type, which tun can change with
TUNSETLINK.

Patch 3 clears a stale skb->protocol left on recycled NAPI frags skbs,
which could make the checks of patch 1 reject valid frames.

Patch 4 fixes a selftest helper computing UDP checksums over a length
in network byte order.

Patches 5 to 7 add tun selftests, on tap and IFF_TUN devices: valid
outer IPv4/IPv6 frames are accepted; mismatched or non-UDP outer
headers and misplaced outer transport headers are rejected, also on
retyped devices.

Patch 8 makes the UDP tunnel selftests write the tunnel offsets of the
virtio header in little endian, so they work on big-endian hosts.

v3:
- Patch 1: fix a comment, ipv6_find_hdr() stops at AH (Sashiko).
- New patch 2, and its tests in patch 6: Sashiko found that changing
  the device type with TUNSETLINK bypasses the checks of patch 1.
- New patch 3: Sashiko found that napi_reuse_skb() leaves a stale
  skb->protocol on IFF_NAPI_FRAGS skbs.
- New patch 7: test cases Sashiko found missing in patch 5 (outer
  IPv6, VLAN with IPv6 or with a wrong outer_th_offset, non-UDP outer
  L4). Fixed the patch 5 changelog.
- New patch 8: big-endian hosts (Sashiko).
- Collected Reviewed-by and Acked-by tags.

v2: https://lore.kernel.org/netdev/20261104050131.629967-1-edumazet@kernel.org/
- Patch 1: use Michael's helpers instead of a new one: find the L3
  header from the device type instead of assuming Ethernet when
  skb->protocol is unset, do not trust skb->protocol when it disagrees
  with the frame, and require UDP exactly at outer_th_offset. Stop at
  IPv6 AH headers (Willem).
- Patch 2: clear udph->check before summing and send 0xffff instead
  of a zero checksum (Willem).
- Patch 3: clear the reused buffer before building each frame (Willem).
  Add IFF_TUN tests, where skb->protocol comes from the tun_pi header.

v1: https://lore.kernel.org/netdev/20261103203113.550604-1-edumazet@kernel.org/

Eric Dumazet (8):
  net: virtio: validate outer protocol of UDP tunnel GSO packets
  net: virtio: do not use dev->type to find the outer L3 header
  tun: clear stale skb->protocol of NAPI frags skbs
  selftests: net: tuntap: fix UDP checksum length in
    build_udp_packet_csum()
  selftests: net: tun: test outer protocol of UDP tunnel GSO packets
  selftests: net: tun: test UDP tunnel GSO on retyped devices
  selftests: net: tun: test more outer header mismatches of UDP tunnel
    GSO
  selftests: net: tuntap: write UDP tunnel offsets in little endian

 drivers/net/tun.c                            |  14 +-
 drivers/net/tun_vnet.h                       |   5 +-
 drivers/net/virtio_net.c                     |   2 +-
 include/linux/virtio_net.h                   | 169 +++++++
 tools/testing/selftests/net/tun.c            | 440 +++++++++++++++++++
 tools/testing/selftests/net/tuntap_helpers.h |  29 +-
 6 files changed, 649 insertions(+), 10 deletions(-)


base-commit: 37dfd0efbfffc20a57e41c2eb349ac49b1ca1ff8
-- 
2.53.0

