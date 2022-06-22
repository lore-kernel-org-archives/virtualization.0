Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 94BCEC43334
	for <virtualization@archiver.kernel.org>; Wed, 22 Jun 2022 15:14:18 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 34F098417A;
	Wed, 22 Jun 2022 15:14:18 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 34F098417A
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=RoWCMe4N
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id zs1Guhju7u2R; Wed, 22 Jun 2022 15:14:17 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id A181D8413A;
	Wed, 22 Jun 2022 15:14:16 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org A181D8413A
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 65719C0032;
	Wed, 22 Jun 2022 15:14:16 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 826E8C002D
 for <virtualization@lists.linux-foundation.org>;
 Wed, 22 Jun 2022 15:14:15 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 65EE340C2B
 for <virtualization@lists.linux-foundation.org>;
 Wed, 22 Jun 2022 15:14:15 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 65EE340C2B
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=RoWCMe4N
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id v3JYqv4I7DBG
 for <virtualization@lists.linux-foundation.org>;
 Wed, 22 Jun 2022 15:14:14 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 9BA0340012
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 9BA0340012
 for <virtualization@lists.linux-foundation.org>;
 Wed, 22 Jun 2022 15:14:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1655910853;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=wGPNK+3CbuAdTkTsB3EwZQ5iFbUOR/MKa+csfzqSuVU=;
 b=RoWCMe4N5twKBNu23mPODG2UvY9tjXWht22JhXOzDCuuKalvhbZ7ddsKxBsRFQmg+bGm+h
 QqxpNjx1KgvTwt+9+qF1CjcU6wT541QcCa+3cD4F3qlI9boY1GWBiC0fsPrcglKAoRmbhz
 BfzseiJtTomWPt/p6XGe/+XOycY/lQo=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-354-eZsERVc-MNufXEe9nKI5_w-1; Wed, 22 Jun 2022 11:14:11 -0400
X-MC-Unique: eZsERVc-MNufXEe9nKI5_w-1
Received: by mail-wm1-f71.google.com with SMTP id
 j31-20020a05600c1c1f00b0039c481c4664so5667838wms.7
 for <virtualization@lists.linux-foundation.org>;
 Wed, 22 Jun 2022 08:14:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=wGPNK+3CbuAdTkTsB3EwZQ5iFbUOR/MKa+csfzqSuVU=;
 b=EHlCX3e1RXnHUfhi1Ol1wg/zIGyMZkBpzMA8MapDaa1j3PAM0jAys8djDoRienyOxg
 cPfs9+fZ/1+tivZheqpVhzbMKaTlpWukb5GcxQdgqywrHgOfGpFeXJK7nHIJMiBkx1Fm
 MT5dfS2sRQWqjFy7rPid7kErnZdKTP3dKyoFi8N13Z+m4IlDGoeAIDozOOecJeXUytKp
 jcHYLX+iocUN13MNbocULeplE3gO16FR3vMGjIJnSl7BgKTdFITSOTnsI3yOibUxUS6j
 xNghTKxTDHtB3EUy8FUpYXdHmaVK13JJ2ZurvL/P00xYurPJ9ea3ricZey7XbRDnoUG+
 ZvQw==
X-Gm-Message-State: AOAM530pkR/E5DRQus/hm4ZkANICRdaPuGshe6mHUISGZySQ8sUYbXxD
 qCM0eKOhYaHFa7JgDU5UEbFj7C40kUceoWCX+nb/CvpvVHfHSgEyeENwmmMOICyhrwUF2Ub4u/w
 mq3b/RGpmwgxasFIHjIoBRhByIIvMDx5z2tnJN7SL6Qc3pJpuYiOk6WDqZDJ7AOxqucdnap9JJi
 1FmtFnzMR50x/FH9yKWQ==
X-Received: by 2002:a05:600c:3508:b0:39c:8240:5538 with SMTP id
 h8-20020a05600c350800b0039c82405538mr46419587wmq.165.1655910849771; 
 Wed, 22 Jun 2022 08:14:09 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzEzFT4TFaMqQR0Ghk5VXNDtqjANOX/reNQn5bceF+MCQwu4Q10ypxVnyl4WOcDbkKlljFl6w==
X-Received: by 2002:a05:600c:3508:b0:39c:8240:5538 with SMTP id
 h8-20020a05600c350800b0039c82405538mr46419547wmq.165.1655910849466; 
 Wed, 22 Jun 2022 08:14:09 -0700 (PDT)
Received: from step1.redhat.com (host-79-46-200-40.retail.telecomitalia.it.
 [79.46.200.40]) by smtp.gmail.com with ESMTPSA id
 z6-20020a7bc7c6000000b0039c63f4bce0sm25194613wmk.12.2022.06.22.08.14.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 22 Jun 2022 08:14:08 -0700 (PDT)
From: Stefano Garzarella <sgarzare@redhat.com>
To: virtualization@lists.linux-foundation.org
Subject: [PATCH] vhost-vdpa: call vhost_vdpa_cleanup during the release
Date: Wed, 22 Jun 2022 17:14:07 +0200
Message-Id: <20220622151407.51232-1-sgarzare@redhat.com>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=sgarzare@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: kvm@vger.kernel.org, "Michael S. Tsirkin" <mst@redhat.com>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 =?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>,
 Gautam Dawar <gautam.dawar@xilinx.com>
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

Before commit 3d5698793897 ("vhost-vdpa: introduce asid based IOTLB")
we call vhost_vdpa_iotlb_free() during the release to clean all regions
mapped in the iotlb.

That commit removed vhost_vdpa_iotlb_free() and added vhost_vdpa_cleanup()
to do some cleanup, including deleting all mappings, but we forgot to call
it in vhost_vdpa_release().

This causes that if an application does not remove all mappings explicitly
(or it crashes), the mappings remain in the iotlb and subsequent
applications may fail if they map the same addresses.

Calling vhost_vdpa_cleanup() also fixes a memory leak since we are not
freeing `v->vdev.vqs` during the release from the same commit.

Since vhost_vdpa_cleanup() calls vhost_dev_cleanup() we can remove its
call from vhost_vdpa_release().

Fixes: 3d5698793897 ("vhost-vdpa: introduce asid based IOTLB")
Cc: gautam.dawar@xilinx.com
Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
---
 drivers/vhost/vdpa.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/vhost/vdpa.c b/drivers/vhost/vdpa.c
index 5ad2596c6e8a..23dcbfdfa13b 100644
--- a/drivers/vhost/vdpa.c
+++ b/drivers/vhost/vdpa.c
@@ -1209,7 +1209,7 @@ static int vhost_vdpa_release(struct inode *inode, struct file *filep)
 	vhost_dev_stop(&v->vdev);
 	vhost_vdpa_free_domain(v);
 	vhost_vdpa_config_put(v);
-	vhost_dev_cleanup(&v->vdev);
+	vhost_vdpa_cleanup(v);
 	mutex_unlock(&d->mutex);
 
 	atomic_dec(&v->opened);
-- 
2.36.1

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
