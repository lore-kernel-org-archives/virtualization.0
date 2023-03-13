Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 19D00C74A5B
	for <virtualization@archiver.kernel.org>; Mon, 13 Mar 2023 18:26:08 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 6AF5F60B8C;
	Mon, 13 Mar 2023 18:26:08 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 6AF5F60B8C
Authentication-Results: smtp3.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=NVCzcmIk
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id GHgL7CruYefh; Mon, 13 Mar 2023 18:26:07 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 1B87860ABF;
	Mon, 13 Mar 2023 18:26:07 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 1B87860ABF
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id D6D2DC0035;
	Mon, 13 Mar 2023 18:26:06 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 66A17C0032
 for <virtualization@lists.linux-foundation.org>;
 Mon, 13 Mar 2023 18:26:05 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 3FA8640351
 for <virtualization@lists.linux-foundation.org>;
 Mon, 13 Mar 2023 18:26:05 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 3FA8640351
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.a=rsa-sha256 header.s=k20201202 header.b=NVCzcmIk
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id wGKBMu9ralBc
 for <virtualization@lists.linux-foundation.org>;
 Mon, 13 Mar 2023 18:26:01 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 74040402B8
Received: from ams.source.kernel.org (ams.source.kernel.org
 [IPv6:2604:1380:4601:e00::1])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 74040402B8
 for <virtualization@lists.linux-foundation.org>;
 Mon, 13 Mar 2023 18:26:01 +0000 (UTC)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ams.source.kernel.org (Postfix) with ESMTPS id 96BAFB811CE;
 Mon, 13 Mar 2023 18:25:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 43BD0C4339C;
 Mon, 13 Mar 2023 18:25:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1678731958;
 bh=Ohid4WW4bE1iYiU0aGgJoySObkAyf67Ea/B4BQVbjnM=;
 h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
 b=NVCzcmIkQtJwFPXGDf1dscUZxLiG0m86+OdrIZCilckaLjnWwg0De2/7zTcA69CUL
 HlmRNYuv0qPfguryWWvJgZzyFsQvaEp17XK9wqPDUVp3tiClPn7Yga30ODV9AD5uTA
 fDyVOiqTXpLA5lfUgc4cTaJ7NFmZVfNaPqm7O7fvDmgKftNyH/rv2uJbzh6aHnLmJJ
 7j2YdMuYNS7TSMrbjcK/xyhBs0rOX18mMUurPIVzeD1TvEhWGgcX10CVI/opg76Arv
 bor27gZV4jYEhOZf6uDHZcsbkclDRwRyG6wrGhx9o7NN06GVGBCthfjRYkCbITY9Ns
 fYjkxJgDyNRCw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org
 (localhost.localdomain [127.0.0.1])
 by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id
 2D253C43161; Mon, 13 Mar 2023 18:25:58 +0000 (UTC)
Subject: Re: [GIT PULL] virtio,vhost,vdpa: bugfixes
From: pr-tracker-bot@kernel.org
In-Reply-To: <20230313023139-mutt-send-email-mst@kernel.org>
References: <20230313023139-mutt-send-email-mst@kernel.org>
X-PR-Tracked-List-Id: Linux virtualization
 <virtualization.lists.linux-foundation.org>
X-PR-Tracked-Message-Id: <20230313023139-mutt-send-email-mst@kernel.org>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/mst/vhost.git tags/for_linus
X-PR-Tracked-Commit-Id: ae43c20da2a77c508715a9c77845b4e87e6a1e25
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: fc89d7fb499b0162e081f434d45e8d1b47e82ece
Message-Id: <167873195817.6604.15099339670931730243.pr-tracker-bot@kernel.org>
Date: Mon, 13 Mar 2023 18:25:58 +0000
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: lulu@redhat.com, kvm@vger.kernel.org, mst@redhat.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org,
 virtualization@lists.linux-foundation.org, eperezma@redhat.com,
 leiyang@redhat.com, rongtao@cestc.cn, gautam.dawar@amd.com, elic@nvidia.com,
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

The pull request you sent on Mon, 13 Mar 2023 02:31:39 -0400:

> https://git.kernel.org/pub/scm/linux/kernel/git/mst/vhost.git tags/for_linus

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/fc89d7fb499b0162e081f434d45e8d1b47e82ece

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
