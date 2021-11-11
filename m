Return-Path: <SRS0=fJjx=P6=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1F85C433EF
	for <virtualization@archiver.kernel.org>; Thu, 11 Nov 2021 19:37:03 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3542B61269
	for <virtualization@archiver.kernel.org>; Thu, 11 Nov 2021 19:37:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 3542B61269
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=csail.mit.edu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id E0CDA4057F;
	Thu, 11 Nov 2021 19:37:02 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 3oi74wWyO6ok; Thu, 11 Nov 2021 19:37:02 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 7A5DF4057B;
	Thu, 11 Nov 2021 19:37:01 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 45019C0019;
	Thu, 11 Nov 2021 19:37:01 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 02A81C000E
 for <virtualization@lists.linux-foundation.org>;
 Thu, 11 Nov 2021 19:37:00 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id D7F6F60600
 for <virtualization@lists.linux-foundation.org>;
 Thu, 11 Nov 2021 19:36:59 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id KqkRdLuPigKr
 for <virtualization@lists.linux-foundation.org>;
 Thu, 11 Nov 2021 19:36:58 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
Received: from outgoing-stata.csail.mit.edu (outgoing-stata.csail.mit.edu
 [128.30.2.210])
 by smtp3.osuosl.org (Postfix) with ESMTP id A9829605F8
 for <virtualization@lists.linux-foundation.org>;
 Thu, 11 Nov 2021 19:36:58 +0000 (UTC)
Received: from [128.177.79.46] (helo=csail.mit.edu)
 by outgoing-stata.csail.mit.edu with esmtpsa (TLS1.2:RSA_AES_256_CBC_SHA1:256)
 (Exim 4.82) (envelope-from <srivatsa@csail.mit.edu>)
 id 1mlFsU-0003Le-47; Thu, 11 Nov 2021 14:36:54 -0500
Date: Thu, 11 Nov 2021 11:40:02 -0800
From: "Srivatsa S. Bhat" <srivatsa@csail.mit.edu>
To: Greg KH <gregkh@linuxfoundation.org>
Subject: Re: [PATCH v3 1/3] MAINTAINERS: Update maintainers for paravirt ops
 and VMware hypervisor interface
Message-ID: <20211111194002.GA8739@csail.mit.edu>
References: <163657479269.84207.13658789048079672839.stgit@srivatsa-dev>
 <163657487268.84207.5604596767569015608.stgit@srivatsa-dev>
 <YYy9P7Rjg9hntmm3@kroah.com> <20211111153916.GA7966@csail.mit.edu>
 <YY1krlfM5R7uEzJF@kroah.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <YY1krlfM5R7uEzJF@kroah.com>
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

On Thu, Nov 11, 2021 at 07:45:02PM +0100, Greg KH wrote:
> On Thu, Nov 11, 2021 at 07:39:16AM -0800, Srivatsa S. Bhat wrote:
> > On Thu, Nov 11, 2021 at 07:50:39AM +0100, Greg KH wrote:
> > > On Wed, Nov 10, 2021 at 12:08:16PM -0800, Srivatsa S. Bhat wrote:
> > > > From: Srivatsa S. Bhat (VMware) <srivatsa@csail.mit.edu>
> > > > 
> > > > Deep has decided to transfer maintainership of the VMware hypervisor
> > > > interface to Srivatsa, and the joint-maintainership of paravirt ops in
> > > > the Linux kernel to Srivatsa and Alexey. Update the MAINTAINERS file
> > > > to reflect this change.
> > > > 
> > > > Signed-off-by: Srivatsa S. Bhat (VMware) <srivatsa@csail.mit.edu>
> > > > Acked-by: Alexey Makhalov <amakhalov@vmware.com>
> > > > Acked-by: Deep Shah <sdeep@vmware.com>
> > > > Acked-by: Juergen Gross <jgross@suse.com>
> > > > Cc: stable@vger.kernel.org
> > > 
> > > Why are MAINTAINERS updates needed for stable?  That's not normal :(
> > 
> > So that people posting bug-fixes / backports to these subsystems for
> > older kernels (stable and LTS releases) will CC the new subsystem
> > maintainers.
> 
> That's not how stable releases work at all.
> 
> > That's why I added CC stable tag only to the first two
> > patches which add/replace maintainers and not the third patch which is
> > just a cleanup.
> 
> Patches for stable kernels need to go into Linus's tree first, and if
> you have the MAINTAINERS file updated properly there, then you will be
> properly cc:ed.  We do not look at the MAINTAINERS file for the older
> kernel when sending patches out, it's totally ignored as that was the
> snapshot at a point in time, which is usually no longer the true state.
> 

Sure, but that's the case for patches that get mainlined (and
subsequently backported to -stable) /after/ this update to the
MAINTAINERS file gets merged into mainline.

When adding the CC stable tag, the case I was trying to address was
for patches that are already in mainline but weren't CC'ed to stable,
and at some later point, somebody decides to backport them to older
stable kernels. In that case, there is a chance that the contributor
might run ./get_maintainer.pl against the stable tree (as that's the
tree they are backporting the upstream commit against) and end up not
CC'ing the new maintainers. So, I thought it would be good to keep the
maintainer info updated in the older stable kernels too.

Regards,
Srivatsa
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
