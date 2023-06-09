Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 106EAC7EE29
	for <virtualization@archiver.kernel.org>; Fri,  9 Jun 2023 18:19:05 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 66DA74247A;
	Fri,  9 Jun 2023 18:19:05 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 66DA74247A
Authentication-Results: smtp4.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=Rw3Aukwf
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id HucC3QsCc6tZ; Fri,  9 Jun 2023 18:19:04 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 9717342473;
	Fri,  9 Jun 2023 18:19:03 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 9717342473
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 5E4D6C007A;
	Fri,  9 Jun 2023 18:19:03 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id C456DC0029
 for <virtualization@lists.linux-foundation.org>;
 Fri,  9 Jun 2023 18:19:02 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 8B79260D59
 for <virtualization@lists.linux-foundation.org>;
 Fri,  9 Jun 2023 18:19:02 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 8B79260D59
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.a=rsa-sha256 header.s=k20201202 header.b=Rw3Aukwf
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id joq_QANxAONR
 for <virtualization@lists.linux-foundation.org>;
 Fri,  9 Jun 2023 18:19:01 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org A466560BEB
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
 by smtp3.osuosl.org (Postfix) with ESMTPS id A466560BEB
 for <virtualization@lists.linux-foundation.org>;
 Fri,  9 Jun 2023 18:19:01 +0000 (UTC)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id DFACE61C81;
 Fri,  9 Jun 2023 18:19:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 4AF09C433EF;
 Fri,  9 Jun 2023 18:19:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1686334740;
 bh=uZgP+KaADG5C3bWQksf0EHSMXqaMfIjehJbNAS9l1os=;
 h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
 b=Rw3AukwfoCqsTNddSOskF7q3/FceE9NTnzzCMdQyqPwqR7+O3GGTodz3NX+9ki09J
 jvyjttN9aavZqHqULdRwfMx/yS+MFJ+kJGruk5roxb/mSpsPeaxrd4m5z4oHgCdqyJ
 5gBCw8LrHUF7aRBtMQXk/9SSYj6824Y0V22vkRtBsoZgHdb3GCG0+qsAVfvMlk6n62
 vlULvfeB+CihBxFkC4ULT3fSv/JAF/2SEOGHTHtvj7jjTnfy3NAUsKhG/TDutEEx5q
 V79gkjKjF2wPWCNvKkierWhpglobOi4AZSgetJoWUjwlZLKwV63Yi5jsqSYDuKzBjS
 Aw1oyS3EGaTUg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org
 (localhost.localdomain [127.0.0.1])
 by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id
 3295CC395F3; Fri,  9 Jun 2023 18:19:00 +0000 (UTC)
Subject: Re: [GIT PULL] virtio,vhost,vdpa: bugfixes
From: pr-tracker-bot@kernel.org
In-Reply-To: <20230609121737-mutt-send-email-mst@kernel.org>
References: <20230609121737-mutt-send-email-mst@kernel.org>
X-PR-Tracked-List-Id: Linux virtualization
 <virtualization.lists.linux-foundation.org>
X-PR-Tracked-Message-Id: <20230609121737-mutt-send-email-mst@kernel.org>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/mst/vhost.git tags/for_linus
X-PR-Tracked-Commit-Id: 07496eeab577eef1d4912b3e1b502a2b52002ac3
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: dbfa18c5d7695766f24c0c140204e1f8c921fb95
Message-Id: <168633474019.10395.11484571179409071436.pr-tracker-bot@kernel.org>
Date: Fri, 09 Jun 2023 18:19:00 +0000
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: zengxianjun@bytedance.com, kvm@vger.kernel.org, mst@redhat.com,
 netdev@vger.kernel.org, zwisler@google.com,
 syzbot+d0d442c22fa8db45ff0e@syzkaller.appspotmail.com,
 linux-kernel@vger.kernel.org, xieyongji@bytedance.com,
 asmetanin@yandex-team.ru, prathubaronia2011@gmail.com, zwisler@chromium.org,
 sheng.zhao@bytedance.com, Linus Torvalds <torvalds@linux-foundation.org>,
 virtualization@lists.linux-foundation.org, rongtao@cestc.cn
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

The pull request you sent on Fri, 9 Jun 2023 12:17:37 -0400:

> https://git.kernel.org/pub/scm/linux/kernel/git/mst/vhost.git tags/for_linus

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/dbfa18c5d7695766f24c0c140204e1f8c921fb95

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
