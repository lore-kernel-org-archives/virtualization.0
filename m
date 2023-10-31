Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 13142C4332F
	for <virtualization@archiver.kernel.org>; Tue, 31 Oct 2023 16:20:10 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 8DC8D41909;
	Tue, 31 Oct 2023 16:20:10 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 8DC8D41909
Authentication-Results: smtp2.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=HKkUTsqo
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id E5EKs-_AXCgQ; Tue, 31 Oct 2023 16:20:09 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id A4DFB418DC;
	Tue, 31 Oct 2023 16:20:08 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org A4DFB418DC
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 56B0CC0039;
	Tue, 31 Oct 2023 16:20:08 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id B1FAEC0032
 for <virtualization@lists.linux-foundation.org>;
 Tue, 31 Oct 2023 16:20:06 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 7F175418DC
 for <virtualization@lists.linux-foundation.org>;
 Tue, 31 Oct 2023 16:20:06 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 7F175418DC
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id msGfznjcrzcz
 for <virtualization@lists.linux-foundation.org>;
 Tue, 31 Oct 2023 16:20:05 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 6D02F418DD
 for <virtualization@lists.linux-foundation.org>;
 Tue, 31 Oct 2023 16:20:05 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 6D02F418DD
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1698769204;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
 bh=9vLLa3ZDoGKvMI4Q2cPPmXzBmtdoj810TCBQHEKpzcg=;
 b=HKkUTsqoAJtJJsZVhkG8iQ3hgCky3vE0YCGes2/0oSwght4UKcMrj2btMpCfNY6w8AeQSu
 BRvUn45WMUdwrjk1JiqHKroOZUUqHxYbjq+S1f8C+++nLj97JfqjfZbFgr3UdDzUW2vt8A
 20AW4nmIRsNQrELoJM3dTvILWso5eqI=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-473-GQEphMrOPriR3jI-wthrEA-1; Tue, 31 Oct 2023 12:20:01 -0400
X-MC-Unique: GQEphMrOPriR3jI-wthrEA-1
Received: by mail-ej1-f70.google.com with SMTP id
 a640c23a62f3a-99c8bbc902eso407073766b.1
 for <virtualization@lists.linux-foundation.org>;
 Tue, 31 Oct 2023 09:20:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698769199; x=1699373999;
 h=content-disposition:mime-version:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=9vLLa3ZDoGKvMI4Q2cPPmXzBmtdoj810TCBQHEKpzcg=;
 b=H3FtDw7s+FBqWfQoPv3mBBXa1Gsozpz65pahLT3l8Og/3H+cqp6Nuz0OLTnJ3v7/XZ
 WGmKKxaJSHhvh+H0KO2p78Zw/oM1N2lHX8rDAZ7ZL5L+lZ3IfcuQhgYuAKESm2z8Vyqn
 s77AGl8hkT7zhzfg8pOHwaixAzcSHe7hsFd59pybMwkHBKgCP5BkMiPnAROOYswkSASA
 kPEKDCLHpNsISEqIIQx+zi/qegpqNktGDbs8jiqM3dJPHkVvnCpReyB3vcBoyszLgBlp
 FDnZw+pJ9JVeIZa0q2jGf1TZHNIpG/0B4GT1+U/z9uC/VzShIAsvwREao5ElQlhGVe+M
 I7zA==
X-Gm-Message-State: AOJu0YxHwLmKiLE1mVxC/mbCKtE6yaNOkJCu4IAnsYpjGgdxtZItYxau
 8N5Ug9PAIZu8cVI0fd+Xm80RYUsmzk0usavIVAo+C9t7a+Xu8FzUt3MpYGiwwYDQgcgH0RB63qM
 XiJu++T0Sfw7MDDCuhcGA8XuW4yO4agGkgoH58hfRww==
X-Received: by 2002:a17:907:944e:b0:9bf:2bf:65f3 with SMTP id
 dl14-20020a170907944e00b009bf02bf65f3mr11554568ejc.7.1698769199662; 
 Tue, 31 Oct 2023 09:19:59 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF9Uml7tqNWi/g3OFNU0ZTpYp3zZEOt77dL9nlhkY9Roe9vB+ogV3dpvxgs1FQIIvYiEvUkMQ==
X-Received: by 2002:a17:907:944e:b0:9bf:2bf:65f3 with SMTP id
 dl14-20020a170907944e00b009bf02bf65f3mr11554554ejc.7.1698769199351; 
 Tue, 31 Oct 2023 09:19:59 -0700 (PDT)
Received: from redhat.com ([2a02:14f:173:14b6:b6f1:4797:8f5d:fa41])
 by smtp.gmail.com with ESMTPSA id
 i1-20020a1709064ec100b009d2eb40ff9dsm1198573ejv.33.2023.10.31.09.19.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 31 Oct 2023 09:19:58 -0700 (PDT)
Date: Tue, 31 Oct 2023 12:19:54 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: linux-kernel@vger.kernel.org
Subject: [PATCH] virtio_pci: move structure to a header
Message-ID: <110d3058179284b092722827bef4f74f8ba0c622.1698769192.git.mst@redhat.com>
MIME-Version: 1.0
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
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

These are guest/host interfaces so belong in the header
where e.g. qemu will know to find them.
Note: we added a new structure as opposed to extending existing one
because someone might be relying on the size of the existing structure
staying unchanged.  Add a warning to avoid using sizeof.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 drivers/virtio/virtio_pci_modern_dev.c |  7 ++++---
 include/linux/virtio_pci_modern.h      |  7 -------
 include/uapi/linux/virtio_pci.h        | 11 +++++++++++
 3 files changed, 15 insertions(+), 10 deletions(-)

diff --git a/drivers/virtio/virtio_pci_modern_dev.c b/drivers/virtio/virtio_pci_modern_dev.c
index e2a1fe7bb66c..7de8b1ebabac 100644
--- a/drivers/virtio/virtio_pci_modern_dev.c
+++ b/drivers/virtio/virtio_pci_modern_dev.c
@@ -294,9 +294,10 @@ int vp_modern_probe(struct virtio_pci_modern_device *mdev)
 
 	err = -EINVAL;
 	mdev->common = vp_modern_map_capability(mdev, common,
-				      sizeof(struct virtio_pci_common_cfg), 4,
-				      0, sizeof(struct virtio_pci_modern_common_cfg),
-				      &mdev->common_len, NULL);
+			      sizeof(struct virtio_pci_common_cfg), 4, 0,
+			      offsetofend(struct virtio_pci_modern_common_cfg,
+					  queue_reset),
+			      &mdev->common_len, NULL);
 	if (!mdev->common)
 		goto err_map_common;
 	mdev->isr = vp_modern_map_capability(mdev, isr, sizeof(u8), 1,
diff --git a/include/linux/virtio_pci_modern.h b/include/linux/virtio_pci_modern.h
index d0f2797420f7..a09e13a577a9 100644
--- a/include/linux/virtio_pci_modern.h
+++ b/include/linux/virtio_pci_modern.h
@@ -5,13 +5,6 @@
 #include <linux/pci.h>
 #include <linux/virtio_pci.h>
 
-struct virtio_pci_modern_common_cfg {
-	struct virtio_pci_common_cfg cfg;
-
-	__le16 queue_notify_data;	/* read-write */
-	__le16 queue_reset;		/* read-write */
-};
-
 /**
  * struct virtio_pci_modern_device - info for modern PCI virtio
  * @pci_dev:	    Ptr to the PCI device struct
diff --git a/include/uapi/linux/virtio_pci.h b/include/uapi/linux/virtio_pci.h
index f703afc7ad31..44f4dd2add18 100644
--- a/include/uapi/linux/virtio_pci.h
+++ b/include/uapi/linux/virtio_pci.h
@@ -166,6 +166,17 @@ struct virtio_pci_common_cfg {
 	__le32 queue_used_hi;		/* read-write */
 };
 
+/*
+ * Warning: do not use sizeof on this: use offsetofend for
+ * specific fields you need.
+ */
+struct virtio_pci_modern_common_cfg {
+	struct virtio_pci_common_cfg cfg;
+
+	__le16 queue_notify_data;	/* read-write */
+	__le16 queue_reset;		/* read-write */
+};
+
 /* Fields in VIRTIO_PCI_CAP_PCI_CFG: */
 struct virtio_pci_cfg_cap {
 	struct virtio_pci_cap cap;
-- 
MST

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
