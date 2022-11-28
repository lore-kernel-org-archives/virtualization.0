Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 570D3C4321E
	for <virtualization@archiver.kernel.org>; Mon, 28 Nov 2022 23:30:28 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id B754160E2E;
	Mon, 28 Nov 2022 23:30:27 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org B754160E2E
Authentication-Results: smtp3.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.a=rsa-sha256 header.s=20171124 header.b=mld/RygI
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id kxor8sctzfnm; Mon, 28 Nov 2022 23:30:27 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 625FE60D56;
	Mon, 28 Nov 2022 23:30:26 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 625FE60D56
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 35EBCC0032;
	Mon, 28 Nov 2022 23:30:26 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 073B7C002D
 for <virtualization@lists.linux-foundation.org>;
 Mon, 28 Nov 2022 23:30:24 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id D05908140C
 for <virtualization@lists.linux-foundation.org>;
 Mon, 28 Nov 2022 23:30:23 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org D05908140C
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch
 header.a=rsa-sha256 header.s=20171124 header.b=mld/RygI
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id d86egT5Ae5IP
 for <virtualization@lists.linux-foundation.org>;
 Mon, 28 Nov 2022 23:30:23 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 35E108139F
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 35E108139F
 for <virtualization@lists.linux-foundation.org>;
 Mon, 28 Nov 2022 23:30:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
 s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
 References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
 Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
 Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
 bh=kC6pnBWOGreiyjfkHaB8DmewKznLzGQDHHEYlft9qEY=; b=mld/RygIdFIktFYpfgzY/sxnJZ
 K97NzztHKPhQWjRhfCcChYNyIpGeQmLob2BtDfGyRJppvznwX4jw2u5pAqL7GdmUnXGwPQrI0LQy/
 4KQkJM3ZpUbQp/3h0m+xef309/UEva1PefEdym7N+PG4K/C9VvRkGnzMgJP81LCJRC2s=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
 (envelope-from <andrew@lunn.ch>)
 id 1oznZG-003o3J-Bs; Tue, 29 Nov 2022 00:29:42 +0100
Date: Tue, 29 Nov 2022 00:29:42 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Shannon Nelson <shnelson@amd.com>
Subject: Re: [RFC PATCH net-next 10/19] pds_core: devlink params for enabling
 VIF support
Message-ID: <Y4VEZj7KQG+zSjlh@lunn.ch>
References: <20221118225656.48309-1-snelson@pensando.io>
 <20221118225656.48309-11-snelson@pensando.io>
 <20221128102953.2a61e246@kernel.org>
 <f7457718-cff6-e5e1-242e-89b0e118ec3f@amd.com>
 <Y4U8wIXSM2kESQIr@lunn.ch>
 <43eebffe-7ac1-6311-6973-c7a53935e42d@amd.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <43eebffe-7ac1-6311-6973-c7a53935e42d@amd.com>
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

> > I know we are running short of short acronyms and we have to recycle
> > them, rfc5513 and all, so could you actually use
> > DEVLINK_PARAM_GENERIC_ID_ENABLE_LIST_MANAGER making it clear your
> > Smart NIC is running majordomo and will soon replace vger.
> > 
> >        Andrew
> 
> Oh, hush, someone might hear you speak of our plan to take over the email
> world!

It seems like something a Smart NIC would be ideal to do. Here is an
email body and 10,000 email addresses i recently acquired, go send
spam to them at line rate.

> How about:
> 	DEVLINK_PARAM_GENERIC_ID_ENABLE_LIVE_MIGRATION

Much better.

     Andrew
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
