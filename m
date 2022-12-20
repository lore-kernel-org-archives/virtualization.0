Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CCE23C4332F
	for <virtualization@archiver.kernel.org>; Tue, 20 Dec 2022 11:24:00 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 535CF400D9;
	Tue, 20 Dec 2022 11:24:00 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 535CF400D9
Authentication-Results: smtp2.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=Vc0RNxdo
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id z38YlqWcKPar; Tue, 20 Dec 2022 11:23:59 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id C137F40198;
	Tue, 20 Dec 2022 11:23:58 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org C137F40198
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 7F86AC0032;
	Tue, 20 Dec 2022 11:23:58 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 0D178C002D
 for <virtualization@lists.linux-foundation.org>;
 Tue, 20 Dec 2022 11:23:56 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 96E4D41602
 for <virtualization@lists.linux-foundation.org>;
 Tue, 20 Dec 2022 11:23:56 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 96E4D41602
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=Vc0RNxdo
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id fjGLj_oyFbld
 for <virtualization@lists.linux-foundation.org>;
 Tue, 20 Dec 2022 11:23:53 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 6FC44415C9
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 6FC44415C9
 for <virtualization@lists.linux-foundation.org>;
 Tue, 20 Dec 2022 11:23:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1671535432;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
 bh=duDj4IDqPGRqUxwsqTLICchzA0MOp+dg3mI/1yy26NU=;
 b=Vc0RNxdolc8/3tBeJL9v+86U54s9le3QtQMqhfTUg8xG85C7UGVufKbxflvKPzfgh3SX65
 Zv38CBV6NnvhOu8dIMCBddXxoxsrtJ5XlvjLHdpVs9ODBqaQuwN08xRkWfAAMOYQJQ96K1
 J0/cAi6eZ08iY203FvvPXvZ+u8k/ce0=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-3--6bhDboqMF-KI4sKEyDgEA-1; Tue, 20 Dec 2022 06:23:50 -0500
X-MC-Unique: -6bhDboqMF-KI4sKEyDgEA-1
Received: by mail-qk1-f197.google.com with SMTP id
 s7-20020a05620a0bc700b006fcb1a3bb9dso9147424qki.15
 for <virtualization@lists.linux-foundation.org>;
 Tue, 20 Dec 2022 03:23:50 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=content-disposition:mime-version:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=duDj4IDqPGRqUxwsqTLICchzA0MOp+dg3mI/1yy26NU=;
 b=GVf+VfkqYhfR/IMakF6FRMu2J4KCHv84/fOYZFDa6eEWoj6YNHdgRV69e0LB/gqPt/
 tNCgo9dBwAshQ6aaShrio/U0eQ4LjAk+07KF9I0TPRiTO8+gO1LxhNZ80WlpCgoFIwGf
 uTNKSWnbzPJQaPv6BxIU7nPmbojWjZvbydfw0YeImIL2l3gJLBdh8uuSj11xfK/RpX1e
 MeTMS0+fj1LRTpm0HX/y+Fp4tQX6iAJ6c77WVtLwcpk9k7w5Ts2THaK+PRB/wmCpBiBp
 lEHEBojXhs3BapOOzQ3tCMGRAzVQLORfn+tfHcHHr3oeBDNfQSYir9mJdmKVfbhmhsKl
 3YrQ==
X-Gm-Message-State: ANoB5pnAVfmQhW/5VfIBE9OXMV1UNpR541cwkOJEcU8/el9MNUYuORzo
 6yhj73jvv1XinW8bf7lHH5wePf5qbof4FQJ17AmOV1WosPrIK6eU8p9l7cprncM+3wzib3v0IRJ
 ZrhhKz6drjmXdiv3Ck0UWD7V0xwAxtk3YI9c48ZqRpg==
X-Received: by 2002:a05:622a:248c:b0:39c:da20:f700 with SMTP id
 cn12-20020a05622a248c00b0039cda20f700mr61864401qtb.36.1671535430243; 
 Tue, 20 Dec 2022 03:23:50 -0800 (PST)
X-Google-Smtp-Source: AA0mqf4bP41rEY68a1GRVkDxLGY+6MlclsHX3KN6pGPekhSNI+eQBndsuGUO2k0JwSQpg38SoIdbVg==
X-Received: by 2002:a05:622a:248c:b0:39c:da20:f700 with SMTP id
 cn12-20020a05622a248c00b0039cda20f700mr61864385qtb.36.1671535429995; 
 Tue, 20 Dec 2022 03:23:49 -0800 (PST)
Received: from redhat.com ([37.19.199.118]) by smtp.gmail.com with ESMTPSA id
 w8-20020a05620a444800b006fc92cf4703sm8722506qkp.132.2022.12.20.03.23.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 20 Dec 2022 03:23:49 -0800 (PST)
Date: Tue, 20 Dec 2022 06:23:44 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: linux-kernel@vger.kernel.org
Subject: [PATCH] virtio-blk: fix probe without CONFIG_BLK_DEV_ZONED
Message-ID: <20221220112340.518841-1-mst@redhat.com>
MIME-Version: 1.0
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: Jens Axboe <axboe@kernel.dk>, Anders Roxell <anders.roxell@linaro.org>,
 virtualization@lists.linux-foundation.org, linux-block@vger.kernel.org,
 Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
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

When building without CONFIG_BLK_DEV_ZONED, VIRTIO_BLK_F_ZONED
is excluded from array of driver features.
As a result virtio_has_feature panics in virtio_check_driver_offered_feature
since that by design verifies that a feature we are checking for
is listed in the feature array.

To fix, replace the call to virtio_has_feature with a stub.

Tested-by: Anders Roxell <anders.roxell@linaro.org>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 drivers/block/virtio_blk.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/drivers/block/virtio_blk.c b/drivers/block/virtio_blk.c
index 88b3639f8536..5ea1dc882a80 100644
--- a/drivers/block/virtio_blk.c
+++ b/drivers/block/virtio_blk.c
@@ -760,6 +760,10 @@ static int virtblk_probe_zoned_device(struct virtio_device *vdev,
 	return ret;
 }
 
+static inline bool virtblk_has_zoned_feature(struct virtio_device *vdev)
+{
+	return virtio_has_feature(vdev, VIRTIO_BLK_F_ZONED);
+}
 #else
 
 /*
@@ -775,6 +779,11 @@ static inline int virtblk_probe_zoned_device(struct virtio_device *vdev,
 {
 	return -EOPNOTSUPP;
 }
+
+static inline bool virtblk_has_zoned_feature(struct virtio_device *vdev)
+{
+	return false;
+}
 #endif /* CONFIG_BLK_DEV_ZONED */
 
 /* return id (s/n) string for *disk to *id_str
@@ -1480,7 +1489,7 @@ static int virtblk_probe(struct virtio_device *vdev)
 	virtblk_update_capacity(vblk, false);
 	virtio_device_ready(vdev);
 
-	if (virtio_has_feature(vdev, VIRTIO_BLK_F_ZONED)) {
+	if (virtblk_has_zoned_feature(vdev)) {
 		err = virtblk_probe_zoned_device(vdev, vblk, q);
 		if (err)
 			goto out_cleanup_disk;
-- 
MST

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
