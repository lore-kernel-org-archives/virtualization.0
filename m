Received: from out30-98.freemail.mail.aliyun.com (out30-98.freemail.mail.aliyun.com [115.124.30.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5387520D4FC
	for <virtualization@lists.linux.dev>; Sat, 11 Oct 2025 09:41:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.98
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760175678; cv=none; b=KVPi/o2HkXhYTA7H3TmhS+QTPQ/YDVw10HGPNELlSs0A67w8UsZMqAGYLJ0Fuig/n4eYKW6kaaP7de+svoFl7uYfx5593Y9HMpMCOvyobYJU92KtpBbjQ0eCMTmK0mBYpOz+Vo4G6sJNK7faXx5mm8iFSIZpAIjWgguQmFw9YKw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760175678; c=relaxed/simple;
	bh=JQeci8kKFhUqNqSiKukDhGQ1oMGj2u2fkEVG4LJqWeE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=sspAt4M0yvSdOpsSoyHUEFomN5MekmXIWE1Xg84CkT4DmK4IXODol/nVU+Mizl5Rp8APFuhYeFpVR0p4NHNUJyIL2zpAAHUyAapXK645KJ4ucUlhBpY1iYKrRghBYjgtAep6kzlvg8cDhUk58gLkAgi5VQzPJcurr/3/x4gygVg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=ZW/xMt97; arc=none smtp.client-ip=115.124.30.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="ZW/xMt97"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1760175669; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=0KMzj+miCiTqLWcLN1eA5YLqErPlKnWHSP2dVaYTGYY=;
	b=ZW/xMt97fUam1Z2al6f8zsJKWsEeUVAkzvkiXK3gs8WDNQeLO2b0/KY8igMUfeHFQ/p+SRyvLvfhHLs9wjQw+/jUEmwemFsL80sOCW8eQho7OBPYtbh56nSJBUnPReeTi0IYNfg+a+ni73GilpvFTWN5vObP+wGMs+0a6TkPJiE=
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com fp:SMTPD_---0Wpw8kFU_1760175667 cluster:ay36)
          by smtp.aliyun-inc.com;
          Sat, 11 Oct 2025 17:41:08 +0800
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
Subject: [PATCH net v1 0/3] fixes two virtio-net related bugs.
Date: Sat, 11 Oct 2025 17:41:04 +0800
Message-Id: <20251011094107.16439-1-xuanzhuo@linux.alibaba.com>
X-Mailer: git-send-email 2.32.0.3.g01195cf9f
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Git-Hash: 94b35d9b48af
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

