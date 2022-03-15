Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4E818C433F5
	for <virtualization@archiver.kernel.org>; Tue, 15 Mar 2022 17:40:52 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id DECF34170A;
	Tue, 15 Mar 2022 17:40:51 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 6m4JwsHjoB3r; Tue, 15 Mar 2022 17:40:51 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 9188840884;
	Tue, 15 Mar 2022 17:40:50 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 63D33C0012;
	Tue, 15 Mar 2022 17:40:50 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 873D0C000B
 for <virtualization@lists.linux-foundation.org>;
 Tue, 15 Mar 2022 17:40:49 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 64E3F842F8
 for <virtualization@lists.linux-foundation.org>;
 Tue, 15 Mar 2022 17:40:49 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=kernel.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id sxWFLmi-arPm
 for <virtualization@lists.linux-foundation.org>;
 Tue, 15 Mar 2022 17:40:48 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from ams.source.kernel.org (ams.source.kernel.org
 [IPv6:2604:1380:4601:e00::1])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 215A9842F2
 for <virtualization@lists.linux-foundation.org>;
 Tue, 15 Mar 2022 17:40:48 +0000 (UTC)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ams.source.kernel.org (Postfix) with ESMTPS id 4B88BB816D6;
 Tue, 15 Mar 2022 17:40:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 0DBB3C340F4;
 Tue, 15 Mar 2022 17:40:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1647366044;
 bh=rD+17gJMM7JyEghFHY4fbvNf02D4yrV+aRzlaYSEAzo=;
 h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
 b=K8U2+2FCwScxNdJdngA9tTKtkyr7AWwmCXrnKbnYqjj6CsZmwFoddYOTm4YaL8kZ3
 eWJX05yLouDZ6WPaHq9ee+IuaxmAuXY0tQ+5gr3eTf7IXCs8e9wootkXWAtY3ispPv
 r6piu0sS1dFDJPU+ZNotr/mIlOxeGdfIIwVBxuZiSkXSEai2leuaSoKcjlzoxvtQEL
 ou4HIgRLOIf2YeKyQrQGhcvWENcd76nxbd+7ErXaCavp8KHcKGE3FfC3Eln+SobMdF
 UygiEei4QoH+ug6q2V0W4V0xtMzTXEle2YMtEI/QjRjtoFKEiZVFeqLpOIZEZRDMnT
 Z/T72ojyWgUjg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org
 (localhost.localdomain [127.0.0.1])
 by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id
 EB1C6E6D44B; Tue, 15 Mar 2022 17:40:43 +0000 (UTC)
Subject: Re: [GIT PULL] virtio: a last minute regression fix
From: pr-tracker-bot@kernel.org
In-Reply-To: <20220314075951-mutt-send-email-mst@kernel.org>
References: <20220314075951-mutt-send-email-mst@kernel.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20220314075951-mutt-send-email-mst@kernel.org>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/mst/vhost.git tags/for_linus
X-PR-Tracked-Commit-Id: 95932ab2ea07b79cdb33121e2f40ccda9e6a73b5
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 6665ca15746dc34606b5d79fae278a101a368437
Message-Id: <164736604395.1904.10708022196014221360.pr-tracker-bot@kernel.org>
Date: Tue, 15 Mar 2022 17:40:43 +0000
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: kvm@vger.kernel.org, mst@redhat.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org,
 mail@anirudhrb.com, elic@nvidia.com,
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

The pull request you sent on Mon, 14 Mar 2022 07:59:51 -0400:

> https://git.kernel.org/pub/scm/linux/kernel/git/mst/vhost.git tags/for_linus

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/6665ca15746dc34606b5d79fae278a101a368437

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
