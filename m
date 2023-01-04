Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 98C5CC4332F
	for <virtualization@archiver.kernel.org>; Wed,  4 Jan 2023 08:42:56 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 1C4C581F42;
	Wed,  4 Jan 2023 08:42:56 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 1C4C581F42
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=solid-run-com.20210112.gappssmtp.com header.i=@solid-run-com.20210112.gappssmtp.com header.a=rsa-sha256 header.s=20210112 header.b=ra3Yd1R4
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id HIhBq5YgCcEO; Wed,  4 Jan 2023 08:42:55 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id A504C81F24;
	Wed,  4 Jan 2023 08:42:54 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org A504C81F24
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 89A9DC0032;
	Wed,  4 Jan 2023 08:42:54 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id BA6ABC002D
 for <virtualization@lists.linux-foundation.org>;
 Wed,  4 Jan 2023 08:42:52 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 9451841819
 for <virtualization@lists.linux-foundation.org>;
 Wed,  4 Jan 2023 08:42:52 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 9451841819
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=solid-run-com.20210112.gappssmtp.com
 header.i=@solid-run-com.20210112.gappssmtp.com header.a=rsa-sha256
 header.s=20210112 header.b=ra3Yd1R4
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id IrJUO-FYlXSi
 for <virtualization@lists.linux-foundation.org>;
 Wed,  4 Jan 2023 08:42:51 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 6E3EE41815
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com
 [IPv6:2a00:1450:4864:20::433])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 6E3EE41815
 for <virtualization@lists.linux-foundation.org>;
 Wed,  4 Jan 2023 08:42:51 +0000 (UTC)
Received: by mail-wr1-x433.google.com with SMTP id t15so23352594wro.9
 for <virtualization@lists.linux-foundation.org>;
 Wed, 04 Jan 2023 00:42:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=solid-run-com.20210112.gappssmtp.com; s=20210112;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=ibKGssGp1sbc8GhGpeNmx58bAzMOGgxSv1GDHJGCDHc=;
 b=ra3Yd1R4sD2fhDAXtEsvG9HJe+tQ8BJGflin9PA93clSP+jKlLI5EUulHaxlK3flNn
 YFZz0rLtBP3Nr/QL0MefDUgTw+fQrdWzEztCf7KcoBES5rCqPE1Ul7ECf4GVw6oK+IIk
 SHaR9x/2WyW++i8vbH7UmPjvuBMZCsYtUlKTO8kzZx29881wM4hXR8ZAhzMSgGAPmrdn
 ctMav3F3IyMI4LfaRsNZgYoa9m7sTwHUwiWVPJ6BqrvkJZrIsWRPkfZZ9dZ0HlpKuOTt
 eiQLzNe3tRUL0Gy6xqr18w2OPZbfSej5oCW9RNYhDREGR86kK9RqHtOCKDCaaVnn/7E2
 4D9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ibKGssGp1sbc8GhGpeNmx58bAzMOGgxSv1GDHJGCDHc=;
 b=VL+WQgDL+YrHCszUcndCWwBEQX70IGXEOHQjEGQl4UfodlBeOrZ1ltc4IzLoPyF13W
 Wny7gMQ0A3E2k2w3Mn5VPnQAAZhhbmekco4XrXLTJE0qs9JDVFyca/3+079wS32sFNXO
 zIXS05J3f6ifgOegeVYdxSivaNzsyJ9BI7L84iTzCmMrTOzwz9u1Xd6vBmZa0BkphWfX
 bBpAGjsrfURvILMWiCrEtYCqdoeL5R94cGVAYh1Z6IRnZDXxVYIjz7xjGfgG81bt9kkb
 z9GqIS7ZBCw2u+KpwCxtqxqm1PwzrDSa8q6+8f+ElDBey6h21a0Z1H9g4JohTtUi1qz6
 C+FA==
X-Gm-Message-State: AFqh2kqvyxm/G2+nlZbVBXN35seh1SBaAv9QDCJxqaLp43Zq8NB2X84C
 zIpPszEk9XmSx1vB3/krZKV3GvdLbNl+oIMc
X-Google-Smtp-Source: AMrXdXsBPSufr/J6ypoezVK29IjiorGCY754T3fzUItRvUasnwawLzmZR8NRsZuJkRuRNVIwcuOagA==
X-Received: by 2002:a5d:4406:0:b0:242:7248:fbe with SMTP id
 z6-20020a5d4406000000b0024272480fbemr29084029wrq.25.1672821768739; 
 Wed, 04 Jan 2023 00:42:48 -0800 (PST)
Received: from localhost.localdomain
 (bzq-84-110-153-254.static-ip.bezeqint.net. [84.110.153.254])
 by smtp.gmail.com with ESMTPSA id
 j6-20020a056000124600b0029100e8dedasm13463343wrx.28.2023.01.04.00.42.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Jan 2023 00:42:47 -0800 (PST)
From: Alvaro Karsz <alvaro.karsz@solid-run.com>
To: virtualization@lists.linux-foundation.org,
	linux-pci@vger.kernel.org
Subject: [PATCH v2 1/3] PCI: Add SolidRun vendor ID
Date: Wed,  4 Jan 2023 10:42:45 +0200
Message-Id: <20230104084245.3424347-1-alvaro.karsz@solid-run.com>
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
--
v2:
	- Semantics fixes in commit log.
	- Move the vendor ID to the rigth place, sorted by vendor ID.
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
