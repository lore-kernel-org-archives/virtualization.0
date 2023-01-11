Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6CBE5C5479D
	for <virtualization@archiver.kernel.org>; Wed, 11 Jan 2023 06:28:46 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 27519812A9;
	Wed, 11 Jan 2023 06:28:46 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 27519812A9
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=Kr2FYPQS
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id sZMcpN_N7RK8; Wed, 11 Jan 2023 06:28:45 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 9FBD880FA4;
	Wed, 11 Jan 2023 06:28:44 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 9FBD880FA4
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 7D440C0032;
	Wed, 11 Jan 2023 06:28:44 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 48CC6C002D
 for <virtualization@lists.linux-foundation.org>;
 Wed, 11 Jan 2023 06:28:43 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 3177281289
 for <virtualization@lists.linux-foundation.org>;
 Wed, 11 Jan 2023 06:28:43 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 3177281289
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id K2ZVH3990Qn4
 for <virtualization@lists.linux-foundation.org>;
 Wed, 11 Jan 2023 06:28:42 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 1CE8D80DC0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 1CE8D80DC0
 for <virtualization@lists.linux-foundation.org>;
 Wed, 11 Jan 2023 06:28:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1673418521;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=epqvlkhFZV9FVfYN+D7bGXQ6MN72AZjZPKTBXiU7FN4=;
 b=Kr2FYPQS+MvCPN4+WtOQ5++lAGxN+VxVY0Gb5FXSE0nyrod7doRrkvZ/v6Re3U4MDnLXWv
 92AAg+86/aRhyL/CI7c6HFYD1kWkw8r/uA3MZM7ConNvoSQz+oUmVLNrV44SkJICU7enzW
 Rno//dP7BfGUeWzJpUhfClbZueg7nAs=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-199-XCW145yROKq1MFbhN6r2iw-1; Wed, 11 Jan 2023 01:28:35 -0500
X-MC-Unique: XCW145yROKq1MFbhN6r2iw-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com
 [10.11.54.2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id EE7E4801779;
 Wed, 11 Jan 2023 06:28:34 +0000 (UTC)
Received: from localhost.localdomain (ovpn-13-175.pek2.redhat.com
 [10.72.13.175])
 by smtp.corp.redhat.com (Postfix) with ESMTP id F2AAB4078904;
 Wed, 11 Jan 2023 06:28:31 +0000 (UTC)
From: Jason Wang <jasowang@redhat.com>
To: mst@redhat.com,
	jasowang@redhat.com
Subject: [PATCH 5/5] vdpa: mlx5: support per virtqueue dma device
Date: Wed, 11 Jan 2023 14:28:09 +0800
Message-Id: <20230111062809.25020-6-jasowang@redhat.com>
In-Reply-To: <20230111062809.25020-1-jasowang@redhat.com>
References: <20230111062809.25020-1-jasowang@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.2
Cc: gdawar@amd.com, elic@nvidia.com, linux-kernel@vger.kernel.org,
 tanuj.kamde@amd.com, virtualization@lists.linux-foundation.org
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

Signed-off-by: Jason Wang <jasowang@redhat.com>
---
 drivers/vdpa/mlx5/net/mlx5_vnet.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/vdpa/mlx5/net/mlx5_vnet.c b/drivers/vdpa/mlx5/net/mlx5_vnet.c
index 6632651b1e54..b0e74c25bf48 100644
--- a/drivers/vdpa/mlx5/net/mlx5_vnet.c
+++ b/drivers/vdpa/mlx5/net/mlx5_vnet.c
@@ -2682,6 +2682,16 @@ static int mlx5_vdpa_set_map(struct vdpa_device *vdev, unsigned int asid,
 	return err;
 }
 
+struct device *mlx5_get_vq_dma_dev(struct vdpa_device *vdev, u16 idx)
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
