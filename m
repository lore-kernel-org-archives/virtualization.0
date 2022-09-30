Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3EF5DC43217
	for <virtualization@archiver.kernel.org>; Fri, 30 Sep 2022 16:48:23 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id A75EE83EC3;
	Fri, 30 Sep 2022 16:48:22 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org A75EE83EC3
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=eJUF5nIX
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id xazqBp_WlUoS; Fri, 30 Sep 2022 16:48:21 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 42A5C83EA2;
	Fri, 30 Sep 2022 16:48:21 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 42A5C83EA2
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 107A4C0033;
	Fri, 30 Sep 2022 16:48:21 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 90F04C002D
 for <virtualization@lists.linux-foundation.org>;
 Fri, 30 Sep 2022 16:48:19 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 57443403C8
 for <virtualization@lists.linux-foundation.org>;
 Fri, 30 Sep 2022 16:48:19 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 57443403C8
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.a=rsa-sha256 header.s=k20201202 header.b=eJUF5nIX
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 1l0Pg-50Znc1
 for <virtualization@lists.linux-foundation.org>;
 Fri, 30 Sep 2022 16:48:18 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 6426740200
Received: from dfw.source.kernel.org (dfw.source.kernel.org
 [IPv6:2604:1380:4641:c500::1])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 6426740200
 for <virtualization@lists.linux-foundation.org>;
 Fri, 30 Sep 2022 16:48:18 +0000 (UTC)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id 316DC623D4;
 Fri, 30 Sep 2022 16:48:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 94C04C433D7;
 Fri, 30 Sep 2022 16:48:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1664556496;
 bh=sGiZf+frNWqIShRobfgZ454+v/RIz7LdvPSEROhBfII=;
 h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
 b=eJUF5nIXS3hdtmsM40BVhWg4TbR02Cke8tLIxTypcG8hCz8vqUaUCb8NVvNl0ykui
 +nfdJkf3/6cwyzfFgfmi90D8XX8emiK0ptCUOx7nVk0nl82SaF9YE6PX2FHwPmPFEq
 3h2fSOaqmQg70KcagedqF+ZI3070K8lw3mLyBQPcJqrFtRHV7PDVcBXTgFviOl6h5W
 DalmlYI7ULn228QDLdy/yQrrnFdD8smfm7JPxpaVkVgZZ7zSjZNKpt70VECoPl81AD
 OzqEa9lVh1pnU+VWo22laI8tsro9orQd+76mVtqo4VR+hN2JS2OiaHd1Hovr1D06nn
 yygrwEz/Hj9jA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org
 (localhost.localdomain [127.0.0.1])
 by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id
 806B9E4D013; Fri, 30 Sep 2022 16:48:16 +0000 (UTC)
Subject: Re: [GIT PULL] virtio: fixes
From: pr-tracker-bot@kernel.org
In-Reply-To: <20220930115933-mutt-send-email-mst@kernel.org>
References: <20220930115933-mutt-send-email-mst@kernel.org>
X-PR-Tracked-List-Id: <kvm.vger.kernel.org>
X-PR-Tracked-Message-Id: <20220930115933-mutt-send-email-mst@kernel.org>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/mst/vhost.git tags/for_linus
X-PR-Tracked-Commit-Id: a43ae8057cc154fd26a3a23c0e8643bef104d995
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 70575e77839f4c5337ce2653b39b86bb365a870e
Message-Id: <166455649651.20642.18137249565430368472.pr-tracker-bot@kernel.org>
Date: Fri, 30 Sep 2022 16:48:16 +0000
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: kvm@vger.kernel.org, acourbot@chromium.org, mst@redhat.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 virtualization@lists.linux-foundation.org, maxime.coquelin@redhat.com,
 stefanha@redhat.com, angus.chen@jaguarmicro.com, elic@nvidia.com,
 suwan.kim027@gmail.com, Linus Torvalds <torvalds@linux-foundation.org>,
 lingshan.zhu@intel.com, helei.sig11@bytedance.com
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

The pull request you sent on Fri, 30 Sep 2022 11:59:33 -0400:

> https://git.kernel.org/pub/scm/linux/kernel/git/mst/vhost.git tags/for_linus

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/70575e77839f4c5337ce2653b39b86bb365a870e

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
