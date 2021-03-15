Return-Path: <SRS0=NA0D=IN=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_RED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 921FAC433E6
	for <virtualization@archiver.kernel.org>; Mon, 15 Mar 2021 16:36:38 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3FBF564F2A
	for <virtualization@archiver.kernel.org>; Mon, 15 Mar 2021 16:36:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3FBF564F2A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 0FB164B601;
	Mon, 15 Mar 2021 16:36:38 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id wIU7SQAtrWuy; Mon, 15 Mar 2021 16:36:37 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTP id 8B84F4C642;
	Mon, 15 Mar 2021 16:36:36 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 759B4C000B;
	Mon, 15 Mar 2021 16:36:36 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 6DCC8C0012
 for <virtualization@lists.linux-foundation.org>;
 Mon, 15 Mar 2021 16:36:35 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 4AFD047E3B
 for <virtualization@lists.linux-foundation.org>;
 Mon, 15 Mar 2021 16:36:35 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id vPf2cEktLasS
 for <virtualization@lists.linux-foundation.org>;
 Mon, 15 Mar 2021 16:36:34 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 7F4F3400A9
 for <virtualization@lists.linux-foundation.org>;
 Mon, 15 Mar 2021 16:36:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1615826193;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=KLOfu+3tvxBM9AOvHodnhHFlNdGDVuA5IWmra+LYM2A=;
 b=Rkj8Z2LVGCt/aPu5A6Aey0w9GTxlBJQ5jV7VpQvTh/BZNbcBZF37KeZFYk4jyhuXUbB+7L
 GAkfkPvkID+BWTXskpmp0EoGuLsw2UVo8IbrVeG0B8tUGYwPVBJjmYlDsPUb4X72CEzftS
 tV7z+vqqeoIGA5DfOXanV2IrAX2x4Gk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-329-ScObpkMJPE2pysMQHktPLQ-1; Mon, 15 Mar 2021 12:36:24 -0400
X-MC-Unique: ScObpkMJPE2pysMQHktPLQ-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 0FE7394DE2;
 Mon, 15 Mar 2021 16:36:23 +0000 (UTC)
Received: from steredhat.redhat.com (ovpn-114-1.ams2.redhat.com [10.36.114.1])
 by smtp.corp.redhat.com (Postfix) with ESMTP id BB0265FC17;
 Mon, 15 Mar 2021 16:36:20 +0000 (UTC)
From: Stefano Garzarella <sgarzare@redhat.com>
To: virtualization@lists.linux-foundation.org
Subject: [PATCH v4 09/14] vhost/vdpa: use get_config_size callback in
 vhost_vdpa_config_validate()
Date: Mon, 15 Mar 2021 17:34:45 +0100
Message-Id: <20210315163450.254396-10-sgarzare@redhat.com>
In-Reply-To: <20210315163450.254396-1-sgarzare@redhat.com>
References: <20210315163450.254396-1-sgarzare@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Cc: Laurent Vivier <lvivier@redhat.com>, Max Gurtovoy <mgurtovoy@nvidia.com>,
 kvm@vger.kernel.org, "Michael S. Tsirkin" <mst@redhat.com>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 Xie Yongji <xieyongji@bytedance.com>, Stefan Hajnoczi <stefanha@redhat.com>
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

Let's use the new 'get_config_size()' callback available instead of
using the 'virtio_id' to get the size of the device config space.

Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
---
 drivers/vhost/vdpa.c | 9 ++-------
 1 file changed, 2 insertions(+), 7 deletions(-)

diff --git a/drivers/vhost/vdpa.c b/drivers/vhost/vdpa.c
index e0a27e336293..7ae4080e57d8 100644
--- a/drivers/vhost/vdpa.c
+++ b/drivers/vhost/vdpa.c
@@ -188,13 +188,8 @@ static long vhost_vdpa_set_status(struct vhost_vdpa *v, u8 __user *statusp)
 static int vhost_vdpa_config_validate(struct vhost_vdpa *v,
 				      struct vhost_vdpa_config *c)
 {
-	long size = 0;
-
-	switch (v->virtio_id) {
-	case VIRTIO_ID_NET:
-		size = sizeof(struct virtio_net_config);
-		break;
-	}
+	struct vdpa_device *vdpa = v->vdpa;
+	long size = vdpa->config->get_config_size(vdpa);
 
 	if (c->len == 0)
 		return -EINVAL;
-- 
2.30.2

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
