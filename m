Return-Path: <SRS0=J2aX=NH=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA37CC4338F
	for <virtualization@archiver.kernel.org>; Mon, 16 Aug 2021 16:40:42 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5E6E760FD7
	for <virtualization@archiver.kernel.org>; Mon, 16 Aug 2021 16:40:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 5E6E760FD7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 2552640290;
	Mon, 16 Aug 2021 16:40:42 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id NZ5HETmSYEdi; Mon, 16 Aug 2021 16:40:38 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 8B7A24023B;
	Mon, 16 Aug 2021 16:40:37 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 504A7C0010;
	Mon, 16 Aug 2021 16:40:37 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id F22A8C000E
 for <virtualization@lists.linux-foundation.org>;
 Mon, 16 Aug 2021 16:40:35 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id E16DA6073B
 for <virtualization@lists.linux-foundation.org>;
 Mon, 16 Aug 2021 16:40:35 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=kernel.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id RI8uYzaTgFI1
 for <virtualization@lists.linux-foundation.org>;
 Mon, 16 Aug 2021 16:40:35 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 3718860633
 for <virtualization@lists.linux-foundation.org>;
 Mon, 16 Aug 2021 16:40:35 +0000 (UTC)
Received: by mail.kernel.org (Postfix) with ESMTPS id BD79F60BD3;
 Mon, 16 Aug 2021 16:40:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1629132034;
 bh=A1t/Z5jL6guB6cSSzNC8PKIYow9T3ryW5fNaPG350RM=;
 h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
 b=DELH67EHML32fwu3iniCKLvZcMJyOtGrAm24p0wtsGlP1Lit8knMIDfsst0vurXCh
 d5R48IPdFycnOwahpVois64EO7PI2DPCEzL+c5XSfIue1QBAhrDqbUOrsqDsmwRbHM
 clnSbtV4xVjvC/g58MCVfnOzm9OkAaTjJ15gMg+YjekVNXLHVBGbBOFPYQUldLFVNT
 K6pGDjKPw4jdBZUD1Rw9iJHz9ZIsgOBBHx7QXxmt/71Fe2VLCedPlbVT39/T5vKIdv
 MrKTg2bhhQGKU8+zq3carA6bb19Vu9YJ6r9HN7pGkaL+83R3lCqPVvFXJODLuEzMYN
 RuMnIrtcYmKPA==
Subject: Re: [GIT PULL] virtio,vhost,vdpa: bugfixes
From: pr-tracker-bot@kernel.org
In-Reply-To: <20210816005054-mutt-send-email-mst@kernel.org>
References: <20210816005054-mutt-send-email-mst@kernel.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20210816005054-mutt-send-email-mst@kernel.org>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/mst/vhost.git tags/for_linus
X-PR-Tracked-Commit-Id: 879753c816dbbdb2a9a395aa4448d29feee92d1a
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 94e95d58997f5234aec02f0eba92ee215b787065
Message-Id: <162913203472.19716.9875992701958753677.pr-tracker-bot@kernel.org>
Date: Mon, 16 Aug 2021 16:40:34 +0000
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: kvm@vger.kernel.org, mst@redhat.com, netdev@vger.kernel.org,
 vincent.whitchurch@axis.com, linux-kernel@vger.kernel.org,
 virtualization@lists.linux-foundation.org, xieyongji@bytedance.com,
 elic@nvidia.com, Linus Torvalds <torvalds@linux-foundation.org>,
 neeraju@codeaurora.org, dan.carpenter@oracle.com
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

The pull request you sent on Mon, 16 Aug 2021 00:50:54 -0400:

> https://git.kernel.org/pub/scm/linux/kernel/git/mst/vhost.git tags/for_linus

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/94e95d58997f5234aec02f0eba92ee215b787065

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
