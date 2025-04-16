Received: from mail-qk1-f175.google.com (mail-qk1-f175.google.com [209.85.222.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C22F183CB0
	for <virtualization@lists.linux.dev>; Wed, 16 Apr 2025 18:18:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744827484; cv=none; b=Z75d8YcaVNyB5wYG1EU5nPjvdeKfv4ToUIeSN8vTv/gVI/vCbjexx9C6wViBakEq52CWkc9NwmXMxNw7xhhN3Xh/hwUeY+5O0l9LnegSegqbq58I1cd8vetodrQ89K6wDiVp6htlmD2DHo7ke6wfStMwpyBvz0z96PKlbKoTWAk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744827484; c=relaxed/simple;
	bh=3DKkQU9Mom2lVRMeCwp0ivdrDyuKM3G5b3qIYQX+qDU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pHy+IF1z2ADH4pgKMUD2KHC5yAvpQ7a/50ldAqJcxZsScXLzVRB1cwIGo742R3VUl45xMrTq/z1CSm1QZxcVlXEnxk0tSDeiHXO0GFSNHetzmOIw30ouec/o37cnz8h/WeVhLxDFwORswv1ZG7QgpkoCgYPeU/ai7sBWrYU4+r8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=FKew2855; arc=none smtp.client-ip=209.85.222.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="FKew2855"
Received: by mail-qk1-f175.google.com with SMTP id af79cd13be357-7be49f6b331so761638185a.1
        for <virtualization@lists.linux.dev>; Wed, 16 Apr 2025 11:18:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1744827481; x=1745432281; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=nhIqXs3b02Zr9EkAcj7RO68Dtso22D3FSSNBcsVaNJc=;
        b=FKew2855kGiptUw/gIx6igJ0x3HjIdjdc/lSs8/St+CzAO0TbS4xGbcsiRTsVCWWhe
         CxDUtgPBKKoOBiUFeywViJTz/n2FYbU68xwJ4Li5e8OdlDgJMtxE8fzqfEzkeLJnaNW8
         PsGN3ESs3rNYq8Wnklo6Av0x9okhCvW3ofJz/kOqy3kF6TJr0D8JzHNYVpzIlQ5sTXt+
         N8qCQavBh/mOxrrn88BsSNJD0NcKyC4J8KtkAxtVKGDMHfQscA1LFC0YEiXRESg/D7+K
         JcRtmRbw1KfJCoZr6JcToG822RiW7UdDogoAW6BoMqRgl9a3KhTBaPJR6BgrGsPmCmfE
         9+Gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744827481; x=1745432281;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nhIqXs3b02Zr9EkAcj7RO68Dtso22D3FSSNBcsVaNJc=;
        b=vKUyQ1rQKwt7wTzuc+DMNtiXFqxx7WB+DwPd3DwUcykr/Nqz7mn9JDxcYqHTPtio/Y
         Iwtyl3JDxVGUhCiQonq4mdp5Kp1mMit2aw4a7SZ4knWrDgmZskisQtdGkr5xEcY9vQHV
         Qj+v+3OcXyXEVP7Pqn2vIdTCH81kmz4iP7zfBYKYjoh2N0tZnKfyouXyQa8Gch9D7WLO
         oUwuN8WX9JeB1Ad2WT8X+4EpcvDPPqhErBkyiqcIC4FNxC++HiaDnkf6sNP3bLwTWbC8
         RJsvY/KDSTS32lw/k+h9Jfs7z0exNItyainV8uA6tnWgqjT2PUFChHgyE8hx3ZvlWK2/
         BGsA==
X-Forwarded-Encrypted: i=1; AJvYcCVQ/be+0GxD+xJg8eye9RbJvTdildD36/9HG7UhEhZIelyDMzGIkjfmTdAJ9asTUB0eooVT2LgLXvXofzbWzA==@lists.linux.dev
X-Gm-Message-State: AOJu0Yy7EYz5xujWqFvNx3FMg6wthFo8ZMZQ9cApX1f4udquMIqwzFM1
	kBbKiRhvrlhnpX0bFm9IsZXMOcYZV+YXlDWT7Hv8JImi0sNNAXLWJVnrvlba0jiTV8Xqzxp6Ccr
	I
X-Gm-Gg: ASbGncv6iZlkLghDif+wrxsRI5ERfEeMAIMI/OkPKtFieQY+fAlZfFWT+58ENeNbahQ
	3haXT2CKntxSwxgVELlSB5XXseEJj2XNd6EViqfEvRmzKrVYuL9BOJKrFtmVDVAhlTF2ZXGFreZ
	2X28f5tstJS2VX7DHGraP5pfMc4ZSBaXKrNtsSM53diiwB+Ts5L0Q2kXnQ3n4dA7o1b4uxYqucP
	apsB4+TQJvJuNqqW5uZrzMHyx5bsg09UR++qXySQv6Uj2xZnBdE6vbUhVJBVTTIhUygIl3Qemqc
	Uxd1Ni81l1EXQJqggE04URQFsjTDzvn0AI/x+6C1JX5U3q/oHV0jNJURUbnbnVZNexHOT+ScYxP
	CBAVYqNHre4Z0DouOnAg=
X-Google-Smtp-Source: AGHT+IHO7Bqf4Fmw+LiZOuVSnpTOMSKYZPCbuJqFFE5vxmLzphTTuPO4Jd1IQCZQaz4uW5OwoW3Ysw==
X-Received: by 2002:a05:620a:171e:b0:7c5:af73:4f72 with SMTP id af79cd13be357-7c919064377mr376498885a.42.1744827481008;
        Wed, 16 Apr 2025 11:18:01 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-167-219-86.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.167.219.86])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7c7a8a0de1esm1088777885a.103.2025.04.16.11.17.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Apr 2025 11:17:59 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1u57Kh-00000004wJB-0tjv;
	Wed, 16 Apr 2025 15:17:59 -0300
Date: Wed, 16 Apr 2025 15:17:59 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Jacob Pan <jacob.pan@linux.microsoft.com>
Cc: Shyam Saini <shyamsaini@linux.microsoft.com>, iommu@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
	virtualization@lists.linux.dev, will@kernel.org,
	eric.auger@redhat.com, code@tyhicks.com,
	eahariha@linux.microsoft.com, vijayb@linux.microsoft.com
Subject: Re: [PATCH v2 0/3] arm-smmu: select suitable IOVA
Message-ID: <20250416181759.GF493866@ziepe.ca>
References: <20250410225030.2528385-1-shyamsaini@linux.microsoft.com>
 <20250410230008.GA6905@ziepe.ca>
 <67fff12d.650a0220.208c7c.d69dSMTPIN_ADDED_BROKEN@mx.google.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <67fff12d.650a0220.208c7c.d69dSMTPIN_ADDED_BROKEN@mx.google.com>

On Wed, Apr 16, 2025 at 11:04:27AM -0700, Jacob Pan wrote:

> Per last discussion "SMMU driver have a list of potential addresses and
> select the first one that does not intersect with the non-working IOVA
> ranges.". If we don't know what the "non-working IOVA" is, how do we
> know it does not intersect the "potential addresses"?

I had understood from previous discussions that this platform is
properly creating IOMMU_RESV_RESERVED regions for the IOVA that
doesn't work. Otherwise everything is broken..

Presumably that happens through iommu_dma_get_resv_regions() calling
of_iommu_get_resv_regions() on a DT platform. There is a schema
describing how to do this, so platform firmware should be able to do it..

So the fix seems trivial enough to me:

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
index b4c21aaed1266a..ebba18579151bc 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -3562,17 +3562,29 @@ static int arm_smmu_of_xlate(struct device *dev,
 static void arm_smmu_get_resv_regions(struct device *dev,
 				      struct list_head *head)
 {
-	struct iommu_resv_region *region;
-	int prot = IOMMU_WRITE | IOMMU_NOEXEC | IOMMU_MMIO;
-
-	region = iommu_alloc_resv_region(MSI_IOVA_BASE, MSI_IOVA_LENGTH,
-					 prot, IOMMU_RESV_SW_MSI, GFP_KERNEL);
-	if (!region)
-		return;
-
-	list_add_tail(&region->list, head);
+	static const u64 msi_bases[] = { MSI_IOVA_BASE, 0x12340000 };
 
 	iommu_dma_get_resv_regions(dev, head);
+
+	/*
+	 * Use the first msi_base that does not intersect with a platform
+	 * reserved region. The SW MSI base selection is entirely arbitary.
+	 */
+	for (i = 0; i != ARRAY_SIZE(msi_bases); i++) {
+		struct iommu_resv_region *region;
+
+		if (resv_intersects(msi_bases[i], MSI_IOVA_LENGTH))
+			continue;
+
+		region = iommu_alloc_resv_region(msi_bases[i], MSI_IOVA_LENGTH,
+						 IOMMU_WRITE | IOMMU_NOEXEC |
+							 IOMMU_MMIO,
+						 IOMMU_RESV_SW_MSI, GFP_KERNEL);
+		if (!region)
+			return;
+		list_add_tail(&region->list, head);
+		return;
+	}
 }
 
 static int arm_smmu_dev_enable_feature(struct device *dev,

Jason
