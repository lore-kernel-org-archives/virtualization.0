Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BEDA9C433F5
	for <virtualization@archiver.kernel.org>; Fri, 14 Jan 2022 21:43:40 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 5CAD1832E7;
	Fri, 14 Jan 2022 21:43:40 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Dwsrlv1Mr2_5; Fri, 14 Jan 2022 21:43:39 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 0BD5C831D5;
	Fri, 14 Jan 2022 21:43:39 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id E2E02C002F;
	Fri, 14 Jan 2022 21:43:38 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 62A78C001E
 for <virtualization@lists.linux-foundation.org>;
 Fri, 14 Jan 2022 21:43:37 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 5016B410E6
 for <virtualization@lists.linux-foundation.org>;
 Fri, 14 Jan 2022 21:43:37 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id VLDJyuP6ntbk
 for <virtualization@lists.linux-foundation.org>;
 Fri, 14 Jan 2022 21:43:33 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 7C7A4410A0
 for <virtualization@lists.linux-foundation.org>;
 Fri, 14 Jan 2022 21:43:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1642196612;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
 bh=H65UNYpk1YgIkr6+F7jbPWFp6tYbCp821iY0zXAi0/8=;
 b=HY3rhKIxs3vNyuksdnnANeng1h0fNAKuvsVavWm1We14YU00jRP6mQYnnV/hr+t4obhKE/
 KynZDKcXv9PzvGmBwMHU5v+wcYHmpnTIH5TGqIJpykWB7S70MAph88SvSb36e2LvmMluep
 O7Rh+d+krA/K1RMsgirDlQ9yC20O/3Y=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-324-oMkacReoOBS1QBf45FyMLQ-1; Fri, 14 Jan 2022 16:43:31 -0500
X-MC-Unique: oMkacReoOBS1QBf45FyMLQ-1
Received: by mail-ed1-f70.google.com with SMTP id
 x19-20020a05640226d300b003f8b80f5729so9198833edd.13
 for <virtualization@lists.linux-foundation.org>;
 Fri, 14 Jan 2022 13:43:30 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
 :content-disposition;
 bh=H65UNYpk1YgIkr6+F7jbPWFp6tYbCp821iY0zXAi0/8=;
 b=H37vrX3rhHavYMGh5jfEfBSMIUZT0k6IbjjBW75Y+guEqYcrHlZ8EoGJLIhB3btebg
 zDA75pN+//OISl4BvM9ICgnb8CVWyAMn3CYNkVAZNzRzXMWIgzLIauDvPaPutGHR4lIq
 f6bFxkRa8921NRMhPPugG5LUNqVuTH8qOUysCO87Uw2+JwFiVlBqdKL3xp87Wd4aNLSQ
 xe0lHO/tE2p95JX+cW/3swSX5MLjs3KLKQdGnl3MrKssJswK64qEFuU4GNE2e2W9uWun
 D1HeTK2YYa5VxEgzBnKdRyFSvyMBaTeyQHUbZYtF792WPV1wAPCMpYtS2s9YYb7rcXHx
 YCoQ==
X-Gm-Message-State: AOAM530BufNaLY1AJTeIAV5BOAaGpwZoeELlwnmrAzcVr1NvuG+sK8o2
 EU5FP3etlCGjuu8lIdHvcG4tA3E1ImMaQHLaoEERFPAX3J3MdhP04+r8fx+OfzCrPBw3u3ZudJa
 YEKbkLlwSmFOym/WNh7qU+nlvxN2Pe8QVmIXVJ4SFtg==
X-Received: by 2002:a05:6402:27d1:: with SMTP id
 c17mr10483755ede.128.1642196609882; 
 Fri, 14 Jan 2022 13:43:29 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwX+X4YHjBMDl2PYMvPClJyagNr+C+tepnu7ca8BYRhvwykdVnYrSL9WI3b0URVZRj1HoAt8A==
X-Received: by 2002:a05:6402:27d1:: with SMTP id
 c17mr10483746ede.128.1642196609685; 
 Fri, 14 Jan 2022 13:43:29 -0800 (PST)
Received: from redhat.com ([2.55.154.210])
 by smtp.gmail.com with ESMTPSA id c19sm2755020ede.47.2022.01.14.13.43.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 14 Jan 2022 13:43:29 -0800 (PST)
Date: Fri, 14 Jan 2022 16:43:26 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: linux-kernel@vger.kernel.org
Subject: [PATCH] virtio_mem: break device on remove
Message-ID: <20220114214324.239444-1-mst@redhat.com>
MIME-Version: 1.0
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: virtualization@lists.linux-foundation.org
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

A common pattern for device reset is currently:
vdev->config->reset(vdev);
.. cleanup ..

reset prevents new interrupts from arriving and waits for interrupt
handlers to finish.

However if - as is common - the handler queues a work request which is
flushed during the cleanup stage, we have code adding buffers / trying
to get buffers while device is reset. Not good.

This was reproduced by running
	modprobe virtio_console
	modprobe -r virtio_console
in a loop, and this reasoning seems to apply to virtio mem though
I could not reproduce it there.

Fix this up by calling virtio_break_device + flush before reset.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 drivers/virtio/virtio_mem.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/virtio/virtio_mem.c b/drivers/virtio/virtio_mem.c
index 38becd8d578c..33b8a118a3ae 100644
--- a/drivers/virtio/virtio_mem.c
+++ b/drivers/virtio/virtio_mem.c
@@ -2888,6 +2888,8 @@ static void virtio_mem_remove(struct virtio_device *vdev)
 		virtio_mem_deinit_hotplug(vm);
 
 	/* reset the device and cleanup the queues */
+	virtio_break_device(vdev);
+	flush_work(&vm->wq);
 	virtio_reset_device(vdev);
 	vdev->config->del_vqs(vdev);
 
-- 
MST

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
