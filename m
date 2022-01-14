Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7084DC43217
	for <virtualization@archiver.kernel.org>; Fri, 14 Jan 2022 21:57:40 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 118D260F16;
	Fri, 14 Jan 2022 21:57:40 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id eqMNR3U1KPR9; Fri, 14 Jan 2022 21:57:38 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 1EEB960B29;
	Fri, 14 Jan 2022 21:57:38 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id EE40BC0031;
	Fri, 14 Jan 2022 21:57:37 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 28DABC002F
 for <virtualization@lists.linux-foundation.org>;
 Fri, 14 Jan 2022 21:57:37 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 084084054A
 for <virtualization@lists.linux-foundation.org>;
 Fri, 14 Jan 2022 21:57:37 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 0xAbirrPiRQo
 for <virtualization@lists.linux-foundation.org>;
 Fri, 14 Jan 2022 21:57:36 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 6DE3B4035E
 for <virtualization@lists.linux-foundation.org>;
 Fri, 14 Jan 2022 21:57:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1642197455;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=H65UNYpk1YgIkr6+F7jbPWFp6tYbCp821iY0zXAi0/8=;
 b=SeSurwWyHP9c/HCum+/op3Sorzkx4GjZUQiUrzlR3sPxULSeNG7VbcVou0l6dqYYd5pVEf
 /o4hRGh/2CHvqUu54h6AtsMmWvuAukd/bETeu4DqLEGsHETf6kHCHRX50bqwq8UYtXnpsj
 GxvFaJnOIkFGWd1hmWLTIWc8/l6wdX4=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-381-9sbuhZsiO4OcTN9RLs_w4w-1; Fri, 14 Jan 2022 16:57:34 -0500
X-MC-Unique: 9sbuhZsiO4OcTN9RLs_w4w-1
Received: by mail-ed1-f72.google.com with SMTP id
 c8-20020a05640227c800b003fdc1684cdeso9321012ede.12
 for <virtualization@lists.linux-foundation.org>;
 Fri, 14 Jan 2022 13:57:34 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=H65UNYpk1YgIkr6+F7jbPWFp6tYbCp821iY0zXAi0/8=;
 b=3YpTlty+M/att7PIAHHd44wrG76xXdizdKBO8quQT/LAOBim3dVQ8WhRLGRfoa/xng
 88WnUZxTGecARr3Db+02ka9w7EYLIDulBQfN+uLkAAHOk953Vs+ECCO+Qb/QZYdV3aU4
 b4sYDF6zeThYKE70WIctXSoeUfmuz6HhgiireK/vGPxm6P3sUmccLJTX5MIF1XoTo9JK
 uUlgySMa26GN8dM2JlkN+QPuakj3w2s/QzgtJ8Eda+9hlP/y0PodHDvTujzIn3IKkl/c
 XvMoQS7/GEYCz9upmZjhrq2ENRKMIbNa94YESfpYryYLrnL55ObfwX40ZSpK4hIcK/xA
 8Q6g==
X-Gm-Message-State: AOAM532hB6Wwg07Fkja5kQ3tspGoPJ5kUFqp5P6BADg/rvU8GMMgvSVa
 hbPbAMJHharwgEDxogG1FZcWhGe7kYOAwNNM+CFh8AZkbhRisBImbnaBZnm6JghK94YYXcCC5as
 4rH8DsHd0aXaQHkH8qxyqYpaFSKt54CSy7mJMi/50Hw==
X-Received: by 2002:a17:907:1689:: with SMTP id
 hc9mr8651756ejc.228.1642197452405; 
 Fri, 14 Jan 2022 13:57:32 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzsTiLtSAGxhk+CZk+P/jiuyGZo11tboZXauUuIvMgtr2CQW2woyxWUOXD9q5He4VsWBSjrIg==
X-Received: by 2002:a17:907:1689:: with SMTP id
 hc9mr8651746ejc.228.1642197452229; 
 Fri, 14 Jan 2022 13:57:32 -0800 (PST)
Received: from redhat.com ([2.55.154.210])
 by smtp.gmail.com with ESMTPSA id c15sm2779480edv.77.2022.01.14.13.57.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 14 Jan 2022 13:57:31 -0800 (PST)
Date: Fri, 14 Jan 2022 16:57:29 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: linux-kernel@vger.kernel.org
Subject: [PATCH v2 3/3] virtio_mem: break device on remove
Message-ID: <20220114215641.239984-4-mst@redhat.com>
References: <20220114215641.239984-1-mst@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20220114215641.239984-1-mst@redhat.com>
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
