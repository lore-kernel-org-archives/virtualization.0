Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5877C22332C
	for <virtualization@lists.linux.dev>; Thu, 19 Dec 2024 09:51:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734601891; cv=none; b=N7dzImhLVYDeszRdONX+MgMdj9CXpdOLQ8CMvgcb51sZvEPX8/FKE9cqRbeEc4yZOt36gKbc5MKinV8ifFxAQ6J/JY1ryT76Px7+EkyxBgoPnvVap6iMfPS1Y3fFjjnY7bv7tm/PY2fe5mDuJUc5XTk+AbWGCocqgMTscL5M8oE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734601891; c=relaxed/simple;
	bh=dS+t8iRYNHXKkiKO0OihFQ73xy+AmgcTAnDXCb4ReyM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=hzVlpkqUcaI79hvcfqz4EOBoZAjwRWUp88cMurM1ItsZimlStumab6VTE+sn3yE+0T8dc3RL0lV8IHG8UDePMHXHXWHyb0WHWzJ824x6SgrU/dUY0tIfdxwRokDSlLK73xNlj8DipcFhupRMliXHSyh1xNqMDaDQE6AKD4+tfl8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=CYNX1WVF; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CYNX1WVF"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1734601889;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=JO1+VcCLtHKK/PETCCCMOlhDindIy1p55HqjLYt/wIU=;
	b=CYNX1WVF2eueNG7muoeDJVq7bugkK6HN6dz2lgbVBVQarWjTM1PI6b3eMJA9sExGJN0G1J
	sV/SZpFTj2wc4RqpVIPOcr8v8acxoWw3NjGI3Ec5bx8RMZsqMxd9CjA+/YFquLH8iHCzlk
	i+Pu/NyjcWmNuLk1VoLFZ4dqPrvuy4Y=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-58-B7IvKKfwPGu3I1HWnFd0lg-1; Thu, 19 Dec 2024 04:51:27 -0500
X-MC-Unique: B7IvKKfwPGu3I1HWnFd0lg-1
X-Mimecast-MFC-AGG-ID: B7IvKKfwPGu3I1HWnFd0lg
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-43651b1ba8aso4851355e9.1
        for <virtualization@lists.linux.dev>; Thu, 19 Dec 2024 01:51:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734601886; x=1735206686;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JO1+VcCLtHKK/PETCCCMOlhDindIy1p55HqjLYt/wIU=;
        b=rrMcFkMw34NtS+gOCN4k6SAP7UJ4YDXAK9NE3RvCUwzsiSRRI2pBstver0bcrffHs8
         2H6amlnuUgyJtCvAiVMnCtkYHuyc7R+M4VQNMEUqFg3uDwYz6hkak4vJ8Pn+clpBM8yZ
         ubanF/GSz3mpe6ZyySXOY3ViaKgfCKza3JrUcCLtKq4IMteiMeOJWjJBytpVPCiJQsf0
         YvH5bRABcwiayRKps7Q125MdcGRWUNn/xKbgcRYL/IdPBkkv2Enf3YBA0c4o5v8iuD+b
         S8M/uMDC+mmC6KB7MLhXeu0iBxkW8c9S/tntymC1aAfeLMdYbAgwaCUUVnDJ0Pm3M6Sm
         o90Q==
X-Forwarded-Encrypted: i=1; AJvYcCWmdBnnbB6JTT3uR+CdDcABvhnR8DqK825OT0LlXxaLBIxV2GAOUX7AWlty/irCWZALdCF7su+jeGqVZZF3sQ==@lists.linux.dev
X-Gm-Message-State: AOJu0Yxuasn5aGtgo+wn7lfLcFJ+vVx8ltC3Vuf9564CJrjCY1iAywAb
	0P/mSVkzc2wnKnc9smryhdXnw/GilU9XVJKGQVgq2KKJkRxLLEeUJs94E8N+j/urgZcd3T3iUy1
	Th1TOEQVyUAQPEvjP4zkM8MibGEf1M3w3eBZmUxgObmT4QbWlaNlzQWlWPKkH0Phb
X-Gm-Gg: ASbGncsuFPaWiIOUhp9lZyNX3gHpwj59OfB/b7SD/54OqwKId3H4t1C5dm6YjABoWVq
	nE5hMKKHDMu/RfVrTUmgmhIQCm9msfyeGU3VQQnCWgxS+h8XUmjDxRdM8xa/lJLPR0b3ZD2Cq/C
	Dv0nYU9blnfQvppvtNuxe0dQUxyftUsyei/Zq7I7iVEMN+q+rlO1jZJD5M1tup4vp7vcqpwFlFQ
	SIU7+/dSmYttMu9bJv/zCPSVJrUcixd83P6Fhc2IIi3uhjqfr0uBccBcIrXTcLZLNT1qaTWXe3L
	z0xZ2kks3MS8JKugJmYPtmBPM+r1FoZw
X-Received: by 2002:a05:600c:6052:b0:434:a815:2b5d with SMTP id 5b1f17b1804b1-4366312f8ddmr7561165e9.24.1734601886630;
        Thu, 19 Dec 2024 01:51:26 -0800 (PST)
X-Google-Smtp-Source: AGHT+IERzu7GX2RVHV0DfUliYnpSQHBfQ8/4vgaGnK4UtkY8+b8knYyGoI/073P1OJS/wlw0cQ7pDQ==
X-Received: by 2002:a05:600c:6052:b0:434:a815:2b5d with SMTP id 5b1f17b1804b1-4366312f8ddmr7560675e9.24.1734601885948;
        Thu, 19 Dec 2024 01:51:25 -0800 (PST)
Received: from sgarzare-redhat (host-87-12-185-21.business.telecomitalia.it. [87.12.185.21])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43661219578sm13274225e9.20.2024.12.19.01.51.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Dec 2024 01:51:25 -0800 (PST)
Date: Thu, 19 Dec 2024 10:51:21 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
To: Philipp Stanner <phasta@kernel.org>
Cc: Alvaro Karsz <alvaro.karsz@solid-run.com>, 
	"Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, 
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>, 
	Philipp Stanner <pstanner@redhat.com>, virtualization@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4] vdpa: solidrun: Replace deprecated PCI functions
Message-ID: <enuhuc7tjc5ez33c23lgzyy2nhiy54lykshlk5xurl4r6ilnsd@qnhrvku4xpxa>
References: <20241219094428.21511-2-phasta@kernel.org>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20241219094428.21511-2-phasta@kernel.org>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 2uWXO6_u_6XclhC8SK9bs4gObDgYzPguUAUJPlgwrjA_1734601887
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline

On Thu, Dec 19, 2024 at 10:44:29AM +0100, Philipp Stanner wrote:
>From: Philipp Stanner <pstanner@redhat.com>
>
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
>Changes in v4:
>  - snet_open_vf_bar(): use distinct temporary variable to ensure
>    snet->bar is never an ERR_PTR. (Stefano)

Thanks for that!

I don't have a device to test, but it LGTM:

Acked-by: Stefano Garzarella <sgarzare@redhat.com>


>
>Changes in v3:
>  - Move __iomem *io declaration into the loop. (Stefano)
>
>Changes in v2:
>  - Fix build warning because of dead variable.
>  - Make "bars_found" a boolean, since only true or false are relevant.
>---
> drivers/vdpa/solidrun/snet_main.c | 57 +++++++++++++++----------------
> 1 file changed, 28 insertions(+), 29 deletions(-)
>
>diff --git a/drivers/vdpa/solidrun/snet_main.c b/drivers/vdpa/solidrun/snet_main.c
>index c8b74980dbd1..55ec51c17ab3 100644
>--- a/drivers/vdpa/solidrun/snet_main.c
>+++ b/drivers/vdpa/solidrun/snet_main.c
>@@ -556,58 +556,60 @@ static const struct vdpa_config_ops snet_config_ops = {
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
>+	void __iomem *io;
>
> 	name = devm_kasprintf(&pdev->dev, GFP_KERNEL, "snet[%s]-bars", pci_name(pdev));
> 	if (!name)
> 		return -ENOMEM;
>
> 	/* Request and map BAR */
>-	ret = pcim_iomap_regions(pdev, BIT(snet->psnet->cfg.vf_bar), name);
>-	if (ret) {
>+	io = pcim_iomap_region(pdev, snet->psnet->cfg.vf_bar, name);
>+	if (IS_ERR(io)) {
> 		SNET_ERR(pdev, "Failed to request and map PCI BAR for a VF\n");
>-		return ret;
>+		return PTR_ERR(io);
> 	}
>
>-	snet->bar = pcim_iomap_table(pdev)[snet->psnet->cfg.vf_bar];
>+	snet->bar = io;
>
> 	return 0;
> }
>@@ -656,15 +658,12 @@ static int psnet_detect_bar(struct psnet *psnet, u32 off)
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
>

