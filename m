Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 48A6AC77B61
	for <virtualization@archiver.kernel.org>; Mon, 17 Apr 2023 02:20:55 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id D3E6A8217B;
	Mon, 17 Apr 2023 02:20:54 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org D3E6A8217B
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igel-co-jp.20221208.gappssmtp.com header.i=@igel-co-jp.20221208.gappssmtp.com header.a=rsa-sha256 header.s=20221208 header.b=W+kitkj4
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id SCUBE8qf536b; Mon, 17 Apr 2023 02:20:54 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 5B44982171;
	Mon, 17 Apr 2023 02:20:53 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 5B44982171
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 3EDB3C0036;
	Mon, 17 Apr 2023 02:20:53 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 7C951C002A
 for <virtualization@lists.linux-foundation.org>;
 Mon, 17 Apr 2023 02:20:52 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 506CE82174
 for <virtualization@lists.linux-foundation.org>;
 Mon, 17 Apr 2023 02:20:52 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 506CE82174
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id S7HzJ4roL7ZD
 for <virtualization@lists.linux-foundation.org>;
 Mon, 17 Apr 2023 02:20:51 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 8FCA782171
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com
 [IPv6:2607:f8b0:4864:20::633])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 8FCA782171
 for <virtualization@lists.linux-foundation.org>;
 Mon, 17 Apr 2023 02:20:51 +0000 (UTC)
Received: by mail-pl1-x633.google.com with SMTP id p8so24162365plk.9
 for <virtualization@lists.linux-foundation.org>;
 Sun, 16 Apr 2023 19:20:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=igel-co-jp.20221208.gappssmtp.com; s=20221208; t=1681698051; x=1684290051;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=zPGr4aLtxvia+ORk+JW6CZQQWfXiix2/yFnvH7YElHY=;
 b=W+kitkj4748KMfkxzVGrcTOmUMYc6GuI5qwaIjw/ez2iMpOp3wzBgCqUNRZMK+qjcb
 BbIY8QEASuYUGBfa9DpedYy0I7LxVeD+MKQbRFXsWwAhKpKwx8eUqTexwbc5mYPFMPD4
 /72izdGZyYzRwKmRN8y1YLdoSVJkog1r86CNCqveOWQ1yyvY4G5NR4++PNGU8wMrnFSC
 Bqh2/3spNiN8seFwQHVoqDVLvWU5WbnBxF8IqDm0FgitAbKfx7VdoGsJ94L4wFrfNr2K
 5hlbiSRFGOGpgBkf7FicQFZAwwbkFMlADZNrmHhAd8T+Tw8A6B+EWt3Yy4RE7QBsN8mg
 z51A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1681698051; x=1684290051;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=zPGr4aLtxvia+ORk+JW6CZQQWfXiix2/yFnvH7YElHY=;
 b=diIJDspMLh4gn9siYLqVsYxsx4BQmeYDvGd1nFeox4T3syT9QlurzczXHeJ8VsSg/K
 5DpIfbPR75Kk2VpJGgI+E4HjGK2uO3U419I8o7BOpKaH1NqBZzUKVHazPE+IHd5ndBx4
 jActG0jrxoA6WF6Fa+m07bWxtY3oN64LBUtf+B7vlBLE9zH4Mr8G+uRBaks5Nl9d9Vfa
 N47s9CLh9x5XunJnj+uObCoFHpsbnrcd3HmLbsU5AxGNKHlQNNLOIyysmMMJkxFk9oX+
 +GJr4hru0r59+Nkw3vea15IwWtn0pMTuUHv/y3g9g+7mE5enIUJHlw1LGOhS+O8gbRxS
 7M3A==
X-Gm-Message-State: AAQBX9eZmL26QD25++kbNi7lVLpqCBQurVrH/7Woi2t70PgGPSS4RMYB
 0Qj+WNEMTtzqSGyh+Qh2n6t4LQ==
X-Google-Smtp-Source: AKy350bs2v5u3uc7g/iYBOl/6g6nM1K60PDxVnsFlqWctrcBKq1BsqKUpM0oxvj+C1lEWPBFV4KybA==
X-Received: by 2002:a17:902:e305:b0:1a6:370c:ce79 with SMTP id
 q5-20020a170902e30500b001a6370cce79mr9051838plc.22.1681698050696; 
 Sun, 16 Apr 2023 19:20:50 -0700 (PDT)
Received: from tyrell.hq.igel.co.jp (napt.igel.co.jp. [219.106.231.132])
 by smtp.gmail.com with ESMTPSA id
 f4-20020a170902e98400b001a68986a3d8sm6195243plb.24.2023.04.16.19.20.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 16 Apr 2023 19:20:50 -0700 (PDT)
From: Shunsuke Mie <mie@igel.co.jp>
To: "Michael S. Tsirkin" <mst@redhat.com>
Subject: [PATCH v3 RESEND 1/2] virtio_ring: add a struct device forward
 declaration
Date: Mon, 17 Apr 2023 11:20:36 +0900
Message-Id: <20230417022037.917668-1-mie@igel.co.jp>
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
Changes from v2: https://lore.kernel.org/virtualization/20230410074929-mutt-send-email-mst@kernel.org/
- Fix a typo of commit title


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
