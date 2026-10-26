Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=185.203.200.13
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793003366;
	b=BzJQp5hldfnOJCJHn49n4cDloP49VFOQL5D9RY3yfdkBDzUSfVtCCkGAiiM0JRcXpyX9
	 b93m1o3ZhUcXwiUVTWM9re6cWJJOjogqRAKp1b0x8D+kH2ZbMdwrbiYZQFu92awkp1jny
	 fwv5Rn2IiVytdUTeof7lFxXcANQNIo26Y3WHwsAQ67PR/QjfvGEGqyQM6b7FqnMWoRD9Y
	 25893+N7f+oY+3k3kdzH2CZLRkuDAwPf2B7HDqELvKZT1AiYiuuiOfA6lJWqMlVDAiRLZ
	 2jpcXbFoU/gH4KKSi3N4Xq+DbEipRf989HBCUK9gYu+81ycF+8pE/p2egD5gAPJ+MGw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793003366;
	h=DMARC-Filter:Received:DKIM-Signature:From:Subject:Date:Message-Id:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:X-B4-Tracking:
	 X-Change-ID:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=GiVdaEvIgA4WM/m7Nl7cDS3bF7MBeLPYnXCf5VwLEvA=;
	b=hRH8B1+QCzrwQZ/HClTqRhPlvWsuXyVYRC7wGwNWG0TJF82ebstUNdvUfX6rsczISow9
	 RUBDSa4DE8TnJwXLOJhNS1He1qy7oKtD2ZwyLuCXYCc14rcmzjSpKfuFLgeUifLIJY0D2
	 GatRIeYammgNzrPFd1dSfJgF3F1yajo5/yrDgA4tz2fkT+8s1yt9MjroSu7sDQIHga0lU
	 eWbh5ZC2N/EEba76Tu7fRd6yzdsXj7U0KA26EdTr2GGJsm0sZKz6qFqBuk2WSr5dxskNL
	 OseR6YQs40yQu+LYtNIWI53SWq8enCn8HYQM2kX/672C2p1yrMz4scrUvQ5vuahB7Bw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=none header.from=pengutronix.de;
	spf=pass smtp.mailfrom=pengutronix.de;
	dkim=pass header.d=pengutronix.de header.i=@pengutronix.de header.a=rsa-sha256 header.s=20260414 header.b=MQYrRpC3;
	arc=pass header.oldest-pass=0 smtp.remote-ip=185.203.200.13
Received: from mx1.white.stw.pengutronix.de (mx1.white.stw.pengutronix.de [185.203.200.13])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB1AE606A321
	for <virtualization@lists.linux.dev>; Mon, 26 Oct 2026 08:29:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CB1AE606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pengutronix.de header.i=@pengutronix.de header.a=rsa-sha256 header.s=20260414 header.b=MQYrRpC3
Received: from ratatoskr.trumtrar.info (unknown [IPv6:2a00:1f:f805:2b01:a03:2f4:308a:7b52])
	(Authenticated sender: str@pengutronix.de)
	by mx1.white.stw.pengutronix.de (Postfix) with ESMTPSA id 5BD1C200BB9;
	Mon, 26 Oct 2026 09:29:22 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1793003362;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=GiVdaEvIgA4WM/m7Nl7cDS3bF7MBeLPYnXCf5VwLEvA=;
	b=MQYrRpC3roMLni+e6ckN0JwD4PnhAyHRwJks8+h6UHgGG5M5QAHa/aVXZNOT2RjuIgZ20H
	+R4x+F+FmBa3Ee5UiGl3/2OONUND3XMnYpOoLW9NuzjLAR9EkdxLuk4CPl7DMT3bd+Rbks
	E1yTyph6WQ9VrOmYeajEMF7acXpfXplCV4KdXWsL3fSAHpVKgOP9Ay1z0xRWOnpNpFMq6P
	dP4mlBjJxpgEY3ej1BGQN+yYQ6VtS9YJ/7f0nQO5/GAIbVavkYB+h8U7rcJ5M4e+/4/eHZ
	J+/SshFbnZPLMksYWrZvY/eiPM8wamwHjLz6qWPT4nsABxUb/fmL7vJW4UL2/w==
ARC-Seal: i=1; s=20260414; d=pengutronix.de; t=1793003362; a=rsa-sha256;
	cv=none;
	b=gcVmUu0Yn6K9BAItJilndmQxA37gmxD13lGuzz1sV6BWzZAIIsa4dwcX2kIz/bycN2aLKN
	G8ndH8oK2TJux46CsANRo56uE3oQdkzZ7Xpmtbx6yZfi42mLHbE1rSMrqTqPzzVZNsxNn8
	BfHCvYzhrRwqSwxgWVvWcue6mzJ5Emd4EL24KQGBlhQcg5QTtgfYcQ4L2MbgpiDalYIQyN
	PunnKoCSPyMNCOhRWwHZPQ2m3rALD08Dj7kjApjIiME2yj02pBjO25jjs2rhk67Uc/z9lW
	XD2a1+8pouaxxaA753QthS+91lg53kzu2cjEE8+nX4EmQjXw+Sc1dJ1mpNE+7g==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=str@pengutronix.de smtp.mailfrom=s.trumtrar@pengutronix.de
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1793003362;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=GiVdaEvIgA4WM/m7Nl7cDS3bF7MBeLPYnXCf5VwLEvA=;
	b=WL2ByiQ+Mi1ziqMKYqZRg3wNuYyjwsJ7Aw0pHVZa+PFBO6CQJ+FKITMcqsW2XA0eQB+67n
	jqFbFWC+4qXUQvTVd/EV3/PknoJxzB/nGixyU+LdijN8IFgXr6qXDjoAzV4nLNdUwhdBMn
	wVvnLK67o4ZFb2o8WHPdrYChlLTut5fsAVfGoE/qhz5lUd4UCqRQbg1QkL+m1oFFLMe1Nn
	gurBM/P/QyH0nyWJPfpIM8h0wsaGTPSAWeDOiMTYFw8eZm/3WUvZso8ECEmjvf6C1vbsDG
	ICzAs/ZXCB7TcziOpf2SUEUK18oIYUXn9gUrT9OEpAeyo391ZxWti0FFIeMh1w==
From: Steffen Trumtrar <s.trumtrar@pengutronix.de>
Subject: [PATCH RFC v4 0/6] virtio-net: add receive timestamp support
Date: Mon, 26 Oct 2026 09:29:00 +0100
Message-Id: <20261026-v6-7-topic-virtio-net-ptp-v4-0-008af03cd43b@pengutronix.de>
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/43OvQ7CIBAH8FdpmD1ToK3oZGLiA7gahxZoewsQQ
 FLT9N0lJE4mxvF/H7+7lQTtUQdyqlbidcKA1uTQ7Coi595MGlDlTFjNOGVUQOrgANE6lJDQR7R
 gdAQXHXA15qFBNmOjSN53Xo+4FPtObtcLeeTijCFa/yr3Ei2tP+hEoQbZyyMbmBItZ2enzfSM3
 hpc9koXOvEP19VHRn9xPHOct7VoaX5XiC9u27Y3J4GLABsBAAA=
X-Change-ID: 20231218-v6-7-topic-virtio-net-ptp-3df023bc4f4d
To: "Michael S. Tsirkin" <mst@redhat.com>, 
 Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
 "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Richard Cochran <richardcochran@gmail.com>, 
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 =?utf-8?q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
 Jason Wang <jasowangio@gmail.com>, Alexei Starovoitov <ast@kernel.org>, 
 Daniel Borkmann <daniel@iogearbox.net>, 
 Jesper Dangaard Brouer <hawk@kernel.org>, 
 John Fastabend <john.fastabend@gmail.com>, 
 Stanislav Fomichev <sdf@fomichev.me>, Eric Dumazet <edumazet@kernel.org>
Cc: Steffen Trumtrar <s.trumtrar@pengutronix.de>, 
 virtualization@lists.linux.dev, netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, bpf@vger.kernel.org, kvm@vger.kernel.org
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=5137;
 i=s.trumtrar@pengutronix.de; h=from:subject:message-id;
 bh=JCkSwnWyfhmF4oek774qkyutXPcBdAVymbPc24mcOqQ=;
 b=owGbwMvMwCUmtVehiCsuTInxtFoSQ9Z9/gSZs8JSHa2pxoER80WVM0NnOfO+kPO4/nGxPKdco
 5joyZiOUhYGMS4GWTFFFpWFFXyiHh88I6eJcMHMYWUCGcLAxSkAE/F+wvA/aO3xzQxP5k181RUa
 +XHvsTezUxWenyu/8vHqx48teTnvljP8T5i+K1Z+pdey2Tx6N5pfbKnZHil+4qbpItMFk/cIxpm
 I8gAA
X-Developer-Key: i=s.trumtrar@pengutronix.de; a=openpgp;
 fpr=24A1780E1548F0495996140A1ABD20720A5E5622

This series picks up Willem de Bruijn's work on a virtio-net receive
timestamp. The device puts the time of arrival (TAI, ns) into the
virtio-net header so the guest can use it for PTP and RTT estimation
without taking the timestamp itself after the host-to-guest latency.

The series is an RFC. I am mostly interested in feedback on the
approach and on the wire format:

 - The timestamp is a new field at the end of virtio_net_common_hdr
   after outer_nh_offset and ipsec, offset 32 (see virtio spec),
   negotiated with VIRTIO_NET_F_RX_TSTAMP (bit 49). Header size now 40
   bytes.
   Willem noted on v3 that virtio_net_common_hdr was not meant to be
   extended this way; I kept it as the simplest approach, but a
   separate struct for the timestamp header is an option.
 - Timestamping is enabled at runtime with SIOCSHWTSTAMP; all
   supported rx filters behave the same for now.
 - XDP programs can read the timestamp with
   bpf_xdp_metadata_rx_timestamp().
 - vhost-net passes the feature through; the timestamp itself is
   written by tun. The tun patch is only meant as a reference
   implementation for the device side.
 - The timestamp is in TAI. The driver reports it as
   SOF_TIMESTAMPING_RAW_HARDWARE without a PTP clock (phc_index -1),
   so userspace cannot tell which clock it refers to and may compare
   it against CLOCK_REALTIME (currently off by 37s). Options I see:
   convert to the guest's system time in the driver (correct only if
   host and guest agree on the TAI offset), expose a PHC so the
   time base is explicit, or keep the raw TAI value and leave the
   conversion to userspace. Which one is preferred?
 - Like the existing rx_hash, the XDP timestamp callback locates the
   header relative to xdp->data, so it must be called before
   bpf_xdp_adjust_head().

A virtio spec change is needed as well and not yet proposed.

Testing: the feature needs a QEMU that knows VIRTIO_NET_F_RX_TSTAMP and
sets the matching vnet header size; see
https://github.com/strumtrar/qemu/tree/v11.0.1/virtio-rx-stamps

Performance: I measured the receive rate with 64 byte UDP packets in
a nested QEMU/KVM setup with vhost-net. The variance between runs is
larger than any difference between the variants (without the series,
series without the feature, feature negotiated, feature enabled), so
I cannot show a measurable cost or the absence of one. Numbers from
bare metal will follow with a non-RFC version.

Signed-off-by: Steffen Trumtrar <s.trumtrar@pengutronix.de>
---
Changes in v4:
- zero the header beyond the known fields on tx and in vhost
- grow padded_vnet_hdr for the 40 byte header (big packets)
- install xdp_metadata_ops if only RX_TSTAMP is negotiated
- rename VIRTIO_NET_F_TSTAMP to VIRTIO_NET_F_RX_TSTAMP
- move tstamp to offset 32 (header size 40) to match virtio spec layout
- drop XDP restriction for SIOCSHWTSTAMP, add xmo_rx_timestamp
- add static_asserts for header sizes
- add support in vhost
- move virtio_net_common_hdr to virtio_net.h
- Link to v3: https://patch.msgid.link/20260921-v6-7-topic-virtio-net-ptp-v3-0-3350851c4f88@pengutronix.de
Changes in v3:
- rework to use virtio_net_common_hdr instead of adding new struct
Changes in v2:
- rework patches to use flow filter instead of feature flag
- Link to v1: https://lore.kernel.org/r/20231218-v6-7-topic-virtio-net-ptp-v1-0-cac92b2d8532@pengutronix.de

To: Michael S. Tsirkin <mst@redhat.com>
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
To: David S. Miller <davem@davemloft.net>
To: Jakub Kicinski <kuba@kernel.org>
To: Paolo Abeni <pabeni@redhat.com>
To: Richard Cochran <richardcochran@gmail.com>
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Andrew Lunn <andrew+netdev@lunn.ch>
To: Eugenio Pérez <eperezma@redhat.com>
To: Jason Wang <jasowangio@gmail.com>
To: Alexei Starovoitov <ast@kernel.org>
To: Daniel Borkmann <daniel@iogearbox.net>
To: Jesper Dangaard Brouer <hawk@kernel.org>
To: John Fastabend <john.fastabend@gmail.com>
To: Stanislav Fomichev <sdf@fomichev.me>
To: Eric Dumazet <edumazet@kernel.org>
Cc: virtualization@lists.linux.dev
Cc: netdev@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Cc: bpf@vger.kernel.org
Cc: kvm@vger.kernel.org

---
Steffen Trumtrar (6):
      virtio-net: move virtio_net_common_hdr to virtio_net.h
      virtio-net: support receive timestamp
      virtio-net: assert header sizes
      vhost-net: support VIRTIO_NET_F_RX_TSTAMP
      virtio-net: add XDP rx timestamp metadata
      tun: add rx timestamp to the vnet header

 drivers/net/tun.c               |  14 ++--
 drivers/net/tun_vnet.h          |  18 +++--
 drivers/net/virtio_net.c        | 171 ++++++++++++++++++++++++++++++++++------
 drivers/vhost/net.c             |  17 +++-
 include/linux/virtio_net.h      |  30 +++++++
 include/uapi/linux/virtio_net.h |   1 +
 6 files changed, 214 insertions(+), 37 deletions(-)
---
base-commit: c03c1a14507dfaf8b856c2608f9ac216021fc222
change-id: 20231218-v6-7-topic-virtio-net-ptp-3df023bc4f4d

Best regards,
--  
Steffen Trumtrar <s.trumtrar@pengutronix.de>

