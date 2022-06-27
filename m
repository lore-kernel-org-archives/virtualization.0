Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5E797CCA47E
	for <virtualization@archiver.kernel.org>; Mon, 27 Jun 2022 18:03:27 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id F3EF983FC8;
	Mon, 27 Jun 2022 18:03:25 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org F3EF983FC8
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=JRS+N/Nz
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id i4YYzJ5jfkHT; Mon, 27 Jun 2022 18:03:25 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 98B4383298;
	Mon, 27 Jun 2022 18:03:24 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 98B4383298
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 5FF3DC0039;
	Mon, 27 Jun 2022 18:03:24 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id B4DD7C002D
 for <virtualization@lists.linux-foundation.org>;
 Mon, 27 Jun 2022 18:03:23 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 8613D83F73
 for <virtualization@lists.linux-foundation.org>;
 Mon, 27 Jun 2022 18:03:23 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 8613D83F73
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id E3NX8uxMLoJK
 for <virtualization@lists.linux-foundation.org>;
 Mon, 27 Jun 2022 18:03:21 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 7974783F44
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 7974783F44
 for <virtualization@lists.linux-foundation.org>;
 Mon, 27 Jun 2022 18:03:21 +0000 (UTC)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id A8B616152A;
 Mon, 27 Jun 2022 18:03:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 15880C341CA;
 Mon, 27 Jun 2022 18:03:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1656353000;
 bh=8B9WkefZfZA95pa9NIMzvxZQv+FB3th3Osx2mBStgjs=;
 h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
 b=JRS+N/Nz3GnX/u7TUbD2YKMzIqIu+lKys5NY3gy/AKgRcFr9X1xPk5XpK5c2+p6+P
 8DnrLpZqc54w2zUWuFWuli/FnXQaAxofH4JWWP2KRu3/sgl+cH+NG5VKCwB/Mg8PmQ
 6SgAdkHhLsBuoG664cK9Y+biw1kMBUc4R1EIO40sASIWL/OtEzbuWBRCuCDYYitMPe
 c40+cE9+I4d0gqaR9Mer9xBpP7UJDbECwVNTOB8gKEdgmSnhrSsqUDqoE0WXzn4FDy
 0Sf1LYaGRkaPGMlBlDaoJ8KNSs4k4ONQGMo1lKVYY21hJF10+PpJt9bJcMBQ1OlIkU
 a2N/4j9acdt1Q==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org
 (localhost.localdomain [127.0.0.1])
 by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id
 F35DCE49BBA; Mon, 27 Jun 2022 18:03:19 +0000 (UTC)
Subject: Re: [GIT PULL] virtio,vdpa: fixes
From: pr-tracker-bot@kernel.org
In-Reply-To: <20220627115024-mutt-send-email-mst@kernel.org>
References: <20220627115024-mutt-send-email-mst@kernel.org>
X-PR-Tracked-List-Id: Linux virtualization
 <virtualization.lists.linux-foundation.org>
X-PR-Tracked-Message-Id: <20220627115024-mutt-send-email-mst@kernel.org>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/mst/vhost.git tags/for_linus
X-PR-Tracked-Commit-Id: c7cc29aaebf9eaa543b4c70801e0ecef1101b3c8
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 941e3e7912696b9fbe3586083a7c2e102cee7a87
Message-Id: <165635299998.10755.3182599712207525309.pr-tracker-bot@kernel.org>
Date: Mon, 27 Jun 2022 18:03:19 +0000
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: kvm@vger.kernel.org, mst@redhat.com, huangjie.albert@bytedance.com,
 netdev@vger.kernel.org, wangdeming@inspur.com, linux-kernel@vger.kernel.org,
 gautam.dawar@xilinx.com, virtualization@lists.linux-foundation.org,
 eperezma@redhat.com, liubo03@inspur.com, elic@nvidia.com,
 Linus Torvalds <torvalds@linux-foundation.org>,
 stephan.gerhold@kernkonzept.com
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

The pull request you sent on Mon, 27 Jun 2022 11:50:24 -0400:

> https://git.kernel.org/pub/scm/linux/kernel/git/mst/vhost.git tags/for_linus

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/941e3e7912696b9fbe3586083a7c2e102cee7a87

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
