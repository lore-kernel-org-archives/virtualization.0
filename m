Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3BA67C61DA4
	for <virtualization@archiver.kernel.org>; Thu,  2 Feb 2023 10:43:02 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id B2FE64054A;
	Thu,  2 Feb 2023 10:43:01 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org B2FE64054A
Authentication-Results: smtp4.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igel-co-jp.20210112.gappssmtp.com header.i=@igel-co-jp.20210112.gappssmtp.com header.a=rsa-sha256 header.s=20210112 header.b=EtrrguGO
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id kVOjbWrwI7nA; Thu,  2 Feb 2023 10:43:00 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 01B114086C;
	Thu,  2 Feb 2023 10:42:59 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 01B114086C
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id DA54CC0032;
	Thu,  2 Feb 2023 10:42:59 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id EBE66C002B
 for <virtualization@lists.linux-foundation.org>;
 Thu,  2 Feb 2023 10:42:57 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id C5D2F607BC
 for <virtualization@lists.linux-foundation.org>;
 Thu,  2 Feb 2023 10:42:57 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org C5D2F607BC
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=igel-co-jp.20210112.gappssmtp.com
 header.i=@igel-co-jp.20210112.gappssmtp.com header.a=rsa-sha256
 header.s=20210112 header.b=EtrrguGO
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id e4TCX3TSMvVd
 for <virtualization@lists.linux-foundation.org>;
 Thu,  2 Feb 2023 10:42:57 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 18EE2600B9
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com
 [IPv6:2607:f8b0:4864:20::535])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 18EE2600B9
 for <virtualization@lists.linux-foundation.org>;
 Thu,  2 Feb 2023 10:42:57 +0000 (UTC)
Received: by mail-pg1-x535.google.com with SMTP id 141so1048855pgc.0
 for <virtualization@lists.linux-foundation.org>;
 Thu, 02 Feb 2023 02:42:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=igel-co-jp.20210112.gappssmtp.com; s=20210112;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=ldGt9CJfPI87gpBgmJqLjVS33kkn4ot4dZ1LzRIHTPU=;
 b=EtrrguGOFagT+7kLAk6uTCf2dZGN0V2lCd1mIKii+4o1yT5n+YV479v6rWAtqm2894
 EABYCzqBz/fN0oOMwM36Nc4O0fdp75HasO+9aAwoPjBMW4W2zcwIQgfkF+9EpEO9xn4o
 Z6ctl6ZFxsBKfXQwhY63l3R8/ALoTj59C0Fh3wdAH5WIRVI2hODdscuiwrLQYb9GWb/G
 O1LtgdXqkxmXCrRTUwfgY5dCuAKAdPHsHXRVDaQ5lGBXymtSHAUmrc+pl7NnlwWRWMbO
 IJx1h97Zk6ylX+8ravr91EOpEZcOkJXEyaQ45X0bW61KQkKlmO/4g4W5CGF7wlsAFF12
 TCVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ldGt9CJfPI87gpBgmJqLjVS33kkn4ot4dZ1LzRIHTPU=;
 b=7ruH30ZlsiSuzi1VlByp2sXK359xv2E6zIPRdSducKQaBHnPzcQRe49jLHey3FpIVA
 DjMOvWsv4AhOudSSkuRtNLY69Ia8sQYkKJ6uxL02FFad91VYLljr0sbf530MU+UKQjLD
 DnM4LGi5ygbDZJSZVi1WWZ24lq70K7VhUEBOtmP05RSrOg9D298Vp73dTtgrVMaDYkyu
 /LUAodER3WTL3SXDOkARSPtL3ThPuwGE6fsHXsvkKXAYwtJ4IV+eaYPr631a3hEcQgl7
 qLeLEZIr7LiQ9QEDouiZRPASAhgY3gLcOToI1RhfGRArUQ8YawP1bMHlNNuQF8Z5AHte
 XYQA==
X-Gm-Message-State: AO0yUKWAShJfIspvz5PGJe2n9yB4zLgbmq73olK7mwFh0mHg3Q4bPbUU
 cNi5HioMXBnmWjPYgGW6vb6DlA==
X-Google-Smtp-Source: AK7set/Rs7+nLs58UmDprCnbeh0PTlwwm4Q7EdQOVVglBIKiQVz3PTwKOQuKPXet1bSUyYwrziJkYg==
X-Received: by 2002:a05:6a00:248c:b0:58d:abd5:504a with SMTP id
 c12-20020a056a00248c00b0058dabd5504amr6366086pfv.31.1675334576527; 
 Thu, 02 Feb 2023 02:42:56 -0800 (PST)
Received: from tyrell.hq.igel.co.jp (napt.igel.co.jp. [219.106.231.132])
 by smtp.gmail.com with ESMTPSA id
 u144-20020a627996000000b0055f209690c0sm13294220pfc.50.2023.02.02.02.42.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 02 Feb 2023 02:42:56 -0800 (PST)
From: Shunsuke Mie <mie@igel.co.jp>
To: "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>,
 Rusty Russell <rusty@rustcorp.com.au>
Subject: [PATCH] vringh: fix a typo in comments for vringh_kiov
Date: Thu,  2 Feb 2023 19:42:48 +0900
Message-Id: <20230202104248.2040652-1-mie@igel.co.jp>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Cc: Shunsuke Mie <mie@igel.co.jp>, linux-kernel@vger.kernel.org,
 kvm@vger.kernel.org, virtualization@lists.linux-foundation.org
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

Probably it is a simple copy error from struct vring_iov.

Signed-off-by: Shunsuke Mie <mie@igel.co.jp>
---
 include/linux/vringh.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/vringh.h b/include/linux/vringh.h
index 212892cf9822..1991a02c6431 100644
--- a/include/linux/vringh.h
+++ b/include/linux/vringh.h
@@ -92,7 +92,7 @@ struct vringh_iov {
 };
 
 /**
- * struct vringh_iov - kvec mangler.
+ * struct vringh_kiov - kvec mangler.
  *
  * Mangles kvec in place, and restores it.
  * Remaining data is iov + i, of used - i elements.
-- 
2.25.1

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
