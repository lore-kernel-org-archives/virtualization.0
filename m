Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 85D5BC636D6
	for <virtualization@archiver.kernel.org>; Thu,  2 Feb 2023 10:45:47 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 0234D60AB3;
	Thu,  2 Feb 2023 10:45:47 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 0234D60AB3
Authentication-Results: smtp3.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igel-co-jp.20210112.gappssmtp.com header.i=@igel-co-jp.20210112.gappssmtp.com header.a=rsa-sha256 header.s=20210112 header.b=xr7SVjq+
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 1Kt_dLrRLy3V; Thu,  2 Feb 2023 10:45:46 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 89229606ED;
	Thu,  2 Feb 2023 10:45:45 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 89229606ED
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 5AF86C0032;
	Thu,  2 Feb 2023 10:45:45 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 1813CC002B
 for <virtualization@lists.linux-foundation.org>;
 Thu,  2 Feb 2023 10:45:44 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id D410E40A20
 for <virtualization@lists.linux-foundation.org>;
 Thu,  2 Feb 2023 10:45:43 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org D410E40A20
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=igel-co-jp.20210112.gappssmtp.com
 header.i=@igel-co-jp.20210112.gappssmtp.com header.a=rsa-sha256
 header.s=20210112 header.b=xr7SVjq+
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id SU4oQ5-cdm9c
 for <virtualization@lists.linux-foundation.org>;
 Thu,  2 Feb 2023 10:45:43 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 52CB140250
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com
 [IPv6:2607:f8b0:4864:20::102c])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 52CB140250
 for <virtualization@lists.linux-foundation.org>;
 Thu,  2 Feb 2023 10:45:43 +0000 (UTC)
Received: by mail-pj1-x102c.google.com with SMTP id
 cq16-20020a17090af99000b0022c9791ac39so5151612pjb.4
 for <virtualization@lists.linux-foundation.org>;
 Thu, 02 Feb 2023 02:45:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=igel-co-jp.20210112.gappssmtp.com; s=20210112;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=Wj1wi+vfvB54wfWKyUZTobNpEfDR2hWH6JizNjshTls=;
 b=xr7SVjq+Qi9fFt/m3pDEUSVVbaizv/QkcY3BkJv7lSkED89MyE2o2ADQSMSY+dFiNY
 eJH5YIxIAEkkg00mBo3BhLjSprH/g46aK8aiEU6y6SqA4wQPGSXcuqJaKHS7rFy5Hpu2
 dFQjraopoEqzjZhNU1wGcGKjF3WbPxhtwJGSf7CeBRvpCBb4KUkYXQrxJCYiB4FLOUjh
 2SGFbPzMDI85JfBYkQl6YW6L3rp6Un1NquGXRUWrqoSt2eki8rm+f4nHpb6sfOKZfOkx
 LM3gJ8746ODgyOIaHCbQOimsq6+RCG/lZ5PDKu+8ttyyp2wGZb/u8ajv78GfsVlRVlPf
 zcWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Wj1wi+vfvB54wfWKyUZTobNpEfDR2hWH6JizNjshTls=;
 b=X+EfhnjwjP4VAwrYgvWvEpefNY8zfJqVLvPaNTtNDswE5ITSM9e5mVLVs5OyhKIzlP
 sPxsOSjxYKlLSC0UXlJRew2lIv4Q4aCw00TxPcRCKf/OdoFKSMkzhqO5j7jeqIm/2DlY
 qaVR+KD95k5fgMGt6vBw97Qsk6Vhyh/JZ7ctuxKF4kyrigyOXHFW4U2BFq/UxOyN6dvZ
 cY9ouL64XlI8q25N6pGn15Nzw3DGfpT9X0SnOgYidd6ftarnZIXldakwFzlH+h/4khRO
 QP/GQFpmSzT2EDJ5+/vs1NyYGUmlc8L7X9d6eqed9twhDe0IrOPYvIwQBzFJ5FqgONAU
 1hew==
X-Gm-Message-State: AO0yUKWTFW4xhTrVrMsv68QmWVnOo7pAIDT825RErPlBz4xreuLYSVPh
 wjUOLUw+a8mX5jdJRu14uA9O3w==
X-Google-Smtp-Source: AK7set8wpF7VU0PIG0iDBH0+zdbpzQ/i+YdEY06ArnDW1Hqqjrgqjz7XwAHfBQ+YFbg6wWYwlSEbQQ==
X-Received: by 2002:a17:90b:4ac1:b0:22c:8b3f:e1a1 with SMTP id
 mh1-20020a17090b4ac100b0022c8b3fe1a1mr6262204pjb.19.1675334742618; 
 Thu, 02 Feb 2023 02:45:42 -0800 (PST)
Received: from tyrell.hq.igel.co.jp (napt.igel.co.jp. [219.106.231.132])
 by smtp.gmail.com with ESMTPSA id
 j6-20020a17090a840600b002270155254csm2919193pjn.24.2023.02.02.02.45.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 02 Feb 2023 02:45:42 -0800 (PST)
From: Shunsuke Mie <mie@igel.co.jp>
To: "Michael S. Tsirkin" <mst@redhat.com>
Subject: [PATCH] tools/virtio: enable to build with retpoline
Date: Thu,  2 Feb 2023 19:45:38 +0900
Message-Id: <20230202104538.2041879-1-mie@igel.co.jp>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Cc: Shunsuke Mie <mie@igel.co.jp>, linux-kernel@vger.kernel.org,
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

Add build options to bring it close to a linux kernel. It allows for
testing that is close to reality.

Signed-off-by: Shunsuke Mie <mie@igel.co.jp>
---
 tools/virtio/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/virtio/Makefile b/tools/virtio/Makefile
index 1b25cc7c64bb..7b7139d97d74 100644
--- a/tools/virtio/Makefile
+++ b/tools/virtio/Makefile
@@ -4,7 +4,7 @@ test: virtio_test vringh_test
 virtio_test: virtio_ring.o virtio_test.o
 vringh_test: vringh_test.o vringh.o virtio_ring.o
 
-CFLAGS += -g -O2 -Werror -Wno-maybe-uninitialized -Wall -I. -I../include/ -I ../../usr/include/ -Wno-pointer-sign -fno-strict-overflow -fno-strict-aliasing -fno-common -MMD -U_FORTIFY_SOURCE -include ../../include/linux/kconfig.h
+CFLAGS += -g -O2 -Werror -Wno-maybe-uninitialized -Wall -I. -I../include/ -I ../../usr/include/ -Wno-pointer-sign -fno-strict-overflow -fno-strict-aliasing -fno-common -MMD -U_FORTIFY_SOURCE -include ../../include/linux/kconfig.h -mfunction-return=thunk -fcf-protection=none -mindirect-branch-register
 CFLAGS += -pthread
 LDFLAGS += -pthread
 vpath %.c ../../drivers/virtio ../../drivers/vhost
-- 
2.25.1

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
