Received: from out30-110.freemail.mail.aliyun.com (out30-110.freemail.mail.aliyun.com [115.124.30.110])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B9014C3D0
	for <virtualization@lists.linux.dev>; Mon, 14 Oct 2024 03:12:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.110
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728875567; cv=none; b=Car6mKuIakda9J5PirNesj+AaxW/9yvecRkragykbtOH8Gt8Pi6ftqUlLmS1KrKEyG2JkU0MA68UEFSjt39hj1whPXuDx3pDrsglNaDFsh+iEz3mjTMMukT26oI4kMYWrEsZ/g37RezUnRusnyNgflBxt4Gp1q5SaZvoax9r2h8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728875567; c=relaxed/simple;
	bh=9Yrh2Vjow15ezj1gKMnRRLy5ct9UaH0gpmCz2JfuK+8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=fNDFPmJd8eFb0Xp6RaPPtoAS2KY3YSZLYR+q1xaeJAxXxZIQwAYpVDYueCEVZVhw9ZfNztZllm3Gvyjo6cB0+amJDRzwupzOqx77euOJrJBgLV1Mi7jd8AjoQeau/bDLAR09gwws0i9NOMAdgM6iwjNax7+9IoazipyhdiNrlhc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=X3YEoiZW; arc=none smtp.client-ip=115.124.30.110
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="X3YEoiZW"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1728875556; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=gaop84a8mzYbIuzv4fvPhmp2O3iiUfbkV9o+jY53Xcc=;
	b=X3YEoiZWw/Icm2u/VrDb+hUDhEmOthFTMHrjyU/xj33lKXZMTLP7l4aHZAgcknHahg17xYvFz4oFqtS0Jjv3SSkyaSF36FcIRhOqsJpLVj4BeS2S1lq0L6mD2NGWEXJJhvJbSZe1h3TaHfo63psftF9qC98V8GhKfFav70kEsoI=
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com fp:SMTPD_---0WH.FFkV_1728875554 cluster:ay36)
          by smtp.aliyun-inc.com;
          Mon, 14 Oct 2024 11:12:34 +0800
From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
To: netdev@vger.kernel.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	=?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	virtualization@lists.linux.dev
Subject: [PATCH 0/5] virtio_net: enable premapped mode by default
Date: Mon, 14 Oct 2024 11:12:29 +0800
Message-Id: <20241014031234.7659-1-xuanzhuo@linux.alibaba.com>
X-Mailer: git-send-email 2.32.0.3.g01195cf9f
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Git-Hash: bba499faae26
Content-Transfer-Encoding: 8bit

In the last linux version, we disabled this feature to fix the
regress[1].

The patch set is try to fix the problem and re-enable it.

More info: http://lore.kernel.org/all/20240820071913.68004-1-xuanzhuo@linux.alibaba.com

Thanks.

[1]: http://lore.kernel.org/all/8b20cc28-45a9-4643-8e87-ba164a540c0a@oracle.com

Xuan Zhuo (5):
  virtio-net: fix overflow inside virtnet_rq_alloc
  virtio_net: introduce vi->mode
  virtio_net: big mode skip the unmap check
  virtio_net: enable premapped mode for merge and small by default
  virtio_net: rx remove premapped failover code

 drivers/net/virtio_net.c | 168 ++++++++++++++++++++++++---------------
 1 file changed, 105 insertions(+), 63 deletions(-)

--
2.32.0.3.g01195cf9f

