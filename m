Return-Path: <SRS0=F8NL=MB=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF788C07E9B
	for <virtualization@archiver.kernel.org>; Fri,  9 Jul 2021 12:56:56 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7600C613B5
	for <virtualization@archiver.kernel.org>; Fri,  9 Jul 2021 12:56:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7600C613B5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 5D7A442397;
	Fri,  9 Jul 2021 12:56:55 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id U4lkb3UG6jYm; Fri,  9 Jul 2021 12:56:54 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id AACA442384;
	Fri,  9 Jul 2021 12:56:53 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 385A8C0023;
	Fri,  9 Jul 2021 12:56:53 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id EA39EC000E;
 Fri,  9 Jul 2021 12:56:51 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id C520F60774;
 Fri,  9 Jul 2021 12:56:51 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id KhkLGdWTw4Zq; Fri,  9 Jul 2021 12:56:51 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by smtp3.osuosl.org (Postfix) with ESMTP id C91B360731;
 Fri,  9 Jul 2021 12:56:50 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 31DFFED1;
 Fri,  9 Jul 2021 05:56:50 -0700 (PDT)
Received: from [10.57.35.192] (unknown [10.57.35.192])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 258A53F66F;
 Fri,  9 Jul 2021 05:56:48 -0700 (PDT)
Subject: Re: [RFC v1 3/8] intel/vt-d: make DMAR table parsing code more
 flexible
To: Wei Liu <wei.liu@kernel.org>,
 Linux on Hyper-V List <linux-hyperv@vger.kernel.org>
References: <20210709114339.3467637-1-wei.liu@kernel.org>
 <20210709114339.3467637-4-wei.liu@kernel.org>
From: Robin Murphy <robin.murphy@arm.com>
Message-ID: <e1dcc315-4ebb-661e-4289-d176b3db39b5@arm.com>
Date: Fri, 9 Jul 2021 13:56:46 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210709114339.3467637-4-wei.liu@kernel.org>
Content-Language: en-GB
Cc: Jean-Philippe Brucker <jean-philippe@linaro.org>, pasha.tatashin@soleen.com,
 kumarpraveen@linux.microsoft.com, Will Deacon <will@kernel.org>,
 Linux Kernel List <linux-kernel@vger.kernel.org>,
 Michael Kelley <mikelley@microsoft.com>,
 "open list:INTEL IOMMU VT-d" <iommu@lists.linux-foundation.org>,
 Nuno Das Neves <nunodasneves@linux.microsoft.com>,
 Sunil Muthuswamy <sunilmut@microsoft.com>,
 virtualization@lists.linux-foundation.org,
 David Woodhouse <dwmw2@infradead.org>,
 Vineeth Pillai <viremana@linux.microsoft.com>
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

On 2021-07-09 12:43, Wei Liu wrote:
> Microsoft Hypervisor provides a set of hypercalls to manage device
> domains. The root kernel should parse the DMAR so that it can program
> the IOMMU (with hypercalls) correctly.
> 
> The DMAR code was designed to work with Intel IOMMU only. Add two more
> parameters to make it useful to Microsoft Hypervisor. Microsoft
> Hypervisor does not need the DMAR parsing code to allocate an Intel
> IOMMU structure; it also wishes to always reparse the DMAR table even
> after it has been parsed before.

We've recently defined the VIOT table for describing paravirtualised 
IOMMUs - would it make more sense to extend that to support the 
Microsoft implementation than to abuse a hardware-specific table? Am I 
right in assuming said hypervisor isn't intended to only ever run on 
Intel hardware?

Robin.

> Adjust Intel IOMMU code to use the new dmar_table_init. There should be
> no functional change to Intel IOMMU code.
> 
> Signed-off-by: Wei Liu <wei.liu@kernel.org>
> ---
> We may be able to combine alloc and force_parse?
> ---
>   drivers/iommu/intel/dmar.c          | 38 ++++++++++++++++++++---------
>   drivers/iommu/intel/iommu.c         |  2 +-
>   drivers/iommu/intel/irq_remapping.c |  2 +-
>   include/linux/dmar.h                |  2 +-
>   4 files changed, 30 insertions(+), 14 deletions(-)
> 
> diff --git a/drivers/iommu/intel/dmar.c b/drivers/iommu/intel/dmar.c
> index 84057cb9596c..bd72f47c728b 100644
> --- a/drivers/iommu/intel/dmar.c
> +++ b/drivers/iommu/intel/dmar.c
> @@ -408,7 +408,8 @@ dmar_find_dmaru(struct acpi_dmar_hardware_unit *drhd)
>    * structure which uniquely represent one DMA remapping hardware unit
>    * present in the platform
>    */
> -static int dmar_parse_one_drhd(struct acpi_dmar_header *header, void *arg)
> +static int dmar_parse_one_drhd_internal(struct acpi_dmar_header *header,
> +		void *arg, bool alloc)
>   {
>   	struct acpi_dmar_hardware_unit *drhd;
>   	struct dmar_drhd_unit *dmaru;
> @@ -440,12 +441,14 @@ static int dmar_parse_one_drhd(struct acpi_dmar_header *header, void *arg)
>   		return -ENOMEM;
>   	}
>   
> -	ret = alloc_iommu(dmaru);
> -	if (ret) {
> -		dmar_free_dev_scope(&dmaru->devices,
> -				    &dmaru->devices_cnt);
> -		kfree(dmaru);
> -		return ret;
> +	if (alloc) {
> +		ret = alloc_iommu(dmaru);
> +		if (ret) {
> +			dmar_free_dev_scope(&dmaru->devices,
> +					    &dmaru->devices_cnt);
> +			kfree(dmaru);
> +			return ret;
> +		}
>   	}
>   	dmar_register_drhd_unit(dmaru);
>   
> @@ -456,6 +459,16 @@ static int dmar_parse_one_drhd(struct acpi_dmar_header *header, void *arg)
>   	return 0;
>   }
>   
> +static int dmar_parse_one_drhd(struct acpi_dmar_header *header, void *arg)
> +{
> +	return dmar_parse_one_drhd_internal(header, arg, true);
> +}
> +
> +int dmar_parse_one_drhd_noalloc(struct acpi_dmar_header *header, void *arg)
> +{
> +	return dmar_parse_one_drhd_internal(header, arg, false);
> +}
> +
>   static void dmar_free_drhd(struct dmar_drhd_unit *dmaru)
>   {
>   	if (dmaru->devices && dmaru->devices_cnt)
> @@ -633,7 +646,7 @@ static inline int dmar_walk_dmar_table(struct acpi_table_dmar *dmar,
>    * parse_dmar_table - parses the DMA reporting table
>    */
>   static int __init
> -parse_dmar_table(void)
> +parse_dmar_table(bool alloc)
>   {
>   	struct acpi_table_dmar *dmar;
>   	int drhd_count = 0;
> @@ -650,6 +663,9 @@ parse_dmar_table(void)
>   		.cb[ACPI_DMAR_TYPE_SATC] = &dmar_parse_one_satc,
>   	};
>   
> +	if (!alloc)
> +		cb.cb[ACPI_DMAR_TYPE_HARDWARE_UNIT] = &dmar_parse_one_drhd_noalloc;
> +
>   	/*
>   	 * Do it again, earlier dmar_tbl mapping could be mapped with
>   	 * fixed map.
> @@ -840,13 +856,13 @@ void __init dmar_register_bus_notifier(void)
>   }
>   
>   
> -int __init dmar_table_init(void)
> +int __init dmar_table_init(bool alloc, bool force_parse)
>   {
>   	static int dmar_table_initialized;
>   	int ret;
>   
> -	if (dmar_table_initialized == 0) {
> -		ret = parse_dmar_table();
> +	if (dmar_table_initialized == 0 || force_parse) {
> +		ret = parse_dmar_table(alloc);
>   		if (ret < 0) {
>   			if (ret != -ENODEV)
>   				pr_info("Parse DMAR table failure.\n");
> diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
> index be35284a2016..a4294d310b93 100644
> --- a/drivers/iommu/intel/iommu.c
> +++ b/drivers/iommu/intel/iommu.c
> @@ -4310,7 +4310,7 @@ int __init intel_iommu_init(void)
>   	}
>   
>   	down_write(&dmar_global_lock);
> -	if (dmar_table_init()) {
> +	if (dmar_table_init(true, false)) {
>   		if (force_on)
>   			panic("tboot: Failed to initialize DMAR table\n");
>   		goto out_free_dmar;
> diff --git a/drivers/iommu/intel/irq_remapping.c b/drivers/iommu/intel/irq_remapping.c
> index f912fe45bea2..0e8abef862e4 100644
> --- a/drivers/iommu/intel/irq_remapping.c
> +++ b/drivers/iommu/intel/irq_remapping.c
> @@ -732,7 +732,7 @@ static int __init intel_prepare_irq_remapping(void)
>   		return -ENODEV;
>   	}
>   
> -	if (dmar_table_init() < 0)
> +	if (dmar_table_init(true, false) < 0)
>   		return -ENODEV;
>   
>   	if (intel_cap_audit(CAP_AUDIT_STATIC_IRQR, NULL))
> diff --git a/include/linux/dmar.h b/include/linux/dmar.h
> index e04436a7ff27..f88535d41a6e 100644
> --- a/include/linux/dmar.h
> +++ b/include/linux/dmar.h
> @@ -106,7 +106,7 @@ static inline bool dmar_rcu_check(void)
>   	for_each_dev_scope((devs), (cnt), (i), (tmp))			\
>   		if (!(tmp)) { continue; } else
>   
> -extern int dmar_table_init(void);
> +extern int dmar_table_init(bool alloc, bool force_parse);
>   extern int dmar_dev_scope_init(void);
>   extern void dmar_register_bus_notifier(void);
>   extern int dmar_parse_dev_scope(void *start, void *end, int *cnt,
> 
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
