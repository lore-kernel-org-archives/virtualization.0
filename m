Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=159.69.87.85
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793941386;
	b=L1nuyc1okiQN9VgK0Amj53bC03BXl0dj+dY1ofo3WxpvsJVyMQQS2pMiNx0fwhKD0NgJ
	 QCS1tfDypk5CYwWTT1AO9cFWCzfyCfGMDopEilomcGOhphREnAq/0L0cU0v9pM1FPS9z5
	 l/Nvcwa65AazLCm9tyUCeyKHjxsTIJ81pwwwB70lHoJD74zNTM9TITUbZcPGr1ZwMaS5m
	 9LL3DHKsWdD0xZ/xaNW3geyRkaGOE+vdagJd4Zi5kZA2FzIGZLxcmZZgfV7yYqsH8b/p2
	 B1NQZ9StzFvzTyT+JutVFdLiUaXCETwuZfsuOtxw/zkHA1ZF2ESrmGbK2YZHXfwAPtA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793941386;
	h=DMARC-Filter:Received:DKIM-Filter:DKIM-Signature:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=P+cO6ALFn4ynv3OOBT/y6EBvmBlsF2ZJXUMXhExZ1l8=;
	b=5LeEgvfZRrPPXr19vOdQeqy5a3+Gxk5ALb5Tlv6hE6B5dHDiPLKnH8Rg+GKowouBRUe3
	 O1hpGe1zAritIQxsiq5/lGn46dbkQr1lmwSKzFl0Slq7uD4G3xVfBYUYQJvJbVNqX6TCu
	 uWtdf5LegCX5pPUNuRE88FY5frDQMYK9++lX/csoqhUNOzoQ8Ukt8KhquJ1iPXkh2nnFd
	 TVFsvKjBx9pDVif6L9X76cE/VgRAADW6QH0BPinbgPu9HlXbvxYwfnHsIa08gSu9wO7z/
	 QojqfEczwWQXF/zKQSMJgwoZF/kyEmlHS3M+pQBqEc7uI2uxWBcuFYoE7FjHynOYTlA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linuxhacker.ru;
	spf=pass smtp.mailfrom=linuxhacker.ru;
	dkim=pass header.d=linuxhacker.ru header.i=@linuxhacker.ru header.a=rsa-sha256 header.s=mail header.b=WnWQd8WH;
	arc=none smtp.remote-ip=159.69.87.85
Received: from eagle.linuxhacker.ru (linuxhacker.ru [159.69.87.85])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86B62606A33A
	for <virtualization@lists.linux.dev>; Fri,  6 Nov 2026 05:03:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 86B62606A33A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxhacker.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxhacker.ru
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linuxhacker.ru header.i=@linuxhacker.ru header.a=rsa-sha256 header.s=mail header.b=WnWQd8WH
Received: from intelbox1.virtnet (unknown [162.81.204.199])
	by eagle.linuxhacker.ru (Postfix) with ESMTPSA id 02380BEE42;
	Fri,  6 Nov 2026 05:03:00 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 eagle.linuxhacker.ru 02380BEE42
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxhacker.ru;
	s=mail; t=1793941382;
	bh=czCB3kW021QBoOVBYCflGEJsyZ7jwVnnd8tARhzgMaM=;
	h=From:To:Cc:Subject:Date:From;
	b=WnWQd8WHVyV3q7/padmFXXeqhe0TYuLgw+UBvogn2VRgIpwGovAGkxTH0+tQzB8M1
	 cbYcZEUG654u4I7kYZIbzXJTgXGTq30RQqJrpPFEsXDAe5ank0VBXzdBw7Zvy/qgTa
	 La+brbagfcYYo+1pKNx1r1H8UPgfDLEGkNoUiJ9/ucV7jgW6TMkDYCG/myszOC7ctd
	 bh78AbkMZi+KxW2j+5dVgzWoH/tbzdKaePFgC+lmiiYXhiqD6HQPdM8sQ966Y8Jhz0
	 y7HTxELU84/lbmAjCSh7wzPVmmj6lX4xtKdwdHA29y6GYKnbuu0U6/v01B3tcOWRVm
	 Ho086BP5nssyQ==
From: Oleg Drokin <green@linuxhacker.ru>
To: sgarzare@redhat.com,
	stefanha@redhat.com,
	mst@redhat.com
Cc: jasowangio@gmail.com,
	eperezma@redhat.com,
	xuanzhuo@linux.alibaba.com,
	bobbyeshleman@meta.com,
	davem@davemloft.net,
	edumazet@kernel.org,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	netdev@vger.kernel.org,
	virtualization@lists.linux.dev,
	kvm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net v2 0/3] vsock/virtio: bound what a peer can make the host queue
Date: Fri,  6 Nov 2026 00:02:41 -0500
Message-ID: <20261106050244.602625-1-green@linuxhacker.ru>
X-Mailer: git-send-email 2.56.0
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

A virtio-vsock peer that does not consume what it is sent can make the
local side queue memory that no limit covers. On a host the peer is a
guest, and the memory is GFP_KERNEL, charged to no memory cgroup. Two
ways remain on net/main:

 - the send credit trusts the fwd_cnt the peer reports, so a peer that
   never reads but keeps acknowledging gets unlimited credit (patch 2);
 - credit updates are not bounded at all: a peer can solicit them with
   OP_CREDIT_REQUEST, or by sending small packets that a reader drains,
   while posting no rx buffers (patch 3). The same works against a
   guest whose device stops reading the tx virtqueue.

Patch 1 fixes the accounting of packets that vhost drops on rx errors;
patch 2 relies on bytes_unsent being right.

These were found by an LLM-assisted security review of vhost-vsock,
done while porting a project from Xen to KVM. Patches 2 and 3 were
reproduced (below); the error paths of patch 1 were not, as they need a
guest that posts malformed rx buffers. The same review found the
receive skb sizing problem that Daehyeon Ko independently fixed in
d5e912448cd9 ("vhost/vsock: size receive SKBs from declared payload"),
so that part is not in this series.

Nothing changes on the wire, except that fewer credit updates are sent.

Tested in an x86_64 qemu/KVM guest running the kernel under test
(net/main fafbc4051123). For the host side, the "guest" is a user-space
program driving /dev/vhost-vsock directly, talking to plain AF_VSOCK
host sockets. For the guest side, a nested guest running the same
kernel uses a vhost-user vsock device that stops reading its tx
virtqueue:

  case                                      net/main      this series
  lying fwd_cnt, no rx buffers, 2 s of      256 MiB       256 KiB
  non-blocking send() on one socket         queued        (one window)
  20000 OP_CREDIT_REQUEST, no rx buffers    +18.5 MiB     +0
  20000 1-byte packets, each read by host   +18.1 MiB     +24 KiB
  guest, tx virtqueue full, 200             200 credit    2
  OP_CREDIT_REQUEST on one connection       updates

vsock_test from tools/testing/vsock passes over loopback and between a
nested guest and its host. A bidirectional stress test (up to 512
connections streaming both ways, readers draining in small reads) runs
without stalls, and vsock_perf throughput stays within run-to-run noise.
A test that moves sockets between transports in connect() while their
packets are queued passes. With KASAN and lockdep enabled, these tests
show no reports.

The reproducers (a user-space program that drives /dev/vhost-vsock as
the guest, and the vhost-user device) are available on request.

Changes in v2:
 - patch 3: fold a new credit update into the one the socket already has
   queued, rewriting its header under the queue lock, instead of
   tracking it from virtio_vsock_sock with a refcount, an skb destructor
   and transmit hooks (review). vhost and the guest driver are no longer
   touched. A failed add to a full guest tx virtqueue no longer lets
   another update through (Sashiko).
 - patch 2: commit message only, the writer's wakeup is gated by
   sock_writeable().
 - all patches: say how the issues were found; patch 3 gives its test
   results.
 - rebased on net/main fafbc4051123.

v1: https://lore.kernel.org/netdev/20261105000141.3617241-1-green@linuxhacker.ru/

Oleg Drokin (3):
  vhost/vsock: release the accounting of packets dropped on rx errors
  vsock/virtio: bound the send credit by bytes not yet consumed by the
    transport
  vsock/virtio: fold credit updates into the one a socket has queued

 drivers/vhost/vsock.c                   | 23 +++++++--
 include/linux/virtio_vsock.h            | 66 ++++++++++++++++++++++++-
 include/net/af_vsock.h                  |  6 +++
 net/vmw_vsock/virtio_transport_common.c |  8 ++-
 net/vmw_vsock/vsock_loopback.c          |  2 +
 5 files changed, 98 insertions(+), 7 deletions(-)

-- 
2.56.0

