Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3FB47CCA484
	for <virtualization@archiver.kernel.org>; Mon,  6 Jun 2022 17:50:52 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id C49DF416FF;
	Mon,  6 Jun 2022 17:50:51 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id v4C_TuLAaByn; Mon,  6 Jun 2022 17:50:50 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id E5049416FA;
	Mon,  6 Jun 2022 17:50:49 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 59B47C007F;
	Mon,  6 Jun 2022 17:50:49 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 2C63DC002D;
 Mon,  6 Jun 2022 17:50:48 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 19D2D402BC;
 Mon,  6 Jun 2022 17:50:48 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id c_qov0A16DbW; Mon,  6 Jun 2022 17:50:47 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by smtp2.osuosl.org (Postfix) with ESMTP id DC3A440220;
 Mon,  6 Jun 2022 17:50:46 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8FE65165C;
 Mon,  6 Jun 2022 10:50:45 -0700 (PDT)
Received: from [10.57.81.38] (unknown [10.57.81.38])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 344483F66F;
 Mon,  6 Jun 2022 10:50:38 -0700 (PDT)
Message-ID: <6575de6d-94ba-c427-5b1e-967750ddff23@arm.com>
Date: Mon, 6 Jun 2022 18:50:33 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH 2/5] iommu: Ensure device has the same iommu_ops as the
 domain
Content-Language: en-GB
To: Nicolin Chen <nicolinc@nvidia.com>
References: <20220606061927.26049-1-nicolinc@nvidia.com>
 <20220606061927.26049-3-nicolinc@nvidia.com>
 <1e0e5403-1e65-db9a-c8e7-34e316bfda8e@arm.com>
 <Yp4wiJZWxoCLY8tm@Asurada-Nvidia>
From: Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <Yp4wiJZWxoCLY8tm@Asurada-Nvidia>
Cc: cohuck@redhat.com, heiko@sntech.de, mjrosato@linux.ibm.com,
 bjorn.andersson@linaro.org, linux-tegra@vger.kernel.org,
 thierry.reding@gmail.com, alim.akhtar@samsung.com, will@kernel.org,
 alyssa@rosenzweig.io, m.szyprowski@samsung.com, jean-philippe@linaro.org,
 linux-samsung-soc@vger.kernel.org, kvm@vger.kernel.org, samuel@sholland.org,
 zhang.lyra@gmail.com, joro@8bytes.org, robdclark@gmail.com,
 jernej.skrabec@gmail.com, jonathanh@nvidia.com,
 linux-rockchip@lists.infradead.org, wens@csie.org, agross@kernel.org,
 linux-arm-kernel@lists.infradead.org, jgg@nvidia.com, orsonzhai@gmail.com,
 gerald.schaefer@linux.ibm.com, linux-sunxi@lists.linux.dev, sven@svenpeter.dev,
 linux-arm-msm@vger.kernel.org, iommu@lists.linux-foundation.org,
 linux-mediatek@lists.infradead.org, matthias.bgg@gmail.com,
 virtualization@lists.linux-foundation.org, yong.wu@mediatek.com,
 linux-s390@vger.kernel.org, marcan@marcan.st, vdumpa@nvidia.com,
 linux-kernel@vger.kernel.org, krzysztof.kozlowski@linaro.org,
 suravee.suthikulpanit@amd.com, baolin.wang7@gmail.com, dwmw2@infradead.org,
 baolu.lu@linux.intel.com
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

On 2022-06-06 17:51, Nicolin Chen wrote:
> Hi Robin,
> 
> On Mon, Jun 06, 2022 at 03:33:42PM +0100, Robin Murphy wrote:
>> On 2022-06-06 07:19, Nicolin Chen wrote:
>>> The core code should not call an iommu driver op with a struct device
>>> parameter unless it knows that the dev_iommu_priv_get() for that struct
>>> device was setup by the same driver. Otherwise in a mixed driver system
>>> the iommu_priv could be casted to the wrong type.
>>
>> We don't have mixed-driver systems, and there are plenty more
>> significant problems than this one to solve before we can (but thanks
>> for pointing it out - I hadn't got as far as auditing the public
>> interfaces yet). Once domains are allocated via a particular device's
>> IOMMU instance in the first place, there will be ample opportunity for
>> the core to stash suitable identifying information in the domain for
>> itself. TBH even the current code could do it without needing the
>> weirdly invasive changes here.
> 
> Do you have an alternative and less invasive solution in mind?
> 
>>> Store the iommu_ops pointer in the iommu_domain and use it as a check to
>>> validate that the struct device is correct before invoking any domain op
>>> that accepts a struct device.
>>
>> In fact this even describes exactly that - "Store the iommu_ops pointer
>> in the iommu_domain", vs. the "Store the iommu_ops pointer in the
>> iommu_domain_ops" which the patch is actually doing :/
> 
> Will fix that.

Well, as before I'd prefer to make the code match the commit message - 
if I really need to spell it out, see below - since I can't imagine that 
we should ever have need to identify a set of iommu_domain_ops in 
isolation, therefore I think it's considerably clearer to use the 
iommu_domain itself. However, either way we really don't need this yet, 
so we may as well just go ahead and remove the redundant test from VFIO 
anyway, and I can add some form of this patch to my dev branch for now.

Thanks,
Robin.

----->8-----
diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index cde2e1d6ab9b..72990edc9314 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -1902,6 +1902,7 @@ static struct iommu_domain 
*__iommu_domain_alloc(struct device *dev,
  	domain->type = type;
  	/* Assume all sizes by default; the driver may override this later */
  	domain->pgsize_bitmap = ops->pgsize_bitmap;
+	domain->owner = ops;
  	if (!domain->ops)
  		domain->ops = ops->default_domain_ops;

diff --git a/include/linux/iommu.h b/include/linux/iommu.h
index 6f64cbbc6721..79e557207f53 100644
--- a/include/linux/iommu.h
+++ b/include/linux/iommu.h
@@ -89,6 +89,7 @@ struct iommu_domain_geometry {

  struct iommu_domain {
  	unsigned type;
+	const struct iommu_ops *owner; /* Who allocated this domain */
  	const struct iommu_domain_ops *ops;
  	unsigned long pgsize_bitmap;	/* Bitmap of page sizes in use */
  	iommu_fault_handler_t handler;
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
