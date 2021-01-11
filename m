Return-Path: <SRS0=uMqA=GO=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA3A4C433DB
	for <virtualization@archiver.kernel.org>; Mon, 11 Jan 2021 12:45:40 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 870002250E
	for <virtualization@archiver.kernel.org>; Mon, 11 Jan 2021 12:45:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 870002250E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id 22E2E204A4;
	Mon, 11 Jan 2021 12:45:40 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id dRWFW7IyeHPk; Mon, 11 Jan 2021 12:45:38 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id DB2FB20115;
	Mon, 11 Jan 2021 12:45:38 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id AEFD5C088B;
	Mon, 11 Jan 2021 12:45:38 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 6E61EC013A
 for <virtualization@lists.linux-foundation.org>;
 Mon, 11 Jan 2021 12:45:37 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id 3C80A20115
 for <virtualization@lists.linux-foundation.org>;
 Mon, 11 Jan 2021 12:45:37 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id DrZlhXAoKnWC
 for <virtualization@lists.linux-foundation.org>;
 Mon, 11 Jan 2021 12:45:36 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by silver.osuosl.org (Postfix) with ESMTPS id 0F28F20030
 for <virtualization@lists.linux-foundation.org>;
 Mon, 11 Jan 2021 12:45:35 +0000 (UTC)
Received: by mail.kernel.org (Postfix) with ESMTPSA id 18F32224B8;
 Mon, 11 Jan 2021 12:45:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
 s=korg; t=1610369135;
 bh=at05HJArNeKKDG7o7RCUH++PakgXJOTjp8UY5j2EBo0=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=Z7qiqFwfLDo9Yx3j4OANoNk35Y+L4CpeD45ducxNOwurEQ4Zro1f81e7CmgnE9xLY
 Sb8XGccHj718e2u3uXmhx6EGBgdue1WVXxqIDabxWL13e8YRiZfagR5a3+H8FE+adh
 7+0HyR8PJT/vopBtAewl2pixGzV+FcrfteBN39e0=
Date: Mon, 11 Jan 2021 13:46:46 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Jorgen Hansen <jhansen@vmware.com>
Subject: Re: [PATCH] VMCI: Enforce queuepair max size for
 IOCTL_VMCI_QUEUEPAIR_ALLOC
Message-ID: <X/xItnTyAa7OwSEI@kroah.com>
References: <1610367535-4463-1-git-send-email-jhansen@vmware.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1610367535-4463-1-git-send-email-jhansen@vmware.com>
Cc: pv-drivers@vmware.com, linux-kernel@vger.kernel.org,
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

On Mon, Jan 11, 2021 at 04:18:53AM -0800, Jorgen Hansen wrote:
> When create the VMCI queue pair tracking data structures on the host
> side, the IOCTL for creating the VMCI queue pair didn't validate
> the queue pair size parameters. This change adds checks for this.
> 
> This avoids a memory allocation issue in qp_host_alloc_queue, as
> reported by nslusarek@gmx.net. The check in qp_host_alloc_queue
> has also been updated to enforce the maximum queue pair size
> as defined by VMCI_MAX_GUEST_QP_MEMORY.
> 
> The fix has been verified using sample code supplied by
> nslusarek@gmx.net.
> 
> Reported-by: nslusarek@gmx.net
> Reviewed-by: Vishnu Dasa <vdasa@vmware.com>
> Signed-off-by: Jorgen Hansen <jhansen@vmware.com>
> ---
>  drivers/misc/vmw_vmci/vmci_queue_pair.c | 12 ++++++++----
>  include/linux/vmw_vmci_defs.h           |  4 ++--
>  2 files changed, 10 insertions(+), 6 deletions(-)

Hi,

This is the friendly patch-bot of Greg Kroah-Hartman.  You have sent him
a patch that has triggered this response.  He used to manually respond
to these common problems, but in order to save his sanity (he kept
writing the same thing over and over, yet to different people), I was
created.  Hopefully you will not take offence and will fix the problem
in your patch and resubmit it so that it can be accepted into the Linux
kernel tree.

You are receiving this message because of the following common error(s)
as indicated below:

- You sent multiple patches, yet no indication of which ones should be
  applied in which order.  Greg could just guess, but if you are
  receiving this email, he guessed wrong and the patches didn't apply.
  Please read the section entitled "The canonical patch format" in the
  kernel file, Documentation/SubmittingPatches for a description of how
  to do this so that Greg has a chance to apply these correctly.


If you wish to discuss this problem further, or you have questions about
how to resolve this issue, please feel free to respond to this email and
Greg will reply once he has dug out from the pending patches received
from other developers.

thanks,

greg k-h's patch email bot
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
