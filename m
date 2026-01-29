Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7060523F26A
	for <virtualization@lists.linux.dev>; Thu, 29 Jan 2026 08:07:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769674026; cv=none; b=FDpgxy+aqVwMKeNH+prdLGPclwDJGgj1MUJaOwZrosHvCwsMOn144BPSM32Y/Pc6bfwRKcgDsBTcTEiZXL2W+BSU+Y4MX6DuW9gIEyNMaMjHhBB8ee/MVip11H7h+jFx6cq/utem/JsQ+F0iiua/5yd74PqphANboSQsQK579cs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769674026; c=relaxed/simple;
	bh=IEEjBD/NyjWngjnunYXQwYzStvzoWAGQ7tdtpUapPpY=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=COZoqYyUcvZpdCaUhLfJk2XLXTWq2ccOx6DaPSRFmVCakSX/VWDXe2rad69sq9TDtz5RAruGLs9tl0855IbVvbUoCt8o9zPGiQ5RDUPmIbwHz4EKqlbRN4odv0apOEHfy8yOcWT9j1ivBu0J1VSKx0g494ciFbkgXED8uI8qoe4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from ptz.office.stw.pengutronix.de ([2a0a:edc0:0:900:1d::77] helo=ratatoskr.trumtrar.info)
	by metis.whiteo.stw.pengutronix.de with esmtp (Exim 4.92)
	(envelope-from <s.trumtrar@pengutronix.de>)
	id 1vlN3J-0006b0-BT; Thu, 29 Jan 2026 09:06:57 +0100
From: Steffen Trumtrar <s.trumtrar@pengutronix.de>
Subject: [PATCH RFC v2 0/2] virtio-net: add flow filter for receive
 timestamps
Date: Thu, 29 Jan 2026 09:06:40 +0100
Message-Id: <20260129-v6-7-topic-virtio-net-ptp-v2-0-30a27dc52760@pengutronix.de>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIABAVe2kC/42NTQ6CMBCFr0Jm7RjaoqIrExMP4NawgHaA2bRNW
 xsM4e42nMDl+/veCpECU4RbtUKgzJGdLUIeKtBzbydCNkWDrKUSUrSYz3jB5DxrzBwSO7SU0Ce
 PyoylNOhmbAyUvQ808rKz3/B6PqAr5swxufDd/7LYoz/QWWCNutdXOUjTnpS8e7LTJwVneTkag
 m7bth97kcHOzAAAAA==
X-Change-ID: 20231218-v6-7-topic-virtio-net-ptp-3df023bc4f4d
To: "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, 
 Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Richard Cochran <richardcochran@gmail.com>, 
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 =?utf-8?q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>
Cc: virtualization@lists.linux.dev, netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Steffen Trumtrar <s.trumtrar@pengutronix.de>
X-Mailer: b4 0.14.3
X-SA-Exim-Connect-IP: 2a0a:edc0:0:900:1d::77
X-SA-Exim-Mail-From: s.trumtrar@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: virtualization@lists.linux.dev

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
    https://github.com/strumtrar/qemu/tree/v10.2.0/virtio-rx-stamps    

Currently only virtio-net is supported. Performance was tested with
pktgen which doesn't show a decrease in transfer speeds.

As these patches are now mostly different from the initial patchset, I removed
the Signed-off-bys from Willem, so he mustn't be ashamed of what his work evolved to ;)

Signed-off-by: Steffen Trumtrar <s.trumtrar@pengutronix.de>
---
Changes in v2:
- rework patches to use flow filter instead of feature flag
- Link to v1: https://lore.kernel.org/r/20231218-v6-7-topic-virtio-net-ptp-v1-0-cac92b2d8532@pengutronix.de

---
Steffen Trumtrar (2):
      tun: support rx-tstamp
      virtio-net: support receive timestamp

 drivers/net/tun.c               |  30 +++++----
 drivers/net/virtio_net.c        | 136 ++++++++++++++++++++++++++++++++++++----
 include/uapi/linux/virtio_net.h |   9 +++
 3 files changed, 151 insertions(+), 24 deletions(-)
---
base-commit: 8f0b4cce4481fb22653697cced8d0d04027cb1e8
change-id: 20231218-v6-7-topic-virtio-net-ptp-3df023bc4f4d

Best regards,
-- 
Steffen Trumtrar <s.trumtrar@pengutronix.de>

