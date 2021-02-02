Return-Path: <SRS0=DeSX=HE=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37539C433E0
	for <virtualization@archiver.kernel.org>; Tue,  2 Feb 2021 18:48:42 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C37CC64F4B
	for <virtualization@archiver.kernel.org>; Tue,  2 Feb 2021 18:48:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C37CC64F4B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id 804AC2288F;
	Tue,  2 Feb 2021 18:48:41 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id b4VpCwXKP0D5; Tue,  2 Feb 2021 18:48:40 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id CB4DF2286C;
	Tue,  2 Feb 2021 18:48:40 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id A7711C0FA7;
	Tue,  2 Feb 2021 18:48:40 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id A2216C013A
 for <virtualization@lists.linux-foundation.org>;
 Tue,  2 Feb 2021 18:48:39 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id 7F5C82288F
 for <virtualization@lists.linux-foundation.org>;
 Tue,  2 Feb 2021 18:48:39 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id BIZkKz6tzBLd
 for <virtualization@lists.linux-foundation.org>;
 Tue,  2 Feb 2021 18:48:38 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by silver.osuosl.org (Postfix) with ESMTPS id D6D142286C
 for <virtualization@lists.linux-foundation.org>;
 Tue,  2 Feb 2021 18:48:38 +0000 (UTC)
Received: by mail.kernel.org (Postfix) with ESMTPS id 692B064E51;
 Tue,  2 Feb 2021 18:48:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1612291718;
 bh=aUnEQIfvzMXhPUXnNM+qC1XZqHg2A60B6eut7OZ6ZUo=;
 h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
 b=KUc7WTnyvX53dgaZrc8HswAxJTg7sg8XVhbQPCqPsOyzi2ZgZYZdAZUBw1mFnvrOB
 r0kM19+g5UgydvFhR9OiGRSwSRedEgYDHcxCJccSxYr67xH8hmWpWVSg4v459ycBGq
 njZCL4QDcry/ORshbPLnF6hXpbFLkoy48GL6613KSepcHrO3kHOwaDLN9oa+XqfpUQ
 D/51PUJLYqRLGJSaY4hLoEQdgNHaN25z5wFuD1+BtsDyjBt9BDHOngDeIUup5Xhz9T
 +Mc1YjxprginXjTb3OBHColL+kaGekhDulnSHnMG9RINa2ysdg0Q+yVAZsJAWFowpw
 M/VpL4D4yrjHA==
Subject: Re: [GIT PULL] vdpa: bugfix
From: pr-tracker-bot@kernel.org
In-Reply-To: <20210201182510-mutt-send-email-mst@kernel.org>
References: <20210201182510-mutt-send-email-mst@kernel.org>
X-PR-Tracked-List-Id: Linux virtualization
 <virtualization.lists.linux-foundation.org>
X-PR-Tracked-Message-Id: <20210201182510-mutt-send-email-mst@kernel.org>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/mst/vhost.git tags/for_linus
X-PR-Tracked-Commit-Id: 710eb8e32d04714452759f2b66884bfa7e97d495
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 2e02677e961fd4b96d8cf106b5979e6a3cdb7362
Message-Id: <161229171829.14515.1965140964811542808.pr-tracker-bot@kernel.org>
Date: Tue, 02 Feb 2021 18:48:38 +0000
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: kvm@vger.kernel.org, mst@redhat.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org,
 elic@nvidia.com, Linus Torvalds <torvalds@linux-foundation.org>
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

The pull request you sent on Mon, 1 Feb 2021 18:25:10 -0500:

> https://git.kernel.org/pub/scm/linux/kernel/git/mst/vhost.git tags/for_linus

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/2e02677e961fd4b96d8cf106b5979e6a3cdb7362

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
