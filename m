Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A7BF3A962D
	for <virtualization@lists.linux.dev>; Tue, 31 Mar 2026 10:27:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774952823; cv=none; b=hIt6bea65qtz9q8h/qQLrLkMqkDU9capy522yxc+CDmZSy5WzaXwaG22pXjloyYiQ/yZFReogcXLd6CAZyWuT2tVgOsQNmRgy2XMOx9Xx8CAcmMULb2kuJxEvT/qQAGE6uorrK7m1KSREVqyeJi4Az6OllLvRZFOSJ14cgCJr/o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774952823; c=relaxed/simple;
	bh=5pm7Qn2XElzYS3fOUrGjF0VgmVwF+RJXnmray/+6o7o=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=nuEYyQ6rxw3TIlIVwCeT2jq4ry5shIEUGS6ixXIXIdtrHn1Hy79dafmUZYeB9LaSMssWln2rGF4Q58gImDw5WgLxamH5u2uJOM9R8gbWgXCTzFzFhJfhIQPdnyV4ELfx8uau8iAM55py03yRaQwRJhtrFKSxQJLzfr79WbWR5fQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=S9lftEu5; arc=none smtp.client-ip=117.135.210.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="S9lftEu5"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=R+
	rgBVCQ57bDSptspbbbF6BPdxKY94YGMQDVjYD8ids=; b=S9lftEu5Mw50/JpsNQ
	XVFXe7/e4Sx2XBEUpPfFbLRxCaJ0Fg2wosKixcB5UxROEg2emOhZxeplhHTZEIty
	/lLMOFiITwMwWhG0u6GP9wfJiwGGHCuj1y1kBvUmV3yHwCApVa2XbSXxPg5Qyu7D
	Dm7s6EVqdz3ifpG+JGIFlJdac=
Received: from localhost.localdomain (unknown [])
	by gzga-smtp-mtada-g0-0 (Coremail) with SMTP id _____wDHqoNToctphXY9CQ--.9353S2;
	Tue, 31 Mar 2026 18:26:27 +0800 (CST)
From: Longjun Tang <lange_tang@163.com>
To: mst@redhat.com,
	jasowang@redhat.com,
	xuanzhuo@linux.alibaba.com,
	edumazet@google.com
Cc: lange_tang@163.com,
	tanglongjun@kylinos.cn,
	virtualization@lists.linux.dev
Subject: [PATCH 0/2] fix virtio_net/virtio when in busy-polling
Date: Tue, 31 Mar 2026 18:26:24 +0800
Message-Id: <20260331102626.108962-1-lange_tang@163.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wDHqoNToctphXY9CQ--.9353S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7WF48Xry5KrWxJFWDZw13urg_yoW8Gw4UpF
	WUK3yF9F4jvryIyFn3XF1qkw15Zwn3ArWfGrn7u3yUCw15KF48Xr10kFyFvFyUuw4kCw12
	vrs5Za45ua45XrJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0pEb18DUUUUU=
X-CM-SenderInfo: 5odqwvxbwd0wi6rwjhhfrp/xtbC-hPJ92nLoVOsswAA3c

From: Longjun Tang <tanglongjun@kylinos.cn>

hi,
about this two patch:
1. virtio_net: disable cb when in busy-polling
When in a busy-polling context, it's possible to be in an enable cb 
state,even though it doesn't need to be. This can lead to vring_interrupt
returning IRQ_NONE. so, This patch proactively disables the cb when
in busy_polling.

2. virtio_ring: return IRQ_HANDLED for stale interrupts when cb disabled
In the vring_interrupt, if the used ring is empty, IRQ_NONE is returned.
However,Sometimes, such as with busy-polling, buffers might be consumed
from the used ring before an stale interrupt notification arrives. it
leading to return IRQ_NONE.The kernel's spurious-IRQ detector counts 
consecutive IRQ_NONE returnsand will permanently disable the interrupt 
line if 99,900 out of 100,000 interrupts go unhandled. so, this patch
add is_cb_disabled() to virtqueue_ops and, when more_used() is false but
cb are suppressed, return IRQ_HANDLED instead of IRQ_NONE so the spurious
counter does not accumulate.

stale interrupts: the device posted this notification before it observed
the cb suppression;


Longjun Tang (2):
  virtio_net: disable cb when in busy-polling
  virtio_ring: return IRQ_HANDLED for stale interrupts when cb disabled

 drivers/net/virtio_net.c     |  3 +++
 drivers/virtio/virtio_ring.c | 29 +++++++++++++++++++++++++++++
 2 files changed, 32 insertions(+)

-- 
2.43.0

