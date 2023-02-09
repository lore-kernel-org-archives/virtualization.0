Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 421E9C05027
	for <virtualization@archiver.kernel.org>; Thu,  9 Feb 2023 07:51:38 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id BE278820F4;
	Thu,  9 Feb 2023 07:51:37 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org BE278820F4
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=solid-run-com.20210112.gappssmtp.com header.i=@solid-run-com.20210112.gappssmtp.com header.a=rsa-sha256 header.s=20210112 header.b=DqrB1xyi
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 6ExWnccWOWY9; Thu,  9 Feb 2023 07:51:37 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 4845A81DF0;
	Thu,  9 Feb 2023 07:51:36 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 4845A81DF0
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 10D56C0070;
	Thu,  9 Feb 2023 07:51:36 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id D3992C002B
 for <virtualization@lists.linux-foundation.org>;
 Thu,  9 Feb 2023 07:51:34 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id AE7F640612
 for <virtualization@lists.linux-foundation.org>;
 Thu,  9 Feb 2023 07:51:34 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org AE7F640612
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=solid-run-com.20210112.gappssmtp.com
 header.i=@solid-run-com.20210112.gappssmtp.com header.a=rsa-sha256
 header.s=20210112 header.b=DqrB1xyi
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id ASo0A3EoJyXF
 for <virtualization@lists.linux-foundation.org>;
 Thu,  9 Feb 2023 07:51:34 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org D3E4F405F4
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com
 [IPv6:2a00:1450:4864:20::32c])
 by smtp2.osuosl.org (Postfix) with ESMTPS id D3E4F405F4
 for <virtualization@lists.linux-foundation.org>;
 Thu,  9 Feb 2023 07:51:33 +0000 (UTC)
Received: by mail-wm1-x32c.google.com with SMTP id
 hn2-20020a05600ca38200b003dc5cb96d46so3222199wmb.4
 for <virtualization@lists.linux-foundation.org>;
 Wed, 08 Feb 2023 23:51:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=solid-run-com.20210112.gappssmtp.com; s=20210112;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=1QDLqR7kr/CBmXE1Ms9xiRugP2U40LQHc7BRgK51iXM=;
 b=DqrB1xyivmJru88kV1Sjj24yeq+DQvcVteJX6n0WW6MtgYX2zJk04mtlpg+ymogPJK
 FcNF5d5BK/1LlbpEW5su/cewZcRnfiX+vHByWxFKRh2qekC87EaJcTtKe7kWy7Wf8VNv
 X9TdfnUHpCLkgn5yjbBHoki6XRZJETZiIq+VRFly7Rg2Y6BWafjAeyi7bjpOwSQhyKlE
 6iR0HQCCa0lUWL6UspgDbgJ4oYTIYNH9Y4QLDx4ar0V4fGdExEMcEzmUu4GtFXMLugKD
 OFwM27wwrb41vN+p0Tvkvx/jnm3s5tIG8npzl//PX5iWuhS6oXxXMzQVwUEkimfgt3jR
 2GeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=1QDLqR7kr/CBmXE1Ms9xiRugP2U40LQHc7BRgK51iXM=;
 b=DnkiSHqfjnThG7iS/jTwy9LlLoc1kWqg6GtAQKgBU0BcOt90iG9prCVxOwKk/7vc4Q
 F1G6of7IjM3jtaELKn6TQmI0vP6S3O1LZDUXIxwhcLOGcXRkfD2E+Y3UHAGdlb499DKU
 Fd/Ga7axv4FvGD5TiTWir3zwOgjOW6XywbhWukCybusQSqjvdoeeMNgq5rKFg4QNupPV
 9QSSzzyohhPbFH3ppt7u0xFSZ0136vk6FLUMWqyg725dBUyxznS4xnplLcpRh9FjyApL
 vZrDiu1GC8Db+4ZbZOfw32F7wLVE1NGTRXx6TvJx7prV8iXFjaVA1Hlr5HWTRJ69laPn
 RzNg==
X-Gm-Message-State: AO0yUKVMcUdw9Qtt2oayOreT19+0BqqoIl2kYVjXB2VACDmqX291iayB
 53N8ddMq+cjTbGQcStDeohfTOQ==
X-Google-Smtp-Source: AK7set/ojLbNsz0po4kOLittWulINUDZVJPvBiujfh2vBNARD2+1TpLIinw3h1qbo2JWjjto9/54gQ==
X-Received: by 2002:a05:600c:2e8a:b0:3dc:5a70:23dc with SMTP id
 p10-20020a05600c2e8a00b003dc5a7023dcmr8766391wmn.27.1675929091993; 
 Wed, 08 Feb 2023 23:51:31 -0800 (PST)
Received: from alvaro-dell.. (bzq-84-110-153-254.static-ip.bezeqint.net.
 [84.110.153.254]) by smtp.gmail.com with ESMTPSA id
 k21-20020a05600c1c9500b003e01493b136sm4294380wms.43.2023.02.08.23.51.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 08 Feb 2023 23:51:31 -0800 (PST)
From: Alvaro Karsz <alvaro.karsz@solid-run.com>
To: mst@redhat.com,
	jasowang@redhat.com
Subject: [PATCH] vdpa: snet: clear dpu_ready flag on reset
Date: Thu,  9 Feb 2023 09:51:28 +0200
Message-Id: <20230209075128.78915-1-alvaro.karsz@solid-run.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
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

The flag should be cleared on reset, otherwise, the DPU won't start
again after reset.

Signed-off-by: Alvaro Karsz <alvaro.karsz@solid-run.com>
---
 drivers/vdpa/solidrun/snet_main.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/vdpa/solidrun/snet_main.c b/drivers/vdpa/solidrun/snet_main.c
index 0c13ccde4520..68de727398ed 100644
--- a/drivers/vdpa/solidrun/snet_main.c
+++ b/drivers/vdpa/solidrun/snet_main.c
@@ -255,6 +255,7 @@ static int snet_reset_dev(struct snet *snet)
 	snet_free_irqs(snet);
 	/* Reset status */
 	snet->status = 0;
+	snet->dpu_ready = false;
 
 	if (ret)
 		SNET_WARN(pdev, "Incomplete reset to SNET[%u] device\n", snet->sid);
-- 
2.34.1

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
