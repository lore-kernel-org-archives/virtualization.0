Return-Path: <SRS0=OSH5=O3=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DCEC0C433F5
	for <virtualization@archiver.kernel.org>; Thu,  7 Oct 2021 15:25:08 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 909D66113E
	for <virtualization@archiver.kernel.org>; Thu,  7 Oct 2021 15:25:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 909D66113E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 5AB23607ED;
	Thu,  7 Oct 2021 15:25:08 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id rcBgSZ2jbX12; Thu,  7 Oct 2021 15:25:07 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 07F1B60FCD;
	Thu,  7 Oct 2021 15:25:06 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id E0B38C000F;
	Thu,  7 Oct 2021 15:25:06 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 2138CC000D
 for <virtualization@lists.linux-foundation.org>;
 Thu,  7 Oct 2021 15:25:06 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 095F040A0A
 for <virtualization@lists.linux-foundation.org>;
 Thu,  7 Oct 2021 15:25:06 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=linuxfoundation.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id JjBvxZA1lnBT
 for <virtualization@lists.linux-foundation.org>;
 Thu,  7 Oct 2021 15:25:05 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by smtp4.osuosl.org (Postfix) with ESMTPS id F3A16409F8
 for <virtualization@lists.linux-foundation.org>;
 Thu,  7 Oct 2021 15:25:04 +0000 (UTC)
Received: by mail.kernel.org (Postfix) with ESMTPSA id 1772E61090;
 Thu,  7 Oct 2021 15:25:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
 s=korg; t=1633620304;
 bh=UGCRCYvmUhVObljPNJkwbU4BVXrBTDvuEF6Qpw5Rwzc=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=JyIeCAiD13IiEXJ/WGJ79vL26uWDf4g9nPjfMIb9PSLkoJH4ghj9+ZybkXcMzo5/u
 ah42NGp9Ty+/NFvUApFOU/oSjxpZ4FnKHa/oAj7pYYAWvItLv5aZK02H8b5hPuPPO8
 E6GbZXf6rYpSE/DkGJRihAWwbX9eADnbMy74XBUc=
Date: Thu, 7 Oct 2021 17:25:02 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Subject: Re: virtio-net: kernel panic in virtio_net.c
Message-ID: <YV8RTqGSTuVLMFOP@kroah.com>
References: <5edaa2b7c2fe4abd0347b8454b2ac032b6694e2c.camel@collabora.com>
 <1633619172.5342586-1-xuanzhuo@linux.alibaba.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1633619172.5342586-1-xuanzhuo@linux.alibaba.com>
Cc: regressions@lists.linux.dev, "Michael S. Tsirkin" <mst@redhat.com>,
 Corentin =?iso-8859-1?Q?No=EBl?= <corentin.noel@collabora.com>,
 stable@vger.kernel.org, virtualization@lists.linux-foundation.org,
 Eric Dumazet <edumazet@google.com>
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
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

On Thu, Oct 07, 2021 at 11:06:12PM +0800, Xuan Zhuo wrote:
> On Thu, 07 Oct 2021 14:04:22 +0200, Corentin No=EBl <corentin.noel@collab=
ora.com> wrote:
> > I've been experiencing crashes with 5.14-rc1 and above that do not
> > occur with 5.13,
> =

> I should have fixed this problem before. I don't know why, I just looked =
at the
> latest net code, and this commit seems to be lost.
> =

>      1a8024239dacf53fcf39c0f07fbf2712af22864f virtio-net: fix for skb_ove=
r_panic inside big mode
> =

> Can you test this patch again?

That commit showed up in 5.13-rc5, so 5.14-rc1 and 5.13 should have had
it in it, right?

thanks,

greg k-h
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
