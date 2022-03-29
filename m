Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 378FFC433FE
	for <virtualization@archiver.kernel.org>; Tue, 29 Mar 2022 04:09:02 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id C2A8241717;
	Tue, 29 Mar 2022 04:09:01 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id e_MkX4XRySC6; Tue, 29 Mar 2022 04:09:00 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 03CC8416F8;
	Tue, 29 Mar 2022 04:08:59 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id CCC3FC001D;
	Tue, 29 Mar 2022 04:08:59 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 813B6C0012
 for <virtualization@lists.linux-foundation.org>;
 Tue, 29 Mar 2022 04:08:59 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 6FE40607A3
 for <virtualization@lists.linux-foundation.org>;
 Tue, 29 Mar 2022 04:08:59 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id xz6TO2ftZ31d
 for <virtualization@lists.linux-foundation.org>;
 Tue, 29 Mar 2022 04:08:58 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 6B3E960776
 for <virtualization@lists.linux-foundation.org>;
 Tue, 29 Mar 2022 04:08:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1648526937;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=FdtzVbHEVVTrIVUf/a9wd2B8iWz4QyPeNZt3tZlqNJw=;
 b=GlVI19k8C/a/tJg1AEUFrT8Azn0YwQ1Yj97YAwZA62hKFkPJUSK5PW6mxG4BVehoUfAjQc
 GFb36keVBQt6PicCbt44d0STfbLJ9SKvtQBWGCfqiQw/3dOt8UsgXQsjM5N2JW6+95RVCT
 qH8IJHVbSPn3VuoBUAPPwBAleEiNpmk=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-30-v0vLYg4mMxOiw9lxARYWRw-1; Tue, 29 Mar 2022 00:08:53 -0400
X-MC-Unique: v0vLYg4mMxOiw9lxARYWRw-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com
 [10.11.54.10])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id E0ABA802809;
 Tue, 29 Mar 2022 04:08:52 +0000 (UTC)
Received: from localhost.localdomain (ovpn-13-210.pek2.redhat.com
 [10.72.13.210])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 76108401E64;
 Tue, 29 Mar 2022 04:08:49 +0000 (UTC)
From: Jason Wang <jasowang@redhat.com>
To: mst@redhat.com,
	jasowang@redhat.com
Subject: [PATCH V2 3/3] vdpa/mlx5: Use consistent RQT size
Date: Tue, 29 Mar 2022 12:08:40 +0800
Message-Id: <20220329040840.3419-3-jasowang@redhat.com>
In-Reply-To: <20220329040840.3419-1-jasowang@redhat.com>
References: <20220329040840.3419-1-jasowang@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.85 on 10.11.54.10
Cc: Eli Cohen <elic@nvidia.com>, linux-kernel@vger.kernel.org,
 virtualization@lists.linux-foundation.org
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

From: Eli Cohen <elic@nvidia.com>

The current code evaluates RQT size based on the configured number of
virtqueues. This can raise an issue in the following scenario:

Assume MQ was negotiated.
1. mlx5_vdpa_set_map() gets called.
2. handle_ctrl_mq() is called setting cur_num_vqs to some value, lower
   than the configured max VQs.
3. A second set_map gets called, but now a smaller number of VQs is used
   to evaluate the size of the RQT.
4. handle_ctrl_mq() is called with a value larger than what the RQT can
   hold. This will emit errors and the driver state is compromised.

To fix this, we use a new field in struct mlx5_vdpa_net to hold the
required number of entries in the RQT. This value is evaluated in
mlx5_vdpa_set_driver_features() where we have the negotiated features
all set up.

In addtion to that, we take into consideration the max capability of RQT
entries early when the device is added so we don't need to take consider
it when creating the RQT.

Last, we remove the use of mlx5_vdpa_max_qps() which just returns the
max_vas / 2 and make the code clearer.

Fixes: 52893733f2c5 ("vdpa/mlx5: Add multiqueue support")
Signed-off-by: Eli Cohen <elic@nvidia.com>
---
 drivers/vdpa/mlx5/net/mlx5_vnet.c | 61 +++++++++++--------------------
 1 file changed, 21 insertions(+), 40 deletions(-)

diff --git a/drivers/vdpa/mlx5/net/mlx5_vnet.c b/drivers/vdpa/mlx5/net/mlx5_vnet.c
index 53b8c1a68f90..61bec1ed0bc9 100644
--- a/drivers/vdpa/mlx5/net/mlx5_vnet.c
+++ b/drivers/vdpa/mlx5/net/mlx5_vnet.c
@@ -161,6 +161,7 @@ struct mlx5_vdpa_net {
 	struct mlx5_flow_handle *rx_rule_mcast;
 	bool setup;
 	u32 cur_num_vqs;
+	u32 rqt_size;
 	struct notifier_block nb;
 	struct vdpa_callback config_cb;
 	struct mlx5_vdpa_wq_ent cvq_ent;
@@ -204,17 +205,12 @@ static __virtio16 cpu_to_mlx5vdpa16(struct mlx5_vdpa_dev *mvdev, u16 val)
 	return __cpu_to_virtio16(mlx5_vdpa_is_little_endian(mvdev), val);
 }
 
-static inline u32 mlx5_vdpa_max_qps(int max_vqs)
-{
-	return max_vqs / 2;
-}
-
 static u16 ctrl_vq_idx(struct mlx5_vdpa_dev *mvdev)
 {
 	if (!(mvdev->actual_features & BIT_ULL(VIRTIO_NET_F_MQ)))
 		return 2;
 
-	return 2 * mlx5_vdpa_max_qps(mvdev->max_vqs);
+	return mvdev->max_vqs;
 }
 
 static bool is_ctrl_vq_idx(struct mlx5_vdpa_dev *mvdev, u16 idx)
@@ -1236,25 +1232,13 @@ static void teardown_vq(struct mlx5_vdpa_net *ndev, struct mlx5_vdpa_virtqueue *
 static int create_rqt(struct mlx5_vdpa_net *ndev)
 {
 	__be32 *list;
-	int max_rqt;
 	void *rqtc;
 	int inlen;
 	void *in;
 	int i, j;
 	int err;
-	int num;
-
-	if (!(ndev->mvdev.actual_features & BIT_ULL(VIRTIO_NET_F_MQ)))
-		num = 1;
-	else
-		num = ndev->cur_num_vqs / 2;
 
-	max_rqt = min_t(int, roundup_pow_of_two(num),
-			1 << MLX5_CAP_GEN(ndev->mvdev.mdev, log_max_rqt_size));
-	if (max_rqt < 1)
-		return -EOPNOTSUPP;
-
-	inlen = MLX5_ST_SZ_BYTES(create_rqt_in) + max_rqt * MLX5_ST_SZ_BYTES(rq_num);
+	inlen = MLX5_ST_SZ_BYTES(create_rqt_in) + ndev->rqt_size * MLX5_ST_SZ_BYTES(rq_num);
 	in = kzalloc(inlen, GFP_KERNEL);
 	if (!in)
 		return -ENOMEM;
@@ -1263,12 +1247,12 @@ static int create_rqt(struct mlx5_vdpa_net *ndev)
 	rqtc = MLX5_ADDR_OF(create_rqt_in, in, rqt_context);
 
 	MLX5_SET(rqtc, rqtc, list_q_type, MLX5_RQTC_LIST_Q_TYPE_VIRTIO_NET_Q);
-	MLX5_SET(rqtc, rqtc, rqt_max_size, max_rqt);
+	MLX5_SET(rqtc, rqtc, rqt_max_size, ndev->rqt_size);
 	list = MLX5_ADDR_OF(rqtc, rqtc, rq_num[0]);
-	for (i = 0, j = 0; i < max_rqt; i++, j += 2)
-		list[i] = cpu_to_be32(ndev->vqs[j % (2 * num)].virtq_id);
+	for (i = 0, j = 0; i < ndev->rqt_size; i++, j += 2)
+		list[i] = cpu_to_be32(ndev->vqs[j % ndev->cur_num_vqs].virtq_id);
 
-	MLX5_SET(rqtc, rqtc, rqt_actual_size, max_rqt);
+	MLX5_SET(rqtc, rqtc, rqt_actual_size, ndev->rqt_size);
 	err = mlx5_vdpa_create_rqt(&ndev->mvdev, in, inlen, &ndev->res.rqtn);
 	kfree(in);
 	if (err)
@@ -1282,19 +1266,13 @@ static int create_rqt(struct mlx5_vdpa_net *ndev)
 static int modify_rqt(struct mlx5_vdpa_net *ndev, int num)
 {
 	__be32 *list;
-	int max_rqt;
 	void *rqtc;
 	int inlen;
 	void *in;
 	int i, j;
 	int err;
 
-	max_rqt = min_t(int, roundup_pow_of_two(ndev->cur_num_vqs / 2),
-			1 << MLX5_CAP_GEN(ndev->mvdev.mdev, log_max_rqt_size));
-	if (max_rqt < 1)
-		return -EOPNOTSUPP;
-
-	inlen = MLX5_ST_SZ_BYTES(modify_rqt_in) + max_rqt * MLX5_ST_SZ_BYTES(rq_num);
+	inlen = MLX5_ST_SZ_BYTES(modify_rqt_in) + ndev->rqt_size * MLX5_ST_SZ_BYTES(rq_num);
 	in = kzalloc(inlen, GFP_KERNEL);
 	if (!in)
 		return -ENOMEM;
@@ -1305,10 +1283,10 @@ static int modify_rqt(struct mlx5_vdpa_net *ndev, int num)
 	MLX5_SET(rqtc, rqtc, list_q_type, MLX5_RQTC_LIST_Q_TYPE_VIRTIO_NET_Q);
 
 	list = MLX5_ADDR_OF(rqtc, rqtc, rq_num[0]);
-	for (i = 0, j = 0; i < max_rqt; i++, j += 2)
+	for (i = 0, j = 0; i < ndev->rqt_size; i++, j += 2)
 		list[i] = cpu_to_be32(ndev->vqs[j % num].virtq_id);
 
-	MLX5_SET(rqtc, rqtc, rqt_actual_size, max_rqt);
+	MLX5_SET(rqtc, rqtc, rqt_actual_size, ndev->rqt_size);
 	err = mlx5_vdpa_modify_rqt(&ndev->mvdev, in, inlen, ndev->res.rqtn);
 	kfree(in);
 	if (err)
@@ -1582,7 +1560,7 @@ static virtio_net_ctrl_ack handle_ctrl_mq(struct mlx5_vdpa_dev *mvdev, u8 cmd)
 
 		newqps = mlx5vdpa16_to_cpu(mvdev, mq.virtqueue_pairs);
 		if (newqps < VIRTIO_NET_CTRL_MQ_VQ_PAIRS_MIN ||
-		    newqps > mlx5_vdpa_max_qps(mvdev->max_vqs))
+		    newqps > ndev->rqt_size)
 			break;
 
 		if (ndev->cur_num_vqs == 2 * newqps) {
@@ -1946,7 +1924,7 @@ static int setup_virtqueues(struct mlx5_vdpa_dev *mvdev)
 	int err;
 	int i;
 
-	for (i = 0; i < 2 * mlx5_vdpa_max_qps(mvdev->max_vqs); i++) {
+	for (i = 0; i < mvdev->max_vqs; i++) {
 		err = setup_vq(ndev, &ndev->vqs[i]);
 		if (err)
 			goto err_vq;
@@ -2017,9 +1995,11 @@ static int mlx5_vdpa_set_driver_features(struct vdpa_device *vdev, u64 features)
 
 	ndev->mvdev.actual_features = features & ndev->mvdev.mlx_features;
 	if (ndev->mvdev.actual_features & BIT_ULL(VIRTIO_NET_F_MQ))
-		ndev->cur_num_vqs = 2 * mlx5vdpa16_to_cpu(mvdev, ndev->config.max_virtqueue_pairs);
+		ndev->rqt_size = mlx5vdpa16_to_cpu(mvdev, ndev->config.max_virtqueue_pairs);
 	else
-		ndev->cur_num_vqs = 2;
+		ndev->rqt_size = 1;
+
+	ndev->cur_num_vqs = 2 * ndev->rqt_size;
 
 	update_cvq_info(mvdev);
 	return err;
@@ -2486,7 +2466,7 @@ static void init_mvqs(struct mlx5_vdpa_net *ndev)
 	struct mlx5_vdpa_virtqueue *mvq;
 	int i;
 
-	for (i = 0; i < 2 * mlx5_vdpa_max_qps(ndev->mvdev.max_vqs); ++i) {
+	for (i = 0; i < ndev->mvdev.max_vqs; ++i) {
 		mvq = &ndev->vqs[i];
 		memset(mvq, 0, offsetof(struct mlx5_vdpa_virtqueue, ri));
 		mvq->index = i;
@@ -2606,7 +2586,8 @@ static int mlx5_vdpa_dev_add(struct vdpa_mgmt_dev *v_mdev, const char *name,
 		return -EOPNOTSUPP;
 	}
 
-	max_vqs = MLX5_CAP_DEV_VDPA_EMULATION(mdev, max_num_virtio_queues);
+	max_vqs = min_t(int, MLX5_CAP_DEV_VDPA_EMULATION(mdev, max_num_virtio_queues),
+			1 << MLX5_CAP_GEN(mdev, log_max_rqt_size));
 	if (max_vqs < 2) {
 		dev_warn(mdev->device,
 			 "%d virtqueues are supported. At least 2 are required\n",
@@ -2670,7 +2651,7 @@ static int mlx5_vdpa_dev_add(struct vdpa_mgmt_dev *v_mdev, const char *name,
 		ndev->mvdev.mlx_features |= BIT_ULL(VIRTIO_NET_F_MAC);
 	}
 
-	config->max_virtqueue_pairs = cpu_to_mlx5vdpa16(mvdev, mlx5_vdpa_max_qps(max_vqs));
+	config->max_virtqueue_pairs = cpu_to_mlx5vdpa16(mvdev, max_vqs / 2);
 	mvdev->vdev.dma_dev = &mdev->pdev->dev;
 	err = mlx5_vdpa_alloc_resources(&ndev->mvdev);
 	if (err)
@@ -2697,7 +2678,7 @@ static int mlx5_vdpa_dev_add(struct vdpa_mgmt_dev *v_mdev, const char *name,
 	ndev->nb.notifier_call = event_handler;
 	mlx5_notifier_register(mdev, &ndev->nb);
 	mvdev->vdev.mdev = &mgtdev->mgtdev;
-	err = _vdpa_register_device(&mvdev->vdev, 2 * mlx5_vdpa_max_qps(max_vqs) + 1);
+	err = _vdpa_register_device(&mvdev->vdev, max_vqs + 1);
 	if (err)
 		goto err_reg;
 
-- 
2.18.1

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
