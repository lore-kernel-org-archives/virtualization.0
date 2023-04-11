Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A2144C7619A
	for <virtualization@archiver.kernel.org>; Tue, 11 Apr 2023 08:51:50 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 0C8866142E;
	Tue, 11 Apr 2023 08:51:50 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 0C8866142E
Authentication-Results: smtp3.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igel-co-jp.20210112.gappssmtp.com header.i=@igel-co-jp.20210112.gappssmtp.com header.a=rsa-sha256 header.s=20210112 header.b=tmUlzxqX
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id g8MKzHZLkdtN; Tue, 11 Apr 2023 08:51:49 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 907B560E0D;
	Tue, 11 Apr 2023 08:51:48 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 907B560E0D
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 71FFEC0037;
	Tue, 11 Apr 2023 08:51:48 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id F1E7DC002A
 for <virtualization@lists.linux-foundation.org>;
 Tue, 11 Apr 2023 08:51:46 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id C5E9040B75
 for <virtualization@lists.linux-foundation.org>;
 Tue, 11 Apr 2023 08:51:46 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org C5E9040B75
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=igel-co-jp.20210112.gappssmtp.com
 header.i=@igel-co-jp.20210112.gappssmtp.com header.a=rsa-sha256
 header.s=20210112 header.b=tmUlzxqX
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 9EcNVQrTsfhD
 for <virtualization@lists.linux-foundation.org>;
 Tue, 11 Apr 2023 08:51:46 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org E21E3400E2
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com
 [IPv6:2607:f8b0:4864:20::102a])
 by smtp2.osuosl.org (Postfix) with ESMTPS id E21E3400E2
 for <virtualization@lists.linux-foundation.org>;
 Tue, 11 Apr 2023 08:51:45 +0000 (UTC)
Received: by mail-pj1-x102a.google.com with SMTP id
 l9-20020a17090a3f0900b0023d32684e7fso1020709pjc.1
 for <virtualization@lists.linux-foundation.org>;
 Tue, 11 Apr 2023 01:51:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=igel-co-jp.20210112.gappssmtp.com; s=20210112; t=1681203105;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=HdqgMzgy29XXK8Oo8n24SJIKxZklUx84N8hmAQJ/vnc=;
 b=tmUlzxqXmx/YVqqgISsH/icdHCOwy8JTrHS+ySmGyJRbF1Y01pJhCNmMrcN0dPzryp
 FbcfMyyRLAijo/IGH5ZFW/eEioEVo0Red5ep7acVM5XMuOoLZyBiZaA0JPQY9je4LgmG
 FoKl7kHmj49urqyIAGO2gwkeU+nzUxLkX7+41Wp8SfEJn/0eR1uTtgMTBzzljzyoWMeD
 Z0d2I03mkcz8vOsiMigfnMOPhaEAChVe19NbIW+eIt1wz1f488yBpBYuH0jw2CJZTJq4
 pTJCARMZxV1ebsLBq3PYEjY6ubVy/MyeIMxH6FExXu6piUH0DWjigS8cPkwA3g/+KgKN
 UX8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112; t=1681203105;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=HdqgMzgy29XXK8Oo8n24SJIKxZklUx84N8hmAQJ/vnc=;
 b=qSWNhYOvENHRIFUo96m5CGd7j+giVRnp32UB5VT2SpRLKIgRDo8+eW3giKpvEaWC4X
 T6XbOEw+jxhiew+vJz9Xs7NPmi/XyMx6GeEf1PTHBqZ0GxSKFAimzQ/600O7VD7nkhqM
 4oBLcXdzwJqeImOkwbCpWaKB/IwSSXJ0W7mZm77Ht8akvQ0h0WDzVJICyF2Z1MOxdWZR
 r+gTISYNxT1/cbajJ3nuZq7yKLRgiI3UiotRj7mgFDeWpVK4sqSdGLljbbalt0KucHT8
 0/Wlof+GCTG7at/dEkugxkodVTkzp7X76xAtt/9/k16Ra4e47svJ7bWKWN+reRLxIMRO
 owIg==
X-Gm-Message-State: AAQBX9ealR1gF3VwCMtTW4IzHuTxQS1M+kMHjaLMaYpsquKy1z1Wc6kS
 Y/4DnGVOsRrkILYvmvTu4EXSNA==
X-Google-Smtp-Source: AKy350ZNlvXlO/AQRbNWdJ7U2sLqaqtUK9axZA3Ylo6bngRGCng5E0VZ4IR0UMTPMA72aRQ7KbsW7g==
X-Received: by 2002:a05:6a20:3aa2:b0:dd:f44a:2717 with SMTP id
 d34-20020a056a203aa200b000ddf44a2717mr2102225pzh.8.1681203105247; 
 Tue, 11 Apr 2023 01:51:45 -0700 (PDT)
Received: from tyrell.hq.igel.co.jp (napt.igel.co.jp. [219.106.231.132])
 by smtp.gmail.com with ESMTPSA id
 e20-20020aa78c54000000b0059085684b54sm9573579pfd.140.2023.04.11.01.51.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 11 Apr 2023 01:51:44 -0700 (PDT)
From: Shunsuke Mie <mie@igel.co.jp>
To: "Michael S. Tsirkin" <mst@redhat.com>
Subject: [PATCH v3 1/2] virtio_ring: add a struct device forward declaration
Date: Tue, 11 Apr 2023 17:51:38 +0900
Message-Id: <20230411085139.375393-1-mie@igel.co.jp>
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
Changes from v2:
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
