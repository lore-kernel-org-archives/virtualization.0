Return-Path: <SRS0=Keeg=BP=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7BC09C433E0
	for <virtualization@archiver.kernel.org>; Wed,  5 Aug 2020 13:44:50 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 504A22065C
	for <virtualization@archiver.kernel.org>; Wed,  5 Aug 2020 13:44:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iOR+KVU7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 504A22065C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 33E60868AB;
	Wed,  5 Aug 2020 13:44:50 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id SDU3Wxrs2dGv; Wed,  5 Aug 2020 13:44:49 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id C79F986888;
	Wed,  5 Aug 2020 13:44:49 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id BF6F0C0051;
	Wed,  5 Aug 2020 13:44:49 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 93551C004C
 for <virtualization@lists.linux-foundation.org>;
 Wed,  5 Aug 2020 13:44:48 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id 82C9488251
 for <virtualization@lists.linux-foundation.org>;
 Wed,  5 Aug 2020 13:44:48 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id gt8bopSKjJnj
 for <virtualization@lists.linux-foundation.org>;
 Wed,  5 Aug 2020 13:44:48 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-1.mimecast.com (us-smtp-delivery-1.mimecast.com
 [207.211.31.120])
 by hemlock.osuosl.org (Postfix) with ESMTPS id 027E888221
 for <virtualization@lists.linux-foundation.org>;
 Wed,  5 Aug 2020 13:44:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1596635087;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=jWci/+5/mBvE1F6mvnsX+8niF7C1kxp9FouMHNJqkcQ=;
 b=iOR+KVU7wRkphptAAwAzEBLj3EFZnN+Kz1AlGnyfqC6w5mqe5EAbnWBg1x4xZVQjk+cmGE
 FUA1bAcB3BiZUdv6LgBoohd6AjR8SX8wUC9AKCKrt6kCHgU3XdqKwc4Pd6yOC8DENQvTSX
 KLHo0WPKOMezJRaabLRWcCVbzCYZr2s=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-301-5gWGtUmXOKyXwRbjRKJ0OQ-1; Wed, 05 Aug 2020 09:44:45 -0400
X-MC-Unique: 5gWGtUmXOKyXwRbjRKJ0OQ-1
Received: by mail-wm1-f69.google.com with SMTP id z1so2730247wmf.9
 for <virtualization@lists.linux-foundation.org>;
 Wed, 05 Aug 2020 06:44:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=jWci/+5/mBvE1F6mvnsX+8niF7C1kxp9FouMHNJqkcQ=;
 b=oaczRxapvX3Cr/WA1AA3uTAyocy/EQAjpU7s7voaic2RmKYhLFPrY19G3azno+LM8C
 E+4QDkJPtgDMuf0ZYGJ+tGuV2QDIt9g2Nlg7YTzCFb06tv2aarn7dr/fawja7HY6Ri2X
 n+uz2x9OaYl+DSyzMBkrnFjW+64DTJKcjQHvHnrAXbhmTnEWns2sUs2uF5iGo27qutbD
 2OSaXdzQUOgDaS9RPQh4N0ksA2jT3S0mI5TFGZJMeGlmxAmGR7J2Xk5fTsl5nXx1r4eU
 iyCBuN9ycL0vwinYzXMdznm1Vpcnf/8vCImQygqdKIWXtmEFNHFgBQO7UxNicKMi51sq
 WGFg==
X-Gm-Message-State: AOAM532XOvWFB1qv94SJ2MBoN5k3y7Zcf+/vvDNzckP3qQgvW6DeIzdu
 o4GKsgW6rrkT2cG+tX9iMmtX9xZnr3D4gM3sKNwWpu7ZdxRd7vc5AFgsRr21nOOgI2GR1jShgN6
 16H4S2ufnzSH3b5VN1CtKgOAEd7u8LFQHi6rmhKd+YA==
X-Received: by 2002:a05:6000:18a:: with SMTP id
 p10mr2648513wrx.33.1596635082516; 
 Wed, 05 Aug 2020 06:44:42 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzh/KIN/KZmvjqAkTq6wQd3jfmeRt/1lbO1zvA9EzKkakixioTV1omDTRNwjFLeWiuqYQR30A==
X-Received: by 2002:a05:6000:18a:: with SMTP id
 p10mr2648497wrx.33.1596635082345; 
 Wed, 05 Aug 2020 06:44:42 -0700 (PDT)
Received: from redhat.com ([192.117.173.58])
 by smtp.gmail.com with ESMTPSA id j5sm2967022wmb.15.2020.08.05.06.44.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 05 Aug 2020 06:44:41 -0700 (PDT)
Date: Wed, 5 Aug 2020 09:44:39 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: linux-kernel@vger.kernel.org
Subject: [PATCH v3 31/38] virtio_fs: convert to LE accessors
Message-ID: <20200805134226.1106164-32-mst@redhat.com>
References: <20200805134226.1106164-1-mst@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200805134226.1106164-1-mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: linux-fsdevel@vger.kernel.org, virtualization@lists.linux-foundation.org,
 Stefan Hajnoczi <stefanha@redhat.com>, Vivek Goyal <vgoyal@redhat.com>,
 Miklos Szeredi <miklos@szeredi.hu>
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

Virtio fs is modern-only. Use LE accessors for config space.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 fs/fuse/virtio_fs.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/fuse/virtio_fs.c b/fs/fuse/virtio_fs.c
index 4c4ef5d69298..104f35de5270 100644
--- a/fs/fuse/virtio_fs.c
+++ b/fs/fuse/virtio_fs.c
@@ -606,8 +606,8 @@ static int virtio_fs_setup_vqs(struct virtio_device *vdev,
 	unsigned int i;
 	int ret = 0;
 
-	virtio_cread(vdev, struct virtio_fs_config, num_request_queues,
-		     &fs->num_request_queues);
+	virtio_cread_le(vdev, struct virtio_fs_config, num_request_queues,
+			&fs->num_request_queues);
 	if (fs->num_request_queues == 0)
 		return -EINVAL;
 
-- 
MST

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
