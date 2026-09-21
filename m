Received: from mail-qk2-f41.google.com (mail-qk2-f41.google.com [74.125.230.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E2F4321F5F
	for <virtualization@lists.linux.dev>; Mon, 21 Sep 2026 02:53:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.230.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789959232; cv=none; b=fi5R8GJL5St1H268Y4jX2fMKOG/hfpfmgO7ZiX3stcgsm3Am0jxayqvkokn8rMX1oAsbZnCh/IpV1eRQ1RvVxPoU+GIO6vUZKUWMLrDCcR1euXyoti58oIYCP8ORyyz9ydFALu1RKRUpfp66vv3IpE9JlLjsWHq1Iol3xLOPwts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789959232; c=relaxed/simple;
	bh=1z8hxM5s9yvUWFN2dVotJ68WWyLuICEJqjli3GIQhLA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Z7hwGI3jYSkSLp2j0qWskyRcRnzvWLkhqk/sTGW/UUBUQbQtJQjASfQIGMnL/72t4hOmcStABqgNNqKmZ/bZNv5krD3Q+FINnP8fSw2vjVMKcU/EtgjyuzG1vOsMTYLxvtncljAUVvraYyYNl10UIHqEWjg6lBqWkYMJ4F9+17g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BHquYbeN; arc=none smtp.client-ip=74.125.230.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BHquYbeN"
Received: by mail-qk2-f41.google.com with SMTP id af79cd13be357-93bfd70b08cso108705785a.2
        for <virtualization@lists.linux.dev>; Sun, 20 Sep 2026 19:53:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789959229; x=1790564029; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Z/1dyv75kvDtXna7My+DxwKsoa7QIaIFxsslk0GYF3w=;
        b=BHquYbeNOKgOvhlpgphtlSkksDzlskCqyCpW447vPYoyG+HxDMboCeM2aL6KfRmp9f
         pYKPaqsoUsEfnxA3IiR+D1Fq9DjX+C33Q/x6ToLLTAtE74bWS8IjaoU08Lto7ZEHVD26
         CkKs41RllsdQgI01goz5w9CZEbX5SmVHohIeMQhBdU3D+o14+j0tsCciyLQQx2qLfRge
         XDI/h7qCjxQApCsPcULNDeyplJRvFuFQKiefg8Vx+FI2wY/Xo9MrPC/0fA79cq8Ouy3d
         YkN35SUInlzC0+568SNaFeZt+Q45GMeLHrSWxZPTdhCqCIi+7IKeyVPHKPFXboERx13D
         zQ0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789959229; x=1790564029;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Z/1dyv75kvDtXna7My+DxwKsoa7QIaIFxsslk0GYF3w=;
        b=QUN+q0Cccta88r7HzMFbouVQO1lGaVTdE5n0dAPT9ZQCY4DTJ0jHyQywfLG9hNbaS3
         xanNJGyUgj+mb8Ptrd1OOHpU3SGYKawV+94iyWR0v2PiZZjfqmmFLAkiLf+hghrhdyNA
         aswTx03g3pqZj9S9fW2ONxLLNgH1F8/2jXt2YFqHoxfI8PnBGnlPhrKjaOMEe7lMsBNg
         Haey9+Fy1EGbvQ14linsv2sDaPB3C2ofsxjRlqafjo5cTxNqCTa1G6EgtQ+jS/GChMQ3
         7xeGTt920VNQW3PjiItSECnSoHObMvXj3N1E+RCs0W2xDZMAqoFdwrcKYtDReA4VFCt1
         r1Tg==
X-Forwarded-Encrypted: i=1; AKwUvBx6Eb2dMnq0cyQR0bJjik5uGQ6ZhFaOl40JeIe3BCOWnxScXHEnV095hfYpRRIRiOnqMjvmQFjX/JAemw3j0Q==@lists.linux.dev
X-Gm-Message-State: AFuF++mZLW7i3e/g5w3gRusNFWsTmzQYITjun4OdkE8BCly7Ka0lEFk7
	M2XVZbiqjKo82QZ4qXMk1SVD5HjsjBiK3sdDmBvSew1ADoa9zRRFGIp3
X-Gm-Gg: AYBFou1fUx+PA3FL1n94FjnhJDVKr7G62P9gb0gczd5D8pLScv37QGGsGnUh1Z/Ho9m
	bSboLADYQ5udrSgHUyEO10Qvy4/POfX/Bj7EwGL29SY3K1tAlM0OPA6zwqr4eQbDGL5AbNaYKzl
	GmuSlHDGO7a8oyWdHAhNGJKKPhp8BgqPIycL9AVwVcKCNtnMMEHjJi/eYzy4wFewttNHDCrhYqT
	qD9wisM5DfWp97LgbCzr0hrMLm4Mzr6+t5jcNiEm6lC41Sk8wyiS6clkXrjD6/u+LsbRBYzk/w7
	Fdo9q7sIKu6FvHxPco7Xmmlfzq8uhrrtWQXRb+HWrPwvCGW73istWfz0YyEXyR8/4SY03Wgg75z
	QkkVUEu5VlOZXENnNOS2XcAgGJzoBZ6IBH8C2MGKyd3+NzqVfvGOHwlytaM+OLDiEFVtdKkHiZd
	5E4sF6TNu04UUvV2x+uWev0LNSMuVBY/ZmgmLsAws5N2Rr3EtPjsj79DbNVR2ToezF4Cad5Tjuk
	Ncxdz8chwseeA0SCu2HKQIUkMpnnrXKoHW+z/gXgFdhEPf9PlWwdBCjohjzPniUvLoq7Q9X
X-Received: by 2002:a05:620a:3187:b0:939:d913:9a74 with SMTP id af79cd13be357-93bf56ef696mr809392485a.46.1789959228703;
        Sun, 20 Sep 2026 19:53:48 -0700 (PDT)
Received: from localhost.localdomain ([2601:155:4200:2c80:64b9:5e22:f77c:324e])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-93bedb3de58sm528732785a.37.2026.09.20.19.53.47
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sun, 20 Sep 2026 19:53:48 -0700 (PDT)
From: Paulos Yibelo <habte.yibelo@gmail.com>
To: netdev@vger.kernel.org
Cc: richard@nod.at,
	anton.ivanov@cambridgegreys.com,
	johannes@sipsolutions.net,
	willemdebruijn.kernel@gmail.com,
	jasowangio@gmail.com,
	mst@redhat.com,
	eperezma@redhat.com,
	xuanzhuo@linux.alibaba.com,
	andrew+netdev@lunn.ch,
	pablo@netfilter.org,
	fw@strlen.de,
	phil@nwl.cc,
	razor@blackwall.org,
	idosch@nvidia.com,
	dsahern@kernel.org,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	linux-um@lists.infradead.org,
	virtualization@lists.linux.dev,
	netfilter-devel@vger.kernel.org,
	coreteam@netfilter.org,
	bridge@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH net v5 0/2] net: prevent partial checksums from modifying network headers
Date: Sun, 20 Sep 2026 22:53:39 -0400
Message-ID: <20260921025341.44846-1-habte.yibelo@gmail.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20260920004733.6473-1-habte.yibelo@gmail.com>
References: <20260920004733.6473-1-habte.yibelo@gmail.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

A virtio-net header can supply CHECKSUM_PARTIAL metadata whose checksum
start resolves inside the network header after link-layer removal.
Software checksum completion can then modify header bytes which the stack
has already parsed.

Patch 1 validates the checksum start against an explicit data-relative L3
origin. It covers TUN/TAP, virtio-net, AF_PACKET, UML, nested VLAN
headers, and tunnel metadata. It does not rely on skb header state which
may not yet be established.

Patch 2 independently validates the checksum start against the parsed
IPv4 or IPv6 header length in all four IP fragmentation implementations
which complete partial checksums.

The v4 Sashiko findings were correct. Patch 1 used
skb_network_offset() before all receive callers had established it.
Patch 2 compared a signed checksum offset with an unsigned IPv4 header
length. This revision fixes both findings and covers the corresponding
bridge and IPv6 fragmentation paths.

Validation included strict checkpatch, focused x86 and UML W=1 builds,
an offset-boundary model, and application of the exact mail series to the
stated base.

Changes in v5:
- Pass an explicit data-relative L3 origin through the virtio-net
  converter and audit every in-tree caller.
- Parse Ethernet and nested VLAN headers without mutating skb header
  state.
- Propagate virtio-header conversion failures in UML.
- Keep the IPv4 comparison signed and add matching parsed-header checks
  to the IPv4/IPv6 output and bridge-netfilter fragmentation paths.
- Drop Michael S. Tsirkin's Acked-by and David Ahern's Reviewed-by tags
  because both patches changed materially.

Link: https://lore.kernel.org/netdev/20260920004733.6473-1-habte.yibelo@gmail.com/

Paulos Yibelo (2):
  net: validate virtio checksum start after network header
  ip: reject partial checksums covering network headers

 arch/um/drivers/vector_transports.c        | 10 ++-
 drivers/net/tun_vnet.h                     | 28 +++++++-
 drivers/net/virtio_net.c                   |  8 ++-
 include/linux/virtio_net.h                 | 76 ++++++++++++++++++----
 net/bridge/netfilter/nf_conntrack_bridge.c | 21 ++++--
 net/ipv4/ip_output.c                       | 23 +++++--
 net/ipv6/ip6_output.c                      | 12 +++-
 net/ipv6/netfilter.c                       | 12 +++-
 net/packet/af_packet.c                     |  6 +-
 9 files changed, 157 insertions(+), 39 deletions(-)


base-commit: 1e24c4f2ee44be0eee94092b5d13cbdb4bdf0d60
-- 
2.46.0
