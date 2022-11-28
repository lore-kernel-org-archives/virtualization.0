Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 37135C4321E
	for <virtualization@archiver.kernel.org>; Mon, 28 Nov 2022 22:57:51 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id A4548401A2;
	Mon, 28 Nov 2022 22:57:50 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org A4548401A2
Authentication-Results: smtp2.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.a=rsa-sha256 header.s=20171124 header.b=IW/JGQG9
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 4t-_ZoC_xEY2; Mon, 28 Nov 2022 22:57:49 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 4119940A81;
	Mon, 28 Nov 2022 22:57:49 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 4119940A81
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 12DCAC0033;
	Mon, 28 Nov 2022 22:57:49 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 3EEF5C002D
 for <virtualization@lists.linux-foundation.org>;
 Mon, 28 Nov 2022 22:57:48 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 2623B40A81
 for <virtualization@lists.linux-foundation.org>;
 Mon, 28 Nov 2022 22:57:48 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 2623B40A81
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id g3ghjvWyoz8u
 for <virtualization@lists.linux-foundation.org>;
 Mon, 28 Nov 2022 22:57:47 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org A8CBF401A2
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
 by smtp2.osuosl.org (Postfix) with ESMTPS id A8CBF401A2
 for <virtualization@lists.linux-foundation.org>;
 Mon, 28 Nov 2022 22:57:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
 s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
 References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
 Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
 Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
 bh=riUMz2JoO3Wk5wQE270/fOYDEjUtIRo/vnvujhBOz1A=; b=IW/JGQG9TWjEh4h85XQK6sqvet
 C8Cyl1CMwC6Zb+xo7yCyifc9IbjN0ulHo6seUOMudzknPkkuqwpW7RGebpRrIM7w8huFjsdqRNCvc
 towmL7awEKHOtLUEPR5UixURX4L2huiA+wXklEQUdB3gyThFcIjV0ks2Cjsv1vm2aEBc=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
 (envelope-from <andrew@lunn.ch>)
 id 1ozn3g-003nmw-Em; Mon, 28 Nov 2022 23:57:04 +0100
Date: Mon, 28 Nov 2022 23:57:04 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Shannon Nelson <shnelson@amd.com>
Subject: Re: [RFC PATCH net-next 10/19] pds_core: devlink params for enabling
 VIF support
Message-ID: <Y4U8wIXSM2kESQIr@lunn.ch>
References: <20221118225656.48309-1-snelson@pensando.io>
 <20221118225656.48309-11-snelson@pensando.io>
 <20221128102953.2a61e246@kernel.org>
 <f7457718-cff6-e5e1-242e-89b0e118ec3f@amd.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <f7457718-cff6-e5e1-242e-89b0e118ec3f@amd.com>
Cc: mst@redhat.com, netdev@vger.kernel.org,
 virtualization@lists.linux-foundation.org, Jakub Kicinski <kuba@kernel.org>,
 drivers@pensando.io, Shannon Nelson <snelson@pensando.io>, davem@davemloft.net
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

On Mon, Nov 28, 2022 at 02:26:26PM -0800, Shannon Nelson wrote:
> On 11/28/22 10:29 AM, Jakub Kicinski wrote:
> > On Fri, 18 Nov 2022 14:56:47 -0800 Shannon Nelson wrote:
> > > +     DEVLINK_PARAM_DRIVER(PDSC_DEVLINK_PARAM_ID_LM,
> > > +                          "enable_lm",
> > > +                          DEVLINK_PARAM_TYPE_BOOL,
> > > +                          BIT(DEVLINK_PARAM_CMODE_RUNTIME),
> > > +                          pdsc_dl_enable_get,
> > > +                          pdsc_dl_enable_set,
> > > +                          pdsc_dl_enable_validate),
> > 
> > Terrible name, not vendor specific.
> 
> ... but useful for starting a conversation.
> 
> How about we add
> 	DEVLINK_PARAM_GENERIC_ID_ENABLE_LM,

I know we are running short of short acronyms and we have to recycle
them, rfc5513 and all, so could you actually use
DEVLINK_PARAM_GENERIC_ID_ENABLE_LIST_MANAGER making it clear your
Smart NIC is running majordomo and will soon replace vger.

      Andrew
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
