Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03F1A31A576
	for <virtualization@lists.linux.dev>; Wed, 15 Oct 2025 09:49:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760521780; cv=none; b=JpBxhSYtNR/2L7IPbOZT/cr/ektwe5H+7s5H7AOjzxj72/r2+vW/5obVSNqcWzF5fVO/P1Si7Za6Wo1ghddFZzHb+VYO5NqTIoHBwyQGe9aJ5bxOolGFh3LQkmfz/fHWlTGOIBo0nyMBF5bjIq22sb/xsnBykg+fotve6Le3x1Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760521780; c=relaxed/simple;
	bh=rOB+qRevXdOABQxuhZUXOwovjJ/hzEyuKah+KBMrFEo=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=pn9GCjCYxmwTEYaYghzo5QI+qou/PsYiMJyfeDsck+333xM/5Gwv4aLnJwa6IGloyg9aL17pt1RLq6qsEU+aKfuitA0X7U290cY2jbkqazCtnef27EjeiilxnfFZwFizP1r6oA3hKkaTT7pj3J2O8Bz9H0ynRISy+qsVUKB92eA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=oU4pLowa; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="oU4pLowa"
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-47103b6058fso2864045e9.1
        for <virtualization@lists.linux.dev>; Wed, 15 Oct 2025 02:49:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1760521776; x=1761126576; darn=lists.linux.dev;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=3kHzW0c0d24RNbU3zu58pyXGEKLKg1AltmWjR3+66u0=;
        b=oU4pLowa6unOHCG84fh4s5l87jI0cdel8tAUPykkToQ4IAdADxNz7SsbtCRpgbiKiY
         kDWHFAFOJjMhn9wqFb8ogef0wG2IsKN/RC+kjtlE1t+jxXKV2XQ3fGxPZZRNam5rj5av
         R/J+6NzJHLfJJJBds6oyR5kXde8SYaODYhs81RxikGhkrSrWOgNjwwK9ySY/+GKJXU6/
         UlmIdd1CKayyDBOjXh/9wepG0yy6zqAEoQMltQLRi03vtiY6uwvNOMsaOQPWFlYfScng
         a4Qhs2EbYAOE16fYx/i5zA5QwPUiXJYy3f8sKl6tysobe0g6F30UOePpmnBJ3QceSyfK
         PbMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760521776; x=1761126576;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3kHzW0c0d24RNbU3zu58pyXGEKLKg1AltmWjR3+66u0=;
        b=G8KcWDp/8sCa+67g/0wqcLTZJyuoAwkdp8Ysmtm4KNifzV9x3Bob42AgdNjbzDmYny
         Nps9926nPHA7jTG6TmhbMG30xOT759zVLwpwzsDmN/AMoDF8rPS2E7+V5tyY7ZN2V5VM
         EIbAXe16NQSgg2zAklnDuYNPZYt0CzN/Bq6p4QL/KfoiuQfP3YroRTXcj8sYQQuZqGQD
         K6Bw/WB2vY19MfLZsADwGUX8Ot6cVGY9sTD2hKYNGsQ2ugHyv6yWIf4zEnDpic9EUld3
         KILCxRLIpwniHcrXqjTdomJCVAZFv8eliZy4NWsH1FcELCwcEtIUcp+KWzFrU0wOD+71
         ORQw==
X-Gm-Message-State: AOJu0Yy2cgilvRZZhiLTSmBwi6IWsXfTjYL03/k/NvusBSpZFKCVk4Pn
	Jzhl/N3LHy6nTBtWDZT46BAlijNLBCrH661PkDTZ3XOEkqBo5ocwxn0EU5HO4HzjWxg=
X-Gm-Gg: ASbGncstTolfw6+aw2pwDu81PHF+3bM3KAvdeJbQo4a2TDSb7cr0EmqnyTpVU1/WoCz
	S00+ENoVDypgluoojh5FiP762kCOoxB6HW1gSxLEwWdC58pL2ikAPmdZpZJNfvonhTCcaVzSRHV
	86bhPRVTU+YUVystTOKKfXIZfWLB+1dHyd3EI+vs1/nISsPIBaBv7v5xqVVLHyFmaErn0a8+ppr
	7HQV9mG4YjFcU7a/riz8HWTon3JzckbKY/KilWEZZxoMDTRaHTNmsvvBrx6GD3VuzZZ2MQ7Se3Q
	HYK5g1JrfiMpvvgfKilixeTLhwfBKfPTxYMlFgaecpPNtMNwrRC2LqD5fcuVC1PetIinX0wdbl6
	EB+jT+lirRMSq+nCuI/Md35Zj6Ref4poTG5EKq5krVPXinITYxIw=
X-Google-Smtp-Source: AGHT+IHIQW1xNRQMkuV2ACBVWBm0WvfNzUIixn9ZmPX2qDRVYUPYjHHqQnLdgDvfnaGFfgJuVv5O5A==
X-Received: by 2002:a05:600c:8b74:b0:46e:37d5:dbed with SMTP id 5b1f17b1804b1-46fa9ebd3edmr195291415e9.12.1760521776064;
        Wed, 15 Oct 2025 02:49:36 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-46fb55ac08dsm280689125e9.13.2025.10.15.02.49.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Oct 2025 02:49:35 -0700 (PDT)
Date: Wed, 15 Oct 2025 12:49:31 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Shijith Thotton <sthotton@marvell.com>
Cc: virtualization@lists.linux.dev
Subject: [bug report] vdpa/octeon_ep: enable support for multiple interrupts
 per device
Message-ID: <aO9uK3LmhajmbPfF@stanley.mountain>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hello Shijith Thotton,

Commit 26f8ce06af64 ("vdpa/octeon_ep: enable support for multiple
interrupts per device") from Jan 3, 2025 (linux-next), leads to the
following issue:

drivers/vdpa/octeon_ep/octep_vdpa_main.c:114:	ret = pci_alloc_irq_vectors(pdev, 1, oct_hw->nb_irqs, PCI_IRQ_MSIX);
This assumes that pci_alloc_irq_vectors() allocates the maximum.

drivers/vdpa/octeon_ep/octep_vdpa_main.c
    104 
    105 static int octep_request_irqs(struct octep_hw *oct_hw)
    106 {
    107         struct pci_dev *pdev = oct_hw->pdev;
    108         int ret, irq, idx;
    109 
    110         oct_hw->irqs = devm_kcalloc(&pdev->dev, oct_hw->nb_irqs, sizeof(int), GFP_KERNEL);
    111         if (!oct_hw->irqs)
    112                 return -ENOMEM;
    113 
--> 114         ret = pci_alloc_irq_vectors(pdev, 1, oct_hw->nb_irqs, PCI_IRQ_MSIX);
                ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
The pci_alloc_irq_vectors() takes a range between 1 and oct_hw->nb_irqs.
If it can't allocate the minimum (1) it will return a negative error
code, otherwise it will return a number between 1 and oct_hw->nb_irqs
inclusive.

    115         if (ret < 0) {
    116                 dev_err(&pdev->dev, "Failed to alloc msix vector");
    117                 return ret;
    118         }
    119 
    120         for (idx = 0; idx < oct_hw->nb_irqs; idx++) {
                                    ^^^^^^^^^^^^^^^
This should be "ret".  We can't assume it allocated all the irq
vectors.

    121                 irq = pci_irq_vector(pdev, idx);
    122                 ret = devm_request_irq(&pdev->dev, irq, octep_vdpa_intr_handler, 0,
    123                                        dev_name(&pdev->dev), oct_hw);
    124                 if (ret) {

regards,
dan carpenter
