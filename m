Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 77B0BC4332F
	for <virtualization@archiver.kernel.org>; Thu, 31 Mar 2022 21:21:48 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 2684E41140;
	Thu, 31 Mar 2022 21:21:48 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id xW9gAH4oeIxX; Thu, 31 Mar 2022 21:21:47 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id BF1994015A;
	Thu, 31 Mar 2022 21:21:46 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 979EFC002C;
	Thu, 31 Mar 2022 21:21:46 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 78348C0012
 for <virtualization@lists.linux-foundation.org>;
 Thu, 31 Mar 2022 21:21:45 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 65A5E60FA6
 for <virtualization@lists.linux-foundation.org>;
 Thu, 31 Mar 2022 21:21:45 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=kernel.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id CAY_4fHDKwJ6
 for <virtualization@lists.linux-foundation.org>;
 Thu, 31 Mar 2022 21:21:44 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 98F3260AB0
 for <virtualization@lists.linux-foundation.org>;
 Thu, 31 Mar 2022 21:21:44 +0000 (UTC)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ams.source.kernel.org (Postfix) with ESMTPS id CB824B82246;
 Thu, 31 Mar 2022 21:21:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 7EA7FC340EE;
 Thu, 31 Mar 2022 21:21:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1648761700;
 bh=SWQTQYUOdaI/V43RFd409qVyPmra5Qem+nxS4qg9Uhc=;
 h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
 b=RC2etaL/g3tJBiYTMXy/jZKUXqxU56cI0ZDjY+lMJ0GY1Ic+Mt1aF7ERw2hzczb3p
 RyfJd9NN25nC1971kdvqEAZKgIDYpFkYE1m9Hzkex92oG74LMstosaHCJCHxcfpNpy
 vKeD03PpxIDm8Ag6SJEfqRymhEQ9H9Yx1Q935cX0iLffaK/QvGNooHxR9N52JMq1J8
 XJ9S0EZsBbtmmRLWOnIu25hte6fti8hGe/0Pwjxra628U+trb5brnVjTgQw0j2QUDO
 4Le3nHF3OkfZmMTKy0UOWrS4yEjiiMG8++vyrJRSiqJ8zYzimtEXNYjfweoJS7is8i
 2NerK/c+1PCVA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org
 (localhost.localdomain [127.0.0.1])
 by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id
 66CCEE7BB0B; Thu, 31 Mar 2022 21:21:40 +0000 (UTC)
Subject: Re: [GIT PULL] virtio: features, fixes
From: pr-tracker-bot@kernel.org
In-Reply-To: <20220331094816-mutt-send-email-mst@kernel.org>
References: <20220331094816-mutt-send-email-mst@kernel.org>
X-PR-Tracked-List-Id: Linux virtualization
 <virtualization.lists.linux-foundation.org>
X-PR-Tracked-Message-Id: <20220331094816-mutt-send-email-mst@kernel.org>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/mst/vhost.git tags/for_linus
X-PR-Tracked-Commit-Id: ad6dc1daaf29f97f23cc810d60ee01c0e83f4c6b
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: f4f5d7cfb2e57fafd12dabd971b892f83ce02bfe
Message-Id: <164876170041.29828.8239348717589894864.pr-tracker-bot@kernel.org>
Date: Thu, 31 Mar 2022 21:21:40 +0000
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: linmiaohe@huawei.com, andrew@daynix.com, kvm@vger.kernel.org,
 mst@redhat.com, trix@redhat.com, keirf@google.com,
 virtualization@lists.linux-foundation.org, mail@anirudhrb.com,
 pizhenwei@bytedance.com, elic@nvidia.com, helei.sig11@bytedance.com,
 maz@kernel.org, willy@infradead.org, longpeng2@huawei.com, gdawar@xilinx.com,
 nathan@kernel.org, qiudayu@archeros.com, Jonathan.Cameron@huawei.com,
 gautam.dawar@xilinx.com, lkp@intel.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, lingshan.zhu@intel.com,
 Linus Torvalds <torvalds@linux-foundation.org>
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
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

The pull request you sent on Thu, 31 Mar 2022 09:48:16 -0400:

> https://git.kernel.org/pub/scm/linux/kernel/git/mst/vhost.git tags/for_linus

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/f4f5d7cfb2e57fafd12dabd971b892f83ce02bfe

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
