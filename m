Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3BF0BC433EF
	for <virtualization@archiver.kernel.org>; Tue, 30 Nov 2021 14:57:09 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id C3E5782605;
	Tue, 30 Nov 2021 14:57:08 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 69nTdWd6mSbk; Tue, 30 Nov 2021 14:57:08 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 78034817EB;
	Tue, 30 Nov 2021 14:57:07 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 4380BC0012;
	Tue, 30 Nov 2021 14:57:07 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 027E4C000A
 for <virtualization@lists.linux-foundation.org>;
 Tue, 30 Nov 2021 14:57:07 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id E4A9981842
 for <virtualization@lists.linux-foundation.org>;
 Tue, 30 Nov 2021 14:57:06 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id a5-sCDH4zu6h
 for <virtualization@lists.linux-foundation.org>;
 Tue, 30 Nov 2021 14:57:05 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
 by smtp1.osuosl.org (Postfix) with ESMTPS id C0FAC817EB
 for <virtualization@lists.linux-foundation.org>;
 Tue, 30 Nov 2021 14:57:05 +0000 (UTC)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ams.source.kernel.org (Postfix) with ESMTPS id 209EFB81A34;
 Tue, 30 Nov 2021 14:50:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EAD23C53FC1;
 Tue, 30 Nov 2021 14:50:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1638283807;
 bh=HNxKbjB96XxCJFowlbjGxNOiW3Tjj8GTqWkuCBB7DGc=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=f7biZn8imblMLA8gd2rqI6G8NZEGuStcPdlox/bQ+uZ1QUE+JO52helIL67wH6Jq+
 f28CKv7Eq8uwPP51+FGJB15/vHOX5BIFtDNGpDvZRyOtVnqHRpoUiUiOoDoAqNHRek
 f4e7Db1IWPXIx9Q6d/NWnncSQik9THy2hRA7aP0BlYV9zWiETc5cuRc5BE4QQ5rxPl
 2tZGMCFtm31PeROXdyR6XqHoCk+K4VLiBIY2RXXZIeaY/mQ938Yqg1uUw8u1rc/jBA
 3fld6Sayg7Ux/CF0IDARBrQwjiGlVpC7xfm3qVxkhMGGcfqEx3GMunt5Zap6A+hqVt
 583tNCrf2P9rg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH AUTOSEL 5.15 61/68] vhost-vdpa: clean irqs before reseting
 vdpa device
Date: Tue, 30 Nov 2021 09:46:57 -0500
Message-Id: <20211130144707.944580-61-sashal@kernel.org>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20211130144707.944580-1-sashal@kernel.org>
References: <20211130144707.944580-1-sashal@kernel.org>
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
index 39039e0461175..e73bff6fcff98 100644
--- a/drivers/vhost/vdpa.c
+++ b/drivers/vhost/vdpa.c
@@ -1015,12 +1015,12 @@ static int vhost_vdpa_release(struct inode *inode, struct file *filep)
 
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
