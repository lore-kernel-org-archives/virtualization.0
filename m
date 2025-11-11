Received: from out30-110.freemail.mail.aliyun.com (out30-110.freemail.mail.aliyun.com [115.124.30.110])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDF21351FDF
	for <virtualization@lists.linux.dev>; Tue, 11 Nov 2025 11:12:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.110
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762859546; cv=none; b=nzUilri9FRQGu+1QWuA4R0QrwPBqX94+2sbMkNJs5bMTGq3oGseDL77L9vlsE8iaETWgEDxL8Ce3THwDZyJrI2ZZf5ywIlUOltcXiQL9N3PvyMI+AK357jiNyOiGMveYni8Y4IzVt3F8g22pxvuQ+pYgLFOX0u4V03OBIagHYVE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762859546; c=relaxed/simple;
	bh=M5ewjUi4yLus3HcD5leOqBCi/HqiKbKYJtq/GQSbD7s=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=EpQjThrlBgudq6eYGxanCdrEvC/RDiJw9voWyEcjHWJFhg9guXdWpCxhSPx788bPnhoSA9QW88MFl5swxu+FuaFI0shq8mifdVKu5h8qzb2SjEnAO493GF4hNazLkBNWEC5+NyL897OhTNStxTodu2Tfss9IZBEfDo/AdSlPFbY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=rX62hdbu; arc=none smtp.client-ip=115.124.30.110
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="rX62hdbu"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1762859533; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=nVqpNz4zmQtnhgYeVe3TQQhFUL1KimGDuNjnX3WYQhU=;
	b=rX62hdbu7dmZbn/XtmwIUsH5vINY+HwmMSc0VtBOcx3vSBohW/9wU/uRlW+BANaNsXbhz8zqLOYa8y6hfnFWux87CewX3DnQGPaMCMUVMmcyzFBZ/zxZ1KPydgLSWlDKWvceD7dcCqYE6I+1qkhIovf3S5lKwSokECqIWIWbgGw=
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com fp:SMTPD_---0WsBONCA_1762859532 cluster:ay36)
          by smtp.aliyun-inc.com;
          Tue, 11 Nov 2025 19:12:12 +0800
From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
To: netdev@vger.kernel.org
Cc: Richard Weinberger <richard@nod.at>,
	Anton Ivanov <anton.ivanov@cambridgegreys.com>,
	Johannes Berg <johannes@sipsolutions.net>,
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
	Jason Wang <jasowang@redhat.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	=?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Jiri Pirko <jiri@resnulli.us>,
	Alvaro Karsz <alvaro.karsz@solid-run.com>,
	linux-um@lists.infradead.org,
	virtualization@lists.linux.dev
Subject: [PATCH net v5 0/2] virtio-net: fix for VIRTIO_NET_F_GUEST_HDRLEN
Date: Tue, 11 Nov 2025 19:12:10 +0800
Message-Id: <20251111111212.102083-1-xuanzhuo@linux.alibaba.com>
X-Mailer: git-send-email 2.32.0.3.g01195cf9f
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Git-Hash: feb36a32054d
Content-Transfer-Encoding: 8bit

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

 arch/um/drivers/vector_transports.c |  1 +
 drivers/net/tun_vnet.h              |  4 +--
 drivers/net/virtio_net.c            |  9 +++++--
 include/linux/virtio_net.h          | 40 +++++++++++++++++++++++------
 net/packet/af_packet.c              |  5 ++--
 5 files changed, 45 insertions(+), 14 deletions(-)

--
2.32.0.3.g01195cf9f

