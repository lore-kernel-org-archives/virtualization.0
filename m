Return-Path: <SRS0=ivLu=BN=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC183C433DF
	for <virtualization@archiver.kernel.org>; Mon,  3 Aug 2020 21:00:07 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DFA9722C9F
	for <virtualization@archiver.kernel.org>; Mon,  3 Aug 2020 21:00:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ShzDvIou"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DFA9722C9F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id 9A05186519;
	Mon,  3 Aug 2020 21:00:07 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id fzB62WMHeGMC; Mon,  3 Aug 2020 21:00:07 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id 1605E85E12;
	Mon,  3 Aug 2020 21:00:07 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 0D8D8C0050;
	Mon,  3 Aug 2020 21:00:07 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 0351DC004C
 for <virtualization@lists.linux-foundation.org>;
 Mon,  3 Aug 2020 21:00:05 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id 0002385B0D
 for <virtualization@lists.linux-foundation.org>;
 Mon,  3 Aug 2020 21:00:04 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Ke8KFjGYkOGJ
 for <virtualization@lists.linux-foundation.org>;
 Mon,  3 Aug 2020 21:00:04 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-1.mimecast.com (us-smtp-delivery-1.mimecast.com
 [207.211.31.120])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id 6B4CC844C9
 for <virtualization@lists.linux-foundation.org>;
 Mon,  3 Aug 2020 21:00:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1596488403;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=THaB8S+209mrmnxdJZIOkJCpQ5DDeAQcpm4IqDkBrvY=;
 b=ShzDvIouAfHBlYex5DjzZX1OMJs7oNUfLARN8iUs+VkyIJ7fpXjCWCw1p388k4TvLutRE1
 G4OAzdXnocGeT736w3qGECMf1iJ/WhO8FioQofkJ7BZUU/pNrSgD2jd7SKYbdywsmL2mK8
 YlzkOa5q8kKcEa1Qeetd5oG1hedsvaM=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-173-lOWX8nlINWaxzjNbMQTCTg-1; Mon, 03 Aug 2020 17:00:01 -0400
X-MC-Unique: lOWX8nlINWaxzjNbMQTCTg-1
Received: by mail-qt1-f200.google.com with SMTP id b18so14779275qte.18
 for <virtualization@lists.linux-foundation.org>;
 Mon, 03 Aug 2020 14:00:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=THaB8S+209mrmnxdJZIOkJCpQ5DDeAQcpm4IqDkBrvY=;
 b=umF2LrMpjO9KpYkuRgmDBtuGxSYsk+KRoaLLmS6wRHsOUg8GzTzRHj1DUNt/CqfzWd
 FscJEHeEehaMylkb9VWPLnSH8xAQAKOSoKQxkapiMh1HUw89AVJc3IJ+M+dEdY+JNKRn
 /zqgLlbe3qKH6bC2qX7+5LphyyfN1fWyrCRLKLLAB8wyQONwW3jQWDCas0cJ5+jV61f5
 2ZpicmkCGCRjYOW5Ruqqqw11MqtovzVrpGuk4D/rKEn59zhAKg/sfPaWksQ6QNN1EwZG
 OByrL0P2UaIUZgAa1Z26agB9eZ5m3gf23XJpX5j2s1UTiMUqKK5I9yn+cg4UQjmeXY9i
 CXmw==
X-Gm-Message-State: AOAM530uIb0xhcn2a1JzWSKMbLp3ZujPdFspv1Is4Y5IjBCW6Q7AwRaC
 FoTsZOasmn4ZUASgfjBjDQHxpU72vJpbkdhzc5zEipm5Pk2thiJYm22LuK2sS6zu+OFLuGDVa0q
 +2ieCY03xA9gR9Ke2LjtiZMuVF147c2jIDTwWUeb2nw==
X-Received: by 2002:ac8:520f:: with SMTP id r15mr19359539qtn.116.1596488401509; 
 Mon, 03 Aug 2020 14:00:01 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwpoSbBmND+77f/SL3KacqAGZQ60M66o69zSkBXnG4eygyZXA8NQ5Vn+5rYip5o5+5O6T9cDg==
X-Received: by 2002:ac8:520f:: with SMTP id r15mr19359526qtn.116.1596488401300; 
 Mon, 03 Aug 2020 14:00:01 -0700 (PDT)
Received: from redhat.com (bzq-79-177-102-128.red.bezeqint.net.
 [79.177.102.128])
 by smtp.gmail.com with ESMTPSA id w44sm23888660qtj.86.2020.08.03.13.59.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 03 Aug 2020 14:00:00 -0700 (PDT)
Date: Mon, 3 Aug 2020 16:59:57 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: linux-kernel@vger.kernel.org
Subject: [PATCH v2 17/24] virtio_config: disallow native type fields
Message-ID: <20200803205814.540410-18-mst@redhat.com>
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

Transitional devices should all use __virtioXX types.
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
