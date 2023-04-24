Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 118FBC77B76
	for <virtualization@archiver.kernel.org>; Mon, 24 Apr 2023 21:45:42 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 92B1960810;
	Mon, 24 Apr 2023 21:45:42 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 92B1960810
Authentication-Results: smtp3.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=t3A/n5b0
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id grVQD1t0Fq-p; Mon, 24 Apr 2023 21:45:41 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 2A6E860EFE;
	Mon, 24 Apr 2023 21:45:41 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 2A6E860EFE
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 00692C0036;
	Mon, 24 Apr 2023 21:45:40 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id E82ACC002A
 for <virtualization@lists.linux-foundation.org>;
 Mon, 24 Apr 2023 21:45:39 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id BDE8E81EE3
 for <virtualization@lists.linux-foundation.org>;
 Mon, 24 Apr 2023 21:45:39 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org BDE8E81EE3
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.a=rsa-sha256 header.s=k20201202 header.b=t3A/n5b0
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id uxCYyvvX848N
 for <virtualization@lists.linux-foundation.org>;
 Mon, 24 Apr 2023 21:45:39 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org C82FB81EDC
Received: from dfw.source.kernel.org (dfw.source.kernel.org
 [IPv6:2604:1380:4641:c500::1])
 by smtp1.osuosl.org (Postfix) with ESMTPS id C82FB81EDC
 for <virtualization@lists.linux-foundation.org>;
 Mon, 24 Apr 2023 21:45:38 +0000 (UTC)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id 0D59960C3A;
 Mon, 24 Apr 2023 21:45:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 72AAFC433D2;
 Mon, 24 Apr 2023 21:45:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1682372737;
 bh=TwnZUueyFdVR1wIPPiWen4VJwzu3FfozwfIcM1QoYPA=;
 h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
 b=t3A/n5b0n7vbVqd9ZgaslNQjFbzJCwvVePCmHb3OwLKZeOh35DKZnadeOyKoTT5M4
 BOOAi1dWQjY+wR82rsMJj/GjpM8MXPaz2iU8kkA+qienZ1/nnkvLsyGvtrv1K6X3/z
 i64WPCB5aFKBVFl8dkfh47JSRxSYIaGMUfGyWuiS0TAHeWKdeP+f1xC7irud27L3Ty
 sIxZJiffz6KJRHEqosNNadidJEip4EnZIs63/J9fV6iC3KmiZ5Hx7D48RxdukWqvxm
 uxfkv8UsxizRHD24pZgStq4sIIZENhsaUB6Y7T07IYRMs5eQlgdDBC2fTAn8dLnACe
 EoiGsXdlXTXvg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org
 (localhost.localdomain [127.0.0.1])
 by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id
 5E4D3E5FFC9; Mon, 24 Apr 2023 21:45:37 +0000 (UTC)
Subject: Re: [GIT PULL] fork: user workers & vhost
From: pr-tracker-bot@kernel.org
In-Reply-To: <20230421-satzglied-cybernaut-b2b652a46bfa@brauner>
References: <20230421-satzglied-cybernaut-b2b652a46bfa@brauner>
X-PR-Tracked-List-Id: <kvm.vger.kernel.org>
X-PR-Tracked-Message-Id: <20230421-satzglied-cybernaut-b2b652a46bfa@brauner>
X-PR-Tracked-Remote: git@gitolite.kernel.org:pub/scm/linux/kernel/git/brauner/linux
 tags/v6.4/kernel.user_worker
X-PR-Tracked-Commit-Id: 6e890c5d5021ca7e69bbe203fde42447874d9a82
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 3323ddce085cdb33331c2c1bb7a88233023566a9
Message-Id: <168237273738.2393.13319031457791989144.pr-tracker-bot@kernel.org>
Date: Mon, 24 Apr 2023 21:45:37 +0000
To: Christian Brauner <brauner@kernel.org>
Cc: Christian Brauner <brauner@kernel.org>,
 Linus Torvalds <torvalds@linux-foundation.org>, linux-kernel@vger.kernel.org,
 kvm@vger.kernel.org, virtualization@lists.linux-foundation.org
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

The pull request you sent on Fri, 21 Apr 2023 15:37:12 +0200:

> git@gitolite.kernel.org:pub/scm/linux/kernel/git/brauner/linux tags/v6.4/kernel.user_worker

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/3323ddce085cdb33331c2c1bb7a88233023566a9

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
