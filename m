Received: from out30-100.freemail.mail.aliyun.com (out30-100.freemail.mail.aliyun.com [115.124.30.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE8C31D618C
	for <virtualization@lists.linux.dev>; Wed, 29 Oct 2025 03:09:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761707360; cv=none; b=CSUI/9KHlK1Zm//Pf0KdnykToqdKKiCdfrqkDInuW6Zdh6LA6WEAivFlHoF+ANRfPCswKJRiyxdxj9Qh5FOKsWBvPIBn68HM+tQHsfOIuS5sIAIxrCM6Bp8KfcQFxFY4XtCs/SsEdOcAn60qgFCwqAKl7nOxKDBNFXHSBbRq1PQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761707360; c=relaxed/simple;
	bh=/x+RI9nrpJQDlZGkxmaDPNggqd6lOH6oIrMEJfLxUHQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=ZccS++yUQYpbznqzAw3vC+kdhqFKZJqYql6eF8P71uCKHQoQ+Lcya7FIhvngN/jYJQLv/E2AOl7SunzAi7E8NRwB3bKwZDpwbZvfjO8aP5LbvfbQdJBjXXe9SGzDS6v66gPgoB/OSAtz3Q4r+q0KG80vWEEMj0wO1hhOzaW7vMA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=RZq//NsA; arc=none smtp.client-ip=115.124.30.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="RZq//NsA"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1761707354; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=xwXnQ84rlwUem24mAJSes+X5+w9nR+WDYcLg7DXFTR0=;
	b=RZq//NsA6yDtpnOVwdJk8dRrqrlRt0a8/4kgFHjJtsXcaQHqn+nfjPhRsWC6qPuwVMA2R1URbHdO3uwfZ88dbtgDK43nd4fFBlh4tozikhkWoK1C8zDzFaMfhvwuhZZc+pJV4W6AUHT554W0cLthewi9ctXi522aJ/9Ogyll1M0=
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com fp:SMTPD_---0WrECN9P_1761707353 cluster:ay36)
          by smtp.aliyun-inc.com;
          Wed, 29 Oct 2025 11:09:13 +0800
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
	Heng Qi <hengqi@linux.alibaba.com>,
	Willem de Bruijn <willemb@google.com>,
	Jiri Pirko <jiri@resnulli.us>,
	Alvaro Karsz <alvaro.karsz@solid-run.com>,
	virtualization@lists.linux.dev
Subject: [PATCH net v4 0/4] fixes two virtio-net related bugs.
Date: Wed, 29 Oct 2025 11:09:09 +0800
Message-Id: <20251029030913.20423-1-xuanzhuo@linux.alibaba.com>
X-Mailer: git-send-email 2.32.0.3.g01195cf9f
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Git-Hash: eb1fbe1c38ee
Content-Transfer-Encoding: 8bit

As discussed in http://lore.kernel.org/all/20250919013450.111424-1-xuanzhuo@linux.alibaba.com
Commit #1 Move the flags into the existing if condition; the issue is that it introduces a
small amount of code duplication.

Commit #3 is new to fix the hdr len in tunnel gso feature.


Thanks.

v4:
   1. add commit "virtio-net: Ensure hdr_len is not set unless the header is forwarded to the device." @Jason

v3:
   1. recode the #3 for tunnel gso, and test it



Xuan Zhuo (4):
  virtio-net: fix incorrect flags recording in big mode
  virtio-net: Ensure hdr_len is not set unless the header is forwarded
    to the device.
  virtio-net: correct hdr_len handling for VIRTIO_NET_F_GUEST_HDRLEN
  virtio-net: correct hdr_len handling for tunnel gso

 drivers/net/virtio_net.c   | 16 +++++++++----
 include/linux/virtio_net.h | 48 ++++++++++++++++++++++++++++++--------
 2 files changed, 49 insertions(+), 15 deletions(-)

--
2.32.0.3.g01195cf9f

