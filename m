Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793768504;
	b=tVS4dikqE70KF780EkQtIlYT/kl+7tbYiOVoK+/VBQx3tLb2FlLjF8U/Y+6DxwERENXd
	 fe/uFkN8wFh5rsUYjwXXGmr2J3/ye61suhbClI4mgOAN2yNPI3ioHGTjiq/l/8qtR7HAN
	 mDHrKvX47SKU4TcSQiEwTf/fxFxONg9Ig8dGgUGBHW2YezGfEg10CKiOjtfocCK1u13J7
	 mcyrHBoNGYTbU9FKMqq42OzoVTssPtinTElvT16PX5EWgkW4Ri7MyQ7OfgC0A20fE7d4Q
	 Oy/Q0tOPlnCsJs4N7G0czmwh8YraRrcCACGxv19Pkyhysf8Rv12NO0mX76BGgJys1kQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793768504;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=5GMAqY7FM6ZAQr9W6BNb+fX/DcRpx409vq4+uvPz0kM=;
	b=Xxs9HmOgCsKZtFPK7Ne9OBSaiXd2nmRKjPyGditGiDAtv4af+Pl6F/4bsmwt6MLN+U6h
	 RbyWY0/O0lUC2/KqOSOtTDkDHoL5fj7ULpQjjD6m3UF5dGtf1VutSrAV0ysV13GphwzjZ
	 7MR64CVxpPh54gUlyXb0GUoiBjExfGmM0H0TjhGwoBMH+zokrz+5FWey81iwbxcqUlUGp
	 sVLr/Rvz4AX2xWbpqDpJZW8Hr629/sgjcZyYNb/yYSdJ/RN+bchY7Ir4ixlIQkx+kDIBc
	 vsXrl2BebQB3fMZvom70k/HqdD45RH46TDSiiOm5afwPdUYNh6HIPAUBjRTsO/rzcnw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=LRJlvdw2;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65764606A329;
	Wed,  4 Nov 2026 05:01:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=LRJlvdw2
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A45DB1F000C1;
	Wed,  4 Nov 2026 05:01:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793768504;
	bh=5GMAqY7FM6ZAQr9W6BNb+fX/DcRpx409vq4+uvPz0kM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=LRJlvdw25Xn4b3ldmZixbHRHdB75iJJps7HrEj5OLHlxh6QvGS13Ce74HnCf/H5aa
	 +iBXWoI2Lxhn7mUL4CeWdc7d25IdJnKGLScCeY2HNCPIXpyz7me/R6XXULkAzjlhrM
	 sWzk0Hqc/EVlc9xyQJfR3WUEbyO76ryKPFC81tu+mw+KirEFUerNvwEtlTyHTskn0A
	 k2B71zGp9Jxs9GA8OjLDXfhcYf2+MHnBk0SKJQ+PYuQH67PcPPI6zsdc1/DtwMeWpg
	 d3lKDC7TcxTzFY03h6G7cbT0YbGv//y8pZRoCxzOVljMKQTbBaT4X/pH+8EgJUaKOx
	 g8Ombk6P3rLqg==
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
Subject: [PATCH net v2 2/3] selftests: net: tuntap: fix UDP checksum length in build_udp_packet_csum()
Date: Wed,  4 Nov 2026 06:01:30 +0100
Message-ID: <20261104050131.629967-3-edumazet@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261104050131.629967-1-edumazet@kernel.org>
References: <20261104050131.629967-1-edumazet@kernel.org>
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

