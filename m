Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3B7FCC433F5
	for <virtualization@archiver.kernel.org>; Tue,  5 Apr 2022 17:49:05 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id C90B240898;
	Tue,  5 Apr 2022 17:49:04 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id XGDRbqdbO5vG; Tue,  5 Apr 2022 17:49:04 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 523E640882;
	Tue,  5 Apr 2022 17:49:03 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 1FD50C002C;
	Tue,  5 Apr 2022 17:49:03 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id D8635C0012
 for <virtualization@lists.linux-foundation.org>;
 Tue,  5 Apr 2022 17:49:01 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id B7F3160A73
 for <virtualization@lists.linux-foundation.org>;
 Tue,  5 Apr 2022 17:49:01 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=kernel.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id nZoMuBJ3_23z
 for <virtualization@lists.linux-foundation.org>;
 Tue,  5 Apr 2022 17:49:01 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
 by smtp3.osuosl.org (Postfix) with ESMTPS id E944560A81
 for <virtualization@lists.linux-foundation.org>;
 Tue,  5 Apr 2022 17:49:00 +0000 (UTC)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ams.source.kernel.org (Postfix) with ESMTPS id 377E0B81EE8;
 Tue,  5 Apr 2022 17:48:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id F1934C385A0;
 Tue,  5 Apr 2022 17:48:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1649180937;
 bh=+1O856swZ0z6MyxA17arCGEyqFnENo2NE4LLuIMWiQk=;
 h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
 b=B3i5mDiLzPCFJVHSLcYE8l7AFBLzBhcryxnkLtKhyMA55ds2LiVRcYIJjE8X3a/Dj
 6znJt7exe5G+LbwfrI8FCJTMnQZRNYAkIOvoLAqcPN9KxIzPjngf+ouYVvFdzg7om/
 bPVtTAaV/IE6BC2/ISXh9k4Ec8AI63B9M4iEC2DoqV8QbEZn5nfBdFubMHsS2/FOgC
 QSHRdCvaTHPz4rOiDla75dX/RlEWAi4rR1PuF//fFhPmW64Kc7lQHIWQcGuxXkQ4hN
 rimGX3fA2ZZGw6H4LmdGklbj+rK9AjbU3EBluM/mDkk9Z7FVyIEX/gkEC1J9FJXpNb
 +8qYI1DKgMjfA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org
 (localhost.localdomain [127.0.0.1])
 by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id
 DC033E6D402; Tue,  5 Apr 2022 17:48:56 +0000 (UTC)
Subject: Re: [GIT PULL] virtio: fixes, cleanups
From: pr-tracker-bot@kernel.org
In-Reply-To: <20220404063128-mutt-send-email-mst@kernel.org>
References: <20220404063128-mutt-send-email-mst@kernel.org>
X-PR-Tracked-List-Id: Linux virtualization
 <virtualization.lists.linux-foundation.org>
X-PR-Tracked-Message-Id: <20220404063128-mutt-send-email-mst@kernel.org>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/mst/vhost.git tags/for_linus
X-PR-Tracked-Commit-Id: 1c80cf031e0204fde471558ee40183695773ce13
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 3e732ebf7316ac83e8562db7e64cc68aec390a18
Message-Id: <164918093688.27639.685715483194892648.pr-tracker-bot@kernel.org>
Date: Tue, 05 Apr 2022 17:48:56 +0000
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

The pull request you sent on Mon, 4 Apr 2022 06:31:28 -0400:

> https://git.kernel.org/pub/scm/linux/kernel/git/mst/vhost.git tags/for_linus

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/3e732ebf7316ac83e8562db7e64cc68aec390a18

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
