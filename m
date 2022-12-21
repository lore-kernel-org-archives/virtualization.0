Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 859C0C4332F
	for <virtualization@archiver.kernel.org>; Wed, 21 Dec 2022 06:17:24 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 08F1A40B26;
	Wed, 21 Dec 2022 06:17:24 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 08F1A40B26
Authentication-Results: smtp2.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=fi9J+QSO
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 8rVOXqwASZ4t; Wed, 21 Dec 2022 06:17:23 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 4EFF8400D1;
	Wed, 21 Dec 2022 06:17:22 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 4EFF8400D1
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id BE60AC007C;
	Wed, 21 Dec 2022 06:17:19 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 06D8EC0077
 for <virtualization@lists.linux-foundation.org>;
 Wed, 21 Dec 2022 06:17:08 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id F2E80417C1
 for <virtualization@lists.linux-foundation.org>;
 Wed, 21 Dec 2022 06:17:06 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org F2E80417C1
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=fi9J+QSO
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id v4s17nH4b-tP
 for <virtualization@lists.linux-foundation.org>;
 Wed, 21 Dec 2022 06:17:06 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 1D46D417BE
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 1D46D417BE
 for <virtualization@lists.linux-foundation.org>;
 Wed, 21 Dec 2022 06:17:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1671603424;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=SXqwCh6Com8aJFlTus6HXtifGXM4NjpzjtHRW5NKksM=;
 b=fi9J+QSOKe8ZGTrqoBO3Nd03djDtqsQtfV6yS1QZM76/nr3t+HI5fJwaK4gmHt3sICR9Hq
 6ETFehRDCJRewZLYtsc+6c7SNtFswE+eK2L76v6Lqpd345hYZX5By8cmo4KNm2WrP1CJPh
 o36jvsw/loaa60E96xMzDiKzl/1tDX4=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-650-i728ixYCPuin4W9HX5UmUQ-1; Wed, 21 Dec 2022 01:17:03 -0500
X-MC-Unique: i728ixYCPuin4W9HX5UmUQ-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
 [10.11.54.6])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id B01513C3C166;
 Wed, 21 Dec 2022 06:17:02 +0000 (UTC)
Received: from localhost.localdomain (ovpn-13-236.pek2.redhat.com
 [10.72.13.236])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 15FB12166B26;
 Wed, 21 Dec 2022 06:16:58 +0000 (UTC)
From: Jason Wang <jasowang@redhat.com>
To: mst@redhat.com,
	jasowang@redhat.com
Subject: [PATCH 1/4] vdpa_sim: switch to use __vdpa_alloc_device()
Date: Wed, 21 Dec 2022 14:16:49 +0800
Message-Id: <20221221061652.15202-2-jasowang@redhat.com>
In-Reply-To: <20221221061652.15202-1-jasowang@redhat.com>
References: <20221221061652.15202-1-jasowang@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.6
Cc: eperezma@redhat.com, virtualization@lists.linux-foundation.org,
 linux-kernel@vger.kernel.org
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

This allows us to control the allocation size of the structure.

Signed-off-by: Jason Wang <jasowang@redhat.com>
---
 drivers/vdpa/vdpa_sim/vdpa_sim.c | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/drivers/vdpa/vdpa_sim/vdpa_sim.c b/drivers/vdpa/vdpa_sim/vdpa_sim.c
index b071f0d842fb..757afef86ba0 100644
--- a/drivers/vdpa/vdpa_sim/vdpa_sim.c
+++ b/drivers/vdpa/vdpa_sim/vdpa_sim.c
@@ -250,6 +250,7 @@ struct vdpasim *vdpasim_create(struct vdpasim_dev_attr *dev_attr,
 			       const struct vdpa_dev_set_config *config)
 {
 	const struct vdpa_config_ops *ops;
+	struct vdpa_device *vdpa;
 	struct vdpasim *vdpasim;
 	struct device *dev;
 	int i, ret = -ENOMEM;
@@ -267,14 +268,16 @@ struct vdpasim *vdpasim_create(struct vdpasim_dev_attr *dev_attr,
 	else
 		ops = &vdpasim_config_ops;
 
-	vdpasim = vdpa_alloc_device(struct vdpasim, vdpa, NULL, ops,
-				    dev_attr->ngroups, dev_attr->nas,
-				    dev_attr->name, false);
-	if (IS_ERR(vdpasim)) {
-		ret = PTR_ERR(vdpasim);
+	vdpa = __vdpa_alloc_device(NULL, ops,
+				   dev_attr->ngroups, dev_attr->nas,
+				   sizeof(struct vdpasim),
+				   dev_attr->name, false);
+	if (IS_ERR(vdpa)) {
+		ret = PTR_ERR(vdpa);
 		goto err_alloc;
 	}
 
+	vdpasim = vdpa_to_sim(vdpa);
 	vdpasim->dev_attr = *dev_attr;
 	INIT_WORK(&vdpasim->work, dev_attr->work_fn);
 	spin_lock_init(&vdpasim->lock);
-- 
2.25.1

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
