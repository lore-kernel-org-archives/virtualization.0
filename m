Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 27B53C433EF
	for <virtualization@archiver.kernel.org>; Thu,  9 Jun 2022 04:19:15 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id AE1BB8290B;
	Thu,  9 Jun 2022 04:19:14 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Zq0-XzHwznsz; Thu,  9 Jun 2022 04:19:13 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 46135828A9;
	Thu,  9 Jun 2022 04:19:13 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 09C06C0039;
	Thu,  9 Jun 2022 04:19:13 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id E54AEC002D
 for <virtualization@lists.linux-foundation.org>;
 Thu,  9 Jun 2022 04:19:11 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id CD69840E46
 for <virtualization@lists.linux-foundation.org>;
 Thu,  9 Jun 2022 04:19:11 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id BAaNAh3pSoGo
 for <virtualization@lists.linux-foundation.org>;
 Thu,  9 Jun 2022 04:19:11 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id D7AF8408A2
 for <virtualization@lists.linux-foundation.org>;
 Thu,  9 Jun 2022 04:19:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1654748349;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=2EUgTmBmBQS8TADvNh3w+eG84Zb6i5oxbEJ7TRa74m8=;
 b=MZrNH6KYjQ3tcMByxSwFb7xcJjTY9+5RsfNjavvq81k4f50DrGHGI6H49lcGzvrhEtqkTq
 +rJQF13QG7bdEKJwWkI1Pbwo6JulKxS+UCutM3WCw8mw1C++Y9vLsJK+sAZEoOra9ZAoPP
 +nSerH74fqHs2rmTm8AIkczdQsbUpXw=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-575-z2rJ_Z0XPfueqmTPLXd04A-1; Thu, 09 Jun 2022 00:19:07 -0400
X-MC-Unique: z2rJ_Z0XPfueqmTPLXd04A-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
 [10.11.54.5])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 7F6C3811E75;
 Thu,  9 Jun 2022 04:19:07 +0000 (UTC)
Received: from localhost.localdomain (ovpn-14-4.pek2.redhat.com [10.72.14.4])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 7733A1730C;
 Thu,  9 Jun 2022 04:19:04 +0000 (UTC)
From: Jason Wang <jasowang@redhat.com>
To: mst@redhat.com,
	jasowang@redhat.com
Subject: [PATCH] vdpa: make get_vq_group and set_group_asid optional
Date: Thu,  9 Jun 2022 12:19:01 +0800
Message-Id: <20220609041901.2029-1-jasowang@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.11.54.5
Cc: netdev@vger.kernel.org, Gautam Dawar <gautam.dawar@xilinx.com>,
 linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
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

This patch makes get_vq_group and set_group_asid optional. This is
needed to unbreak the vDPA parent that doesn't support multiple
address spaces.

Cc: Gautam Dawar <gautam.dawar@xilinx.com>
Fixes: aaca8373c4b1 ("vhost-vdpa: support ASID based IOTLB API")
Signed-off-by: Jason Wang <jasowang@redhat.com>
---
 drivers/vhost/vdpa.c | 2 ++
 include/linux/vdpa.h | 5 +++--
 2 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/vhost/vdpa.c b/drivers/vhost/vdpa.c
index 935a1d0ddb97..5ad2596c6e8a 100644
--- a/drivers/vhost/vdpa.c
+++ b/drivers/vhost/vdpa.c
@@ -499,6 +499,8 @@ static long vhost_vdpa_vring_ioctl(struct vhost_vdpa *v, unsigned int cmd,
 		ops->set_vq_ready(vdpa, idx, s.num);
 		return 0;
 	case VHOST_VDPA_GET_VRING_GROUP:
+		if (!ops->get_vq_group)
+			return -EOPNOTSUPP;
 		s.index = idx;
 		s.num = ops->get_vq_group(vdpa, idx);
 		if (s.num >= vdpa->ngroups)
diff --git a/include/linux/vdpa.h b/include/linux/vdpa.h
index 15af802d41c4..6113a978fbcd 100644
--- a/include/linux/vdpa.h
+++ b/include/linux/vdpa.h
@@ -176,7 +176,8 @@ struct vdpa_map_file {
  *				for the device
  *				@vdev: vdpa device
  *				Returns virtqueue algin requirement
- * @get_vq_group:		Get the group id for a specific virtqueue
+ * @get_vq_group:		Get the group id for a specific
+ *				virtqueue (optional)
  *				@vdev: vdpa device
  *				@idx: virtqueue index
  *				Returns u32: group id for this virtqueue
@@ -241,7 +242,7 @@ struct vdpa_map_file {
  *				Returns the iova range supported by
  *				the device.
  * @set_group_asid:		Set address space identifier for a
- *				virtqueue group
+ *				virtqueue group (optional)
  *				@vdev: vdpa device
  *				@group: virtqueue group
  *				@asid: address space id for this group
-- 
2.25.1

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
