Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 49651C433F5
	for <virtualization@archiver.kernel.org>; Tue, 18 Jan 2022 17:03:53 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id D7ED681D4D;
	Tue, 18 Jan 2022 17:03:52 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id M9dNmAfJHG0k; Tue, 18 Jan 2022 17:03:52 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 63CE781D24;
	Tue, 18 Jan 2022 17:03:51 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 12BC5C0039;
	Tue, 18 Jan 2022 17:03:51 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 4D8EFC002F
 for <virtualization@lists.linux-foundation.org>;
 Tue, 18 Jan 2022 17:03:50 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 23CD481D3A
 for <virtualization@lists.linux-foundation.org>;
 Tue, 18 Jan 2022 17:03:50 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id jgrb4jBKS5Wj
 for <virtualization@lists.linux-foundation.org>;
 Tue, 18 Jan 2022 17:03:49 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id CCFF581D24
 for <virtualization@lists.linux-foundation.org>;
 Tue, 18 Jan 2022 17:03:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1642525427;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
 bh=xeHoR1Km3Ot/QwwgnNEtsDvDGwANoK5Acc9epKDxSQU=;
 b=Xpijj9Fn5Fr4+2bNwTB8g315xzQZG21M3KKrF3BAl0DVvR5vliAT9eMangZMF1CxW/mEhn
 dC2meVhuDo7OXwcB0W7QUg6genoVCYpo21lQ7k+D6YpH+4WErtqhRG167gRCyKGSdyOvsg
 C2nkwsNjXUmA28cspAryht5K3lG8JwA=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-248-MM8pISjrN5qyITE908OP0w-1; Tue, 18 Jan 2022 12:03:46 -0500
X-MC-Unique: MM8pISjrN5qyITE908OP0w-1
Received: by mail-ed1-f71.google.com with SMTP id
 el8-20020a056402360800b00403bbdcef64so1684698edb.14
 for <virtualization@lists.linux-foundation.org>;
 Tue, 18 Jan 2022 09:03:42 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
 :content-disposition;
 bh=xeHoR1Km3Ot/QwwgnNEtsDvDGwANoK5Acc9epKDxSQU=;
 b=0O3s+eQdGBTUq4R1Q6IcBKRFi0pGzb7I/nuUUEw6MZgkV1G3qJAQO/YxpQAc66gcWs
 oXBLhCbJsEzRE0qkycPE7VPN1SXtRyyDnYWniFEuF93sh24D1gux2I9voBcrvvMwrevq
 vwAZrCCbul8wzkaBxGtCAkRp9QU4i7bxeWLwH/Ukv3WTdM+9kAEtMO2xcuJCi2zMpF5f
 f2EuHrAN0mFcRVHtEce+DWSFe08W/RZdZZ8W9fK8/XgwyREDIYNUHG2y1x7e2AP2/bb1
 J9l2i/1ZXzLTo4HCDH90V0Lvzk9y5UQzikinVR5bFj/UeWK/ziWpw9LsyRcI1jQzaqpi
 APbQ==
X-Gm-Message-State: AOAM5328RE6ISLlkYZh8Wxk//L3rpt02YdqttZ/z4tsPa14agmdatDJ7
 rZnDxIfZyZDuETRNhrKT9HWPX5p7XgmGiePRzgKBf7QRap+/ZfS1iIybe0P+Z8syVDHgbbF+qoB
 84/7t3YFgRJwpswCsYUFj6XO4LC5GTvcjWr/Hq4F7hQ==
X-Received: by 2002:a05:6402:399:: with SMTP id
 o25mr25929991edv.70.1642525421625; 
 Tue, 18 Jan 2022 09:03:41 -0800 (PST)
X-Google-Smtp-Source: ABdhPJysFKMueDijbw2+fxPnfDwyfRixXRfg11cODmIZFCXfCeIojgPJErkMskMdbICWuCYRvZZVkg==
X-Received: by 2002:a05:6402:399:: with SMTP id
 o25mr25929978edv.70.1642525421403; 
 Tue, 18 Jan 2022 09:03:41 -0800 (PST)
Received: from redhat.com ([2.55.154.241])
 by smtp.gmail.com with ESMTPSA id i22sm5559325ejw.75.2022.01.18.09.03.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 18 Jan 2022 09:03:38 -0800 (PST)
Date: Tue, 18 Jan 2022 12:03:29 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/2] virtio: unexport virtio_finalize_features
Message-ID: <20220118170225.30620-1-mst@redhat.com>
MIME-Version: 1.0
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: Cornelia Huck <cohuck@redhat.com>,
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

virtio_finalize_features is only used internally within virtio.
No reason to export it.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Reviewed-by: Cornelia Huck <cohuck@redhat.com>
Acked-by: Jason Wang <jasowang@redhat.com>
---
 drivers/virtio/virtio.c | 3 +--
 include/linux/virtio.h  | 1 -
 2 files changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/virtio/virtio.c b/drivers/virtio/virtio.c
index 00ac9db792a4..d891b0a354b0 100644
--- a/drivers/virtio/virtio.c
+++ b/drivers/virtio/virtio.c
@@ -166,7 +166,7 @@ void virtio_add_status(struct virtio_device *dev, unsigned int status)
 }
 EXPORT_SYMBOL_GPL(virtio_add_status);
 
-int virtio_finalize_features(struct virtio_device *dev)
+static int virtio_finalize_features(struct virtio_device *dev)
 {
 	int ret = dev->config->finalize_features(dev);
 	unsigned status;
@@ -202,7 +202,6 @@ int virtio_finalize_features(struct virtio_device *dev)
 	}
 	return 0;
 }
-EXPORT_SYMBOL_GPL(virtio_finalize_features);
 
 void virtio_reset_device(struct virtio_device *dev)
 {
diff --git a/include/linux/virtio.h b/include/linux/virtio.h
index 72292a62cd90..5464f398912a 100644
--- a/include/linux/virtio.h
+++ b/include/linux/virtio.h
@@ -133,7 +133,6 @@ bool is_virtio_device(struct device *dev);
 void virtio_break_device(struct virtio_device *dev);
 
 void virtio_config_changed(struct virtio_device *dev);
-int virtio_finalize_features(struct virtio_device *dev);
 #ifdef CONFIG_PM_SLEEP
 int virtio_device_freeze(struct virtio_device *dev);
 int virtio_device_restore(struct virtio_device *dev);
-- 
MST

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
