Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D4C4CC77B61
	for <virtualization@archiver.kernel.org>; Thu, 27 Apr 2023 18:28:20 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 491A5408D3;
	Thu, 27 Apr 2023 18:28:20 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 491A5408D3
Authentication-Results: smtp4.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=WK3+Z2QS
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id kgJAY4CnNtYG; Thu, 27 Apr 2023 18:28:18 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 0F4864034F;
	Thu, 27 Apr 2023 18:28:18 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 0F4864034F
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id D16ECC0037;
	Thu, 27 Apr 2023 18:28:17 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id DEC3BC002A
 for <virtualization@lists.linux-foundation.org>;
 Thu, 27 Apr 2023 18:28:16 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id B6F384034F
 for <virtualization@lists.linux-foundation.org>;
 Thu, 27 Apr 2023 18:28:16 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org B6F384034F
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id CpaNoABxOJW8
 for <virtualization@lists.linux-foundation.org>;
 Thu, 27 Apr 2023 18:28:15 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 8586D40345
Received: from dfw.source.kernel.org (dfw.source.kernel.org
 [IPv6:2604:1380:4641:c500::1])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 8586D40345
 for <virtualization@lists.linux-foundation.org>;
 Thu, 27 Apr 2023 18:28:15 +0000 (UTC)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id B28BB63E9A;
 Thu, 27 Apr 2023 18:28:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D4625C4339E;
 Thu, 27 Apr 2023 18:28:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1682620094;
 bh=eBxG5p4VvkS1hruiYxFut4TnMP2p0AGA9ZCpb2a/S9Q=;
 h=Date:From:To:Cc:Subject:In-Reply-To:From;
 b=WK3+Z2QSIuyTRUnMXUba2OgVayK15hLaggwO9SU5drY4T1Gapbkeuga4bWm1QbLDI
 Y1k7HWzRDC94zvufNaMVWZrB1SZbfGNVOdIA6nHrD8J8CNAIe3FTQ7LaMGallRv1AU
 HJpfaOAArIjc+zAiBASBwB3Jd2bSw42N/esM4PIJ9eQBKuGOCLt6GHyGitZD3vMOfd
 D1JtafxEmzhi9FKIO/rRwjQNLDH2hxVFfOReSlRDIgSGwW1IGusKZ5IAPLftQ7CvJJ
 5aYwx7UOjSR/TRns1R5RDnHSF1CXZDvaJw15o6lRJPiRvoVXm1Wc/YJpLc+hfrgfzl
 86A8rh3EOWonw==
Date: Thu, 27 Apr 2023 13:28:12 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Shunsuke Mie <mie@igel.co.jp>
Subject: Re: [RFC PATCH v2 1/3] PCI: endpoint: introduce a helper to
 implement pci ep virtio function
Message-ID: <20230427182812.GA262399@bhelgaas>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20230427104428.862643-2-mie@igel.co.jp>
Cc: Kishon Vijay Abraham I <kishon@kernel.org>,
 Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, linux-pci@vger.kernel.org,
 Lorenzo Pieralisi <lpieralisi@kernel.org>,
 Randy Dunlap <rdunlap@infradead.org>, Frank Li <Frank.Li@nxp.com>,
 linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org,
 Ren Zhijie <renzhijie2@huawei.com>, Manivannan Sadhasivam <mani@kernel.org>,
 Jon Mason <jdmason@kudzu.us>, Bjorn Helgaas <bhelgaas@google.com>
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

Simple typos, don't repost until there's more substantive feedback.

On Thu, Apr 27, 2023 at 07:44:26PM +0900, Shunsuke Mie wrote:
> The Linux PCIe Endpoint framework supports to implement PCIe endpoint
> functions using a PCIe controller operating in endpoint mode.
> It is possble to realize the behavior of PCIe device, such as virtio PCI
> device. This patch introduces a setof helper functions and data structures
> to implement a PCIe endpoint function that behaves as a virtio device.

s/possble/possible/
s/setof/set of/

> Those functions enable the implementation PCIe endpoint function that
> comply with the virtio lecacy specification. Because modern virtio
> specifications require devices to implement custom PCIe capabilities, which
> are not currently supported by either PCIe controllers/drivers or the PCIe
> endpoint framework.

s/implementation PCIe endpoint function/implementation of PCIe endpoint functions/
s/lecacy/legacy/ (What does "legacy" mean?  Is there a spec for this?)

I guess "legacy virtio" devices need not implement custom PCIe
capabilities, but "modern virtio" devices must implement them?

Capitalize "Endpoint framework" consistently; sometimes it's
"Endpoint", other times it's "endpoint".

> While this patch provides functions for negotiating with host drivers and
> copying data, each PCIe function driver must impl ement operations that
> depend on each specific device, such as network, block, etc.

s/impl ement/implement/

> +#include <linux/virtio_pci.h>
> +#include <linux/virtio_config.h>
> +#include <linux/kthread.h>

Typically the header includes would be alphabetized if possible.

> +	vq_virt = pci_epc_map_addr(epf->epc, epf->func_no, epf->vfunc_no,
> +				   vq_pci_addr, vq_phys, vq_size);
> +	if (IS_ERR(vq_virt)) {
> +		pr_err("Failed to map virtuqueue to local");

s/virtuqueue/virtqueue/

I know you probably don't have any way to use dev_err(), but this
message really needs some context, like a driver name and instance or
something.

> +#define VIRTIO_PCI_LEGACY_CFG_BAR 0

What makes this a "legacy cfg BAR"?  Is there some spec that covers
virtio BAR usage?

> + * epf_virtio_init - initialize struct epf_virtio and setup BAR for virtio
> + * @evio: struct epf_virtio to initialize.
> + * @hdr: pci configuration space to show remote host.
> + * @bar_size: pci BAR size it depends on the virtio device type.

s/pci/PCI/ (there were also a few more instances above in messages or
comments)

> + * epf_virtio_final - finalize struct epf_virtio. it frees bar and memories
> + * @evio: struct epf_virtio to finalize.

s/bar/BAR/

> +static void epf_virtio_monitor_qnotify(struct epf_virtio *evio)
> +{
> +	const u16 qn_default = evio->nvq;
> +	u16 tmp;
> +
> +	/* Since there is no way to synchronize between the host and EP functions,
> +	 * it is possible to miss multiple notifications.

Multi-line comment style.

> +	err = epf_virtio_negotiate_vq(evio);
> +	if (err < 0) {
> +		pr_err("failed to negoticate configs with driver\n");

s/negoticate/negotiate/

> + * epf_virtio_reset - reset virtio status

Some of the function descriptions end with a period (".") and others
don't.  Please figure out what the most common style is and use that
consistently.

> +			dst = pci_epc_map_addr(epf->epc, epf->func_no,
> +					       epf->vfunc_no, dbase, &phys,
> +					       slen);
> +			if (IS_ERR(dst)) {
> +				pr_err("failed to map pci mmoery spact to local\n");

s/pci/PCI/
s/mmoery/memory/
s/spact/space/ ?

Also below.

IIRC some previous messages started with a capital letter.  Please
make them all consistent.

> +		if (dir == DMA_MEM_TO_DEV) {
> +			pci_epc_unmap_addr(epf->epc, epf->func_no,
> +					   epf->vfunc_no, phys, dst, slen);
> +		} else {
> +			pci_epc_unmap_addr(epf->epc, epf->func_no,
> +					   epf->vfunc_no, phys, src, slen);
> +		}
> +	}
> +
> +	return 1;

I guess this function returns either a negative error code or the
value 1?  That seems sort of weird (I think "negative error code or
*zero* is more typical), but maybe you're following some convention?

> +#include <linux/pci-epf.h>
> +#include <linux/pci-epc.h>
> +#include <linux/vringh.h>
> +#include <linux/dmaengine.h>

Alpha order if possible

> +	/* Virtual address of pci configuration space */

s/pci/PCI/

> +	/* Callback function and parameter for queue notifcation
> +	 * Note: PCI EP function cannot detect qnotify accurately, therefore this
> +	 * callback function should check all of virtqueue's changes.
> +	 */

Multi-line comment style.

Bjorn
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
