Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4CC8DC4332F
	for <virtualization@archiver.kernel.org>; Fri, 14 Jan 2022 21:57:38 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id D9BA6833AE;
	Fri, 14 Jan 2022 21:57:37 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id V7j3EfOH1mdA; Fri, 14 Jan 2022 21:57:37 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 8255B83396;
	Fri, 14 Jan 2022 21:57:36 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id BD02FC0071;
	Fri, 14 Jan 2022 21:57:35 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id AFF85C001E
 for <virtualization@lists.linux-foundation.org>;
 Fri, 14 Jan 2022 21:57:34 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 9EDFD4035B
 for <virtualization@lists.linux-foundation.org>;
 Fri, 14 Jan 2022 21:57:34 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id pOCaZqMx-nx4
 for <virtualization@lists.linux-foundation.org>;
 Fri, 14 Jan 2022 21:57:32 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id D4FE240509
 for <virtualization@lists.linux-foundation.org>;
 Fri, 14 Jan 2022 21:57:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1642197450;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=L16b4DGvxyPb5nATXEM8DIgZjgXdywlPz0ryK6DeeCM=;
 b=YBAdaDcD5IBzd5AscjwEZp2n9zm9Wp/eyEzfPIEF8mN316VglqkevXzqt3ulvdQPbBacRr
 5aAoWMVRA1jQ4JrOCB+Q+qDe5cxYFwD521BC4eCu1tsmJDXV6Yp2HkuuLLI7bM78NTFlbh
 Crmp/1f/zQDSdu2abzeDLrbU9YRvVJg=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-653-xrrQaK0WPhOf-cgH3_qx_w-1; Fri, 14 Jan 2022 16:57:28 -0500
X-MC-Unique: xrrQaK0WPhOf-cgH3_qx_w-1
Received: by mail-ed1-f71.google.com with SMTP id
 z9-20020a05640240c900b003fea688a17eso9312094edb.10
 for <virtualization@lists.linux-foundation.org>;
 Fri, 14 Jan 2022 13:57:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=L16b4DGvxyPb5nATXEM8DIgZjgXdywlPz0ryK6DeeCM=;
 b=GanWNVgDKDZ3yXkbcu6lMWuO0qcZNfbiT/R9ysrSTXS9PuRCefseYtBIEqH7w4nbCW
 ZDqpyixFYM5KLdFhfTbsVbYgss3W0+xqZtLDp1od2hm/IyWb3Yyxhs4CL8cy6+XpdqMf
 bjtaFrSnIkrv+/FKxmbd2n+C1oGW5/4WlLmQWjKs/a058wyp0btJX21ji3qC7vlScroO
 WqMnLlk7kk3s7u551PEAFRs/2b1em+0CQtEpxO3/ovB9LffLh+6PuMz/BCo2wcwG17Eu
 B/dJofBfMvGUpXgB075yRkFSAdKR6GL9he6BSZnAGnTkdqGwTwkzjk56LNwXVDuLOWNN
 bgIA==
X-Gm-Message-State: AOAM531rt1Mr65TpTjrM6cKuWVpUoo7ROJkgfnwhLqORWmSQm4Yui9fD
 RoX51YxHE48t30pn4cNrwGqTzWPmn7S4BaVHbnYIzvtnp6LafZbPPsk2zqhEITRn7etHWAOgj/+
 toIQi60kI0Yxqb7mmgG8phZ3EWXjBJxVhYS7AZHqv6Q==
X-Received: by 2002:aa7:ce14:: with SMTP id d20mr8882134edv.234.1642197446941; 
 Fri, 14 Jan 2022 13:57:26 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzRf2UPE1rQiu4oDrmGOKJ5fch7iHEHP3P6A+VJ1Pk64gSLJydxmVYQaT6KOfiVjxBzt05taw==
X-Received: by 2002:aa7:ce14:: with SMTP id d20mr8882118edv.234.1642197446731; 
 Fri, 14 Jan 2022 13:57:26 -0800 (PST)
Received: from redhat.com ([2.55.154.210])
 by smtp.gmail.com with ESMTPSA id c12sm2869794edx.80.2022.01.14.13.57.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 14 Jan 2022 13:57:25 -0800 (PST)
Date: Fri, 14 Jan 2022 16:57:24 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/3] virtio: document virtio_reset_device
Message-ID: <20220114215641.239984-2-mst@redhat.com>
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

Looks like most callers get driver/device removal wrong.
Document what's expected of callers.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 drivers/virtio/virtio.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/drivers/virtio/virtio.c b/drivers/virtio/virtio.c
index 2ed6e2451fd8..631a346a3aa6 100644
--- a/drivers/virtio/virtio.c
+++ b/drivers/virtio/virtio.c
@@ -201,6 +201,22 @@ static int virtio_finalize_features(struct virtio_device *dev)
 	return 0;
 }
 
+/**
+ * virtio_reset_device - quiesce device for removal
+ * @dev: the device to reset
+ *
+ * Prevents device from sending interrupts and accessing memory.
+ *
+ * Generally used for cleanup during driver / device removal.
+ *
+ * Once this has been invoked, caller must ensure that
+ * virtqueue_notify / virtqueue_kick are not in progress.
+ *
+ * Note: this guarantees that vq callbacks are not in progress, however caller
+ * is responsible for preventing access from other contexts, such as a system
+ * call/workqueue/bh.  Invoking virtio_break_device then flushing any such
+ * contexts is one way to handle that.
+ * */
 void virtio_reset_device(struct virtio_device *dev)
 {
 	dev->config->reset(dev);
-- 
MST

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
