Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C73D3C00A5A
	for <virtualization@archiver.kernel.org>; Thu, 19 Jan 2023 06:16:12 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 7A8F78229B;
	Thu, 19 Jan 2023 06:16:12 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 7A8F78229B
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=BvB6fy39
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Lb2dVTDPTcGg; Thu, 19 Jan 2023 06:16:11 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id F1ECD82284;
	Thu, 19 Jan 2023 06:16:10 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org F1ECD82284
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id CDAB9C0032;
	Thu, 19 Jan 2023 06:16:10 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id CB509C002D
 for <virtualization@lists.linux-foundation.org>;
 Thu, 19 Jan 2023 06:16:08 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 35E2740148
 for <virtualization@lists.linux-foundation.org>;
 Thu, 19 Jan 2023 06:16:08 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 35E2740148
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=BvB6fy39
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 0veDm2Y3ii_X
 for <virtualization@lists.linux-foundation.org>;
 Thu, 19 Jan 2023 06:16:07 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 6BDAB40127
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 6BDAB40127
 for <virtualization@lists.linux-foundation.org>;
 Thu, 19 Jan 2023 06:16:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1674108966;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=7ggS+8BEq6Y5BuiP5CUK1tAuZNnVqha6988K92SB/Gc=;
 b=BvB6fy39OxxSIgYHAwC5lb+ikdp9PZuamlPfDMY0hOLsay5M7mm7eyhD3PihUq7y7hkn4w
 jZViJNekMvydla8xPOe6D6gsDEupFGvMg1m7PlYag8OvxGtjPgr5Svmey+uQHmgH4maNB0
 EdVvQhoTl+shG5f07ejHR8zifGhmKsA=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-673-_7yl938FMyWjqThxXudjuQ-1; Thu, 19 Jan 2023 01:15:54 -0500
X-MC-Unique: _7yl938FMyWjqThxXudjuQ-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
 [10.11.54.3])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id E9C7C280605A;
 Thu, 19 Jan 2023 06:15:53 +0000 (UTC)
Received: from localhost.localdomain (ovpn-13-97.pek2.redhat.com [10.72.13.97])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 876441121315;
 Thu, 19 Jan 2023 06:15:50 +0000 (UTC)
From: Jason Wang <jasowang@redhat.com>
To: mst@redhat.com,
	jasowang@redhat.com
Subject: [PATCH V2 5/5] vdpa: mlx5: support per virtqueue dma device
Date: Thu, 19 Jan 2023 14:15:25 +0800
Message-Id: <20230119061525.75068-6-jasowang@redhat.com>
In-Reply-To: <20230119061525.75068-1-jasowang@redhat.com>
References: <20230119061525.75068-1-jasowang@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.3
Cc: gdawar@amd.com, elic@nvidia.com, virtualization@lists.linux-foundation.org,
 tanuj.kamde@amd.com, linux-kernel@vger.kernel.org
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

This patch implements per virtqueue dma device for mlx5_vdpa. This is
needed for virtio_vdpa to work for CVQ which is backed by vringh but
not DMA. We simply advertise the vDPA device itself as the DMA device
for CVQ then DMA API can simply use PA so the identical mapping for
CVQ can still be used. Otherwise the identical (1:1) mapping won't
work when platform IOMMU is enabled since the IOVA is allocated on
demand which is not necessarily the PA.

This fixes the following crash when mlx5 vDPA device is bound to
virtio-vdpa with platform IOMMU enabled but not in passthrough mode:

BUG: unable to handle page fault for address: ff2fb3063deb1002
#PF: supervisor read access in kernel mode
#PF: error_code(0x0000) - not-present page
PGD 1393001067 P4D 1393002067 PUD 0
Oops: 0000 [#1] PREEMPT SMP NOPTI
CPU: 55 PID: 8923 Comm: kworker/u112:3 Kdump: loaded Not tainted 6.1.0+ #7
Hardware name: Dell Inc. PowerEdge R750/0PJ80M, BIOS 1.5.4 12/17/2021
Workqueue: mlx5_vdpa_wq mlx5_cvq_kick_handler [mlx5_vdpa]
RIP: 0010:vringh_getdesc_iotlb+0x93/0x1d0 [vringh]
Code: 14 25 40 ef 01 00 83 82 c0 0a 00 00 01 48 2b 05 93 5a 1b ea 8b 4c 24 14 48 c1 f8 06 48 c1 e0 0c 48 03 05 90 5a 1b ea 48 01 c8 <0f> b7 00 83 aa c0 0a 00 00 01 65 ff 0d bc e4 41 3f 0f 84 05 01 00
RSP: 0018:ff46821ba664fdf8 EFLAGS: 00010282
RAX: ff2fb3063deb1002 RBX: 0000000000000a20 RCX: 0000000000000002
RDX: ff2fb318d2f94380 RSI: 0000000000000002 RDI: 0000000000000001
RBP: ff2fb3065e832410 R08: ff46821ba664fe00 R09: 0000000000000001
R10: 0000000000000000 R11: 000000000000000d R12: ff2fb3065e832488
R13: ff2fb3065e8324a8 R14: ff2fb3065e8324c8 R15: ff2fb3065e8324a8
FS:  0000000000000000(0000) GS:ff2fb3257fac0000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: ff2fb3063deb1002 CR3: 0000001392010006 CR4: 0000000000771ee0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
PKRU: 55555554
Call Trace:
<TASK>
  mlx5_cvq_kick_handler+0x89/0x2b0 [mlx5_vdpa]
  process_one_work+0x1e2/0x3b0
  ? rescuer_thread+0x390/0x390
  worker_thread+0x50/0x3a0
  ? rescuer_thread+0x390/0x390
  kthread+0xd6/0x100
  ? kthread_complete_and_exit+0x20/0x20
  ret_from_fork+0x1f/0x30
  </TASK>

Reviewed-by: Eli Cohen <elic@nvidia.com>
Tested-by: Eli Cohen <elic@nvidia.com>
Signed-off-by: Jason Wang <jasowang@redhat.com>
---
Changes since V1:
- make mlx5_get_vq_dma_dev() static
---
 drivers/vdpa/mlx5/net/mlx5_vnet.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/vdpa/mlx5/net/mlx5_vnet.c b/drivers/vdpa/mlx5/net/mlx5_vnet.c
index 6632651b1e54..97d1ada7f4db 100644
--- a/drivers/vdpa/mlx5/net/mlx5_vnet.c
+++ b/drivers/vdpa/mlx5/net/mlx5_vnet.c
@@ -2682,6 +2682,16 @@ static int mlx5_vdpa_set_map(struct vdpa_device *vdev, unsigned int asid,
 	return err;
 }
 
+static struct device *mlx5_get_vq_dma_dev(struct vdpa_device *vdev, u16 idx)
+{
+	struct mlx5_vdpa_dev *mvdev = to_mvdev(vdev);
+
+	if (is_ctrl_vq_idx(mvdev, idx))
+		return &vdev->dev;
+
+	return mvdev->vdev.dma_dev;
+}
+
 static void mlx5_vdpa_free(struct vdpa_device *vdev)
 {
 	struct mlx5_vdpa_dev *mvdev = to_mvdev(vdev);
@@ -2897,6 +2907,7 @@ static const struct vdpa_config_ops mlx5_vdpa_ops = {
 	.get_generation = mlx5_vdpa_get_generation,
 	.set_map = mlx5_vdpa_set_map,
 	.set_group_asid = mlx5_set_group_asid,
+	.get_vq_dma_dev = mlx5_get_vq_dma_dev,
 	.free = mlx5_vdpa_free,
 	.suspend = mlx5_vdpa_suspend,
 };
-- 
2.25.1

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
