Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CAF67C433F5
	for <virtualization@archiver.kernel.org>; Tue,  1 Mar 2022 01:26:34 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 5CC0980D1B;
	Tue,  1 Mar 2022 01:26:34 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id w_P09w8nJfAg; Tue,  1 Mar 2022 01:26:33 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id E1D0A8254A;
	Tue,  1 Mar 2022 01:26:32 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id B397CC0077;
	Tue,  1 Mar 2022 01:26:32 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id C4857C001A
 for <virtualization@lists.linux-foundation.org>;
 Tue,  1 Mar 2022 01:26:31 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id A3940403FD
 for <virtualization@lists.linux-foundation.org>;
 Tue,  1 Mar 2022 01:26:31 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id NWgOQr0WoLPP
 for <virtualization@lists.linux-foundation.org>;
 Tue,  1 Mar 2022 01:26:30 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
Received: from mxhk.zte.com.cn (mxhk.zte.com.cn [63.216.63.35])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 6F60E401CA
 for <virtualization@lists.linux-foundation.org>;
 Tue,  1 Mar 2022 01:26:30 +0000 (UTC)
Received: from mxct.zte.com.cn (unknown [192.168.251.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mxhk.zte.com.cn (FangMail) with ESMTPS id 4K702X5MLLzBH5DP
 for <virtualization@lists.linux-foundation.org>;
 Tue,  1 Mar 2022 09:26:28 +0800 (CST)
Received: from mse-fl2.zte.com.cn (unknown [10.30.14.239])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mxct.zte.com.cn (FangMail) with ESMTPS id 4K702Q4kt9z8fkWd;
 Tue,  1 Mar 2022 09:26:22 +0800 (CST)
Received: from szxlzmapp05.zte.com.cn ([10.5.230.85])
 by mse-fl2.zte.com.cn with SMTP id 2211Q6Ev061421;
 Tue, 1 Mar 2022 09:26:07 +0800 (GMT-8)
 (envelope-from wang.yi59@zte.com.cn)
Received: from fox-cloudhost8.localdomain (unknown [10.234.72.110])
 by smtp (Zmail) with SMTP; Tue, 1 Mar 2022 09:26:06 +0800
X-Zmail-TransId: 3e81621d762e002-92466
From: Yi Wang <wang.yi59@zte.com.cn>
To: mst@redhat.com
Subject: [PATCH] vdpa: fix use-after-free on vp_vdpa_remove
Date: Tue,  1 Mar 2022 17:10:59 +0800
Message-Id: <20220301091059.46869-1-wang.yi59@zte.com.cn>
X-Mailer: git-send-email 2.33.0.rc0.dirty
MIME-Version: 1.0
X-MAIL: mse-fl2.zte.com.cn 2211Q6Ev061421
X-Fangmail-Gw-Spam-Type: 0
X-FangMail-Miltered: at cgslv5.04-192.168.250.138.novalocal with ID
 621D7644.001 by FangMail milter!
X-FangMail-Envelope: 1646097988/4K702X5MLLzBH5DP/621D7644.001/192.168.251.13/[192.168.251.13]/mxct.zte.com.cn/<wang.yi59@zte.com.cn>
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 621D7644.001/4K702X5MLLzBH5DP
Cc: wang.yi59@zte.com.cn, Zhang Min <zhang.min9@zte.com.cn>,
 wang.liang82@zte.com.cn, linux-kernel@vger.kernel.org,
 virtualization@lists.linux-foundation.org, xieyongji@bytedance.com,
 wuzongyong@linux.alibaba.com, xue.zhihong@zte.com.cn, elic@nvidia.com
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

From: Zhang Min <zhang.min9@zte.com.cn>

When vp_vdpa driver is unbind, vp_vdpa is freed in vdpa_unregister_device
and then vp_vdpa->mdev.pci_dev is dereferenced in vp_modern_remove,
triggering use-after-free.

Call Trace of unbinding driver free vp_vdpa :
do_syscall_64
  vfs_write
    kernfs_fop_write_iter
      device_release_driver_internal
        pci_device_remove
          vp_vdpa_remove
            vdpa_unregister_device
              kobject_release
                device_release
                  kfree

Call Trace of dereference vp_vdpa->mdev.pci_dev:
vp_modern_remove
  pci_release_selected_regions
    pci_release_region
      pci_resource_len
        pci_resource_end
          (dev)->resource[(bar)].end

Signed-off-by: Zhang Min <zhang.min9@zte.com.cn>
Signed-off-by: Yi Wang <wang.yi59@zte.com.cn>
---
 drivers/vdpa/virtio_pci/vp_vdpa.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/vdpa/virtio_pci/vp_vdpa.c b/drivers/vdpa/virtio_pci/vp_vdpa.c
index a57e381e830b..cce101e6a940 100644
--- a/drivers/vdpa/virtio_pci/vp_vdpa.c
+++ b/drivers/vdpa/virtio_pci/vp_vdpa.c
@@ -533,8 +533,8 @@ static void vp_vdpa_remove(struct pci_dev *pdev)
 {
 	struct vp_vdpa *vp_vdpa = pci_get_drvdata(pdev);
 
-	vdpa_unregister_device(&vp_vdpa->vdpa);
 	vp_modern_remove(&vp_vdpa->mdev);
+	vdpa_unregister_device(&vp_vdpa->vdpa);
 }
 
 static struct pci_driver vp_vdpa_driver = {
-- 
2.27.0
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
