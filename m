Received: from out30-97.freemail.mail.aliyun.com (out30-97.freemail.mail.aliyun.com [115.124.30.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0DB323BE
	for <virtualization@lists.linux.dev>; Sat,  4 May 2024 06:44:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.97
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714805099; cv=none; b=VX1fokMmNWrWA0LDy7q7JjWOh+v6w9I5D1viJrtbQoxn4ZwA5kCjG+QokOXs2KUGXF3Kl4R4ceDEl6OeMhZIf5SYG4/6JXYp6OmnEQD2iVHWctpU+655H0wCUDMA9hcmo3v+g79XtC4FYXQ0iv7GzPmcgP3GRtcX6TZF0vnUDE0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714805099; c=relaxed/simple;
	bh=ls/PIBwKI6TT1X75ac0C4Wm0YLYXqQKw3/ydK2nRGKE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=qmEOqOxiRcjB12GxbNTu6O0Cb385cdX4a1Tb1NO42IHprVHQq8sDedrGeqohLuVGnpfRZEpxEnI/cz8A0g7DY93oapOZ4Vbjx9uStw7BCwkGQY4nSODJR0c/ORPiDXiKbxu38lvue1Plf+tWKOxxiGJekgy2WVNNBd1rXKDFOYM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=PYpG7YLg; arc=none smtp.client-ip=115.124.30.97
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="PYpG7YLg"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1714805095; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=GJD19GuqeHHyAZSeKce08gSgzKiq2SrycBxSISnyviU=;
	b=PYpG7YLg+mvuCgsv6yYsNmqnQqDzwHAh7OZUeN9sd14SI5pZqd6oukK/hhxfeWEdvNghb6tiwPF5AvSYn1fhJL0T2exl+LW1cgRjkFN52AGA2YXMd51KmK6Lgj0mDF0mL6NdOFz6eEcIcT4IMyCX1wazwB9lw2oO2+/YH2nycQE=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R681e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037067110;MF=hengqi@linux.alibaba.com;NM=1;PH=DS;RN=24;SR=0;TI=SMTPD_---0W5luCme_1714805093;
Received: from localhost(mailfrom:hengqi@linux.alibaba.com fp:SMTPD_---0W5luCme_1714805093)
          by smtp.aliyun-inc.com;
          Sat, 04 May 2024 14:44:54 +0800
From: Heng Qi <hengqi@linux.alibaba.com>
To: netdev@vger.kernel.org,
	virtualization@lists.linux.dev
Cc: Jakub Kicinski <kuba@kernel.org>,
	"David S . Miller" <davem@davemloft.net>,
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
	justinstitt@google.com,
	Simon Horman <horms@kernel.org>
Subject: [PATCH net-next v12 3/4] dim: add new interfaces for initialization and getting results
Date: Sat,  4 May 2024 14:44:46 +0800
Message-Id: <20240504064447.129622-4-hengqi@linux.alibaba.com>
X-Mailer: git-send-email 2.32.0.3.g01195cf9f
In-Reply-To: <20240504064447.129622-1-hengqi@linux.alibaba.com>
References: <20240504064447.129622-1-hengqi@linux.alibaba.com>
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
 include/linux/dim.h | 48 ++++++++++++++++++++++++++++++++
 lib/dim/net_dim.c   | 68 +++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 116 insertions(+)

diff --git a/include/linux/dim.h b/include/linux/dim.h
index d848b790ca50..5cf0987a79f7 100644
--- a/include/linux/dim.h
+++ b/include/linux/dim.h
@@ -257,6 +257,54 @@ int net_dim_init_irq_moder(struct net_device *dev, u8 profile_flags,
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
index b3e01619f929..60944f31a886 100644
--- a/lib/dim/net_dim.c
+++ b/lib/dim/net_dim.c
@@ -166,6 +166,74 @@ void net_dim_free_irq_moder(struct net_device *dev)
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
+		dim->mode = READ_ONCE(irq_moder->dim_tx_mode);
+		return;
+	}
+
+	INIT_WORK(&dim->work, irq_moder->rx_dim_work);
+	dim->mode = READ_ONCE(irq_moder->dim_rx_mode);
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
+	res.cq_period_mode = dim->mode;
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
+	res.cq_period_mode = dim->mode;
+
+	return res;
+}
+EXPORT_SYMBOL(net_dim_get_tx_irq_moder);
+
+void net_dim_set_rx_mode(struct net_device *dev, u8 rx_mode)
+{
+	WRITE_ONCE(dev->irq_moder->dim_rx_mode, rx_mode);
+}
+EXPORT_SYMBOL(net_dim_set_rx_mode);
+
+void net_dim_set_tx_mode(struct net_device *dev, u8 tx_mode)
+{
+	WRITE_ONCE(dev->irq_moder->dim_tx_mode, tx_mode);
+}
+EXPORT_SYMBOL(net_dim_set_tx_mode);
+
 static int net_dim_step(struct dim *dim)
 {
 	if (dim->tired == (NET_DIM_PARAMS_NUM_PROFILES * 2))
-- 
2.32.0.3.g01195cf9f

