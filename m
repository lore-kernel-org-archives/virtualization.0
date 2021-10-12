Return-Path: <SRS0=TY3O=PA=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7D4BC433FE
	for <virtualization@archiver.kernel.org>; Tue, 12 Oct 2021 10:27:10 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 65526610E5
	for <virtualization@archiver.kernel.org>; Tue, 12 Oct 2021 10:27:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 65526610E5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 42CCD60B74;
	Tue, 12 Oct 2021 10:27:10 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id nCCWUxRFg7vI; Tue, 12 Oct 2021 10:27:09 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id D035A60B6B;
	Tue, 12 Oct 2021 10:27:08 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id AB2D0C000F;
	Tue, 12 Oct 2021 10:27:08 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 4CCAFC000D
 for <virtualization@lists.linux-foundation.org>;
 Tue, 12 Oct 2021 10:27:08 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 2E8D760B6B
 for <virtualization@lists.linux-foundation.org>;
 Tue, 12 Oct 2021 10:27:08 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id hMils_RX8HHK
 for <virtualization@lists.linux-foundation.org>;
 Tue, 12 Oct 2021 10:27:07 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 876D160B47
 for <virtualization@lists.linux-foundation.org>;
 Tue, 12 Oct 2021 10:27:07 +0000 (UTC)
Received: by mail.kernel.org (Postfix) with ESMTPSA id 7BF5461050;
 Tue, 12 Oct 2021 10:27:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1634034427;
 bh=ZbYDsAr2Reh1HtFuRKBlffF3hTY/uwo1Huzzdo3YMiE=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=Qc0w9QhJRO1WcDvQPXJKzA8adZm8PCT+/fKTz5V8IQm8kZaCmqej/uYGHTni5iu/Y
 2a4CFTg9Yh4ghYGCSyEeEw9BPGBLhAe/saIk1S9sU4PikfLuJB2cAvrQ2JL29obKWW
 grSCz+KrnOhZSsC6yhUg70eztF3BIATteSUWJJHJaaFsXDcaqwNa0HPDpdIscKG1qj
 a9nvoqh8msFt4NYO1gEmu2TF2BhH3kSTf8iHdCETveVfssP6lMz6GN71QiIcsJ4775
 3/uU1HnFRhI8uohtGFXiBHL7v+8AT7ehgj15KOLtCa4941/4frLcWUiYhFBvuEVl0i
 ywURvljc+3frg==
From: Leon Romanovsky <leon@kernel.org>
To: Doug Ledford <dledford@redhat.com>,
	Jason Gunthorpe <jgg@nvidia.com>
Subject: [PATCH mlx5-next 6/7] RDMA/mlx5: Move struct mlx5_core_mkey to mlx5_ib
Date: Tue, 12 Oct 2021 13:26:34 +0300
Message-Id: <61e2704c9bb4669186274f08b41544092d96de8d.1634033957.git.leonro@nvidia.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1634033956.git.leonro@nvidia.com>
References: <cover.1634033956.git.leonro@nvidia.com>
MIME-Version: 1.0
Cc: Aharon Landau <aharonl@nvidia.com>, linux-rdma@vger.kernel.org,
 netdev@vger.kernel.org, "Michael S. Tsirkin" <mst@redhat.com>,
 linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org,
 Shay Drory <shayd@nvidia.com>, Jakub Kicinski <kuba@kernel.org>,
 Maor Gottlieb <maorg@nvidia.com>, Saeed Mahameed <saeedm@nvidia.com>
X-BeenThere: virtualization@lists.linux-foundation.org
X-Mailman-Version: 2.1.15
Precedence: list
List-Id: Linux virtualization <virtualization.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>, 
 <mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>, 
 <mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

From: Aharon Landau <aharonl@nvidia.com>

Move mlx5_core_mkey struct to mlx5_ib, as the mlx5_core doesn't use it
at this point.

Signed-off-by: Aharon Landau <aharonl@nvidia.com>
Reviewed-by: Shay Drory <shayd@nvidia.com>
Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
---
 drivers/infiniband/hw/mlx5/devx.c    |  2 +-
 drivers/infiniband/hw/mlx5/mlx5_ib.h | 25 +++++++++++++++++++------
 drivers/infiniband/hw/mlx5/mr.c      | 12 +++++-------
 drivers/infiniband/hw/mlx5/odp.c     |  8 ++++----
 include/linux/mlx5/driver.h          | 13 -------------
 5 files changed, 29 insertions(+), 31 deletions(-)

diff --git a/drivers/infiniband/hw/mlx5/devx.c b/drivers/infiniband/hw/mlx5/devx.c
index 465ea835f854..2778b10ffd48 100644
--- a/drivers/infiniband/hw/mlx5/devx.c
+++ b/drivers/infiniband/hw/mlx5/devx.c
@@ -1293,7 +1293,7 @@ static int devx_handle_mkey_indirect(struct devx_obj *obj,
 				     void *in, void *out)
 {
 	struct mlx5_ib_devx_mr *devx_mr = &obj->devx_mr;
-	struct mlx5_core_mkey *mkey;
+	struct mlx5_ib_mkey *mkey;
 	void *mkc;
 	u8 key;
 
diff --git a/drivers/infiniband/hw/mlx5/mlx5_ib.h b/drivers/infiniband/hw/mlx5/mlx5_ib.h
index cf8b0653f0ce..ef6087a9f93b 100644
--- a/drivers/infiniband/hw/mlx5/mlx5_ib.h
+++ b/drivers/infiniband/hw/mlx5/mlx5_ib.h
@@ -628,6 +628,19 @@ struct mlx5_user_mmap_entry {
 	u32 page_idx;
 };
 
+enum mlx5_mkey_type {
+	MLX5_MKEY_MR = 1,
+	MLX5_MKEY_MW,
+	MLX5_MKEY_INDIRECT_DEVX,
+};
+
+struct mlx5_ib_mkey {
+	u32			key;
+	enum mlx5_mkey_type	type;
+	struct wait_queue_head wait;
+	refcount_t usecount;
+};
+
 #define MLX5_IB_MTT_PRESENT (MLX5_IB_MTT_READ | MLX5_IB_MTT_WRITE)
 
 #define MLX5_IB_DM_MEMIC_ALLOWED_ACCESS (IB_ACCESS_LOCAL_WRITE   |\
@@ -646,7 +659,7 @@ struct mlx5_user_mmap_entry {
 
 struct mlx5_ib_mr {
 	struct ib_mr ibmr;
-	struct mlx5_core_mkey mmkey;
+	struct mlx5_ib_mkey mmkey;
 
 	/* User MR data */
 	struct mlx5_cache_ent *cache_ent;
@@ -722,12 +735,12 @@ static inline bool is_dmabuf_mr(struct mlx5_ib_mr *mr)
 
 struct mlx5_ib_mw {
 	struct ib_mw		ibmw;
-	struct mlx5_core_mkey	mmkey;
+	struct mlx5_ib_mkey	mmkey;
 	int			ndescs;
 };
 
 struct mlx5_ib_devx_mr {
-	struct mlx5_core_mkey	mmkey;
+	struct mlx5_ib_mkey	mmkey;
 	int			ndescs;
 };
 
@@ -1605,7 +1618,7 @@ static inline bool mlx5_ib_can_reconfig_with_umr(struct mlx5_ib_dev *dev,
 }
 
 static inline int mlx5r_store_odp_mkey(struct mlx5_ib_dev *dev,
-				       struct mlx5_core_mkey *mmkey)
+				       struct mlx5_ib_mkey *mmkey)
 {
 	refcount_set(&mmkey->usecount, 1);
 
@@ -1614,14 +1627,14 @@ static inline int mlx5r_store_odp_mkey(struct mlx5_ib_dev *dev,
 }
 
 /* deref an mkey that can participate in ODP flow */
-static inline void mlx5r_deref_odp_mkey(struct mlx5_core_mkey *mmkey)
+static inline void mlx5r_deref_odp_mkey(struct mlx5_ib_mkey *mmkey)
 {
 	if (refcount_dec_and_test(&mmkey->usecount))
 		wake_up(&mmkey->wait);
 }
 
 /* deref an mkey that can participate in ODP flow and wait for relese */
-static inline void mlx5r_deref_wait_odp_mkey(struct mlx5_core_mkey *mmkey)
+static inline void mlx5r_deref_wait_odp_mkey(struct mlx5_ib_mkey *mmkey)
 {
 	mlx5r_deref_odp_mkey(mmkey);
 	wait_event(mmkey->wait, refcount_read(&mmkey->usecount) == 0);
diff --git a/drivers/infiniband/hw/mlx5/mr.c b/drivers/infiniband/hw/mlx5/mr.c
index 2260b0298965..675be5b1de9c 100644
--- a/drivers/infiniband/hw/mlx5/mr.c
+++ b/drivers/infiniband/hw/mlx5/mr.c
@@ -89,9 +89,8 @@ static void set_mkc_access_pd_addr_fields(void *mkc, int acc, u64 start_addr,
 	MLX5_SET64(mkc, mkc, start_addr, start_addr);
 }
 
-static void
-assign_mkey_variant(struct mlx5_ib_dev *dev, struct mlx5_core_mkey *mkey,
-		    u32 *in)
+static void assign_mkey_variant(struct mlx5_ib_dev *dev,
+				struct mlx5_ib_mkey *mkey, u32 *in)
 {
 	u8 key = atomic_inc_return(&dev->mkey_var);
 	void *mkc;
@@ -101,9 +100,8 @@ assign_mkey_variant(struct mlx5_ib_dev *dev, struct mlx5_core_mkey *mkey,
 	mkey->key = key;
 }
 
-static int
-mlx5_ib_create_mkey(struct mlx5_ib_dev *dev, struct mlx5_core_mkey *mkey,
-		    u32 *in, int inlen)
+static int mlx5_ib_create_mkey(struct mlx5_ib_dev *dev,
+			       struct mlx5_ib_mkey *mkey, u32 *in, int inlen)
 {
 	int ret;
 
@@ -117,7 +115,7 @@ mlx5_ib_create_mkey(struct mlx5_ib_dev *dev, struct mlx5_core_mkey *mkey,
 
 static int
 mlx5_ib_create_mkey_cb(struct mlx5_ib_dev *dev,
-		       struct mlx5_core_mkey *mkey,
+		       struct mlx5_ib_mkey *mkey,
 		       struct mlx5_async_ctx *async_ctx,
 		       u32 *in, int inlen, u32 *out, int outlen,
 		       struct mlx5_async_work *context)
diff --git a/drivers/infiniband/hw/mlx5/odp.c b/drivers/infiniband/hw/mlx5/odp.c
index 8ffd3ea8db7c..8dd9d8457767 100644
--- a/drivers/infiniband/hw/mlx5/odp.c
+++ b/drivers/infiniband/hw/mlx5/odp.c
@@ -788,7 +788,7 @@ struct pf_frame {
 	int depth;
 };
 
-static bool mkey_is_eq(struct mlx5_core_mkey *mmkey, u32 key)
+static bool mkey_is_eq(struct mlx5_ib_mkey *mmkey, u32 key)
 {
 	if (!mmkey)
 		return false;
@@ -797,7 +797,7 @@ static bool mkey_is_eq(struct mlx5_core_mkey *mmkey, u32 key)
 	return mmkey->key == key;
 }
 
-static int get_indirect_num_descs(struct mlx5_core_mkey *mmkey)
+static int get_indirect_num_descs(struct mlx5_ib_mkey *mmkey)
 {
 	struct mlx5_ib_mw *mw;
 	struct mlx5_ib_devx_mr *devx_mr;
@@ -831,7 +831,7 @@ static int pagefault_single_data_segment(struct mlx5_ib_dev *dev,
 {
 	int npages = 0, ret, i, outlen, cur_outlen = 0, depth = 0;
 	struct pf_frame *head = NULL, *frame;
-	struct mlx5_core_mkey *mmkey;
+	struct mlx5_ib_mkey *mmkey;
 	struct mlx5_ib_mr *mr;
 	struct mlx5_klm *pklm;
 	u32 *out = NULL;
@@ -1703,8 +1703,8 @@ get_prefetchable_mr(struct ib_pd *pd, enum ib_uverbs_advise_mr_advice advice,
 		    u32 lkey)
 {
 	struct mlx5_ib_dev *dev = to_mdev(pd->device);
-	struct mlx5_core_mkey *mmkey;
 	struct mlx5_ib_mr *mr = NULL;
+	struct mlx5_ib_mkey *mmkey;
 
 	xa_lock(&dev->odp_mkeys);
 	mmkey = xa_load(&dev->odp_mkeys, mlx5_base_mkey(lkey));
diff --git a/include/linux/mlx5/driver.h b/include/linux/mlx5/driver.h
index 42f653c70e8c..441a2f8715f8 100644
--- a/include/linux/mlx5/driver.h
+++ b/include/linux/mlx5/driver.h
@@ -357,19 +357,6 @@ struct mlx5_core_sig_ctx {
 	u32			sigerr_count;
 };
 
-enum {
-	MLX5_MKEY_MR = 1,
-	MLX5_MKEY_MW,
-	MLX5_MKEY_INDIRECT_DEVX,
-};
-
-struct mlx5_core_mkey {
-	u32			key;
-	u32			type;
-	struct wait_queue_head wait;
-	refcount_t usecount;
-};
-
 #define MLX5_24BIT_MASK		((1 << 24) - 1)
 
 enum mlx5_res_type {
-- 
2.31.1

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
