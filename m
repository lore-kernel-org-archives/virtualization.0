Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C4049C19F29
	for <virtualization@archiver.kernel.org>; Thu, 28 Jul 2022 08:44:54 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 6D7A760B50;
	Thu, 28 Jul 2022 08:44:54 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 6D7A760B50
Authentication-Results: smtp3.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=bn1arOhX
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id tttv0h9qXOgd; Thu, 28 Jul 2022 08:44:52 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id C07C5606BF;
	Thu, 28 Jul 2022 08:44:51 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org C07C5606BF
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 7E837C0035;
	Thu, 28 Jul 2022 08:44:51 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id F1661C002D
 for <virtualization@lists.linux-foundation.org>;
 Thu, 28 Jul 2022 08:44:49 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id AEAEE60B50
 for <virtualization@lists.linux-foundation.org>;
 Thu, 28 Jul 2022 08:44:49 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org AEAEE60B50
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 9HBDLv1LaBlC
 for <virtualization@lists.linux-foundation.org>;
 Thu, 28 Jul 2022 08:44:49 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org EED55606BF
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
 by smtp3.osuosl.org (Postfix) with ESMTPS id EED55606BF
 for <virtualization@lists.linux-foundation.org>;
 Thu, 28 Jul 2022 08:44:48 +0000 (UTC)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ams.source.kernel.org (Postfix) with ESMTPS id 1E26FB8236D;
 Thu, 28 Jul 2022 08:44:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7ADC9C433C1;
 Thu, 28 Jul 2022 08:44:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
 s=korg; t=1658997885;
 bh=kjXvoyrVFqKMyp7gDe2PYIdDOYJl8LQrhNsJ/qwi1MU=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=bn1arOhX5Vh1zIiaStd7UHo9M1Dfp/uNmTh/2atMFY9R2AbHfSVYlbo46Ed6xz8T5
 EfbkjqAiNI/CWBO5NZlfigcRtXfeQSPzVDwyW4tNi5teEBBHvdHOOJpnKPdZfQ3B1b
 DHIEFeQ+wqhL037uDLMVbp4a3YUbrdevGaRMzV7U=
Date: Thu, 28 Jul 2022 10:44:43 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: rajesh jalisatgi <rajeshjalisatgi@gmail.com>
Subject: Re: [PATCH] VMCI: Update maintainers for VMCI
Message-ID: <YuJMe6WD1eeU2jyW@kroah.com>
References: <20220725163246.38486-1-vdasa@vmware.com>
 <Yt7bfyANrfdPxdS8@kroah.com>
 <FD326388-D2BB-42B4-B217-89DB9C134866@vmware.com>
 <YuAD90UfLnf1Ojso@kroah.com>
 <47D07B41-C327-4908-A383-683FC6C67040@vmware.com>
 <CAJ60do+Lgnx6gfHncckF-=8F=zzn81tCiFNLOmg_8TyuLGUotw@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAJ60do+Lgnx6gfHncckF-=8F=zzn81tCiFNLOmg_8TyuLGUotw@mail.gmail.com>
Cc: Vishnu Dasa <vdasa@vmware.com>, Pv-drivers <Pv-drivers@vmware.com>,
 Bryan Tan <bryantan@vmware.com>,
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

On Tue, Jul 26, 2022 at 09:35:54AM -0700, rajesh jalisatgi wrote:

<snip>

This message never made it to any public list as it was sent in HTML
format.  Please resend in a way we can properly access it.

thanks,

greg k-h
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
