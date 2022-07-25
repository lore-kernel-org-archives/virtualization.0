Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 187F9C433EF
	for <virtualization@archiver.kernel.org>; Mon, 25 Jul 2022 18:06:06 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 949F660E0F;
	Mon, 25 Jul 2022 18:06:06 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 949F660E0F
Authentication-Results: smtp3.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=jlJJMIgj
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id FfX8zZeHwqBn; Mon, 25 Jul 2022 18:06:05 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 1A56F60BA1;
	Mon, 25 Jul 2022 18:06:05 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 1A56F60BA1
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id E5094C0033;
	Mon, 25 Jul 2022 18:06:04 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 84BE9C002D
 for <virtualization@lists.linux-foundation.org>;
 Mon, 25 Jul 2022 18:06:03 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 49F0F83434
 for <virtualization@lists.linux-foundation.org>;
 Mon, 25 Jul 2022 18:06:03 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 49F0F83434
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (1024-bit key) header.d=linuxfoundation.org
 header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg
 header.b=jlJJMIgj
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id YVjOuaVdA08t
 for <virtualization@lists.linux-foundation.org>;
 Mon, 25 Jul 2022 18:06:00 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 60D3483403
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 60D3483403
 for <virtualization@lists.linux-foundation.org>;
 Mon, 25 Jul 2022 18:06:00 +0000 (UTC)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ams.source.kernel.org (Postfix) with ESMTPS id 47916B81025;
 Mon, 25 Jul 2022 18:05:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 11783C341C6;
 Mon, 25 Jul 2022 18:05:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
 s=korg; t=1658772356;
 bh=A+xNeGPneLFwkZxPMiltoykKB8Es4RbWRTW+xpD7pVI=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=jlJJMIgjjkT4+NarOvwTnNNRxOyDcFdb4kO+7jQ1EU6MqnYhOOxhoFxW6H72A4VvP
 O+zG3ga7tQNVjcMCpGp1Z5+8sn9CxTZNShymf3uOkn5eUmBQyLuOrj/6x1DpJEIdoZ
 DsEoKMvlnQdStbJK44qO2Vt7OCiCVOAI4X8WphMc=
Date: Mon, 25 Jul 2022 20:05:51 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: vdasa@vmware.com
Subject: Re: [PATCH] VMCI: Update maintainers for VMCI
Message-ID: <Yt7bfyANrfdPxdS8@kroah.com>
References: <20220725163246.38486-1-vdasa@vmware.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20220725163246.38486-1-vdasa@vmware.com>
Cc: pv-drivers@vmware.com, bryantan@vmware.com, linux-kernel@vger.kernel.org,
 virtualization@lists.linux-foundation.org
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

On Mon, Jul 25, 2022 at 09:32:46AM -0700, vdasa@vmware.com wrote:
> From: Vishnu Dasa <vdasa@vmware.com>
> 
> Remove Rajesh as a maintainer for the VMCI driver.

Why?

> 
> Acked-by: Bryan Tan <bryantan@vmware.com>
> Signed-off-by: Vishnu Dasa <vdasa@vmware.com>

I need an ack from the person that is being removed here, for obvious
reasons.  Any specific reason you didn't cc: them on this patch?

thanks,

greg k-h
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
