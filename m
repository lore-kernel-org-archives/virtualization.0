Received: from out30-130.freemail.mail.aliyun.com (out30-130.freemail.mail.aliyun.com [115.124.30.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B9E1187FF8
	for <virtualization@lists.linux.dev>; Thu,  1 Aug 2024 12:27:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722515270; cv=none; b=F0oBixHkoi9mpXOb8TnqaDCxaiKE0hxgL1mrPd/ZQCTTtMJ+GaS6UVaUt6PxhLe9OehUafVdPSx1RFyz//oFFNIj90VeycFQyq/T7v4wYiDStv4JHsteHKNQY91Pc0Tg7E1nl049K/z96oZ3bgSzzh7nJJAPRaIZ5TeSMx766Sg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722515270; c=relaxed/simple;
	bh=SxDemmGaN3st80uf3+JBuqcgoUpXJWdaS/PqrX0QwrQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=at5CCHR86MJuiwkGYKPsrvNZPY1y2GLXLk3yEe4Y3UtppPvGtVjXrwbJeDKrlwh1Gnb92i4RRVrk+RBIkjQSYwdq+xYKZWiJyob2ZFeN+qqhbKYqfp87wJwpcaEQ3qiqi96BowV5KcCEUgMadt0OWP5oam8zTBLPGBV2GWhrEyQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=sGorMisd; arc=none smtp.client-ip=115.124.30.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="sGorMisd"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1722515260; h=From:To:Subject:Date:Message-Id:MIME-Version:Content-Type;
	bh=7hyKvqh5Dm/qJywKT8SxFRy4+uoyGMo/T8N8S928GPo=;
	b=sGorMisdvavJv810/svpY5uBc3LLKdndeuoLPsqluPkWYJxuREnqicjZV2Nezcb3B0qNpvYPzRBFHXocX5G8qfgqzWLAZ8WX7hw3XWaKxAoabr58TWfX38LLHg8itSDF48/SoDgZOrudaxnDPUIFs5KiPSD+DJ3ViaJ6KZSv5Hs=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R361e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037067109;MF=hengqi@linux.alibaba.com;NM=1;PH=DS;RN=10;SR=0;TI=SMTPD_---0WBtjk1e_1722515259;
Received: from localhost(mailfrom:hengqi@linux.alibaba.com fp:SMTPD_---0WBtjk1e_1722515259)
          by smtp.aliyun-inc.com;
          Thu, 01 Aug 2024 20:27:40 +0800
From: Heng Qi <hengqi@linux.alibaba.com>
To: netdev@vger.kernel.org,
	Jason Wang <jasowang@redhat.com>,
	"Michael S. Tsirkin" <mst@redhat.com>
Cc: virtualization@lists.linux.dev,
	Paolo Abeni <pabeni@redhat.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	"David S. Miller" <davem@davemloft.net>,
	=?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Subject: [PATCH net v3 0/2] virtio-net: unbreak vq resizing if vq coalescing is not supported
Date: Thu,  1 Aug 2024 20:27:37 +0800
Message-Id: <20240801122739.49008-1-hengqi@linux.alibaba.com>
X-Mailer: git-send-email 2.32.0.3.g01195cf9f
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Currently, if the driver does not negotiate the vq coalescing feature
but supports vq resize, the vq resize action, which could have been
successfully executed, is interrupted due to the failure in configuring
the vq coalescing parameters. This issue needs to be fixed.

Changelog
=========
v2->v3:
  - Break out the feature check and the fix into separate patches.

v1->v2:
  - Rephrase the subject.
  - Put the feature check inside the virtnet_send_{r,t}x_ctrl_coal_vq_cmd.

Heng Qi (2):
  virtio-net: check feature before configuring the vq coalescing command
  virtio-net: unbreak vq resizing when coalescing is not negotiated

 drivers/net/virtio_net.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

-- 
2.32.0.3.g01195cf9f

