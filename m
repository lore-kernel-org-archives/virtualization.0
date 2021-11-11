Return-Path: <SRS0=fJjx=P6=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F23BC433FE
	for <virtualization@archiver.kernel.org>; Thu, 11 Nov 2021 18:45:10 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C6FCE61267
	for <virtualization@archiver.kernel.org>; Thu, 11 Nov 2021 18:45:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org C6FCE61267
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 8FA4E404B4;
	Thu, 11 Nov 2021 18:45:09 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 1IlqyU8yU6g3; Thu, 11 Nov 2021 18:45:08 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 5877A402F1;
	Thu, 11 Nov 2021 18:45:08 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 18C48C0012;
	Thu, 11 Nov 2021 18:45:08 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 816B8C000E
 for <virtualization@lists.linux-foundation.org>;
 Thu, 11 Nov 2021 18:45:06 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 6EEC960778
 for <virtualization@lists.linux-foundation.org>;
 Thu, 11 Nov 2021 18:45:06 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=linuxfoundation.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id OnNtq9WL_JVr
 for <virtualization@lists.linux-foundation.org>;
 Thu, 11 Nov 2021 18:45:05 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 4817C6067A
 for <virtualization@lists.linux-foundation.org>;
 Thu, 11 Nov 2021 18:45:05 +0000 (UTC)
Received: by mail.kernel.org (Postfix) with ESMTPSA id 54ADF61247;
 Thu, 11 Nov 2021 18:45:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
 s=korg; t=1636656304;
 bh=8RZy03sKFmPQxQGWpXw06dPaHhv2NHWVZwLqTolSEBs=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=AgZ16xZyM0xpofvm47bb+5pA7KgECxsSn04+0rcqYZy6FuVFnASXPEEzSyGB6ac06
 lG2CM1rrx0R+mBr7DXTJnczIs3tZwL8SuKJMlszy2YQkB4DJhz6AALtVzgNcJlCsxa
 q/QXVTOEY99q8BKwxL6ikWFdvA2R0qmFstCeSgMI=
Date: Thu, 11 Nov 2021 19:45:02 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: "Srivatsa S. Bhat" <srivatsa@csail.mit.edu>
Subject: Re: [PATCH v3 1/3] MAINTAINERS: Update maintainers for paravirt ops
 and VMware hypervisor interface
Message-ID: <YY1krlfM5R7uEzJF@kroah.com>
References: <163657479269.84207.13658789048079672839.stgit@srivatsa-dev>
 <163657487268.84207.5604596767569015608.stgit@srivatsa-dev>
 <YYy9P7Rjg9hntmm3@kroah.com> <20211111153916.GA7966@csail.mit.edu>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20211111153916.GA7966@csail.mit.edu>
Cc: jgross@suse.com, anishs@vmware.com, pv-drivers@vmware.com, x86@kernel.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org,
 virtualization@lists.linux-foundation.org, keerthanak@vmware.com,
 namit@vmware.com, rostedt@goodmis.org, Alexey Makhalov <amakhalov@vmware.com>,
 joe@perches.com, kuba@kernel.org
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

On Thu, Nov 11, 2021 at 07:39:16AM -0800, Srivatsa S. Bhat wrote:
> On Thu, Nov 11, 2021 at 07:50:39AM +0100, Greg KH wrote:
> > On Wed, Nov 10, 2021 at 12:08:16PM -0800, Srivatsa S. Bhat wrote:
> > > From: Srivatsa S. Bhat (VMware) <srivatsa@csail.mit.edu>
> > > 
> > > Deep has decided to transfer maintainership of the VMware hypervisor
> > > interface to Srivatsa, and the joint-maintainership of paravirt ops in
> > > the Linux kernel to Srivatsa and Alexey. Update the MAINTAINERS file
> > > to reflect this change.
> > > 
> > > Signed-off-by: Srivatsa S. Bhat (VMware) <srivatsa@csail.mit.edu>
> > > Acked-by: Alexey Makhalov <amakhalov@vmware.com>
> > > Acked-by: Deep Shah <sdeep@vmware.com>
> > > Acked-by: Juergen Gross <jgross@suse.com>
> > > Cc: stable@vger.kernel.org
> > 
> > Why are MAINTAINERS updates needed for stable?  That's not normal :(
> 
> So that people posting bug-fixes / backports to these subsystems for
> older kernels (stable and LTS releases) will CC the new subsystem
> maintainers.

That's not how stable releases work at all.

> That's why I added CC stable tag only to the first two
> patches which add/replace maintainers and not the third patch which is
> just a cleanup.

Patches for stable kernels need to go into Linus's tree first, and if
you have the MAINTAINERS file updated properly there, then you will be
properly cc:ed.  We do not look at the MAINTAINERS file for the older
kernel when sending patches out, it's totally ignored as that was the
snapshot at a point in time, which is usually no longer the true state.

So this would have no affect at all, sorry.  That's why I asked if you
all really realized what you were doing here :)

thanks,

greg k-h
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
