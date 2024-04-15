Received: from out30-130.freemail.mail.aliyun.com (out30-130.freemail.mail.aliyun.com [115.124.30.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B064208B0
	for <virtualization@lists.linux.dev>; Mon, 15 Apr 2024 13:38:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713188295; cv=none; b=Umx38PO35C8RDcrXF7JpkxPQJpqKHcEAHF2arTh6E1VOAbIRVKNjN8lBI+Xr6aRAy7DMAJROIRgJYr07Wu2pXzf3KdW7RNJDOW0fa7rbho87akNPKCL7FYD4RZm7iOCJKxnkecHdMRxtsOKZb3H3z9BY/9m7K/ovfaBBvbGhvPI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713188295; c=relaxed/simple;
	bh=3gXGNebqefPXgWmEmxws2q/k17H8yCR4bsq8QfYr9qU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=mEi8k+MEVOIT8VXNXiTqHcD0j7Pgm4dL6SRwHwLIeW+9IBWwUs/pB9yz2oRfm09fTy2oJAC6VTvLVU6H9wULs1R/aukAGxnwWPA+qCnHeGc8OaMcZBQLFktbv3Ea1Z6lDBQBHl5rWo1aB+xcPCEIioOxoOpM3W0chMCRlfSIPms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=XslyrigI; arc=none smtp.client-ip=115.124.30.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="XslyrigI"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1713188290; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=IJn5JoNDxwJSLayGMmgWWRisRt/GqGsocEhi4oOUZas=;
	b=XslyrigI0x9HqHrduE7gETAgRIYefvtbzSflHltGxGph8V7dTswVGSR00HUAiYCRPsVEDJGePf7XKipT5oJt3908PHDjQXhx+feGmHvy8LoIC1oG6mO+cucvU/7tBPa40BaKigQIhwpCLQjb647LbvjjmTDt57myv936v8FBcYs=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R111e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046056;MF=hengqi@linux.alibaba.com;NM=1;PH=DS;RN=12;SR=0;TI=SMTPD_---0W4diK4P_1713188288;
Received: from localhost(mailfrom:hengqi@linux.alibaba.com fp:SMTPD_---0W4diK4P_1713188288)
          by smtp.aliyun-inc.com;
          Mon, 15 Apr 2024 21:38:09 +0800
From: Heng Qi <hengqi@linux.alibaba.com>
To: netdev@vger.kernel.org,
	virtualization@lists.linux.dev
Cc: Jakub Kicinski <kuba@kernel.org>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	"Michael S . Tsirkin" <mst@redhat.com>,
	Brett Creeley <bcreeley@amd.com>,
	Ratheesh Kannoth <rkannoth@marvell.com>,
	Alexander Lobakin <aleksander.lobakin@intel.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Subject: [PATCH RESEND net-next v7 1/4] linux/dim: move useful macros to .h file
Date: Mon, 15 Apr 2024 21:38:04 +0800
Message-Id: <20240415133807.116394-2-hengqi@linux.alibaba.com>
X-Mailer: git-send-email 2.32.0.3.g01195cf9f
In-Reply-To: <20240415133807.116394-1-hengqi@linux.alibaba.com>
References: <20240415133807.116394-1-hengqi@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

These will be used in subsequent patches, including
newly declared profile arrays.

Signed-off-by: Heng Qi <hengqi@linux.alibaba.com>
---
 include/linux/dim.h | 13 +++++++++++++
 lib/dim/net_dim.c   | 10 ++--------
 2 files changed, 15 insertions(+), 8 deletions(-)

diff --git a/include/linux/dim.h b/include/linux/dim.h
index f343bc9aa2ec..8149d2d6589c 100644
--- a/include/linux/dim.h
+++ b/include/linux/dim.h
@@ -10,6 +10,13 @@
 #include <linux/types.h>
 #include <linux/workqueue.h>
 
+/* Number of DIM profiles and period mode. */
+#define NET_DIM_PARAMS_NUM_PROFILES 5
+#define NET_DIM_DEFAULT_RX_CQ_PKTS_FROM_EQE 256
+#define NET_DIM_DEFAULT_TX_CQ_PKTS_FROM_EQE 128
+#define NET_DIM_DEF_PROFILE_CQE 1
+#define NET_DIM_DEF_PROFILE_EQE 1
+
 /*
  * Number of events between DIM iterations.
  * Causes a moderation of the algorithm run.
@@ -127,6 +134,12 @@ enum dim_cq_period_mode {
 	DIM_CQ_PERIOD_NUM_MODES
 };
 
+extern const struct dim_cq_moder
+rx_profile[DIM_CQ_PERIOD_NUM_MODES][NET_DIM_PARAMS_NUM_PROFILES];
+
+extern const struct dim_cq_moder
+tx_profile[DIM_CQ_PERIOD_NUM_MODES][NET_DIM_PARAMS_NUM_PROFILES];
+
 /**
  * enum dim_state - DIM algorithm states
  *
diff --git a/lib/dim/net_dim.c b/lib/dim/net_dim.c
index 4e32f7aaac86..a649d9069c06 100644
--- a/lib/dim/net_dim.c
+++ b/lib/dim/net_dim.c
@@ -11,12 +11,6 @@
  *        There are different set of profiles for RX/TX CQs.
  *        Each profile size must be of NET_DIM_PARAMS_NUM_PROFILES
  */
-#define NET_DIM_PARAMS_NUM_PROFILES 5
-#define NET_DIM_DEFAULT_RX_CQ_PKTS_FROM_EQE 256
-#define NET_DIM_DEFAULT_TX_CQ_PKTS_FROM_EQE 128
-#define NET_DIM_DEF_PROFILE_CQE 1
-#define NET_DIM_DEF_PROFILE_EQE 1
-
 #define NET_DIM_RX_EQE_PROFILES { \
 	{.usec = 1,   .pkts = NET_DIM_DEFAULT_RX_CQ_PKTS_FROM_EQE,}, \
 	{.usec = 8,   .pkts = NET_DIM_DEFAULT_RX_CQ_PKTS_FROM_EQE,}, \
@@ -49,13 +43,13 @@
 	{.usec = 64, .pkts = 32,}   \
 }
 
-static const struct dim_cq_moder
+const struct dim_cq_moder
 rx_profile[DIM_CQ_PERIOD_NUM_MODES][NET_DIM_PARAMS_NUM_PROFILES] = {
 	NET_DIM_RX_EQE_PROFILES,
 	NET_DIM_RX_CQE_PROFILES,
 };
 
-static const struct dim_cq_moder
+const struct dim_cq_moder
 tx_profile[DIM_CQ_PERIOD_NUM_MODES][NET_DIM_PARAMS_NUM_PROFILES] = {
 	NET_DIM_TX_EQE_PROFILES,
 	NET_DIM_TX_CQE_PROFILES,
-- 
2.32.0.3.g01195cf9f

