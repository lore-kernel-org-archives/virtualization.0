Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A02D6C4332F
	for <virtualization@archiver.kernel.org>; Wed, 21 Dec 2022 12:42:24 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 29AE481E53;
	Wed, 21 Dec 2022 12:42:24 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 29AE481E53
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=hXPp7+hB
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id GdqlSx25_TLm; Wed, 21 Dec 2022 12:42:22 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 1C7C081E2D;
	Wed, 21 Dec 2022 12:42:22 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 1C7C081E2D
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 23A06C0071;
	Wed, 21 Dec 2022 12:42:21 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id DE84CC0070
 for <virtualization@lists.linux-foundation.org>;
 Wed, 21 Dec 2022 12:42:09 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 58FF040382
 for <virtualization@lists.linux-foundation.org>;
 Wed, 21 Dec 2022 12:42:08 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 58FF040382
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (1024-bit key) header.d=linuxfoundation.org
 header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg
 header.b=hXPp7+hB
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id bUQx0ZGuNcIJ
 for <virtualization@lists.linux-foundation.org>;
 Wed, 21 Dec 2022 12:42:04 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 5B57F402A8
Received: from dfw.source.kernel.org (dfw.source.kernel.org
 [IPv6:2604:1380:4641:c500::1])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 5B57F402A8
 for <virtualization@lists.linux-foundation.org>;
 Wed, 21 Dec 2022 12:42:04 +0000 (UTC)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id 0C03B6179A;
 Wed, 21 Dec 2022 12:42:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CAC34C433EF;
 Wed, 21 Dec 2022 12:42:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
 s=korg; t=1671626522;
 bh=gQUFpEO6Bldd7g3YthL9Gzsvs+Z4eFoaLG9TyOi5QPY=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=hXPp7+hBYdB1DUfU5s9xr/o6OB4LsGlmipuTFugx9ufNhcSR3yHDYK74aGJEmekvH
 BBdojzzMb3poEm32umegR7l+3tWVAUQ8NmB/LGUrYRwdbWezgYNoWNIdpOXks1qiZv
 cOeHe6ZSkcX61WFsp6lAxE2Q+ORL3R7WQXYYCJy0=
Date: Wed, 21 Dec 2022 13:41:59 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Tudor Ambarus <tudor.ambarus@linaro.org>
Subject: Re: kernel BUG in __skb_gso_segment
Message-ID: <Y6L/F2Hwm7BRdYj8@kroah.com>
References: <82b18028-7246-9af9-c992-528a0e77f6ba@linaro.org>
 <CAF=yD-KEwVnH6PRyxbJZt4iGfKasadYwU_6_V+hHW2s+ZqFNcw@mail.gmail.com>
 <a13f83f3-737d-1bfe-c9ef-031a6cd4d131@linaro.org>
 <Y6K3q6Bo3wwC57bK@kroah.com>
 <fc60e8da-1187-ca2b-1aa8-28e01ea2769a@linaro.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <fc60e8da-1187-ca2b-1aa8-28e01ea2769a@linaro.org>
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

On Wed, Dec 21, 2022 at 09:42:59AM +0200, Tudor Ambarus wrote:
> 
> 
> On 21.12.2022 09:37, Greg KH wrote:
> > On Wed, Dec 21, 2022 at 09:28:16AM +0200, Tudor Ambarus wrote:
> > > Hi,
> > > 
> > > I added Greg KH to the thread, maybe he can shed some light on whether
> > > new support can be marked as fixes and backported to stable. The rules
> > > on what kind of patches are accepted into the -stable tree don't mention
> > > new support:
> > > https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html
> > 
> > As you say, we don't take new features into older kernels.  Unless they
> > fix a reported problem, if so, submit the git ids to us and we will be
> > glad to review them.
> > 
> 
> They do fix a bug. I'm taking care of it. Shall I update
> Documentation/process/stable-kernel-rules.rst to mention this rule as
> well?

How exactly would you change it, and why?
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
