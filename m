Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.remote-ip=185.203.200.13
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=fail;
	t=1794482417;
	b=eSRY/XSPRyncjOQxsFE7NTNLLG5Os27KJ4hZmsLVLNeZ3EyPqFSPGG449k5uMWv0p2WT
	 GojwYOjlP0iC2MAIUz6hXcQ6mcNa1G8xkLhDKy9YtrUhj9A48IbD07Vej9GFI1BcEQvqI
	 7Va6t+QXYyDLSnANZLNrc3ZluG77rXOjVhzQkMDyk21maXD8A/JQeeF/R9/91K8ldWAQy
	 x9sIZdsGIO21z7TUkikIM8nAlBIrCkvdfRX2fTzZ41ILD1143OBH6MXMrGDzMA90fooH8
	 aotDFcPhqm8S0wfVjLlT3ywLomZ3vn5y06amNlNAvB/EFXKVjfyPaE5f1QiDTVaiqSA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794482417;
	h=DMARC-Filter:Received:DKIM-Signature:From:Subject:Date:Message-Id:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:X-B4-Tracking:
	 X-Change-ID:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=BWXJGOTMWB3mRIx8UP4xBvK/jbKwCSMHaxxpvW0Gkzc=;
	b=orQZKslgTz9tuWBsJzf+A+7w74VHFxUgSzMQ39bIzW+iefk1YNw6sazMgCebFPfx3L8/
	 g7W/hIS1lspsN7J4sTQdvG9wgaKDSfV6d/jsWNQXLSu/aChWFVpF/eklPMGebPKzASuyw
	 OFyKrkRup70ZyG+xqYn+FHwGajwNdCdiJGBI6wW8n84Ju/gGGcNA6Q8RTT92o3+auYMWV
	 /Wgj5zjgXYtnZrU/Cfq7T6LWcytBKSZpqFqIl0G6YqU5x6l9LYtiN+iWtVixAQReUFTp/
	 Jrb3cxVw2qSZ7s+Rvp1iVUCPKL5fJsBihTiVETTmwEf1WRUkTdmFuLj+ZTGYiaP8NuQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=none header.from=pengutronix.de;
	spf=pass smtp.mailfrom=pengutronix.de;
	dkim=pass header.d=pengutronix.de header.i=@pengutronix.de header.a=rsa-sha256 header.s=20260414 header.b=IIKeJRBm;
	arc=fail smtp.remote-ip=185.203.200.13
Received: from mx1.white.stw.pengutronix.de (mx1.white.stw.pengutronix.de [185.203.200.13])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 247BD60A261B
	for <virtualization@lists.linux.dev>; Thu, 12 Nov 2026 11:20:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 247BD60A261B
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pengutronix.de header.i=@pengutronix.de header.a=rsa-sha256 header.s=20260414 header.b=IIKeJRBm
Received: from ratatoskr.trumtrar.info (unknown [IPv6:2a00:1f:f805:2b01:a03:2f4:308a:7b52])
	(Authenticated sender: str@pengutronix.de)
	by mx1.white.stw.pengutronix.de (Postfix) with ESMTPSA id 8BA2D202C6A;
	Thu, 12 Nov 2026 12:20:13 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1794482414;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=BWXJGOTMWB3mRIx8UP4xBvK/jbKwCSMHaxxpvW0Gkzc=;
	b=IIKeJRBmXAScXlNf6nt9s5i0zl3nrsSjbojYiDYpRVgL5UI5HydqueE17vSSGSTMOjMj7O
	kNrctTP8bCzTUBhIhhXrWpZw6ChQGgxoaLxuJY3QpuMqhhBNnTjuxSzzH8YexxO87MkCMg
	ITlArjFdx14LOSY3Vdiy2YWfVXA9uwEbEfB54dZLh20/kuqaFIBGQqamMTHvXQwJqQMQcS
	EFZ+HxFrSlt1YV0v2TAZyC6bcGjvmgEPpkxSkw3oQJu0aIChg3Ui/nNdPcdkYTtMoTdxjV
	J6B2X4XpdIwsmggko05oIrLPFRem7lW6vw/lXj42/l3IyLmNCnNyndpSIYY9Ww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1794482414;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=BWXJGOTMWB3mRIx8UP4xBvK/jbKwCSMHaxxpvW0Gkzc=;
	b=cXxdIvpilngcx6/54xV3QQiVZblZdaTTruvOgjlz9dQ04UciyRZ05D4pmCIARxQnFvKgIK
	uWVB4MIAlE7GmOgLkriOMduMOtxtvgFuoBdGEgPpzD5J5YlRXN9gtuu/aexMKd6lEUUvBa
	VGoCWtCOftphkN5HwUdJ2zU8g6rIwKE0q7Q4u4PXuqDgQkXcqqIi0G9EvapGrY38vZHiRL
	nyGj2nPROK6fN8+hdNaks+3dxAL+jQGNcTdSN5flk3J3x5iWj9JYVMz0VWBgZcl+4FO68f
	BKdO/GzWCrTs32m1Oa77y0pNziSOWXe/nlNb9sWVwCU8LjmKxdyYcMNyKdGMeQ==
ARC-Seal: i=1; s=20260414; d=pengutronix.de; t=1794482414; a=rsa-sha256;
	cv=none;
	b=evjpDArJYaa1AnhNy4HbOxb4DfKuE+QbrTx/U3ux2R+sttj82XDd3MyepZy/CvKPjsRUHU
	aKkxjiN1PasCZpoJ54/934BkWRolomuf9l3aZ8RSlS5NalUGR3n6nMX6pzvm4psXqndGLq
	qCVcFt5x89wUfDQYcJdMAg5ovNEiQ3dPVQiheLYXoRGMHgS52Q83j9deYx5/jPJ6otjU3S
	KFr35ZR48Fwz6g/Zrw2x8kXTm3AMoTWI5N3LMB9FP+d4bQafuwGRrIIkYPZyoUpRM3RFN6
	laozpKfvT7OyGti3OgknPfgL2tZR6pjmwNPrU9pgdFqYu2HuOAepH1MdQQQS/w==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=str@pengutronix.de smtp.mailfrom=s.trumtrar@pengutronix.de
From: Steffen Trumtrar <s.trumtrar@pengutronix.de>
Subject: [PATCH net-next v5 0/9] virtio-net: add receive timestamp support
Date: Thu, 12 Nov 2026 12:19:32 +0100
Message-Id: <20261112-v6-7-topic-virtio-net-ptp-v5-0-7ab67b572f4f@pengutronix.de>
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
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/43OwU7DMAwG4FeZcsYoidORceI90A5t4m6+JFEao
 k5T3x1TCS6giYMPv2x/9l0tVJkW9Xq4q0qdF85JwvB0UOE6pgsBR8nKaovGGg/9CC/QcuEAnWv
 jDIkalFYA4yxDU3Czi0r2S6WZ191+V19DidamztK58tJyve1Hu9n7//C7AQ1hDCc72egHtG+F0
 uWj1Zx4fY600x2/uaM+WfOIQ+EQB+0HIz97/yfnfjgj9Yhzwmntx1ljiA6nX9y2bZ/U4/yfbwE
 AAA==
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
 Stanislav Fomichev <sdf@fomichev.me>, Eric Dumazet <edumazet@kernel.org>, 
 Andrew Lunn <andrew@lunn.ch>, Simon Horman <horms@kernel.org>, 
 Kory Maincent <kory.maincent@bootlin.com>, 
 Liang Chen <liangchen.linux@gmail.com>, Heng Qi <hengqi@linux.alibaba.com>
Cc: virtualization@lists.linux.dev, netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, bpf@vger.kernel.org, kvm@vger.kernel.org, 
 kernel@pengutronix.de, Steffen Trumtrar <s.trumtrar@pengutronix.de>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=5593;
 i=s.trumtrar@pengutronix.de; h=from:subject:message-id;
 bh=Af8L4UIeATrDH9XPcK3wO4GWOliuc2/JNfjRjsxJVEM=;
 b=owGbwMvMwCUmtVehiCsuTInxtFoSQ9bXBc/Dr0R1lGycO0tv5ZtZUm9CAwymvZjYe8/jvuG9e
 1M9r6zZ0VHKwiDGxSArpsiisrCCT9Tjg2fkNBEumDmsTCBDGLg4BWAiCSsYGfazJLrsvsAT4zhX
 PmGl2+vDBk6nljJNeSq921Iz6/okCQ1GhpeCOndUNhX+4257leMmwLj7gcvMGyIp5utLfWdeP/0
 0gR0A
X-Developer-Key: i=s.trumtrar@pengutronix.de; a=openpgp;
 fpr=24A1780E1548F0495996140A1ABD20720A5E5622

This series picks up Willem de Bruijn's work on a virtio-net receive
timestamp. The device puts the time of arrival (TAI, ns) into the virtio-net
header so the guest can use it for PTP and RTT estimation without
taking the timestamp itself after the host-to-guest latency.

In detail, with the points that are still open:

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
   written by tun, the device side in software.
 - The timestamp is in TAI. On v4 Willem and I discussed whether the
   spec should fix the time base at all. Fixing it to TAI is the
   simplest: a software device like tun can convert its own clock, and
   the guest needs nothing else. The driver reports the timestamp as
   SOF_TIMESTAMPING_RAW_HARDWARE without a PTP clock (phc_index -1).
   For hardware virtio-net queues, which may not be able to convert,
   the model of NIC timestamps and their PHC would fit better: the
   device names a clock (e.g. a virtio_rtc clock, whose PHC the driver
   reports) or virtio-net gets a PHC of its own. That needs consensus
   on the virtio side; Which way would you prefer?
 - With phc_index -1, ETHTOOL_MSG_TSCONFIG_GET and _SET fail with
   -ENODEV (SET after the config was already applied). Other drivers
   with hardware timestamps but no PHC have the same problem
   (ngbe/txgbe, dpaa); patch 1 lets tsconfig handle phc_index -1.

Patches 1 to 3 fix existing code and do not depend on the rest:
tsconfig refused devices with hardware timestamps but no PHC, the tx
header was not fully cleared, and the XDP rx hash was read from the
headroom after the XDP program could have overwritten it. They can go
to net on their own if preferred.

A virtio spec change is needed as well and not yet proposed.

Testing: the feature needs a QEMU that knows VIRTIO_NET_F_RX_TSTAMP and
sets the matching vnet header size; see
https://github.com/strumtrar/qemu/tree/v11.0.1/virtio-rx-stamps
Each patch builds with W=1 on arm64 on top of net-next.

Tools: this version was developed with an LLM coding assistant (Claude
Opus 5.5 in Claude Code). From the review of v4 (Willem's and the
Sashiko findings) it wrote patches 1 to 3, the xdp_buff wrapper and
the other changes listed below, and drafts of the commit messages and
of this cover letter.
v4 carried Assisted-by tags; after commit 1e035297ffda ("docs: remove
Assisted-by references") this is said here instead.

Signed-off-by: Steffen Trumtrar <s.trumtrar@pengutronix.de>
---
Changes in v5:
- new patch: let tsconfig handle devices without a PHC
- new patch: clear the whole tx header in xmit_skb()
- new patch: copy the XDP rx hash into a wrapper around xdp_buff
  before the XDP program runs
- use the same wrapper for the XDP rx timestamp
- rename has_rx_tstamp/hwts_rx_en to rx_tstamp_supported/rx_tstamp_enabled
- add VIRTIO_NET_F_RX_TSTAMP to features[] only, not to features_legacy[]
- vhost: zero the rest of the header also when num_buffers is not written
- timestamp stays TAI, open question for the virtio side in the cover letter
- drop the performance numbers from the cover letter
- drop the Assisted-by tags, tool use is described in the cover letter
- send as PATCH, no longer RFC
- rebase onto net-next/main 20261112
- Link to v4: https://patch.msgid.link/20261026-v6-7-topic-virtio-net-ptp-v4-0-008af03cd43b@pengutronix.de
Changes in v4:
- add static_asserts for header sizes
- rework hdr_len handling
- add support in vhost
- fix/add support for xdp
- Link to v3: https://patch.msgid.link/20260921-v6-7-topic-virtio-net-ptp-v3-0-3350851c4f88@pengutronix.de
Changes in v3:
- rework to use virtio_net_common_hdr instead of adding new struct
Changes in v2:
- rework patches to use flow filter instead of feature flag
- Link to v1: https://lore.kernel.org/r/20231218-v6-7-topic-virtio-net-ptp-v1-0-cac92b2d8532@pengutronix.de

---
Steffen Trumtrar (9):
      net: ethtool: tsconfig: allow hardware timestamping without a PHC
      virtio-net: zero the whole tx header
      virtio-net: copy the XDP rx hash before the program runs
      virtio-net: move virtio_net_common_hdr to virtio_net.h
      virtio-net: support receive timestamp
      virtio-net: assert header sizes
      vhost-net: support VIRTIO_NET_F_RX_TSTAMP
      virtio-net: add XDP rx timestamp metadata
      tun: add rx timestamp to the vnet header

 drivers/net/tun.c               |  14 ++-
 drivers/net/tun_vnet.h          |  18 ++-
 drivers/net/virtio_net.c        | 250 +++++++++++++++++++++++++++++++---------
 drivers/vhost/net.c             |  21 +++-
 include/linux/virtio_net.h      |  30 +++++
 include/uapi/linux/virtio_net.h |   1 +
 net/ethtool/tsconfig.c          |   6 +-
 7 files changed, 270 insertions(+), 70 deletions(-)
---
base-commit: c88fd6989aea9237a60a4859139a265bfb7ddc0b
change-id: 20231218-v6-7-topic-virtio-net-ptp-3df023bc4f4d

Best regards,
--  
Steffen Trumtrar <s.trumtrar@pengutronix.de>

