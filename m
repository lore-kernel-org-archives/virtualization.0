Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BCF84C433F5
	for <virtualization@archiver.kernel.org>; Fri,  4 Feb 2022 15:12:14 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 47DE760E42;
	Fri,  4 Feb 2022 15:12:14 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id KUdjCHpUNhEX; Fri,  4 Feb 2022 15:12:13 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id EBEFE60AAB;
	Fri,  4 Feb 2022 15:12:12 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id CE17FC0011;
	Fri,  4 Feb 2022 15:12:12 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 76A96C000B
 for <virtualization@lists.linux-foundation.org>;
 Fri,  4 Feb 2022 15:12:11 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 73259416BE
 for <virtualization@lists.linux-foundation.org>;
 Fri,  4 Feb 2022 15:12:11 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=linuxfoundation.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id w1uFtpCO1DNN
 for <virtualization@lists.linux-foundation.org>;
 Fri,  4 Feb 2022 15:12:10 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
Received: from ams.source.kernel.org (ams.source.kernel.org
 [IPv6:2604:1380:4601:e00::1])
 by smtp4.osuosl.org (Postfix) with ESMTPS id CA5E041682
 for <virtualization@lists.linux-foundation.org>;
 Fri,  4 Feb 2022 15:12:10 +0000 (UTC)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ams.source.kernel.org (Postfix) with ESMTPS id 39201B837C5;
 Fri,  4 Feb 2022 15:12:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8DEB9C004E1;
 Fri,  4 Feb 2022 15:12:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
 s=korg; t=1643987528;
 bh=067hDVxi+b/lqCImfNdJsFF36HNXY7Gq9n7MG2mjYBU=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=yCvZPumyM+8jZeDdP7sbGmXcxOg5mjO1n5L7wGbmiwGfJC/684atfpmyBWpOrR5vQ
 bSQU/vWfW8WCaoakXP0tCcB/OU3JMmAahfdq6qlbavHz2J56GCWDE3gQ5Z3ZdP1SNQ
 PKJTrgqV75NthSY94V51HR+XGqyeKqkg1HVbpO9k=
Date: Fri, 4 Feb 2022 16:12:00 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Jorgen Hansen <jhansen@vmware.com>
Subject: Re: [PATCH v2 4/8] VMCI: dma dg: set OS page size
Message-ID: <Yf1CQO99mPzLg+Mq@kroah.com>
References: <20220203131237.3380-1-jhansen@vmware.com>
 <20220203131237.3380-5-jhansen@vmware.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20220203131237.3380-5-jhansen@vmware.com>
Cc: pv-drivers@vmware.com, Vishnu Dasa <vdasa@vmware.com>,
 linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org
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

On Thu, Feb 03, 2022 at 05:12:33AM -0800, Jorgen Hansen wrote:
> Tell the device the page size used by the OS.
> 
> Reviewed-by: Vishnu Dasa <vdasa@vmware.com>
> Signed-off-by: Jorgen Hansen <jhansen@vmware.com>
> ---
>  drivers/misc/vmw_vmci/vmci_guest.c | 9 +++++++++
>  include/linux/vmw_vmci_defs.h      | 1 +
>  2 files changed, 10 insertions(+)
> 
> diff --git a/drivers/misc/vmw_vmci/vmci_guest.c b/drivers/misc/vmw_vmci/vmci_guest.c
> index 5a99d8e27873..808680dc0820 100644
> --- a/drivers/misc/vmw_vmci/vmci_guest.c
> +++ b/drivers/misc/vmw_vmci/vmci_guest.c
> @@ -581,6 +581,15 @@ static int vmci_guest_probe_device(struct pci_dev *pdev,
>  	/* Let the host know which capabilities we intend to use. */
>  	vmci_write_reg(vmci_dev, caps_in_use, VMCI_CAPS_ADDR);
>  
> +	if (caps_in_use & VMCI_CAPS_DMA_DATAGRAM) {
> +		uint32_t page_shift;
> +
> +		/* Let the device know the size for pages passed down. */
> +		vmci_write_reg(vmci_dev, PAGE_SHIFT, VMCI_GUEST_PAGE_SHIFT);
> +		page_shift = vmci_read_reg(vmci_dev, VMCI_GUEST_PAGE_SHIFT);
> +		dev_info(&pdev->dev, "Using page shift %d\n", page_shift);

Please do not print out debugging stuff like this to the kernel log.

When drivers are working properly, they are quiet.

thanks,

greg k-h
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
