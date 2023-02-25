Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9FE8CC7EE2F
	for <virtualization@archiver.kernel.org>; Sat, 25 Feb 2023 19:58:16 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 36A5A4097F;
	Sat, 25 Feb 2023 19:58:16 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 36A5A4097F
Authentication-Results: smtp2.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=rZa9AL21
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id YEDiwKAKZmDZ; Sat, 25 Feb 2023 19:58:15 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id C9A9040103;
	Sat, 25 Feb 2023 19:58:14 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org C9A9040103
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id A1178C0033;
	Sat, 25 Feb 2023 19:58:14 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id E5903C002B
 for <virtualization@lists.linux-foundation.org>;
 Sat, 25 Feb 2023 19:58:13 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id C746A4014D
 for <virtualization@lists.linux-foundation.org>;
 Sat, 25 Feb 2023 19:58:13 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org C746A4014D
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id h_7klKrpgfq6
 for <virtualization@lists.linux-foundation.org>;
 Sat, 25 Feb 2023 19:58:13 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 0CFAB40103
Received: from dfw.source.kernel.org (dfw.source.kernel.org
 [IPv6:2604:1380:4641:c500::1])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 0CFAB40103
 for <virtualization@lists.linux-foundation.org>;
 Sat, 25 Feb 2023 19:58:12 +0000 (UTC)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id B9B4060B5C;
 Sat, 25 Feb 2023 19:58:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 2A61FC433D2;
 Sat, 25 Feb 2023 19:58:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1677355091;
 bh=Af4EZS9W1eJNBY7oPlsoCzaKOu1YTZ46uihFnYYeYRU=;
 h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
 b=rZa9AL21mN13eeFBKwQ+Letv3Y/gvtWCqg8kJC8gi3yRZt1UATneWida+0s6RhoZv
 1A1wOd6asQaW3RuMkGuoawKL6JxjSlkRZvumEQ1ZYQOJ8aLGUpGrh+HrtVu0H0pwe7
 ++3taeUJ32iHHnuTF0u3cNBjxBZljQ1N6VOneYLLpiR3mJ7PUr+Oq6BU7X5v3mQCsa
 LEd8x2T4TKcd2GMkBoETJjX7KtB2N2R+DKAfPpE4VDhL9cCUE9GBUV0s1TnsBKDzRp
 9hoAEmYYOYxczcyiaArk9JnUkFdcnAyLL/Q7FCuaIRReGECQPANBThVAepycikirSX
 8nlzBMEHPu+qA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org
 (localhost.localdomain [127.0.0.1])
 by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id
 13E9AE68D26; Sat, 25 Feb 2023 19:58:11 +0000 (UTC)
Subject: Re: [GIT PULL] virtio,vhost,vdpa: features, fixes
From: pr-tracker-bot@kernel.org
In-Reply-To: <20230220194045-mutt-send-email-mst@kernel.org>
References: <20230220194045-mutt-send-email-mst@kernel.org>
X-PR-Tracked-List-Id: <kvm.vger.kernel.org>
X-PR-Tracked-Message-Id: <20230220194045-mutt-send-email-mst@kernel.org>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/mst/vhost.git tags/for_linus
X-PR-Tracked-Commit-Id: deeacf35c922da579637f5db625af20baafc66ed
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 84cc6674b76ba2cdac0df8037b4d8a22a6fc1b77
Message-Id: <167735509107.12970.18167182731534923756.pr-tracker-bot@kernel.org>
Date: Sat, 25 Feb 2023 19:58:11 +0000
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: kvm@vger.kernel.org, mst@redhat.com,
 virtualization@lists.linux-foundation.org, stable@vger.kernel.org,
 bagasdotme@gmail.com, elic@nvidia.com, zyytlz.wz@163.com, hch@lst.de,
 m.szyprowski@samsung.com, almasrymina@google.com, sfr@canb.auug.org.au,
 anders.roxell@linaro.org, eperezma@redhat.com, liubo03@inspur.com,
 yangyingliang@huawei.com, lkft@linaro.org, colin.i.king@gmail.com,
 kangjie.xu@linux.alibaba.com, sammler@google.com, leiyang@redhat.com,
 bhelgaas@google.com, suwan.kim027@gmail.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, liming.wu@jaguarmicro.com,
 dmitry.fomichev@wdc.com, sebastien.boeuf@intel.com, mie@igel.co.jp,
 Linus Torvalds <torvalds@linux-foundation.org>
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

The pull request you sent on Mon, 20 Feb 2023 19:40:45 -0500:

> https://git.kernel.org/pub/scm/linux/kernel/git/mst/vhost.git tags/for_linus

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/84cc6674b76ba2cdac0df8037b4d8a22a6fc1b77

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
