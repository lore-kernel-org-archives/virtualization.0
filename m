Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D6AE35968
	for <virtualization@lists.linux.dev>; Mon,  9 Dec 2024 13:31:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733751077; cv=none; b=seeDS5Thz5BZdK5wtLJjBWHSFdGqIQ5DsqVePhWEX+Bd4LtS5W3G8Kn0clsoxM4tI6YMwaRkVr9r0fzcb2xIBN1tQRQ23TB75Gb4Cwuz2Oyz4eAf13u6Ms9VrKBWwY6cExCzgiXVctgCZFfOxgrtF3P2duDn1gyEqwDmR8MRSXk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733751077; c=relaxed/simple;
	bh=1H2yYR4fWimIzimli7rKNJTjfr7H1SoQ5tzNP52S2i8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=LCTPqb3W6h0/kEPNXPgeN/SWcpU0zoYaBZ4vuhN4bnc9fgMy2X/n+fdCtrb24Re4cDCoEJS7bMKcBayDtEH7dvNwp14yxFAemfIkbEA/kyfskmGSSUHi7kF8yFw9yJGOmvj2EtMPbSOaAilXe7DPT628b64salgTj0FJO2gyN0o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=feyrXe9p; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="feyrXe9p"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1733751074;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=EJJrk6X28C8CR+DZtpKKo6pW56zGxdkQs6FbM6/Q0HU=;
	b=feyrXe9pWI79da6VniXLVW1J6N6sx2tCwco3N8Q/DWl+5ezhl3Kez6JtJAtMEIBORhmkg5
	ISyKSI36ECayJzUwpKxCQ/A6tt/QFZM9gOttFruMvKauatJOye7Sns10OF0iTSRUrz1wX9
	s7JjREurSurFn8aYlhgZi8ei4RGZ54Q=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-112-L646xQSePPOcpuuaZ-5QWQ-1; Mon, 09 Dec 2024 08:31:13 -0500
X-MC-Unique: L646xQSePPOcpuuaZ-5QWQ-1
X-Mimecast-MFC-AGG-ID: L646xQSePPOcpuuaZ-5QWQ
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-7b6cfc8fc17so241236085a.1
        for <virtualization@lists.linux.dev>; Mon, 09 Dec 2024 05:31:13 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733751073; x=1734355873;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EJJrk6X28C8CR+DZtpKKo6pW56zGxdkQs6FbM6/Q0HU=;
        b=TsBjed2M0pr2aulNh4TIMcVyHsIJz62iarGdbJIZSWaCkzoai9gc0EvYsyh5fNVcIi
         TykqgyKz2/+TRiduPisOSLaZbwN0QM4o6USAgT0WfU2kps7LgJQpaaJmyDHT9HgJYxXB
         WqT7r84838ksjHAurmdm+Bk+vkispIz4P+KqSKjIJbN6t78ruLfYA2Rrag/d89JDfXH9
         h+2Mg/2BXuqWM6DnTWVKpNZaWIiup9uGpG/qdNcbi7E4NFHu53Sc55NLQ3jYIfSt9Jgo
         03UdaPGTpVz7frQeqNP5yAIWlSU3vZBnkNSSW9ltnLlw7IRVTjCYBZqxUNx5hSjP4Pym
         XI1w==
X-Forwarded-Encrypted: i=1; AJvYcCW2DiFXdBZTvrmwI9mBaWT+Du9rCrQ9ACKlUGWaTumlAQoU+E2cTC9w4qEKe5E5ecF/PfSSuK9haQtNI10XAA==@lists.linux.dev
X-Gm-Message-State: AOJu0YyE4ppI/Rs92hcVihCkWN4PmQWX3TLDeccjQM7NZblg8Md+zArB
	P3yVKD0B0xc5IJl0Z8kn2IzpAPDmCPg5GlYZjqJdSI+z75G3bKgpv0Ye8DBTA2OmlPAwyG1ZQtk
	tExRfTgmowlQdP7DCwF3f2NFgTnwViyPsXG0giJH1rGUE36MAdh5g4fOTyIFnUnaU
X-Gm-Gg: ASbGncvRGNGOMg/FgzGyOc12T5UkFw4+wrezA2NHoOKxTupqgZz6cjKRTlSuy9UmbKv
	xCT/WRVgHnDEw/swcZgR5PST2WjURtAbAOc99cQ+6IR7FZYdoQaW/tY1FTTUmRXkx/zidEi4YqP
	syoisSSEwNCgUWt1cGgjBEj3Rxk/aCkZQsDl8hq9mKIkwgkOF/ByWiNpWvZu0IoazzzQaLpiOjT
	mdAUxeeHtx4HGMEhTuenTmA2Czno/LNzJylOLGR3OdzEJST8SL2QYz7Jl7H+QBxLJMYQXwIz5sl
	dCoOB7SdJZ52SdRcVfoUkoTyVQ==
X-Received: by 2002:a05:620a:8907:b0:7b6:cedf:1b48 with SMTP id af79cd13be357-7b6cedf1cf5mr1047520385a.3.1733751072839;
        Mon, 09 Dec 2024 05:31:12 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHHOffgDQ8/bjuiYZrcLXualPEwUTQlzYmQoIldXxXgZHOWsGH5VE9kSfFc+AkR+6USYKF4jQ==
X-Received: by 2002:a05:620a:8907:b0:7b6:cedf:1b48 with SMTP id af79cd13be357-7b6cedf1cf5mr1047514985a.3.1733751072389;
        Mon, 09 Dec 2024 05:31:12 -0800 (PST)
Received: from sgarzare-redhat (host-87-12-25-244.business.telecomitalia.it. [87.12.25.244])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7b6d447cba1sm113579385a.116.2024.12.09.05.31.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Dec 2024 05:31:11 -0800 (PST)
Date: Mon, 9 Dec 2024 14:31:05 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
To: Philipp Stanner <pstanner@redhat.com>
Cc: Alvaro Karsz <alvaro.karsz@solid-run.com>, 
	"Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, 
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>, 
	virtualization@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] vdpa: solidrun: Replace deprecated PCI functions
Message-ID: <whzxo7v7ocomwvx2onrccrrnfc7eg5g5yeusoifmmflaiawaa6@xylztblydibz>
References: <20241209115118.125940-2-pstanner@redhat.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20241209115118.125940-2-pstanner@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: f9Hy5Gl2IBTbQ3c1TjFKiTvDSsTpdJDnMu_bRuGKdCA_1733751073
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline

On Mon, Dec 09, 2024 at 12:51:18PM +0100, Philipp Stanner wrote:
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
>Changes in v2:
>  - Fix build warning because of dead variable.
>  - Make "bars_found" a boolean, since only true or false are relevant.
>---
> drivers/vdpa/solidrun/snet_main.c | 55 ++++++++++++++-----------------
> 1 file changed, 25 insertions(+), 30 deletions(-)
>
>diff --git a/drivers/vdpa/solidrun/snet_main.c b/drivers/vdpa/solidrun/snet_main.c
>index c8b74980dbd1..1b9841698a1a 100644
>--- a/drivers/vdpa/solidrun/snet_main.c
>+++ b/drivers/vdpa/solidrun/snet_main.c
>@@ -556,59 +556,57 @@ static const struct vdpa_config_ops snet_config_ops = {
> static int psnet_open_pf_bar(struct pci_dev *pdev, struct psnet *psnet)
> {
> 	char *name;
>-	int ret, i, mask = 0;
>+	unsigned short i;
>+	bool bars_found = false;
>+	void __iomem *io;

I would suggest to move this declaration (*io) inside the for loop where 
it's used.

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
>+		if (pci_resource_len(pdev, i) == 0)
>+			continue;
>+
>+		io = pcim_iomap_region(pdev, i, name);
>+		if (IS_ERR(io)) {
>+			SNET_ERR(pdev, "Failed to request and map PCI BARs\n");
>+			return PTR_ERR(io);

Now instead of calling pcim_iomap_regions() once, we need to call 
pcim_iomap_region() multiple times.
If one of these fails, should we unmap the ones we mapped before?

Thanks,
Stefano

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
>@@ -656,15 +654,12 @@ static int psnet_detect_bar(struct psnet *psnet, u32 off)
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

