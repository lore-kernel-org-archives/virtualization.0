Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7E1F0E92FCF
	for <virtualization@archiver.kernel.org>; Thu,  5 Oct 2023 22:51:09 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id F03696FA35;
	Thu,  5 Oct 2023 22:51:08 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org F03696FA35
Authentication-Results: smtp3.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=MNukphMS
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id TSrI_0cjO_EB; Thu,  5 Oct 2023 22:51:08 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 439BE60F47;
	Thu,  5 Oct 2023 22:51:07 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 439BE60F47
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 1477BC0071;
	Thu,  5 Oct 2023 22:51:07 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id E90BAC0032
 for <virtualization@lists.linux-foundation.org>;
 Thu,  5 Oct 2023 22:51:05 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id B19C84168D
 for <virtualization@lists.linux-foundation.org>;
 Thu,  5 Oct 2023 22:51:05 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org B19C84168D
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.a=rsa-sha256 header.s=k20201202 header.b=MNukphMS
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id FUyOaajVDy0o
 for <virtualization@lists.linux-foundation.org>;
 Thu,  5 Oct 2023 22:51:05 +0000 (UTC)
Received: from dfw.source.kernel.org (dfw.source.kernel.org
 [IPv6:2604:1380:4641:c500::1])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 086574157C
 for <virtualization@lists.linux-foundation.org>;
 Thu,  5 Oct 2023 22:51:04 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 086574157C
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by dfw.source.kernel.org (Postfix) with ESMTP id 84F8861B84;
 Thu,  5 Oct 2023 22:51:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0C844C433C7;
 Thu,  5 Oct 2023 22:51:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1696546263;
 bh=6Z+aNRTykgUl2shYjBKN3j99iPvZlR6BDg/SD2cELU8=;
 h=Date:From:To:Cc:Subject:In-Reply-To:From;
 b=MNukphMSInGVUe6e01X0aki2ed92AZyanoAXS1Tse2jkA9W3Ip2Vrq3qZXUuWFeAm
 5THAUEv1ZFV7lRkX73pa5wFZbrMZVnBtOOADNoSVhDoSwvQbgRCf2ReCyg2FU8JDiw
 hJBi1H9FhrZ6OnSz/lmhK+ZlshRSG+Z1VQ5zHtoIInARuChulTjTyRksLL+HT8wYwb
 /b2wAQVwnnFrh5H08XEA415LtQagTLgi6HT7mMLSLLrpdJGnm+chWdfYEO2Pvwz94V
 kz4ubbn+i563g6Wk23YSZYGgBg7iCQAhlJKyFUj281GiAyrIznmNiSXnDuSpnsUr5o
 bPn9QBR7/7oXQ==
Date: Thu, 5 Oct 2023 17:51:01 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Sui Jingfeng <sui.jingfeng@linux.dev>
Subject: Re: [-next 1/5] PCI: Add the pci_is_vga() helper
Message-ID: <20231005225101.GA792747@bhelgaas>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20230830111532.444535-2-sui.jingfeng@linux.dev>
Cc: Sui Jingfeng <suijingfeng@loongson.cn>, linux-pci@vger.kernel.org,
 linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
 Gurchetan Singh <gurchetansingh@chromium.org>,
 Bjorn Helgaas <bhelgaas@google.com>, virtualization@lists.linux-foundation.org,
 Chia-I Wu <olvaffe@gmail.com>, "Maciej W. Rozycki" <macro@orcam.me.uk>
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

On Wed, Aug 30, 2023 at 07:15:28PM +0800, Sui Jingfeng wrote:
> From: Sui Jingfeng <suijingfeng@loongson.cn>
> 
> The PCI code and ID assignment specification defined four types of
> display controllers for the display base class(03h), and the devices
> with 0x00h sub-class code are VGA devices. VGA devices with programming

I can update this with the spec details (PCI Code and Assignment spec
r1.15, secs 1.1 and 1.4).

> interface 0x00 is VGA-compatible, VGA devices with programming interface
> 0x01 are 8514-compatible controllers. Besides, PCI_CLASS_NOT_DEFINED_VGA
> is defined to provide backward compatibility for devices that were built
> before the class code field was defined. Hence, introduce the pci_is_vga()
> helper, let it handle the details for us. It returns true if the PCI(e)
> device being tested belongs to the VGA devices category.
>
> Cc: "Maciej W. Rozycki" <macro@orcam.me.uk>
> Signed-off-by: Sui Jingfeng <suijingfeng@loongson.cn>
> ---
>  include/linux/pci.h | 27 +++++++++++++++++++++++++++
>  1 file changed, 27 insertions(+)
> 
> diff --git a/include/linux/pci.h b/include/linux/pci.h
> index cf6e0b057752..ace727001911 100644
> --- a/include/linux/pci.h
> +++ b/include/linux/pci.h
> @@ -713,6 +713,33 @@ static inline bool pci_is_bridge(struct pci_dev *dev)
>  		dev->hdr_type == PCI_HEADER_TYPE_CARDBUS;
>  }
>  
> +/**
> + * The PCI code and ID assignment specification defined four types of
> + * display controllers for the display base class(03h), and the devices
> + * with 0x00h sub-class code are VGA devices. VGA devices with programming
> + * interface 0x00 is VGA-compatible, VGA devices with programming interface
> + * 0x01 are 8514-compatible controllers. Besides, PCI_CLASS_NOT_DEFINED_VGA
> + * is defined to provide backward compatibility for devices that were built
> + * before the class code field was defined. This means that it belong to the
> + * VGA devices category also.
> + *
> + * Returns:
> + * true if the PCI device is a VGA device, false otherwise.
> + */
> +static inline bool pci_is_vga(struct pci_dev *pdev)
> +{
> +	if (!pdev)
> +		return false;
> +
> +	if ((pdev->class >> 8) == PCI_CLASS_DISPLAY_VGA)
> +		return true;
> +
> +	if ((pdev->class >> 8) == PCI_CLASS_NOT_DEFINED_VGA)
> +		return true;

Are you seeing a problem that will be fixed by this series, i.e., a
PCI_CLASS_NOT_DEFINED_VGA device that we currently don't handle
correctly?

I think this makes sense per the spec, but there's always a risk of
breaking something, so it's nice if the change actually *fixes*
something to make that risk worthwhile.

> +	return false;
> +}
> +
>  #define for_each_pci_bridge(dev, bus)				\
>  	list_for_each_entry(dev, &bus->devices, bus_list)	\
>  		if (!pci_is_bridge(dev)) {} else
> -- 
> 2.34.1
> 
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
