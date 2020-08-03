Return-Path: <SRS0=ivLu=BN=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C93F2C433E1
	for <virtualization@archiver.kernel.org>; Mon,  3 Aug 2020 20:59:14 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CD30F22C9F
	for <virtualization@archiver.kernel.org>; Mon,  3 Aug 2020 20:59:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="C8dvCP3N"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CD30F22C9F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id 8914E853E6;
	Mon,  3 Aug 2020 20:59:14 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id hwCJrqgCyW5y; Mon,  3 Aug 2020 20:59:13 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id D55D48557B;
	Mon,  3 Aug 2020 20:59:13 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id B9EEFC0050;
	Mon,  3 Aug 2020 20:59:13 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id A9001C004C
 for <virtualization@lists.linux-foundation.org>;
 Mon,  3 Aug 2020 20:59:12 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id 98DF9879A5
 for <virtualization@lists.linux-foundation.org>;
 Mon,  3 Aug 2020 20:59:12 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id pjQuuNsnXkd7
 for <virtualization@lists.linux-foundation.org>;
 Mon,  3 Aug 2020 20:59:12 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-delivery-1.mimecast.com (us-smtp-1.mimecast.com
 [205.139.110.61])
 by hemlock.osuosl.org (Postfix) with ESMTPS id 1A30B877A0
 for <virtualization@lists.linux-foundation.org>;
 Mon,  3 Aug 2020 20:59:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1596488350;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=i84PP3Re6PfoQrMXF63OXd7sE+dx3f/0IwVj5uJOuRY=;
 b=C8dvCP3NAQCbUZ34s83daZUeUJBZPhtBv/4/6EMivE6iFSQVfAk0dE9K0saU3VPr0Jrp0y
 OZYcYnuLwRI4NL/yTqiphLJzO9i65ZEPyNZ4MW0q+p4nztL0Rn7q8hsB39J5s2hXx0VB5k
 /ZfaCL9HpH+OSKzJxzzkD8pa5UnWmZo=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-126-gNg00J_NPj62boF3h623jQ-1; Mon, 03 Aug 2020 16:59:09 -0400
X-MC-Unique: gNg00J_NPj62boF3h623jQ-1
Received: by mail-qt1-f200.google.com with SMTP id r9so27754339qtp.7
 for <virtualization@lists.linux-foundation.org>;
 Mon, 03 Aug 2020 13:59:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=i84PP3Re6PfoQrMXF63OXd7sE+dx3f/0IwVj5uJOuRY=;
 b=LRJPdWuFySTRLkpyfDy4UF2j1T8cU+iDNhw+bergrCqg1hSNbaNHmHmvPZ9rbUIg5Z
 XtJkbJzrV7nbhfXxUGqttkspe9EZxK04zVp+MetOfNpgn84BuZ6xnFDw0rS2HLsYKvkq
 dA19Qm2mJrkRRxPCxfAzI7YLqsdJxPvq6OE7EX3Wt1/LhcsnccsRWr431vRBWcHlLr9W
 eUTeKXoTDzxB1z7g28trKU+Th/AfjKyWDJfLNs1MMiMOrzpEpeZcONokdhsnlkeMGvfE
 PuTi5djx1GYo0DUhK0XgA1YD7ZDoyT9YBpcKni1Q1iIMhU/IBNAPR8h8qg8tEpmOSGyX
 zOhg==
X-Gm-Message-State: AOAM531cYb0cx3qbcARPzkYvXs4C8u0060lnpggpTTDrRAaizunWwsdn
 w4GPPATejxDuKfMUx5KlT9ksFWIVx4bMnvQrj5/opfkQyWwtiUpy3HpkYa3dHcKah1QTeefpGpt
 Rd6P9zYBnS7LA312VvvOjI/s3N8B9hmr4pjZD3tuXhA==
X-Received: by 2002:ad4:42cc:: with SMTP id f12mr19042819qvr.89.1596488348830; 
 Mon, 03 Aug 2020 13:59:08 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJz262h1J0muCLAurrrG0els/b63+CoBKe7x5909bPvHViTN2G1SB1XsG8FwJY6r+RwaqGESuA==
X-Received: by 2002:ad4:42cc:: with SMTP id f12mr19042808qvr.89.1596488348608; 
 Mon, 03 Aug 2020 13:59:08 -0700 (PDT)
Received: from redhat.com (bzq-79-177-102-128.red.bezeqint.net.
 [79.177.102.128])
 by smtp.gmail.com with ESMTPSA id c22sm20470842qke.2.2020.08.03.13.59.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 03 Aug 2020 13:59:07 -0700 (PDT)
Date: Mon, 3 Aug 2020 16:59:04 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: linux-kernel@vger.kernel.org
Subject: [PATCH v2 07/24] virtio_console: correct tags for config space fields
Message-ID: <20200803205814.540410-8-mst@redhat.com>
References: <20200803205814.540410-1-mst@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200803205814.540410-1-mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: Amit Shah <amit@kernel.org>, virtualization@lists.linux-foundation.org
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

Tag config space fields as having virtio endian-ness.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 include/uapi/linux/virtio_console.h | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/include/uapi/linux/virtio_console.h b/include/uapi/linux/virtio_console.h
index b7fb108c9310..7e6ec2ff0560 100644
--- a/include/uapi/linux/virtio_console.h
+++ b/include/uapi/linux/virtio_console.h
@@ -45,13 +45,13 @@
 
 struct virtio_console_config {
 	/* colums of the screens */
-	__u16 cols;
+	__virtio16 cols;
 	/* rows of the screens */
-	__u16 rows;
+	__virtio16 rows;
 	/* max. number of ports this device can hold */
-	__u32 max_nr_ports;
+	__virtio32 max_nr_ports;
 	/* emergency write register */
-	__u32 emerg_wr;
+	__virtio32 emerg_wr;
 } __attribute__((packed));
 
 /*
-- 
MST

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
