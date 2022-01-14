Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 91DD1C433F5
	for <virtualization@archiver.kernel.org>; Fri, 14 Jan 2022 21:57:37 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 24BE883388;
	Fri, 14 Jan 2022 21:57:37 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id PUi14-imDfEy; Fri, 14 Jan 2022 21:57:36 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id BB6048329D;
	Fri, 14 Jan 2022 21:57:35 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 8E73EC002F;
	Fri, 14 Jan 2022 21:57:35 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 3BC41C001E
 for <virtualization@lists.linux-foundation.org>;
 Fri, 14 Jan 2022 21:57:34 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 15D0483385
 for <virtualization@lists.linux-foundation.org>;
 Fri, 14 Jan 2022 21:57:34 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id p9nnIqXQ-zPD
 for <virtualization@lists.linux-foundation.org>;
 Fri, 14 Jan 2022 21:57:33 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 3D54D8329D
 for <virtualization@lists.linux-foundation.org>;
 Fri, 14 Jan 2022 21:57:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1642197452;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=0wOvJxanjv8dJh5us8ooGzpb/lM+VsWX3ZsU7uSOCqY=;
 b=BbbzC1QWvLFkLm0przHgaiEssyvFXWbObc/7qcWgMpRtKwL7z8YJYZjaPN0xyx3qjnBuoI
 ELFfrMGl2Gr0GP/u9oGi9IX/mFnK7r+/ZELRJvPvQMh+rPxWLMe16xRDV+BlF4VfqaHmwB
 rwX/fAalxBh1gEGJ0pZbDmtAAov2tcQ=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-580-E4Sjd183N0K_zkUOtHSW3A-1; Fri, 14 Jan 2022 16:57:30 -0500
X-MC-Unique: E4Sjd183N0K_zkUOtHSW3A-1
Received: by mail-ed1-f70.google.com with SMTP id
 c8-20020a05640227c800b003fdc1684cdeso9320914ede.12
 for <virtualization@lists.linux-foundation.org>;
 Fri, 14 Jan 2022 13:57:30 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=0wOvJxanjv8dJh5us8ooGzpb/lM+VsWX3ZsU7uSOCqY=;
 b=JWPQdmh3AaRGQypO9OBOZe+AArm1hF9nZrpKZDMQsDljhKOOcF53P5Fsk/UpDFGwrK
 mBh6qUTNCUxXAmFfRuCxwOYuA7xSdGG6Uo6yT9VPEi1MogGY+u1ed/OgXcHlaR0lp+np
 QKvliUa2mvsuPRZPPx93L9m32gSpmPnJvyuzLZhD3E8Kzm0ylVoB66gwmBjfw07oQizM
 HbHT+sQ9tbySmNR0wWb8DwREFc3U3sYVXAFFIAaAuQlb6qYqwdCfeEg3dmbs/Y9+J9iK
 Os9eButHjLQcM/QUDWxA9Exn0YPwvKJxZodIOvAXZ0sFaXwtkJ7q9VKAFBaRlFGXG7We
 8RDg==
X-Gm-Message-State: AOAM531NkB22+CjpbPVWBzRbthYQqjBba1Wd2W3CLdllx9GhnzlzCHeo
 2SWumJkW7d8qZjCvtGcZHHGcUeZGd2lplE0DAxRK5LVmofN5imzbpGHAutjZ9ZokL8LzTj3DHpB
 nTqAKxttJxKxbqQ4e2NsMd1YKJfK+NDgUbqbWYDfgew==
X-Received: by 2002:aa7:db41:: with SMTP id n1mr10643160edt.307.1642197449775; 
 Fri, 14 Jan 2022 13:57:29 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxPcMkPHRedToYHc/SYw7TuOGuXM5aNzWoT0JmhpwS9rK3yCFyfEvKXtgc7v8dDKX/rq3pNmQ==
X-Received: by 2002:aa7:db41:: with SMTP id n1mr10643153edt.307.1642197449573; 
 Fri, 14 Jan 2022 13:57:29 -0800 (PST)
Received: from redhat.com ([2.55.154.210])
 by smtp.gmail.com with ESMTPSA id hd16sm2084204ejc.62.2022.01.14.13.57.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 14 Jan 2022 13:57:29 -0800 (PST)
Date: Fri, 14 Jan 2022 16:57:27 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/3] virtio_console: break out of buf poll on remove
Message-ID: <20220114215641.239984-3-mst@redhat.com>
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

Fix this up by calling virtio_break_device + flush before reset.

Bugzilla: https://bugzilla.redhat.com/show_bug.cgi?id=1786239
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 drivers/char/virtio_console.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/char/virtio_console.c b/drivers/char/virtio_console.c
index 2359889a35a0..e3c430539a17 100644
--- a/drivers/char/virtio_console.c
+++ b/drivers/char/virtio_console.c
@@ -1957,6 +1957,13 @@ static void virtcons_remove(struct virtio_device *vdev)
 	list_del(&portdev->list);
 	spin_unlock_irq(&pdrvdata_lock);
 
+	/* Device is going away, exit any polling for buffers */
+	virtio_break_device(vdev);
+	if (use_multiport(portdev))
+		flush_work(&portdev->control_work);
+	else
+		flush_work(&portdev->config_work);
+
 	/* Disable interrupts for vqs */
 	virtio_reset_device(vdev);
 	/* Finish up work that's lined up */
-- 
MST

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
