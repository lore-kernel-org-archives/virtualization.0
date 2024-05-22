Received: from out30-130.freemail.mail.aliyun.com (out30-130.freemail.mail.aliyun.com [115.124.30.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC5ED763EE
	for <virtualization@lists.linux.dev>; Wed, 22 May 2024 03:45:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716349560; cv=none; b=sNugGcM3BnbwPOnAO+9cAMdSJ5PUb/c7n8J9GFoYH+VCBJeiDpvLTgMCzNct5nBXV9aKoTeB9jPJ8iKpsMJbFXaFczRSpRM9oh5pkIAxN/JK9xoL7QJ9OaSSVai6s68mqU+r+98h+5vNBJIcGTMjOdWpZUJigckhQKrl/VmpC+o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716349560; c=relaxed/simple;
	bh=fj28zLV0cyC3gCv41/tt+bGVfoW1qBQetpQHpDRptU0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=FPlAYMgP6g5OQveL9Ao/zGnKE0X9GNMWjNCAL2V/3nCOf1OttE0jy3s11CeccgeFY2CKNQSFkfk0dVmrAchOviJE2JT0wl6yju+FA1pQBdq+O2SV671kdVKuNzDk5I/bue8kcaaF0/1Qce4aOLkULWmiuD2CemSew7M9SjP136Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=GKLZlk+a; arc=none smtp.client-ip=115.124.30.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="GKLZlk+a"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1716349551; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=AMGX0af6ZOTVD+jIX9wGqw68iZttX4BJbQ9DJvsjByQ=;
	b=GKLZlk+aTGO8S25rrbkJj63NsdJ6EbT0annKL2ukBWsmJ4L+fdqHIuClo46/MNPI6t4FMQujhrsrbEpcGFCIriDEvDrOSj+piF4Oq64M85K4GfAjuqJ1NnqZjWB/dpYK9yiEMeJq4skf1MoRr0OQ2roCK9cl8mcQrDd+pP+0dTU=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R101e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033045075189;MF=hengqi@linux.alibaba.com;NM=1;PH=DS;RN=9;SR=0;TI=SMTPD_---0W6zl.xR_1716349549;
Received: from localhost(mailfrom:hengqi@linux.alibaba.com fp:SMTPD_---0W6zl.xR_1716349549)
          by smtp.aliyun-inc.com;
          Wed, 22 May 2024 11:45:50 +0800
From: Heng Qi <hengqi@linux.alibaba.com>
To: netdev@vger.kernel.org,
	virtualization@lists.linux.dev
Cc: Jason Wang <jasowang@redhat.com>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Subject: [PATCH net 0/2] virtio_net: fix lock warning and unrecoverable state
Date: Wed, 22 May 2024 11:45:46 +0800
Message-Id: <20240522034548.58131-1-hengqi@linux.alibaba.com>
X-Mailer: git-send-email 2.32.0.3.g01195cf9f
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Patch 1 describes and fixes an issue where dim cannot return to
normal state in certain scenarios.

Patch 2 attempts to resolve lockdep's complaints that holding many
nested locks and when there is a maximum number of queues may also
be problematic, so try to remove the dim_lock.

Heng Qi (2):
  virtio_net: fix possible dim status unrecoverable
  Revert "virtio_net: Add a lock for per queue RX coalesce"

 drivers/net/virtio_net.c | 55 ++++++++++------------------------------
 1 file changed, 13 insertions(+), 42 deletions(-)

-- 
2.32.0.3.g01195cf9f

