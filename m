Return-Path: <SRS0=Keeg=BP=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13763C433DF
	for <virtualization@archiver.kernel.org>; Wed,  5 Aug 2020 13:44:41 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CF0572065C
	for <virtualization@archiver.kernel.org>; Wed,  5 Aug 2020 13:44:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="aWG6Qzql"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CF0572065C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 8358886892;
	Wed,  5 Aug 2020 13:44:40 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id V8BD1kJkX2iU; Wed,  5 Aug 2020 13:44:40 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 2A9658672E;
	Wed,  5 Aug 2020 13:44:40 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 22489C0051;
	Wed,  5 Aug 2020 13:44:40 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 11731C004C
 for <virtualization@lists.linux-foundation.org>;
 Wed,  5 Aug 2020 13:44:39 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id F19EC8688A
 for <virtualization@lists.linux-foundation.org>;
 Wed,  5 Aug 2020 13:44:38 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id HZycNp-r6CPD
 for <virtualization@lists.linux-foundation.org>;
 Wed,  5 Aug 2020 13:44:38 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-delivery-1.mimecast.com (us-smtp-2.mimecast.com
 [205.139.110.61])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id 7884C86888
 for <virtualization@lists.linux-foundation.org>;
 Wed,  5 Aug 2020 13:44:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1596635077;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=aTite/iD0lQBRsDAUmY/i15AjG2mB78/HSvWX+2Oy3A=;
 b=aWG6Qzql2vlxW88X22+EgOqv3gLNlbSLAF1BWxcRK4Qo+AsW6CFMOKK8tT1yoJ5dYWlr1p
 GRexR8ycmbpkOkwtJrFFgB4VZrbLhpED4DVvXodEBY6xkh4j/l+yzTdMXXI1i5mc8ztf5F
 Knv8VrF7BzM+aQ2M9lDvG8HItT4ek50=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-276-VrVDuLBAPW-_nMDwC2d78w-1; Wed, 05 Aug 2020 09:44:34 -0400
X-MC-Unique: VrVDuLBAPW-_nMDwC2d78w-1
Received: by mail-wr1-f71.google.com with SMTP id s23so13430358wrb.12
 for <virtualization@lists.linux-foundation.org>;
 Wed, 05 Aug 2020 06:44:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=aTite/iD0lQBRsDAUmY/i15AjG2mB78/HSvWX+2Oy3A=;
 b=ML2HtWLxhI4j+Yf849d7J/krImro7pSRNzRIA1jZlMOBiDI4Rprf7npMwHDHJUJN8i
 AXWS8WekZv4h2zAFr7Cy5zfV3PxAt5g8MT6VOnkvPXXoruhZHw+19LQ+IPRQaLQcVK57
 E+dpg8xn5NJwmWbHOb7scBx/Cj61fRNRVCPjgO0CiDkhez3Ek/cW8jRjyBvsO4e0hqxi
 uyykIkrU0KfKy3eKTPCMmQfxKwnA0Yj2zUNQZEyqQiX0Dl3iYwevNwzTZjFDMJOaL21L
 b2QDmTGfejhiajeOUM7w0tydmzfA9ri4KLbC7Fcg3DWU/xj0XxCzas0vFYJzXTgrqFaR
 KThg==
X-Gm-Message-State: AOAM532SAVhuhD3LsCik1ZtKGvBayV27phiVSWj+VsDv9Ai+D0e1Oq0v
 brDgc/GPJ/rr/8V1wAHt9sjacFhAf+8KpLEojf5Oy2cB52NlltM6AukI32hGdXsK1Bt4tcWwZ+x
 lGPu6ccdHQdvaKMxi6rrIQRWN8lPKRHxknVeqrQ7fvg==
X-Received: by 2002:a1c:7915:: with SMTP id l21mr3585719wme.50.1596635073671; 
 Wed, 05 Aug 2020 06:44:33 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzBmRcbWg6Zcj3SVEKY1RPNAFRs6pH6ZTvrDA1nI/1TIiw8ZC6tgWC862aXu3/qn+3fvibSog==
X-Received: by 2002:a1c:7915:: with SMTP id l21mr3585709wme.50.1596635073461; 
 Wed, 05 Aug 2020 06:44:33 -0700 (PDT)
Received: from redhat.com ([192.117.173.58])
 by smtp.gmail.com with ESMTPSA id b77sm2354968wmb.3.2020.08.05.06.44.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 05 Aug 2020 06:44:32 -0700 (PDT)
Date: Wed, 5 Aug 2020 09:44:31 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: linux-kernel@vger.kernel.org
Subject: [PATCH v3 28/38] virtio_config: add virtio_cread_le_feature
Message-ID: <20200805134226.1106164-29-mst@redhat.com>
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

Mirrors virtio_cread_feature but for LE fields.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 include/linux/virtio_config.h | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/include/linux/virtio_config.h b/include/linux/virtio_config.h
index 5b5196fec899..cc7a2b1fd7b2 100644
--- a/include/linux/virtio_config.h
+++ b/include/linux/virtio_config.h
@@ -555,4 +555,14 @@ static inline void virtio_cwrite64(struct virtio_device *vdev,
 		_r;							\
 	})
 
+/* Conditional config space accessors. */
+#define virtio_cread_le_feature(vdev, fbit, structname, member, ptr)	\
+	({								\
+		int _r = 0;						\
+		if (!virtio_has_feature(vdev, fbit))			\
+			_r = -ENOENT;					\
+		else							\
+			virtio_cread_le((vdev), structname, member, ptr); \
+		_r;							\
+	})
 #endif /* _LINUX_VIRTIO_CONFIG_H */
-- 
MST

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
