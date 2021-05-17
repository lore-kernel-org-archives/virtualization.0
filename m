Return-Path: <SRS0=CgtS=KM=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1FA08C433ED
	for <virtualization@archiver.kernel.org>; Mon, 17 May 2021 05:46:23 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B33DC61206
	for <virtualization@archiver.kernel.org>; Mon, 17 May 2021 05:46:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B33DC61206
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 77DD140328;
	Mon, 17 May 2021 05:46:22 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id u4JEG55NMPvh; Mon, 17 May 2021 05:46:21 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTP id F3DB340452;
	Mon, 17 May 2021 05:46:20 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id D0DABC000E;
	Mon, 17 May 2021 05:46:20 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 94879C0001
 for <virtualization@lists.linux-foundation.org>;
 Mon, 17 May 2021 05:46:19 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 739C883B02
 for <virtualization@lists.linux-foundation.org>;
 Mon, 17 May 2021 05:46:19 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=linuxfoundation.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id B57PUPOqV3HB
 for <virtualization@lists.linux-foundation.org>;
 Mon, 17 May 2021 05:46:18 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by smtp1.osuosl.org (Postfix) with ESMTPS id D8B6B83AD6
 for <virtualization@lists.linux-foundation.org>;
 Mon, 17 May 2021 05:46:18 +0000 (UTC)
Received: by mail.kernel.org (Postfix) with ESMTPSA id 21CCF6108D;
 Mon, 17 May 2021 05:46:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
 s=korg; t=1621230378;
 bh=UssYIYbkL3qu2UXuoT41PmlhMhpzovvV5hj4VqQqw6c=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=Vna6C9/eXr0rr9wnsxamGgP6HY53+rapHkKqAnJK3sSoY631+u0j3cZ/Xjleivf8U
 lDAxln7hHa19MzfzYmHSkNzIK1K5pI/K/AyFyyommMzJ/FNr5UiqNJi1b78GTzBNCc
 OvydG874aqfpppXC7D0nP3i8lBieHyXygMg/IfKE=
Date: Mon, 17 May 2021 07:46:12 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Juerg Haefliger <juerg.haefliger@canonical.com>
Subject: Re: [PATCH] treewide: Remove leading spaces in Kconfig files
Message-ID: <YKIDJIfuufBrTQ4f@kroah.com>
References: <20210516132209.59229-1-juergh@canonical.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210516132209.59229-1-juergh@canonical.com>
Cc: linux-fbdev@vger.kernel.org, mst@redhat.com, tony@atomide.com,
 dri-devel@lists.freedesktop.org, virtualization@lists.linux-foundation.org,
 zbr@ioremap.net, lee.jones@linaro.org, daniel.thompson@linaro.org,
 linux-scsi@vger.kernel.org, aaro.koskinen@iki.fi,
 Juerg Haefliger <juergh@canonical.com>, kadlec@netfilter.org,
 lvs-devel@vger.kernel.org, ja@ssi.bg, coreteam@netfilter.org, kuba@kernel.org,
 pablo@netfilter.org, jejb@linux.ibm.com, horms@verge.net.au,
 linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 martin.petersen@oracle.com, jingoohan1@gmail.com, linux-usb@vger.kernel.org,
 fw@strlen.de, linux-kernel@vger.kernel.org, linux@prisktech.co.nz,
 netfilter-devel@vger.kernel.org, linux-crypto@vger.kernel.org,
 netdev@vger.kernel.org, linux-fsdevel@vger.kernel.org, davem@davemloft.net
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

On Sun, May 16, 2021 at 03:22:09PM +0200, Juerg Haefliger wrote:
> There are a few occurences of leading spaces before tabs in a couple of
> Kconfig files. Remove them by running the following command:
> 
>   $ find . -name 'Kconfig*' | xargs sed -r -i 's/^[ ]+\t/\t/'
> 
> Signed-off-by: Juerg Haefliger <juergh@canonical.com>
> ---
>  arch/arm/mach-omap1/Kconfig     | 12 ++++++------
>  arch/arm/mach-vt8500/Kconfig    |  6 +++---
>  arch/arm/mm/Kconfig             | 10 +++++-----
>  drivers/char/hw_random/Kconfig  |  8 ++++----
>  drivers/net/usb/Kconfig         | 10 +++++-----
>  drivers/net/wan/Kconfig         |  4 ++--
>  drivers/scsi/Kconfig            |  2 +-
>  drivers/uio/Kconfig             |  2 +-
>  drivers/video/backlight/Kconfig | 10 +++++-----
>  drivers/virtio/Kconfig          |  2 +-
>  drivers/w1/masters/Kconfig      |  6 +++---
>  fs/proc/Kconfig                 |  4 ++--
>  init/Kconfig                    |  2 +-
>  net/netfilter/Kconfig           |  2 +-
>  net/netfilter/ipvs/Kconfig      |  2 +-
>  15 files changed, 41 insertions(+), 41 deletions(-)

Please break this up into one patch per subsystem and resend to the
proper maintainers that way.

thanks,

greg k-h
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
