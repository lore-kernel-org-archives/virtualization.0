Return-Path: <SRS0=ivLu=BN=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10EC0C433E0
	for <virtualization@archiver.kernel.org>; Mon,  3 Aug 2020 20:59:45 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 130C222C9F
	for <virtualization@archiver.kernel.org>; Mon,  3 Aug 2020 20:59:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="aow/cB0Y"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 130C222C9F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id A65DA20482;
	Mon,  3 Aug 2020 20:59:44 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id EOOZXhSuiaOl; Mon,  3 Aug 2020 20:59:43 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id 20B7F204C7;
	Mon,  3 Aug 2020 20:59:43 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 1901EC0050;
	Mon,  3 Aug 2020 20:59:43 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id B5A51C004C
 for <virtualization@lists.linux-foundation.org>;
 Mon,  3 Aug 2020 20:59:42 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id 9CD1485D7E
 for <virtualization@lists.linux-foundation.org>;
 Mon,  3 Aug 2020 20:59:42 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id MELHSEpQ-0R8
 for <virtualization@lists.linux-foundation.org>;
 Mon,  3 Aug 2020 20:59:42 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-delivery-1.mimecast.com (us-smtp-1.mimecast.com
 [207.211.31.81])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id CCB87844C9
 for <virtualization@lists.linux-foundation.org>;
 Mon,  3 Aug 2020 20:59:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1596488380;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Rgbr3S7Op26qakIXtpfCwbs62McqD9fRJN/CcHSJJtk=;
 b=aow/cB0YSeVgVJrK2AEsh/dos7Ud6/GDtlBoHzpwm2Mi3DDX/+zAGWNfEaCSSiLL5SVQ8C
 DoOf8FTSGqG83IQROSxF+PyHZBQHL6PVObPJp8pDyM6Ej5IhlNoc/56zJf9tFr96lPdwFk
 7zLyrptHEzGaoOHzX9w6QUolAqeAGsY=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-141-vo_6XXHfO0Wg4an0DGfntQ-1; Mon, 03 Aug 2020 16:59:37 -0400
X-MC-Unique: vo_6XXHfO0Wg4an0DGfntQ-1
Received: by mail-qv1-f69.google.com with SMTP id h6so5133234qvz.14
 for <virtualization@lists.linux-foundation.org>;
 Mon, 03 Aug 2020 13:59:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=Rgbr3S7Op26qakIXtpfCwbs62McqD9fRJN/CcHSJJtk=;
 b=iDr0Dy9np/GHA90587eajn3A6ih1euF8haADeEAnDuV1kIWlL5ayO04wiLq/r2AkRK
 4E1lZCUIia3LX42F7fzqpo1/1ePdEuj4wRBN1mV5uzop6ZYpYj80vctZUpRFDyaq9yW7
 CGdXKPFgSwivIszGI/MGw4ffmO+V/xR/sRtDRbq3y2J3Fv1sN72RCS7pvgtJaTn9liam
 G374aYWdd55EfPZ6GouUdtxqcfi/NPJVXDAMOC9JzYxpymL4j0WdzuFDA/eWnN9pTrRx
 a3qjMGDmjR1ArjP9BZ6qJCITSyA0QNR7BWFmqRFeLBFz+6i5rw68tWDpYGVabvHG7T7Y
 6YNA==
X-Gm-Message-State: AOAM5314srMP6olC4hhauHu/0kSkshUW42rg9LHbO75cYqrdN0suphBu
 SiJXjdf6JIfm1e7hgNzlF3+ZDoNIcg1/RsbQVuUf1BxZYiGAdN2YvsxA+mmP7duaLDuBqMb3b82
 t19TP7NUX7NlTkvjPViooIN5lEgatTFnaIYPaepwTYw==
X-Received: by 2002:a37:e04:: with SMTP id 4mr17763981qko.269.1596488376481;
 Mon, 03 Aug 2020 13:59:36 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJydECTgbLYKr4hjShvtJWKB8TcEkpEIhhziBGJusR6Qak9+rn18ZeFUCSzURruspK65XnYsog==
X-Received: by 2002:a37:e04:: with SMTP id 4mr17763967qko.269.1596488376274;
 Mon, 03 Aug 2020 13:59:36 -0700 (PDT)
Received: from redhat.com (bzq-79-177-102-128.red.bezeqint.net.
 [79.177.102.128])
 by smtp.gmail.com with ESMTPSA id x13sm21991885qts.23.2020.08.03.13.59.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 03 Aug 2020 13:59:35 -0700 (PDT)
Date: Mon, 3 Aug 2020 16:59:32 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: linux-kernel@vger.kernel.org
Subject: [PATCH v2 13/24] virtio_mem: correct tags for config space fields
Message-ID: <20200803205814.540410-14-mst@redhat.com>
References: <20200803205814.540410-1-mst@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200803205814.540410-1-mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
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

Since this is a modern-only device,
tag config space fields as having little endian-ness.

TODO: check other uses of __virtioXX types in this header,
should probably be __leXX.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 include/uapi/linux/virtio_mem.h | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/include/uapi/linux/virtio_mem.h b/include/uapi/linux/virtio_mem.h
index a9ffe041843c..70e01c687d5e 100644
--- a/include/uapi/linux/virtio_mem.h
+++ b/include/uapi/linux/virtio_mem.h
@@ -185,27 +185,27 @@ struct virtio_mem_resp {
 
 struct virtio_mem_config {
 	/* Block size and alignment. Cannot change. */
-	__u64 block_size;
+	__le64 block_size;
 	/* Valid with VIRTIO_MEM_F_ACPI_PXM. Cannot change. */
-	__u16 node_id;
+	__le16 node_id;
 	__u8 padding[6];
 	/* Start address of the memory region. Cannot change. */
-	__u64 addr;
+	__le64 addr;
 	/* Region size (maximum). Cannot change. */
-	__u64 region_size;
+	__le64 region_size;
 	/*
 	 * Currently usable region size. Can grow up to region_size. Can
 	 * shrink due to VIRTIO_MEM_REQ_UNPLUG_ALL (in which case no config
 	 * update will be sent).
 	 */
-	__u64 usable_region_size;
+	__le64 usable_region_size;
 	/*
 	 * Currently used size. Changes due to plug/unplug requests, but no
 	 * config updates will be sent.
 	 */
-	__u64 plugged_size;
+	__le64 plugged_size;
 	/* Requested size. New plug requests cannot exceed it. Can change. */
-	__u64 requested_size;
+	__le64 requested_size;
 };
 
 #endif /* _LINUX_VIRTIO_MEM_H */
-- 
MST

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
