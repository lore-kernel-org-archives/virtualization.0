Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8AF90C433EF
	for <virtualization@archiver.kernel.org>; Tue, 21 Jun 2022 15:12:22 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 2C733830B8;
	Tue, 21 Jun 2022 15:12:22 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 2C733830B8
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=XtGlzDiQ
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id djLQtpa50BTp; Tue, 21 Jun 2022 15:12:21 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id A40A1829FE;
	Tue, 21 Jun 2022 15:12:20 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org A40A1829FE
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 83178C0039;
	Tue, 21 Jun 2022 15:12:20 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 7C469C002D
 for <virtualization@lists.linux-foundation.org>;
 Tue, 21 Jun 2022 15:12:19 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 52CED4109F
 for <virtualization@lists.linux-foundation.org>;
 Tue, 21 Jun 2022 15:12:19 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 52CED4109F
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=XtGlzDiQ
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id jkEYLsDFBCa8
 for <virtualization@lists.linux-foundation.org>;
 Tue, 21 Jun 2022 15:12:18 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org D28CF40A03
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id D28CF40A03
 for <virtualization@lists.linux-foundation.org>;
 Tue, 21 Jun 2022 15:12:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1655824336;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=+Yc3piLjSOYJf8KyxbSuOZbWnM7+vW6XohmDJSSJEHM=;
 b=XtGlzDiQd1TzOCFcJLtVQvalt7BOy2/AXzOeajCA7Jjj3lUPIArVTaUJ1+sV8u0agJaPEt
 sVU6kpCISnZPd44p9szmQEuFls0WX9tWB0X4VEXFY8wslKSZxb/72Smtzyv3LCB5qBJIOP
 5593splhs4rIXN4NQ0ybdt2B5hy1AM4=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-42-gpRSX1OuPdScZK7zx2lChA-1; Tue, 21 Jun 2022 11:12:15 -0400
X-MC-Unique: gpRSX1OuPdScZK7zx2lChA-1
Received: by mail-qk1-f200.google.com with SMTP id
 bl27-20020a05620a1a9b00b0069994eeb30cso16695154qkb.11
 for <virtualization@lists.linux-foundation.org>;
 Tue, 21 Jun 2022 08:12:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=+Yc3piLjSOYJf8KyxbSuOZbWnM7+vW6XohmDJSSJEHM=;
 b=KukMmGaJcftyvyhmXNTq8UW2HlM49G5vOE/EmkL7B2j1ZiKIOTJO9K9FQYCcF4c/YR
 /T5AYau7j1kMqsd5hCVJdqUNvHcdpukTYFZMGnJgQPlXIVV+se+0FMnBPDvzWUIdtMFL
 qTln/gjaaIFADTrG7k7ELe9Qf2MgJdQxqgoUoUDQSqJIVdkz13xRTF1MvKFNhxcMxsW1
 bjxeueMt17S6Bpg3hzjPvKTKaPvNYhAhPi3DyZod7wKI03lIvard+uE7AJV9QLoe6wSa
 W50ZcXdKTFKrDE2ysS1+UFzUSJgiIElL8Y5UB2O3R0HIAfZiYPh4qrfnBY3jQdMDygjM
 QNUw==
X-Gm-Message-State: AJIora+0BGjTp3Mp0cTM/aIzY2JIZsoUxqM5E1SDwxYRwbC5hiSspbRq
 AfjPYtoHFKn4tTNCDROnWWSBZf8NoiGb3whTLgg184qCrT/C0YfPhYseSbYlUw6ty0ehseQ52uz
 eXcqs0ci+ZvNrJI/ogxKhfjKyI7HegEYxiuhSw75AmsdTKwNdaE76tCuRs9cZrIIJe+zhYOwbEG
 meZaB0uiRRgJ35RxAr1Q==
X-Received: by 2002:a05:620a:2793:b0:6a7:44f0:c280 with SMTP id
 g19-20020a05620a279300b006a744f0c280mr20349739qkp.53.1655824333757; 
 Tue, 21 Jun 2022 08:12:13 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1uOo3vKWCa+TRKaTNYxloZSJewJ8mn+JceU1HnjH0/Zgr1kX0gDJMovGRyMPqtz+VsNgoSTNQ==
X-Received: by 2002:a05:620a:2793:b0:6a7:44f0:c280 with SMTP id
 g19-20020a05620a279300b006a744f0c280mr20349695qkp.53.1655824333313; 
 Tue, 21 Jun 2022 08:12:13 -0700 (PDT)
Received: from step1.redhat.com (host-79-46-200-40.retail.telecomitalia.it.
 [79.46.200.40]) by smtp.gmail.com with ESMTPSA id
 u11-20020a05620a454b00b006a74da327fcsm14778324qkp.99.2022.06.21.08.12.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 21 Jun 2022 08:12:12 -0700 (PDT)
From: Stefano Garzarella <sgarzare@redhat.com>
To: virtualization@lists.linux-foundation.org
Subject: [PATCH] vdpa_sim: use max_iotlb_entries as a limit in vhost_iotlb_init
Date: Tue, 21 Jun 2022 17:12:08 +0200
Message-Id: <20220621151208.189959-1-sgarzare@redhat.com>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=sgarzare@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: Gautam Dawar <gautam.dawar@xilinx.com>, linux-kernel@vger.kernel.org,
 "Michael S. Tsirkin" <mst@redhat.com>
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

Commit bda324fd037a ("vdpasim: control virtqueue support") changed
the allocation of iotlbs calling vhost_iotlb_init() for each address
space, instead of vhost_iotlb_alloc().

With this change we forgot to use the limit we had introduced with
the `max_iotlb_entries` module parameter.

Fixes: bda324fd037a ("vdpasim: control virtqueue support")
Cc: gautam.dawar@xilinx.com
Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
---
 drivers/vdpa/vdpa_sim/vdpa_sim.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/vdpa/vdpa_sim/vdpa_sim.c b/drivers/vdpa/vdpa_sim/vdpa_sim.c
index 0f2865899647..3e81532c01cb 100644
--- a/drivers/vdpa/vdpa_sim/vdpa_sim.c
+++ b/drivers/vdpa/vdpa_sim/vdpa_sim.c
@@ -33,7 +33,7 @@ MODULE_PARM_DESC(batch_mapping, "Batched mapping 1 -Enable; 0 - Disable");
 static int max_iotlb_entries = 2048;
 module_param(max_iotlb_entries, int, 0444);
 MODULE_PARM_DESC(max_iotlb_entries,
-		 "Maximum number of iotlb entries. 0 means unlimited. (default: 2048)");
+		 "Maximum number of iotlb entries for each address space. 0 means unlimited. (default: 2048)");
 
 #define VDPASIM_QUEUE_ALIGN PAGE_SIZE
 #define VDPASIM_QUEUE_MAX 256
@@ -291,7 +291,7 @@ struct vdpasim *vdpasim_create(struct vdpasim_dev_attr *dev_attr)
 		goto err_iommu;
 
 	for (i = 0; i < vdpasim->dev_attr.nas; i++)
-		vhost_iotlb_init(&vdpasim->iommu[i], 0, 0);
+		vhost_iotlb_init(&vdpasim->iommu[i], max_iotlb_entries, 0);
 
 	vdpasim->buffer = kvmalloc(dev_attr->buffer_size, GFP_KERNEL);
 	if (!vdpasim->buffer)
-- 
2.36.1

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
