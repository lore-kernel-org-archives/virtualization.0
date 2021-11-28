Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4BC65C433EF
	for <virtualization@archiver.kernel.org>; Sun, 28 Nov 2021 20:03:29 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id C470940265;
	Sun, 28 Nov 2021 20:03:28 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id RophA3a6HZQo; Sun, 28 Nov 2021 20:03:27 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 4AA6240140;
	Sun, 28 Nov 2021 20:03:27 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 18292C001C;
	Sun, 28 Nov 2021 20:03:27 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 57221C000A
 for <virtualization@lists.linux-foundation.org>;
 Sun, 28 Nov 2021 20:03:25 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 42DB6403B4
 for <virtualization@lists.linux-foundation.org>;
 Sun, 28 Nov 2021 20:03:25 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=kernel.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id KlsjV7jPNLLk
 for <virtualization@lists.linux-foundation.org>;
 Sun, 28 Nov 2021 20:03:24 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 2A6514033F
 for <virtualization@lists.linux-foundation.org>;
 Sun, 28 Nov 2021 20:03:24 +0000 (UTC)
Received: from mail.kernel.org (unknown [198.145.29.99])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id 2578E61123;
 Sun, 28 Nov 2021 20:03:22 +0000 (UTC)
Received: by mail.kernel.org (Postfix) with ESMTPS id 8B6C160041;
 Sun, 28 Nov 2021 20:03:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1638129801;
 bh=fYzzj/FusNSnStGNweaI1Lw8LCCnN3s3U2QDq7fynns=;
 h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
 b=hnHAXLGBgmVZhy/VoZyzTYKSEtw0/KzamE2erN0j33Uuv8MypNvJrP7NOojYeW9er
 9+qgvQ9dIWyDEssNjBom/Vr14xOlJ9cqElPhxDqJ7elngZgOZnpMXd691lIcgR3E/6
 f/GnNYeoc9i99mRodn52mx6dsCrxOjsSWVXzo6OWMx3nEQ1pgcMx8Cz8zipm3j+zrn
 ppXae04LUIO8/xL8647OU+Yn58lXux+mmitmW1sYg3b7vc7Fhs1JaNCV16roq86ipx
 gOHV6UJ/gopotAUpJ81r0fp/LSNdFsx0TA+pUnDoteqUbNc9xlxwBn1rYbAe7tc2Yj
 eBkj2UrkwZDuQ==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain
 [127.0.0.1])
 by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id 7A64E609DB;
 Sun, 28 Nov 2021 20:03:21 +0000 (UTC)
Subject: Re: [GIT PULL] vhost,virtio,vdpa: bugfixes
From: pr-tracker-bot@kernel.org
In-Reply-To: <20211128125803-mutt-send-email-mst@kernel.org>
References: <20211128125803-mutt-send-email-mst@kernel.org>
X-PR-Tracked-List-Id: <kvm.vger.kernel.org>
X-PR-Tracked-Message-Id: <20211128125803-mutt-send-email-mst@kernel.org>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/mst/vhost.git tags/for_linus
X-PR-Tracked-Commit-Id: bb93ce4b150dde79f58e34103cbd1fe829796649
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: d06c942efea40e1701ade200477a7449008d9f24
Message-Id: <163812980144.10783.3903876021175664187.pr-tracker-bot@kernel.org>
Date: Sun, 28 Nov 2021 20:03:21 +0000
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: kvm@vger.kernel.org, mst@redhat.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org,
 virtualization@lists.linux-foundation.org, pasic@linux.ibm.com,
 wuzongyong@linux.alibaba.com, ye.guojin@zte.com.cn, longpeng2@huawei.com,
 Linus Torvalds <torvalds@linux-foundation.org>, zealci@zte.com.cn
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

The pull request you sent on Sun, 28 Nov 2021 12:58:03 -0500:

> https://git.kernel.org/pub/scm/linux/kernel/git/mst/vhost.git tags/for_linus

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/d06c942efea40e1701ade200477a7449008d9f24

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
