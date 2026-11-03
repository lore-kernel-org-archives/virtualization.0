Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793737883;
	b=EfGIrxVLIqjcRtZRWbgTHo/EYbFuKjh/jW5Gg/2BOT57UnQgLkkTysjqUMt5rEkRcfmE
	 E+5xlCN+FVGeIM1560DdosE8NSSHUVqVXYOI44zi8pJc6m5u1g9XEmjKVxS5mjDUBrUiT
	 LNb3ogPtB6XzCyQbLWskrc+fRRMjUb+5vr5Kw2vLKz6X67qsCT/PZ4NAYqkls7u4tBNeB
	 RYr3QguadvMo5vpB00aMFF8ha+JnPB1JHQFskXwrl5Bv1m5UQilBd+hDlBOSn+FmcMSGk
	 sfwX2jCcN0z5C8eyJHswVwC0arRHHb3QljO2e042nI3uw3ohYTZ6xWeVNVT7xF3OM+A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793737883;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding;
	bh=vmzrb4/T0oqAjCmcKtvvEia+LGLPBUTmBoP8KRjFMHI=;
	b=PZ648idvTP8ubeL+n4uGaOr2utXbvTyoBoWpdJaeWL0mGQrrMhLPQLDromBXoqt4RsQf
	 OPKjeuU3ylpBS6h6WJvSFWBMNCHHDJ/IVEQgoZd17IY78tMNhZoS+3wAX/64taJhsmDbo
	 nceN8TpYPnNXspe4VR/O0iJnAcXnJtdv4R+krjY0P8Y6UqooO5kufz0GIATrzHoHC9soO
	 XSxfWz30kszYcBQc0VwMIBQnRYzBkw9FscFLPXXV+hoywVhqtzytBqr5fu+3HgiQF4cQp
	 YR4FouMARSSusHD6vaG23PdpbPAGmA5+F79lruHO8mjYsmcAy26OuyZcKtQD5/VZkyg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=dclSn7dQ;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECF4A606A31B;
	Tue,  3 Nov 2026 20:31:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=dclSn7dQ
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 665B61F000C1;
	Tue,  3 Nov 2026 20:31:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793737882;
	bh=vmzrb4/T0oqAjCmcKtvvEia+LGLPBUTmBoP8KRjFMHI=;
	h=From:To:Cc:Subject:Date;
	b=dclSn7dQPmlZeGTbOGUL6YLBP2Tg84gymyizEL204OCtU1GN2x9gVGV0o9sdQTCQb
	 snFdeN4ofyiGywmLP5LLn9FLp97RQOeOPqYM8IKhoLABvdmUMH6VCH+J/3wFWom5em
	 mSgqlbnkHkT/4SRHVI4gv/SU0KQs5Z5WcsepQnrqCssnt2IQ2EiQDYQxipT2uhc2ZV
	 iMnqvHwDPdUCWgwlR52zUTI//5emPNSZp+0XkKQYO+XEXeTgKh3RMlNP/0RmfkB8qJ
	 avSm1zbk5iB36oRFN3jeC/aIgMGcgAZBXAsW69RIw8pG7tVHjXzggKOgQ7qsvzh88m
	 zIikTeYaekpyQ==
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
Subject: [PATCH net 0/3] net: virtio: validate outer protocol of UDP tunnel GSO packets
Date: Tue,  3 Nov 2026 21:31:10 +0100
Message-ID: <20261103203113.550604-1-edumazet@kernel.org>
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
packet really has an outer IPv4/IPv6 header matching the declared
tunnel type. A guest, or any tap writer, can send a frame with another
outer ethertype (NSH in the report), and the GSO stack then builds
segments with skb->data before skb->head. The host crashes in
skb_under_panic() as soon as a header is pushed.

Patch 1 adds the missing check. Ethernet frames can carry VLAN tags
before the outer IP header; for IFF_TUN, skb->protocol is provided
by the caller.

Patch 2 fixes a selftest helper computing UDP checksums over a length
in network byte order.

Patch 3 adds tun selftests: valid outer IPv4 frames (plain and VLAN
tagged) are accepted, mismatched or non-IP outer headers are rejected.

Eric Dumazet (3):
  net: virtio: validate outer protocol of UDP tunnel GSO packets
  selftests: net: tuntap: fix UDP checksum length in
    build_udp_packet_csum()
  selftests: net: tun: test outer protocol of UDP tunnel GSO packets

 include/linux/virtio_net.h                   |  28 ++++
 tools/testing/selftests/net/tun.c            | 130 +++++++++++++++++++
 tools/testing/selftests/net/tuntap_helpers.h |   2 +-
 3 files changed, 159 insertions(+), 1 deletion(-)


base-commit: 647b81ddefc6364290e67bf33c89d54971f8995e
-- 
2.53.0

