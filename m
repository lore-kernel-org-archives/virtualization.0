Return-Path: <SRS0=i4sF=I4=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17E29C433DB
	for <virtualization@archiver.kernel.org>; Tue, 30 Mar 2021 12:40:20 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B7D26619A7
	for <virtualization@archiver.kernel.org>; Tue, 30 Mar 2021 12:40:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B7D26619A7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 8060C4045D;
	Tue, 30 Mar 2021 12:40:19 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id r7RZu2MNQzoR; Tue, 30 Mar 2021 12:40:18 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTP id C607D403AE;
	Tue, 30 Mar 2021 12:40:17 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 6802CC0013;
	Tue, 30 Mar 2021 12:40:17 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 7719BC000A;
 Tue, 30 Mar 2021 12:40:16 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 720AF83CE6;
 Tue, 30 Mar 2021 12:40:16 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=kernel.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id xBWbtpBUKI4S; Tue, 30 Mar 2021 12:40:15 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by smtp1.osuosl.org (Postfix) with ESMTPS id B667C83C59;
 Tue, 30 Mar 2021 12:40:15 +0000 (UTC)
Received: by mail.kernel.org (Postfix) with ESMTPSA id E982E60232;
 Tue, 30 Mar 2021 12:40:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1617108015;
 bh=IX2YifXUPutEwODCiJ5FkZ7svmqC2sPBx3924aa48Yg=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=nWgQteGwA5KJlS2JEm1DqLRTwpQa9MxXWOIN5GJCMFtjX0INuGG/yNdjsVWCFpiYJ
 oxPSJpF11duop8M2scavelMol6/AT8NTEQVpD99bNW9C8YnpWrW5SilD7uovqWEsBw
 9NXGPUDX+nSIkkaLAjXvH1N0TCwIw2ZKe5EClUtTpNYe36xPYxZpRn+GOishndd0RZ
 XkYFeNPS5aTR5cbmGiWYvlLf/h/vfoDZLBLAT/a/UKQp/8Kfhx8IIcqRyN0qW/Vx0V
 DJqO0c48Fq0jOR6T0u+2L2HLBIx3MQrqTW4L44QcFkRIAs0f/QJTlssAZuY9kevdw9
 EsfSKgPiTPvmQ==
Date: Tue, 30 Mar 2021 13:40:09 +0100
From: Will Deacon <will@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH 06/18] iommu/fsl_pamu: remove ->domain_window_enable
Message-ID: <20210330124009.GF5908@willie-the-truck>
References: <20210316153825.135976-1-hch@lst.de>
 <20210316153825.135976-7-hch@lst.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210316153825.135976-7-hch@lst.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: freedreno@lists.freedesktop.org, kvm@vger.kernel.org,
 Michael Ellerman <mpe@ellerman.id.au>, Joerg Roedel <joro@8bytes.org>,
 linuxppc-dev@lists.ozlabs.org, dri-devel@lists.freedesktop.org,
 Li Yang <leoyang.li@nxp.com>, iommu@lists.linux-foundation.org,
 netdev@vger.kernel.org, linux-arm-msm@vger.kernel.org,
 virtualization@lists.linux-foundation.org,
 David Woodhouse <dwmw2@infradead.org>, linux-arm-kernel@lists.infradead.org,
 Lu Baolu <baolu.lu@linux.intel.com>
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

On Tue, Mar 16, 2021 at 04:38:12PM +0100, Christoph Hellwig wrote:
> The only thing that fsl_pamu_window_enable does for the current caller
> is to fill in the prot value in the only dma_window structure, and to
> propagate a few values from the iommu_domain_geometry struture into the
> dma_window.  Remove the dma_window entirely, hardcode the prot value and
> otherwise use the iommu_domain_geometry structure instead.
> 
> Remove the now unused ->domain_window_enable iommu method.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> Acked-by: Li Yang <leoyang.li@nxp.com>
> ---
>  drivers/iommu/fsl_pamu_domain.c     | 182 +++-------------------------
>  drivers/iommu/fsl_pamu_domain.h     |  17 ---
>  drivers/iommu/iommu.c               |  11 --
>  drivers/soc/fsl/qbman/qman_portal.c |   7 --
>  include/linux/iommu.h               |  17 ---
>  5 files changed, 14 insertions(+), 220 deletions(-)
> 
> diff --git a/drivers/iommu/fsl_pamu_domain.c b/drivers/iommu/fsl_pamu_domain.c
> index e6bdd38fc18409..fd2bc88b690465 100644
> --- a/drivers/iommu/fsl_pamu_domain.c
> +++ b/drivers/iommu/fsl_pamu_domain.c
> @@ -54,34 +54,18 @@ static int __init iommu_init_mempool(void)
>  	return 0;
>  }
>  
> -static phys_addr_t get_phys_addr(struct fsl_dma_domain *dma_domain, dma_addr_t iova)
> -{
> -	struct dma_window *win_ptr = &dma_domain->win_arr[0];
> -	struct iommu_domain_geometry *geom;
> -
> -	geom = &dma_domain->iommu_domain.geometry;
> -
> -	if (win_ptr->valid)
> -		return win_ptr->paddr + (iova & (win_ptr->size - 1));
> -
> -	return 0;
> -}
> -
>  /* Map the DMA window corresponding to the LIODN */
>  static int map_liodn(int liodn, struct fsl_dma_domain *dma_domain)
>  {
>  	int ret;
> -	struct dma_window *wnd = &dma_domain->win_arr[0];
> -	phys_addr_t wnd_addr = dma_domain->iommu_domain.geometry.aperture_start;
> +	struct iommu_domain_geometry *geom = &dma_domain->iommu_domain.geometry;
>  	unsigned long flags;
>  
>  	spin_lock_irqsave(&iommu_lock, flags);
> -	ret = pamu_config_ppaace(liodn, wnd_addr,
> -				 wnd->size,
> -				 ~(u32)0,
> -				 wnd->paddr >> PAMU_PAGE_SHIFT,
> -				 dma_domain->snoop_id, dma_domain->stash_id,
> -				 wnd->prot);
> +	ret = pamu_config_ppaace(liodn, geom->aperture_start,
> +				 geom->aperture_end - 1, ~(u32)0,

You're passing 'geom->aperture_end - 1' as the size here, but the old code
seemed to _add_ 1:

> -static int fsl_pamu_window_enable(struct iommu_domain *domain, u32 wnd_nr,
> -				  phys_addr_t paddr, u64 size, int prot)
> -{
> -	struct fsl_dma_domain *dma_domain = to_fsl_dma_domain(domain);
> -	struct dma_window *wnd;
> -	int pamu_prot = 0;
> -	int ret;
> -	unsigned long flags;
> -	u64 win_size;
> -
> -	if (prot & IOMMU_READ)
> -		pamu_prot |= PAACE_AP_PERMS_QUERY;
> -	if (prot & IOMMU_WRITE)
> -		pamu_prot |= PAACE_AP_PERMS_UPDATE;
> -
> -	spin_lock_irqsave(&dma_domain->domain_lock, flags);
> -	if (wnd_nr > 0) {
> -		pr_debug("Invalid window index\n");
> -		spin_unlock_irqrestore(&dma_domain->domain_lock, flags);
> -		return -EINVAL;
> -	}
> -
> -	win_size = (domain->geometry.aperture_end + 1) >> ilog2(1);

here ^^ when calculating the exclusive upper bound. In other words, I think
'1ULL << 36' used to get passed to pamu_config_ppaace(). Is that an
intentional change?

Will
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
