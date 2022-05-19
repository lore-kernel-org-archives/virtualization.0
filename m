Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AD8B9C433F5
	for <virtualization@archiver.kernel.org>; Thu, 19 May 2022 00:35:26 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 47AEE843E4;
	Thu, 19 May 2022 00:35:26 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id COmEwa63hxay; Thu, 19 May 2022 00:35:25 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 02D5684100;
	Thu, 19 May 2022 00:35:24 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id AD6AAC0032;
	Thu, 19 May 2022 00:35:24 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 80F22C002D
 for <virtualization@lists.linux-foundation.org>;
 Thu, 19 May 2022 00:35:23 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 6F3B7610A4
 for <virtualization@lists.linux-foundation.org>;
 Thu, 19 May 2022 00:35:23 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=kernel.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id czjOGkzQ12se
 for <virtualization@lists.linux-foundation.org>;
 Thu, 19 May 2022 00:35:22 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 8DB4860E8D
 for <virtualization@lists.linux-foundation.org>;
 Thu, 19 May 2022 00:35:22 +0000 (UTC)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ams.source.kernel.org (Postfix) with ESMTPS id 22189B8227E;
 Thu, 19 May 2022 00:35:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id E6465C385A9;
 Thu, 19 May 2022 00:35:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1652920517;
 bh=/Tm11RFlNKmtY2ZepP5yUL0xMrhzGYOVHBkmCUnjqsg=;
 h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
 b=Imtmf12XZ6SN/0fQnIzFMV4ix/W3SoEf9rCkuzXX+1TpPKRliO7krhuH+qi7TYOqp
 oxiyiQv3m4tgvGWGE/16K6GkgMiqi4JJeIL8lSB4ZyGohayb0swXnKy59+p3unEuAH
 BTOQKn2vj5hfqQLmmwYq3ONvtqf6OiZ1lIoUl8LXkqefItK2FVp/KSiVIo5ZswXKZ0
 plu9Kk8R/lvGl/A53gc447sJFo/usYScnOXt0CuQxOqwu5QMiqopnMaBhJ++sbPQLR
 mbeRiqQAHKxtuiSJowv6Vd+DwlM9yyJBSnYJmVHp1Ka5rHOjzDPHCj8WV0Zia9cRKs
 Cm1mCplLYPpNg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org
 (localhost.localdomain [127.0.0.1])
 by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id
 CE8B8F03935; Thu, 19 May 2022 00:35:17 +0000 (UTC)
Subject: Re: [GIT PULL] mlx5: last minute fixup
From: pr-tracker-bot@kernel.org
In-Reply-To: <20220518123304-mutt-send-email-mst@kernel.org>
References: <20220518123304-mutt-send-email-mst@kernel.org>
X-PR-Tracked-List-Id: Linux virtualization
 <virtualization.lists.linux-foundation.org>
X-PR-Tracked-Message-Id: <20220518123304-mutt-send-email-mst@kernel.org>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/mst/vhost.git tags/for_linus
X-PR-Tracked-Commit-Id: acde3929492bcb9ceb0df1270230c422b1013798
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: db1fd3fc06420e983c2854c09f0260a66aa8dcc0
Message-Id: <165292051784.29647.16410056914812712498.pr-tracker-bot@kernel.org>
Date: Thu, 19 May 2022 00:35:17 +0000
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: kvm@vger.kernel.org, mst@redhat.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org,
 elic@nvidia.com, Linus Torvalds <torvalds@linux-foundation.org>
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

The pull request you sent on Wed, 18 May 2022 12:33:04 -0400:

> https://git.kernel.org/pub/scm/linux/kernel/git/mst/vhost.git tags/for_linus

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/db1fd3fc06420e983c2854c09f0260a66aa8dcc0

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
