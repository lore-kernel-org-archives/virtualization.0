Received: from out30-112.freemail.mail.aliyun.com (out30-112.freemail.mail.aliyun.com [115.124.30.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D5E53DE42D
	for <virtualization@lists.linux.dev>; Wed, 11 Mar 2026 11:54:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.112
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773230065; cv=none; b=cWD/VZA9jh2OFypJeMrpkK8pQ47Om1cfcQM6H9hWUF78tVz+kxVQOGla+a69fUqQ4hhgZnN03kaSUihEA1Ey69fzss+4Mi5wSW5L+gY745AIbCDwwlrkRx4t8FGxRvVEKyiF2z1GWJ6eyjeVrjnsYB9dhVeDYqZXJ1Yjt4jHOQk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773230065; c=relaxed/simple;
	bh=IMnjKnGRtpiO4K60kqahJfD0CXWi3GaCjPXwJUQchdw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=K3FT6AvQxzpS1SR8ZQugS2kJWnFziAFWAyruu+tByMYdKJDaZhjDpdVGufY6g+FiaaxmZVDJe3pntM/r8wCh9Y1UC71o5e8GtLR2CrJ/oNnQT021eCk3piU9cKdh3h+WY1zGTlYYkAJCo9OsRK1of93MoyH7EGxjN9AFZzubLmc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=rj9LdSBk; arc=none smtp.client-ip=115.124.30.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="rj9LdSBk"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1773230055; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=a1PdeYd1K8Fs0ta/NrWccE4W5qv2O99W55DACnHqO0E=;
	b=rj9LdSBkNazKKPBWF1zTu3SbzpHfZOu8biYs9rgdon1poxfvEZBsE3eGzp0WDIyfNSDI7BtyqSytfLy6gMJGUQ7z5o24LhfUWXhLkqqj/jauku6JXonA3k6AkBJCUry7P7xE8c7RqBg6Jn7Xt6MIcnIHKbee5cs9p8CCPA2+Mdg=
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com fp:SMTPD_---0X-k0AI8_1773230054 cluster:ay36)
          by smtp.aliyun-inc.com;
          Wed, 11 Mar 2026 19:54:15 +0800
From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
To: netdev@vger.kernel.org
Cc: Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
	Jason Wang <jasowang@redhat.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	=?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>,
	Jiri Pirko <jiri@resnulli.us>,
	Alvaro Karsz <alvaro.karsz@solid-run.com>,
	virtualization@lists.linux.dev
Subject: [PATCH net v9 0/2] virtio-net: fix for VIRTIO_NET_F_GUEST_HDRLEN
Date: Wed, 11 Mar 2026 19:54:12 +0800
Message-Id: <20260311115414.31243-1-xuanzhuo@linux.alibaba.com>
X-Mailer: git-send-email 2.32.0.3.g01195cf9f
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Git-Hash: e88adc2e5a2a
Content-Transfer-Encoding: 8bit

v9:
  1. Introduce new helpers to set hdr len, and virtio_net_hdr_tnl_from_skb
  calls them directly.

v8:
  1. move changes of virtio_net_hdr_from_skb for udp tunnel to #2
  2. remove change for num_sg

v7:
  1. fix bug reported by robot
  2. Still splitting into two commits, as the issues fixed originate from
     different commits. This separation makes it easier to selectively revert to
     previous versions.

v6:
  1. rename to guest_hdrlen
  2. introduce a function virtio_net_set_hdrlen to set the hdrlen

The commit be50da3e9d4a ("net: virtio_net: implement exact header length
guest feature") introduces support for the VIRTIO_NET_F_GUEST_HDRLEN
feature in virtio-net.

This feature requires virtio-net to set hdr_len to the actual header
length of the packet when transmitting, the number of
bytes from the start of the packet to the beginning of the
transport-layer payload.

However, in practice, hdr_len was being set using skb_headlen(skb),
which is clearly incorrect. This path set fixes that issue.

As discussed in [0], this version checks the VIRTIO_NET_F_GUEST_HDRLEN is
negotiated.


[0]: http://lore.kernel.org/all/20251029030913.20423-1-xuanzhuo@linux.alibaba.com





Xuan Zhuo (2):
  virtio-net: correct hdr_len handling for VIRTIO_NET_F_GUEST_HDRLEN
  virtio-net: correct hdr_len handling for tunnel gso

 drivers/net/tun_vnet.h     |  2 +-
 drivers/net/virtio_net.c   |  6 ++++-
 include/linux/virtio_net.h | 51 +++++++++++++++++++++++++++++++++++---
 3 files changed, 53 insertions(+), 6 deletions(-)

--
2.32.0.3.g01195cf9f

