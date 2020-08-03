Return-Path: <SRS0=ivLu=BN=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BAFBC433E0
	for <virtualization@archiver.kernel.org>; Mon,  3 Aug 2020 20:59:26 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3C50622C9F
	for <virtualization@archiver.kernel.org>; Mon,  3 Aug 2020 20:59:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TwkydxG/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3C50622C9F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id DCB2A855B1;
	Mon,  3 Aug 2020 20:59:25 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id pCWn85ppMq4a; Mon,  3 Aug 2020 20:59:23 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id 1D29885692;
	Mon,  3 Aug 2020 20:59:23 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 0280CC0050;
	Mon,  3 Aug 2020 20:59:23 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id AF915C004C
 for <virtualization@lists.linux-foundation.org>;
 Mon,  3 Aug 2020 20:59:21 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 9F50C85A90
 for <virtualization@lists.linux-foundation.org>;
 Mon,  3 Aug 2020 20:59:21 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 4RZFS2v-CNAw
 for <virtualization@lists.linux-foundation.org>;
 Mon,  3 Aug 2020 20:59:21 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-1.mimecast.com (us-smtp-delivery-1.mimecast.com
 [207.211.31.120])
 by whitealder.osuosl.org (Postfix) with ESMTPS id 0C75785692
 for <virtualization@lists.linux-foundation.org>;
 Mon,  3 Aug 2020 20:59:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1596488360;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=or+zNAibqtaoCeVVGOGdUm20NwzQtJQIDqrZeu9+GCU=;
 b=TwkydxG/QH72p48OLC6OaIreqgXJB38DjSy33FeNt36OWFT+QjSKpwiGD0BDC5UIgj0U4p
 Dxo0eJtmBlw31v8zV4ew6tTBjszgizSzRzDvOhyuFWne0UfdpalRrD9rcAwK8rSGk+VUN7
 NISfbN4+kTrisagAM/P1xlmG0QivN/8=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-439-sDAh1XXsNZKivVzg1-gStg-1; Mon, 03 Aug 2020 16:59:18 -0400
X-MC-Unique: sDAh1XXsNZKivVzg1-gStg-1
Received: by mail-qv1-f71.google.com with SMTP id x4so15988459qvu.18
 for <virtualization@lists.linux-foundation.org>;
 Mon, 03 Aug 2020 13:59:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=or+zNAibqtaoCeVVGOGdUm20NwzQtJQIDqrZeu9+GCU=;
 b=DyJrQCrIFnGLy5SbieC2ODe2H2H8bLI8X2IahMaLZVk4DGgs5BV4YZAVrYjcdplWYA
 nhexUGotQRRhmqo986X0J0fmUKNfXzM8yGhdneU0zMHjbEMhvTso+mPncZMimP2xnuL8
 Tub3c4fa6XNDmgqKkXFNtbnDqWwtNs6BmQgqy/2d9qco613+SqwpDSV8d/xHJbaqtZih
 G06e4FMTV/RlCuYLWcHaH6pyihFBLFGGJgacJQg/o1iAkFd9lbq2stp+5rrlaCGjo+hj
 lGyG35gxvbxYObQSkYq3kKRLAO36HsmLVmch7UKkVZM0GWHnhVIInphpEHCLQuprFaoQ
 P39g==
X-Gm-Message-State: AOAM530Ie8LyXFPNJzaKxLz9Dw6dvvz0uPwxaPStaBFsCRd/gy0X/bUj
 xIm2dfzm27EIAybkp4+ZPilTZ7upc35E9cXuvZ1CMvw34TyaptV7UkfuM3sbFBZzizZ2VNCZAlE
 QteCyQ/wyscrzNAWkKbpdMKkt6aG9ANIGuMwNVYFRKQ==
X-Received: by 2002:ac8:1084:: with SMTP id a4mr17555987qtj.83.1596488358265; 
 Mon, 03 Aug 2020 13:59:18 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzrapOZB7Hdxu0x7Z+dBtzskHcpM/llP/zvUq8ucoKtu/KA509zj05FQ3vDOugv6knjeTkoqw==
X-Received: by 2002:ac8:1084:: with SMTP id a4mr17555977qtj.83.1596488358075; 
 Mon, 03 Aug 2020 13:59:18 -0700 (PDT)
Received: from redhat.com (bzq-79-177-102-128.red.bezeqint.net.
 [79.177.102.128])
 by smtp.gmail.com with ESMTPSA id z14sm21310391qtn.92.2020.08.03.13.59.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 03 Aug 2020 13:59:17 -0700 (PDT)
Date: Mon, 3 Aug 2020 16:59:13 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: linux-kernel@vger.kernel.org
Subject: [PATCH v2 09/24] virtio_fs: correct tags for config space fields
Message-ID: <20200803205814.540410-10-mst@redhat.com>
References: <20200803205814.540410-1-mst@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200803205814.540410-1-mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: Miklos Szeredi <miklos@szeredi.hu>,
 virtualization@lists.linux-foundation.org,
 Stefan Hajnoczi <stefanha@redhat.com>, linux-fsdevel@vger.kernel.org,
 Vivek Goyal <vgoyal@redhat.com>
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

Since fs is a modern-only device,
tag config space fields as having little endian-ness.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 include/uapi/linux/virtio_fs.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/uapi/linux/virtio_fs.h b/include/uapi/linux/virtio_fs.h
index b02eb2ac3d99..3056b6e9f8ce 100644
--- a/include/uapi/linux/virtio_fs.h
+++ b/include/uapi/linux/virtio_fs.h
@@ -13,7 +13,7 @@ struct virtio_fs_config {
 	__u8 tag[36];
 
 	/* Number of request queues */
-	__u32 num_request_queues;
+	__le32 num_request_queues;
 } __attribute__((packed));
 
 #endif /* _UAPI_LINUX_VIRTIO_FS_H */
-- 
MST

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
