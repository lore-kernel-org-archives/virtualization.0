Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 753ACEB64DA
	for <virtualization@archiver.kernel.org>; Thu, 22 Jun 2023 20:49:24 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id EDF5A839C0;
	Thu, 22 Jun 2023 20:49:23 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org EDF5A839C0
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=RsBDDiIe
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id xJ3YhBh6xKHl; Thu, 22 Jun 2023 20:49:23 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 6A3EE836C3;
	Thu, 22 Jun 2023 20:49:22 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 6A3EE836C3
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 41702C007A;
	Thu, 22 Jun 2023 20:49:22 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id E11BDC0029
 for <virtualization@lists.linux-foundation.org>;
 Thu, 22 Jun 2023 20:49:20 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id C121440181
 for <virtualization@lists.linux-foundation.org>;
 Thu, 22 Jun 2023 20:49:20 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org C121440181
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=RsBDDiIe
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id JMMmYqIe1lga
 for <virtualization@lists.linux-foundation.org>;
 Thu, 22 Jun 2023 20:49:19 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 5B17840001
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 5B17840001
 for <virtualization@lists.linux-foundation.org>;
 Thu, 22 Jun 2023 20:49:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1687466957;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=71euS97JqDaYftzvmNJahHa0ohhMOQyQZdTI3d5Cdjk=;
 b=RsBDDiIer+WLFmynFghlsk+8w7GNEJYW6T5NABpOamuQF/WLH+BcRJKAqjwiXEv3CKonyI
 hU8SKak4qqugVAR6nXCi0ZV/iuZXp4GxSIwk5IHS7zeKpNhmaKlavp0HYB+E35Xtl7M4pW
 ChFL0njxMXdkV2BB2A/sPzom7OCnktY=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-12-sHV2WgY9PIi-WFyhF7pZrg-1; Thu, 22 Jun 2023 16:49:15 -0400
X-MC-Unique: sHV2WgY9PIi-WFyhF7pZrg-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
 [10.11.54.5])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 5B5EC2807D8B;
 Thu, 22 Jun 2023 20:49:04 +0000 (UTC)
Received: from max-t490s.redhat.com (unknown [10.39.208.22])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 54FE1422B0;
 Thu, 22 Jun 2023 20:49:02 +0000 (UTC)
From: Maxime Coquelin <maxime.coquelin@redhat.com>
To: xieyongji@bytedance.com, jasowang@redhat.com, mst@redhat.com,
 xuanzhuo@linux.alibaba.com
Subject: [PATCH v2] vduse: fix NULL pointer dereference
Date: Thu, 22 Jun 2023 22:48:51 +0200
Message-ID: <20230622204851.318125-1-maxime.coquelin@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.5
Cc: gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
 virtualization@lists.linux-foundation.org,
 Maxime Coquelin <maxime.coquelin@redhat.com>, sheng.zhao@bytedance.com
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

vduse_vdpa_set_vq_affinity callback can be called
with NULL value as cpu_mask when deleting the vduse
device.

This patch resets virtqueue's IRQ affinity mask value
to set all CPUs instead of dereferencing NULL cpu_mask.

[ 4760.952149] BUG: kernel NULL pointer dereference, address: 0000000000000000
[ 4760.959110] #PF: supervisor read access in kernel mode
[ 4760.964247] #PF: error_code(0x0000) - not-present page
[ 4760.969385] PGD 0 P4D 0
[ 4760.971927] Oops: 0000 [#1] PREEMPT SMP PTI
[ 4760.976112] CPU: 13 PID: 2346 Comm: vdpa Not tainted 6.4.0-rc6+ #4
[ 4760.982291] Hardware name: Dell Inc. PowerEdge R640/0W23H8, BIOS 2.8.1 06/26/2020
[ 4760.989769] RIP: 0010:memcpy_orig+0xc5/0x130
[ 4760.994049] Code: 16 f8 4c 89 07 4c 89 4f 08 4c 89 54 17 f0 4c 89 5c 17 f8 c3 cc cc cc cc 66 66 2e 0f 1f 84 00 00 00 00 00 66 90 83 fa 08 72 1b <4c> 8b 06 4c 8b 4c 16 f8 4c 89 07 4c 89 4c 17 f8 c3 cc cc cc cc 66
[ 4761.012793] RSP: 0018:ffffb1d565abb830 EFLAGS: 00010246
[ 4761.018020] RAX: ffff9f4bf6b27898 RBX: ffff9f4be23969c0 RCX: ffff9f4bcadf6400
[ 4761.025152] RDX: 0000000000000008 RSI: 0000000000000000 RDI: ffff9f4bf6b27898
[ 4761.032286] RBP: 0000000000000000 R08: 0000000000000008 R09: 0000000000000000
[ 4761.039416] R10: 0000000000000000 R11: 0000000000000600 R12: 0000000000000000
[ 4761.046549] R13: 0000000000000000 R14: 0000000000000080 R15: ffffb1d565abbb10
[ 4761.053680] FS:  00007f64c2ec2740(0000) GS:ffff9f635f980000(0000) knlGS:0000000000000000
[ 4761.061765] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[ 4761.067513] CR2: 0000000000000000 CR3: 0000001875270006 CR4: 00000000007706e0
[ 4761.074645] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[ 4761.081775] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
[ 4761.088909] PKRU: 55555554
[ 4761.091620] Call Trace:
[ 4761.094074]  <TASK>
[ 4761.096180]  ? __die+0x1f/0x70
[ 4761.099238]  ? page_fault_oops+0x171/0x4f0
[ 4761.103340]  ? exc_page_fault+0x7b/0x180
[ 4761.107265]  ? asm_exc_page_fault+0x22/0x30
[ 4761.111460]  ? memcpy_orig+0xc5/0x130
[ 4761.115126]  vduse_vdpa_set_vq_affinity+0x3e/0x50 [vduse]
[ 4761.120533]  virtnet_clean_affinity.part.0+0x3d/0x90 [virtio_net]
[ 4761.126635]  remove_vq_common+0x1a4/0x250 [virtio_net]
[ 4761.131781]  virtnet_remove+0x5d/0x70 [virtio_net]
[ 4761.136580]  virtio_dev_remove+0x3a/0x90
[ 4761.140509]  device_release_driver_internal+0x19b/0x200
[ 4761.145742]  bus_remove_device+0xc2/0x130
[ 4761.149755]  device_del+0x158/0x3e0
[ 4761.153245]  ? kernfs_find_ns+0x35/0xc0
[ 4761.157086]  device_unregister+0x13/0x60
[ 4761.161010]  unregister_virtio_device+0x11/0x20
[ 4761.165543]  device_release_driver_internal+0x19b/0x200
[ 4761.170770]  bus_remove_device+0xc2/0x130
[ 4761.174782]  device_del+0x158/0x3e0
[ 4761.178276]  ? __pfx_vdpa_name_match+0x10/0x10 [vdpa]
[ 4761.183336]  device_unregister+0x13/0x60
[ 4761.187260]  vdpa_nl_cmd_dev_del_set_doit+0x63/0xe0 [vdpa]

Fixes: 28f6288eb63d ("vduse: Support set_vq_affinity callback")
Cc: xieyongji@bytedance.com

Signed-off-by: Maxime Coquelin <maxime.coquelin@redhat.com>
---
 drivers/vdpa/vdpa_user/vduse_dev.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/vdpa/vdpa_user/vduse_dev.c b/drivers/vdpa/vdpa_user/vduse_dev.c
index 5f5c21674fdc..0d84e6a9c3cc 100644
--- a/drivers/vdpa/vdpa_user/vduse_dev.c
+++ b/drivers/vdpa/vdpa_user/vduse_dev.c
@@ -726,7 +726,11 @@ static int vduse_vdpa_set_vq_affinity(struct vdpa_device *vdpa, u16 idx,
 {
 	struct vduse_dev *dev = vdpa_to_vduse(vdpa);
 
-	cpumask_copy(&dev->vqs[idx]->irq_affinity, cpu_mask);
+	if (cpu_mask)
+		cpumask_copy(&dev->vqs[idx]->irq_affinity, cpu_mask);
+	else
+		cpumask_setall(&dev->vqs[idx]->irq_affinity);
+
 	return 0;
 }
 
-- 
2.41.0

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
