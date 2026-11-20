Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=117.135.210.5
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795159127;
	b=cW4caMwqHv7ph342pXH1k9marC2x6zTPF1hLTQpHCEUiDFcVLDSnR54/qzUzTm1ZAF6T
	 XZCm2ot4ZdseTRxv3mNomB0q963+VXYa8ITBTJWkjOXL96iK3fO81sDP47WSgvZhUK3jj
	 8q7CzJZpA29wJofJDdjZs20kYYZ7SmQlgBFadCgzaArpw60GhYcfKO1fYhgQ7lUn/FSLo
	 TyAj61k7VeBJilMs1tGqVroVmIU9j2crVCiihwRHb6CdFK26Mggvbp/t+cAOaLFUcHMhp
	 yQPD4zTP/c82uPz89bkT7jLrMl0TBy4hzDaZbMg5+blJ1ZW6lGSsB/g+U05uMv2wAFg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795159127;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-Id:X-Mailer:MIME-Version:Content-Transfer-Encoding:
	 X-CM-TRANSID:X-Coremail-Antispam:X-CM-SenderInfo;
	bh=ReFJvVVBSdvgMbf1ZoY5/kh1HS8Ok7VGssPSK/Gd+ys=;
	b=wb2cnn7iPIWuAAz/EApf3O3aMxc11Z1SLBeI6z/IyyxqZPdsmrv+X8MZJXCuk0qj8h8V
	 bRMV0mGzN60SCyBYNcAaYVuNmXH8QxyzMKhsOiA1FHM5bYiJOFKR4Fg93fmcnIsb05uBY
	 MiL3n3pILj+8ZlL3B4OFx64ASaZaBYTbD4cALa9/nspVzoi6D3nQjXE+VMJ8vdStqjdqp
	 G8nwgODGOeY9L/fEKTohSU+HXHMwMRLygcQTFb5mioszNprqX9kprMk08G6FI0bWMtJw1
	 9iKupO+gRd7/hturzncfjJexyBGNH/t3nh8gYdO/uG7zzNMLnUsc7A11vInviwfs76w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=163.com;
	spf=pass smtp.mailfrom=163.com;
	dkim=pass header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b="eOA9/6JB";
	arc=none smtp.remote-ip=117.135.210.5
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 849B7606A325
	for <virtualization@lists.linux.dev>; Fri, 20 Nov 2026 07:18:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 849B7606A325
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=eOA9/6JB
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=Re
	FJvVVBSdvgMbf1ZoY5/kh1HS8Ok7VGssPSK/Gd+ys=; b=eOA9/6JBZrEFyPhmks
	NvViCBj7aTyMGrkFQ9xPbwIqaNnbk20aScETGvJabRgh5rYTnxTqKkWsMc9XSPxN
	kiORz8J5iN5mq17oG2bDFcXr04b6G71yIJnrZMLEm5wOE7nkhjCfc0RzgOzQnl7X
	/SEnPHqvF+N2qDxWSfAHEdzc4=
Received: from localhost.localdomain (unknown [])
	by gzga-smtp-mtada-g0-3 (Coremail) with SMTP id _____wD354ZD9P9qmowxJA--.12595S2;
	Fri, 20 Nov 2026 15:18:27 +0800 (CST)
From: Longjun Tang <lange_tang@163.com>
To: mst@redhat.com,
	kuba@kernel.org,
	eperezma@redhat.com,
	jasowangio@gmail.com
Cc: xuanzhuo@linux.alibaba.com,
	virtualization@lists.linux.dev,
	netdev@vger.kernel.org,
	tanglongjun@kylinos.cn,
	Longjun Tang <lange_tang@163.com>
Subject: [PATCH v2 0/3] virtio_net: introduce an RX queue watchdog for stuck detection
Date: Fri, 20 Nov 2026 15:18:23 +0800
Message-Id: <20261120071826.198604-1-lange_tang@163.com>
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
X-CM-TRANSID:_____wD354ZD9P9qmowxJA--.12595S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxCw4fCr4DJFW3WF1DJFWUArb_yoW5Xw1UpF
	WYk3Z8Zr95GryS9aySvF48Jry5Aan3Aw42yrn7t348AFs0yr40qr1UKFy5tFyUCrykCw12
	vF1Fg3yDCw1DZaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0piC31iUUUUU=
X-CM-SenderInfo: 5odqwvxbwd0wi6rwjhhfrp/xtbC-QPnFmr-9EONPgAA3e

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

Patch 1 exposes last_used_idx through a new helper, which is used by both
the split and the packed ring and denotes the position the driver has
last consumed. Together with the existing virtqueue_poll(), it lets a
driver ask whether the device has produced buffers that the driver has
not consumed yet ("backlog").

Patch 2 adds a per-device RX watchdog that scans all RX queues once per
second. A queue is considered stuck when, for 5 seconds, all of the
following hold simultaneously:
  - the queue has a non-zero backlog (unconsumed buffers);
  - the driver makes no consumption progress (last_used unchanged);
  - no new interrupt arrives (rq->calls unchanged).
On detection it logs a warning, rate-limited to once per timeout, and
reschedules NAPI, which drains the ring and refills the descriptors,
so the queue recovers.

Patch 3 adds a per-queue stalls statistic, exposed via ethtool -S, so
the number of stuck events can be observed per queue.

questions and comments are welcome.

Thanks!
Lange

Changes in v2:
- 1/3: fix the kdoc.
- 2/3: drop the module parameter, use a fixed 5s timeout.
- 3/3: rename rx_timeouts to stalls.

Longjun Tang (3):
  virtio: add virtqueue_get_last_used_idx() helper
  virtio_net: introduce an RX queue watchdog for stuck detection
  virtio_net: add stalls per-queue statistic

 drivers/net/virtio_net.c     | 105 +++++++++++++++++++++++++++++++++++
 drivers/virtio/virtio_ring.c |  18 +++++-
 include/linux/virtio.h       |   2 +
 3 files changed, 123 insertions(+), 2 deletions(-)

-- 
2.25.1

