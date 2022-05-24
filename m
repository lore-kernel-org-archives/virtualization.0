Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E4D15C433F5
	for <virtualization@archiver.kernel.org>; Tue, 24 May 2022 05:56:17 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 5E6C3419A2;
	Tue, 24 May 2022 05:56:17 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id iyb181jLQn-1; Tue, 24 May 2022 05:56:16 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id BDC12419EC;
	Tue, 24 May 2022 05:56:15 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 74C3FC0032;
	Tue, 24 May 2022 05:56:15 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 71F6DC002D
 for <virtualization@lists.linux-foundation.org>;
 Tue, 24 May 2022 05:56:13 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 4BE2083323
 for <virtualization@lists.linux-foundation.org>;
 Tue, 24 May 2022 05:56:13 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id zgewZCtFXNb8
 for <virtualization@lists.linux-foundation.org>;
 Tue, 24 May 2022 05:56:12 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 6FDDF82EF1
 for <virtualization@lists.linux-foundation.org>;
 Tue, 24 May 2022 05:56:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1653371771;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=tNuCs3myf8YTzjg6YEi6CfRCnRzJghoZRGG5TUri4wc=;
 b=C4gQeccxtCmAC06YlwJzPBcU26Qr/gFixF45s/09JmPIh9DMxkvz0yFHPKl6xTGQoGV+aX
 Jr3jFrpMQCMCoZdiaU1+LI1tgOEn42DZF1+We92pFrWvNc+IMS7QLtempDSnzk/uxpfpZ9
 t3IhV6sGtGYZn2xh+lTxiXwGern/jFI=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-360-byxo_TCoM-aBro8LqBX2aA-1; Tue, 24 May 2022 01:56:04 -0400
X-MC-Unique: byxo_TCoM-aBro8LqBX2aA-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com
 [10.11.54.1])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id DAAC0185A79C;
 Tue, 24 May 2022 05:56:03 +0000 (UTC)
Received: from localhost.localdomain (ovpn-12-128.pek2.redhat.com
 [10.72.12.128])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 040FC40E7F06;
 Tue, 24 May 2022 05:56:00 +0000 (UTC)
From: Jason Wang <jasowang@redhat.com>
To: mst@redhat.com,
	jasowang@redhat.com,
	lingshan.zhu@intel.com
Subject: [PATCH] vdpa: ifcvf: set pci driver data in probe
Date: Tue, 24 May 2022 13:55:57 +0800
Message-Id: <20220524055557.1938-1-jasowang@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.11.54.1
Cc: Zheyu Ma <zheyuma97@gmail.com>, linux-kernel@vger.kernel.org,
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

We should set the pci driver data in probe instead of the vdpa device
adding callback. Otherwise if no vDPA device is created we will lose
the pointer to the management device.

Fixes: 6b5df347c6482 ("vDPA/ifcvf: implement management netlink framework for ifcvf")
Tested-by: Zheyu Ma <zheyuma97@gmail.com>
Signed-off-by: Jason Wang <jasowang@redhat.com>
---
 drivers/vdpa/ifcvf/ifcvf_main.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/vdpa/ifcvf/ifcvf_main.c b/drivers/vdpa/ifcvf/ifcvf_main.c
index 750e5f23406d..0a5670729412 100644
--- a/drivers/vdpa/ifcvf/ifcvf_main.c
+++ b/drivers/vdpa/ifcvf/ifcvf_main.c
@@ -771,7 +771,6 @@ static int ifcvf_vdpa_dev_add(struct vdpa_mgmt_dev *mdev, const char *name,
 	}
 
 	ifcvf_mgmt_dev->adapter = adapter;
-	pci_set_drvdata(pdev, ifcvf_mgmt_dev);
 
 	vf = &adapter->vf;
 	vf->dev_type = get_dev_type(pdev);
@@ -886,6 +885,8 @@ static int ifcvf_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 		goto err;
 	}
 
+	pci_set_drvdata(pdev, ifcvf_mgmt_dev);
+
 	return 0;
 
 err:
-- 
2.25.1

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
