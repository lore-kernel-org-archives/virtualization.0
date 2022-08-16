Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1B22EC2BB41
	for <virtualization@archiver.kernel.org>; Tue, 16 Aug 2022 09:49:13 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 6E3C7410E4;
	Tue, 16 Aug 2022 09:49:13 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 6E3C7410E4
Authentication-Results: smtp4.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=kvzkpRTa
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 0Y6bZeM1GBRI; Tue, 16 Aug 2022 09:49:12 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 3C6DE409EE;
	Tue, 16 Aug 2022 09:49:11 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 3C6DE409EE
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id ED6B0C0032;
	Tue, 16 Aug 2022 09:49:10 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 2060CC002D
 for <virtualization@lists.linux-foundation.org>;
 Tue, 16 Aug 2022 09:49:10 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id E72F260ADD
 for <virtualization@lists.linux-foundation.org>;
 Tue, 16 Aug 2022 09:49:09 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org E72F260ADD
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (1024-bit key) header.d=linuxfoundation.org
 header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg
 header.b=kvzkpRTa
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 2CTuRJL9jeb0
 for <virtualization@lists.linux-foundation.org>;
 Tue, 16 Aug 2022 09:49:09 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org D3CB860AAA
Received: from dfw.source.kernel.org (dfw.source.kernel.org
 [IPv6:2604:1380:4641:c500::1])
 by smtp3.osuosl.org (Postfix) with ESMTPS id D3CB860AAA
 for <virtualization@lists.linux-foundation.org>;
 Tue, 16 Aug 2022 09:49:08 +0000 (UTC)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id B82B5612C5;
 Tue, 16 Aug 2022 09:49:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 95EF6C433D6;
 Tue, 16 Aug 2022 09:49:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
 s=korg; t=1660643347;
 bh=WWioMFcNN2dl6v/4lVUXRRr6/HAg8tayDniICrS0uxU=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=kvzkpRTafvVeoPO+7cPSAY6Uej/op8RJyCJ8jozt/xYS5fNGR+xr3CcQJhX2dpgBY
 WPp7R0fKWb7iPGFrT5G3H8lNnacaR4JyLzc/U23JgfFKV0ZY3AvvVDmKxBqYTqLykJ
 iFosH5ieKzNaIr+2sEJVQBgOFZi7/CN6+bm334Mk=
Date: Tue, 16 Aug 2022 11:49:03 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Alexander Atanasov <alexander.atanasov@virtuozzo.com>
Subject: Re: [PATCH v2 1/4] Make place for common balloon code
Message-ID: <YvtoDxvefWUJBfAS@kroah.com>
References: <20220816094117.3144881-1-alexander.atanasov@virtuozzo.com>
 <20220816094117.3144881-2-alexander.atanasov@virtuozzo.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20220816094117.3144881-2-alexander.atanasov@virtuozzo.com>
Cc: Arnd Bergmann <arnd@arndb.de>, "Michael S. Tsirkin" <mst@redhat.com>,
 VMware PV-Drivers Reviewers <pv-drivers@vmware.com>,
 Michael Ellerman <mpe@ellerman.id.au>, linux-kernel@vger.kernel.org,
 Christophe Leroy <christophe.leroy@csgroup.eu>,
 virtualization@lists.linux-foundation.org, linux-mm@kvack.org,
 Nadav Amit <namit@vmware.com>, Nicholas Piggin <npiggin@gmail.com>,
 kernel@openvz.org, Andrew Morton <akpm@linux-foundation.org>,
 linuxppc-dev@lists.ozlabs.org
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

On Tue, Aug 16, 2022 at 12:41:14PM +0300, Alexander Atanasov wrote:
> File already contains code that is common along balloon
> drivers so rename it to reflect its contents.
> mm/balloon_compaction.c -> mm/balloon_common.c
> 
> Signed-off-by: Alexander Atanasov <alexander.atanasov@virtuozzo.com>
> ---
>  MAINTAINERS                                              | 4 ++--
>  arch/powerpc/platforms/pseries/cmm.c                     | 2 +-
>  drivers/misc/vmw_balloon.c                               | 2 +-
>  drivers/virtio/virtio_balloon.c                          | 2 +-
>  include/linux/{balloon_compaction.h => balloon_common.h} | 2 +-
>  mm/Makefile                                              | 2 +-
>  mm/{balloon_compaction.c => balloon_common.c}            | 4 ++--
>  mm/migrate.c                                             | 2 +-
>  mm/vmscan.c                                              | 2 +-
>  9 files changed, 11 insertions(+), 11 deletions(-)
>  rename include/linux/{balloon_compaction.h => balloon_common.h} (99%)

Why rename the .h file?  It still handles the "balloon compaction"
logic.

thanks,

greg k-h
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
