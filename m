Return-Path: <SRS0=+Z4V=G5=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A2EFC433E0
	for <virtualization@archiver.kernel.org>; Tue, 26 Jan 2021 18:19:17 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2FC0D207A9
	for <virtualization@archiver.kernel.org>; Tue, 26 Jan 2021 18:19:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2FC0D207A9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id C29988453D;
	Tue, 26 Jan 2021 18:19:16 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ILH0rHvt6YjM; Tue, 26 Jan 2021 18:19:16 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 3ADD1844CA;
	Tue, 26 Jan 2021 18:19:16 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 19AEBC0FA7;
	Tue, 26 Jan 2021 18:19:16 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id EA372C013A
 for <virtualization@lists.linux-foundation.org>;
 Tue, 26 Jan 2021 18:19:14 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id B5D442035B
 for <virtualization@lists.linux-foundation.org>;
 Tue, 26 Jan 2021 18:19:14 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id p-3VFK4s4Ns2
 for <virtualization@lists.linux-foundation.org>;
 Tue, 26 Jan 2021 18:19:13 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by silver.osuosl.org (Postfix) with ESMTPS id B073520355
 for <virtualization@lists.linux-foundation.org>;
 Tue, 26 Jan 2021 18:19:13 +0000 (UTC)
Received: by mail.kernel.org (Postfix) with ESMTPSA id E497D206B7;
 Tue, 26 Jan 2021 18:19:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
 s=korg; t=1611685153;
 bh=/W0CpE+i5EJG4RMr7NnCLePZex2RvGmJHRmEsh1ZZ6o=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=YB7JspRvUwnQftK+2RxlvQpsZW/6MJ8KrqM1YE4MWLmdvIaDruZb6y6NbyW2fjx1l
 N7xd6Z9nqFDcU7XgVwEVlfnbYCI92jTdlvwyq1Kh6AuLfloyBWDYRiXrlBhRqIjwT5
 z4zeCPw4GmKaadkh3tHk1tQViIoW6ywDHpyXizEc=
Date: Tue, 26 Jan 2021 19:19:11 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Jorgen Hansen <jhansen@vmware.com>
Subject: Re: [PATCH v2 0/3] VMCI: Queue pair bug fixes
Message-ID: <YBBdHz0zFPqFPywI@kroah.com>
References: <1611160324-30066-1-git-send-email-jhansen@vmware.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1611160324-30066-1-git-send-email-jhansen@vmware.com>
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

On Wed, Jan 20, 2021 at 08:32:04AM -0800, Jorgen Hansen wrote:
> This series contains three bug fixes for the queue pair
> implementation in the VMCI driver.
> 
> v1 -> v2:
>   - format patches as a series
>   - use min_t instead of min to ensure size_t comparison
>     (issue pointed out by kernel test robot <lkp@intel.com>)
> 
> Jorgen Hansen (3):
>   VMCI: Stop log spew when qp allocation isn't possible
>   VMCI: Use set_page_dirty_lock() when unregistering guest memory
>   VMCI: Enforce queuepair max size for IOCTL_VMCI_QUEUEPAIR_ALLOC
> 
>  drivers/misc/vmw_vmci/vmci_queue_pair.c | 16 ++++++++++------
>  include/linux/vmw_vmci_defs.h           |  4 ++--
>  2 files changed, 12 insertions(+), 8 deletions(-)
> 
> -- 
> 2.6.2
> 

Please in the future properly thread your emails so that tools like 'b4'
can pick them all up at once.

thanks,

greg k-h
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
