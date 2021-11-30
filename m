Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D6E7EC433EF
	for <virtualization@archiver.kernel.org>; Tue, 30 Nov 2021 14:52:00 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 69E10402E9;
	Tue, 30 Nov 2021 14:52:00 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id K9GZ8oPMRBoX; Tue, 30 Nov 2021 14:51:59 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id DEA904021F;
	Tue, 30 Nov 2021 14:51:58 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id C55A8C0012;
	Tue, 30 Nov 2021 14:51:58 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 8EA91C000A
 for <virtualization@lists.linux-foundation.org>;
 Tue, 30 Nov 2021 14:51:57 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 70E6E40393
 for <virtualization@lists.linux-foundation.org>;
 Tue, 30 Nov 2021 14:51:57 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=kernel.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id qLNZy_kO_ccc
 for <virtualization@lists.linux-foundation.org>;
 Tue, 30 Nov 2021 14:51:56 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from sin.source.kernel.org (sin.source.kernel.org
 [IPv6:2604:1380:40e1:4800::1])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 26362403A8
 for <virtualization@lists.linux-foundation.org>;
 Tue, 30 Nov 2021 14:51:56 +0000 (UTC)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by sin.source.kernel.org (Postfix) with ESMTPS id 23752CE1A5D;
 Tue, 30 Nov 2021 14:51:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7293BC53FD1;
 Tue, 30 Nov 2021 14:51:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1638283910;
 bh=rG5KoghkyfV7pz9bOTRLk+mJ5sE6VXKu+6Aw2KfwALs=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=fSWbO6Wl8mkWUWZb0MZTPDpEd4fKnV21ullPuVPeHLmrWgmjuXnXFVp5n5U8iutea
 UNuPojMMcHTIM/ORAiUWk0LmF+nzqyR65orluwgdHOqGhzY27CfCpOtcBxrILYVsnB
 E7B2LdWEbdmhyYCoNrtHXEObxVZw4dEN37n0C5qUZ7fUSoCM47pPd3rgIuB+oEZFHJ
 Izi2st7ME7GGBgYNOsoRGhCaWRrtAdxZE30dSzt2lyZCgWF3GBAuB3hEGdoGpMwAvA
 7aslSIFd+uPbsssuYTTKvv2UBJ/VFZuVfVqEDD1T+cHN8hrE35PdxLNsxfAwPz1JDE
 Jelk/vReB9nGA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH AUTOSEL 5.10 40/43] vhost-vdpa: clean irqs before reseting
 vdpa device
Date: Tue, 30 Nov 2021 09:50:17 -0500
Message-Id: <20211130145022.945517-40-sashal@kernel.org>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20211130145022.945517-1-sashal@kernel.org>
References: <20211130145022.945517-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Cc: Sasha Levin <sashal@kernel.org>, kvm@vger.kernel.org,
 "Michael S . Tsirkin" <mst@redhat.com>, netdev@vger.kernel.org,
 virtualization@lists.linux-foundation.org,
 Wu Zongyong <wuzongyong@linux.alibaba.com>
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

From: Wu Zongyong <wuzongyong@linux.alibaba.com>

[ Upstream commit ea8f17e44fa7d54fae287ccbe30ce269afb5ee42 ]

Vdpa devices should be reset after unseting irqs of virtqueues, or we
will get errors when killing qemu process:

>> pi_update_irte: failed to update PI IRTE
>> irq bypass consumer (token 0000000065102a43) unregistration fails: -22

Signed-off-by: Wu Zongyong <wuzongyong@linux.alibaba.com>
Link: https://lore.kernel.org/r/a2cb60cf73be9da5c4e6399242117d8818f975ae.1636946171.git.wuzongyong@linux.alibaba.com
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Acked-by: Jason Wang <jasowang@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/vhost/vdpa.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/vhost/vdpa.c b/drivers/vhost/vdpa.c
index fdeb20f2f174c..dc4dccd35f59b 100644
--- a/drivers/vhost/vdpa.c
+++ b/drivers/vhost/vdpa.c
@@ -928,12 +928,12 @@ static int vhost_vdpa_release(struct inode *inode, struct file *filep)
 
 	mutex_lock(&d->mutex);
 	filep->private_data = NULL;
+	vhost_vdpa_clean_irq(v);
 	vhost_vdpa_reset(v);
 	vhost_dev_stop(&v->vdev);
 	vhost_vdpa_iotlb_free(v);
 	vhost_vdpa_free_domain(v);
 	vhost_vdpa_config_put(v);
-	vhost_vdpa_clean_irq(v);
 	vhost_dev_cleanup(&v->vdev);
 	kfree(v->vdev.vqs);
 	mutex_unlock(&d->mutex);
-- 
2.33.0

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
