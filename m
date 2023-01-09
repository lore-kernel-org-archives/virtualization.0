Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0C594C5479D
	for <virtualization@archiver.kernel.org>; Mon,  9 Jan 2023 08:05:08 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 79B3860D4C;
	Mon,  9 Jan 2023 08:05:08 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 79B3860D4C
Authentication-Results: smtp3.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=solid-run-com.20210112.gappssmtp.com header.i=@solid-run-com.20210112.gappssmtp.com header.a=rsa-sha256 header.s=20210112 header.b=BuJW0gQ8
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 023Vf5RH46Gd; Mon,  9 Jan 2023 08:05:07 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 136C460C29;
	Mon,  9 Jan 2023 08:05:07 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 136C460C29
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id DE657C0032;
	Mon,  9 Jan 2023 08:05:06 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 0262AC002D
 for <virtualization@lists.linux-foundation.org>;
 Mon,  9 Jan 2023 08:05:05 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id C3C9760C16
 for <virtualization@lists.linux-foundation.org>;
 Mon,  9 Jan 2023 08:05:04 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org C3C9760C16
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id wSO4yOJa6uVC
 for <virtualization@lists.linux-foundation.org>;
 Mon,  9 Jan 2023 08:05:04 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 0C00060C29
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com
 [IPv6:2a00:1450:4864:20::335])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 0C00060C29
 for <virtualization@lists.linux-foundation.org>;
 Mon,  9 Jan 2023 08:05:03 +0000 (UTC)
Received: by mail-wm1-x335.google.com with SMTP id
 p1-20020a05600c1d8100b003d8c9b191e0so5913761wms.4
 for <virtualization@lists.linux-foundation.org>;
 Mon, 09 Jan 2023 00:05:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=solid-run-com.20210112.gappssmtp.com; s=20210112;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=FZEnByuYZvS4oCO1vsa+paT8I+UTZXQmFwyne1ALlrI=;
 b=BuJW0gQ8Gc5KrObkxInIyw9PuEH78Wd4O2dd2DrEKlw2s4KULrGCkmrTdJWfh+KpI/
 O9aZOpadf7+gOZ8iiaYxCu5Wlv90r/vGUMTGQhqGAhNNMYTdrEFeozk6o/6IB9X9Yxsr
 NjUESK+0q+bjcrT3MCv4xVjsuXZznuXbV2zWY7aa61pSApxfG/CHhzLmhUM5AOBHASnw
 udccYsgKbF1qVbLmIjVTfIBul5vJPQI3ew172d8ZAzYTe9OzIjYMLvNDUIloyoyarsy5
 2LOmvEeG8xF0aTOgtLIc6+H23jKIadnxH/RWhkleR5U+v9KJtpk4UzET0iduKSnQA03L
 O2CA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=FZEnByuYZvS4oCO1vsa+paT8I+UTZXQmFwyne1ALlrI=;
 b=u8qwneqSrASBaMClaNJTNUupBS75LsKo/Jat5Mmeq6m+8eZifmOQLfUNVZT7IHz4Ja
 n2LkeFrcBfLyHGCYqonLOP007e6tAJ1Y6l8tM27tCEAlT/eyRYPp5EA1XkosXSDklubC
 ss4JkpgFGJirwcKmmSPVZQ9H11otqgmA5fP0keHnhtt67kmJxRIa2FBthGl/feyc0poO
 QLwVIyhG3z1JoY8S2q9d/f5Zgpvz4ZteP0sjnvNzajCgSD0YInTiyLm3xDMoG9zUz1aN
 JjvSg+6R+C6VS/ZggzVft1jdWu0jLB2wBJMXX5lXCVjHO1LS8upS7kBikvb4lRbHEzMs
 3Iag==
X-Gm-Message-State: AFqh2kqFEnDntnHo1jMImhoXzOOoeopamWVAHrpxugou99dQdBaZGpGK
 ICB1JUFWLlw9Dw7cVP6m/xUYd8k7tmHZhWDm
X-Google-Smtp-Source: AMrXdXtlCLU9gB3jqVupm3Tx0U0gBBgA61YGRuQhR0b+lwt+fRT56ka/gWU6kCOroTd0tvZca3EUag==
X-Received: by 2002:a05:600c:3d8b:b0:3d9:f0d8:708c with SMTP id
 bi11-20020a05600c3d8b00b003d9f0d8708cmr1356882wmb.26.1673251501438; 
 Mon, 09 Jan 2023 00:05:01 -0800 (PST)
Received: from localhost.localdomain
 (bzq-84-110-153-254.static-ip.bezeqint.net. [84.110.153.254])
 by smtp.gmail.com with ESMTPSA id
 h8-20020a05600c350800b003d990372dd5sm16361989wmq.20.2023.01.09.00.04.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 09 Jan 2023 00:05:00 -0800 (PST)
From: Alvaro Karsz <alvaro.karsz@solid-run.com>
To: virtualization@lists.linux-foundation.org,
	linux-pci@vger.kernel.org
Subject: [PATCH v8 1/3] PCI: Add SolidRun vendor ID
Date: Mon,  9 Jan 2023 10:04:53 +0200
Message-Id: <20230109080453.1155113-1-alvaro.karsz@solid-run.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Cc: bhelgaas@google.com, mst@redhat.com
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

Add SolidRun vendor ID to pci_ids.h

The vendor ID is used in 2 different source files,
the SNET vDPA driver and PCI quirks.

Signed-off-by: Alvaro Karsz <alvaro.karsz@solid-run.com>
Acked-by: Bjorn Helgaas <bhelgaas@google.com>
---
 include/linux/pci_ids.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/include/linux/pci_ids.h b/include/linux/pci_ids.h
index b362d90eb9b..9a3102e61db 100644
--- a/include/linux/pci_ids.h
+++ b/include/linux/pci_ids.h
@@ -3092,6 +3092,8 @@

 #define PCI_VENDOR_ID_3COM_2		0xa727

+#define PCI_VENDOR_ID_SOLIDRUN          0xd063
+
 #define PCI_VENDOR_ID_DIGIUM		0xd161
 #define PCI_DEVICE_ID_DIGIUM_HFC4S	0xb410

--
2.32.0
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
