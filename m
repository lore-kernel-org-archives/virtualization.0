Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 07A94C4332F
	for <virtualization@archiver.kernel.org>; Tue, 27 Dec 2022 02:25:43 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 8CC90404FC;
	Tue, 27 Dec 2022 02:25:43 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 8CC90404FC
Authentication-Results: smtp2.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igel-co-jp.20210112.gappssmtp.com header.i=@igel-co-jp.20210112.gappssmtp.com header.a=rsa-sha256 header.s=20210112 header.b=wbZLVqKZ
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id u8oRZW-ApYI5; Tue, 27 Dec 2022 02:25:42 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 2CC35404ED;
	Tue, 27 Dec 2022 02:25:42 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 2CC35404ED
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 08746C0035;
	Tue, 27 Dec 2022 02:25:42 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 2DC81C007B
 for <virtualization@lists.linux-foundation.org>;
 Tue, 27 Dec 2022 02:25:40 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 091F181336
 for <virtualization@lists.linux-foundation.org>;
 Tue, 27 Dec 2022 02:25:40 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 091F181336
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=igel-co-jp.20210112.gappssmtp.com
 header.i=@igel-co-jp.20210112.gappssmtp.com header.a=rsa-sha256
 header.s=20210112 header.b=wbZLVqKZ
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id T_pKPNLTmb-q
 for <virtualization@lists.linux-foundation.org>;
 Tue, 27 Dec 2022 02:25:39 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 623F0812E7
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com
 [IPv6:2607:f8b0:4864:20::631])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 623F0812E7
 for <virtualization@lists.linux-foundation.org>;
 Tue, 27 Dec 2022 02:25:39 +0000 (UTC)
Received: by mail-pl1-x631.google.com with SMTP id b2so12027676pld.7
 for <virtualization@lists.linux-foundation.org>;
 Mon, 26 Dec 2022 18:25:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=igel-co-jp.20210112.gappssmtp.com; s=20210112;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=vc9dKkOu9Bxzey4EMEiWLkvY83L8oxqqOyKDYNLTu5g=;
 b=wbZLVqKZnCa58wA2i8a8+KZ6p3B3BKGx6AZ5PJqw+pOt7brvZts5glurkjMa11iFTL
 RqjgkaYA+1yRF5BXn8Ld/InkXNROzQ7xFuLueevxDuXqNWEQgc7qt9MHvWCt2gqQdUPX
 oV+d9kpPZel6sq7QA6S5wG+nBa4rNygSq+Y4dzCgVtqv0Cp4+GptPOCMPkIQ0MGwh7E7
 UGrrRMjFjndiyuydtbO7/txh6wJtnsFynXdAaGl75AIxNvGmnvZs4jsyZJ+Ka/N8tvP+
 wkzUFhNrc9FDCKWp9R2bbGbBvrjLsZQFep1xZ/uI21A9InML4Q9l6dMopWZX7sQNyEU6
 nSmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=vc9dKkOu9Bxzey4EMEiWLkvY83L8oxqqOyKDYNLTu5g=;
 b=dTXkZSvOgDBBRucWbwNq+WCRIGp/9hqyiDHuuyXBoWy1srIxj5vOHFtqXGmwK0uQtZ
 mmzE+avGuSBmyIocboOAb8eLA0m5+Ba/fy/gcXjokO7mzS1yQ21olJMpm7XA/dg57wE4
 OFMvhZRotw1kBpSKl6FzLpG8wK0b/r8/MRpKAMCwr1YVgsy8VXuJVeYIDK24+Q76FjSt
 BpfQ1JGgLf2hJmOJYiE0j3bgKf639CYjuF8XCiIe1mwJIlxsqLBmRRg4aNHD/IbkgDRB
 n7AmRFiCUte+hgG53M0DS+Kvj9KmAb4LcMxGSZPv5UV1sJMwUDbwCwqVgmDFsx+BTwsQ
 HCgw==
X-Gm-Message-State: AFqh2kpb/Bi26zOYnTdwbc9GId763TklqU46C2Zn/ZK9Evbavzv+fZEi
 raNDJtyI3+coX/NqdjGNGRqS0g==
X-Google-Smtp-Source: AMrXdXtZe0PP83G04+jg1kuf3vdXwhv44n2Bde+IvwOeyqGGAZ7SMJJgmZfCmhv40gnPTO2AXV5aUw==
X-Received: by 2002:a05:6a20:3b9c:b0:ac:94a1:8afb with SMTP id
 b28-20020a056a203b9c00b000ac94a18afbmr19088805pzh.13.1672107938858; 
 Mon, 26 Dec 2022 18:25:38 -0800 (PST)
Received: from tyrell.hq.igel.co.jp (napt.igel.co.jp. [219.106.231.132])
 by smtp.gmail.com with ESMTPSA id
 w15-20020a1709026f0f00b001870dc3b4c0sm2465014plk.74.2022.12.26.18.25.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 26 Dec 2022 18:25:38 -0800 (PST)
From: Shunsuke Mie <mie@igel.co.jp>
To: "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>,
 Rusty Russell <rusty@rustcorp.com.au>
Subject: [RFC PATCH 1/9] vringh: fix a typo in comments for vringh_kiov
Date: Tue, 27 Dec 2022 11:25:23 +0900
Message-Id: <20221227022528.609839-2-mie@igel.co.jp>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221227022528.609839-1-mie@igel.co.jp>
References: <20221227022528.609839-1-mie@igel.co.jp>
MIME-Version: 1.0
Cc: netdev@vger.kernel.org, Shunsuke Mie <mie@igel.co.jp>,
 linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
 virtualization@lists.linux-foundation.org
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

Fixes: f87d0fbb5798 ("vringh: host-side implementation of virtio rings.")
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
