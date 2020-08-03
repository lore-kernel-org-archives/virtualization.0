Return-Path: <SRS0=ivLu=BN=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08C83C433DF
	for <virtualization@archiver.kernel.org>; Mon,  3 Aug 2020 21:00:35 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 086D722C9F
	for <virtualization@archiver.kernel.org>; Mon,  3 Aug 2020 21:00:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IGd8DcSY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 086D722C9F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id A5D9887AAF;
	Mon,  3 Aug 2020 21:00:34 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id CVeZhQuiSHnd; Mon,  3 Aug 2020 21:00:34 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id 2C7DB8782A;
	Mon,  3 Aug 2020 21:00:34 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 18FAEC0050;
	Mon,  3 Aug 2020 21:00:34 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 46640C004C
 for <virtualization@lists.linux-foundation.org>;
 Mon,  3 Aug 2020 21:00:32 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 3596E85E12
 for <virtualization@lists.linux-foundation.org>;
 Mon,  3 Aug 2020 21:00:32 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 2cS52XFGm+P2
 for <virtualization@lists.linux-foundation.org>;
 Mon,  3 Aug 2020 21:00:31 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-1.mimecast.com (us-smtp-delivery-1.mimecast.com
 [207.211.31.120])
 by whitealder.osuosl.org (Postfix) with ESMTPS id 9311485A90
 for <virtualization@lists.linux-foundation.org>;
 Mon,  3 Aug 2020 21:00:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1596488430;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=kSRe7wmYN+c40TNuZd0aK8LNMOsV+g9hMYDNFujk/tc=;
 b=IGd8DcSYa9RHW5IYgjVaeplNJUjbVV/lIii0MnkbIUVBRp7bwyz6gdQCX3RdvIzgMlHm0A
 czJmZTYtGsr5z8iIM+tNdAWn1XTHjMHVDIv5SGuHq7f8ECb9+JNAbFgTS+IiqJOxrgWlTb
 pkge2bKZ0w2KDqZVcTOTSRfMANa1Ot0=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-317-rzqAQ9OJOTeuJ9Gle3FEyg-1; Mon, 03 Aug 2020 17:00:29 -0400
X-MC-Unique: rzqAQ9OJOTeuJ9Gle3FEyg-1
Received: by mail-qk1-f199.google.com with SMTP id q18so23805418qkq.11
 for <virtualization@lists.linux-foundation.org>;
 Mon, 03 Aug 2020 14:00:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=kSRe7wmYN+c40TNuZd0aK8LNMOsV+g9hMYDNFujk/tc=;
 b=bHCVmUwVdwt/B4258xc/E2cHdKOuM/yQIf2tU2Ccuj5ZfTAilqip8Bxpc5iWJB0C9p
 x33xJLTP6XhcO70Y2A1Mh6v2Fy/FAWuzlZGypr4wJgCLp9O/b2QO/sKaHDQ4cTT1PtAQ
 z0z/nYRp6eF2TY9rQf8kZ4zmAR0cYhNSZysToMvCUOlhW1uQdDoMrfr6ULJBOurtvZ3j
 JjDDOfsprbej7zkHi/u15XsZj9BC2mQTpkL6hyK+E4zy/5WHTdtXB7pkuXKq8eUvJPpA
 W3HgeWtq+Ld3d9nRc8tibtxR3Oy3aGTtEvWqYOJXqON43uGR3u5XLkznuJ97E5E/K0Np
 gn4g==
X-Gm-Message-State: AOAM5334z0t+XQSSUueRl8LauZBvmHukf2WNawL/KFhSnLH/EK/5cKqb
 ZbsvKu1BCo8zdI2tBEEIjopIAa7cTjlQPSj27rQmqi3oGpYiD+wkLMi50GsvAwxPxHkyGyipRHI
 JTKVDDiHVNmeRWxbDdejhn4+cX7a8YH06j5+YKZYwxw==
X-Received: by 2002:aed:3203:: with SMTP id y3mr18662628qtd.376.1596488428499; 
 Mon, 03 Aug 2020 14:00:28 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyytSR2o8DqbLBPnR7jLzUuJzz/9lygAGjqsOnx/cmHBbbEeMQdbF76xlz6+tLx56E25N+M/Q==
X-Received: by 2002:aed:3203:: with SMTP id y3mr18662607qtd.376.1596488428289; 
 Mon, 03 Aug 2020 14:00:28 -0700 (PDT)
Received: from redhat.com (bzq-79-177-102-128.red.bezeqint.net.
 [79.177.102.128])
 by smtp.gmail.com with ESMTPSA id o37sm24591606qte.9.2020.08.03.14.00.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 03 Aug 2020 14:00:27 -0700 (PDT)
Date: Mon, 3 Aug 2020 17:00:24 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: linux-kernel@vger.kernel.org
Subject: [PATCH v2 23/24] virtio_config: cread/write cleanup
Message-ID: <20200803205814.540410-24-mst@redhat.com>
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

Use vars of the correct type instead of casting.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 include/linux/virtio_config.h | 31 +++++++++++++++++++------------
 1 file changed, 19 insertions(+), 12 deletions(-)

diff --git a/include/linux/virtio_config.h b/include/linux/virtio_config.h
index c68f58f3bf34..5c3b02245ecd 100644
--- a/include/linux/virtio_config.h
+++ b/include/linux/virtio_config.h
@@ -444,53 +444,60 @@ static inline void virtio_cwrite8(struct virtio_device *vdev,
 static inline u16 virtio_cread16(struct virtio_device *vdev,
 				 unsigned int offset)
 {
-	u16 ret;
+	__virtio16 ret;
 
 	might_sleep();
 	vdev->config->get(vdev, offset, &ret, sizeof(ret));
-	return virtio16_to_cpu(vdev, (__force __virtio16)ret);
+	return virtio16_to_cpu(vdev, ret);
 }
 
 static inline void virtio_cwrite16(struct virtio_device *vdev,
 				   unsigned int offset, u16 val)
 {
+	__virtio16 v;
+
 	might_sleep();
-	val = (__force u16)cpu_to_virtio16(vdev, val);
-	vdev->config->set(vdev, offset, &val, sizeof(val));
+	v = cpu_to_virtio16(vdev, val);
+	vdev->config->set(vdev, offset, &v, sizeof(v));
 }
 
 static inline u32 virtio_cread32(struct virtio_device *vdev,
 				 unsigned int offset)
 {
-	u32 ret;
+	__virtio32 ret;
 
 	might_sleep();
 	vdev->config->get(vdev, offset, &ret, sizeof(ret));
-	return virtio32_to_cpu(vdev, (__force __virtio32)ret);
+	return virtio32_to_cpu(vdev, ret);
 }
 
 static inline void virtio_cwrite32(struct virtio_device *vdev,
 				   unsigned int offset, u32 val)
 {
+	__virtio32 v;
+
 	might_sleep();
-	val = (__force u32)cpu_to_virtio32(vdev, val);
-	vdev->config->set(vdev, offset, &val, sizeof(val));
+	v = cpu_to_virtio32(vdev, val);
+	vdev->config->set(vdev, offset, &v, sizeof(v));
 }
 
 static inline u64 virtio_cread64(struct virtio_device *vdev,
 				 unsigned int offset)
 {
-	u64 ret;
+	__virtio64 ret;
+
 	__virtio_cread_many(vdev, offset, &ret, 1, sizeof(ret));
-	return virtio64_to_cpu(vdev, (__force __virtio64)ret);
+	return virtio64_to_cpu(vdev, ret);
 }
 
 static inline void virtio_cwrite64(struct virtio_device *vdev,
 				   unsigned int offset, u64 val)
 {
+	__virtio64 v;
+
 	might_sleep();
-	val = (__force u64)cpu_to_virtio64(vdev, val);
-	vdev->config->set(vdev, offset, &val, sizeof(val));
+	v = cpu_to_virtio64(vdev, val);
+	vdev->config->set(vdev, offset, &v, sizeof(v));
 }
 
 /* Conditional config space accessors. */
-- 
MST

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
