Return-Path: <SRS0=Mct1=QD=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C07DC433F5
	for <virtualization@archiver.kernel.org>; Tue, 16 Nov 2021 05:11:32 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9877C61A6C
	for <virtualization@archiver.kernel.org>; Tue, 16 Nov 2021 05:11:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 9877C61A6C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=perches.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 598C6607C6;
	Tue, 16 Nov 2021 05:11:31 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id b_bUjPLC3G7c; Tue, 16 Nov 2021 05:11:30 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 2727260775;
	Tue, 16 Nov 2021 05:11:30 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id ED040C002E;
	Tue, 16 Nov 2021 05:11:29 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id AD60AC0012
 for <virtualization@lists.linux-foundation.org>;
 Tue, 16 Nov 2021 05:11:27 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 873D6401BA
 for <virtualization@lists.linux-foundation.org>;
 Tue, 16 Nov 2021 05:11:27 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 5iyNplVhv0Aq
 for <virtualization@lists.linux-foundation.org>;
 Tue, 16 Nov 2021 05:11:26 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
Received: from smtprelay.hostedemail.com (smtprelay0155.hostedemail.com
 [216.40.44.155])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 2CBED40100
 for <virtualization@lists.linux-foundation.org>;
 Tue, 16 Nov 2021 05:11:26 +0000 (UTC)
Received: from smtprelay.hostedemail.com (10.5.19.251.rfc1918.com
 [10.5.19.251])
 by smtpgrave08.hostedemail.com (Postfix) with ESMTP id 9074D182D3ECD
 for <virtualization@lists.linux-foundation.org>;
 Tue, 16 Nov 2021 04:33:48 +0000 (UTC)
Received: from omf17.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
 by smtprelay02.hostedemail.com (Postfix) with ESMTP id AE6D98479E;
 Tue, 16 Nov 2021 04:33:45 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: joe@perches.com) by
 omf17.hostedemail.com (Postfix) with ESMTPA id B1937E00035D; 
 Tue, 16 Nov 2021 04:33:38 +0000 (UTC)
Message-ID: <70cd970d6c39a5ea5e88cbf4b86031c22c5d10d4.camel@perches.com>
Subject: Re: [PATCH v3 1/3] MAINTAINERS: Update maintainers for paravirt ops
 and VMware hypervisor interface
From: Joe Perches <joe@perches.com>
To: "Srivatsa S. Bhat" <srivatsa@csail.mit.edu>, Sasha Levin
 <sashal@kernel.org>
Date: Mon, 15 Nov 2021 20:33:40 -0800
In-Reply-To: <20211115223900.GA22267@csail.mit.edu>
References: <163657479269.84207.13658789048079672839.stgit@srivatsa-dev>
 <163657487268.84207.5604596767569015608.stgit@srivatsa-dev>
 <YYy9P7Rjg9hntmm3@kroah.com> <20211111153916.GA7966@csail.mit.edu>
 <YY1krlfM5R7uEzJF@kroah.com> <20211111194002.GA8739@csail.mit.edu>
 <YY6hhWtvh+OvOqAl@sashalap> <20211115223900.GA22267@csail.mit.edu>
User-Agent: Evolution 3.40.4-1 
MIME-Version: 1.0
X-Rspamd-Queue-Id: B1937E00035D
X-Stat-Signature: f98m33wsx4mfc3t3jhbfctk3bb9t83gn
X-Rspamd-Server: rspamout01
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Session-ID: U2FsdGVkX187U+B1QyrWtVLRt6ScGYedLRY84IBk+8w=
X-HE-Tag: 1637037218-641034
Cc: jgross@suse.com, anishs@vmware.com, pv-drivers@vmware.com,
 Greg KH <gregkh@linuxfoundation.org>, x86@kernel.org,
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

On Mon, 2021-11-15 at 14:39 -0800, Srivatsa S. Bhat wrote:
> On Fri, Nov 12, 2021 at 12:16:53PM -0500, Sasha Levin wrote:
> > Maybe we should just remove MAINTAINERS from stable trees to make it
> > obvious.
> 
> I don't think we should go quite that far. Instead, perhaps we can
> modify get_maintainer.pl (if needed) such that it prints out a warning
> or reminder to consult the upstream MAINTAINERS file if the script is
> invoked on an older stable kernel.

I don't see how that's feasible.

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
