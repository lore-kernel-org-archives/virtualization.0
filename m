Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 158411D3185
	for <virtualization@lists.linux.dev>; Tue, 27 Aug 2024 18:56:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724784988; cv=none; b=iuIO3C7wK8nKlVGP+oJCbfaF0/50bV4hZrMRyCFFikHfiJuZhoRL6nnIGiqmxGZK8vYwwnZ8rioRFQCvuM5aYxPtygUTOWCHGpOsGj350LgMI/lSPfJ2cXaGrISlVlqSs0aQdceFGfqh/YXd4YUtwg3RdvCrPt09dyv0esOgv0g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724784988; c=relaxed/simple;
	bh=V4KRcC8BfWc5Sti/Fdc73KUa8QY4uocvnp5UyVnLmQQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=AgcLsTPxFBevVz+JDLoGJNwzKcP8mR22xoOjBEVzB8Umupyiu/q+1X2lWW0gqGrzMMyBX/vtbs5Y2ezBm9Y+G5QjUthWnFAiLlaX5/G9Y7WIP9vqkeiwZHEq9lbCyIFyYQD/Zm8Iey9ubML0E0ZCxg1QsVVtNZJkthTgdmY1iDM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=IjKKDlEn; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IjKKDlEn"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1724784986;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=j5hLs33+KllKyvrdGIaXp9UPbFVf3GpM3GrIwQsqtHc=;
	b=IjKKDlEn0CGsl43y2f2akmAb0rKJQos75gzdXCRkVtj/RNw19o3hF6/JBE4y5M0kvfWwIh
	QHQqaCahbq1RYYiT/tZR1D6nzda0Pa89eTHbsmdnk0zSnH93b+F/6vgONrrTBl9omoQaZA
	jGiN1WNG4v4fqI9MJ5XQvZ3WKbUh0CE=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-647-jqIglistMqu5kw894oq1bg-1; Tue, 27 Aug 2024 14:56:25 -0400
X-MC-Unique: jqIglistMqu5kw894oq1bg-1
Received: by mail-ej1-f72.google.com with SMTP id a640c23a62f3a-a7d6a72ad99so526972366b.2
        for <virtualization@lists.linux.dev>; Tue, 27 Aug 2024 11:56:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724784984; x=1725389784;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=j5hLs33+KllKyvrdGIaXp9UPbFVf3GpM3GrIwQsqtHc=;
        b=isBg/tYk/jM3KE/A0UErn8qc7n096YObtVpxle1G4q41PGhmALFYoyiXaDhjYmLGf8
         Sw9G1tkp9DyfJJr3qNBHlLGSsHb6WwkHPXqQHC4zPRC+ov7Qgpr3i5eif7NJB5sO6t/h
         HGDRX57iFnAes5ZnBB0WFrlbZ7EZSpOyVADMQefuyrdt/ukyFj2fEzlb+16mOW1xr50d
         qHyL6UC8IQja41tNuc0UwnJW9HW8Fs4tIjEB46wYy3l3/bZ/gCnY8Io2liNVn0X9drNv
         aw8cRN89HvHVKej/qjg1BFJ0UsybVyE/4tJaL9Hm6ROAZITyCSGbd0CIOvTJ1cSWEixs
         Miow==
X-Forwarded-Encrypted: i=1; AJvYcCUxseF+ZmXJQ5Da4XDTdnZ4aOk3copiRhf/ExadxhND9l1pk9rX7k4ydVKWUlnqGFbprPIw9G5NWfHAAviaWw==@lists.linux.dev
X-Gm-Message-State: AOJu0YySqdZATE5b1m1gFvI3I5SGJE+1xR8NMPHwy6dkyQmkCWFEO9r9
	FABW/bFiFPHBdpwJuuqFHAk3cJrewVBX2haWqOzpjpZtDqa1V1cFg4Gbf735UHyqrTsPGttlg3W
	0tYKnLUcgNRPTELTtqfmzRMc7WxaabJhWDiC6Xf8Zo0Ealx+QXCG00J+l8kjyKZrLUDyZHSCY
X-Received: by 2002:a17:907:7252:b0:a77:cf9d:f495 with SMTP id a640c23a62f3a-a86e3a4ce7fmr296320966b.40.1724784983724;
        Tue, 27 Aug 2024 11:56:23 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE/x6IpxLJLbWNctYsTotEW22H/JYXErvbzu49sBel1g7SXflnutqyYs4SKAlH6O5BaH+21/w==
X-Received: by 2002:a17:907:7252:b0:a77:cf9d:f495 with SMTP id a640c23a62f3a-a86e3a4ce7fmr296318366b.40.1724784983124;
        Tue, 27 Aug 2024 11:56:23 -0700 (PDT)
Received: from eisenberg.fritz.box ([2001:16b8:3dbc:3c00:460c:db7e:8195:ddb5])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a86e549c4e9sm141473066b.47.2024.08.27.11.56.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Aug 2024 11:56:22 -0700 (PDT)
From: Philipp Stanner <pstanner@redhat.com>
To: ens Axboe <axboe@kernel.dk>,
	Wu Hao <hao.wu@intel.com>,
	Tom Rix <trix@redhat.com>,
	Moritz Fischer <mdf@kernel.org>,
	Xu Yilun <yilun.xu@intel.com>,
	Andy Shevchenko <andy@kernel.org>,
	Linus Walleij <linus.walleij@linaro.org>,
	Bartosz Golaszewski <brgl@bgdev.pl>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Alvaro Karsz <alvaro.karsz@solid-run.com>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	=?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>,
	Richard Cochran <richardcochran@gmail.com>,
	Damien Le Moal <dlemoal@kernel.org>,
	Hannes Reinecke <hare@suse.de>,
	Keith Busch <kbusch@kernel.org>,
	Philipp Stanner <pstanner@redhat.com>
Cc: linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-fpga@vger.kernel.org,
	linux-gpio@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-pci@vger.kernel.org,
	virtualization@lists.linux.dev
Subject: [PATCH v4 2/7] fpga/dfl-pci.c: Replace deprecated PCI functions
Date: Tue, 27 Aug 2024 20:56:07 +0200
Message-ID: <20240827185616.45094-3-pstanner@redhat.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240827185616.45094-1-pstanner@redhat.com>
References: <20240827185616.45094-1-pstanner@redhat.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"; x-default=true

pcim_iomap_regions() and pcim_iomap_table() have been deprecated by the
PCI subsystem in commit e354bb84a4c1 ("PCI: Deprecate
pcim_iomap_table(), pcim_iomap_regions_request_all()").

Port dfl-pci.c to the successor, pcim_iomap_region().

Consistently, replace pcim_iounmap_regions() with pcim_iounmap_region().

Signed-off-by: Philipp Stanner <pstanner@redhat.com>
Reviewed-by: Andy Shevchenko <andy@kernel.org>
Acked-by: Xu Yilun <yilun.xu@intel.com>
---
 drivers/fpga/dfl-pci.c | 16 ++++------------
 1 file changed, 4 insertions(+), 12 deletions(-)

diff --git a/drivers/fpga/dfl-pci.c b/drivers/fpga/dfl-pci.c
index 80cac3a5f976..602807d6afcc 100644
--- a/drivers/fpga/dfl-pci.c
+++ b/drivers/fpga/dfl-pci.c
@@ -39,14 +39,6 @@ struct cci_drvdata {
 	struct dfl_fpga_cdev *cdev;	/* container device */
 };
 
-static void __iomem *cci_pci_ioremap_bar0(struct pci_dev *pcidev)
-{
-	if (pcim_iomap_regions(pcidev, BIT(0), DRV_NAME))
-		return NULL;
-
-	return pcim_iomap_table(pcidev)[0];
-}
-
 static int cci_pci_alloc_irq(struct pci_dev *pcidev)
 {
 	int ret, nvec = pci_msix_vec_count(pcidev);
@@ -235,9 +227,9 @@ static int find_dfls_by_default(struct pci_dev *pcidev,
 	u64 v;
 
 	/* start to find Device Feature List from Bar 0 */
-	base = cci_pci_ioremap_bar0(pcidev);
-	if (!base)
-		return -ENOMEM;
+	base = pcim_iomap_region(pcidev, 0, DRV_NAME);
+	if (IS_ERR(base))
+		return PTR_ERR(base);
 
 	/*
 	 * PF device has FME and Ports/AFUs, and VF device only has one
@@ -296,7 +288,7 @@ static int find_dfls_by_default(struct pci_dev *pcidev,
 	}
 
 	/* release I/O mappings for next step enumeration */
-	pcim_iounmap_regions(pcidev, BIT(0));
+	pcim_iounmap_region(pcidev, 0);
 
 	return ret;
 }
-- 
2.46.0

