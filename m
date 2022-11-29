Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D1785C4332F
	for <virtualization@archiver.kernel.org>; Tue, 29 Nov 2022 09:00:22 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 48D634087C;
	Tue, 29 Nov 2022 09:00:22 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 48D634087C
Authentication-Results: smtp4.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=EHJIG+TR
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id YCQeCtG_5qHu; Tue, 29 Nov 2022 09:00:21 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 8E1EC40880;
	Tue, 29 Nov 2022 09:00:20 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 8E1EC40880
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 6501DC0032;
	Tue, 29 Nov 2022 09:00:20 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id D9F51C002D
 for <virtualization@lists.linux-foundation.org>;
 Tue, 29 Nov 2022 09:00:19 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id B430281454
 for <virtualization@lists.linux-foundation.org>;
 Tue, 29 Nov 2022 09:00:19 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org B430281454
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.a=rsa-sha256 header.s=k20201202 header.b=EHJIG+TR
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id e0T0WKfYeFlC
 for <virtualization@lists.linux-foundation.org>;
 Tue, 29 Nov 2022 09:00:19 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 1837181449
Received: from dfw.source.kernel.org (dfw.source.kernel.org
 [IPv6:2604:1380:4641:c500::1])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 1837181449
 for <virtualization@lists.linux-foundation.org>;
 Tue, 29 Nov 2022 09:00:18 +0000 (UTC)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id 08F74615FC;
 Tue, 29 Nov 2022 09:00:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E363EC433C1;
 Tue, 29 Nov 2022 09:00:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1669712417;
 bh=JMtlPLzZ3a8fXa9Q793wRaTS3fttDUGM3PLHlR6YI3w=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=EHJIG+TR359VmsNT5iPayk59dMzJSPkzpLsBoCKl0C9vOB+/WxLRZYadp7o59YZOj
 8wAbN9dF2RLZ47Nbw21HQQ7mvev3ZirlLyqtAdzYxMKnWOn3zBddPzbzDZmHb17N/t
 aZYvwg8VS3UJcvhJBLHapMlVN24EzjECVnaLpYu/cUWAjidsfV6nQvARvMXArynG1O
 7hTlXdwoLbKNm4wZUwYZGm2MyGPlWIXsG4wyJbqia042Al8Yln1KUVwbaiG12DZhBE
 ekv7nwmE6R7ok0+kD80RzW/1s2d0NGkGR8oAGSKDl/JQ+H1/voAE9nm4O3DmIbe2gk
 abnGFPJSv4j0w==
Date: Tue, 29 Nov 2022 11:00:13 +0200
From: Leon Romanovsky <leon@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
Subject: Re: [RFC PATCH net-next 10/19] pds_core: devlink params for enabling
 VIF support
Message-ID: <Y4XKHTAOxQwKuaQU@unreal>
References: <20221118225656.48309-1-snelson@pensando.io>
 <20221118225656.48309-11-snelson@pensando.io>
 <20221128102953.2a61e246@kernel.org>
 <f7457718-cff6-e5e1-242e-89b0e118ec3f@amd.com>
 <Y4U8wIXSM2kESQIr@lunn.ch>
 <43eebffe-7ac1-6311-6973-c7a53935e42d@amd.com>
 <Y4VEZj7KQG+zSjlh@lunn.ch> <20221128153922.2e94958a@kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20221128153922.2e94958a@kernel.org>
Cc: Andrew Lunn <andrew@lunn.ch>, Shannon Nelson <shnelson@amd.com>,
 mst@redhat.com, netdev@vger.kernel.org,
 virtualization@lists.linux-foundation.org, drivers@pensando.io,
 Shannon Nelson <snelson@pensando.io>, davem@davemloft.net
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

On Mon, Nov 28, 2022 at 03:39:22PM -0800, Jakub Kicinski wrote:
> On Tue, 29 Nov 2022 00:29:42 +0100 Andrew Lunn wrote:
> > > How about:
> > > 	DEVLINK_PARAM_GENERIC_ID_ENABLE_LIVE_MIGRATION  
> > 
> > Much better.
> 
> +1, although I care much less about the define name which is stupidly
> long anyway and more about the actual value that the user will see

We have enable/disable devlink live migration knob in our queue. Saeed
thought to send it next week.

Thanks
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
