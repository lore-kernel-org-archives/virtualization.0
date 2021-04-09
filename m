Return-Path: <SRS0=E6mM=JG=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD295C433ED
	for <virtualization@archiver.kernel.org>; Fri,  9 Apr 2021 19:59:29 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 59FB3610F7
	for <virtualization@archiver.kernel.org>; Fri,  9 Apr 2021 19:59:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 59FB3610F7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 2A53B83C2A;
	Fri,  9 Apr 2021 19:59:29 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id YESwiZv0Hs-x; Fri,  9 Apr 2021 19:59:28 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTP id D9ECB838FB;
	Fri,  9 Apr 2021 19:59:27 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id B08F5C000C;
	Fri,  9 Apr 2021 19:59:27 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 9A66DC000A
 for <virtualization@lists.linux-foundation.org>;
 Fri,  9 Apr 2021 19:59:26 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 748786076D
 for <virtualization@lists.linux-foundation.org>;
 Fri,  9 Apr 2021 19:59:26 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=kernel.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id M1UJS9lR1Hx8
 for <virtualization@lists.linux-foundation.org>;
 Fri,  9 Apr 2021 19:59:25 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by smtp3.osuosl.org (Postfix) with ESMTPS id CA4E86076A
 for <virtualization@lists.linux-foundation.org>;
 Fri,  9 Apr 2021 19:59:25 +0000 (UTC)
Received: by mail.kernel.org (Postfix) with ESMTPS id 42BDE611AF;
 Fri,  9 Apr 2021 19:59:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1617998365;
 bh=pJ7c657VoLqpI/8XU9Khru6I80F9QWhd7I0r2ySUqlk=;
 h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
 b=cJWeYJoKPIy4RKvyJx9JgZ8w1qYfKvC1Q958gU8xF3kj/fUn0wFcO0s/Fipan2Q4b
 4yRubMzJezjPgcFKtGwpc1FALJ2fA40H4B3DDNPxzOpH8ypp1uxXbqsawkJIpaQiHc
 uNUnz/paxQFMm83uIluqDIcgUfQgQ7LAzsL40QHoisOKluUcosYwBKNLLmj5OFAWQY
 thrISi3HSXEVkwACnhUtqIg7lvvWXyuL0fLSXXpuCgLoVfWHg2y9IvpW5HmNO+Euet
 x8pB2pUUqQ9Y1lbIoscnu+Pe7WbqMN9Dk0D+VUUljvVZzYtDoMmViDmKPs1enmS4cS
 M3Ciirdi9InfQ==
Subject: Re: [GIT PULL] vdpa/mlx5: last minute fixes
From: pr-tracker-bot@kernel.org
In-Reply-To: <20210409124816-mutt-send-email-mst@kernel.org>
References: <20210409124816-mutt-send-email-mst@kernel.org>
X-PR-Tracked-List-Id: <kvm.vger.kernel.org>
X-PR-Tracked-Message-Id: <20210409124816-mutt-send-email-mst@kernel.org>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/mst/vhost.git tags/for_linus
X-PR-Tracked-Commit-Id: bc04d93ea30a0a8eb2a2648b848cef35d1f6f798
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 189fefc7a4f0401d0f799de96b772319a6541fc1
Message-Id: <161799836524.7895.6127535602829010878.pr-tracker-bot@kernel.org>
Date: Fri, 09 Apr 2021 19:59:25 +0000
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: kvm@vger.kernel.org, mst@redhat.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org,
 si-wei.liu@oracle.com, elic@nvidia.com,
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

The pull request you sent on Fri, 9 Apr 2021 12:48:16 -0400:

> https://git.kernel.org/pub/scm/linux/kernel/git/mst/vhost.git tags/for_linus

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/189fefc7a4f0401d0f799de96b772319a6541fc1

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
