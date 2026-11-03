Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793737889;
	b=GjR/nr3kor1DitOeIQu4dRCssLUJrCh7QZGrNlcPsCn8ibGjLPoMtOrDigiy4j4xBTFe
	 1st4Dx+Zm3ccTEvHOOvOHiC4fKnOIi1F5mE1CZlZBILLbmNx8/SEUx7z1sIcR0mOBVAvG
	 x8Sjy+48GAkeZIweKIxnPLj89Kez0pJG56tptr9KnbKtY+syQXhOyp45bR28ebQvahXed
	 lgYNefk2ACNkEDkiGUVbp3sdpKI07kAowCPBxwBL2tWAAC9t2x08iSeBCCGKPTTi0BvHn
	 VRu17h9lhwMe0gbdOKTkPI+bjyW8Q9qHZP+3BSzRqSfmK4gOuCg4l+Kuc6RxAUgn7SA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793737889;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=VFNRxIvcxkzTqlqpdT20AbjU9YSCGoaOHPbKbT6QSgE=;
	b=WWar4zF/C53iMsFr2K5P3fHp9f2Pz8FJ2bIta3OoACWpylJfupZ83NfunYC74H8F0nZW
	 35aWhPJSOAg9S2RiUS4oIrwt7X59lhPi2vCB2bDhOvLoB+jeiBUasW1M65oyhgi03Jjo8
	 RffPqHZW9YKj8arTB/odgoeuM8hJ7R3q4v+UfKOQw5V8arcNGIo10eZPchqsAsIp3Le8Y
	 UIpceW1UU/t7N45Q+SRwQQIaV8iUKkklOsz6neyunfKwW2XosphIq5U71wKKL2A0VOVgA
	 59zaH7cz1sQp83anp0nzS3TOqi5XE8PyTSSvkNndFtxajydNNPpE7uCIJf5JZvY5FnA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hPc8eIjS;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7727A606A331;
	Tue,  3 Nov 2026 20:31:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hPc8eIjS
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C8BB11F000C1;
	Tue,  3 Nov 2026 20:31:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793737889;
	bh=VFNRxIvcxkzTqlqpdT20AbjU9YSCGoaOHPbKbT6QSgE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=hPc8eIjSs8DSwNmTu/eaY8bIQPDvXy8te5In0lRkRse+crCdxEOhxrVSMHboloY2R
	 thf6fTyKQpmv757GJi+4yYewIeWtbyysnTB+6LSkJCuiDHKOQ1W8yCYXa0exigtSVO
	 wc/kDV08At7WilUaflEQQs7ytN/12CqjhUbsL6MvSGUHbJTpAulwnzAnVR7gI/1bsR
	 Qw5lTTB2QygCdtffCHva7zH/olKsaaIeWwNqlpNZDjWzzmzZoQCPpybyGE4jYji8Ca
	 EOOLpvqhuoqZfRDsZk/OsnUjg9t9GDG408qisIgFmtHVIHj2/29A8PSIznA7IENktX
	 63bJuykqiLYNw==
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
Subject: [PATCH net 2/3] selftests: net: tuntap: fix UDP checksum length in build_udp_packet_csum()
Date: Tue,  3 Nov 2026 21:31:12 +0100
Message-ID: <20261103203113.550604-3-edumazet@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261103203113.550604-1-edumazet@kernel.org>
References: <20261103203113.550604-1-edumazet@kernel.org>
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

Fixes: a942fcd72e97 ("selftest: tun: Introduce tuntap_helpers.h header for TUN/TAP testing")
Signed-off-by: Eric Dumazet <edumazet@kernel.org>
---
 tools/testing/selftests/net/tuntap_helpers.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/net/tuntap_helpers.h b/tools/testing/selftests/net/tuntap_helpers.h
index d6c0437136ec..ac9b2da57a6d 100644
--- a/tools/testing/selftests/net/tuntap_helpers.h
+++ b/tools/testing/selftests/net/tuntap_helpers.h
@@ -335,7 +335,7 @@ static inline void build_udp_packet_csum(uint8_t *buf, int family,
 	sum += htons(IPPROTO_UDP) + udph->len;
 
 	if (!csum_off)
-		sum += add_csum(buf, udph->len);
+		sum += add_csum(buf, ntohs(udph->len));
 
 	udph->check = finish_ip_csum(sum);
 }
-- 
2.53.0

