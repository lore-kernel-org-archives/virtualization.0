Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1652FC433F5
	for <virtualization@archiver.kernel.org>; Fri, 18 Mar 2022 12:47:15 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id B1DAB8481B;
	Fri, 18 Mar 2022 12:47:15 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 3vQ6zul9W1Mu; Fri, 18 Mar 2022 12:47:15 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 6964E8481F;
	Fri, 18 Mar 2022 12:47:14 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 259F8C001A;
	Fri, 18 Mar 2022 12:47:14 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id E03F8C000B
 for <virtualization@lists.linux-foundation.org>;
 Fri, 18 Mar 2022 12:47:12 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id C02396080A
 for <virtualization@lists.linux-foundation.org>;
 Fri, 18 Mar 2022 12:47:12 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=linuxfoundation.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id fGcugfpnw5U9
 for <virtualization@lists.linux-foundation.org>;
 Fri, 18 Mar 2022 12:47:12 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
Received: from ams.source.kernel.org (ams.source.kernel.org
 [IPv6:2604:1380:4601:e00::1])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 12DD860759
 for <virtualization@lists.linux-foundation.org>;
 Fri, 18 Mar 2022 12:47:11 +0000 (UTC)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ams.source.kernel.org (Postfix) with ESMTPS id 8AC5BB82265;
 Fri, 18 Mar 2022 12:47:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E302CC340E8;
 Fri, 18 Mar 2022 12:47:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
 s=korg; t=1647607628;
 bh=s/tR3vmJ6yluDHWR+/tWoJCyxW4zOMrmbL3tDyikWFA=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=RtXxBn4OFQ9FB2xH98Gr68EKBJpgpK6Nvtw40YUmKfM1YXhcw5bPcox4a9ceX0W2a
 RIuptf52vePW8hqljxdb0TPZIMvWHheK30QhCpLgaCnIw6l1CWszcatFnwDkShmux+
 jKz14+wlPLVnMISLpKJDfv6IoiDvgwLtZugPE6Us=
Date: Fri, 18 Mar 2022 13:47:03 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: vdasa@vmware.com
Subject: Re: [PATCH RESEND] VMCI: Check exclusive_vectors when freeing
 interrupt 1
Message-ID: <YjR/RyduLkaQevQp@kroah.com>
References: <20220318055843.30606-1-vdasa@vmware.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20220318055843.30606-1-vdasa@vmware.com>
Cc: pv-drivers@vmware.com, rjalisatgi@vmware.com, linux-kernel@vger.kernel.org,
 virtualization@lists.linux-foundation.org, bryantan@vmware.com,
 Dan Carpenter <dan.carpenter@oracle.com>
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

On Thu, Mar 17, 2022 at 10:58:43PM -0700, vdasa@vmware.com wrote:
> From: Vishnu Dasa <vdasa@vmware.com>
> 
> free_irq() may be called to free an interrupt that was not
> allocated.  Add missing 'if' statement to check for
> exclusive_vectors when freeing interrupt 1.
> 
> Fixes: cc68f2177fcb ("VMCI: dma dg: register dummy IRQ handlers for DMA datagrams")
> Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
> Reviewed-by: Bryan Tan <bryantan@vmware.com>
> Reviewed-by: Rajesh Jalisatgi <rjalisatgi@vmware.com>
> Signed-off-by: Vishnu Dasa <vdasa@vmware.com>
> ---
>  drivers/misc/vmw_vmci/vmci_guest.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/misc/vmw_vmci/vmci_guest.c b/drivers/misc/vmw_vmci/vmci_guest.c
> index 6596a54daa88..57a6157209a1 100644
> --- a/drivers/misc/vmw_vmci/vmci_guest.c
> +++ b/drivers/misc/vmw_vmci/vmci_guest.c
> @@ -862,7 +862,9 @@ static int vmci_guest_probe_device(struct pci_dev *pdev,
>  	return 0;
>  
>  err_free_bm_irq:
> -	free_irq(pci_irq_vector(pdev, 1), vmci_dev);
> +	if (vmci_dev->exclusive_vectors)
> +		free_irq(pci_irq_vector(pdev, 1), vmci_dev);
> +
>  err_free_irq:
>  	free_irq(pci_irq_vector(pdev, 0), vmci_dev);
>  	tasklet_kill(&vmci_dev->datagram_tasklet);
> -- 
> 2.25.1
> 

You sent the previous version 2 days before this, and 5 days before
that.  Please relax and don't start worrying unless it's been 2 weeks.

thanks,

greg k-h
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
