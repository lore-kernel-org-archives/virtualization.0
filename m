Return-Path: <SRS0=Keeg=BP=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64D52C433E0
	for <virtualization@archiver.kernel.org>; Wed,  5 Aug 2020 13:44:36 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 386862065C
	for <virtualization@archiver.kernel.org>; Wed,  5 Aug 2020 13:44:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KFs3GJfY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 386862065C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id 22B3087828;
	Wed,  5 Aug 2020 13:44:36 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id FILFQGt4S3AR; Wed,  5 Aug 2020 13:44:35 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id 91C478781C;
	Wed,  5 Aug 2020 13:44:35 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 88B2DC0051;
	Wed,  5 Aug 2020 13:44:35 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 68078C004C
 for <virtualization@lists.linux-foundation.org>;
 Wed,  5 Aug 2020 13:44:33 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id 57AEC88221
 for <virtualization@lists.linux-foundation.org>;
 Wed,  5 Aug 2020 13:44:33 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id JP-lA4qGrtUF
 for <virtualization@lists.linux-foundation.org>;
 Wed,  5 Aug 2020 13:44:32 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-1.mimecast.com (us-smtp-delivery-1.mimecast.com
 [205.139.110.120])
 by hemlock.osuosl.org (Postfix) with ESMTPS id BEACB8820F
 for <virtualization@lists.linux-foundation.org>;
 Wed,  5 Aug 2020 13:44:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1596635071;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Oi4CR23bemPbIyBSn03I/oQ2VbOHBaULBpoKArW5b+0=;
 b=KFs3GJfYfcqG+BPYZEdsKY/3uga7liEr+xIin00HP4YUcaEONf8OAqF/59r2tz7P5NfzKl
 HsF85r/WcKX+y3kYULi3TBdldYHGFkcIfouHlxVNxgvL2oIpKt8dZrN++zdpa2BCGwOrgI
 49MIr5uSCk+2RqlDrvvQOxMNCk+EePY=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-62-MAmppC3MNHGEwkEOhhaEDA-1; Wed, 05 Aug 2020 09:44:29 -0400
X-MC-Unique: MAmppC3MNHGEwkEOhhaEDA-1
Received: by mail-wm1-f69.google.com with SMTP id u144so2740865wmu.3
 for <virtualization@lists.linux-foundation.org>;
 Wed, 05 Aug 2020 06:44:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=Oi4CR23bemPbIyBSn03I/oQ2VbOHBaULBpoKArW5b+0=;
 b=QC5hLflAU+SL6fDvba/DqZzWmDiqOZadX0DaPm/AyWj8bRtMq3SmF0tuLvJ/qcLJyU
 hr1wP7lqG/xlmRgO+BZLLFA5DjXWGs+TyTAZvcBtPC7Cf5/AOefXArHGh0rv7mCCs2L4
 QDpfqp9Qvz+qRTFUnXFGK+eAg4pg3jyDtRS2+x6a0VKAZeEWCRG+7HZQOzR9kk3oMJ0w
 yvPTkOi/oBAfEOnO2VOHi+jNbgskqPJ4TgrOUG+kpjF4AQeUbuK4EAHkHFvwuRpIJ92O
 VQLwQRygzMVcEea8szE/eYmGtm0vVivkKR/ccKvqRyRz8JfDAbeYM2dJvmXzLGDNeEU5
 SJ7w==
X-Gm-Message-State: AOAM533xu6jzQyRjp6eYrSDsHY3ppqoXMHOsrtCFzeJVYKJ3G8SvOyME
 48ZLIN7Mr5wMP9Sy0B6oil5JYrRVYms8peSmjp/lBS2TC0/9vuknGe8YD5QCeKehRytsfQmT79r
 cZ27Gh8wCtYdHFMBRKH2G+dVo+QkAyhsbS4hO7/14zA==
X-Received: by 2002:a7b:cc90:: with SMTP id p16mr3095001wma.79.1596635068412; 
 Wed, 05 Aug 2020 06:44:28 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJznD7SElHR1ba9YFcNoWzD+TthlJQKN9Qe3cw8IS76anMHj+jkdeXutWXn0hFJZpgmXPOns7Q==
X-Received: by 2002:a7b:cc90:: with SMTP id p16mr3094984wma.79.1596635068196; 
 Wed, 05 Aug 2020 06:44:28 -0700 (PDT)
Received: from redhat.com (bzq-79-178-123-8.red.bezeqint.net. [79.178.123.8])
 by smtp.gmail.com with ESMTPSA id
 y203sm2960492wmc.29.2020.08.05.06.44.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 05 Aug 2020 06:44:27 -0700 (PDT)
Date: Wed, 5 Aug 2020 09:44:26 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: linux-kernel@vger.kernel.org
Subject: [PATCH v3 26/38] virtio_config: LE config space accessors
Message-ID: <20200805134226.1106164-27-mst@redhat.com>
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

To be used by modern code, as well as to handle LE only fields such as
balloon.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 include/linux/virtio_config.h | 65 +++++++++++++++++++++++++++++++++++
 1 file changed, 65 insertions(+)

diff --git a/include/linux/virtio_config.h b/include/linux/virtio_config.h
index 441fd6dd42ab..5b5196fec899 100644
--- a/include/linux/virtio_config.h
+++ b/include/linux/virtio_config.h
@@ -375,6 +375,71 @@ static inline __virtio64 cpu_to_virtio64(struct virtio_device *vdev, u64 val)
 				  sizeof(virtio_cwrite_v));		\
 	} while(0)
 
+/*
+ * Nothing virtio-specific about these, but let's worry about generalizing
+ * these later.
+ */
+#define virtio_le_to_cpu(x) \
+	_Generic((x), \
+		__u8: (x), \
+		 __le16: le16_to_cpu(x), \
+		 __le32: le32_to_cpu(x), \
+		 __le64: le64_to_cpu(x) \
+		)
+
+#define virtio_cpu_to_le(x, m) \
+	_Generic((m), \
+		 __u8: (x), \
+		 __le16: cpu_to_le16(x), \
+		 __le32: cpu_to_le32(x), \
+		 __le64: cpu_to_le64(x) \
+		)
+
+/* LE (e.g. modern) Config space accessors. */
+#define virtio_cread_le(vdev, structname, member, ptr)			\
+	do {								\
+		typeof(((structname*)0)->member) virtio_cread_v;	\
+									\
+		might_sleep();						\
+		/* Sanity check: must match the member's type */	\
+		typecheck(typeof(virtio_le_to_cpu(virtio_cread_v)), *(ptr)); \
+									\
+		switch (sizeof(virtio_cread_v)) {			\
+		case 1:							\
+		case 2:							\
+		case 4:							\
+			vdev->config->get((vdev), 			\
+					  offsetof(structname, member), \
+					  &virtio_cread_v,		\
+					  sizeof(virtio_cread_v));	\
+			break;						\
+		default:						\
+			__virtio_cread_many((vdev), 			\
+					  offsetof(structname, member), \
+					  &virtio_cread_v,		\
+					  1,				\
+					  sizeof(virtio_cread_v));	\
+			break;						\
+		}							\
+		*(ptr) = virtio_le_to_cpu(virtio_cread_v);		\
+	} while(0)
+
+/* Config space accessors. */
+#define virtio_cwrite_le(vdev, structname, member, ptr)			\
+	do {								\
+		typeof(((structname*)0)->member) virtio_cwrite_v =	\
+			virtio_cpu_to_le(*(ptr), ((structname*)0)->member); \
+									\
+		might_sleep();						\
+		/* Sanity check: must match the member's type */	\
+		typecheck(typeof(virtio_le_to_cpu(virtio_cwrite_v)), *(ptr)); \
+									\
+		vdev->config->set((vdev), offsetof(structname, member),	\
+				  &virtio_cwrite_v,			\
+				  sizeof(virtio_cwrite_v));		\
+	} while(0)
+
+
 /* Read @count fields, @bytes each. */
 static inline void __virtio_cread_many(struct virtio_device *vdev,
 				       unsigned int offset,
-- 
MST

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
