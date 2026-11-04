Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793768498;
	b=VDy7K4AenIq4DV+9EZKRvCZalwmeVFvcAfcW1DGpT2B+cC2MEyxjCQ643WK1FJfDEITq
	 NA37vDB5Rh501C3i4aQyTAABZoOYjD/1vhSIMLgpaKqgDEiKE6I1ziQe7OElBReeMF9Ax
	 aD8fluZZbMu/Od7jIOYW9XLDGLFkgP6AEh8m/6uzqEJM8wFTHd++qj3GFtaT9An7gVgTZ
	 ZDJwHY60iP3uaHMZaAxmU3KHv099cu1j/gzT6pSZNv3ad8CceL6EDELTF0QMgZHGhXo6b
	 vbbuKV6zFBEg4NAgtBOt94OHYqC4hXiG2T3AK0qObPcsAIevJzTfMJGe0ajbKAqd5cQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793768498;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding;
	bh=0wPtjYOAhIeZugd2ESPq1FOUrzmTQoQ46TekB4ReUyc=;
	b=3i9/fY9YI70DvwMaB9hrIYuKWJAt1OtWdL5mTTIAdfsVIv06zKZWSiS51Vu0BKtkbuyd
	 G4o1KnTM3Gs9/bf7/GkPVaeVeOihJCYJsVM3j01T2Z1t/H0/USKv8K4F7w1dFzD0RfsjT
	 EVunKy9peDWnZViMOYKk7qWKgzNZiWtKkyypbHFxf50+O8CqRdzd1I6IiCdonJctStT1h
	 VcpYmH4k9W2jnrJtH3haP0YGcocQXAooutcYWS78XlwK3qMjZG1RyTN/Z0iF9jY8HOq8r
	 yz8zX9WaYNRyng0Ikba02Rl5w49Kk/KO26juYL6U9OrwFXrcvLaqDK565RTH9J1Y9Sg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=CtRmgpZy;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6BA7606A326;
	Wed,  4 Nov 2026 05:01:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=CtRmgpZy
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0095B1F000C1;
	Wed,  4 Nov 2026 05:01:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793768497;
	bh=0wPtjYOAhIeZugd2ESPq1FOUrzmTQoQ46TekB4ReUyc=;
	h=From:To:Cc:Subject:Date;
	b=CtRmgpZyrIgh/V5uGJm1gNFDDHYYe0cxTv3xIBOYXyhDknpdO5c/gPdu5Vro1Q05Y
	 2ltnQt3AjXx3RZWvDeItvo90XY7wVSpKMs8s3QduRRt5Yme/w9SYQ8Hj0et8Uzmn5F
	 PX2wBa5sqaYtZQt5MeEiAJc1PmA0gFUOg4mMSfSClOkUnFSd2bBxRT2aWbbFxEHAsa
	 XlExbJhunu+f3dtg93Bvi2nj9PSyM0BuCbn6Jpxn05X0QRKlKNN9RrNpNLIcXKs2oW
	 UOQqsBZdm9fcrM8z5ZkAqLYBJtC6Wyth3Klve/vgA2wLoayWFKizvvhL2IwZY7gqWx
	 RcOob2BdXvGNQ==
From: Eric Dumazet <edumazet@kernel.org>
To: netdev@vger.kernel.org,
	"David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Eric Dumazet <edumazet@kernel.org>,
	Simon Horman <horms@kernel.org>,
	Willem de Bruijn <willemb@google.com>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	=?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>,
	Hassan Sultan <hassansultan@google.com>,
	virtualization@lists.linux.dev
Subject: [PATCH net v2 0/3] net: virtio: validate outer protocol of UDP tunnel GSO packets
Date: Wed,  4 Nov 2026 06:01:28 +0100
Message-ID: <20261104050131.629967-1-edumazet@kernel.org>
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

Patch 2 fixes a selftest helper computing UDP checksums over a length
in network byte order.

Patch 3 adds tun selftests, on tap and IFF_TUN devices: valid outer
IPv4 frames (plain and VLAN tagged) are accepted, mismatched or non-IP
outer headers are rejected.

v2:
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

Eric Dumazet (3):
  net: virtio: validate outer protocol of UDP tunnel GSO packets
  selftests: net: tuntap: fix UDP checksum length in
    build_udp_packet_csum()
  selftests: net: tun: test outer protocol of UDP tunnel GSO packets

 include/linux/virtio_net.h                   | 169 ++++++++++++
 tools/testing/selftests/net/tun.c            | 269 +++++++++++++++++++
 tools/testing/selftests/net/tuntap_helpers.h |  10 +-
 3 files changed, 447 insertions(+), 1 deletion(-)


base-commit: 787268686c64be60023743b527645a907e38ccca
-- 
2.53.0

