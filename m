Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 026A31DFE08
	for <virtualization@lists.linux.dev>; Fri, 13 Dec 2024 15:10:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734102636; cv=none; b=W/OlXkjR4Y2JnT4fdDScVq3GiMhMOOk1JHopdRhD0gUYMu7ewzbF8L293NEcmHDQshSDp2SqCJWsun0qOFex2PP1gRZU3c8LOlLKGtg9Rojz4viEqQ2vpDWmgXDZUC9cH5lSOtuM9pWpo0ICvWFVAmUpjuk/qvqjwLa2hINtciM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734102636; c=relaxed/simple;
	bh=xSgxkdchTJyFCqqvoi9ov9RsXW8Hs0dq0bbwd76PbfY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=H0lA+e/HW/UDNlFTlXLd/8WAhv0wUdXwGIpmgoOT13ZJxeebcWLHfE1DxgNJflBT7K+cLnsR5R5Ru8oTQLBrCF3vmwe45KPiHeDYo817w1R1XnzoDXw/C1vh6Gx3S50fWsg/QrBOnxPb+qyKb6xrCBq6mIw8Nn/fr1eBuuqjcL0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Dfj44iC2; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Dfj44iC2"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1734102633;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=6BEyRorFLWfoHHa/oesuugW/TqvR2Li1O4P72mmMm/o=;
	b=Dfj44iC2dPXy8Ir9iw4YwJGnefAjAhvDCTdh5/mJms67bA6JOpFck1aHlEH2n8ks4kEBFJ
	MDOz+TK9udv8PWckwMCnIvAGouPobVReSSTXYsbqaiV3iT6WvrkZujg7UUas+1kIBtC0v1
	3C6KaZzZgHOdhwqtcPunE7nnCzo3XsI=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-190-wz_5c4CtP1GJ7udY-tj3JQ-1; Fri, 13 Dec 2024 10:10:32 -0500
X-MC-Unique: wz_5c4CtP1GJ7udY-tj3JQ-1
X-Mimecast-MFC-AGG-ID: wz_5c4CtP1GJ7udY-tj3JQ
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-467982f8816so43281031cf.1
        for <virtualization@lists.linux.dev>; Fri, 13 Dec 2024 07:10:32 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734102632; x=1734707432;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6BEyRorFLWfoHHa/oesuugW/TqvR2Li1O4P72mmMm/o=;
        b=V9U0khMcT+wHqzTg4qfeAATpunOgKFdjxpFsZH0amLPwqHvDcynzCjlCFu0V6GKIHa
         wJMT9hVfOMQJirSsxyn0QEKRWw2UmYHhZyjdI7A45Gtx21Ufwh75eqW3c+hO/8ohUgMa
         sQ/O0Qq/FXH5SvmqShCxlJ5qsfc3/b37X5hkanJdR5LtVDgYqrbslHxNKk337a8Q6Yzp
         ZL4GK3831e0RMyJ07FunW2W1ZmO3PDJWE5f2B/0RcOnnLPPkOz2uKvXAs26XiIUtpbNh
         Vg2zI6+qR2fWpOosWPb0oCTB0MGy1UWzMlY7E7FR0XTPxnYbhj7TgY6CQxP373ft02FG
         ZeTQ==
X-Forwarded-Encrypted: i=1; AJvYcCVtYC4lCDR7cHD17qLJmtXc9QPv8j5Qo72GUPkjyK0FK9QrYTTIH36UKCvCCz7RMNtOVrEf3AOTsYSpa9FrHg==@lists.linux.dev
X-Gm-Message-State: AOJu0YwoYuHkuA2zvq0c7HUfPpm1Fer8b6VBH12haIA6OCnMhFg0OBWO
	3PId6Kw8SjKb2kF4ywyO6qgfkCL9QTVIqgCAF63dQW2AhZuXL8LVOLEvWxK9ekv0XunbbPHAntw
	4cZoN9acKZGwQ7LBwY+Q5pbEHP27s4JAeMqOAKji6kDaQ03bJvgZaJ7D028WwutTO
X-Gm-Gg: ASbGncuBia/shbFkGMTYq+42HkAFXken5yU85C7facN/6hJL3VQV3zjLicSVEhDqbD2
	cUCZ2Xb3PiUjIyIESuVpMO00NFhjhQV6Z29DsWYSftxE0PyAiGXYyGVhaiABKkXCrQiPptg87x1
	v7TLsrSTRVMrn44/e/7l3jojM82BTjNNhVRoxu+flRzpa5+8Uw2APdViEHXLVB39kGAGbTw8fEp
	LnPu3dZtqocMkUmNqPkemIbmk2SUSuqqS3YGAeHuN9l0AZe/V1YQes15rYNV5depaZbRPaBID8l
	k+11PNEC1x/6YzNqwJXWK9qFb2d90icB
X-Received: by 2002:ac8:580d:0:b0:460:9ac7:8fcd with SMTP id d75a77b69052e-467a57187fdmr52846281cf.1.1734102632402;
        Fri, 13 Dec 2024 07:10:32 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGAC+FS+51MMmMCXEiGRCIxWdIv4Ie7rXV1jDHWY/BSX2ZUme69goy8f4oh8q1WbfMuFRI6jw==
X-Received: by 2002:ac8:580d:0:b0:460:9ac7:8fcd with SMTP id d75a77b69052e-467a57187fdmr52845841cf.1.1734102631983;
        Fri, 13 Dec 2024 07:10:31 -0800 (PST)
Received: from sgarzare-redhat (host-87-12-185-21.business.telecomitalia.it. [87.12.185.21])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-46776526082sm42161231cf.14.2024.12.13.07.10.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Dec 2024 07:10:31 -0800 (PST)
Date: Fri, 13 Dec 2024 16:10:25 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
To: Philipp Stanner <pstanner@redhat.com>
Cc: Alvaro Karsz <alvaro.karsz@solid-run.com>, 
	"Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, 
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>, 
	virtualization@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] vdpa: solidrun: Replace deprecated PCI functions
Message-ID: <vr7gh5y7ooomyj6hazju7khcuyvw5qs2xjsybj33ztcim3vtc4@gdbozbxlcsi3>
References: <20241211104704.208354-2-pstanner@redhat.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20241211104704.208354-2-pstanner@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: tha8KtJF3T7CzgHXsF02nEfXgHuHgLn6NVao7zO8Igs_1734102632
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline

On Wed, Dec 11, 2024 at 11:47:05AM +0100, Philipp Stanner wrote:
>The PCI functions
>
>	pcim_iomap_regions()
>	pcim_iounmap_regions()
>	pcim_iomap_table()
>
>have been deprecated by the PCI subsystem.
>
>Replace these functions with their successors pcim_iomap_region() and
>pcim_iounmap_region().
>
>Signed-off-by: Philipp Stanner <pstanner@redhat.com>
>---
>Changes in v3:
>  - Move __iomem *io declaration into the loop. (Stefano)
>
>Changes in v2:
>  - Fix build warning because of dead variable.
>  - Make "bars_found" a boolean, since only true or false are relevant.
>---
> drivers/vdpa/solidrun/snet_main.c | 56 ++++++++++++++-----------------
> 1 file changed, 26 insertions(+), 30 deletions(-)
>
>diff --git a/drivers/vdpa/solidrun/snet_main.c b/drivers/vdpa/solidrun/snet_main.c
>index c8b74980dbd1..643e335f00f1 100644
>--- a/drivers/vdpa/solidrun/snet_main.c
>+++ b/drivers/vdpa/solidrun/snet_main.c
>@@ -556,59 +556,58 @@ static const struct vdpa_config_ops snet_config_ops = {
> static int psnet_open_pf_bar(struct pci_dev *pdev, struct psnet *psnet)
> {
> 	char *name;
>-	int ret, i, mask = 0;
>+	unsigned short i;
>+	bool bars_found = false;
>+
>+	name = devm_kasprintf(&pdev->dev, GFP_KERNEL, "psnet[%s]-bars", pci_name(pdev));
>+	if (!name)
>+		return -ENOMEM;
>+
> 	/* We don't know which BAR will be used to communicate..
> 	 * We will map every bar with len > 0.
> 	 *
> 	 * Later, we will discover the BAR and unmap all other BARs.
> 	 */
> 	for (i = 0; i < PCI_STD_NUM_BARS; i++) {
>-		if (pci_resource_len(pdev, i))
>-			mask |= (1 << i);
>+		void __iomem *io;
>+
>+		if (pci_resource_len(pdev, i) == 0)
>+			continue;
>+
>+		io = pcim_iomap_region(pdev, i, name);
>+		if (IS_ERR(io)) {
>+			SNET_ERR(pdev, "Failed to request and map PCI BARs\n");
>+			return PTR_ERR(io);
>+		}
>+
>+		psnet->bars[i] = io;
>+		bars_found = true;
> 	}
>
> 	/* No BAR can be used.. */
>-	if (!mask) {
>+	if (!bars_found) {
> 		SNET_ERR(pdev, "Failed to find a PCI BAR\n");
> 		return -ENODEV;
> 	}
>
>-	name = devm_kasprintf(&pdev->dev, GFP_KERNEL, "psnet[%s]-bars", pci_name(pdev));
>-	if (!name)
>-		return -ENOMEM;
>-
>-	ret = pcim_iomap_regions(pdev, mask, name);
>-	if (ret) {
>-		SNET_ERR(pdev, "Failed to request and map PCI BARs\n");
>-		return ret;
>-	}
>-
>-	for (i = 0; i < PCI_STD_NUM_BARS; i++) {
>-		if (mask & (1 << i))
>-			psnet->bars[i] = pcim_iomap_table(pdev)[i];
>-	}
>-
> 	return 0;
> }
>
> static int snet_open_vf_bar(struct pci_dev *pdev, struct snet *snet)
> {
> 	char *name;
>-	int ret;
>
> 	name = devm_kasprintf(&pdev->dev, GFP_KERNEL, "snet[%s]-bars", pci_name(pdev));
> 	if (!name)
> 		return -ENOMEM;
>
> 	/* Request and map BAR */
>-	ret = pcim_iomap_regions(pdev, BIT(snet->psnet->cfg.vf_bar), name);
>-	if (ret) {
>+	snet->bar = pcim_iomap_region(pdev, snet->psnet->cfg.vf_bar, name);

Could we also use a temporary variable here as we did in 
psnet_open_pf_bar()?

It seems to me that no one uses `!snet->bar` for now to check whether 
they are configured or not, but maybe better to prevent, WDYT?

Thanks,
Stefano

>+	if (IS_ERR(snet->bar)) {
> 		SNET_ERR(pdev, "Failed to request and map PCI BAR for a VF\n");
>-		return ret;
>+		return PTR_ERR(snet->bar);
> 	}
>
>-	snet->bar = pcim_iomap_table(pdev)[snet->psnet->cfg.vf_bar];
>-
> 	return 0;
> }
>
>@@ -656,15 +655,12 @@ static int psnet_detect_bar(struct psnet *psnet, u32 off)
>
> static void psnet_unmap_unused_bars(struct pci_dev *pdev, struct psnet *psnet)
> {
>-	int i, mask = 0;
>+	unsigned short i;
>
> 	for (i = 0; i < PCI_STD_NUM_BARS; i++) {
> 		if (psnet->bars[i] && i != psnet->barno)
>-			mask |= (1 << i);
>+			pcim_iounmap_region(pdev, i);
> 	}
>-
>-	if (mask)
>-		pcim_iounmap_regions(pdev, mask);
> }
>
> /* Read SNET config from PCI BAR */
>-- 
>2.47.1
>

