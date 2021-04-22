Return-Path: <SRS0=T/77=JT=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5E22C433ED
	for <virtualization@archiver.kernel.org>; Thu, 22 Apr 2021 23:30:42 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 320F161421
	for <virtualization@archiver.kernel.org>; Thu, 22 Apr 2021 23:30:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 320F161421
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id D7D896060E;
	Thu, 22 Apr 2021 23:30:41 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id GXHu1j7ZhzNf; Thu, 22 Apr 2021 23:30:41 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTP id 7B5B0605E9;
	Thu, 22 Apr 2021 23:30:40 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 51E42C000E;
	Thu, 22 Apr 2021 23:30:40 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 97824C000B
 for <virtualization@lists.linux-foundation.org>;
 Thu, 22 Apr 2021 23:30:39 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 84A1D4056B
 for <virtualization@lists.linux-foundation.org>;
 Thu, 22 Apr 2021 23:30:39 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=kernel.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id ItvpOmGQ_mTs
 for <virtualization@lists.linux-foundation.org>;
 Thu, 22 Apr 2021 23:30:38 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 3D6D940525
 for <virtualization@lists.linux-foundation.org>;
 Thu, 22 Apr 2021 23:30:38 +0000 (UTC)
Received: by mail.kernel.org (Postfix) with ESMTPS id 904CC61417;
 Thu, 22 Apr 2021 23:30:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1619134236;
 bh=Oag/qHmdRa6QX9ANpkVAVsvFpxx7M8p3mEORxwqYcC4=;
 h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
 b=VV+Jhmqvm45TuZAsdwGuDIzsSSlimGhG35iIwWxas9DDJgMlNrKxQl/RxpXB04gRb
 IFK/HYgkASjCo8H09q+xrOOE3VqPTrJCx9Y9cx9jWfK07WYiVsk5/XZHzXKuTacJAE
 j8uJ30/GvloxHsMmAgcs6Z59ZgwfslXGa/aokvYbSoisJI6qbWhBYLDW97imbzJwhh
 VcqIQnJKoqYM5rQKPAIKEcHlCAwf/PTR9dYVVJ6Bu1vlA0YPetH/mRxFQGSJlwy2S7
 zq3VOqvraueSaSsw1gWNW5MbiXRFwAhyZg7VgMd0H7vyBf+A5ybSBfB3l5IQn5I8h9
 r7dr70NtMez+w==
Subject: Re: [GIT PULL] virtio: last minute fixes
From: pr-tracker-bot@kernel.org
In-Reply-To: <20210422182016-mutt-send-email-mst@kernel.org>
References: <20210422182016-mutt-send-email-mst@kernel.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20210422182016-mutt-send-email-mst@kernel.org>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/mst/vhost.git tags/for_linus
X-PR-Tracked-Commit-Id: be286f84e33da1a7f83142b64dbd86f600e73363
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 18a3c5f7abfdf97f88536d35338ebbee119c355c
Message-Id: <161913423647.3750.12332768319066444186.pr-tracker-bot@kernel.org>
Date: Thu, 22 Apr 2021 23:30:36 +0000
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: lkp@intel.com, kvm@vger.kernel.org, mst@redhat.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org,
 virtualization@lists.linux-foundation.org, xieyongji@bytedance.com,
 elic@nvidia.com, Linus Torvalds <torvalds@linux-foundation.org>,
 dan.carpenter@oracle.com
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

The pull request you sent on Thu, 22 Apr 2021 18:20:16 -0400:

> https://git.kernel.org/pub/scm/linux/kernel/git/mst/vhost.git tags/for_linus

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/18a3c5f7abfdf97f88536d35338ebbee119c355c

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
