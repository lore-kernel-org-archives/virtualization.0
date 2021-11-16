Return-Path: <SRS0=Mct1=QD=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D008CC433F5
	for <virtualization@archiver.kernel.org>; Tue, 16 Nov 2021 18:15:38 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6AADC61A7D
	for <virtualization@archiver.kernel.org>; Tue, 16 Nov 2021 18:15:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 6AADC61A7D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=csail.mit.edu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 200DD40332;
	Tue, 16 Nov 2021 18:15:38 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id kGRIt5TzUq-C; Tue, 16 Nov 2021 18:15:37 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 8F6BB400BD;
	Tue, 16 Nov 2021 18:15:36 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 6B067C002E;
	Tue, 16 Nov 2021 18:15:36 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 0732AC0012
 for <virtualization@lists.linux-foundation.org>;
 Tue, 16 Nov 2021 18:15:36 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id D13434039C
 for <virtualization@lists.linux-foundation.org>;
 Tue, 16 Nov 2021 18:15:35 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 3CDiE4SO-AWX
 for <virtualization@lists.linux-foundation.org>;
 Tue, 16 Nov 2021 18:15:35 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
Received: from outgoing-stata.csail.mit.edu (outgoing-stata.csail.mit.edu
 [128.30.2.210])
 by smtp2.osuosl.org (Postfix) with ESMTP id F1093400BD
 for <virtualization@lists.linux-foundation.org>;
 Tue, 16 Nov 2021 18:15:34 +0000 (UTC)
Received: from [128.177.79.46] (helo=csail.mit.edu)
 by outgoing-stata.csail.mit.edu with esmtpsa (TLS1.2:RSA_AES_256_CBC_SHA1:256)
 (Exim 4.82) (envelope-from <srivatsa@csail.mit.edu>)
 id 1mn2zO-00026C-FP; Tue, 16 Nov 2021 13:15:26 -0500
Date: Tue, 16 Nov 2021 10:18:37 -0800
From: "Srivatsa S. Bhat" <srivatsa@csail.mit.edu>
To: Joe Perches <joe@perches.com>
Subject: Re: [PATCH v3 1/3] MAINTAINERS: Update maintainers for paravirt ops
 and VMware hypervisor interface
Message-ID: <20211116181837.GA24696@csail.mit.edu>
References: <163657479269.84207.13658789048079672839.stgit@srivatsa-dev>
 <163657487268.84207.5604596767569015608.stgit@srivatsa-dev>
 <YYy9P7Rjg9hntmm3@kroah.com> <20211111153916.GA7966@csail.mit.edu>
 <YY1krlfM5R7uEzJF@kroah.com> <20211111194002.GA8739@csail.mit.edu>
 <YY6hhWtvh+OvOqAl@sashalap> <20211115223900.GA22267@csail.mit.edu>
 <70cd970d6c39a5ea5e88cbf4b86031c22c5d10d4.camel@perches.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <70cd970d6c39a5ea5e88cbf4b86031c22c5d10d4.camel@perches.com>
Cc: Sasha Levin <sashal@kernel.org>, jgross@suse.com, anishs@vmware.com,
 pv-drivers@vmware.com, Greg KH <gregkh@linuxfoundation.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org,
 virtualization@lists.linux-foundation.org, keerthanak@vmware.com,
 namit@vmware.com, rostedt@goodmis.org, Alexey Makhalov <amakhalov@vmware.com>,
 kuba@kernel.org
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

On Mon, Nov 15, 2021 at 08:33:40PM -0800, Joe Perches wrote:
> On Mon, 2021-11-15 at 14:39 -0800, Srivatsa S. Bhat wrote:
> > On Fri, Nov 12, 2021 at 12:16:53PM -0500, Sasha Levin wrote:
> > > Maybe we should just remove MAINTAINERS from stable trees to make it
> > > obvious.
> > 
> > I don't think we should go quite that far. Instead, perhaps we can
> > modify get_maintainer.pl (if needed) such that it prints out a warning
> > or reminder to consult the upstream MAINTAINERS file if the script is
> > invoked on an older stable kernel.
> 
> I don't see how that's feasible.
> 

Not that I'm pushing for this change, but isn't it straight-forward to
distinguish upstream and stable kernel releases based on their
versioning schemes? The SUBLEVEL in the Makefile is always 0 for
upstream, and positive for stable versions (ignoring ancient kernels
like v2.6.32, of course). Since stable kernels are behind mainline by
definition, anytime the get_maintainer.pl script is invoked on a
kernel with a positive SUBLEVEL value, we can print out the said
warning/reminder (if it is considered useful).

Regards,
Srivatsa
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
