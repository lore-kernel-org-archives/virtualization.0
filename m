Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 48A36C433EF
	for <virtualization@archiver.kernel.org>; Thu,  7 Jul 2022 15:55:12 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id C4A1A41BA6;
	Thu,  7 Jul 2022 15:55:11 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org C4A1A41BA6
Authentication-Results: smtp4.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=TklWbEmb
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id HgfEIa3PCXCJ; Thu,  7 Jul 2022 15:55:10 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 28BE941BA5;
	Thu,  7 Jul 2022 15:55:10 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 28BE941BA5
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 876F3C0033;
	Thu,  7 Jul 2022 15:55:09 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 1CC59C002D
 for <virtualization@lists.linux-foundation.org>;
 Thu,  7 Jul 2022 15:55:08 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 0556D4018B
 for <virtualization@lists.linux-foundation.org>;
 Thu,  7 Jul 2022 15:55:08 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 0556D4018B
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.a=rsa-sha256 header.s=k20201202 header.b=TklWbEmb
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id GyWKENC0tGzk
 for <virtualization@lists.linux-foundation.org>;
 Thu,  7 Jul 2022 15:55:07 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 5153740606
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 5153740606
 for <virtualization@lists.linux-foundation.org>;
 Thu,  7 Jul 2022 15:55:07 +0000 (UTC)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ams.source.kernel.org (Postfix) with ESMTPS id 2DE26B82269;
 Thu,  7 Jul 2022 15:55:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8DDC9C3411E;
 Thu,  7 Jul 2022 15:55:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1657209302;
 bh=MH13anBIQAlg7iuL9TMZMMak6LuWoaKYU6GCL/VxllM=;
 h=Date:From:To:Cc:Subject:In-Reply-To:From;
 b=TklWbEmb0IG0ubepaaNE7fPRnsa3sXenPkN5azIZI5FwLByDHwIJw9Gw0B6IvR8iI
 IFr/icbokCzhR8gBu7/n5IawiMNB3Gcqqb3gcAyO623fiPgsp3KBxtfxsN3E+fUWuP
 agvAELktyYfZrNrV69aOtjG9kzl7SoEZlQPZK6v3fP0J6kz9xpfpoKyW9Z499c6euC
 kJNZPdnP92xFzXj1a/p81ciX64dCN9mzkONdbdDQu4pNKM8iehrKOdu6J34WlCdZlt
 05oe5NdKYsdR7KaKWMOtcu607eY/VZWOjkP0qKTbWFd089sahetVAcaL0XdSIUWUI6
 6Hk1cTmu26Frw==
Date: Thu, 7 Jul 2022 10:55:00 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Martin Habets <habetsm.xilinx@gmail.com>
Subject: Re: [PATCH net-next v2 0/2] sfc: Add EF100 BAR config support
Message-ID: <20220707155500.GA305857@bhelgaas>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <165719918216.28149.7678451615870416505.stgit@palantir17.mph.net>
Cc: netdev@vger.kernel.org, virtualization@lists.linux-foundation.org,
 ecree.xilinx@gmail.com, edumazet@google.com, linux-pci@vger.kernel.org,
 kuba@kernel.org, pabeni@redhat.com, davem@davemloft.net
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

On Thu, Jul 07, 2022 at 02:07:07PM +0100, Martin Habets wrote:
> The EF100 NICs allow for different register layouts of a PCI memory BAR.
> This series provides the framework to switch this layout at runtime.
> 
> Subsequent patch series will use this to add support for vDPA.

Normally drivers rely on the PCI Vendor and Device ID to learn the
number of BARs and their layouts.  I guess this series implies that
doesn't work on this device?  And the user needs to manually specify
what kind of device this is?

I'm confused about how this is supposed to work.  What if the driver
is built-in and claims a device before the user can specify the
register layout?  What if the user specifies the wrong layout and the
driver writes to the wrong registers?

> ---
> 
> Martin Habets (2):
>       sfc: Add EF100 BAR config support
>       sfc: Implement change of BAR configuration
> 
> 
>  drivers/net/ethernet/sfc/ef100_nic.c |   80 ++++++++++++++++++++++++++++++++++
>  drivers/net/ethernet/sfc/ef100_nic.h |    6 +++
>  2 files changed, 86 insertions(+)
> 
> --
> Martin Habets <habetsm.xilinx@gmail.com>
> 
> 
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
