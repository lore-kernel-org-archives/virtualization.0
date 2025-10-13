Received: from out30-100.freemail.mail.aliyun.com (out30-100.freemail.mail.aliyun.com [115.124.30.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1A6823C8C5
	for <virtualization@lists.linux.dev>; Mon, 13 Oct 2025 02:06:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760321202; cv=none; b=QL6dgWf/zNiVszkxX9iBxx4fTFig4HWKepOp1rorPzEkPfuCwQ3tlehGm3239soJtYNgiA98/OATKHHBKqQI6+hH7/KzWrRv2oB8Z5lPFwkPriHDAXJ+MrITnnitVEZfdclHCooLmVBOAA7dfPzflFL6IkhsoyY2epBrxY5+C+U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760321202; c=relaxed/simple;
	bh=JQeci8kKFhUqNqSiKukDhGQ1oMGj2u2fkEVG4LJqWeE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=MC3twXJDRitJxfoXhIr+fVYTqCPMWveMv2D+M9B4SX1OJfFUzhe/UIJ8Dvciyip6WxM5wwp3LIQ777L/dlD2p+RyexB5a7rABrIjQnTZHI/KWelUQ6OQblncncKMAukzm5iVjYL8sEwZNwSR8MAc7gHebOLh6CxZC7LD/bKCbFY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=xfl3x8S6; arc=none smtp.client-ip=115.124.30.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="xfl3x8S6"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1760321191; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=0KMzj+miCiTqLWcLN1eA5YLqErPlKnWHSP2dVaYTGYY=;
	b=xfl3x8S6Cl4CXNlI+N87SkXtWnwK18vINLcxoaFzrlCjiIgIK+yyzhN2/tPExNc+8K0qPiLKTKcBRjkk9WGH+27lu3I3nIAfpXv4cLJdqKg4c2mwxgZiroMKHBMPVEyYUbX+qqgeWOHAWd6JLwKcI8VdAs3Jlb01YC2SLZbquBU=
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com fp:SMTPD_---0WpzsXhN_1760321189 cluster:ay36)
          by smtp.aliyun-inc.com;
          Mon, 13 Oct 2025 10:06:30 +0800
From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
To: netdev@vger.kernel.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	=?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Willem de Bruijn <willemb@google.com>,
	Jiri Pirko <jiri@resnulli.us>,
	Alvaro Karsz <alvaro.karsz@solid-run.com>,
	Heng Qi <hengqi@linux.alibaba.com>,
	virtualization@lists.linux.dev
Subject: [PATCH net v2 0/3] fixes two virtio-net related bugs.
Date: Mon, 13 Oct 2025 10:06:26 +0800
Message-Id: <20251013020629.73902-1-xuanzhuo@linux.alibaba.com>
X-Mailer: git-send-email 2.32.0.3.g01195cf9f
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Git-Hash: 06377f1ca66f
Content-Transfer-Encoding: 8bit

As discussed in http://lore.kernel.org/all/20250919013450.111424-1-xuanzhuo@linux.alibaba.com
Commit #1 Move the flags into the existing if condition; the issue is that it introduces a
small amount of code duplication.

Commit #3 is new to fix the hdr len in tunnel gso feature.

Hi @Paolo Abenchi,
Could you please test commit #3? I don't have a suitable test environment, as
QEMU doesn't currently support the tunnel GSO feature.

Thanks.

Xuan Zhuo (3):
  virtio-net: fix incorrect flags recording in big mode
  virtio-net: correct hdr_len handling for VIRTIO_NET_F_GUEST_HDRLEN
  virtio-net: correct hdr_len handling for tunnel gso

 drivers/net/virtio_net.c   | 16 ++++++++-----
 include/linux/virtio_net.h | 46 ++++++++++++++++++++++++++++++++------
 2 files changed, 50 insertions(+), 12 deletions(-)

--
2.32.0.3.g01195cf9f

