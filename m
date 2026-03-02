Received: from out30-98.freemail.mail.aliyun.com (out30-98.freemail.mail.aliyun.com [115.124.30.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35C5A38CFFC
	for <virtualization@lists.linux.dev>; Mon,  2 Mar 2026 09:04:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.98
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772442263; cv=none; b=J1lc7CuFwJa/yXojuqNDcG+ZVHeDWJM3NASVx55yrMR288UTrv6icwF09Q9Ai3jU9XRiJp4vfl0bjLCPmsFOhjiEuGC6NoiEuNWc2LQ54FJiyPAHrgnbaBy1uxSIWPKVc8RPgd0V9okg4o2NKPH71IMDI2eg6akAfB++8VrQ4Ws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772442263; c=relaxed/simple;
	bh=M/5UGSXmiAi3LMiirhyPHLxvhl0B/FI7SuHP06BOEno=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Knpsr3DBVcLR5S12tBllJNWVAHRtb4hdhgSVyqINGC54YjQiLt3CzWL/YdMJ7c26QWl4jEoRk3IZC9FV10bIH8o6L0jKP3qjTYXEkS1f8KThDrPw8WIGuPCUcMODnKTr2lgs616Van5XezPaJAV6t3Vmf6x77jaZUEtXZQeaCmc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=xfLwrEle; arc=none smtp.client-ip=115.124.30.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="xfLwrEle"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1772442254; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=kbNcH2W+V8ckIXxWzUBT3RoK30EQAg07KZjEUzugMPY=;
	b=xfLwrEle5+xRBY1WWQ7eItCtMFG+1d3AJ/bXa9eErL/mkYRFwkhXYVxO1cjbJ8HSiuOyhVdw3JGl3GjM+Vhpx3/VNiR9vgtPHGdJ58JSeWd9cGDUrEHnirNogzY2UU/SsupBBv4y0O82hMr9LGCEgmK/CRxfMYHKAI1Mbv2kZxI=
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com fp:SMTPD_---0X-2wO1B_1772442253 cluster:ay36)
          by smtp.aliyun-inc.com;
          Mon, 02 Mar 2026 17:04:13 +0800
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
Subject: [PATCH net v7 0/2] virtio-net: fix for VIRTIO_NET_F_GUEST_HDRLEN
Date: Mon,  2 Mar 2026 17:04:11 +0800
Message-Id: <20260302090413.86471-1-xuanzhuo@linux.alibaba.com>
X-Mailer: git-send-email 2.32.0.3.g01195cf9f
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Git-Hash: 411d21554521
Content-Transfer-Encoding: 8bit

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
 drivers/net/virtio_net.c   |  8 +++-
 include/linux/virtio_net.h | 75 ++++++++++++++++++++++++++++++--------
 3 files changed, 67 insertions(+), 18 deletions(-)

--
2.32.0.3.g01195cf9f

