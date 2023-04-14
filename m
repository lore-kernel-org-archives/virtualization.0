Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 05A84C77B76
	for <virtualization@archiver.kernel.org>; Fri, 14 Apr 2023 12:39:26 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 8637B84295;
	Fri, 14 Apr 2023 12:39:26 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 8637B84295
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igel-co-jp.20221208.gappssmtp.com header.i=@igel-co-jp.20221208.gappssmtp.com header.a=rsa-sha256 header.s=20221208 header.b=b7ywarHD
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id eS2lNsuT0yxV; Fri, 14 Apr 2023 12:39:25 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 35DA3842FF;
	Fri, 14 Apr 2023 12:39:25 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 35DA3842FF
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 0D64BC0036;
	Fri, 14 Apr 2023 12:39:25 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id A1B9EC002A
 for <virtualization@lists.linux-foundation.org>;
 Fri, 14 Apr 2023 12:39:23 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 6DD726FF51
 for <virtualization@lists.linux-foundation.org>;
 Fri, 14 Apr 2023 12:39:23 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 6DD726FF51
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=igel-co-jp.20221208.gappssmtp.com
 header.i=@igel-co-jp.20221208.gappssmtp.com header.a=rsa-sha256
 header.s=20221208 header.b=b7ywarHD
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id UTSIfA3IiCIU
 for <virtualization@lists.linux-foundation.org>;
 Fri, 14 Apr 2023 12:39:22 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org B58326FF0C
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com
 [IPv6:2607:f8b0:4864:20::102d])
 by smtp3.osuosl.org (Postfix) with ESMTPS id B58326FF0C
 for <virtualization@lists.linux-foundation.org>;
 Fri, 14 Apr 2023 12:39:22 +0000 (UTC)
Received: by mail-pj1-x102d.google.com with SMTP id
 hg14-20020a17090b300e00b002471efa7a8fso4796614pjb.0
 for <virtualization@lists.linux-foundation.org>;
 Fri, 14 Apr 2023 05:39:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=igel-co-jp.20221208.gappssmtp.com; s=20221208; t=1681475962; x=1684067962;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=fuOjoATSwNwQ5isXLaWbsITf7ep/YO9eHaGnk3Xv1+k=;
 b=b7ywarHDTXn9DuzxgGH5T9X8yXaaRlqT+o0+z+U6K56Sv8klVOP0I5Sja/eBAUBiQA
 auAsHdsRzbKjwT2F5ktIGoYPu30zgnbAFR483hcB5Pz9pWW77rBoy5YnVGG/MANXW3AC
 wYUuWfXmJ/yjqrUl3NuDTFn/Q9EloGImclGA+aHoB+5UEG+EUe5WDswjqS4gpxUBRcgj
 YI8GZCrPcs360w5VTYi/qWwCXraGrUBWFsZU2h5AiBLHRG298zVOWR4yLTcVT4/7FbGy
 /cFujgoQrZINwbfcMBOcQgucZ7bZYfGx+d6aUQEgzZ2UEPxO0PfP3fw0UiRqW/R7wSe1
 T+BQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1681475962; x=1684067962;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=fuOjoATSwNwQ5isXLaWbsITf7ep/YO9eHaGnk3Xv1+k=;
 b=Q/uZeXvDghA9WEnGmtBfJD3prCIFHRvy1KrrvLyLgl9gYdI4jXSPZm7kuUbaLBaaVI
 BQY16NPKS7PrZQJZtrPhAllvmCUEGpME4xPWtEUlcoADuh81UHeGJ6ZvOO5ZGOfglUWa
 CDTwENobdAad/osoW8mxAlFouqxIpttYad7mHCHPuCW1pKFOBKokqN7truX6WhKUnABk
 TO3TntXnZHDYLIEepKAmRMZzOTyuLiU10gwaLkTMEUPLZD5fRpwWFeLfrEDDSkQ7nesj
 OiCt5PobhfbKnV5uFSKYUPyYPxh+uWkx+YmaZ59V2vgAOlqp9Hv+pt8gG4ujL33Sr86w
 ypOQ==
X-Gm-Message-State: AAQBX9e0kr6zePr0gdmjrFbUjxoUG5hxjAaji1holJmRI/JiDk8hzlWf
 wTneVWhAwylGi7x1/vCRO2HWSQ==
X-Google-Smtp-Source: AKy350bbTAYGABfXjfsLqUTU/WrsVCelzkOFGUGytTzIM5zBcMTZxDzCBF1sB9aPe7WOcn+g/Ntnkw==
X-Received: by 2002:a17:902:7892:b0:1a1:97b5:c63e with SMTP id
 q18-20020a170902789200b001a197b5c63emr2479303pll.38.1681475961919; 
 Fri, 14 Apr 2023 05:39:21 -0700 (PDT)
Received: from tyrell.hq.igel.co.jp (napt.igel.co.jp. [219.106.231.132])
 by smtp.gmail.com with ESMTPSA id
 v21-20020a1709028d9500b001a527761c31sm3015366plo.79.2023.04.14.05.39.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 14 Apr 2023 05:39:21 -0700 (PDT)
From: Shunsuke Mie <mie@igel.co.jp>
To: Lorenzo Pieralisi <lpieralisi@kernel.org>
Subject: [RFC PATCH 2/3] virtio_pci: add a definition of queue flag in ISR
Date: Fri, 14 Apr 2023 21:39:02 +0900
Message-Id: <20230414123903.896914-3-mie@igel.co.jp>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230414123903.896914-1-mie@igel.co.jp>
References: <20230414123903.896914-1-mie@igel.co.jp>
MIME-Version: 1.0
Cc: Kishon Vijay Abraham I <kishon@kernel.org>,
 =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
 Randy Dunlap <rdunlap@infradead.org>, "Michael S. Tsirkin" <mst@redhat.com>,
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
---
 include/uapi/linux/virtio_pci.h | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/include/uapi/linux/virtio_pci.h b/include/uapi/linux/virtio_pci.h
index f703afc7ad31..d405bea27240 100644
--- a/include/uapi/linux/virtio_pci.h
+++ b/include/uapi/linux/virtio_pci.h
@@ -94,6 +94,9 @@
 
 #endif /* VIRTIO_PCI_NO_LEGACY */
 
+/* Bits for ISR status field:only when if MSI-X is disabled */
+/* The bit of the ISR which indicates a queue entry update. */
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
