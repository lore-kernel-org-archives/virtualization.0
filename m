Received: from mx1.white.stw.pengutronix.de (mx1.white.stw.pengutronix.de [185.203.200.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49FA04A7C9E
	for <virtualization@lists.linux.dev>; Mon, 21 Sep 2026 14:46:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.200.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790001981; cv=none; b=aOJF9r3vv6421PBmXPfJy8sk4Cqj/beMvAfkP0d858cBEpvfCtfI4HrX8u5L6dmkxDMCjVXgbCy2x3vHk3snry9ZEZDFybHrJmTEWSEnDGaZRILdlj9AD/dJtZPGbN5fVaFOZ8rZx1HAGV0/cBI/g4R8141mBgjpMYRXV5XMg+k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790001981; c=relaxed/simple;
	bh=xXi8NyZ/pfQ1jpS03zckU+/ZLXTUXsMh5yJlQcd4CLk=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=XhpSoXwXPo72/aaPsUFuZHQqaj9SwCpbjvXVvd2K6+Juh6tESuKP2EvVIDs0lqS01Y+xvQnCHruN7itrH+O2z0Ddndul0QlVIX6JRXBUkgthbX7jvaB7jboS5nkKr9DcotGHZuHhJNthhpsOaBMDdoCEo7FIbmRfhyMTlgkczdk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.200.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from ratatoskr.trumtrar.info (unknown [IPv6:2a00:1f:f805:4b01:1e0e:d42d:4ec8:33b2])
	(Authenticated sender: str@pengutronix.de)
	by mx1.white.stw.pengutronix.de (Postfix) with ESMTPSA id 25359200153;
	Mon, 21 Sep 2026 16:46:14 +0200 (CEST)
From: Steffen Trumtrar <s.trumtrar@pengutronix.de>
Subject: [PATCH RFC v3 0/2] virtio-net: add flow filter for receive
 timestamps
Date: Mon, 21 Sep 2026 16:46:09 +0200
Message-Id: <20260921-v6-7-topic-virtio-net-ptp-v3-0-3350851c4f88@pengutronix.de>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/42NTQ6CMBCFr0Jm7RjaoqIrExMP4NawgHaA2bRNW
 xsM4e42nMDl+/veCpECU4RbtUKgzJGdLUIdKtBzbydCNkWDrKUSUrSYz3jB5DxrzBwSO7SU0Ce
 PyoylNOhmbAyUvQ808rKz3/B6PqAr5swxufDd/7LYoz/QWWCNutdXOUjTnpS8e7LTJwVneTkag
 m7bth9ky3AQzAAAAA==
X-Change-ID: 20231218-v6-7-topic-virtio-net-ptp-3df023bc4f4d
To: "Michael S. Tsirkin" <mst@redhat.com>, 
 Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Richard Cochran <richardcochran@gmail.com>, 
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 =?utf-8?q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
 Jason Wang <jasowangio@gmail.com>, Alexei Starovoitov <ast@kernel.org>, 
 Daniel Borkmann <daniel@iogearbox.net>, 
 Jesper Dangaard Brouer <hawk@kernel.org>, 
 John Fastabend <john.fastabend@gmail.com>, 
 Stanislav Fomichev <sdf@fomichev.me>, Jason Wang <jasowangio@gmail.com>
Cc: virtualization@lists.linux.dev, netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, bpf@vger.kernel.org, 
 Steffen Trumtrar <s.trumtrar@pengutronix.de>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2898;
 i=s.trumtrar@pengutronix.de; h=from:subject:message-id;
 bh=xXi8NyZ/pfQ1jpS03zckU+/ZLXTUXsMh5yJlQcd4CLk=;
 b=owGbwMvMwCUmtVehiCsuTInxtFoSQ9ZGZ9P5Kmc7X7n6hBiEnQx3/ibjfKlil0FedYXiP5fsC
 We3f3DsKGVhEONikBVTZFFZWMEn6vHBM3KaCBfMHFYmkCEMXJwCMBHP+YwMd49sl86TL3O/y8F7
 5trDHvn0bZ95lUPl3Vz3JJfpLrv2huF/2cGVH1JFPBzOi5/OZOxNL28L8DK0EiuYqiNQ3tg7N5E
 FAA==
X-Developer-Key: i=s.trumtrar@pengutronix.de; a=openpgp;
 fpr=24A1780E1548F0495996140A1ABD20720A5E5622

This series tries to pick up the work on the virtio-net timestamping
feature from Willem de Bruijn.

Original series
    Message-Id: 20210208185558.995292-1-willemdebruijn.kernel@gmail.com
    Subject: [PATCH RFC v2 0/4] virtio-net: add tx-hash, rx-tstamp,
    tx-tstamp and tx-time
    From: Willem de Bruijn <willemb@google.com>

    RFC for four new features to the virtio network device:

    1. pass tx flow state to host, for routing + telemetry
    2. pass rx tstamp to guest, for better RTT estimation
    3. pass tx tstamp to guest, idem
    3. pass tx delivery time to host, for accurate pacing

    All would introduce an extension to the virtio spec.

The changes in this series are to the driver side. For the changes to qemu see:
    https://github.com/strumtrar/qemu/tree/v11.0.1/virtio-rx-stamps    

Currently only virtio-net is supported. Performance was tested with
pktgen which doesn't show a decrease in transfer speeds.

As these patches are now mostly different from the initial patchset, I removed
the Signed-off-bys from Willem, so he mustn't be ashamed of what his work evolved to ;)

---
Changes in v3:
- rework to use virtio_net_common_hdr instead of adding new struct
Changes in v2:
- rework patches to use flow filter instead of feature flag
- Link to v1: https://lore.kernel.org/r/20231218-v6-7-topic-virtio-net-ptp-v1-0-cac92b2d8532@pengutronix.de

To: Michael S. Tsirkin <mst@redhat.com>
To: Jason Wang <jasowang@redhat.com>
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
To: David S. Miller <davem@davemloft.net>
To: Eric Dumazet <edumazet@google.com>
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
Cc: virtualization@lists.linux.dev
Cc: netdev@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Cc: bpf@vger.kernel.org
Signed-off-by: Steffen Trumtrar <s.trumtrar@pengutronix.de>

---
Steffen Trumtrar (2):
      virtio-net: support receive timestamp
      tun: support rx-tstamp

 drivers/net/tun.c               |  20 ++++--
 drivers/net/tun_vnet.h          |  27 ++++----
 drivers/net/virtio_net.c        | 134 ++++++++++++++++++++++++++++++++++++----
 include/uapi/linux/virtio_net.h |  12 ++++
 4 files changed, 166 insertions(+), 27 deletions(-)
---
base-commit: cee9395acd8043be0644b25c34bfa86623f2b935
change-id: 20231218-v6-7-topic-virtio-net-ptp-3df023bc4f4d

Best regards,
--  
Steffen Trumtrar <s.trumtrar@pengutronix.de>

