Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=111.22.67.139
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794296188;
	b=wcsJ6geq3inGychjCD3wyE+fSg1gLQh3VSv8S7TU8QOPUY7vYq9Zjh2iviFigjJMvV+6
	 ot/wwfeMIIrgCIV52Tm+5Qf4F5kJJemNd6ta8PtNPHh/YXsWe5cKEoO4XXU1UpPW5WeMT
	 PI3MUdOIg1dAnrvF240SKpExPb2qJ4VRifLK0pCehhiP9+7Ix510XG0d5PTO3fTG6EJg2
	 ky6En0vNflm9p5uxjlwV8EJg6cjDGzi+Prv7IsUsmR7TWYKAsTPaSc3l93gHsFowS1VrH
	 3vWp4znFigos0NfIWC481taAAwZ1V5+Jl8BwTRjMCPuyIO6HnhDyxa1PVsoEgCFM7yw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794296188;
	h=DMARC-Filter:DKIM-Signature:X-RM-TagInfo:X-RM-SPAM-FLAG:Received:
	 X-RM-TRANSID:X-RM-TagInfo:X-RM-SPAM-FLAG:Received:X-RM-TRANSID:From:
	 To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=cFd6ezi/lAlBtvDnXCqb/PVYufkJTh2+r/D5VNJo2rw=;
	b=Ytn6mFlQIuN3jgut+5Pwb+1tp0QQemPFwKioGDduSsksQdrQ9J/VxiQ/M7AEXCwZaqWf
	 gsvGOnJn1RHSJZUG3aQFhwH+Ryzj6YeLNBUN7mHHrb26Z2UoFprpjllGMEspZ2vqrcORf
	 QObfgXmG2wTP1CiAUthzt5ceSA5ygh2Tx+LWdqMCDWX6nltJ7mTi/W5FdZVCM1HWmC9Qg
	 FPPIEJg715WKe7rLMGRDmaElHYpU6WP/Aj8EhIYChEFuv6zWFVIQcmCDO8QOn/7clhCJX
	 GVOvlMaq1okvTAYdVA9uJXmfQ4DHWjVE1aF1LhyqgYBXjEUmCJjU34dqauvk8axCWmg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=cmss.chinamobile.com;
	spf=pass smtp.mailfrom=cmss.chinamobile.com;
	dkim=pass header.d=cmss.chinamobile.com header.i=@cmss.chinamobile.com header.a=rsa-sha256 header.s=default header.b=LfTc7lZL;
	arc=none smtp.remote-ip=111.22.67.139
Received: from cmccmta6.chinamobile.com (cmccmta6.chinamobile.com [111.22.67.139])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C75A606A32A
	for <virtualization@lists.linux.dev>; Tue, 10 Nov 2026 07:36:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9C75A606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmss.chinamobile.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmss.chinamobile.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=cmss.chinamobile.com header.i=@cmss.chinamobile.com header.a=rsa-sha256 header.s=default header.b=LfTc7lZL
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=cmss.chinamobile.com; s=default; l=0;
	h=from:subject:message-id:to:cc:mime-version;
	bh=47DEQpj8HBSa+/TImW+5JCeuQeRkm5NMpJWZG3hSuFU=;
	b=LfTc7lZLt4NTisK0hdvZcTeiA5o3yNBjieukBJ5S2AIVeRSJAmR0LsHpC3T2jU2HyOyH++aBgtDwD
	 2xeRppo4t5AGOdM3xnVSBye9/PWbLhcrsCoeKf/OM7rdntJKpNhhreVQCFDg8p3iYXIsAR9lStL8Ou
	 zBhrwVnJY4VPPj0U=
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from spf.mail.chinamobile.com (unknown[10.188.0.87])
	by rmmx-syy-dmz-app05-12005 (RichMail) with SMTP id 2ee56af2c979783-c9cf4;
	Tue, 10 Nov 2026 15:36:26 +0800 (CST)
X-RM-TRANSID:2ee56af2c979783-c9cf4
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from openEuler-24.03.03 (unknown[74.82.203.40])
	by rmsmtp-syy-appsvr03-12003 (RichMail) with SMTP id 2ee36af2c970885-ab713;
	Tue, 10 Nov 2026 15:36:25 +0800 (CST)
X-RM-TRANSID:2ee36af2c970885-ab713
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
Subject: [PATCH net v3 0/2] virtio_net: AF_XDP zero-copy fixes for arm64 and XDP queues
Date: Wed, 11 Nov 2026 00:29:59 +0900
Message-ID: <20261110153003.23731-1-yanhaishuang@cmss.chinamobile.com>
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

Two AF_XDP zero-copy fixes for virtio_net.

Patch 1: on arm64, binding a zero-copy socket fails with -ENOMEM and a
"rejecting DMA map of vmalloc memory" warning whenever the device uses
the DMA API (e.g. VIRTIO_F_ACCESS_PLATFORM), because the static TX
header lives in the kernel image, which arm64 maps in the vmalloc area.

Patch 2: removing XDP, explicitly or when the device is unregistered,
can leave a zero-copy pool bound to a queue above curr_queue_pairs.
Unbinding the socket then fails in the driver, and the queue is
refilled from the freed pool.

The suspend fix that was patch 3 in v2 is dropped from this series.
Review found problems with it for pools on queues above
curr_queue_pairs; it will be reworked and sent separately on top of
these two.

Testing used KASAN kernels in QEMU with virtio-net-pci and
iommu_platform=on:

- Patch 1 on arm64 (TCG, virt): binding an XDP_ZEROCOPY socket fails
  without the patch and succeeds with it.
- Patch 2 on x86_64 (KVM, q35, intel-iommu, two queue pairs): with a
  socket bound to an XDP queue, removing XDP and then closing the
  socket gives "Failed to disable zero-copy!" and a KASAN
  use-after-free in xp_alloc_batch() on net, and no warnings with this
  series. Unbinding the device from virtio_net with XDP attached and a
  socket on an XDP queue gives "Failed to disable zero-copy!" on net,
  and no warning with this series. In both cases the unregister then
  keeps waiting for eth0 to become free; that also happens with only
  XDP attached and no socket, so it is a separate issue.

The issues were found with the help of an AI coding assistant.

Changes in v3:
- Drop patch 3, to be reworked and sent separately (Sashiko).
- Patch 2: mention the unregister path in the changelog (Sashiko).
- Rebased on net 1d5e2c57e9ff; the code of patches 1 and 2 is
  unchanged.

Changes in v2:
- Patch 1: drop the sentence about cache lines from the changelog
  (Sashiko).
- New patch 2, for a pool left on a queue above curr_queue_pairs
  (Sashiko).
- Patch 3: rework (Sashiko).

v2: https://lore.kernel.org/netdev/20261108193845.73621-1-yanhaishuang@cmss.chinamobile.com/
v1: https://lore.kernel.org/netdev/20261107125723.33547-1-yanhaishuang@cmss.chinamobile.com/

Haishuang Yan (2):
  virtio_net: Don't DMA map the kernel image for the AF_XDP TX header
  virtio_net: Disable AF_XDP pools on queues above curr_queue_pairs

 drivers/net/virtio_net.c | 26 +++++++++++++++++++++-----
 1 file changed, 21 insertions(+), 5 deletions(-)


base-commit: 1d5e2c57e9ffc134e14b3f837c8d7c53b508bd22
-- 
2.43.0



