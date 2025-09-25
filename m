Received: from out30-131.freemail.mail.aliyun.com (out30-131.freemail.mail.aliyun.com [115.124.30.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01D3A20298D
	for <virtualization@lists.linux.dev>; Thu, 25 Sep 2025 02:25:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758767148; cv=none; b=pobOwnvsbcKSPh/xt+/V6J8i3tQle511KWZHDBu0eiDAJNw3wq4kyFDvvnU28cfUDzCdutjF5NArleEsdAK3/Th3Zh3bOYWswlT5FNONqy1dPnC1vVDKUCITbt7ern9YhqSRTpy6hpRXYKiLM2cg0EtsPKxAsKok2PIOkywMSsA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758767148; c=relaxed/simple;
	bh=oRDuhn7Y658oIujEOtFvXZcJwIQ0U9KoG6tl4a70K2o=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=aPKXOaAn0Ciw9mAJTwjEvjOlrCv1rc+lMHXy0ySVMQj4yUsMtRqv5BigiL8Rn23lDNTMgvss4eRD0sO1UMZ2pVDddA8qBjzcXh99WG9M43iDBopZ/XW6Mc/b5ruQmOu8B+LYByUsl4+7JyTp/yD56qvypwHRyVumR+dc3PlLEhk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=un2QhBbi; arc=none smtp.client-ip=115.124.30.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="un2QhBbi"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1758767138; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=YQzqMdtynwLdblPLgkLi43biFCY7AG/K30UPXO5sBN0=;
	b=un2QhBbir1R6xTyrf8QNAoxPiPgrM3lO18rxlUco6zgUcU1/5tDz8IE01g37fcyArtXWvimV4MeT4NVejkS4JrdJIeNsdZycPmBljE/6y5gzgqYprnij3GRYWAey5XItn98mfOiyxxVnfKPN6HFggcDC9h+LyVqLiFPVCt91jws=
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com fp:SMTPD_---0WolqhAj_1758767137 cluster:ay36)
          by smtp.aliyun-inc.com;
          Thu, 25 Sep 2025 10:25:37 +0800
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
Subject: [PATCH net 0/2] fixes two virtio-net related bugs.
Date: Thu, 25 Sep 2025 10:25:35 +0800
Message-Id: <20250925022537.91774-1-xuanzhuo@linux.alibaba.com>
X-Mailer: git-send-email 2.32.0.3.g01195cf9f
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Git-Hash: 833f31d30d57
Content-Transfer-Encoding: 8bit

As discussed in http://lore.kernel.org/all/20250919013450.111424-1-xuanzhuo@linux.alibaba.com
Commit #1 Move the flags into the existing if condition; the issue is that it introduces a
small amount of code duplication.

Commit #2 is new.

Xuan Zhuo (2):
  virtio-net: fix incorrect flags recording in big mode
  virtio-net: correct hdr_len handling for VIRTIO_NET_F_GUEST_HDRLEN

 drivers/net/virtio_net.c   | 16 +++++++++++-----
 include/linux/virtio_net.h | 19 ++++++++++++-------
 2 files changed, 23 insertions(+), 12 deletions(-)

--
2.32.0.3.g01195cf9f

