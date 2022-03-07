Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B16A9C433F5
	for <virtualization@archiver.kernel.org>; Mon,  7 Mar 2022 19:47:11 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 6D2A560B5E;
	Mon,  7 Mar 2022 19:47:11 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id BZg6rVk1I6py; Mon,  7 Mar 2022 19:47:10 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 1E68960EAD;
	Mon,  7 Mar 2022 19:47:10 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id D7AF8C001D;
	Mon,  7 Mar 2022 19:47:09 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 2794BC000B
 for <virtualization@lists.linux-foundation.org>;
 Mon,  7 Mar 2022 19:47:09 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 15D74828DA
 for <virtualization@lists.linux-foundation.org>;
 Mon,  7 Mar 2022 19:47:09 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=kernel.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id uHy8eTbA_t0w
 for <virtualization@lists.linux-foundation.org>;
 Mon,  7 Mar 2022 19:47:08 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from ams.source.kernel.org (ams.source.kernel.org
 [IPv6:2604:1380:4601:e00::1])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 338A982894
 for <virtualization@lists.linux-foundation.org>;
 Mon,  7 Mar 2022 19:47:08 +0000 (UTC)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ams.source.kernel.org (Postfix) with ESMTPS id 797A9B816F6;
 Mon,  7 Mar 2022 19:47:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 14AEAC340EB;
 Mon,  7 Mar 2022 19:47:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1646682425;
 bh=wnIHskNDTiWGuOn6SMaYqSAfatEdRhyYgNpNgobbHFg=;
 h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
 b=ME+em3BSiR0V3FiDLe4WlgPoSBcGC5qCbMxstPVPpqdaXAJ9gmiJ/5b6WYrz4sNap
 i4yWmarXYDCLjAR80lOqZpiVxDCOvblwtuvkD8gL17u6GXmvVlI1tshXwKc/DuaSvb
 cFUmPID2TY5IeTJA/8KOguIb7D1NyF9l6sqsydRbAcIHhZuAqtf4xZGZ/Xi9pJxm3l
 0bxYxmFUhN13/KVSwxpjB9Xku1Nrx46QgTke1sgSVHYss2DEo+urvBx/QcPbz4c9yk
 S7ZTTXyL7lIqPkAV/Lm6GDy7t1+dCBlB6KXciLdS3qwbNvN++xa/TC6fJr+G4F7vtN
 FKxixISfsWJ0Q==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org
 (localhost.localdomain [127.0.0.1])
 by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id
 F2B9CE6D3DE; Mon,  7 Mar 2022 19:47:04 +0000 (UTC)
Subject: Re: [GIT PULL] virtio: last minute fixes
From: pr-tracker-bot@kernel.org
In-Reply-To: <20220307060332-mutt-send-email-mst@kernel.org>
References: <20220307060332-mutt-send-email-mst@kernel.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20220307060332-mutt-send-email-mst@kernel.org>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/mst/vhost.git tags/for_linus
X-PR-Tracked-Commit-Id: 3dd7d135e75cb37c8501ba02977332a2a487dd39
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 06be3029703fed2099b7247c527ab70d75255178
Message-Id: <164668242498.29310.4137734389077787873.pr-tracker-bot@kernel.org>
Date: Mon, 07 Mar 2022 19:47:04 +0000
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: wang.yi59@zte.com.cn, zhang.min9@zte.com.cn, lkp@intel.com,
 kvm@vger.kernel.org, netdev@vger.kernel.org, mst@redhat.com,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org,
 virtualization@lists.linux-foundation.org, pasic@linux.ibm.com,
 xieyongji@bytedance.com, mail@anirudhrb.com, si-wei.liu@oracle.com,
 syzbot+0abd373e2e50d704db87@syzkaller.appspotmail.com,
 Linus Torvalds <torvalds@linux-foundation.org>, dan.carpenter@oracle.com
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

The pull request you sent on Mon, 7 Mar 2022 06:03:32 -0500:

> https://git.kernel.org/pub/scm/linux/kernel/git/mst/vhost.git tags/for_linus

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/06be3029703fed2099b7247c527ab70d75255178

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
