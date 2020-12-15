Return-Path: <SRS0=Oc7+=FT=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E23C1C4361B
	for <virtualization@archiver.kernel.org>; Tue, 15 Dec 2020 14:45:27 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 93D65223D6
	for <virtualization@archiver.kernel.org>; Tue, 15 Dec 2020 14:45:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 93D65223D6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 4FF0A86E57;
	Tue, 15 Dec 2020 14:45:27 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id BWXTlqFyOC4Q; Tue, 15 Dec 2020 14:45:26 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id E60B286E3F;
	Tue, 15 Dec 2020 14:45:26 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id B134DC0893;
	Tue, 15 Dec 2020 14:45:26 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 2D557C013B
 for <virtualization@lists.linux-foundation.org>;
 Tue, 15 Dec 2020 14:45:26 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 1CFFA871F4
 for <virtualization@lists.linux-foundation.org>;
 Tue, 15 Dec 2020 14:45:26 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id w1XPvOtOkAWd
 for <virtualization@lists.linux-foundation.org>;
 Tue, 15 Dec 2020 14:45:25 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [63.128.21.124])
 by whitealder.osuosl.org (Postfix) with ESMTPS id 7A95386614
 for <virtualization@lists.linux-foundation.org>;
 Tue, 15 Dec 2020 14:45:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1608043524;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=x8NFGtoRITboX12gxZUXMgI+BfyloqUcec6BjZjcRqE=;
 b=dN55RHxSAWI2T8kTosTtKwiL7p20jMHVmqxuv7HCn/Jl8Cjo4ahUkCoPNgU2qeQNYcsKqR
 rcAQN+WK2SY2oSl8elGMuNL3P7cqQeKyVyZo8wOBVCzVBIFieChZ3bWawr5lt+X7fxDsMq
 LhPzByskh6Rq3/I0KfnyS8Qa9+XsZcE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-450-v-ZOzENwOjiTV_keL7Q52A-1; Tue, 15 Dec 2020 09:45:20 -0500
X-MC-Unique: v-ZOzENwOjiTV_keL7Q52A-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 3B16B1842145;
 Tue, 15 Dec 2020 14:45:19 +0000 (UTC)
Received: from steredhat.redhat.com (ovpn-115-49.ams2.redhat.com
 [10.36.115.49])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 7916260C0F;
 Tue, 15 Dec 2020 14:45:16 +0000 (UTC)
From: Stefano Garzarella <sgarzare@redhat.com>
To: virtualization@lists.linux-foundation.org
Subject: [PATCH v4 15/18] vdpa_sim: use kvmalloc to allocate vdpasim->buffer
Date: Tue, 15 Dec 2020 15:42:53 +0100
Message-Id: <20201215144256.155342-16-sgarzare@redhat.com>
In-Reply-To: <20201215144256.155342-1-sgarzare@redhat.com>
References: <20201215144256.155342-1-sgarzare@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Cc: Laurent Vivier <lvivier@redhat.com>, Max Gurtovoy <mgurtovoy@nvidia.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Randy Dunlap <rdunlap@infradead.org>,
 linux-kernel@vger.kernel.org, Shahaf Shuler <shahafs@nvidia.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Eli Cohen <elic@nvidia.com>,
 Oren Duer <oren@nvidia.com>
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

The next patch will make the buffer size configurable from each
device.
Since the buffer could be larger than a page, we use kvmalloc()
instead of kmalloc().

Acked-by: Jason Wang <jasowang@redhat.com>
Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
---
 drivers/vdpa/vdpa_sim/vdpa_sim.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/vdpa/vdpa_sim/vdpa_sim.c b/drivers/vdpa/vdpa_sim/vdpa_sim.c
index 19ff5e352782..87529899033a 100644
--- a/drivers/vdpa/vdpa_sim/vdpa_sim.c
+++ b/drivers/vdpa/vdpa_sim/vdpa_sim.c
@@ -418,7 +418,7 @@ static struct vdpasim *vdpasim_create(struct vdpasim_dev_attr *dev_attr)
 	if (!vdpasim->iommu)
 		goto err_iommu;
 
-	vdpasim->buffer = kmalloc(PAGE_SIZE, GFP_KERNEL);
+	vdpasim->buffer = kvmalloc(PAGE_SIZE, GFP_KERNEL);
 	if (!vdpasim->buffer)
 		goto err_iommu;
 
@@ -707,7 +707,7 @@ static void vdpasim_free(struct vdpa_device *vdpa)
 	struct vdpasim *vdpasim = vdpa_to_sim(vdpa);
 
 	cancel_work_sync(&vdpasim->work);
-	kfree(vdpasim->buffer);
+	kvfree(vdpasim->buffer);
 	if (vdpasim->iommu)
 		vhost_iotlb_free(vdpasim->iommu);
 	kfree(vdpasim->vqs);
-- 
2.26.2

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
