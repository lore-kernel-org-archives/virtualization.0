Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 66BDAC433F5
	for <virtualization@archiver.kernel.org>; Mon, 13 Dec 2021 22:50:08 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id DA7C54047C;
	Mon, 13 Dec 2021 22:50:07 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id mKl_U74EIg4O; Mon, 13 Dec 2021 22:50:07 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 5C057404A8;
	Mon, 13 Dec 2021 22:50:06 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 28001C002F;
	Mon, 13 Dec 2021 22:50:06 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 2C28DC0012
 for <virtualization@lists.linux-foundation.org>;
 Mon, 13 Dec 2021 22:50:05 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 04E8160B5E
 for <virtualization@lists.linux-foundation.org>;
 Mon, 13 Dec 2021 22:50:05 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=kernel.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 6jOItMwr0JJR
 for <virtualization@lists.linux-foundation.org>;
 Mon, 13 Dec 2021 22:50:03 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
 by smtp3.osuosl.org (Postfix) with ESMTPS id E7D3660B5D
 for <virtualization@lists.linux-foundation.org>;
 Mon, 13 Dec 2021 22:50:02 +0000 (UTC)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ams.source.kernel.org (Postfix) with ESMTPS id 6B121B816D2;
 Mon, 13 Dec 2021 22:50:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 24235C34600;
 Mon, 13 Dec 2021 22:49:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1639435799;
 bh=kn8oxVkJ6yPEUpS8v7x4XjZ+luhJ//RD7OwzUBU08GE=;
 h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
 b=FJHAUSVplX9ssZzTKkrdlWgZDn5urUEhpHLspLu0tFD+iwkj6mAsz6CsF6hqbWifn
 3dHfusbpeJatnLm8ZhTcc+Br0X31isNLqRkqLzZCmYneC9Nb2tFC+wGwNsYa7LzVNj
 dSiRJggs7Cm8vJJxSY1c30N8h5iwONAiWCjFY6qiDGa3aWPL9aCPOFmg62cQjoSoJw
 tOcwCzXU0JL+CJKILmIx1Y5kj8rqWhLl6oASrB10nIuQf+oKhdSjdh4ANreMqiT3i9
 sCAhJgYbrg0yAy8PtF9IBFwyOjw73JT9P+pyW6iZk5SyakGwKTY8DCwcAb+Tlb6o4H
 vFbMDBNDOsTYg==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain
 [127.0.0.1])
 by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id 00536609D6;
 Mon, 13 Dec 2021 22:49:58 +0000 (UTC)
Subject: Re: [GIT PULL] vhost: cleanups and fixes
From: pr-tracker-bot@kernel.org
In-Reply-To: <20211212175951-mutt-send-email-mst@kernel.org>
References: <20211212175951-mutt-send-email-mst@kernel.org>
X-PR-Tracked-List-Id: <netdev.vger.kernel.org>
X-PR-Tracked-Message-Id: <20211212175951-mutt-send-email-mst@kernel.org>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/mst/vhost.git tags/for_linus
X-PR-Tracked-Commit-Id: bb47620be322c5e9e372536cb6b54e17b3a00258
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 5472f14a37421d1bca3dddf33cabd3bd6dbefbbc
Message-Id: <163943579893.4494.7297461004032490348.pr-tracker-bot@kernel.org>
Date: Mon, 13 Dec 2021 22:49:58 +0000
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: kvm@vger.kernel.org, mst@redhat.com,
 virtualization@lists.linux-foundation.org, will@kernel.org, hch@lst.de,
 lkp@intel.com, xieyongji@bytedance.com, maz@kernel.org, suzuki.poulose@arm.com,
 steven.price@arm.com, Linus Torvalds <torvalds@linux-foundation.org>,
 dan.carpenter@oracle.com, jroedel@suse.de, arnd@arndb.de,
 konrad.wilk@oracle.com, qperret@google.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org, robin.murphy@arm.com
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

The pull request you sent on Sun, 12 Dec 2021 17:59:51 -0500:

> https://git.kernel.org/pub/scm/linux/kernel/git/mst/vhost.git tags/for_linus

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/5472f14a37421d1bca3dddf33cabd3bd6dbefbbc

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
