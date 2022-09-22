Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7C09DECAAD8
	for <virtualization@archiver.kernel.org>; Thu, 22 Sep 2022 02:43:43 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 22257610A7;
	Thu, 22 Sep 2022 02:43:43 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 22257610A7
Authentication-Results: smtp3.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=XG8PUGOl
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 7SOEZWVWLaXy; Thu, 22 Sep 2022 02:43:42 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id C419660E4F;
	Thu, 22 Sep 2022 02:43:41 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org C419660E4F
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id A1267C0032;
	Thu, 22 Sep 2022 02:43:41 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 09E79C002D
 for <virtualization@lists.linux-foundation.org>;
 Thu, 22 Sep 2022 02:43:40 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id CBBEA813CD
 for <virtualization@lists.linux-foundation.org>;
 Thu, 22 Sep 2022 02:43:39 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org CBBEA813CD
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=XG8PUGOl
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Yc2g6NTXhg38
 for <virtualization@lists.linux-foundation.org>;
 Thu, 22 Sep 2022 02:43:39 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 0F6C9813B7
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 0F6C9813B7
 for <virtualization@lists.linux-foundation.org>;
 Thu, 22 Sep 2022 02:43:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1663814618;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Ar4ws6tsYSlypig9THRYQWjGLpEgGwvHCM9nNLPpuwA=;
 b=XG8PUGOlIy+hrVxsROq7S89h4v4QE/bW+c2MkQplShg+gYBYCuTL7VIl9+PW5Zql986rHm
 01Zj0E4mjdkS3rJpeEfHakkk1q36ZQ8oMrVjaxj4mB0aphI2ycJPMkBjVaB6m7Qo1LI/iT
 T7/8rsmyZ05iPI1WhfSDxvhSPTSE8Dw=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-557-4ocpHA7zO3-cICqkXFXqtw-1; Wed, 21 Sep 2022 22:43:34 -0400
X-MC-Unique: 4ocpHA7zO3-cICqkXFXqtw-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com
 [10.11.54.7])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 52A52855304;
 Thu, 22 Sep 2022 02:43:34 +0000 (UTC)
Received: from localhost.localdomain (ovpn-13-82.pek2.redhat.com [10.72.13.82])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 499AC140EBF3;
 Thu, 22 Sep 2022 02:43:28 +0000 (UTC)
From: Jason Wang <jasowang@redhat.com>
To: mst@redhat.com,
	jasowang@redhat.com
Subject: [PATCH V2 2/3] vdpa_sim_net: support feature provisioning
Date: Thu, 22 Sep 2022 10:43:04 +0800
Message-Id: <20220922024305.1718-3-jasowang@redhat.com>
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

This patch implements features provisioning for vdpa_sim_net.

1) validating the provisioned features to be a subset of the parent
   features.
2) clearing the features that is not wanted by the userspace

For example:

# vdpa mgmtdev show
vdpasim_net:
  supported_classes net
  max_supported_vqs 3
  dev_features MTU MAC CTRL_VQ CTRL_MAC_ADDR ANY_LAYOUT VERSION_1 ACCESS_PLATFORM

1) provision vDPA device with all features that are supported by the
   net simulator

# vdpa dev add name dev1 mgmtdev vdpasim_net
# vdpa dev config show
dev1: mac 00:00:00:00:00:00 link up link_announce false mtu 1500
  negotiated_features MTU MAC CTRL_VQ CTRL_MAC_ADDR VERSION_1 ACCESS_PLATFORM

2) provision vDPA device with a subset of the features

# vdpa dev add name dev1 mgmtdev vdpasim_net device_features 0x300020000
# vdpa dev config show
dev1: mac 00:00:00:00:00:00 link up link_announce false mtu 1500
  negotiated_features CTRL_VQ VERSION_1 ACCESS_PLATFORM

Reviewed-by: Eli Cohen <elic@nvidia.com>
Signed-off-by: Jason Wang <jasowang@redhat.com>
---
 drivers/vdpa/vdpa_sim/vdpa_sim_net.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/drivers/vdpa/vdpa_sim/vdpa_sim_net.c b/drivers/vdpa/vdpa_sim/vdpa_sim_net.c
index 886449e88502..a9ba02be378b 100644
--- a/drivers/vdpa/vdpa_sim/vdpa_sim_net.c
+++ b/drivers/vdpa/vdpa_sim/vdpa_sim_net.c
@@ -254,6 +254,14 @@ static int vdpasim_net_dev_add(struct vdpa_mgmt_dev *mdev, const char *name,
 	dev_attr.work_fn = vdpasim_net_work;
 	dev_attr.buffer_size = PAGE_SIZE;
 
+	if (config->mask & BIT_ULL(VDPA_ATTR_DEV_FEATURES)) {
+		if (config->device_features &
+		    ~dev_attr.supported_features)
+			return -EINVAL;
+		dev_attr.supported_features &=
+			 config->device_features;
+	}
+
 	simdev = vdpasim_create(&dev_attr);
 	if (IS_ERR(simdev))
 		return PTR_ERR(simdev);
@@ -294,7 +302,8 @@ static struct vdpa_mgmt_dev mgmt_dev = {
 	.id_table = id_table,
 	.ops = &vdpasim_net_mgmtdev_ops,
 	.config_attr_mask = (1 << VDPA_ATTR_DEV_NET_CFG_MACADDR |
-			     1 << VDPA_ATTR_DEV_NET_CFG_MTU),
+			     1 << VDPA_ATTR_DEV_NET_CFG_MTU |
+		             1 << VDPA_ATTR_DEV_FEATURES),
 	.max_supported_vqs = VDPASIM_NET_VQ_NUM,
 	.supported_features = VDPASIM_NET_FEATURES,
 };
-- 
2.25.1

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
