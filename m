Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=182.48.54.220
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795622817;
	b=u6FjZtdJ+RitAgZa8Y0Z3Y0IAqVBGLhBerMud/hlnM7t0v8XSFf9exYOMBC4qliimcue
	 y3J/jhECilh9wAZI/fpA7722h3s5XslFwAfkKcIgC9juBiTtF4JfoXRJ/sOpVjtzTRTZR
	 of4Sw24iBTBGX6S1dtj1T98SHYPezWpi6SWo9+2h+E4jq9p0sCB96viaCyd2PoY9pT1zm
	 hB403EY6WPgsWDyiHRoeIFUa4UpN+1pNEnGH8gJXIE8Iq/2HEt2YczOlKTUu1wlduwrwO
	 5Mf8Un00Fc12GQjPQKHEc13L/3zpEXXC4jN7xOMD9xu1f0hG+BTyfr09pDwN6K/Bprw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795622817;
	h=DMARC-Filter:Received:From:To:Cc:Subject:Date:Message-ID:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=tbHtq4u5qNw0coKzM67hn3NfizR9DRcO7y7V+ZSUs48=;
	b=uzuZXBrcXYbw9chQGERHOah619BlqxXCHMZ4wql/OvEViacBCtbGLfG+MgiQ0oxCMTIc
	 YZg9MTBvL8bGEOT/74uXoPin2Qi4OFhPmkKgIv0rFWdVT/i05Dyw1NV9a72sR6Wyt8OOP
	 hfgmmnSLQaCGazdwb5p3Ss8uLRkiUGgQaD4UsCGoHQi1wC4J3kSGPmOczqHKmWhdeoslr
	 cR5aRmk+xT4VYFhCDyFV8qaFHFaWU7Dgn+8+6KeDlfPuh0PfpT5fEvo6COzvb6UetEUau
	 dqZBZwqluKKJL3N0gZsJepjNpKiXpby8uD4z03iYwsQd/bT7cPLp2tAfmPZjpCLEAnQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=snowrabbit.org;
	spf=pass smtp.mailfrom=snowrabbit.org;
	arc=none smtp.remote-ip=182.48.54.220
Received: from bambi.snowrabbit.org (bambi.snowrabbit.org [182.48.54.220])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81B69606A33D
	for <virtualization@lists.linux.dev>; Wed, 25 Nov 2026 16:06:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 81B69606A33D
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=snowrabbit.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=snowrabbit.org
Received: by bambi.snowrabbit.org (Postfix, from userid 3001)
	id 2B33CC9300; Thu, 26 Nov 2026 01:06:55 +0900 (JST)
From: Showta Ishizaki <zakinko@snowrabbit.org>
To: "Michael S. Tsirkin" <mst@redhat.com>,
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
	Jason Wang <jasowangio@gmail.com>,
	netdev@vger.kernel.org
Cc: Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	"David S. Miller" <davem@davemloft.net>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Simon Horman <horms@kernel.org>,
	=?utf-8?q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Richard Weinberger <richard@nod.at>,
	Anton Ivanov <anton.ivanov@cambridgegreys.com>,
	Johannes Berg <johannes@sipsolutions.net>,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Randy Dunlap <rdunlap@infradead.org>,
	Chris Arges <carges@cloudflare.com>,
	Paulos Yibelo <habte.yibelo@gmail.com>,
	=?utf-8?b?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>,
	virtualization@lists.linux.dev,
	linux-um@lists.infradead.org,
	linux-doc@vger.kernel.org,
	Showta Ishizaki <zakinko@snowrabbit.org>
Subject: [PATCH RFC net v8 0/6] more virtio-net csum hardening
Date: Thu, 26 Nov 2026 01:06:41 +0900
Message-ID: <20261126.rfcv8.99797.0.zakinko@snowrabbit.org>
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Michael wrote in v7 that he would be on other things for a while and
posted it in case anyone wants to take it up, so here it is, rebased and
with the review comments addressed. Michael, if you already have a newer
version, I am happy to drop this one in favor of it. Patches 1-4 and 6
are yours; what I changed is noted above my sign-off.

Changes since v7:
- Rebased. Commit 73e08d50eb13 ("net: virtio: validate outer protocol of
  UDP tunnel GSO packets") has the header parsing helpers and the outer
  header checks, so those are gone from patch 4.
- Patch 4: has_eth is passed to virtio_net_hdr_to_skb() as well, instead
  of looking at the device type. I dropped Chris' Tested-by, as this is
  no longer what he tested.
- Patch 4: the tnl_csum_negotiated check is ahead of the validation
  again, as Willem pointed out.
- Patch 5 is new: the outer checksum of tunnel packets that are too small
  to segment. Willem asked for it as a separate patch.
- Patch 6: the sysctl does not turn off the outer header checks, which
  are in the tree unconditionally now. I turned the Reviewed-by tags into
  Cc, as that changes what was reviewed.

The two issues Michael listed as open in v7 are still open, hence the
RFC: the inner packet of a tunnel can have a valid header at
inner_nh_offset that overlaps the real transport header, and completing
the checksum at input breaks nf/BPF programs that edit the payload and
rely on CHECKSUM_PARTIAL.

I compared no patches, 1-4 and 1-6 on arm64 (qemu, TCG) with frames
written to a tap:

- Non-GSO UDP tunnel packets that ask for the outer checksum, over IPv4
  and IPv6, go out with a wrong one without the series and with 1-4, and
  with a correct one with 1-6.
- When the inner packet is a fragment, 1-4 reject them with EINVAL, and
  1-6 send them with a correct checksum.
- GSO behind an IPv6 AH is accepted without the series, and rejected
  with 1-4 and with 1-6.
- A plain UDP packet with csum_offset at the destination port is
  completed at input and counted in rx_csum_sw. One with good metadata is
  not counted.

The objects touched build on x86_64 with W=1 after each patch. At the end
of the series I also built the um objects, and linked an arm64 kernel
with CONFIG_INET=n and VIRTIO_NET=y.

Based on net e6474ead54b8, where the tests were run as well.

Michael S. Tsirkin (5):
  net: account for ingress-resolved virtio net hdr state
  um: vector: trim skbs before verifying the header
  virtio_net: parse tunnel csum_start little-endian
  net: resolve uncommon partial checksums at ingress
  net: add a sysctl to opt out of virtio net hdr checksum validation

Showta Ishizaki (1):
  net: virtio: compute the outer checksum of non-GSO tunnel packets

 Documentation/admin-guide/sysctl/net.rst |  19 ++
 arch/um/drivers/vector_kern.c            |   6 +-
 arch/um/drivers/vector_transports.c      |   4 +-
 drivers/net/tap.c                        |   4 +-
 drivers/net/tun.c                        |  44 +++-
 drivers/net/tun_vnet.h                   |   4 +-
 drivers/net/virtio_net.c                 |   2 +-
 include/linux/virtio_net.h               | 247 ++++++++++++++++++++++-
 include/net/netns/core.h                 |   1 +
 net/core/dev.c                           |   7 +
 net/core/net_namespace.c                 |   1 +
 net/core/sysctl_net_core.c               |  50 +++++
 net/packet/af_packet.c                   |  16 +-
 13 files changed, 381 insertions(+), 24 deletions(-)


base-commit: e6474ead54b8acecb8b0462dde2d77f46d2b7dc1
-- 
2.54.0
