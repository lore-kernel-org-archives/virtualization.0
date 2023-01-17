Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C31B0C63797
	for <virtualization@archiver.kernel.org>; Tue, 17 Jan 2023 15:16:39 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 52B40416A9;
	Tue, 17 Jan 2023 15:16:39 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 52B40416A9
Authentication-Results: smtp4.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=NOUkbYh4
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 3Dzi65K2j_lU; Tue, 17 Jan 2023 15:16:38 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 5A4FC4173A;
	Tue, 17 Jan 2023 15:16:37 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 5A4FC4173A
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 35440C0032;
	Tue, 17 Jan 2023 15:16:37 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 5D2EAC002D
 for <virtualization@lists.linux-foundation.org>;
 Tue, 17 Jan 2023 15:16:35 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 4572D405D7
 for <virtualization@lists.linux-foundation.org>;
 Tue, 17 Jan 2023 15:16:35 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 4572D405D7
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=NOUkbYh4
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id XDIAPfLp5NOR
 for <virtualization@lists.linux-foundation.org>;
 Tue, 17 Jan 2023 15:16:34 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 942AF405B8
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 942AF405B8
 for <virtualization@lists.linux-foundation.org>;
 Tue, 17 Jan 2023 15:16:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1673968593;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=fw/nFMgEKd6/JOs4Bo38UV7NzYCcuP0Qle+XYJWZ2qI=;
 b=NOUkbYh42556d+LZ8lB9ncQqF68p0IAHdtEQXsg7gwBth4jiS9G9KobCaGDVum5fHSV1eD
 EO/I3tOXurgQf4JS6Qrcfa1d9ub8/Phe/VksT7UgpcAzLery3KtU10RQ/cg2O3T7gcTl9o
 W0HIGOJ1dQBhKzoECYZ+eYmRAL3uvjg=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-663-XilJkniLMZW6SrZ_Dud_eA-1; Tue, 17 Jan 2023 10:16:32 -0500
X-MC-Unique: XilJkniLMZW6SrZ_Dud_eA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com
 [10.11.54.2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 7B6723814968;
 Tue, 17 Jan 2023 15:15:22 +0000 (UTC)
Received: from qualcomm-amberwing-rep-06.khw4.lab.eng.bos.redhat.com
 (qualcomm-amberwing-rep-06.khw4.lab.eng.bos.redhat.com [10.19.240.11])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 317F44078904;
 Tue, 17 Jan 2023 15:15:22 +0000 (UTC)
From: Eric Auger <eric.auger@redhat.com>
To: eric.auger.pro@gmail.com, eric.auger@redhat.com, mst@redhat.com,
 jasowang@redhat.com, kvm@vger.kernel.org, netdev@vger.kernel.org,
 virtualization@lists.linux-foundation.org
Subject: [PATCH 1/2] vhost: Remove the enabled parameter from
 vhost_init_device_iotlb
Date: Tue, 17 Jan 2023 10:15:17 -0500
Message-Id: <20230117151518.44725-2-eric.auger@redhat.com>
In-Reply-To: <20230117151518.44725-1-eric.auger@redhat.com>
References: <20230117151518.44725-1-eric.auger@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.2
Cc: lvivier@redhat.com
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

The 'enabled' parameter is not used by the function. Remove it.

Signed-off-by: Eric Auger <eric.auger@redhat.com>
Reported-by: Michael S. Tsirkin <mst@redhat.com>
---
 drivers/vhost/net.c   | 2 +-
 drivers/vhost/vhost.c | 2 +-
 drivers/vhost/vhost.h | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/vhost/net.c b/drivers/vhost/net.c
index 9af19b0cf3b7..135e23254a26 100644
--- a/drivers/vhost/net.c
+++ b/drivers/vhost/net.c
@@ -1642,7 +1642,7 @@ static int vhost_net_set_features(struct vhost_net *n, u64 features)
 		goto out_unlock;
 
 	if ((features & (1ULL << VIRTIO_F_ACCESS_PLATFORM))) {
-		if (vhost_init_device_iotlb(&n->dev, true))
+		if (vhost_init_device_iotlb(&n->dev))
 			goto out_unlock;
 	}
 
diff --git a/drivers/vhost/vhost.c b/drivers/vhost/vhost.c
index cbe72bfd2f1f..34458e203716 100644
--- a/drivers/vhost/vhost.c
+++ b/drivers/vhost/vhost.c
@@ -1729,7 +1729,7 @@ long vhost_vring_ioctl(struct vhost_dev *d, unsigned int ioctl, void __user *arg
 }
 EXPORT_SYMBOL_GPL(vhost_vring_ioctl);
 
-int vhost_init_device_iotlb(struct vhost_dev *d, bool enabled)
+int vhost_init_device_iotlb(struct vhost_dev *d)
 {
 	struct vhost_iotlb *niotlb, *oiotlb;
 	int i;
diff --git a/drivers/vhost/vhost.h b/drivers/vhost/vhost.h
index d9109107af08..4bfa10e52297 100644
--- a/drivers/vhost/vhost.h
+++ b/drivers/vhost/vhost.h
@@ -221,7 +221,7 @@ ssize_t vhost_chr_read_iter(struct vhost_dev *dev, struct iov_iter *to,
 			    int noblock);
 ssize_t vhost_chr_write_iter(struct vhost_dev *dev,
 			     struct iov_iter *from);
-int vhost_init_device_iotlb(struct vhost_dev *d, bool enabled);
+int vhost_init_device_iotlb(struct vhost_dev *d);
 
 void vhost_iotlb_map_free(struct vhost_iotlb *iotlb,
 			  struct vhost_iotlb_map *map);
-- 
2.31.1

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
