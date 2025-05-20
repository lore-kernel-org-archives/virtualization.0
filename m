Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 104FC25F984;
	Tue, 20 May 2025 22:42:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747780946; cv=none; b=egWiFMeezupkYlEpXMAEE3woWMc7vZdI77AOlQIhcY3tQenzMX/8O+BCOQXGdy0reY3uah1RmynrechfQWRrkZ4kNjoQYKz8ImP7bO3CWZz1Ch8XD8TaAcShZ0xso3wzi9gqSHgdrCDGU6vaOgmKQcGbgpn6nvi8phIjgZL0FzE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747780946; c=relaxed/simple;
	bh=LEmHzMGZMeWbHV95axfvamFFe4GU6DbF7lodqwp38Jk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jNm/JiBolc5BvNEQyKy2GDupDj0XgKYoAz8srJa9neBObpbQbRp/BW8xp1mkV3u3ZKflb/BwSYQfcljcVOtzpUe50pfV+7WksuGnO0GVdUGiLcNZ50DfauHndyn1IJ5s5hfAJGdJm+KQF0xGks0i9Jm1Dc8Wx8TsrCamZW5jqtQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=bvUGCBR4; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="bvUGCBR4"
Received: by linux.microsoft.com (Postfix, from userid 1152)
	id 9616F2067864; Tue, 20 May 2025 15:42:24 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 9616F2067864
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1747780944;
	bh=DlpgK8+tZkkDHiRWgBwHzi2Y0cqlH2RIldw1jLBTIb4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=bvUGCBR4iqg/M7Vg3HP94282EcXsXC5noJNb1o/uDAj1lfvSmUtR3/enibqZKqGml
	 IvzwXSS/YTm9/i/m4JJRERdIp388+J5wxgwzStIpmjQ4uI+6mrY/MlL8XjdktFOfqI
	 o3HYFu1SfU5/WDFlksRh6wBlNWwZk7zhBZ5f0IOI=
Date: Tue, 20 May 2025 15:42:24 -0700
From: Shyam Saini <shyamsaini@linux.microsoft.com>
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: Jacob Pan <jacob.pan@linux.microsoft.com>, iommu@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
	virtualization@lists.linux.dev, will@kernel.org,
	eric.auger@redhat.com, code@tyhicks.com,
	eahariha@linux.microsoft.com, vijayb@linux.microsoft.com
Subject: Re: [PATCH v2 0/3] arm-smmu: select suitable IOVA
Message-ID: <20250520224224.GA16365@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
References: <20250410225030.2528385-1-shyamsaini@linux.microsoft.com>
 <20250410230008.GA6905@ziepe.ca>
 <67fff12d.650a0220.208c7c.d69dSMTPIN_ADDED_BROKEN@mx.google.com>
 <20250416181759.GF493866@ziepe.ca>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250416181759.GF493866@ziepe.ca>
User-Agent: Mutt/1.5.21 (2010-09-15)

Hi Jason,

apologies for the delayed response.

> On Wed, Apr 16, 2025 at 11:04:27AM -0700, Jacob Pan wrote:
> 
> > Per last discussion "SMMU driver have a list of potential addresses and
> > select the first one that does not intersect with the non-working IOVA
> > ranges.". If we don't know what the "non-working IOVA" is, how do we
> > know it does not intersect the "potential addresses"?
> 
> I had understood from previous discussions that this platform is
> properly creating IOMMU_RESV_RESERVED regions for the IOVA that
> doesn't work. Otherwise everything is broken..
> 
> Presumably that happens through iommu_dma_get_resv_regions() calling
> of_iommu_get_resv_regions() on a DT platform. There is a schema
> describing how to do this, so platform firmware should be able to do it..
> 
> So the fix seems trivial enough to me:
> 
> diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> index b4c21aaed1266a..ebba18579151bc 100644
> --- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> +++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> @@ -3562,17 +3562,29 @@ static int arm_smmu_of_xlate(struct device *dev,
>  static void arm_smmu_get_resv_regions(struct device *dev,
>  				      struct list_head *head)
>  {
> -	struct iommu_resv_region *region;
> -	int prot = IOMMU_WRITE | IOMMU_NOEXEC | IOMMU_MMIO;
> -
> -	region = iommu_alloc_resv_region(MSI_IOVA_BASE, MSI_IOVA_LENGTH,
> -					 prot, IOMMU_RESV_SW_MSI, GFP_KERNEL);
> -	if (!region)
> -		return;
> -
> -	list_add_tail(&region->list, head);
> +	static const u64 msi_bases[] = { MSI_IOVA_BASE, 0x12340000 };
>  
>  	iommu_dma_get_resv_regions(dev, head);

my understand is, this hook is not called for all the devices, eg: pcie dts node
doesn't use [1] "iommus" property instead it uses "iommu-map" property
as a consequence, [1] while loop exits prematurely and iommu_dma_get_resv_regions()
is not called, so there is no IOVA reservation for the pcie device. 

Did i miss something? Please let me know.

[1] https://elixir.bootlin.com/linux/v6.15-rc7/source/drivers/of/device.c#L161

Thanks,
Shyam
