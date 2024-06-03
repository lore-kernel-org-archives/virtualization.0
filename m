Received: from out30-98.freemail.mail.aliyun.com (out30-98.freemail.mail.aliyun.com [115.124.30.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 761D9131BDD
	for <virtualization@lists.linux.dev>; Mon,  3 Jun 2024 15:47:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.98
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717429662; cv=none; b=Y6KicwSAbvkyqZsfEm/+kN57IGfZDpb6FpNuOG7hdNWfzec76A5ckcVEdlgxJ+9vdis7O1dwUjTcuMlAu0qTt7vg4M3vsG4bQwzi9l+NBJdgxLA3Syn4xqX0jPQ6eN499nhrjBdqBUj3IthnhOWgvB+nlwTrEPeGWXFUqXGYx5M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717429662; c=relaxed/simple;
	bh=V2q9wNhoGtcyAXiR+9ihkLI1oCVtTX6AlUqTypmDM7g=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=rCUx9kzJaTpcjo0jzYoCniu8zdjpaixyRiDITG1YcTq0GyXavyQaCsUE3TzGzFhyqcta0OS5RwAQSRDPAv4EVfn7brcZ4ouu0MXg0Yg0XF2FyE+v2KhDh8I2zN272o1L7tDtrCWPB+5I2eNcVF2MDmeulmLErLQkPkK2JiRWsvA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=ZdWMvLmd; arc=none smtp.client-ip=115.124.30.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="ZdWMvLmd"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1717429652; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=MPfdTFk0JzUdgoO7Gp95wxkRiKUup9y05x3o9Fsda+E=;
	b=ZdWMvLmdO076Rrs02KKmtsoxKj5/7D2dc7kv9wxnnfLi6obYcwRPNz+3XvBb/Ksik0GgylNgUdND7HPUnEonzZ7p2w0vwMtIqxTeoUTtfYsD1WsL3WNuzlIqFcbVd7u5SgNYme2ZvaSf/AAXR2p/DHiyA9M9UXwlmcaUisCWPQo=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R121e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037067111;MF=hengqi@linux.alibaba.com;NM=1;PH=DS;RN=31;SR=0;TI=SMTPD_---0W7oH02s_1717429650;
Received: from localhost(mailfrom:hengqi@linux.alibaba.com fp:SMTPD_---0W7oH02s_1717429650)
          by smtp.aliyun-inc.com;
          Mon, 03 Jun 2024 23:47:31 +0800
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
	donald.hunter@gmail.com,
	=?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Dragos Tatulea <dtatulea@nvidia.com>,
	Rahul Rameshbabu <rrameshbabu@nvidia.com>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	awel Dembicki <paweldembicki@gmail.com>
Subject: [PATCH net-next v14 2/5] dim: make DIMLIB dependent on NET
Date: Mon,  3 Jun 2024 23:47:24 +0800
Message-Id: <20240603154727.31998-3-hengqi@linux.alibaba.com>
X-Mailer: git-send-email 2.32.0.3.g01195cf9f
In-Reply-To: <20240603154727.31998-1-hengqi@linux.alibaba.com>
References: <20240603154727.31998-1-hengqi@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

DIMLIB's capabilities are supplied by the dim, net_dim, and
rdma_dim objects, and dim's interfaces solely act as a base for
net_dim and rdma_dim and are not explicitly used anywhere else.
rdma_dim is utilized by the infiniband driver, while net_dim
is for network devices, excluding the soc/fsl driver.

In this patch, net_dim relies on some NET's interfaces, thus
DIMLIB needs to explicitly depend on the NET Kconfig.

The soc/fsl driver uses the functions provided by net_dim, so
it also needs to depend on NET.

Signed-off-by: Heng Qi <hengqi@linux.alibaba.com>
---
 drivers/soc/fsl/Kconfig | 2 +-
 lib/Kconfig             | 1 +
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/soc/fsl/Kconfig b/drivers/soc/fsl/Kconfig
index fcec6ed83d5e..a1e0bc8c1757 100644
--- a/drivers/soc/fsl/Kconfig
+++ b/drivers/soc/fsl/Kconfig
@@ -22,7 +22,7 @@ config FSL_GUTS
 
 config FSL_MC_DPIO
         tristate "QorIQ DPAA2 DPIO driver"
-        depends on FSL_MC_BUS
+        depends on FSL_MC_BUS && NET
         select SOC_BUS
         select FSL_GUTS
         select DIMLIB
diff --git a/lib/Kconfig b/lib/Kconfig
index d33a268bc256..0ffc4f69564f 100644
--- a/lib/Kconfig
+++ b/lib/Kconfig
@@ -629,6 +629,7 @@ config SIGNATURE
 
 config DIMLIB
 	tristate
+	depends on NET
 	help
 	  Dynamic Interrupt Moderation library.
 	  Implements an algorithm for dynamically changing CQ moderation values
-- 
2.32.0.3.g01195cf9f

