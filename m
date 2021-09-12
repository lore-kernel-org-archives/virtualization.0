Return-Path: <SRS0=fv7C=OC=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD3CEC43219
	for <virtualization@archiver.kernel.org>; Sun, 12 Sep 2021 00:42:15 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7DCBB611C0
	for <virtualization@archiver.kernel.org>; Sun, 12 Sep 2021 00:42:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 7DCBB611C0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 4E7CC82849;
	Sun, 12 Sep 2021 00:42:15 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 8FE2khQKJpkw; Sun, 12 Sep 2021 00:42:14 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 1AB1B827F0;
	Sun, 12 Sep 2021 00:42:14 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id DFE63C0011;
	Sun, 12 Sep 2021 00:42:13 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 500DDC000D
 for <virtualization@lists.linux-foundation.org>;
 Sun, 12 Sep 2021 00:42:12 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 32D2A607D1
 for <virtualization@lists.linux-foundation.org>;
 Sun, 12 Sep 2021 00:42:12 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=kernel.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 9mxDFu-VQPES
 for <virtualization@lists.linux-foundation.org>;
 Sun, 12 Sep 2021 00:42:11 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 991FE600C6
 for <virtualization@lists.linux-foundation.org>;
 Sun, 12 Sep 2021 00:42:11 +0000 (UTC)
Received: by mail.kernel.org (Postfix) with ESMTPS id 4119A6113E;
 Sun, 12 Sep 2021 00:42:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1631407331;
 bh=vO0yrHPLOkBrN8r9NE9CEpKY1uqNKyqDslzxg6dly5I=;
 h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
 b=llqY7opjf1DkVtb4Knt9eX2p3++OGRtteKL7MlYSRb2FbcYnoTxbnqmvOf1rAoKgw
 R6g2SwbDnXwWGX1tnbM2yc97urzvNX8JtvGuOqUcX6bWTGd8CgwkI8LlfUPBEoPygV
 xIgcgFuPI95pWjTrpdHIGsj/Tz2m7XcXESPv/xMROOwUuNOmxGfXlWnwRL75dDNhLp
 Q0TUv+t5f8+hMucJx5DB02gdL7xR+aicVPihMj6FgnN9r+j+13ng5rjiAZF/JDKJ1K
 7U+1zxHOc2oZn9IIyBQScT9j1AUVsbo2wqNvUvij1WxIJmGxS55ZP8MDIpv1iACQuZ
 tXrPoLEC9LaIw==
Subject: Re: [GIT PULL V2] virtio,vdpa,vhost: features, fixes
From: pr-tracker-bot@kernel.org
In-Reply-To: <20210911200504-mutt-send-email-mst@kernel.org>
References: <20210911200504-mutt-send-email-mst@kernel.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20210911200504-mutt-send-email-mst@kernel.org>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/mst/vhost.git
 tags/for_linus_v2
X-PR-Tracked-Commit-Id: 6105d1fe6f4c24ce8c13e2e6568b16b76e04983d
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: a93a962669cdbe56bb0bcd88156f0f1598f31c88
Message-Id: <163140733123.30830.10283487707815357982.pr-tracker-bot@kernel.org>
Date: Sun, 12 Sep 2021 00:42:11 +0000
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: mgurtovoy@nvidia.com, lingshan.zhu@intel.com, kvm@vger.kernel.org,
 mst@redhat.com, xianting.tian@linux.alibaba.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org,
 wsa@kernel.org, xieyongji@bytedance.com, viresh.kumar@linaro.org,
 arseny.krasnov@kaspersky.com, Linus Torvalds <torvalds@linux-foundation.org>,
 elic@nvidia.com
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

The pull request you sent on Sat, 11 Sep 2021 20:05:04 -0400:

> https://git.kernel.org/pub/scm/linux/kernel/git/mst/vhost.git tags/for_linus_v2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/a93a962669cdbe56bb0bcd88156f0f1598f31c88

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
