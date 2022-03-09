Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 49C8AC433F5
	for <virtualization@archiver.kernel.org>; Thu, 10 Mar 2022 09:19:11 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id CD8764187F;
	Thu, 10 Mar 2022 09:19:10 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id yDB19C09r-5A; Thu, 10 Mar 2022 09:19:10 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 4A93341881;
	Thu, 10 Mar 2022 09:19:09 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id F0267C001D;
	Thu, 10 Mar 2022 09:19:08 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id BDE60C000B
 for <virtualization@lists.linux-foundation.org>;
 Thu, 10 Mar 2022 09:19:07 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id A77F183E7C
 for <virtualization@lists.linux-foundation.org>;
 Thu, 10 Mar 2022 09:19:07 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=linuxfoundation.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id aTTy3CNqVGM2
 for <virtualization@lists.linux-foundation.org>;
 Thu, 10 Mar 2022 09:19:07 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 04F4683313
 for <virtualization@lists.linux-foundation.org>;
 Thu, 10 Mar 2022 09:19:06 +0000 (UTC)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id E208361BD9;
 Thu, 10 Mar 2022 09:19:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CB3AAC36AF4;
 Thu, 10 Mar 2022 09:19:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
 s=korg; t=1646903944;
 bh=OhpNF8WViNL36unydTb9lJvXpzj1iKydclWlldKejA8=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=X+mo8Ku6PDmkuYG+dP+vMfeZVH4RSVdYuglzgukjP7KGC6+WpTWKEedCc3JAJFNqN
 eOmr/iCfygmbKi/ml0lM6KYErYaVJHt3zhhABlLV0seUR5UJaI7nd1LbPMeSZaiWD6
 Tw98ZEIKZiCCXIZOb6KjHGnCX2UDknr54dhcgRtE=
Date: Wed, 9 Mar 2022 19:33:10 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Vishnu Dasa <vdasa@vmware.com>
Subject: Re: [PATCH] VMCI: Fix a couple of failure paths in
 vmci_guest_probe_device()
Message-ID: <Yijy5miaTI3GIXDZ@kroah.com>
References: <1646850296-49445-1-git-send-email-vdasa@vmware.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1646850296-49445-1-git-send-email-vdasa@vmware.com>
Cc: pv-drivers@vmware.com, bryantan@vmware.com, rjalisatgi@vmware.com,
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

On Wed, Mar 09, 2022 at 10:24:56AM -0800, Vishnu Dasa wrote:
> notification_bitmap may not be released when VMCI_CAPS_DMA_DATAGRAM
> capability is missing from the device.  Add missing
> 'err_free_notification_bitmap' label and use it instead of
> 'err_free_data_buffers' to avoid this.
> 
> free_irq() may be called to free an interrupt that was not
> allocated.  Add missing 'if' statement to check for
> exclusive_vectors when freeing interrupt 1.
> 
> Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
> Reviewed-by: Bryan Tan <bryantan@vmware.com>
> Reviewed-by: Rajesh Jalisatgi <rjalisatgi@vmware.com>
> Signed-off-by: Vishnu Dasa <vdasa@vmware.com>
> ---
> The patches which introduced these bugs are not in any released
> kernels nor RC yet, so this fix does not need to be backported.

So this has to get into 5.17-final?  If not, it should be backported to
5.17, right?  You should always include the "Fixes:" tag in the commit
message so that we can figure this out.

And shouldn't this be 2 different patches?  Please break up.

thanks,

greg k-h
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
