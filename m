Return-Path: <SRS0=hAHP=MN=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB859C07E9B
	for <virtualization@archiver.kernel.org>; Wed, 21 Jul 2021 09:00:44 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 950ED611C1
	for <virtualization@archiver.kernel.org>; Wed, 21 Jul 2021 09:00:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 950ED611C1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 5EB2F402BC;
	Wed, 21 Jul 2021 09:00:44 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id iTHWRdo9Xq2U; Wed, 21 Jul 2021 09:00:43 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id D893140138;
	Wed, 21 Jul 2021 09:00:42 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id A70EFC001A;
	Wed, 21 Jul 2021 09:00:42 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 4CD30C000E
 for <virtualization@lists.linux-foundation.org>;
 Wed, 21 Jul 2021 09:00:42 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 2F28D830C5
 for <virtualization@lists.linux-foundation.org>;
 Wed, 21 Jul 2021 09:00:42 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=linuxfoundation.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id yFfSdDXlIp8n
 for <virtualization@lists.linux-foundation.org>;
 Wed, 21 Jul 2021 09:00:41 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by smtp1.osuosl.org (Postfix) with ESMTPS id A380D82E4C
 for <virtualization@lists.linux-foundation.org>;
 Wed, 21 Jul 2021 09:00:41 +0000 (UTC)
Received: by mail.kernel.org (Postfix) with ESMTPSA id 9266C61175;
 Wed, 21 Jul 2021 09:00:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
 s=korg; t=1626858041;
 bh=Nm8mnH9tGqYOqV3B8p39LD6S+9Q29MorENuKk20x+4k=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=hn49yPndJpyJ+dUwfi+oo3LtPjWG5+/Bgou2JXhxVOPy7EHluSi16SeLnbp63ZQc9
 hWTxUquFme+uMe80OKPet9oLg0HJLP6/3LbrMehm2C22kkmFACe08WbGrXse4pHTOk
 9T4BwhS1yXEOkjhGKpo5tN0HuUMQ/hVcFqGqUdiE=
Date: Wed, 21 Jul 2021 11:00:38 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Jorgen Hansen <jhansen@vmware.com>
Subject: Re: [PATCH] MAINTAINERS: Update for VMCI driver
Message-ID: <YPfiNuKonyTIKcDL@kroah.com>
References: <1626776941-9163-1-git-send-email-jhansen@vmware.com>
 <YPan14jucU9/u6JL@kroah.com>
 <0C3493F7-AF29-417B-94EA-26871283E65A@vmware.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <0C3493F7-AF29-417B-94EA-26871283E65A@vmware.com>
Cc: Pv-drivers <Pv-drivers@vmware.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "virtualization@lists.linux-foundation.org"
 <virtualization@lists.linux-foundation.org>
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

On Wed, Jul 21, 2021 at 08:46:15AM +0000, Jorgen Hansen wrote:
> 
> 
> > On 20 Jul 2021, at 12:39, Greg KH <gregkh@linuxfoundation.org> wrote:
> > 
> > On Tue, Jul 20, 2021 at 03:29:01AM -0700, Jorgen Hansen wrote:
> >> Add maintainer info for the VMware VMCI driver.
> >> 
> >> Signed-off-by: Jorgen Hansen <jhansen@vmware.com>
> >> ---
> >> MAINTAINERS | 8 ++++++++
> >> 1 file changed, 8 insertions(+)
> >> 
> >> diff --git a/MAINTAINERS b/MAINTAINERS
> >> index a61f4f3..7e7c6fa 100644
> >> --- a/MAINTAINERS
> >> +++ b/MAINTAINERS
> >> @@ -19792,6 +19792,14 @@ L:	netdev@vger.kernel.org
> >> S:	Supported
> >> F:	drivers/ptp/ptp_vmw.c
> >> 
> >> +VMWARE VMCI DRIVER
> >> +M:	Jorgen Hansen <jhansen@vmware.com>
> >> +M:	Vishnu Dasa <vdasa@vmware.com>
> >> +M:	"VMware, Inc." <pv-drivers@vmware.com>
> > 
> > Please do not use generic aliases as they provide no personal
> > responsibility.  Just stick with real people.
> 
> That makes sense. However, the pv-drivers list is used for keeping managers
> and people helping with testing in the loop. So would adding pv-drivers as a
> second L: entry be OK?

Is it really a list?  If not, then that would not make much sense.
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
