Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793879852;
	b=VWuXLcMP1Rmgt54VClRbDqe793DaqwT/4TIukJcwcv+CcSwTNxxwmieRoJlC1BSMHO4R
	 x+bbZ2ofHabpndGtM0Iea1JDZhvGis+kYT9HE3N1kvvn2w72wxab/YCr1VgK3+aN15fQv
	 Q9NzyAxPEgRaVbHNecWE07tUhPF9AuLPHOatuaIOwfZYWL9SXfbyYLuGhk5wikImgKIBY
	 gdsJapO8Djs5H+eMo0qp8yis3brysUDxkqH7qV5mTfNZ1b1K/44pr3B+ZnihX4bAxwU5h
	 PGY1TQzzr42liUHgckhk1b5IlLqA4pWHtnrQp+q+zTNhCaCTVIHp+UH56/ps3z37YEQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793879852;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=5GMAqY7FM6ZAQr9W6BNb+fX/DcRpx409vq4+uvPz0kM=;
	b=nbmJT0Eug1P/xkTzETA7xp6jPvsQvxz7F7gmVkK/NpCjJtTuz1QESVyieWKWfvSzi3/6
	 gQJEkY/vc2okwagbVtkwMB8+MAjcgRxEtnaY2dMFoxLWhw5b1TiqhWpFXYh1jCwdWtbBP
	 kP8UEvZGeGd5TyZbvBwZy0IUaxAFotM5IO6GeByhJxJgn8y4zaCKyBUnlSi1LSPjt2Ep7
	 wOhiSWwucYq1RuVJFCFy/2R7LvAsThhVEHH2X9ch08+s+X48n4gLdx6/i0/4+/KgNnYXd
	 cg9o3jOyhuMm//tcHH1U7M53jIHZJ5NZy/bwdcoNtN4Q4UqduzYYVPLCpkzTGQaOklA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=La0ow71c;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B1A8606D801;
	Thu,  5 Nov 2026 11:57:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=La0ow71c
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 96E9B1F0093A;
	Thu,  5 Nov 2026 11:57:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793879852;
	bh=5GMAqY7FM6ZAQr9W6BNb+fX/DcRpx409vq4+uvPz0kM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=La0ow71c/c7XYBluF2qRAhPZIWRij2839XlrQiQy94qLDeBhk8knhpNdo1TMXMc9W
	 z40UBp+m/aupTlC+czkll/ZnPlSnh5ANFHckNAreMDIV6NYE5QcT+ll/5tFjAzIINl
	 s8KO2VEgjp9RUVXWJ6Pla4N9FaPbfjnH9uGv0QVtwx88p9V6DL9hHwT/btTmXN4YU4
	 g5uOSYFD3S3N56TUHlLnO1oGq0r9s+CM1WA3tR3uF3rb2H+A92T+4S9quc19AAzyjJ
	 s+CZGKYeIO1qDcyCalURE3vhc4lbV/ADarRmHqpjIZlzhUXyyH8PeSLyOL9U7jphy3
	 /2PH4cd1Halhw==
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
Subject: [PATCH net v3 4/8] selftests: net: tuntap: fix UDP checksum length in build_udp_packet_csum()
Date: Thu,  5 Nov 2026 12:57:11 +0100
Message-ID: <20261105115715.1466924-5-edumazet@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261105115715.1466924-1-edumazet@kernel.org>
References: <20261105115715.1466924-1-edumazet@kernel.org>
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

build_udp_packet_csum() passes udph->len, which is in network byte
order, as the number of bytes to checksum. On little-endian hosts this
reads up to 64KB past the UDP header and computes a wrong checksum.

Existing callers did not crash only because they use packet buffers
of MAX_VNET_TUNNEL_PACKET_SZ bytes.

Use ntohs(udph->len), as tap.c does in its own build_udp_packet().

While at it, clear udph->check before summing instead of relying on
the caller, and send 0xffff instead of a computed zero checksum, as
the kernel does with CSUM_MANGLED_0.

Fixes: a942fcd72e97 ("selftest: tun: Introduce tuntap_helpers.h header for TUN/TAP testing")
Reviewed-by: Willem de Bruijn <willemb@google.com>
Signed-off-by: Eric Dumazet <edumazet@kernel.org>
---
 tools/testing/selftests/net/tuntap_helpers.h | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/net/tuntap_helpers.h b/tools/testing/selftests/net/tuntap_helpers.h
index d6c0437136ec..ecad83fae158 100644
--- a/tools/testing/selftests/net/tuntap_helpers.h
+++ b/tools/testing/selftests/net/tuntap_helpers.h
@@ -330,14 +330,22 @@ static inline void build_udp_packet_csum(uint8_t *buf, int family,
 	size_t ipalen = ip_addr_len(family);
 	uint32_t sum;
 
+	udph->check = 0;
+
 	/* No extension IPv4 and IPv6 headers addresses are the last fields */
 	sum = add_csum(buf - 2 * ipalen, 2 * ipalen);
 	sum += htons(IPPROTO_UDP) + udph->len;
 
 	if (!csum_off)
-		sum += add_csum(buf, udph->len);
+		sum += add_csum(buf, ntohs(udph->len));
 
 	udph->check = finish_ip_csum(sum);
+
+	/* A zero UDP checksum means no checksum: send 0xffff instead,
+	 * as the kernel does with CSUM_MANGLED_0.
+	 */
+	if (!csum_off && !udph->check)
+		udph->check = 0xffff;
 }
 
 static inline int build_udp_packet(uint8_t *buf, uint16_t sport, uint16_t dport,
-- 
2.53.0

