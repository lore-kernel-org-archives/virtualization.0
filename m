Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AD8E5ECAAD5
	for <virtualization@archiver.kernel.org>; Mon, 29 Aug 2022 07:49:49 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 35BBF4048A;
	Mon, 29 Aug 2022 07:49:49 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 35BBF4048A
Authentication-Results: smtp2.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=yt6GPMZR
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id IV9n95I59kxz; Mon, 29 Aug 2022 07:49:48 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 95C2D400C1;
	Mon, 29 Aug 2022 07:49:47 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 95C2D400C1
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 5B30FC0032;
	Mon, 29 Aug 2022 07:49:47 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 418AEC002D
 for <virtualization@lists.linux-foundation.org>;
 Mon, 29 Aug 2022 07:49:46 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 151DB818A1
 for <virtualization@lists.linux-foundation.org>;
 Mon, 29 Aug 2022 07:49:46 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 151DB818A1
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (1024-bit key) header.d=linuxfoundation.org
 header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg
 header.b=yt6GPMZR
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id VZd8zOQAjovi
 for <virtualization@lists.linux-foundation.org>;
 Mon, 29 Aug 2022 07:49:45 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 522C881852
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 522C881852
 for <virtualization@lists.linux-foundation.org>;
 Mon, 29 Aug 2022 07:49:45 +0000 (UTC)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ams.source.kernel.org (Postfix) with ESMTPS id E17A4B80D27;
 Mon, 29 Aug 2022 07:49:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F3748C433D6;
 Mon, 29 Aug 2022 07:49:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
 s=korg; t=1661759381;
 bh=aGFduZhHwfv9PnY3vRPitP/7usWw3M+bWFBLuYbVIS0=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=yt6GPMZRoQxQaQf7mU/klM55vy27vm/KW0cqKOSj5iD/P/uxiaB1ghupJK+xPOHZE
 jycDWKH4POpzprvZDeN7T2Blk08twg/3ueahnOlDziRYemic+wlJlb/b7Ty6IgS/HJ
 yKAcr7PsClex4E5DnXvgHPsNsfCpWcgDjEqnMmng=
Date: Mon, 29 Aug 2022 09:48:44 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Maxime Coquelin <maxime.coquelin@redhat.com>
Subject: Re: [PATCH v2] vduse: prevent uninitialized memory accesses
Message-ID: <YwxvXFiuRqGxRgZH@kroah.com>
References: <20220829073424.5677-1-maxime.coquelin@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20220829073424.5677-1-maxime.coquelin@redhat.com>
Cc: guanjun@linux.alibaba.com, mst@redhat.com, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org, virtualization@lists.linux-foundation.org,
 xieyongji@bytedance.com, gautam.dawar@xilinx.com, elic@nvidia.com,
 dan.carpenter@oracle.com
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

On Mon, Aug 29, 2022 at 09:34:24AM +0200, Maxime Coquelin wrote:
> If the VDUSE application provides a smaller config space
> than the driver expects, the driver may use uninitialized
> memory from the stack.
> 
> This patch prevents it by initializing the buffer passed by
> the driver to store the config value.
> 
> This fix addresses CVE-2022-2308.
> 
> Cc: xieyongji@bytedance.com
> Cc: stable@vger.kernel.org # v5.15+
> Fixes: c8a6153b6c59 ("vduse: Introduce VDUSE - vDPA Device in Userspace")
> 
> Acked-by: Jason Wang <jasowang@redhat.com>
> Signed-off-by: Maxime Coquelin <maxime.coquelin@redhat.com>

Please no blank line above the Acked-by: line here if possible.

thanks,

greg k-h
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
