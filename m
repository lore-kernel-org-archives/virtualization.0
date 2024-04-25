Received: from out30-118.freemail.mail.aliyun.com (out30-118.freemail.mail.aliyun.com [115.124.30.118])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E85F131746
	for <virtualization@lists.linux.dev>; Thu, 25 Apr 2024 16:59:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.118
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714064400; cv=none; b=TxEoc2enO2CIankQQZ5EwZrzzaGDzUw9Q1QEs08ZQHv6dC51FZddU4O4Uyzn8ugiYoeOJXGCcILZDMYO0gAJg+k5/WJ71kHf2jo6dhd+2KF2xQvaBNFSaHX+Fh6Njd1dA0RkxbI+8JOSyVnilK8yHNpxq6FLtS11hlyr3kHVnYE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714064400; c=relaxed/simple;
	bh=V0Rn+vn4+XpCdkvdQ5dnRUb3mzRVI6w+fsOAma3iMB4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ixc/m1KsYT6hAcZ+jlrLoDtUkRtZvE6kYXED6o3vXjPiBeQwuMd3lHufPEKbR9IQlpoN17FcPJ5qsUmb7xvJZXNLeyy18Vsg8Vq542JSj8DDKdGN2SasZloHSaf8nRmLmQ5SQ87PxuoUINQ0WlhziaBU/9evfudMoxjJ0SgZO/U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=RPHCNAuD; arc=none smtp.client-ip=115.124.30.118
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="RPHCNAuD"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1714064396; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=Dv0DCX3typ0piH+DuILkNw5wIpyf/s2KWGP2NHru3hw=;
	b=RPHCNAuD3y6jPIs/5q7QqxlwNRkY0p5uo/+vKn94N7y1evB6p5UsTCPJ0/qxDVqlltNaYFc8pJWiTZ/6CugMJVjue3tYul0P1kHVuGgJsZMjwEYIMe/4raPO7aRtx5wpOFYrEZlbee7g4JfGWIKFbqPiYfnbcxYOBvZLk6kBLqU=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R111e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037067113;MF=hengqi@linux.alibaba.com;NM=1;PH=DS;RN=23;SR=0;TI=SMTPD_---0W5G1Lkt_1714064393;
Received: from localhost(mailfrom:hengqi@linux.alibaba.com fp:SMTPD_---0W5G1Lkt_1714064393)
          by smtp.aliyun-inc.com;
          Fri, 26 Apr 2024 00:59:55 +0800
From: Heng Qi <hengqi@linux.alibaba.com>
To: netdev@vger.kernel.org,
	virtualization@lists.linux.dev,
	Jakub Kicinski <kuba@kernel.org>
Cc: "David S . Miller" <davem@davemloft.net>,
	Paolo Abeni <pabeni@redhat.com>,
	Eric Dumazet <edumazet@google.com>,
	Jason Wang <jasowang@redhat.com>,
	"Michael S . Tsirkin" <mst@redhat.com>,
	Brett Creeley <bcreeley@amd.com>,
	Ratheesh Kannoth <rkannoth@marvell.com>,
	Alexander Lobakin <aleksander.lobakin@intel.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Tal Gilboa <talgi@nvidia.com>,
	Jonathan Corbet <corbet@lwn.net>,
	linux-doc@vger.kernel.org,
	Maxime Chevallier <maxime.chevallier@bootlin.com>,
	Jiri Pirko <jiri@resnulli.us>,
	Paul Greenwalt <paul.greenwalt@intel.com>,
	Ahmed Zaki <ahmed.zaki@intel.com>,
	Vladimir Oltean <vladimir.oltean@nxp.com>,
	Kory Maincent <kory.maincent@bootlin.com>,
	Andrew Lunn <andrew@lunn.ch>,
	"justinstitt @ google . com" <justinstitt@google.com>
Subject: [PATCH net-next v10 3/4] dim: add new interfaces for initialization and getting results
Date: Fri, 26 Apr 2024 00:59:47 +0800
Message-Id: <20240425165948.111269-4-hengqi@linux.alibaba.com>
X-Mailer: git-send-email 2.32.0.3.g01195cf9f
In-Reply-To: <20240425165948.111269-1-hengqi@linux.alibaba.com>
References: <20240425165948.111269-1-hengqi@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

DIM-related mode and work have been collected in one same place,
so new interfaces are added to provide convenience.

Signed-off-by: Heng Qi <hengqi@linux.alibaba.com>
---
 include/linux/dim.h | 48 +++++++++++++++++++++++++++++++++
 lib/dim/net_dim.c   | 66 +++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 114 insertions(+)

diff --git a/include/linux/dim.h b/include/linux/dim.h
index af01389fcf39..ea7551bbc599 100644
--- a/include/linux/dim.h
+++ b/include/linux/dim.h
@@ -258,6 +258,54 @@ int net_dim_init_irq_moder(struct net_device *dev, u8 profile_flags,
  */
 void net_dim_free_irq_moder(struct net_device *dev);
 
+/**
+ * net_dim_setting - initialize DIM's cq mode and schedule worker
+ * @dev: target network device
+ * @dim: DIM context
+ * @is_tx: true indicates the tx direction, false indicates the rx direction
+ */
+void net_dim_setting(struct net_device *dev, struct dim *dim, bool is_tx);
+
+/**
+ * net_dim_work_cancel - synchronously cancel dim's worker
+ * @dim: DIM context
+ */
+void net_dim_work_cancel(struct dim *dim);
+
+/**
+ * net_dim_get_rx_irq_moder - get DIM rx results based on profile_ix
+ * @dev: target network device
+ * @dim: DIM context
+ *
+ * Return: DIM irq moderation
+ */
+struct dim_cq_moder
+net_dim_get_rx_irq_moder(struct net_device *dev, struct dim *dim);
+
+/**
+ * net_dim_get_tx_irq_moder - get DIM tx results based on profile_ix
+ * @dev: target network device
+ * @dim: DIM context
+ *
+ * Return: DIM irq moderation
+ */
+struct dim_cq_moder
+net_dim_get_tx_irq_moder(struct net_device *dev, struct dim *dim);
+
+/**
+ * net_dim_set_rx_mode - set DIM rx cq mode
+ * @dev: target network device
+ * @rx_mode: target rx cq mode
+ */
+void net_dim_set_rx_mode(struct net_device *dev, u8 rx_mode);
+
+/**
+ * net_dim_set_tx_mode - set DIM tx cq mode
+ * @dev: target network device
+ * @tx_mode: target tx cq mode
+ */
+void net_dim_set_tx_mode(struct net_device *dev, u8 tx_mode);
+
 /**
  *	dim_on_top - check if current state is a good place to stop (top location)
  *	@dim: DIM context
diff --git a/lib/dim/net_dim.c b/lib/dim/net_dim.c
index ec0dc21793c0..8c4543a628e1 100644
--- a/lib/dim/net_dim.c
+++ b/lib/dim/net_dim.c
@@ -174,6 +174,72 @@ void net_dim_free_irq_moder(struct net_device *dev)
 }
 EXPORT_SYMBOL(net_dim_free_irq_moder);
 
+void net_dim_setting(struct net_device *dev, struct dim *dim, bool is_tx)
+{
+	struct dim_irq_moder *irq_moder = dev->irq_moder;
+
+	if (!irq_moder)
+		return;
+
+	if (is_tx) {
+		INIT_WORK(&dim->work, irq_moder->tx_dim_work);
+		dim->mode = irq_moder->dim_tx_mode;
+		return;
+	}
+
+	INIT_WORK(&dim->work, irq_moder->rx_dim_work);
+	dim->mode = irq_moder->dim_rx_mode;
+}
+EXPORT_SYMBOL(net_dim_setting);
+
+void net_dim_work_cancel(struct dim *dim)
+{
+	cancel_work_sync(&dim->work);
+}
+EXPORT_SYMBOL(net_dim_work_cancel);
+
+struct dim_cq_moder net_dim_get_rx_irq_moder(struct net_device *dev,
+					     struct dim *dim)
+{
+	struct dim_cq_moder res, *profile;
+
+	rcu_read_lock();
+	profile = rcu_dereference(dev->irq_moder->rx_profile);
+	res = profile[dim->profile_ix];
+	rcu_read_unlock();
+
+	dim->mode = READ_ONCE(dev->irq_moder->dim_rx_mode);
+
+	return res;
+}
+EXPORT_SYMBOL(net_dim_get_rx_irq_moder);
+
+struct dim_cq_moder net_dim_get_tx_irq_moder(struct net_device *dev,
+					     struct dim *dim)
+{
+	struct dim_cq_moder res, *profile;
+
+	rcu_read_lock();
+	profile = rcu_dereference(dev->irq_moder->tx_profile);
+	res = profile[dim->profile_ix];
+	rcu_read_unlock();
+
+	dim->mode = READ_ONCE(dev->irq_moder->dim_tx_mode);
+
+	return res;
+}
+EXPORT_SYMBOL(net_dim_get_tx_irq_moder);
+
+void net_dim_set_rx_mode(struct net_device *dev, u8 rx_mode)
+{
+	WRITE_ONCE(dev->irq_moder->dim_rx_mode, rx_mode);
+}
+
+void net_dim_set_tx_mode(struct net_device *dev, u8 tx_mode)
+{
+	WRITE_ONCE(dev->irq_moder->dim_tx_mode, tx_mode);
+}
+
 static int net_dim_step(struct dim *dim)
 {
 	if (dim->tired == (NET_DIM_PARAMS_NUM_PROFILES * 2))
-- 
2.32.0.3.g01195cf9f

