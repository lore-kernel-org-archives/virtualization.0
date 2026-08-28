Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 187DF3DDAFB
	for <virtualization@lists.linux.dev>; Fri, 28 Aug 2026 07:43:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787903030; cv=none; b=fOLbpccGegoeF9Hoc4YM1rwAuaVQa2WeAtwGSI8VhouSGvWAJvL2CGoRt+SQpjNRd9bd368Yia2fsq7RKKl5dm6dY1HovLpFDeatIZrQXyAjrbQ+A815/K3lrGt2EB1Tp7Mnj1NMFfWXFwtvNliuYcLFyzm6niKoxpFqyGe0+dk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787903030; c=relaxed/simple;
	bh=Dj2o9yBOxhObKHe7sLDHOkOrcVlZdUFIa4I2lCSjkMY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=r+DCtul/KJVVyDhGvXgGqyMzEqdioe/YDtftjxYspn5JJdHCtpBEZkjh1IUh83RehyazCyJ0x1At3Kf8kM3hXp9dnyWaQV4zTHrYC21gg5tgOLVAKOHcFSJmb7CUbH0K2fibKO5A8Umbx8WpZiHmXZcuqSdsAK3qfYIu/Q/UXh8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=AxuwQEsM; arc=none smtp.client-ip=117.135.210.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="AxuwQEsM"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=St
	ZHzbsLVXBknff1WbHxETGXdM3xYic3VlsdTy66Nxk=; b=AxuwQEsMCizu/P1r8i
	1p+3mPYGUryH2oRs+Ks9IDwK8PmDM36zP9QDzR0WQgpOs+OBnqAboD2EE6tBWbc/
	eNmKCO/kt86wtM3Wwec7uvxPdsaKhjtlCcdlfE3Z8oCaH2PaZt1yWkCWKZ8CCUYH
	zW/D3ucPtVLdGTs+imqk1QfP8=
Received: from localhost.localdomain (unknown [])
	by gzsmtp3 (Coremail) with SMTP id PigvCgD31xMfPJFqXWYePg--.48947S2;
	Fri, 28 Aug 2026 15:43:27 +0800 (CST)
From: Longjun Tang <lange_tang@163.com>
To: mst@redhat.com,
	kuba@kernel.org
Cc: jasowangio@gmail.com,
	xuanzhuo@linux.alibaba.com,
	virtualization@lists.linux.dev,
	netdev@vger.kernel.org,
	tanglongjun@kylinos.cn
Subject: [RFC PATCH 0/3] virtio_net: introduce an RX queue watchdog for stuck detection
Date: Fri, 28 Aug 2026 15:43:23 +0800
Message-Id: <20260828074326.65594-1-lange_tang@163.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:PigvCgD31xMfPJFqXWYePg--.48947S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxCFW8tryfCw4ktF1rXw4fXwb_yoW5ZrWDpF
	WYka90vr1kGryS9a4ftF4UJry5Ka93Ar42yrn2q348Can0kr40qr1IkFy5KFyUCrZ7Cw1j
	vr4F93s5uw1DZaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jouWdUUUUU=
X-CM-SenderInfo: 5odqwvxbwd0wi6rwjhhfrp/xtbC4gAWRGqRPCACTQAA3Y

From: Longjun Tang <tanglongjun@kylinos.cn>

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

 drivers/net/virtio_net.c     | 103 +++++++++++++++++++++++++++++++++++
 drivers/virtio/virtio_ring.c |  23 +++++++-
 include/linux/virtio.h       |   2 +
 3 files changed, 126 insertions(+), 2 deletions(-)


base-commit: 2709dd5ae32f0828f386327c76bba9f39f63a1c6
-- 
2.43.0

