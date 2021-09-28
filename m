Return-Path: <SRS0=Y9jr=OS=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BE25C433F5
	for <virtualization@archiver.kernel.org>; Tue, 28 Sep 2021 14:31:17 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4FCDF6120D
	for <virtualization@archiver.kernel.org>; Tue, 28 Sep 2021 14:31:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 4FCDF6120D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 261C48197D;
	Tue, 28 Sep 2021 14:31:17 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id dayEyEu6aTQt; Tue, 28 Sep 2021 14:31:16 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id E356480D96;
	Tue, 28 Sep 2021 14:31:15 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id C47E4C0011;
	Tue, 28 Sep 2021 14:31:15 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 3A732C000D
 for <virtualization@lists.linux-foundation.org>;
 Tue, 28 Sep 2021 14:31:15 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 172EE8197D
 for <virtualization@lists.linux-foundation.org>;
 Tue, 28 Sep 2021 14:31:15 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Kuna-TBV91FO
 for <virtualization@lists.linux-foundation.org>;
 Tue, 28 Sep 2021 14:31:14 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 8879081971
 for <virtualization@lists.linux-foundation.org>;
 Tue, 28 Sep 2021 14:31:14 +0000 (UTC)
Received: by mail.kernel.org (Postfix) with ESMTPS id 26C8B61209;
 Tue, 28 Sep 2021 14:31:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1632839474;
 bh=EgMsATwK+z9MklT81mtu/IjIQhMpyFPQe+UMism4VLk=;
 h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
 b=f/5Y24zMJ1LapGxcHoUpqdLXv5tvZZBgxqVmW2isV5lvPQNOCgii/3gP2VpUQyoiJ
 H7dGW1p9tAuyHEWMy0RuVhmVJcEyFYuq3Np4epmqM90+PP75wFbT1lB+Ltgf9ppRoY
 Bgkdy/MGv7vYhMjFC0NTMorDr9BTmVOGpEsiHGvlWx2LUVmQeHOUHUDLlkfxp0/8Zr
 ITJd8DkAHw9ucfX10YO4ELDdmQIvLbeOU7Miaw1S933DSIMuHczNjBcBopuHJTTE8C
 3n2PNQyHlLrk0v4yqcth6IWq4Bk0lasm5ClfLATQ1aJoZiBGXgkpWxmHFk8FPVWMJS
 zy0iLbY/FJ1Rg==
Subject: Re: [GIT PULL] virtio,vdpa: fixes
From: pr-tracker-bot@kernel.org
In-Reply-To: <20210927183003-mutt-send-email-mst@kernel.org>
References: <20210927183003-mutt-send-email-mst@kernel.org>
X-PR-Tracked-List-Id: Linux virtualization
 <virtualization.lists.linux-foundation.org>
X-PR-Tracked-Message-Id: <20210927183003-mutt-send-email-mst@kernel.org>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/mst/vhost.git tags/for_linus
X-PR-Tracked-Commit-Id: be9c6bad9b46451ba5bb8d366c51e2475f374981
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: d33bec7b3dfa36691ed53ccaaf187d90b53be852
Message-Id: <163283947412.32258.5234903356989794369.pr-tracker-bot@kernel.org>
Date: Tue, 28 Sep 2021 14:31:14 +0000
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: kvm@vger.kernel.org, arnd@arndb.de, mst@redhat.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org,
 xieyongji@bytedance.com, dan.carpenter@oracle.com, viresh.kumar@linaro.org,
 elic@nvidia.com, Linus Torvalds <torvalds@linux-foundation.org>,
 linux@roeck-us.net
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

The pull request you sent on Mon, 27 Sep 2021 18:30:03 -0400:

> https://git.kernel.org/pub/scm/linux/kernel/git/mst/vhost.git tags/for_linus

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/d33bec7b3dfa36691ed53ccaaf187d90b53be852

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
