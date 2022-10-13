Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A0B44C433FE
	for <virtualization@archiver.kernel.org>; Thu, 13 Oct 2022 18:00:18 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 1E63D40CDC;
	Thu, 13 Oct 2022 18:00:18 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 1E63D40CDC
Authentication-Results: smtp2.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=MJwKEsc2
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id A5bH0jS8do4J; Thu, 13 Oct 2022 18:00:17 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 8E95B40158;
	Thu, 13 Oct 2022 18:00:16 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 8E95B40158
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 5B01CC0032;
	Thu, 13 Oct 2022 18:00:16 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 80E32C002D
 for <virtualization@lists.linux-foundation.org>;
 Thu, 13 Oct 2022 18:00:14 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 5204583E73
 for <virtualization@lists.linux-foundation.org>;
 Thu, 13 Oct 2022 18:00:14 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 5204583E73
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.a=rsa-sha256 header.s=k20201202 header.b=MJwKEsc2
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 8X7WBUu6BwPi
 for <virtualization@lists.linux-foundation.org>;
 Thu, 13 Oct 2022 18:00:13 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 5F35C83E72
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 5F35C83E72
 for <virtualization@lists.linux-foundation.org>;
 Thu, 13 Oct 2022 18:00:13 +0000 (UTC)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ams.source.kernel.org (Postfix) with ESMTPS id AA4D5B82059;
 Thu, 13 Oct 2022 18:00:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 7464AC433C1;
 Thu, 13 Oct 2022 18:00:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1665684009;
 bh=Fe7d0Zn2chLLmPzOexN099gWKHr/nuc+bPn9sa6xGrE=;
 h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
 b=MJwKEsc2KYYmKxjxm9JoAcOBVauyxTd/2m5uQkwKthdphd5Xzj/1AClF9tYju8D/D
 ziw2YWuyhDW45WBiXi3QMsZzAFKB1M+NRJ0yLY8u7mvm5l09yiMnY5jrMstjHwAu/0
 FiM8p5SbdDIPyiAFaeW91lHGcQHr4lakW7vB6L2BMVEFWMff+liyYi/JXP7Qi1FpEN
 SJ/qWbv+BONbGA74qF93cjeRIVbty2GnYEp8coy4wwJZ88qSOYnJrTiBZp9q7v2R6e
 Ka30mIntngJurdepbjH9HIo8FdFFfpyHVHRCG/Pk6Xr/XWeFwG/zLEkw7WmEFOo15d
 cZvBapYzLv+2A==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org
 (localhost.localdomain [127.0.0.1])
 by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id
 57F3AE29F31; Thu, 13 Oct 2022 18:00:09 +0000 (UTC)
Subject: Re: [GIT PULL] virtio: bugfix, reviewer
From: pr-tracker-bot@kernel.org
In-Reply-To: <20221013094021-mutt-send-email-mst@kernel.org>
References: <20221013094021-mutt-send-email-mst@kernel.org>
X-PR-Tracked-List-Id: <kvm.vger.kernel.org>
X-PR-Tracked-Message-Id: <20221013094021-mutt-send-email-mst@kernel.org>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/mst/vhost.git tags/for_linus
X-PR-Tracked-Commit-Id: be8ddea9e75e65b05837f6d51dc5774b866d0bcf
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: d6f04f26e25242898959b1758432e4076fabc0c0
Message-Id: <166568400929.7515.1599489627533192092.pr-tracker-bot@kernel.org>
Date: Thu, 13 Oct 2022 18:00:09 +0000
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: kvm@vger.kernel.org, mst@redhat.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org,
 mpe@ellerman.id.au, angus.chen@jaguarmicro.com, lingshan.zhu@intel.com,
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

The pull request you sent on Thu, 13 Oct 2022 09:40:21 -0400:

> https://git.kernel.org/pub/scm/linux/kernel/git/mst/vhost.git tags/for_linus

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/d6f04f26e25242898959b1758432e4076fabc0c0

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
