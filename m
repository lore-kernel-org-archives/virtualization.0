Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 46337C433F5
	for <virtualization@archiver.kernel.org>; Mon, 10 Oct 2022 17:12:28 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id C1454405EC;
	Mon, 10 Oct 2022 17:12:27 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org C1454405EC
Authentication-Results: smtp2.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=cVOG64Hv
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id V_DXyuHzMZBB; Mon, 10 Oct 2022 17:12:27 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 54379400A6;
	Mon, 10 Oct 2022 17:12:26 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 54379400A6
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 350BAC0032;
	Mon, 10 Oct 2022 17:12:26 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id CCEF4C002D
 for <virtualization@lists.linux-foundation.org>;
 Mon, 10 Oct 2022 17:12:25 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 98B0F40865
 for <virtualization@lists.linux-foundation.org>;
 Mon, 10 Oct 2022 17:12:25 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 98B0F40865
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=cVOG64Hv
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id afrrxWd2vI6j
 for <virtualization@lists.linux-foundation.org>;
 Mon, 10 Oct 2022 17:12:24 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org A68F940860
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id A68F940860
 for <virtualization@lists.linux-foundation.org>;
 Mon, 10 Oct 2022 17:12:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1665421943;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
 bh=NQfJCIP1SalvtcFCK3pdAaYE1SnNGgH0a1J3wHjmhUg=;
 b=cVOG64Hvz2isSJ/OlHmWpgeIU+4c3nwJ/9LIkhPZlMCPLFlSvHnQRY634rC1+qnIKpEO8N
 4rXLy6/HzYbObwr27rqkULPjHJ/Hh1yz5qpNyy24CgB+z/i7NI75p13kgpN5PSq68Ge2gu
 cGvfpMCw79GrPjHMwZnxMFkA4gNY1Jc=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-479-3dtEYqCaMbSHMxhFDfJhbA-1; Mon, 10 Oct 2022 13:12:22 -0400
X-MC-Unique: 3dtEYqCaMbSHMxhFDfJhbA-1
Received: by mail-wm1-f70.google.com with SMTP id
 c5-20020a1c3505000000b003c56da8e894so3097347wma.0
 for <virtualization@lists.linux-foundation.org>;
 Mon, 10 Oct 2022 10:12:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=content-disposition:mime-version:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=NQfJCIP1SalvtcFCK3pdAaYE1SnNGgH0a1J3wHjmhUg=;
 b=2/eunmc8EcXclDUPSixIrbIZcgTqU3r2OeH10ZqWuv5RVricQ21FQXNKSYuHCgp5lb
 6nrFpbB2rg37ZTg/Kb08VrIdrUmlaZvjgO5hlbMQSWAJiYsQfovmC830wo5SO5B34rIA
 XVpSmypjBPmb03LYGAadW4mpAij3g3795snwdW7pNFGS7oect76Oay3+5haSZS95XVCq
 OlJK+gxG5eGCb4RkBNQWUgwXlxu4ykHSLXdvbdDLu+i+MnQbyJA0XTon7n36wI7QXh+X
 lkcVB8cLfou1ydm8gBTo1QAl956qa4uRlED87k49flauBEoijFAG9uaqLdboK0RGnEyn
 AKwA==
X-Gm-Message-State: ACrzQf3fML9CDgZZ4POECVUe8o6olSwdJJCWwBUkEhJEp3Cv6mWsq867
 TQz+9sN8oAR6UfFnVbgpCyjZlUrwYwGmkYx1J8RmbePrq+5U0qDCaVHiW5y1ZlQjvJLVUFHSLHM
 hzlu4iHhMb3ea0HxdVWFvPKsYtSRlshc4VEmj5hrQuQ==
X-Received: by 2002:a05:600c:3845:b0:3b4:b187:3d09 with SMTP id
 s5-20020a05600c384500b003b4b1873d09mr20540150wmr.96.1665421940997; 
 Mon, 10 Oct 2022 10:12:20 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM63cjhz7XzZhJCporbzOGCOCeEtLMeJPQcnHObTdg8t2i7mRm/yvHLdG4jtj6Aj67AJhVchlg==
X-Received: by 2002:a05:600c:3845:b0:3b4:b187:3d09 with SMTP id
 s5-20020a05600c384500b003b4b1873d09mr20540132wmr.96.1665421940794; 
 Mon, 10 Oct 2022 10:12:20 -0700 (PDT)
Received: from redhat.com ([2.55.183.131]) by smtp.gmail.com with ESMTPSA id
 a13-20020adff7cd000000b0022a403954c3sm9339737wrq.42.2022.10.10.10.12.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 10 Oct 2022 10:12:20 -0700 (PDT)
Date: Mon, 10 Oct 2022 13:12:15 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: linux-kernel@vger.kernel.org
Subject: [PATCH RFC] pci: fix device presence detection for VFs
Message-ID: <20221009191835.4036-1-mst@redhat.com>
MIME-Version: 1.0
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
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

virtio uses the same driver for VFs and PFs.  Accordingly,
pci_device_is_present is used to detect device presence. This function
isn't currently working properly for VFs since it attempts reading
device and vendor ID. Result is device marked broken incorrectly.  As
VFs are present if and only if PF is present, just return the value for
that device.

Reported-by: gongwei <gongwei833x@gmail.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>

---

Warning - compile tested only. gongwei could you help test and report
please?

 drivers/pci/pci.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index 95bc329e74c0..ba29b8e2f3c1 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -6462,6 +6462,9 @@ bool pci_device_is_present(struct pci_dev *pdev)
 {
 	u32 v;
 
+	if (pdev->is_virtfn)
+		return pci_device_is_present(pdev->physfn);
+
 	if (pci_dev_is_disconnected(pdev))
 		return false;
 	return pci_bus_read_dev_vendor_id(pdev->bus, pdev->devfn, &v, 0);
-- 
MST

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
