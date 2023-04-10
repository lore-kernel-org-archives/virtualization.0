Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2E193C77B61
	for <virtualization@archiver.kernel.org>; Mon, 10 Apr 2023 11:28:57 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 9B9FC40A86;
	Mon, 10 Apr 2023 11:28:56 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 9B9FC40A86
Authentication-Results: smtp2.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igel-co-jp.20210112.gappssmtp.com header.i=@igel-co-jp.20210112.gappssmtp.com header.a=rsa-sha256 header.s=20210112 header.b=1MJHz5Hj
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id MQOPQ6dXWc8Q; Mon, 10 Apr 2023 11:28:55 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 362FD400A6;
	Mon, 10 Apr 2023 11:28:55 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 362FD400A6
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id E8876C0037;
	Mon, 10 Apr 2023 11:28:54 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id E99F3C002A
 for <virtualization@lists.linux-foundation.org>;
 Mon, 10 Apr 2023 11:28:53 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id B1C0B40A7F
 for <virtualization@lists.linux-foundation.org>;
 Mon, 10 Apr 2023 11:28:53 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org B1C0B40A7F
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id o1jqWhOefN-o
 for <virtualization@lists.linux-foundation.org>;
 Mon, 10 Apr 2023 11:28:53 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 29833400A6
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com
 [IPv6:2607:f8b0:4864:20::636])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 29833400A6
 for <virtualization@lists.linux-foundation.org>;
 Mon, 10 Apr 2023 11:28:53 +0000 (UTC)
Received: by mail-pl1-x636.google.com with SMTP id o2so4407392plg.4
 for <virtualization@lists.linux-foundation.org>;
 Mon, 10 Apr 2023 04:28:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=igel-co-jp.20210112.gappssmtp.com; s=20210112; t=1681126132;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=VkNfRS2z4TLrRnI95YkzXxtnMiNB9VejbuSfHWwKvfU=;
 b=1MJHz5HjiAZ0Plo62ALxgwSJLnz60cwmLyvXZWvPxOMsoXI9uNFNss3qBh3O5xa5mg
 9NYZnCt3Gt8PmPsES3zZUX9yM92k9hTDoAkLr5ntVVxen1NDn+B3mxmGLiElo1NDdahL
 iaeltav6IJvc9rj8oF70stZYXcTblA0vgMj493XdWPeKLekTXHHtpF1qL5MT+8wa3TWB
 fED/Lscsb36TMigS/BqIh5Ve77DpRxERm2Pb9z/GccceUk2+zRnEbP4+1cG5a2SSOdlT
 PvK7sHplNo2lA2hM7vqkMhVgHncPkZfP+d0x2lyULWsJh7sp75gpRBAmir8nZib66xML
 Heog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112; t=1681126132;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=VkNfRS2z4TLrRnI95YkzXxtnMiNB9VejbuSfHWwKvfU=;
 b=KVDhQcynjT//ksONSErOU0IZrg2hfZl5Ye5CY9qfK5j2C6RydZI1QwtJWVlnWzTt22
 kHREzjMQ46NEOqNYbnTbm2U43+Jj7Rl+/64Dd2EoTvsuMuTpndKTk54TcmmOWgit2/eA
 Vbwd/3H5+yMi1TBZB6P3mE5IsLuaWe4dyrMKu+QqWPRKD459nYESFzHZgqSXNVKQx4HL
 4R6aGzghYPrW9diUCfr77S1Qf2lemJahWaZQvPKqyIhS8qXe+NQ6oq98182Qc0gsqeNQ
 AlFC5K2JlbO4e2fQr6KZHLQpYEmzapgo7T/2ofFijNOZCXeQ37nH3O5HARXPy8SSTDp+
 gsPw==
X-Gm-Message-State: AAQBX9cJ1s3Jfw6t89HqjHK430GMK/K/4iMbgkG4zcEGRKpNCAPUXkvz
 JiX9YybSAqygbXJmJtdg4fPiyw==
X-Google-Smtp-Source: AKy350bCVikvIoHJ6lVsgIMVIyeu765afYRq6v7P1NOXma1TJJbIHOZYgqYBCoWGggyVEWw/E2Dwcg==
X-Received: by 2002:a17:903:1112:b0:1a3:d4c7:365b with SMTP id
 n18-20020a170903111200b001a3d4c7365bmr15308569plh.3.1681126132550; 
 Mon, 10 Apr 2023 04:28:52 -0700 (PDT)
Received: from tyrell.hq.igel.co.jp (napt.igel.co.jp. [219.106.231.132])
 by smtp.gmail.com with ESMTPSA id
 y11-20020a1709027c8b00b0019c919bccf8sm7575052pll.86.2023.04.10.04.28.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 10 Apr 2023 04:28:52 -0700 (PDT)
From: Shunsuke Mie <mie@igel.co.jp>
To: "Michael S. Tsirkin" <mst@redhat.com>
Subject: [PATCH v2 1/2] virtio_ring: add a struce device forward declaration
Date: Mon, 10 Apr 2023 20:28:44 +0900
Message-Id: <20230410112845.337212-1-mie@igel.co.jp>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Cc: "Rafael J. Wysocki" <rafael@kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-kernel@vger.kernel.org,
 "Matthew Wilcox \(Oracle\)" <willy@infradead.org>,
 virtualization@lists.linux-foundation.org,
 =?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>,
 Shunsuke Mie <mie@igel.co.jp>, Sakari Ailus <sakari.ailus@linux.intel.com>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>
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

The virtio_ring header file uses the struct device without a forward
declaration.

Signed-off-by: Shunsuke Mie <mie@igel.co.jp>
---
 include/linux/virtio_ring.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/linux/virtio_ring.h b/include/linux/virtio_ring.h
index 8b95b69ef694..77a9c2f52919 100644
--- a/include/linux/virtio_ring.h
+++ b/include/linux/virtio_ring.h
@@ -58,6 +58,7 @@ do { \
 
 struct virtio_device;
 struct virtqueue;
+struct device;
 
 /*
  * Creates a virtqueue and allocates the descriptor ring.  If
-- 
2.25.1

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
