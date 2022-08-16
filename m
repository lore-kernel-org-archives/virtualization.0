Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 493AFC2BB41
	for <virtualization@archiver.kernel.org>; Tue, 16 Aug 2022 07:48:40 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id CC506812F2;
	Tue, 16 Aug 2022 07:48:39 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org CC506812F2
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.a=rsa-sha256 header.s=2020 header.b=OsO6XOZ3;
	dkim=fail reason="signature verification failed" header.d=linutronix.de header.i=@linutronix.de header.a=ed25519-sha256 header.s=2020e header.b=+/ZQQPk5
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id m_hoUy5at2Eg; Tue, 16 Aug 2022 07:48:39 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 6F9F88128B;
	Tue, 16 Aug 2022 07:48:38 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 6F9F88128B
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 3DCB3C0032;
	Tue, 16 Aug 2022 07:48:38 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id B70D4C002D
 for <virtualization@lists.linux-foundation.org>;
 Tue, 16 Aug 2022 07:48:36 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 91B9160760
 for <virtualization@lists.linux-foundation.org>;
 Tue, 16 Aug 2022 07:48:36 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 91B9160760
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de
 header.a=rsa-sha256 header.s=2020 header.b=OsO6XOZ3; 
 dkim=pass header.d=linutronix.de header.i=@linutronix.de
 header.a=ed25519-sha256 header.s=2020e header.b=+/ZQQPk5
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id EJrm41ntZhws
 for <virtualization@lists.linux-foundation.org>;
 Tue, 16 Aug 2022 07:48:36 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org B0BB3600CD
Received: from galois.linutronix.de (Galois.linutronix.de
 [IPv6:2a0a:51c0:0:12e:550::1])
 by smtp3.osuosl.org (Postfix) with ESMTPS id B0BB3600CD
 for <virtualization@lists.linux-foundation.org>;
 Tue, 16 Aug 2022 07:48:35 +0000 (UTC)
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
 s=2020; t=1660636111;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=Kq23wt13aEDGrrNwPR0CNKQbr9ikiQd5pqFGW4CuUhE=;
 b=OsO6XOZ32b1UjWc49xNNPVgbBr9i/bFEpPgjVCc60yr5OVOoy9Dk+gnKeMkNUsbszaV7AE
 USM/NIOIcGH4os8xBgbEWOgJHw1cpn2edSntgUFgThWH/EfCn30xD5DROc6Sjf2rL6C8HZ
 BRyA490ZfV8AKWy9GEjeVAv+N6EgfWBnIB1+FaeXkHfz2qzP3NTlBGKwbo71RZPeyJDJuC
 7pMf6bFTvQT3i78vPPHvEg9aSUK8TthNnvoNWiyvekVqX0UuzEXdq3topphiIIscexTRsj
 Gn7fWmZVqUJ+pfSQT1ipdO9VTblXMQSgdTye3KxPy9JdSAWx5lsNKctRQ9LkkQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
 s=2020e; t=1660636111;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=Kq23wt13aEDGrrNwPR0CNKQbr9ikiQd5pqFGW4CuUhE=;
 b=+/ZQQPk5vWX79GxPwLy2SErvvYsIBzy8tqivtDloNFmFhtpHYcwYBARWm1vtyzIVUBJTSM
 80qELTcy3TAYQWCw==
To: virtualization@lists.linux-foundation.org
Subject: [PATCH] vduse:  Remove include of rwlock.h
Date: Tue, 16 Aug 2022 09:48:16 +0200
Message-Id: <20220816074816.173227-1-bigeasy@linutronix.de>
MIME-Version: 1.0
Cc: Xie Yongji <xieyongji@bytedance.com>, Thomas Gleixner <tglx@linutronix.de>,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 "Michael S. Tsirkin" <mst@redhat.com>
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

rwlock.h should not be included directly. Instead linux/splinlock.h
should be included. Including it directly will break the RT build.

Remove the rwlock.h include.

Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 drivers/vdpa/vdpa_user/iova_domain.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/vdpa/vdpa_user/iova_domain.h b/drivers/vdpa/vdpa_user/iova_domain.h
index 4e0e50e7ac153..173e979b84a93 100644
--- a/drivers/vdpa/vdpa_user/iova_domain.h
+++ b/drivers/vdpa/vdpa_user/iova_domain.h
@@ -14,7 +14,6 @@
 #include <linux/iova.h>
 #include <linux/dma-mapping.h>
 #include <linux/vhost_iotlb.h>
-#include <linux/rwlock.h>
 
 #define IOVA_START_PFN 1
 
-- 
2.37.2

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
