Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=111.22.67.137
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794137954;
	b=LiiweJfFxruMYSvrGPOlFNUxFGNbcqVsOYLnu0hJjse79531VT09fmj4kAHW0aabML6I
	 n+ja4cOVZq+h9jou+CMtVoD9Ez//1NIR9aeg/5D40w/S/WybuDZKMJpQ8BcoFjWP2uxdv
	 adHcOD50PJqQO1dL8KEz8LVwFf8FQ0TEV29LzAjvjWLjSw0oapF1Wg4ZMgwf3cNwBCJPJ
	 zpXK0BwC7qcKR/N6g/jSV6iF9rvJlsyzYf6b0q7uZlWg/Um6X4FeqvePiMDaq4gXvtTbm
	 kkhddEo1AXiGvX4KctTcv90/tluPHeuLYb1Yu8FIaLlL9dpNkYz4JaGu2rU0rvumZkg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794137954;
	h=DMARC-Filter:DKIM-Signature:X-RM-TagInfo:X-RM-SPAM-FLAG:Received:
	 X-RM-TRANSID:X-RM-TagInfo:X-RM-SPAM-FLAG:Received:X-RM-TRANSID:From:
	 To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=k/JlVhtdHW1N7+kfk+zWcbzIZHLZh0ZrTv2A0uour0Y=;
	b=dldC23rk5fz7D0DWQWUSeBNWGyURuNykFu0SZFF1qUKCWD2S+rDGtS5cnSbIu1AyTMZ2
	 D47u673AXZRufm1n2+u36ULgHYzDquIzC8IvvjWoyFc7zYt9VTmHpgaoPQ1Lcocznmeop
	 rjy5scDgIOnvMik7M8ywSK/RuweUCT8NXL0+Xg6jJ8MPLKXWnxauFAV0R+s/W8SSmxPEU
	 Ego+Q9o6w4cM1jMx+hr3NwSCfVdF48i4v5icnt++ulNZrJJkTELY9XDSxbCr2MZ0a/Su9
	 z3tUr80PHKO4RgvcUNnp+3Yv01abw9SbDNEEo6zZIofZf4MdXM/J0XR3GbA5Vta371w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=cmss.chinamobile.com;
	spf=pass smtp.mailfrom=cmss.chinamobile.com;
	dkim=pass header.d=cmss.chinamobile.com header.i=@cmss.chinamobile.com header.a=rsa-sha256 header.s=default header.b=bQ0UtJQT;
	arc=none smtp.remote-ip=111.22.67.137
Received: from cmccmta4.chinamobile.com (cmccmta4.chinamobile.com [111.22.67.137])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F12C606A321
	for <virtualization@lists.linux.dev>; Sun,  8 Nov 2026 11:39:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6F12C606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmss.chinamobile.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmss.chinamobile.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=cmss.chinamobile.com header.i=@cmss.chinamobile.com header.a=rsa-sha256 header.s=default header.b=bQ0UtJQT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=cmss.chinamobile.com; s=default; l=0;
	h=from:subject:message-id:to:cc:mime-version;
	bh=47DEQpj8HBSa+/TImW+5JCeuQeRkm5NMpJWZG3hSuFU=;
	b=bQ0UtJQT/dgIUSZd+hfA3NZf90pdvg1CzJBYIsVuOR7Ut1tMz7kobpi19EQRoqDCtgJOzK6NuFQjt
	 15Eu87YHioxIv59a8eyvESMPUgXDaB0OiFpOgD88QVyth3hm0AmZhXHJnECELvR9ckSrMdwcPfTX6U
	 qqHppyYQcZzVHTWc=
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from spf.mail.chinamobile.com (unknown[10.188.0.87])
	by rmmx-syy-dmz-app08-12008 (RichMail) with SMTP id 2ee86af05f58330-5b2ef;
	Sun, 08 Nov 2026 19:39:09 +0800 (CST)
X-RM-TRANSID:2ee86af05f58330-5b2ef
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from openEuler-24.03.03 (unknown[74.82.203.40])
	by rmsmtp-syy-appsvr10-12010 (RichMail) with SMTP id 2eea6af05f47e53-6669c;
	Sun, 08 Nov 2026 19:39:09 +0800 (CST)
X-RM-TRANSID:2eea6af05f47e53-6669c
From: Haishuang Yan <yanhaishuang@cmss.chinamobile.com>
To: "Michael S. Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowangio@gmail.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Cc: =?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	Stanislav Fomichev <sdf@fomichev.me>,
	netdev@vger.kernel.org,
	virtualization@lists.linux.dev,
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net v2 0/3] virtio_net: AF_XDP zero-copy fixes for arm64 and suspend
Date: Mon,  9 Nov 2026 04:38:36 +0900
Message-ID: <20261108193845.73621-1-yanhaishuang@cmss.chinamobile.com>
X-Mailer: git-send-email 2.43.0
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

Three AF_XDP zero-copy fixes for virtio_net.

Patch 1: on arm64, binding a zero-copy socket fails with -ENOMEM and a
"rejecting DMA map of vmalloc memory" warning whenever the device uses
the DMA API (e.g. VIRTIO_F_ACCESS_PLATFORM), because the static TX
header lives in the kernel image, which arm64 maps in the vmalloc area.

Patch 2: removing XDP can leave a zero-copy pool bound to a queue above
curr_queue_pairs. Closing the socket then fails in the driver, and the
queue is refilled from the freed pool.

Patch 3: freeze frees the rx/tx queues while the sockets stay bound in
the xsk core. The driver state of the pools is leaked, and closing the
socket after resume hits a "Missing register" warning and a NULL
pointer dereference in xp_dma_unmap(). v2 keeps the pools DMA mapped
across suspend and only moves the driver state to the new queues.

Freeze also drops the XDP program of virtio_net, so it has to be
attached again after resume. That is an older issue and this series
does not change it.

Testing used x86_64 KASAN kernels in QEMU/KVM (q35, intel-iommu,
virtio-net-pci with iommu_platform=on, x-pcie-pm-init=off) with a
small /init that binds an XDP_ZEROCOPY socket, redirects to it with an
XSKMAP program, and sends an ARP request through the TX ring and waits
for the reply on the RX ring, before suspend and after each of two
suspend cycles (pm_test=devices), then closes the socket:

- net: no TX or RX on the socket after resume, and an oops when it is
  closed. With a socket bound to an XDP queue and XDP removed, closing
  it gives "Failed to disable zero-copy!" and a KASAN use-after-free in
  xp_alloc_batch().
- v1: passes with an aligned umem, but with an unaligned umem nothing
  is received after resume. The XDP queue case behaves as on net.
- v2: all cases pass, without warnings, also with an unaligned umem and
  with a suspend cycle between removing XDP and closing the socket.

The test program is not part of the series; I can send it if useful.
Patch 1 is unchanged since v1, where it was tested on arm64 (QEMU TCG,
virt) with a KASAN kernel; arm64 was not tested again for v2. Real
hibernation and multiqueue traffic were not tested.

The issues were found with the help of an AI coding assistant.

Changes in v2:
- Patch 1: drop the sentence about cache lines from the changelog
  (Sashiko).
- New patch 2, for a pool left on a queue above curr_queue_pairs
  (Sashiko).
- Patch 3: keep the pools DMA mapped across suspend and set the driver
  state up on the new queues before NAPI is enabled, instead of
  disabling and enabling the pools while their sockets are still bound
  (Sashiko). This avoids a race with the RX path on freeze, stale DMA
  addresses with an unaligned umem, and transmitting before the TX
  header is mapped on restore.
- Rebased on net 30c71476d842.

v1: https://lore.kernel.org/netdev/20261107125723.33547-1-yanhaishuang@cmss.chinamobile.com/

Haishuang Yan (3):
  virtio_net: Don't DMA map the kernel image for the AF_XDP TX header
  virtio_net: Disable AF_XDP pools on queues above curr_queue_pairs
  virtio_net: Keep AF_XDP zero-copy pools bound across suspend

 drivers/net/virtio_net.c | 177 ++++++++++++++++++++++++++++++++++++---
 1 file changed, 166 insertions(+), 11 deletions(-)


base-commit: 30c71476d842b094651bd7712f6c8ee8716147d0
-- 
2.43.0



