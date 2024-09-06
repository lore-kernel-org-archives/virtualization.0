Received: from out30-100.freemail.mail.aliyun.com (out30-100.freemail.mail.aliyun.com [115.124.30.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A014F266AB
	for <virtualization@lists.linux.dev>; Fri,  6 Sep 2024 12:31:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725625904; cv=none; b=YdedDTS10hd0/EtSER5EYLaZ4mFIJgcPuObAM3Assjo9JLBZd8Ga0MkaPGu2WPDULvhm7vuz5N3DqAoyDDns/SHUVN4RAY6kxAxSSFjD6fy0Dx8gpSQN0l604hoL61jx3PerZgj7hc95qEnpuX++Qa954JJiSrCsh8GZPxUWoi4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725625904; c=relaxed/simple;
	bh=FWFSewh1d/KHfNw81JqqBTxAG8A9BX3IRoIrq0QfBnc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=uCPy05DsCzj7RalORNzRId9m10tG+twNL+mdfwm1tjTdgmiITXaiAK4SlY0k+S9Otkzgal9LjEGA5HBZJyen4O4dKFEq08Ap1hFEG+chGwSiRu14NghoKs/4MeT57AO0WWR/Z4t63kY5MC53FH0qCVLMUGmYbnj9dqfe54eopjs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=iBtb452A; arc=none smtp.client-ip=115.124.30.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="iBtb452A"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1725625899; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=V7Xi84uKBuBdD+mPN+ES0YH/6Sdrpj2J3QNAmdHmkpQ=;
	b=iBtb452Ae1a+A/epp6biLdrx6Jatcnrv1LNTDhEIyJ/dYbv2O14ewSSJlAOpcYkWaHcnRk0W8fxsODee+kLJjyje51nLsnt6V4YbuLrBWKp5nyXEf+D56Ke1fwZ1g6LWJNnSM+SdMayVBmYdjfs9P42WNlIaQD4axMYplaOjig8=
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com fp:SMTPD_---0WEPWJ4v_1725625897)
          by smtp.aliyun-inc.com;
          Fri, 06 Sep 2024 20:31:38 +0800
From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
To: virtualization@lists.linux.dev
Cc: "Michael S. Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	=?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org,
	Darren Kenny <darren.kenny@oracle.com>,
	"Si-Wei Liu" <si-wei.liu@oracle.com>
Subject: [PATCH 0/3] Revert "virtio_net: rx enable premapped mode by default"
Date: Fri,  6 Sep 2024 20:31:34 +0800
Message-Id: <20240906123137.108741-1-xuanzhuo@linux.alibaba.com>
X-Mailer: git-send-email 2.32.0.3.g01195cf9f
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Git-Hash: ccfd5e625b8b
Content-Transfer-Encoding: 8bit

Regression: http://lore.kernel.org/all/8b20cc28-45a9-4643-8e87-ba164a540c0a@oracle.com

I still think that the patch can fix the problem, I hope Darren can re-test it
or give me more info.

    http://lore.kernel.org/all/20240820071913.68004-1-xuanzhuo@linux.alibaba.com

If that can not work or Darren can not reply in time, Michael you can try this
patch set.

Thanks.

Xuan Zhuo (3):
  Revert "virtio_net: rx remove premapped failover code"
  Revert "virtio_net: big mode skip the unmap check"
  virtio_net: disable premapped mode by default

 drivers/net/virtio_net.c | 95 +++++++++++++++++++---------------------
 1 file changed, 46 insertions(+), 49 deletions(-)

--
2.32.0.3.g01195cf9f

