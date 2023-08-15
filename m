Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 242A7C0015E
	for <virtualization@archiver.kernel.org>; Tue, 15 Aug 2023 06:30:31 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 9E6B640126;
	Tue, 15 Aug 2023 06:30:30 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 9E6B640126
Authentication-Results: smtp2.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=cJxPxsG1
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id VjQ-UuVEy4KE; Tue, 15 Aug 2023 06:30:30 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 47F2B40332;
	Tue, 15 Aug 2023 06:30:29 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 47F2B40332
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 1E4E9C0072;
	Tue, 15 Aug 2023 06:30:29 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 42DBDC0032
 for <virtualization@lists.linux-foundation.org>;
 Tue, 15 Aug 2023 06:30:28 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 0FB0760A66
 for <virtualization@lists.linux-foundation.org>;
 Tue, 15 Aug 2023 06:30:28 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 0FB0760A66
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.a=rsa-sha256 header.s=k20201202 header.b=cJxPxsG1
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id v5fkuZADMdJc
 for <virtualization@lists.linux-foundation.org>;
 Tue, 15 Aug 2023 06:30:27 +0000 (UTC)
Received: from dfw.source.kernel.org (dfw.source.kernel.org
 [IPv6:2604:1380:4641:c500::1])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 4AC6960AA0
 for <virtualization@lists.linux-foundation.org>;
 Tue, 15 Aug 2023 06:30:27 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 4AC6960AA0
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id 8A42E61512;
 Tue, 15 Aug 2023 06:30:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id D254BC433C7;
 Tue, 15 Aug 2023 06:30:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1692081025;
 bh=/r9zQqPcKHXB+/YvF7yHrkr2SnbTZmcfogf/eo9mkOw=;
 h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
 b=cJxPxsG17aAMpcZSikIySt2PtxQWKUNj/mhChyqABDGEiXCKdQ07P9M/AJCnVmxGz
 5oIQIJ4dSh3j38iEIgGswQWJr9RhGgCC3R1MxSXnbMVXYiSwMk+uyBxl3QDxW/odgv
 XvktYKCquvmtwMppHmtSAs9LDVuefondZZwQVqqK5tvH9wJB3jcDgH7nirQhvtOBFU
 zGNqAXN6i0z4reLupSqs7/QN2+XEeZx8S5/Lk6CJH/NISrkM+AnfoCHWnll0BlKiQI
 xWX6BRIYgn5F0araMzIX1wc6RbQF2oJnj+6YW1fZ7945JoyzqKl/OYiZAz4lkdjgdT
 ciTwsOVVVW/aw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org
 (localhost.localdomain [127.0.0.1])
 by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id
 BF043E93B37; Tue, 15 Aug 2023 06:30:25 +0000 (UTC)
Subject: Re: [GIT PULL] virtio: bugfixes
From: pr-tracker-bot@kernel.org
In-Reply-To: <20230813190803-mutt-send-email-mst@kernel.org>
References: <20230813190803-mutt-send-email-mst@kernel.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20230813190803-mutt-send-email-mst@kernel.org>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/mst/vhost.git tags/for_linus
X-PR-Tracked-Commit-Id: f55484fd7be923b740e8e1fc304070ba53675cb4
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 91aa6c412d7f85e48aead7b00a7d9e91f5cf5863
Message-Id: <169208102577.2851.3010271963190642664.pr-tracker-bot@kernel.org>
Date: Tue, 15 Aug 2023 06:30:25 +0000
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: andrew@daynix.com, kvm@vger.kernel.org, allen.hubbe@amd.com,
 virtualization@lists.linux-foundation.org, wsa+renesas@sang-engineering.com,
 xieyongji@bytedance.com, gal@nvidia.com, mst@redhat.com, eperezma@redhat.com,
 yin31149@gmail.com, leiyang@redhat.com, stefanha@redhat.com,
 stable@vger.kernelorg, linma@zju.edu.cn, netdev@vger.kernel.org,
 rdunlap@infradead.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org,
 maxime.coquelin@redhat.com, Linus Torvalds <torvalds@linux-foundation.org>
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

The pull request you sent on Sun, 13 Aug 2023 19:08:03 -0400:

> https://git.kernel.org/pub/scm/linux/kernel/git/mst/vhost.git tags/for_linus

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/91aa6c412d7f85e48aead7b00a7d9e91f5cf5863

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
