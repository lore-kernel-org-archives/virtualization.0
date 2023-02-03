Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8E3DCC61DA4
	for <virtualization@archiver.kernel.org>; Fri,  3 Feb 2023 10:04:35 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 27CA7820E8;
	Fri,  3 Feb 2023 10:04:35 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 27CA7820E8
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igel-co-jp.20210112.gappssmtp.com header.i=@igel-co-jp.20210112.gappssmtp.com header.a=rsa-sha256 header.s=20210112 header.b=JTIWKvUB
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id n91uzc19K4zA; Fri,  3 Feb 2023 10:04:34 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id CD7F0820A9;
	Fri,  3 Feb 2023 10:04:33 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org CD7F0820A9
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id B6233C0033;
	Fri,  3 Feb 2023 10:04:33 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 47F31C002B
 for <virtualization@lists.linux-foundation.org>;
 Fri,  3 Feb 2023 10:04:33 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 3115A820A9
 for <virtualization@lists.linux-foundation.org>;
 Fri,  3 Feb 2023 10:04:33 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 3115A820A9
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 7SzmCFLmKxrd
 for <virtualization@lists.linux-foundation.org>;
 Fri,  3 Feb 2023 10:04:32 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org DE390820A8
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com
 [IPv6:2607:f8b0:4864:20::42e])
 by smtp1.osuosl.org (Postfix) with ESMTPS id DE390820A8
 for <virtualization@lists.linux-foundation.org>;
 Fri,  3 Feb 2023 10:04:31 +0000 (UTC)
Received: by mail-pf1-x42e.google.com with SMTP id g9so3182235pfo.5
 for <virtualization@lists.linux-foundation.org>;
 Fri, 03 Feb 2023 02:04:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=igel-co-jp.20210112.gappssmtp.com; s=20210112;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=vqPOa6wQ7me1yaZ8gWql2+REBdfg2nWO86T9Pc9DfW4=;
 b=JTIWKvUBIafMXOXAwc5zu2jHnnG/zaLppVGuVMB3fRUCLIHSZaQjW7WBErdSad8Nf2
 Y7QmZCVReYCUEF5lS+pVLUizADK3zOavCz3cOrNBj8GLcxWP5cxEm7rJCn6ItoVliBi6
 lcKWfrPNPeNRTj74y1vbst6LBm+f9aZWrah8AUR/P+C98SVcjoRQGpMNsPM7WSo7AmNy
 JmM4wG4D2ADLxi3UDyVCMJcI13G/vJRDdQ1ijc4redm6X7jcVkB9FkFB7LgVLZFc/SKk
 iCSyl+CF2tZi0IkwTHPTV1DfE4XvJAJXZg1yPsDgPSZ1T+W/Xq63z73Twbv6F37RKok/
 wvWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=vqPOa6wQ7me1yaZ8gWql2+REBdfg2nWO86T9Pc9DfW4=;
 b=w52zelUpD9Y71NCDDqFhxtBiyTVaVWIom8T0b0djHjR0ccr45NJ2f7LI1xGNbATzGd
 sCnOhDhdqDi+u/AX7tcbv8Cz6qP2B+ke30g+xnBbd3jsykUNbmK7kiJmFLMUpweGCpIb
 3aLTJWWjUD/MUKEZ11qRJxwK4SFDfNLyQBqDqyA3D0wQ/f5FweddgniPU8AHqGwVly0h
 kezhqRrf284ny6zeyRPbwIFdDzR7pFnRoY5w9nZtWg1ZgSwavkF5StLbdrpwTwNuA/8z
 rmWHedoo7q/aHGIQz0AEGMw6hbYm0nmsmdWLadxpbegQqvKr9z2/r6gDnKoPvHYczvwy
 tSYg==
X-Gm-Message-State: AO0yUKU6jxIWJCaa0ByILknT+gdNZhMGT6fKQFyJsjEHCd8naq5BdeqO
 yfHL3g8VRUcMZlr8fsNKvRr3dA==
X-Google-Smtp-Source: AK7set8Y4kcnE70IRY7UtJdoEwFc/ieWHA4OwVMuzDLqXN/hzEi8OHAQTbL4MZdtSXQdly1zS67Qcw==
X-Received: by 2002:a05:6a00:2409:b0:593:5e76:b0 with SMTP id
 z9-20020a056a00240900b005935e7600b0mr9875294pfh.2.1675418671319; 
 Fri, 03 Feb 2023 02:04:31 -0800 (PST)
Received: from tyrell.hq.igel.co.jp (napt.igel.co.jp. [219.106.231.132])
 by smtp.gmail.com with ESMTPSA id
 d3-20020aa797a3000000b0058d8f23af26sm1278885pfq.157.2023.02.03.02.04.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 03 Feb 2023 02:04:31 -0800 (PST)
From: Shunsuke Mie <mie@igel.co.jp>
To: Lorenzo Pieralisi <lpieralisi@kernel.org>
Subject: [RFC PATCH 1/4] virtio_pci: add a definition of queue flag in ISR
Date: Fri,  3 Feb 2023 19:04:15 +0900
Message-Id: <20230203100418.2981144-2-mie@igel.co.jp>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230203100418.2981144-1-mie@igel.co.jp>
References: <20230203100418.2981144-1-mie@igel.co.jp>
MIME-Version: 1.0
Cc: Kishon Vijay Abraham I <kishon@kernel.org>,
 =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
 Takanari Hayama <taki@igel.co.jp>, "Michael S. Tsirkin" <mst@redhat.com>,
 linux-pci@vger.kernel.org, Manivannan Sadhasivam <mani@kernel.org>,
 Frank Li <Frank.Li@nxp.com>, linux-kernel@vger.kernel.org,
 virtualization@lists.linux-foundation.org, Ren Zhijie <renzhijie2@huawei.com>,
 Shunsuke Mie <mie@igel.co.jp>, Jon Mason <jdmason@kudzu.us>,
 Bjorn Helgaas <bhelgaas@google.com>
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

Already it has beed defined a config changed flag of ISR, but not the queue
flag. Add a macro for it.

Signed-off-by: Shunsuke Mie <mie@igel.co.jp>
Signed-off-by: Takanari Hayama <taki@igel.co.jp>
---
 include/uapi/linux/virtio_pci.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/include/uapi/linux/virtio_pci.h b/include/uapi/linux/virtio_pci.h
index f703afc7ad31..fa82afd6171a 100644
--- a/include/uapi/linux/virtio_pci.h
+++ b/include/uapi/linux/virtio_pci.h
@@ -94,6 +94,8 @@
 
 #endif /* VIRTIO_PCI_NO_LEGACY */
 
+/* Ths bit of the ISR which indicates a queue entry update */
+#define VIRTIO_PCI_ISR_QUEUE		0x1
 /* The bit of the ISR which indicates a device configuration change. */
 #define VIRTIO_PCI_ISR_CONFIG		0x2
 /* Vector value used to disable MSI for queue */
-- 
2.25.1

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
