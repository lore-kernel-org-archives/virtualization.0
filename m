Received: from out30-112.freemail.mail.aliyun.com (out30-112.freemail.mail.aliyun.com [115.124.30.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDFCA19D88D
	for <virtualization@lists.linux.dev>; Wed,  5 Jun 2024 14:55:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.112
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717599344; cv=none; b=YBdG20HjoA4yWniTXz+DBpeHTkcYvdtDjLNrJ7QKlpktsIU4KCWmtPodPfBuqSEN66sT9t+IIclRG1Ryzq/vJ8w8NTjukr9wmfN4+lgNJquVa+eyxVRab7HbdzwoOMVmooGiIZ1u840FWuvblrMs6qJVP17N0X4jrM4GGrwfdqY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717599344; c=relaxed/simple;
	bh=yokiJV8p9dkMWxqbtWIOEv99O5LOULthUIzCQYKny84=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=t1zC5DQz8iXHRjvRBWgZNInx1ARi9ToVL4So96XzRnYuE64AJDAgSW57Uf5GVrmR/pmkChi0PMPnDqDOIv63YpxUo3EGYXka0WEBiOBe55Ncua/bDXoAzKh5GNEtX/371kKuYFf8lVWcgBcOXQm8lefXpKX7Z42NqaHXDuYtKCE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=qSr1FNow; arc=none smtp.client-ip=115.124.30.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="qSr1FNow"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1717599334; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=SfcsuPQSNJSnC3bKPAJUEDlWamBHyYsQMPKp4RigRnw=;
	b=qSr1FNow87UMoEkjIkdQkOqlC2rjxx6gDtsQLMF+g5m2t5wuFDVEx3u1IEO/p6yTPvgWKdqA376iMxJZ3KG+9oIyBL+Dc49AO2raZq4/USsLVRrKToz3aMYbs6eO5+xYzI0vwMjb2YxWLMCR7F1ts8mMfqtRuIy6hVdsXZpKqPg=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R191e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037067109;MF=hengqi@linux.alibaba.com;NM=1;PH=DS;RN=10;SR=0;TI=SMTPD_---0W7vW.U5_1717599333;
Received: from localhost(mailfrom:hengqi@linux.alibaba.com fp:SMTPD_---0W7vW.U5_1717599333)
          by smtp.aliyun-inc.com;
          Wed, 05 Jun 2024 22:55:34 +0800
From: Heng Qi <hengqi@linux.alibaba.com>
To: netdev@vger.kernel.org,
	virtualization@lists.linux.dev
Cc: Jason Wang <jasowang@redhat.com>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	=?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>,
	Eric Dumazet <edumazet@google.com>,
	"David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Subject: [PATCH net-next v2 0/2] virtio_net: enable the irq for ctrlq
Date: Wed,  5 Jun 2024 22:55:31 +0800
Message-Id: <20240605145533.86229-1-hengqi@linux.alibaba.com>
X-Mailer: git-send-email 2.32.0.3.g01195cf9f
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Ctrlq in polling mode may cause the virtual machine to hang and
occupy additional CPU resources. Enabling the irq for ctrlq
alleviates this problem and allows commands to be requested
concurrently.

Changelog
=========
v1->v2:
  - Refactor the patch 1 and rephase the commit log.

Heng Qi (2):
  virtio_net: enable irq for the control vq
  virtio_net: improve dim command request efficiency

 drivers/net/virtio_net.c | 277 ++++++++++++++++++++++++++++++++++-----
 1 file changed, 247 insertions(+), 30 deletions(-)

-- 
2.32.0.3.g01195cf9f

