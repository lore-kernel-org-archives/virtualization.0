Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9F0E8C83F3F
	for <virtualization@archiver.kernel.org>; Mon,  4 Sep 2023 18:43:53 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 0094A408BC;
	Mon,  4 Sep 2023 18:43:53 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 0094A408BC
Authentication-Results: smtp2.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=sViUpbyq
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 4IqwZV1PknKg; Mon,  4 Sep 2023 18:43:50 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 50E6C40396;
	Mon,  4 Sep 2023 18:43:49 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 50E6C40396
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 14F8EC0071;
	Mon,  4 Sep 2023 18:43:49 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 5E1A4C0032
 for <virtualization@lists.linux-foundation.org>;
 Mon,  4 Sep 2023 18:43:47 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 24E6D40472
 for <virtualization@lists.linux-foundation.org>;
 Mon,  4 Sep 2023 18:43:47 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 24E6D40472
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 4mLpjiYJlkCx
 for <virtualization@lists.linux-foundation.org>;
 Mon,  4 Sep 2023 18:43:46 +0000 (UTC)
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 1943F40396
 for <virtualization@lists.linux-foundation.org>;
 Mon,  4 Sep 2023 18:43:46 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 1943F40396
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by sin.source.kernel.org (Postfix) with ESMTPS id E2513CE0F87;
 Mon,  4 Sep 2023 18:43:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 3EABEC433C8;
 Mon,  4 Sep 2023 18:43:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1693853018;
 bh=P3waEknk93lpso15++IpTOfJPAM5bzNhE1bMrPIVuGA=;
 h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
 b=sViUpbyqkVXlv+vATJFmoAi3Q8ukaUKgpv2qd7NPVzJxoY4IX4NRs2tk7AOq8DZUB
 PhM+6Z9G9DpU8XfimpDLGM/XloyZS+Jlu2OfFMCj/Bxy0NYwUkI7/mLQUneIZIjSau
 ARjsCnKT5mcS5iR9dbTY9iNWfvRjA8n6iWeIeU8bW/yPwqmSLh3XEVwRSDCy3KD4N6
 AXyPJadCGthdjr31o23gEAIui2CLUjppxRyIsuAiqSd/hob/HROCz5RsVurUSdOQMt
 /ghwUhXVAkUOprAJcSq5jY9wgxtZTj+DfkM9SGELhx/NMCr373nCayNJVQudDMRxXw
 ypLljV/qmmgog==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org
 (localhost.localdomain [127.0.0.1])
 by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id
 2BF9AC04DD9; Mon,  4 Sep 2023 18:43:38 +0000 (UTC)
Subject: Re: [GIT PULL] virtio: features
From: pr-tracker-bot@kernel.org
In-Reply-To: <20230903181338-mutt-send-email-mst@kernel.org>
References: <20230903181338-mutt-send-email-mst@kernel.org>
X-PR-Tracked-List-Id: <kvm.vger.kernel.org>
X-PR-Tracked-Message-Id: <20230903181338-mutt-send-email-mst@kernel.org>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/mst/vhost.git tags/for_linus
X-PR-Tracked-Commit-Id: 1acfe2c1225899eab5ab724c91b7e1eb2881b9ab
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: e4f1b8202fb59c56a3de7642d50326923670513f
Message-Id: <169385301813.15626.4404495470670396580.pr-tracker-bot@kernel.org>
Date: Mon, 04 Sep 2023 18:43:38 +0000
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: xuanzhuo@linux.alibaba.com, kvm@vger.kernel.org, mst@redhat.com,
 netdev@vger.kernel.org, yuehaibing@huawei.com, linux-kernel@vger.kernel.org,
 virtualization@lists.linux-foundation.org, yuanyaogoog@chromium.org,
 eperezma@redhat.com, Linus Torvalds <torvalds@linux-foundation.org>
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

The pull request you sent on Sun, 3 Sep 2023 18:13:38 -0400:

> https://git.kernel.org/pub/scm/linux/kernel/git/mst/vhost.git tags/for_linus

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/e4f1b8202fb59c56a3de7642d50326923670513f

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
