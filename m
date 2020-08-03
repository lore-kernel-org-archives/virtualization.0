Return-Path: <SRS0=ivLu=BN=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F295C433E0
	for <virtualization@archiver.kernel.org>; Mon,  3 Aug 2020 20:58:53 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9378022C9F
	for <virtualization@archiver.kernel.org>; Mon,  3 Aug 2020 20:58:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WxpH72H+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9378022C9F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id 384D28573E;
	Mon,  3 Aug 2020 20:58:53 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id FoYtaiT-+Jih; Mon,  3 Aug 2020 20:58:52 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id B97CD8555A;
	Mon,  3 Aug 2020 20:58:52 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id A4BD3C0050;
	Mon,  3 Aug 2020 20:58:52 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 49451C004C
 for <virtualization@lists.linux-foundation.org>;
 Mon,  3 Aug 2020 20:58:51 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id 388F9844DC
 for <virtualization@lists.linux-foundation.org>;
 Mon,  3 Aug 2020 20:58:51 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id G7NRx_BtH1dN
 for <virtualization@lists.linux-foundation.org>;
 Mon,  3 Aug 2020 20:58:49 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-1.mimecast.com (us-smtp-delivery-1.mimecast.com
 [205.139.110.120])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id 301CB84496
 for <virtualization@lists.linux-foundation.org>;
 Mon,  3 Aug 2020 20:58:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1596488327;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=UIoKJgwiwHBXzqx7bTTScO5nMJSnsWEl2/CTLb7XXEY=;
 b=WxpH72H+L3sEB6TtSnxqb7vFux0fo9ihkEyrlYNMLIus6La1k0/czg57pjXkaE2a/PNyTE
 Y4+zBHEM3zX//ej1mB9TpKGWFTRhcpCzmzKt1kdoCoqkUmkM+FXgElXjTAMFSXYOhhsd2P
 YOTTqGQkZZhnvxYPJwgrPt4OVVDLGnM=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-44-QnGC4Q5cP12j5mZ-XbBwqg-1; Mon, 03 Aug 2020 16:58:46 -0400
X-MC-Unique: QnGC4Q5cP12j5mZ-XbBwqg-1
Received: by mail-qt1-f198.google.com with SMTP id h10so27790175qtc.4
 for <virtualization@lists.linux-foundation.org>;
 Mon, 03 Aug 2020 13:58:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=UIoKJgwiwHBXzqx7bTTScO5nMJSnsWEl2/CTLb7XXEY=;
 b=Sg8Wpt0Y6IAqil2yq0mm/xbWcrTHl6aFDV9G0hm/68UjkC0ibdGGimljxni2glJeiN
 oCO6XM1f2pYEXnDdebNq1oCh1obwO//sWWLpjrzk2KAUtBoy0u/6BS2jctIQXWaY0n2p
 qvtuVrV/L9FRsu4vHeeD+r9CAtE4MwuVhgRNvAq9X2aRVv6Pa5i68paK50A6QlXaRe0A
 N+hab+61FYIknIpiZ6T7bhtdQocQyDAdUdXno5/n/Bj+/iguuJKvNWwEquyViI8clY91
 0qpbvjryzTBep6w9Jko/FlWWZZz0h4BjCewmnEK0RKnu3klvk8wmMNdfOUQycxFIdFlj
 V2GQ==
X-Gm-Message-State: AOAM5314o/s0EZalOGeCF3Gy5L+X+NM4LpXN8CS/+M08Odw/Dt9ISm8u
 QjYv+YnMTVF5O8qFMn9osVVQubPD9KIPLGfAqbW/wGlNcqiV49hCPuPpuSsYHALPADnn6kbYJ4e
 IL659M3aG5qMNUVSRyYt7Xx13IAiUWrPZdZYuD2yn0A==
X-Received: by 2002:a05:620a:13cf:: with SMTP id
 g15mr16786169qkl.48.1596488325833; 
 Mon, 03 Aug 2020 13:58:45 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJz/usVrinipJ2UNkJyBG8SnnEAzcc9qw/4hOyTpADhTf+Pw3MhloA9MKuwjt0FKT+pTufaqUQ==
X-Received: by 2002:a05:620a:13cf:: with SMTP id
 g15mr16786157qkl.48.1596488325620; 
 Mon, 03 Aug 2020 13:58:45 -0700 (PDT)
Received: from redhat.com (bzq-79-177-102-128.red.bezeqint.net.
 [79.177.102.128])
 by smtp.gmail.com with ESMTPSA id i19sm19925205qkk.68.2020.08.03.13.58.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 03 Aug 2020 13:58:45 -0700 (PDT)
Date: Mon, 3 Aug 2020 16:58:42 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: linux-kernel@vger.kernel.org
Subject: [PATCH v2 02/24] virtio_ring: sparse warning fixup
Message-ID: <20200803205814.540410-3-mst@redhat.com>
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

virtio_store_mb was built with split ring in mind so it accepts
__virtio16 arguments. Packed ring uses __le16 values, so sparse
complains.  It's just a store with some barriers so let's convert it to
a macro, we don't loose too much type safety by doing that.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 include/linux/virtio_ring.h | 19 +++++++++----------
 1 file changed, 9 insertions(+), 10 deletions(-)

diff --git a/include/linux/virtio_ring.h b/include/linux/virtio_ring.h
index 3dc70adfe5f5..b485b13fa50b 100644
--- a/include/linux/virtio_ring.h
+++ b/include/linux/virtio_ring.h
@@ -46,16 +46,15 @@ static inline void virtio_wmb(bool weak_barriers)
 		dma_wmb();
 }
 
-static inline void virtio_store_mb(bool weak_barriers,
-				   __virtio16 *p, __virtio16 v)
-{
-	if (weak_barriers) {
-		virt_store_mb(*p, v);
-	} else {
-		WRITE_ONCE(*p, v);
-		mb();
-	}
-}
+#define virtio_store_mb(weak_barriers, p, v) \
+do { \
+	if (weak_barriers) { \
+		virt_store_mb(*p, v); \
+	} else { \
+		WRITE_ONCE(*p, v); \
+		mb(); \
+	} \
+} while (0) \
 
 struct virtio_device;
 struct virtqueue;
-- 
MST

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
