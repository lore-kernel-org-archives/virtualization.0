Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D73BCEB64DC
	for <virtualization@archiver.kernel.org>; Tue,  4 Jul 2023 00:16:54 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 503CE60EE5;
	Tue,  4 Jul 2023 00:16:54 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 503CE60EE5
Authentication-Results: smtp3.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=DkAAGrdn
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Qv3FvXi3QSrK; Tue,  4 Jul 2023 00:16:53 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id B5A1860BE7;
	Tue,  4 Jul 2023 00:16:52 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org B5A1860BE7
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 858B9C0072;
	Tue,  4 Jul 2023 00:16:52 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 5EA71C0032
 for <virtualization@lists.linux-foundation.org>;
 Tue,  4 Jul 2023 00:16:51 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 30B654162C
 for <virtualization@lists.linux-foundation.org>;
 Tue,  4 Jul 2023 00:16:51 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 30B654162C
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.a=rsa-sha256 header.s=k20201202 header.b=DkAAGrdn
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 4PJkmFqGPLOw
 for <virtualization@lists.linux-foundation.org>;
 Tue,  4 Jul 2023 00:16:50 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 180D64109B
Received: from dfw.source.kernel.org (dfw.source.kernel.org
 [IPv6:2604:1380:4641:c500::1])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 180D64109B
 for <virtualization@lists.linux-foundation.org>;
 Tue,  4 Jul 2023 00:16:50 +0000 (UTC)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id E69B06109A;
 Tue,  4 Jul 2023 00:16:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 48B7EC433C7;
 Tue,  4 Jul 2023 00:16:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1688429808;
 bh=4Arucsbx7xXqBiJTMaZ2sHKWBFMCtusx1d5m5Uphgso=;
 h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
 b=DkAAGrdnnnfiwiC89o0VZ3uslqIdbGQ6SfUpM7T/TzojYaMGDyAxiJ2vC2uTbN4zk
 NssPpXz/RhgXyiib8WCc8DEqbGdbxZ4E1v2zDLT9CFBSnk9HVAQfERCOUV6XgdswW4
 yRZ1eSozjbVnr8qyOpiGZ7tial8XQDe2GHfmWsl1GkbTJTy10GyHLhefqUq6nVBYFT
 CffYwH9WR7ydcQoSL3QV+a+TLWW/StZElppe/qNzKvfgP3Ye9tDCetQykuTJ+iPuYI
 EjyL1N2CHSQn2ckHuPh2bicLfW/tRh93bFF7XkKRzB9m3XOrEYxjtpwEW2bAiOYhCQ
 0M1lH9fBRUkJg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org
 (localhost.localdomain [127.0.0.1])
 by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id
 33BBCC561EE; Tue,  4 Jul 2023 00:16:48 +0000 (UTC)
Subject: Re: [GIT PULL] virtio: features, fixes, cleanups
From: pr-tracker-bot@kernel.org
In-Reply-To: <20230703123256-mutt-send-email-mst@kernel.org>
References: <20230703123256-mutt-send-email-mst@kernel.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20230703123256-mutt-send-email-mst@kernel.org>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/mst/vhost.git tags/for_linus
X-PR-Tracked-Commit-Id: 9e396a2f434f829fb3b98a24bb8db5429320589d
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: a8d70602b186f3c347e62c59a418be802b71886d
Message-Id: <168842980820.28751.12949460743497751873.pr-tracker-bot@kernel.org>
Date: Tue, 04 Jul 2023 00:16:48 +0000
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: peng.fan@nxp.com, kvm@vger.kernel.org, mst@redhat.com,
 virtualization@lists.linux-foundation.org, elic@nvidia.com,
 xianting.tian@linux.alibaba.com, xieyongji@bytedance.com,
 tianxianting.txt@alibaba-inc.com, maxime.coquelin@redhat.com,
 netdev@vger.kernel.org, Linus Torvalds <torvalds@linux-foundation.org>,
 linux-kernel@vger.kernel.org, krzysztof.kozlowski@linaro.org, horms@kernel.org,
 saeedm@nvidia.com
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

The pull request you sent on Mon, 3 Jul 2023 12:32:56 -0400:

> https://git.kernel.org/pub/scm/linux/kernel/git/mst/vhost.git tags/for_linus

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/a8d70602b186f3c347e62c59a418be802b71886d

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
