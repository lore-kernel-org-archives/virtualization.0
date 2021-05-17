Return-Path: <SRS0=CgtS=KM=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0AFDFC433ED
	for <virtualization@archiver.kernel.org>; Mon, 17 May 2021 08:17:50 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B1BBA6128C
	for <virtualization@archiver.kernel.org>; Mon, 17 May 2021 08:17:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B1BBA6128C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 7AEF1839D8;
	Mon, 17 May 2021 08:17:49 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id FEy8vPAOwmQm; Mon, 17 May 2021 08:17:46 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTP id 6E75883A05;
	Mon, 17 May 2021 08:17:45 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 4571BC000D;
	Mon, 17 May 2021 08:17:45 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id B7B9AC0001
 for <virtualization@lists.linux-foundation.org>;
 Mon, 17 May 2021 08:17:44 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 87982403D3
 for <virtualization@lists.linux-foundation.org>;
 Mon, 17 May 2021 08:17:44 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=linuxfoundation.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id OOxvU8ZfHYqD
 for <virtualization@lists.linux-foundation.org>;
 Mon, 17 May 2021 08:17:40 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 52642403D2
 for <virtualization@lists.linux-foundation.org>;
 Mon, 17 May 2021 08:17:40 +0000 (UTC)
Received: by mail.kernel.org (Postfix) with ESMTPSA id 787E960C3D;
 Mon, 17 May 2021 08:17:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
 s=korg; t=1621239459;
 bh=BZxAEIkbSW7MbE/cKpN6ELnrkkO5GDgcmYWBCq1E9oE=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=xe+a+SfspvvC4YFLbvfFGou5Jh4ZaOJhNkVXbtGzQzDaw9YtnD2k5/AYJRH37GLz1
 HarCPEyiCvtPLqqvURKmUeKluy77qdfGcIrJi/isWCrMZQ6A5QP/7rtzd2dmdK2J0A
 3SHQ8E4iKKDOiX1B7oZK1lgB1PjMHYvnVe3bZMP0=
Date: Mon, 17 May 2021 10:17:38 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Juerg Haefliger <juerg.haefliger@canonical.com>
Subject: Re: [PATCH] treewide: Remove leading spaces in Kconfig files
Message-ID: <YKImotylLR7D4mQW@kroah.com>
References: <20210516132209.59229-1-juergh@canonical.com>
 <YKIDJIfuufBrTQ4f@kroah.com>
 <CAB2i3ZgszsUVDuK2fkUXtD72tPSgrycnDawM4VAuGGPJiA9+cA@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAB2i3ZgszsUVDuK2fkUXtD72tPSgrycnDawM4VAuGGPJiA9+cA@mail.gmail.com>
Cc: linux-fbdev@vger.kernel.org, mst@redhat.com, tony@atomide.com,
 dri-devel@lists.freedesktop.org, virtualization@lists.linux-foundation.org,
 zbr@ioremap.net, Lee Jones <lee.jones@linaro.org>,
 Daniel Thompson <daniel.thompson@linaro.org>, linux-scsi@vger.kernel.org,
 aaro.koskinen@iki.fi, Juerg Haefliger <juergh@canonical.com>,
 kadlec@netfilter.org, lvs-devel@vger.kernel.org, ja@ssi.bg,
 coreteam@netfilter.org, kuba@kernel.org, pablo@netfilter.org,
 jejb@linux.ibm.com, horms@verge.net.au, linux-omap@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, martin.petersen@oracle.com,
 jingoohan1@gmail.com, linux-usb@vger.kernel.org, fw@strlen.de,
 LKML <linux-kernel@vger.kernel.org>, linux@prisktech.co.nz,
 netfilter-devel@vger.kernel.org, linux-crypto@vger.kernel.org,
 netdev <netdev@vger.kernel.org>, linux-fsdevel@vger.kernel.org,
 David Miller <davem@davemloft.net>
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

On Mon, May 17, 2021 at 10:07:43AM +0200, Juerg Haefliger wrote:
> On Mon, May 17, 2021 at 7:46 AM Greg KH <gregkh@linuxfoundation.org> wrote:
> >
> > On Sun, May 16, 2021 at 03:22:09PM +0200, Juerg Haefliger wrote:
> > > There are a few occurences of leading spaces before tabs in a couple of
> > > Kconfig files. Remove them by running the following command:
> > >
> > >   $ find . -name 'Kconfig*' | xargs sed -r -i 's/^[ ]+\t/\t/'
> > >
> > > Signed-off-by: Juerg Haefliger <juergh@canonical.com>
> > > ---
> > >  arch/arm/mach-omap1/Kconfig     | 12 ++++++------
> > >  arch/arm/mach-vt8500/Kconfig    |  6 +++---
> > >  arch/arm/mm/Kconfig             | 10 +++++-----
> > >  drivers/char/hw_random/Kconfig  |  8 ++++----
> > >  drivers/net/usb/Kconfig         | 10 +++++-----
> > >  drivers/net/wan/Kconfig         |  4 ++--
> > >  drivers/scsi/Kconfig            |  2 +-
> > >  drivers/uio/Kconfig             |  2 +-
> > >  drivers/video/backlight/Kconfig | 10 +++++-----
> > >  drivers/virtio/Kconfig          |  2 +-
> > >  drivers/w1/masters/Kconfig      |  6 +++---
> > >  fs/proc/Kconfig                 |  4 ++--
> > >  init/Kconfig                    |  2 +-
> > >  net/netfilter/Kconfig           |  2 +-
> > >  net/netfilter/ipvs/Kconfig      |  2 +-
> > >  15 files changed, 41 insertions(+), 41 deletions(-)
> >
> > Please break this up into one patch per subsystem and resend to the
> > proper maintainers that way.
> 
> Hmm... How is my patch different from other treewide Kconfig cleanup
> patches like:
> a7f7f6248d97 ("treewide: replace '---help---' in Kconfig files with 'help'")
> 8636a1f9677d ("treewide: surround Kconfig file paths with double quotes")
> 83fc61a563cb ("treewide: Fix typos in Kconfig")
> 769a12a9c760 ("treewide: Kconfig: fix wording / spelling")
> f54619f28fb6 ("treewide: Fix typos in Kconfig")

Ok, I'll just ignore this and not try to suggest a way for you to get
your change accepted...

greg k-h
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
