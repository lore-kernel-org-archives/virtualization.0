Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CD6BEC00140
	for <virtualization@archiver.kernel.org>; Tue, 26 Jul 2022 15:16:43 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 49E2D422F0;
	Tue, 26 Jul 2022 15:16:43 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 49E2D422F0
Authentication-Results: smtp4.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=ey0DAijP
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id dVcXAhK7ZGmP; Tue, 26 Jul 2022 15:16:42 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 94AA0422EE;
	Tue, 26 Jul 2022 15:16:41 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 94AA0422EE
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 675E0C0033;
	Tue, 26 Jul 2022 15:16:41 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id E73E5C002D
 for <virtualization@lists.linux-foundation.org>;
 Tue, 26 Jul 2022 15:16:40 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id B179184057
 for <virtualization@lists.linux-foundation.org>;
 Tue, 26 Jul 2022 15:16:40 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org B179184057
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (1024-bit key) header.d=linuxfoundation.org
 header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg
 header.b=ey0DAijP
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id vQN_UZ2vK2PJ
 for <virtualization@lists.linux-foundation.org>;
 Tue, 26 Jul 2022 15:16:40 +0000 (UTC)
X-Greylist: delayed 00:05:43 by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org E517F83FAE
Received: from sin.source.kernel.org (sin.source.kernel.org
 [IPv6:2604:1380:40e1:4800::1])
 by smtp1.osuosl.org (Postfix) with ESMTPS id E517F83FAE
 for <virtualization@lists.linux-foundation.org>;
 Tue, 26 Jul 2022 15:16:39 +0000 (UTC)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by sin.source.kernel.org (Postfix) with ESMTPS id 497AECE19EC;
 Tue, 26 Jul 2022 15:10:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 76F9AC433C1;
 Tue, 26 Jul 2022 15:10:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
 s=korg; t=1658848251;
 bh=Ve3kJopSs2GE0hsDcrtwFJkWj6Nvx21L402wTn5aSw0=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=ey0DAijPvLnK4bfKUSDWiyI4CdD2YLHtQNKvPqxonvaip1mmJEFPnDWamjrQq6xDQ
 BnUtc50uPchU5gwsEweasVZ3R3SKzt5Uu7tROvEcbDXl+cMENbyzCNCAaMM6xMubPK
 igWAR4lKo3tuZEODfPM07jwesz730pTTUK1cEFE4=
Date: Tue, 26 Jul 2022 17:10:47 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Vishnu Dasa <vdasa@vmware.com>
Subject: Re: [PATCH] VMCI: Update maintainers for VMCI
Message-ID: <YuAD90UfLnf1Ojso@kroah.com>
References: <20220725163246.38486-1-vdasa@vmware.com>
 <Yt7bfyANrfdPxdS8@kroah.com>
 <FD326388-D2BB-42B4-B217-89DB9C134866@vmware.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <FD326388-D2BB-42B4-B217-89DB9C134866@vmware.com>
Cc: Pv-drivers <Pv-drivers@vmware.com>, Bryan Tan <bryantan@vmware.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "virtualization@lists.linux-foundation.org"
 <virtualization@lists.linux-foundation.org>
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

On Mon, Jul 25, 2022 at 06:29:25PM +0000, Vishnu Dasa wrote:
> 
> > On Jul 25, 2022, at 11:05 AM, Greg KH <gregkh@linuxfoundation.org> wrote:
> > 
> > On Mon, Jul 25, 2022 at 09:32:46AM -0700, vdasa@vmware.com wrote:
> >> From: Vishnu Dasa <vdasa@vmware.com>
> >> 
> >> Remove Rajesh as a maintainer for the VMCI driver.
> > 
> > Why?
> 
> Rajesh is no longer with VMware and won't be working on VMCI.

But employment does not matter for maintainership and has nothing to do
with it.  Maintainership follows the person, not the company, you all
know this.

So for obvious reasons, I can't take this type of change without Rajesh
acking it.

thanks,

greg k-h
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
