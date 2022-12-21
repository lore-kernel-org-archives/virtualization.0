Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 752A6C4332F
	for <virtualization@archiver.kernel.org>; Wed, 21 Dec 2022 07:37:41 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id D7C7760FD2;
	Wed, 21 Dec 2022 07:37:40 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org D7C7760FD2
Authentication-Results: smtp3.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=vNb32GPp
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id A1BkD-Dgfd4u; Wed, 21 Dec 2022 07:37:40 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 736AE60FC1;
	Wed, 21 Dec 2022 07:37:39 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 736AE60FC1
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 6DC38C0071;
	Wed, 21 Dec 2022 07:37:36 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id E23E6C0070
 for <virtualization@lists.linux-foundation.org>;
 Wed, 21 Dec 2022 07:37:25 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 8D8C9404B3
 for <virtualization@lists.linux-foundation.org>;
 Wed, 21 Dec 2022 07:37:24 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 8D8C9404B3
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (1024-bit key) header.d=linuxfoundation.org
 header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg
 header.b=vNb32GPp
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id nyw1z_EXk2bH
 for <virtualization@lists.linux-foundation.org>;
 Wed, 21 Dec 2022 07:37:23 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 3FD7740476
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 3FD7740476
 for <virtualization@lists.linux-foundation.org>;
 Wed, 21 Dec 2022 07:37:22 +0000 (UTC)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ams.source.kernel.org (Postfix) with ESMTPS id 3023CB8136A;
 Wed, 21 Dec 2022 07:37:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2D487C433EF;
 Wed, 21 Dec 2022 07:37:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
 s=korg; t=1671608238;
 bh=3yfMgw+PQQ42Se7/IHoqWZt4LsTgn8jUBoQAaa2937o=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=vNb32GPpeB0LKGJop7iSiFWvICvnGNAs0Ttd7rCgxYP7nd1hIBkhex1xZd2x+mvkI
 Un6nbY0msoYjX/jOzl/kywALbyGXbduflx8l4u/QgXNz4ELq4gyFh5AkmfRnwezsow
 drP4K5xKgyeayv2I2FMjlKpmoNgMG21lQv7jwQUA=
Date: Wed, 21 Dec 2022 08:37:15 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Tudor Ambarus <tudor.ambarus@linaro.org>
Subject: Re: kernel BUG in __skb_gso_segment
Message-ID: <Y6K3q6Bo3wwC57bK@kroah.com>
References: <82b18028-7246-9af9-c992-528a0e77f6ba@linaro.org>
 <CAF=yD-KEwVnH6PRyxbJZt4iGfKasadYwU_6_V+hHW2s+ZqFNcw@mail.gmail.com>
 <a13f83f3-737d-1bfe-c9ef-031a6cd4d131@linaro.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <a13f83f3-737d-1bfe-c9ef-031a6cd4d131@linaro.org>
Cc: Willem de Bruijn <willemdebruijn.kernel@gmail.com>, mst@redhat.com,
 netdev@vger.kernel.org, willemb@google.com,
 virtualization@lists.linux-foundation.org, edumazet@google.com,
 syzkaller@googlegroups.com, liuhangbin@gmail.com, joneslee@google.com,
 kuba@kernel.org, pabeni@redhat.com, davem@davemloft.net,
 linux-kernel@vger.kernel.org
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

On Wed, Dec 21, 2022 at 09:28:16AM +0200, Tudor Ambarus wrote:
> Hi,
> 
> I added Greg KH to the thread, maybe he can shed some light on whether
> new support can be marked as fixes and backported to stable. The rules
> on what kind of patches are accepted into the -stable tree don't mention
> new support:
> https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html

As you say, we don't take new features into older kernels.  Unless they
fix a reported problem, if so, submit the git ids to us and we will be
glad to review them.

thanks,

greg k-h
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
