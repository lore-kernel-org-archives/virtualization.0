Received: from out30-111.freemail.mail.aliyun.com (out30-111.freemail.mail.aliyun.com [115.124.30.111])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AE4A2E7F1E
	for <virtualization@lists.linux.dev>; Fri, 24 Oct 2025 07:41:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.111
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761291696; cv=none; b=TfWMsAk4Rqc6Hc67oPoEItSIplfJuiqkjoc7VtbzcqglnNIFzGeHfBEmIeBXQdpuTmidwJqyi7TZ5NXZNBoviQ4nUXjawA1RT/648IdR0wv+wv1rVNQkH2vSQVSTh3DYYyM6oDNg8Sjq7+7BCyUsj1+b5FKqXIGHt3K6bbjNX10=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761291696; c=relaxed/simple;
	bh=zJJTIMGSOwxKfb2US6KEAP1oCsZIQ0qpCABmkMTLQYk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=bSj8Tg3nK60hCBZ2I9YXwrbu1z2aLF/l4TqjjNpRn8qfQsy8FsOxWxpccDYJywFUWM4vYg0i+69RLMaLOwFIhrBe2lENcOFjtYwkuu7b1UefVlcDtbM5VQEfsjePQwl5ylCnrUtvxHzC1h0Az/f9tJLKS5xJbehKUNH/rfjG0bc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=mhkaCvLe; arc=none smtp.client-ip=115.124.30.111
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="mhkaCvLe"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1761291691; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=P4t7EHVBxzPFlbSFx++Y2HgFlVp6dY0965Mu6URnaQA=;
	b=mhkaCvLeD7vKTtCCPN9t/PD2Hurhkn/g+r6pmE1XR9x/3aSuHyw8UcXvJr/4XO0Wnb/2P7nHbdMRfkxGmd3oupJl8XSUN4sMpiSrkkgWUpI9p5k53Yj9obb71pTaqgfvTwGKYqsVfZcjoKKv5c5FfQAiJDKWCX1b5lQNdK4WeoY=
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com fp:SMTPD_---0WqtaKOo_1761291690 cluster:ay36)
          by smtp.aliyun-inc.com;
          Fri, 24 Oct 2025 15:41:30 +0800
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
Subject: [PATCH net v3 0/3] fixes two virtio-net related bugs.
Date: Fri, 24 Oct 2025 15:41:27 +0800
Message-Id: <20251024074130.65580-1-xuanzhuo@linux.alibaba.com>
X-Mailer: git-send-email 2.32.0.3.g01195cf9f
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Git-Hash: deaf684dfaeb
Content-Transfer-Encoding: 8bit

As discussed in http://lore.kernel.org/all/20250919013450.111424-1-xuanzhuo@linux.alibaba.com
Commit #1 Move the flags into the existing if condition; the issue is that it introduces a
small amount of code duplication.

Commit #3 is new to fix the hdr len in tunnel gso feature.


Thanks.

v3:
   1. recode the #3 for tunnel gso, and test it


Xuan Zhuo (3):
  virtio-net: fix incorrect flags recording in big mode
  virtio-net: correct hdr_len handling for VIRTIO_NET_F_GUEST_HDRLEN
  virtio-net: correct hdr_len handling for tunnel gso

 drivers/net/virtio_net.c   | 16 +++++++++----
 include/linux/virtio_net.h | 47 ++++++++++++++++++++++++++++++--------
 2 files changed, 48 insertions(+), 15 deletions(-)

--
2.32.0.3.g01195cf9f

