Return-Path: <SRS0=LBOH=OZ=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6BD9C433FE
	for <virtualization@archiver.kernel.org>; Tue,  5 Oct 2021 07:04:18 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3F2646154B
	for <virtualization@archiver.kernel.org>; Tue,  5 Oct 2021 07:04:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 3F2646154B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 09CFB60717;
	Tue,  5 Oct 2021 07:04:18 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id MusWXypLUk9Z; Tue,  5 Oct 2021 07:04:17 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 85E9C6065C;
	Tue,  5 Oct 2021 07:04:16 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 4EB57C0011;
	Tue,  5 Oct 2021 07:04:16 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id A9455C000D
 for <virtualization@lists.linux-foundation.org>;
 Tue,  5 Oct 2021 07:04:15 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 97E6B8377F
 for <virtualization@lists.linux-foundation.org>;
 Tue,  5 Oct 2021 07:04:15 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 5qo0zBaS2tba
 for <virtualization@lists.linux-foundation.org>;
 Tue,  5 Oct 2021 07:04:14 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 8EE6883774
 for <virtualization@lists.linux-foundation.org>;
 Tue,  5 Oct 2021 07:04:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1633417453;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
 bh=MwInSBtYmEyMyAif3gbAt3an+xVu0NUGoBdgjgo4es8=;
 b=aviES+LSZU74pNRgHy9HsyS9dzeaQ1OufFAFdur7ZvIHUblc7fDTo9mU3yBlH4mswtf/r/
 jrwZ2ph6ubxbwu8sGzIGAo8c3+qlxNXuIzRUYSfv/wRqtAJmOCOC7DoSZEIxW84X1mYE6t
 bI6h4UZXotDVvgp8JEyZ+cPjsIeU7+8=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-582-_-RuVyjmOuup3VShQDBSVQ-1; Tue, 05 Oct 2021 03:04:11 -0400
X-MC-Unique: _-RuVyjmOuup3VShQDBSVQ-1
Received: by mail-ed1-f72.google.com with SMTP id
 c30-20020a50f61e000000b003daf3955d5aso5152552edn.4
 for <virtualization@lists.linux-foundation.org>;
 Tue, 05 Oct 2021 00:04:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
 :content-disposition;
 bh=MwInSBtYmEyMyAif3gbAt3an+xVu0NUGoBdgjgo4es8=;
 b=vvLpdRXNsHiMAAXkQPxNudKP6SlN3RF4aSCbPHpXxybluc3oPeLQrkHw+SgEyBjINM
 0nrgI0lg5VY6z2+QK2TX13WBasHSnOPzgFlZhQvcmuBr15xrdymCI209AA1BnDDLtiPf
 UX8VP2Hqbg+mde0TjONPl7EGoDGlHLwEoTlZ00Ji0U9WsoQna0HVdhYC9eAnb/gVYKsY
 GN3H8E3aW5muqYlVAO6hu0dMlAmfcPyTZ6kIrQs+1FuNcHjWNyu+5uCa51zwVb1StLdU
 j1hgNvGMAeQDbwmLPWTdiUesDA2LtL1xaJTduRhiXyoEbN8crOKWL+q9Eb6hE36xrgI0
 1tyA==
X-Gm-Message-State: AOAM530i4kDB00D+iiSdN+1Ry7IZ5HW0CBgkG3d9xeMPdFlI9KmyuuG7
 7Mzo4drxRHrNzScvRSj4BC2K0teImvoRVrlxIov+DrMEUQrPGlzfIjlZ6KiMwRhIuKiZujP3x5Z
 0633/UZEN90ouj97D+KjbPAI2zPv7czAXCiVKFbJUrQ==
X-Received: by 2002:a05:6402:1b8a:: with SMTP id
 cc10mr23533868edb.313.1633417450539; 
 Tue, 05 Oct 2021 00:04:10 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzY7TKGubb0zmZNFzLoIzxm3WkaPK9JNBr5tNNxLovtIG5E0rgMolF1pMxF4SXqmvMM/BQpOA==
X-Received: by 2002:a05:6402:1b8a:: with SMTP id
 cc10mr23533849edb.313.1633417450387; 
 Tue, 05 Oct 2021 00:04:10 -0700 (PDT)
Received: from redhat.com ([2.55.147.134])
 by smtp.gmail.com with ESMTPSA id a1sm7729375edu.43.2021.10.05.00.04.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 05 Oct 2021 00:04:09 -0700 (PDT)
Date: Tue, 5 Oct 2021 03:04:07 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: linux-kernel@vger.kernel.org
Subject: [PATCH] virtio_console: break out of buf poll on remove
Message-ID: <20211005070354.265164-1-mst@redhat.com>
MIME-Version: 1.0
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 virtualization@lists.linux-foundation.org, Arnd Bergmann <arnd@arndb.de>,
 Amit Shah <amit@kernel.org>
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
in a loop.

Fixing this comprehensively needs some thought, and new APIs.
Let's at least handle the specific case of virtio_console
removal that was reported in the field.

Bugzilla: https://bugzilla.redhat.com/show_bug.cgi?id=1786239
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 drivers/char/virtio_console.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/char/virtio_console.c b/drivers/char/virtio_console.c
index 7eaf303a7a86..c852ce0b4d56 100644
--- a/drivers/char/virtio_console.c
+++ b/drivers/char/virtio_console.c
@@ -1956,6 +1956,12 @@ static void virtcons_remove(struct virtio_device *vdev)
 	list_del(&portdev->list);
 	spin_unlock_irq(&pdrvdata_lock);
 
+	/* Device is going away, exit any polling for buffers */
+	virtio_break_device(vdev);
+	if (use_multiport(portdev))
+		flush_work(&portdev->control_work);
+	else
+		flush_work(&portdev->config_work);
 	/* Disable interrupts for vqs */
 	vdev->config->reset(vdev);
 	/* Finish up work that's lined up */
-- 
MST

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
