Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5E0D4C43334
	for <virtualization@archiver.kernel.org>; Sun, 12 Jun 2022 00:33:47 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id DC4C26119E;
	Sun, 12 Jun 2022 00:33:46 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ltbeAP8pj-vZ; Sun, 12 Jun 2022 00:33:46 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 74FA8611BD;
	Sun, 12 Jun 2022 00:33:45 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 4A8C5C0039;
	Sun, 12 Jun 2022 00:33:45 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 0973CC002D
 for <virtualization@lists.linux-foundation.org>;
 Sun, 12 Jun 2022 00:33:44 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id DC50C611BD
 for <virtualization@lists.linux-foundation.org>;
 Sun, 12 Jun 2022 00:33:43 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id r62mg025nyPN
 for <virtualization@lists.linux-foundation.org>;
 Sun, 12 Jun 2022 00:33:42 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
 by smtp3.osuosl.org (Postfix) with ESMTPS id E9E4B6119E
 for <virtualization@lists.linux-foundation.org>;
 Sun, 12 Jun 2022 00:33:41 +0000 (UTC)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id CC7056132A;
 Sun, 12 Jun 2022 00:33:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 368F6C34116;
 Sun, 12 Jun 2022 00:33:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1654994020;
 bh=YK+v++7aHXh6ZVsNGPhoQ32la+K/dqkHHmiEfw1ISHg=;
 h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
 b=Hh6uL5u9xn3vFbB7R+vcU+f8l+A2htz8iUC8hP7V9VGu2rmdOC8N8sZ8oXs3LK42M
 QNj0xZyYREMyzdCEYboJOaCxEWkEYZ8JD1ElOEENCEYqGb74xgiTdg1EY4odTQdwbc
 zBGbR+qS0GadrEnC1JQni46mScY/n01yG/I5hmjWcQOpgtc9jl2cInzhZtVmY3uT+1
 T3p0S2BKDXu/6cIeXcdsInzM+bvvTbkcTsJGvm9yMzNZzQl1hJgVlBvwdGNYXeL2t8
 sDGoRWACJMAVz2yoaga6ZP0+Ionzq3Z1viWp7C2+e0X+aPLneP25IKXDRwAjQq3n3l
 5WObU+CphcP4Q==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org
 (localhost.localdomain [127.0.0.1])
 by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id
 2315FE737F0; Sun, 12 Jun 2022 00:33:40 +0000 (UTC)
Subject: Re: [GIT PULL] virtio,vdpa: fixes
From: pr-tracker-bot@kernel.org
In-Reply-To: <20220611034848-mutt-send-email-mst@kernel.org>
References: <20220611034848-mutt-send-email-mst@kernel.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20220611034848-mutt-send-email-mst@kernel.org>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/mst/vhost.git tags/for_linus
X-PR-Tracked-Commit-Id: eacea844594ff338db06437806707313210d4865
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: abe71eb32f3051f461d2975c674c0857549d0b93
Message-Id: <165499402013.23172.7490053891155613764.pr-tracker-bot@kernel.org>
Date: Sun, 12 Jun 2022 00:33:40 +0000
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: xieyongji@bytedance.com, wangxiang@cdjrlc.com, pilgrimtao@gmail.com,
 kvm@vger.kernel.org, mst@redhat.com, netdev@vger.kernel.org,
 vincent.whitchurch@axis.com, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org, virtualization@lists.linux-foundation.org,
 johannes@sipsolutions.net, oliver.sang@intel.com, liubo03@inspur.com,
 fam.zheng@bytedance.com, elic@nvidia.com,
 Linus Torvalds <torvalds@linux-foundation.org>, gautam.dawar@xilinx.com,
 dan.carpenter@oracle.com,
 syzbot+5b59d6d459306a556f54@syzkaller.appspotmail.com
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

The pull request you sent on Sat, 11 Jun 2022 03:48:48 -0400:

> https://git.kernel.org/pub/scm/linux/kernel/git/mst/vhost.git tags/for_linus

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/abe71eb32f3051f461d2975c674c0857549d0b93

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
