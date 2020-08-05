Return-Path: <SRS0=Keeg=BP=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3F47C433E0
	for <virtualization@archiver.kernel.org>; Wed,  5 Aug 2020 13:44:15 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C57722065C
	for <virtualization@archiver.kernel.org>; Wed,  5 Aug 2020 13:44:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fGrcCO3l"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C57722065C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id A34B122219;
	Wed,  5 Aug 2020 13:44:15 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id w2u7lms6rDG0; Wed,  5 Aug 2020 13:44:11 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id B14502083F;
	Wed,  5 Aug 2020 13:44:11 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 95C68C0051;
	Wed,  5 Aug 2020 13:44:11 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id E1FC7C004C
 for <virtualization@lists.linux-foundation.org>;
 Wed,  5 Aug 2020 13:44:10 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id CFB1D2034F
 for <virtualization@lists.linux-foundation.org>;
 Wed,  5 Aug 2020 13:44:10 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id T0Ef3QnIfcxk
 for <virtualization@lists.linux-foundation.org>;
 Wed,  5 Aug 2020 13:44:08 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-1.mimecast.com (us-smtp-delivery-1.mimecast.com
 [207.211.31.120])
 by silver.osuosl.org (Postfix) with ESMTPS id 64E0220BF8
 for <virtualization@lists.linux-foundation.org>;
 Wed,  5 Aug 2020 13:44:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1596635047;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=QhVm0jpCx0j1VjzEJrlev45JExYE6+1Gd5oJ2Fv0G+k=;
 b=fGrcCO3lJ9Cm1xcgMxSIhZzvfYNvcj7oGAxKWsp9CJs0f+IkFtgsIJXM99jCUCsJ7pCdwf
 a4jfN83xwMVZmRKESchbqtH1o/uOwmlmhkw9PjnS3zzScGcxs2MGdKl9ctE0S/6YoCctM1
 UbKC13frA1qnyn2jsp3O90sbmFwFies=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-433-C-FjoeguMMCxAiGvj7dcCA-1; Wed, 05 Aug 2020 09:44:05 -0400
X-MC-Unique: C-FjoeguMMCxAiGvj7dcCA-1
Received: by mail-wr1-f69.google.com with SMTP id r14so1528859wrq.3
 for <virtualization@lists.linux-foundation.org>;
 Wed, 05 Aug 2020 06:44:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=QhVm0jpCx0j1VjzEJrlev45JExYE6+1Gd5oJ2Fv0G+k=;
 b=K8U0a2jVQsY2ZLuKg/SONFnLjrYYFDe2RAZUCbvyOhY7gdxBmh4Z4iJunMDWNJYpxq
 s1Tjc5vMqhqg8C3yycxbqBwDweY98nq4vOuBotTdHzypZber2flPBzGin1QeLfxDDk9c
 2VmbH+mEt7vpZArQE4c2zYPfY2ZAu+HLJWcgEgDNHDRLOXo964gFmMSPFSP89GjUBObX
 nbc7aaFUS1ReRPP5OkSY3N/iEBOJvtduim/adCAQhzFhhUA+BffdGnRw98N6Uq1Q4pxy
 W5D+zm6VoO5EAGJ0YSiUwmgbfsIGaChiHekrFY3oIIIqDt5aN5w5l8ZjPWAzkxTkol+W
 pi2g==
X-Gm-Message-State: AOAM530/jY3u3m0AJHZwV4jYdroUtN1aXYZrsjvi9Wj7uRVGiCXqRxVS
 GqvmX8/BWWPkH3JKIf5TVht9YpvUKP5bWElWfd5s0wOytD6KVRBsfijj2Ut5H5DSt/GMvNj7cDd
 9jn2Lg9nBVZ8Su8Kndvm09vftDjYljihtl6lGFGx7kw==
X-Received: by 2002:a1c:e912:: with SMTP id q18mr3340534wmc.130.1596635044511; 
 Wed, 05 Aug 2020 06:44:04 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyNXwX/2HYdrh9bva0R4SCALRC4UH6tOenG7WilayDF9QXu8qTNoQRaplyGLd1b/SDfI6ylAQ==
X-Received: by 2002:a1c:e912:: with SMTP id q18mr3340516wmc.130.1596635044293; 
 Wed, 05 Aug 2020 06:44:04 -0700 (PDT)
Received: from redhat.com (bzq-79-178-123-8.red.bezeqint.net. [79.178.123.8])
 by smtp.gmail.com with ESMTPSA id
 t189sm2914860wmf.47.2020.08.05.06.44.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 05 Aug 2020 06:44:03 -0700 (PDT)
Date: Wed, 5 Aug 2020 09:44:02 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: linux-kernel@vger.kernel.org
Subject: [PATCH v3 17/38] virtio_config: disallow native type fields
Message-ID: <20200805134226.1106164-18-mst@redhat.com>
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

Transitional devices should all use __virtioXX types (and __leXX for
fields not present in legacy devices).
Modern ones should use __leXX.
_uXX type would be a bug.
Let's prevent that.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 include/linux/virtio_config.h | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/include/linux/virtio_config.h b/include/linux/virtio_config.h
index 64da491936f7..c68f58f3bf34 100644
--- a/include/linux/virtio_config.h
+++ b/include/linux/virtio_config.h
@@ -319,9 +319,8 @@ static inline __virtio64 cpu_to_virtio64(struct virtio_device *vdev, u64 val)
 	__virtio_pick_type(x, __u8, __u8,					\
 		__virtio_pick_endian(x, __virtio16, __virtio32, __virtio64,	\
 			__virtio_pick_endian(x, __le16, __le32, __le64,		\
-				__virtio_pick_endian(x, __u16, __u32, __u64,	\
-					/* No other type allowed */		\
-					(void)0)))))
+				/* No other type allowed */			\
+				(void)0))))
 
 #endif
 
-- 
MST

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
