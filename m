Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 684AB4F0526
	for <virtualization@lists.linux.dev>; Tue,  8 Sep 2026 09:27:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788859635; cv=none; b=n0sgu3CGegCtnl8soto97vHYCR54wlYUTYVpzYYhQ/LdRjwk1gf016Huzuy2Hw0C8deAV6REprUTf+YnYAJTgluCZM3rn2M1H+/0l7MnNPIwVLoUMVvQJo3oiAy31oeAqseNDZBYRaHQgvq2pU/NICA8wDnEMxsvrQE6f4dR0o8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788859635; c=relaxed/simple;
	bh=TH2KrDMqXFiOdWjjNaWh5C1liTsVTa5L6i54+wRfvGo=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=f0VnT10s2+C9aUqrJLWHVx2NsfAwBzvODxJ17wr36Pby4jwWf9yFhOVY9uifYoP50w6eMR1yWTFD4L2VUbGIHbNnrdpdBXxjI3V3OS7U+AQM/U13o/eN/TnlBKk/YSRAaWW3rcvgXeymZaEVblUQMSt9dRaU7HhNFA7zOSOjEXc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=WWrGQv2Y; arc=none smtp.client-ip=117.135.210.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="WWrGQv2Y"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=uX
	egf20DF7eQfV2ZaryDDtLLMbtgbBzpvgrwghRxI7E=; b=WWrGQv2Y1VxqZbLaik
	1GlVBeZ/D+7InWDgtI5IreTZ4493mNHjfN6uglwClVA2cC6UCB9mvGHtzHrHjuuZ
	xfaVdM3/3rRFK+zCkAALRlujOdgSXI/BtZ6cqwME70TeXdTIgumtC7WMKiG3FxZF
	ZEAMq3bLXZ3Zy4afD+4O9LDYQ=
Received: from localhost.localdomain (unknown [])
	by gzsmtp3 (Coremail) with SMTP id PigvCgD3Bf3X1J9qaBRdRg--.18019S2;
	Tue, 08 Sep 2026 17:26:48 +0800 (CST)
From: Longjun Tang <lange_tang@163.com>
To: mst@redhat.com,
	kuba@kernel.org
Cc: jasowangio@gmail.com,
	xuanzhuo@linux.alibaba.com,
	virtualization@lists.linux.dev,
	netdev@vger.kernel.org,
	tanglongjun@kylinos.cn,
	Longjun Tang <lange_tang@163.com>
Subject: [RFC RESEND 0/3] virtio_net: introduce an RX queue watchdog for stuck detection
Date: Tue,  8 Sep 2026 17:26:43 +0800
Message-Id: <20260908092646.108865-1-lange_tang@163.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:PigvCgD3Bf3X1J9qaBRdRg--.18019S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxCw4fCryrKF48ZFWDuFy3Jwb_yoW5Zw4DpF
	WYk390vr1kGryI9a4SyF4UJryYka93Ar47Crn2q34ruFs0kr40qr1IkFy5KFyUCrZ3Aw1j
	vr4FgrZ5C34DZaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0pEWE_ZUUUUU=
X-CM-SenderInfo: 5odqwvxbwd0wi6rwjhhfrp/xtbC-hjtHGqf1NiNBgAA3l

Hi Michael, Kuba,

While troubleshooting virtual network issues in a production environment,
I once ran into a problem where the virtio_net receive queue became
permanently stuck.

The virtio_net RX path relies on backend interrupt notifications. 
The backend(vhost_net/vhost-user) appends buffers to the used ring
and then notifies the guest, relying on the hypervisor(KVM) to inject
the interrupt. On receiving it, virtio_net schedules NAPI, drains the
used ring and refills descriptors.

If the hypervisor fails to inject the interrupt(e.g. a transient KVM
failure), the guest never schedules NAPI, so it neither consumes buffers
nor returns descriptors. The backend keeps appending until the ring is full,
then stops and, with no free descriptors left, also stops sending
notifications. Both sides now wait for the other, and the RX queue is
permanently stuck.

The root cause is the lost interrupt in the hypervisor, and the proper
fix belongs there. Nevertheless, I believe virtio_net needs a way to 
observe and diagnose it. Today, once a queue hangs, there is no signal
to the operator that anything is wrong: the RX path has no equivalent of
the TX watchdog (ndo_tx_timeout). This series lets virtio_net detect a 
stuck RX queue. It is detection only: the driver records the event and 
logs a warning, leaving recovery to a follow-up if desired.


Implementation
--------------

Patch 1 exports virtqueue_get_last_used_idx(), a read-only accessor for
the last_used_idx. Together with the existing virtqueue_poll(), it lets
a driver ask whether the device has produced buffers that the driver has
not consumed yet ("backlog").

Patch 2 adds a per-device RX watchdog that scans all RX queues once per
second. A queue is considered stuck when, for rx_watchdog_timeo seconds
(default 5, 0 disables it), all of the following hold simultaneously:
  - the queue has a non-zero backlog (used.idx != last_used_idx);
  - the driver makes no consumption progress (last_used_idx unchanged);
  - no new interrupt arrives (rq->calls unchanged).
On detection it logs a warning, rate-limited to once per timeout.

Patch 3 adds a per-queue rx_timeouts statistic, exposed via ethtool -S,
so the number of watchdog events can be observed per queue.


RFC
---

This is sent as an RFC to gather feedback on a few open points:

  - Scope: this series only detects the stuck queue. Is it better to
    keep detection and recovery separate, or should recovery (forcing a
    NAPI poll to drain the queue) be included?

  - Default: rx_watchdog_timeo defaults to 5 seconds (enabled). Should
    the watchdog be enabled by default, or disabled unless explicitly
    requested?

Parts of this series, including portions of this cover letter, were drafted
with AI assistance. I have carefully reviewed everything; 
questions and comments are welcome. 

Thanks!
Lange

Longjun Tang (3):
  virtio: add virtqueue_get_last_used_idx() helper
  virtio_net: introduce an RX queue watchdog for stuck detection
  virtio_net: add rx_timeouts per-queue statistic

 drivers/net/virtio_net.c     | 95 ++++++++++++++++++++++++++++++++++++
 drivers/virtio/virtio_ring.c | 18 ++++++-
 include/linux/virtio.h       |  2 +
 3 files changed, 113 insertions(+), 2 deletions(-)

-- 
2.25.1

