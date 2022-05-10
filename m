Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 282C6C433F5
	for <virtualization@archiver.kernel.org>; Tue, 10 May 2022 01:04:11 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id BF46760D74;
	Tue, 10 May 2022 01:04:10 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id hYmxksAZJONc; Tue, 10 May 2022 01:04:07 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 69BA160B17;
	Tue, 10 May 2022 01:04:06 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 46708C0039;
	Tue, 10 May 2022 01:04:06 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 1B2EFC002D
 for <virtualization@lists.linux-foundation.org>;
 Tue, 10 May 2022 01:04:05 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 0206A60D74
 for <virtualization@lists.linux-foundation.org>;
 Tue, 10 May 2022 01:04:05 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id hR5h8_2Smrlf
 for <virtualization@lists.linux-foundation.org>;
 Tue, 10 May 2022 01:04:03 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
 by smtp3.osuosl.org (Postfix) with ESMTPS id A60F460B17
 for <virtualization@lists.linux-foundation.org>;
 Tue, 10 May 2022 01:04:03 +0000 (UTC)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ams.source.kernel.org (Postfix) with ESMTPS id 25566B81A13;
 Tue, 10 May 2022 01:03:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 763C0C385C2;
 Tue, 10 May 2022 01:03:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
 s=korg; t=1652144637;
 bh=aQB+EIItZRmuzbO4IcL2oBYPBcYCUUntWM5wji7KkFc=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=Mu8TGd39OAW4aZVLqxOVW1+zcH/47f1GRgIZ/HnfOCz1j48b31nMyGpuyUtCbKyPU
 h+2mwCSfI5byIFCiq5b40sTsONdFq8eCK4TG9UXSAeP2XqeWYsuFO278Bn/FXjC1/O
 1HW8ebntV6+ARDkp2oimhDmFMik1yBxUnNuhTgdY=
Date: Mon, 9 May 2022 18:03:56 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Zi Yan <ziy@nvidia.com>
Subject: Re: [PATCH v11 0/6] Use pageblock_order for cma and
 alloc_contig_range alignment.
Message-Id: <20220509180356.24ff0403cf3ffc3fd01ffe98@linux-foundation.org>
In-Reply-To: <20220425143118.2850746-1-zi.yan@sent.com>
References: <20220425143118.2850746-1-zi.yan@sent.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Cc: linux-kernel@vger.kernel.org,
 Christophe Leroy <christophe.leroy@csgroup.eu>,
 virtualization@lists.linux-foundation.org, linux-mm@kvack.org,
 Mike Rapoport <rppt@kernel.org>, Eric Ren <renzhengeek@gmail.com>,
 Zi Yan <zi.yan@sent.com>, Mel Gorman <mgorman@techsingularity.net>,
 Vlastimil Babka <vbabka@suse.cz>, Oscar Salvador <osalvador@suse.de>
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

On Mon, 25 Apr 2022 10:31:12 -0400 Zi Yan <zi.yan@sent.com> wrote:

> This patchset tries to remove the MAX_ORDER-1 alignment requirement for CMA
> and alloc_contig_range(). It prepares for my upcoming changes to make
> MAX_ORDER adjustable at boot time[1].

I'm thinking this looks ready to be merged into mm-stable later this week, for
the 5.19-rc1 merge window.

I believe the build error at
https://lkml.kernel.org/r/CA+G9fYveMF-NU-rvrsbaora2g2QWxrkF7AWViuDrJyN9mNScJg@mail.gmail.com
was addressed in ARM?

I have one -fix to be squashed,
https://git.kernel.org/pub/scm/linux/kernel/git/akpm/25-new.git/tree/patches/mm-make-alloc_contig_range-work-at-pageblock-granularity-fix.patch

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
