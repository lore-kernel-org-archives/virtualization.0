Return-Path: <SRS0=Keeg=BP=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3135C433E1
	for <virtualization@archiver.kernel.org>; Wed,  5 Aug 2020 13:43:51 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 78EE622D05
	for <virtualization@archiver.kernel.org>; Wed,  5 Aug 2020 13:43:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZIScxlAC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 78EE622D05
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id 566FB8815E;
	Wed,  5 Aug 2020 13:43:51 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ttfo+YJVLYig; Wed,  5 Aug 2020 13:43:50 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id E09A88796D;
	Wed,  5 Aug 2020 13:43:50 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id CBBC5C0051;
	Wed,  5 Aug 2020 13:43:50 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id F20DFC004C
 for <virtualization@lists.linux-foundation.org>;
 Wed,  5 Aug 2020 13:43:49 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id E0C1A8816B
 for <virtualization@lists.linux-foundation.org>;
 Wed,  5 Aug 2020 13:43:49 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id OZGi3LG8QUoc
 for <virtualization@lists.linux-foundation.org>;
 Wed,  5 Aug 2020 13:43:49 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-1.mimecast.com (us-smtp-delivery-1.mimecast.com
 [205.139.110.120])
 by hemlock.osuosl.org (Postfix) with ESMTPS id 6549D8796D
 for <virtualization@lists.linux-foundation.org>;
 Wed,  5 Aug 2020 13:43:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1596635028;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=QNkBL0MOslnxA1lTPWBDwCkBLDnBYOCw/rGPZtjWTCU=;
 b=ZIScxlACOASOF8EC8m6eNcqI31nt6wZ8BFjuyIJ67yHc7UTx+Rcc0UUVPAVunqyEPWSnFQ
 EzMhI86Cit8QzlKlbLspt6cLm8WIZU5ifvMkiTUtliZsmmyKn7Yqx6Ln2Nj50nek3z1i9Q
 k3V1hBND3IkzG2tmjn6yo6V3sYxCArc=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-22-a9tAqizoNa6llmaB6T22xg-1; Wed, 05 Aug 2020 09:43:46 -0400
X-MC-Unique: a9tAqizoNa6llmaB6T22xg-1
Received: by mail-wr1-f69.google.com with SMTP id z12so13640312wrl.16
 for <virtualization@lists.linux-foundation.org>;
 Wed, 05 Aug 2020 06:43:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=QNkBL0MOslnxA1lTPWBDwCkBLDnBYOCw/rGPZtjWTCU=;
 b=iAfe4nr5HuIsrA/VlkBCJNa2VWSalgwOjJSK/jQ5SoIzn48brYnkmIKeu4C+mdmkKB
 HUxhn3JsnXGQlPVcG7ieIUehThtYYyyNRRC3ooiRh4966605vh7btBmW989cbIBzFqhd
 p2iQ+cxXPyZP4H4GHIl6QkSjcvcipE3EWLpdMgFnvjn9Fa1229D2ku++MLjHj0PhtVEo
 XJAzHXKFsDgD2HnAGzclEGj+JlBTrgtwaTBjvy8JBDrloFLqKbwk6wsdZbnJBWtN1SBN
 NaUER5QgpQD61hZMTvjsDTLYCzYX5Yx2h6SKl5gJDQRGqOCuimAiWkJ4BHXmkapfk7yu
 H81A==
X-Gm-Message-State: AOAM5326Sp279dUZEVg6EzuL6RIK2Vd7ToEZdbGAO+yn4Q0DPkiWZ8rI
 qrhysZyRBkwAeq7QSeOnfTbslEbTYYh5W1QmF98bLA6iuKbJp+/nvFqx840qxcJ/AlW4rpz+1Z1
 Np4Pku0GYO36z4rOVhOzHCyqFtuPaQ5X8J9ynOyLomQ==
X-Received: by 2002:adf:f64a:: with SMTP id x10mr2692843wrp.99.1596635025555; 
 Wed, 05 Aug 2020 06:43:45 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJw+wOWu/BUGFDnYiFNkYnDk0qc3NvkypKVIbTb4eZBzRtJysZaIOINp4bGehYs8hyi8ABgcfQ==
X-Received: by 2002:adf:f64a:: with SMTP id x10mr2692831wrp.99.1596635025403; 
 Wed, 05 Aug 2020 06:43:45 -0700 (PDT)
Received: from redhat.com (bzq-79-180-0-181.red.bezeqint.net. [79.180.0.181])
 by smtp.gmail.com with ESMTPSA id
 s131sm2941176wme.17.2020.08.05.06.43.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 05 Aug 2020 06:43:44 -0700 (PDT)
Date: Wed, 5 Aug 2020 09:43:42 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: linux-kernel@vger.kernel.org
Subject: [PATCH v3 10/38] virtio_gpu: correct tags for config space fields
Message-ID: <20200805134226.1106164-11-mst@redhat.com>
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
Cc: David Airlie <airlied@linux.ie>, Cornelia Huck <cohuck@redhat.com>,
 dri-devel@lists.freedesktop.org, virtualization@lists.linux-foundation.org
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

Since gpu is a modern-only device,
tag config space fields as having little endian-ness.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Reviewed-by: Cornelia Huck <cohuck@redhat.com>
---
 include/uapi/linux/virtio_gpu.h | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/include/uapi/linux/virtio_gpu.h b/include/uapi/linux/virtio_gpu.h
index 0c85914d9369..ccbd174ef321 100644
--- a/include/uapi/linux/virtio_gpu.h
+++ b/include/uapi/linux/virtio_gpu.h
@@ -320,10 +320,10 @@ struct virtio_gpu_resp_edid {
 #define VIRTIO_GPU_EVENT_DISPLAY (1 << 0)
 
 struct virtio_gpu_config {
-	__u32 events_read;
-	__u32 events_clear;
-	__u32 num_scanouts;
-	__u32 num_capsets;
+	__le32 events_read;
+	__le32 events_clear;
+	__le32 num_scanouts;
+	__le32 num_capsets;
 };
 
 /* simple formats for fbcon/X use */
-- 
MST

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
