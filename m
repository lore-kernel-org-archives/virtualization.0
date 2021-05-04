Return-Path: <SRS0=eOzH=J7=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8FCDC43460
	for <virtualization@archiver.kernel.org>; Tue,  4 May 2021 08:21:05 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4454B613C1
	for <virtualization@archiver.kernel.org>; Tue,  4 May 2021 08:21:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4454B613C1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id DF44C4010C;
	Tue,  4 May 2021 08:21:04 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id qlQz4JTM-6Ef; Tue,  4 May 2021 08:21:04 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTP id 91CC0400F8;
	Tue,  4 May 2021 08:21:03 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 641C9C000E;
	Tue,  4 May 2021 08:21:03 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 490E5C0001
 for <virtualization@lists.linux-foundation.org>;
 Tue,  4 May 2021 08:21:02 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 2986184340
 for <virtualization@lists.linux-foundation.org>;
 Tue,  4 May 2021 08:21:02 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id b-9nRjA4WF-M
 for <virtualization@lists.linux-foundation.org>;
 Tue,  4 May 2021 08:21:01 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 5FDEC84334
 for <virtualization@lists.linux-foundation.org>;
 Tue,  4 May 2021 08:21:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1620116459;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
 bh=ZduZH7uIcqDrcp+Id8iATABsMeFNx9WnKRzKVMxr/dA=;
 b=BKbogr/jMZ/LLENdEwzz8ouQ1CrrdpFcDx9G2k3mvHX1HzzwL6uhUUHBNrLjCy4+8V8nSk
 Lyky+j0zFYUTIvzy80IfCwF5AWItTLVExGIDKyzaasccZD+naFDaotrilf9Mp6DccTTzHL
 RUHjrr+FRwMjsDkN+zurVbuDokdbfYo=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-501-EUq4cWFUM16CQRNVQRPoRg-1; Tue, 04 May 2021 04:20:57 -0400
X-MC-Unique: EUq4cWFUM16CQRNVQRPoRg-1
Received: by mail-wr1-f71.google.com with SMTP id
 88-20020adf95610000b029010758d8d7e2so5402424wrs.19
 for <virtualization@lists.linux-foundation.org>;
 Tue, 04 May 2021 01:20:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
 :content-disposition;
 bh=ZduZH7uIcqDrcp+Id8iATABsMeFNx9WnKRzKVMxr/dA=;
 b=A+QFJmC6K6jEdRIhQNZmgvlfPfLcc+YTMd4F3BKO2JMEBhKUCg1uiH3lNkvl0YLjgb
 obp+WxIrPPRjntMfCZOuZaxJ1GrB0tNYQZ78UhanOXHKiJNa2w7BrBpZUbj1Qqx+6jFc
 2K5le2t23LCGmrVA3uA0W+aE04etVV5+HAIm5aXQS5jxbknEoRglLCKRZD41yU3AkXPA
 lz70W9FElzJI5Hz4RFiq6qmYvYWFu8H2iHXbM36lUM8SZ+aHGDaxALn/hMHvKqsNCKti
 Tqcnr6UwlG8hwqVcYccZBLavlIFlVkiZudOVKhUMFkdNhT5Qo6aTSLKWnjMYgiBWueZk
 A9Tw==
X-Gm-Message-State: AOAM5324stEoK5fIvxJ6HRbsWwU0xQ5ygDAF5AnMhWxuZ9qnQLlVU2ey
 4FTER+CNrKNxWWn94B+pTvlpFYfER4cfm5EP8RndkiVphruJZzVK45BeCIaJQE18wrbAE22leOZ
 KQvDEzd0Y/xeU7JlYZzeNUpRsatu2sokOgpX4U6XiRw==
X-Received: by 2002:a1c:4482:: with SMTP id r124mr2599994wma.42.1620116456220; 
 Tue, 04 May 2021 01:20:56 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwio/Fcw9s4W5lDKZ/mtZxroSdSPwEkZaybadnCc9xMJ6LakGIrRp0EXSNfm8bUGh5UKO2N+A==
X-Received: by 2002:a1c:4482:: with SMTP id r124mr2599983wma.42.1620116455999; 
 Tue, 04 May 2021 01:20:55 -0700 (PDT)
Received: from redhat.com ([2a10:800a:cdef:0:114d:2085:61e4:7b41])
 by smtp.gmail.com with ESMTPSA id d127sm1633011wmd.14.2021.05.04.01.20.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 04 May 2021 01:20:55 -0700 (PDT)
Date: Tue, 4 May 2021 04:20:53 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] virtio_pci_modern: __force cast the notify mapping
Message-ID: <20210504082034.118581-1-mst@redhat.com>
MIME-Version: 1.0
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: Eli Cohen <elic@nvidia.com>, kernel test robot <lkp@intel.com>,
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

When switching virtio_pci_modern to use a helper for mappings we lost an
__iomem tag. We should restore it.

However, virtio_pci_modern is playing tricks by hiding an iomem pointer
in a regular vq->priv pointer. Which is okay as long as it's
all contained within a single file, but we need to __force cast
the value otherwise we'll get sparse warnings.

Reported-by: kernel test robot <lkp@intel.com>
Fixes: 7dca6c0ea96b ("virtio-pci library: switch to use vp_modern_map_vq_notify()")
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 drivers/virtio/virtio_pci_modern.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/virtio/virtio_pci_modern.c b/drivers/virtio/virtio_pci_modern.c
index 722ea44e7579..30654d3a0b41 100644
--- a/drivers/virtio/virtio_pci_modern.c
+++ b/drivers/virtio/virtio_pci_modern.c
@@ -224,7 +224,7 @@ static struct virtqueue *setup_vq(struct virtio_pci_device *vp_dev,
 				virtqueue_get_avail_addr(vq),
 				virtqueue_get_used_addr(vq));
 
-	vq->priv = vp_modern_map_vq_notify(mdev, index, NULL);
+	vq->priv = (void __force *)vp_modern_map_vq_notify(mdev, index, NULL);
 	if (!vq->priv) {
 		err = -ENOMEM;
 		goto err_map_notify;
-- 
MST

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
