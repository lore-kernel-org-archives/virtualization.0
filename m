Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 17E21C4167D
	for <virtualization@archiver.kernel.org>; Fri, 22 Apr 2022 14:54:11 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id BC53081457;
	Fri, 22 Apr 2022 14:54:10 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ns8ezg3gqf-1; Fri, 22 Apr 2022 14:54:10 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 5642C8001F;
	Fri, 22 Apr 2022 14:54:09 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 24290C0039;
	Fri, 22 Apr 2022 14:54:09 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id CE97AC002D
 for <virtualization@lists.linux-foundation.org>;
 Fri, 22 Apr 2022 14:54:07 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id B405A83DF6
 for <virtualization@lists.linux-foundation.org>;
 Fri, 22 Apr 2022 14:54:07 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id MbNbzzjlIUuz
 for <virtualization@lists.linux-foundation.org>;
 Fri, 22 Apr 2022 14:54:05 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
 by smtp1.osuosl.org (Postfix) with ESMTPS id C2BE683404
 for <virtualization@lists.linux-foundation.org>;
 Fri, 22 Apr 2022 14:54:05 +0000 (UTC)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id BDD8F60C6E;
 Fri, 22 Apr 2022 14:54:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0DC7EC385AB;
 Fri, 22 Apr 2022 14:54:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
 s=korg; t=1650639244;
 bh=c/tlEA8ZlzdxmIQcMOOwVpEn66NWm3rRj8+jDgV6xxc=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=gqA0vzwFNzldjsjjRmYleh3zBQQsf2csoe8Klhv/3GjBm4DNaPy55KzSHN+92OUFG
 m3GNyJl25wnUK7V/vD5eogrGZ+M/bqPHb977EwGlbc3JNLGzmYWVnypL9eTSt5TC+O
 s80RQTbQw2OrYCwnCnsa3LtgR6qLawgvnYBRHp1Q=
Date: Fri, 22 Apr 2022 16:54:01 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: Re: [PATCH v7 00/12] Fix broken usage of driver_override (and kfree
 of static memory)
Message-ID: <YmLBiQjyKhFZsPlG@kroah.com>
References: <20220419113435.246203-1-krzysztof.kozlowski@linaro.org>
 <529de1fd-7e98-1634-c61e-0e69ddcd9e73@linaro.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <529de1fd-7e98-1634-c61e-0e69ddcd9e73@linaro.org>
Cc: linux-hyperv@vger.kernel.org, Stuart Yoder <stuyoder@gmail.com>,
 "Rafael J. Wysocki" <rafael@kernel.org>, linux-pci@vger.kernel.org,
 linux-remoteproc@vger.kernel.org, alsa-devel@alsa-project.org,
 Peter Oberparleiter <oberpar@linux.ibm.com>,
 Vineeth Vijayan <vneethv@linux.ibm.com>,
 Alexander Gordeev <agordeev@linux.ibm.com>, linux-clk@vger.kernel.org,
 linux-s390@vger.kernel.org, Wei Liu <wei.liu@kernel.org>,
 Stephen Hemminger <sthemmin@microsoft.com>, Dexuan Cui <decui@microsoft.com>,
 Andy Shevchenko <andy.shevchenko@gmail.com>, Andy Gross <agross@kernel.org>,
 NXP Linux Team <linux-imx@nxp.com>, virtualization@lists.linux-foundation.org,
 Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
 linux-arm-msm@vger.kernel.org, Haiyang Zhang <haiyangz@microsoft.com>,
 Rasmus Villemoes <linux@rasmusvillemoes.dk>,
 Bjorn Helgaas <bhelgaas@google.com>,
 Bjorn Andersson <bjorn.andersson@linaro.org>,
 linux-arm-kernel@lists.infradead.org,
 Mathieu Poirier <mathieu.poirier@linaro.org>, linux-kernel@vger.kernel.org,
 linux-spi@vger.kernel.org, Sven Schnelle <svens@linux.ibm.com>,
 Linus Torvalds <torvalds@linux-foundation.org>
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

On Wed, Apr 20, 2022 at 11:20:06AM +0200, Krzysztof Kozlowski wrote:
> On 19/04/2022 13:34, Krzysztof Kozlowski wrote:
> 
> Hi Greg, Rafael,
> 
> The patchset was for some time on the lists, got some reviews, some
> changes/feedback which I hope I applied/responded.
> 
> Entire set depends on the driver core changes, so maybe you could pick
> up everything via drivers core tree?

Ok, will do, thanks.

greg k-h
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
