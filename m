Return-Path: <SRS0=F8NL=MB=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89972C07E99
	for <virtualization@archiver.kernel.org>; Fri,  9 Jul 2021 12:46:32 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3F76F613B0
	for <virtualization@archiver.kernel.org>; Fri,  9 Jul 2021 12:46:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3F76F613B0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id E696983640;
	Fri,  9 Jul 2021 12:46:31 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 0WfDrJSY6hF2; Fri,  9 Jul 2021 12:46:31 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 729CE82A0E;
	Fri,  9 Jul 2021 12:46:30 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 4AECAC0010;
	Fri,  9 Jul 2021 12:46:30 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id D3D92C000E;
 Fri,  9 Jul 2021 12:46:28 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id B377542378;
 Fri,  9 Jul 2021 12:46:28 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id b-_O7vyUOskr; Fri,  9 Jul 2021 12:46:27 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by smtp4.osuosl.org (Postfix) with ESMTP id A71D9422A1;
 Fri,  9 Jul 2021 12:46:27 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E6C9FED1;
 Fri,  9 Jul 2021 05:46:26 -0700 (PDT)
Received: from [10.57.35.192] (unknown [10.57.35.192])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 8C00C3F66F;
 Fri,  9 Jul 2021 05:46:24 -0700 (PDT)
Subject: Re: [RFC v1 6/8] mshv: command line option to skip devices in PV-IOMMU
To: Wei Liu <wei.liu@kernel.org>,
 Linux on Hyper-V List <linux-hyperv@vger.kernel.org>
References: <20210709114339.3467637-1-wei.liu@kernel.org>
 <20210709114339.3467637-7-wei.liu@kernel.org>
From: Robin Murphy <robin.murphy@arm.com>
Message-ID: <1c839a00-0f5f-fdfa-cfb3-f345bef9f849@arm.com>
Date: Fri, 9 Jul 2021 13:46:19 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210709114339.3467637-7-wei.liu@kernel.org>
Content-Language: en-GB
Cc: Stephen Hemminger <sthemmin@microsoft.com>, pasha.tatashin@soleen.com,
 kumarpraveen@linux.microsoft.com,
 Vineeth Pillai <viremana@linux.microsoft.com>,
 Haiyang Zhang <haiyangz@microsoft.com>, Dexuan Cui <decui@microsoft.com>,
 Linux Kernel List <linux-kernel@vger.kernel.org>,
 Michael Kelley <mikelley@microsoft.com>,
 "open list:IOMMU DRIVERS" <iommu@lists.linux-foundation.org>,
 Nuno Das Neves <nunodasneves@linux.microsoft.com>,
 Sunil Muthuswamy <sunilmut@microsoft.com>, Will Deacon <will@kernel.org>,
 virtualization@lists.linux-foundation.org
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
> Some devices may have been claimed by the hypervisor already. One such
> example is a user can assign a NIC for debugging purpose.
> 
> Ideally Linux should be able to tell retrieve that information, but
> there is no way to do that yet. And designing that new mechanism is
> going to take time.
> 
> Provide a command line option for skipping devices. This is a stopgap
> solution, so it is intentionally undocumented. Hopefully we can retire
> it in the future.

Huh? If the host is using a device, why the heck is it exposing any 
knowledge of that device to the guest at all, let alone allowing the 
guest to do anything that could affect its operation!?

Robin.

> Signed-off-by: Wei Liu <wei.liu@kernel.org>
> ---
>   drivers/iommu/hyperv-iommu.c | 45 ++++++++++++++++++++++++++++++++++++
>   1 file changed, 45 insertions(+)
> 
> diff --git a/drivers/iommu/hyperv-iommu.c b/drivers/iommu/hyperv-iommu.c
> index 043dcff06511..353da5036387 100644
> --- a/drivers/iommu/hyperv-iommu.c
> +++ b/drivers/iommu/hyperv-iommu.c
> @@ -349,6 +349,16 @@ static const struct irq_domain_ops hyperv_root_ir_domain_ops = {
>   
>   #ifdef CONFIG_HYPERV_ROOT_PVIOMMU
>   
> +/* The IOMMU will not claim these PCI devices. */
> +static char *pci_devs_to_skip;
> +static int __init mshv_iommu_setup_skip(char *str) {
> +	pci_devs_to_skip = str;
> +
> +	return 0;
> +}
> +/* mshv_iommu_skip=(SSSS:BB:DD.F)(SSSS:BB:DD.F) */
> +__setup("mshv_iommu_skip=", mshv_iommu_setup_skip);
> +
>   /* DMA remapping support */
>   struct hv_iommu_domain {
>   	struct iommu_domain domain;
> @@ -774,6 +784,41 @@ static struct iommu_device *hv_iommu_probe_device(struct device *dev)
>   	if (!dev_is_pci(dev))
>   		return ERR_PTR(-ENODEV);
>   
> +	/*
> +	 * Skip the PCI device specified in `pci_devs_to_skip`. This is a
> +	 * temporary solution until we figure out a way to extract information
> +	 * from the hypervisor what devices it is already using.
> +	 */
> +	if (pci_devs_to_skip && *pci_devs_to_skip) {
> +		int pos = 0;
> +		int parsed;
> +		int segment, bus, slot, func;
> +		struct pci_dev *pdev = to_pci_dev(dev);
> +
> +		do {
> +			parsed = 0;
> +
> +			sscanf(pci_devs_to_skip + pos,
> +				" (%x:%x:%x.%x) %n",
> +				&segment, &bus, &slot, &func, &parsed);
> +
> +			if (parsed <= 0)
> +				break;
> +
> +			if (pci_domain_nr(pdev->bus) == segment &&
> +				pdev->bus->number == bus &&
> +				PCI_SLOT(pdev->devfn) == slot &&
> +				PCI_FUNC(pdev->devfn) == func)
> +			{
> +				dev_info(dev, "skipped by MSHV IOMMU\n");
> +				return ERR_PTR(-ENODEV);
> +			}
> +
> +			pos += parsed;
> +
> +		} while (pci_devs_to_skip[pos]);
> +	}
> +
>   	vdev = kzalloc(sizeof(*vdev), GFP_KERNEL);
>   	if (!vdev)
>   		return ERR_PTR(-ENOMEM);
> 
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
