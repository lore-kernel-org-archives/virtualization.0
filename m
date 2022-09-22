Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F246DECAAD8
	for <virtualization@archiver.kernel.org>; Thu, 22 Sep 2022 02:43:35 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 7266E40509;
	Thu, 22 Sep 2022 02:43:35 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 7266E40509
Authentication-Results: smtp4.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=AEzRNdrp
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id eapaqRmTbGKE; Thu, 22 Sep 2022 02:43:34 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 964DB404A5;
	Thu, 22 Sep 2022 02:43:33 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 964DB404A5
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 70A83C0032;
	Thu, 22 Sep 2022 02:43:33 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id C99B3C002D
 for <virtualization@lists.linux-foundation.org>;
 Thu, 22 Sep 2022 02:43:32 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id A432F8124B
 for <virtualization@lists.linux-foundation.org>;
 Thu, 22 Sep 2022 02:43:32 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org A432F8124B
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=AEzRNdrp
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id WGxGbND6EyTA
 for <virtualization@lists.linux-foundation.org>;
 Thu, 22 Sep 2022 02:43:32 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org C86C780E07
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id C86C780E07
 for <virtualization@lists.linux-foundation.org>;
 Thu, 22 Sep 2022 02:43:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1663814610;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=voAQSkJZsqEcFHoE05kFOKlNJJihIbhmQEwAm2HrkYI=;
 b=AEzRNdrpJjGSXJ7D3Pn9a+DbRazCuJLUZtxmKnLQ3A6FMrZdO546MF7ip69lEqqZ1A/vZb
 D13C1DAOuA5F0B6BUgCBQw7zD62mgFgLIsoFspVCzLNdIZHyA8C+QLYk/fX4PUf5H7cQlz
 I12WpBjHwUBCPySBYLmbYPJEK6bCaa8=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-351-vpxGZcnCPNGHGUaF0l8ATQ-1; Wed, 21 Sep 2022 22:43:29 -0400
X-MC-Unique: vpxGZcnCPNGHGUaF0l8ATQ-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com
 [10.11.54.7])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 950CD1C05AA7;
 Thu, 22 Sep 2022 02:43:28 +0000 (UTC)
Received: from localhost.localdomain (ovpn-13-82.pek2.redhat.com [10.72.13.82])
 by smtp.corp.redhat.com (Postfix) with ESMTP id A43E4140EBF3;
 Thu, 22 Sep 2022 02:43:22 +0000 (UTC)
From: Jason Wang <jasowang@redhat.com>
To: mst@redhat.com,
	jasowang@redhat.com
Subject: [PATCH V2 1/3] vdpa: device feature provisioning
Date: Thu, 22 Sep 2022 10:43:03 +0800
Message-Id: <20220922024305.1718-2-jasowang@redhat.com>
In-Reply-To: <20220922024305.1718-1-jasowang@redhat.com>
References: <20220922024305.1718-1-jasowang@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.7
Cc: lulu@redhat.com, xieyongji@bytedance.com, linux-kernel@vger.kernel.org,
 gdawar@xilinx.com, virtualization@lists.linux-foundation.org,
 eperezma@redhat.com, wuzongyong@linux.alibaba.com, elic@nvidia.com,
 lingshan.zhu@intel.com
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

This patch allows the device features to be provisioned through
netlink. A new attribute is introduced to allow the userspace to pass
a 64bit device features during device adding.

This provides several advantages:

- Allow to provision a subset of the features to ease the cross vendor
  live migration.
- Better debug-ability for vDPA framework and parent.

Reviewed-by: Eli Cohen <elic@nvidia.com>
Signed-off-by: Jason Wang <jasowang@redhat.com>
---
 drivers/vdpa/vdpa.c       | 5 +++++
 include/linux/vdpa.h      | 1 +
 include/uapi/linux/vdpa.h | 2 ++
 3 files changed, 8 insertions(+)

diff --git a/drivers/vdpa/vdpa.c b/drivers/vdpa/vdpa.c
index c06c02704461..278e26bfa492 100644
--- a/drivers/vdpa/vdpa.c
+++ b/drivers/vdpa/vdpa.c
@@ -600,6 +600,11 @@ static int vdpa_nl_cmd_dev_add_set_doit(struct sk_buff *skb, struct genl_info *i
 		}
 		config.mask |= BIT_ULL(VDPA_ATTR_DEV_NET_CFG_MAX_VQP);
 	}
+	if (nl_attrs[VDPA_ATTR_DEV_FEATURES]) {
+		config.device_features =
+			nla_get_u64(nl_attrs[VDPA_ATTR_DEV_FEATURES]);
+		config.mask |= BIT_ULL(VDPA_ATTR_DEV_FEATURES);
+	}
 
 	/* Skip checking capability if user didn't prefer to configure any
 	 * device networking attributes. It is likely that user might have used
diff --git a/include/linux/vdpa.h b/include/linux/vdpa.h
index d282f464d2f1..6d0f5e4e82c2 100644
--- a/include/linux/vdpa.h
+++ b/include/linux/vdpa.h
@@ -104,6 +104,7 @@ struct vdpa_iova_range {
 };
 
 struct vdpa_dev_set_config {
+	u64 device_features;
 	struct {
 		u8 mac[ETH_ALEN];
 		u16 mtu;
diff --git a/include/uapi/linux/vdpa.h b/include/uapi/linux/vdpa.h
index 25c55cab3d7c..9dc855f37c59 100644
--- a/include/uapi/linux/vdpa.h
+++ b/include/uapi/linux/vdpa.h
@@ -52,6 +52,8 @@ enum vdpa_attr {
 	VDPA_ATTR_DEV_VENDOR_ATTR_NAME,		/* string */
 	VDPA_ATTR_DEV_VENDOR_ATTR_VALUE,        /* u64 */
 
+	VDPA_ATTR_DEV_FEATURES,                 /* u64 */
+
 	/* new attributes must be added above here */
 	VDPA_ATTR_MAX,
 };
-- 
2.25.1

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
