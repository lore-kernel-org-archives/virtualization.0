Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=220.197.31.4
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794217413;
	b=cSqL7vK6lYEVhfS6n9LZSvaxM0wfC2NeR+o/RfsrV03KtcvJEC7LWIK5s0y64QLBBOWn
	 MUDjKwOo2+qxeB5uprgbtxC3WgvnhO4NrsmJoyQiJJkx1h/Go2IxOwua7Pbz9M26NWCVa
	 XmAKisvMc98TecHSWywMW9+v0l/UgVH967xhIEKDb0ABXYVG1R57KOHt7TOzPYt2GVoTw
	 BHofbcBHaQFOFcFLg1x1/HjIsjRthLzM7Kq5eXKqWVrtrqF7QG/ibDhkMV4EwEVCqrXF0
	 WeUx7/b5bPQuapU8RhUxoRe8XBayvdwJjX9zdXtteQ+U3nRt8rG9flQ2rWsam/IR9SA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794217413;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-Id:X-Mailer:MIME-Version:Content-Transfer-Encoding:
	 X-CM-TRANSID:X-Coremail-Antispam:X-CM-SenderInfo;
	bh=o4Ehh7rNSx9OYGc6ilukIoNG08FCDxa37EOyEFmx9NU=;
	b=Hj3flqGma5fqBOHBwJIXfk0jJmDEvT0iMZRbN/8bTQXeQEp74iT7VcvcsTLPfcoyPUcp
	 ILHpUKl/py/ue7iF/pZpNw6oH7wVpPxYeV2LG37vvLoj7glqRutBTbELdntsBrpX6MPjF
	 SJwmE7kAt5FXnZnzo71AIHS3o/NWBNYRQcLdGOkuMRWZOMrxho/ZppYSh6kwXLunAXhRM
	 G7fGUsxiD00Klr1Bpfa7aw2dRMt8HT8cEeWmnHybxecU543igtph4OwFarSRkS4wo41xi
	 YJ1g1+uDI6UKTVUxgbYrNEuMbOAjdNfBWpO0VybcdwdC5bbRW2tSGtr/ahEKeAwbBdw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=163.com;
	spf=pass smtp.mailfrom=163.com;
	dkim=pass header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=S9cCK6S2;
	arc=none smtp.remote-ip=220.197.31.4
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 069CA606A326
	for <virtualization@lists.linux.dev>; Mon,  9 Nov 2026 09:43:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 069CA606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=S9cCK6S2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=o4
	Ehh7rNSx9OYGc6ilukIoNG08FCDxa37EOyEFmx9NU=; b=S9cCK6S2PidwVwFs4x
	plcas/CA2D1mMy92pSblcB0nqd4AZScdpKRX9nhzkZ9dbfPnYqHeOoLE15Y/Z6zf
	7ZrrxODaJvRZn+d230h8abQg7nOaaMCE5f1Mw/REYTqn8izx+t2TAgcBIIpE4QQW
	tpt8pVcJIOZ2Rz3W410jWOx9c=
Received: from localhost.localdomain (unknown [])
	by gzga-smtp-mtada-g0-2 (Coremail) with SMTP id _____wBHJCGvlfFq58sxGQ--.4049S2;
	Mon, 09 Nov 2026 17:43:12 +0800 (CST)
From: Longjun Tang <lange_tang@163.com>
To: mst@redhat.com,
	kuba@kernel.org,
	eperezma@redhat.com,
	jasowangio@gmail.com
Cc: xuanzhuo@linux.alibaba.com,
	virtualization@lists.linux.dev,
	netdev@vger.kernel.org,
	tanglongjun@kylinos.cn
Subject: [PATCH 0/3] virtio_net: introduce an RX queue watchdog for stuck detection
Date: Mon,  9 Nov 2026 17:43:07 +0800
Message-Id: <20261109094310.103979-1-lange_tang@163.com>
X-Mailer: git-send-email 2.25.1
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
X-CM-TRANSID:_____wBHJCGvlfFq58sxGQ--.4049S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxCw4fCryrKF48uF4rJry7Jrb_yoW5XF18pF
	WYkw4YvrykJryI9a4SqF4DJry5Can3ArsFyrs2q348GFs0kr40qr1jkFy5tFyUCr97Cw12
	vrsY93yku34DZaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07j5J5rUUUUU=
X-CM-SenderInfo: 5odqwvxbwd0wi6rwjhhfrp/xtbC4RCo1mrxlbDM+gAA3H

From: Longjun Tang <tanglongjun@kylinos.cn>

Hi Michael, Kuba,

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
the TX watchdog (ndo_tx_timeout). This series lets virtio_net detect and
recover a stuck RX queue.


Implementation
--------------

Patch 1 exports virtqueue_get_last_used_idx(), a read-only accessor for
the last consumed used ring index. Together with the existing
virtqueue_poll(), it lets a driver ask whether the device has produced
buffers that the driver has not consumed yet ("backlog").

Patch 2 adds a per-device RX watchdog that scans all RX queues once per
second. A queue is considered stuck when, for rx_watchdog_timeo seconds
(default 5, 0 disables it), all of the following hold simultaneously:
  - the queue has a non-zero backlog (unconsumed buffers in the used ring);
  - the driver makes no consumption progress (last_used unchanged);
  - no new interrupt arrives (rq->calls unchanged).
On detection it logs a warning, rate-limited to once per timeout, and
reschedules NAPI, which drains the used ring and refills the descriptors,
so the queue recovers.

Patch 3 adds a per-queue rx_timeouts statistic, exposed via ethtool -S,
so the number of stuck events can be observed per queue.

questions and comments are welcome.

Thanks!
Lange

Longjun Tang (3):
  virtio: add virtqueue_get_last_used_idx() helper
  virtio_net: introduce an RX queue watchdog for stuck detection
  virtio_net: add rx_timeouts per-queue statistic

 drivers/net/virtio_net.c     | 112 +++++++++++++++++++++++++++++++++++
 drivers/virtio/virtio_ring.c |  18 +++++-
 include/linux/virtio.h       |   2 +
 3 files changed, 130 insertions(+), 2 deletions(-)

-- 
2.51.0

