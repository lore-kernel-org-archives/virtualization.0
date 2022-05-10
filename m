Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F33D7C43217
	for <virtualization@archiver.kernel.org>; Tue, 10 May 2022 18:31:15 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 99AB240138;
	Tue, 10 May 2022 18:31:15 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 6hcWH5cjZsUS; Tue, 10 May 2022 18:31:14 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 3C51C400A4;
	Tue, 10 May 2022 18:31:14 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 0C9A2C0032;
	Tue, 10 May 2022 18:31:14 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 0A6CFC002D
 for <virtualization@lists.linux-foundation.org>;
 Tue, 10 May 2022 18:31:13 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 06E29417C8
 for <virtualization@lists.linux-foundation.org>;
 Tue, 10 May 2022 18:31:13 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=kernel.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id gptS9UZE43pE
 for <virtualization@lists.linux-foundation.org>;
 Tue, 10 May 2022 18:31:12 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 19C12417C7
 for <virtualization@lists.linux-foundation.org>;
 Tue, 10 May 2022 18:31:11 +0000 (UTC)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id B3B6360C71;
 Tue, 10 May 2022 18:31:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 84BC3C385C2;
 Tue, 10 May 2022 18:31:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1652207470;
 bh=3wbzCdPUumedt6nbcJr9g77t66aOTyWH8eo5PuqqxVE=;
 h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
 b=nqWLoZl9vJr1KxzD/0pITSLnadScln1XYcfvJHAZIQbRzFZxyNXF2qdq9rvW4fOIW
 uWwyzEKfuS1sZJz4aDKYnJDuwu8A/MgS68uHevLpg4tRWFGBQv59Qepf/OyI9/K/BK
 mbV2ktT12rRdF6G/jLDk93cZ4PXsTALmgR1AJR6cn+cyHfm1Aap003PMESq3Vk0XxJ
 n9Xr2DzVrvHX4/aZO+1RR/lLPSFGvV1Q5XoHeMo2IK/mF8C3XascdfRVEjm/xxltcq
 O3pvzzErxiUcIvG0c3SD/V7G9QoJyuTkgx97IPKlTOTKKy/93Bkora1oVyUiCc+OSQ
 +cll+nIMUHuew==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org
 (localhost.localdomain [127.0.0.1])
 by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id
 70595F0392D; Tue, 10 May 2022 18:31:10 +0000 (UTC)
Subject: Re: [GIT PULL] virtio: last minute fixup
From: pr-tracker-bot@kernel.org
In-Reply-To: <20220510082351-mutt-send-email-mst@kernel.org>
References: <20220510082351-mutt-send-email-mst@kernel.org>
X-PR-Tracked-List-Id: <kvm.vger.kernel.org>
X-PR-Tracked-Message-Id: <20220510082351-mutt-send-email-mst@kernel.org>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/mst/vhost.git tags/for_linus
X-PR-Tracked-Commit-Id: 7ff960a6fe399fdcbca6159063684671ae57eee9
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: feb9c5e19e913b53cb536a7aa7c9f20107bb51ec
Message-Id: <165220747045.23919.144863447335101428.pr-tracker-bot@kernel.org>
Date: Tue, 10 May 2022 18:31:10 +0000
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: kvm@vger.kernel.org, mst@redhat.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org,
 mie@igel.co.jp, Linus Torvalds <torvalds@linux-foundation.org>
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

The pull request you sent on Tue, 10 May 2022 08:23:51 -0400:

> https://git.kernel.org/pub/scm/linux/kernel/git/mst/vhost.git tags/for_linus

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/feb9c5e19e913b53cb536a7aa7c9f20107bb51ec

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
