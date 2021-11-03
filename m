Return-Path: <SRS0=Oeu7=PW=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96504C433F5
	for <virtualization@archiver.kernel.org>; Wed,  3 Nov 2021 22:04:42 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3CC3F6113E
	for <virtualization@archiver.kernel.org>; Wed,  3 Nov 2021 22:04:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 3CC3F6113E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id EFB2C60B13;
	Wed,  3 Nov 2021 22:04:41 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id BpluOjdjpipF; Wed,  3 Nov 2021 22:04:40 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 4931460B03;
	Wed,  3 Nov 2021 22:04:40 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 1E269C0019;
	Wed,  3 Nov 2021 22:04:40 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 306D2C000E
 for <virtualization@lists.linux-foundation.org>;
 Wed,  3 Nov 2021 22:04:39 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 09823403AF
 for <virtualization@lists.linux-foundation.org>;
 Wed,  3 Nov 2021 22:04:39 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=kernel.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Y7Drds-VEobM
 for <virtualization@lists.linux-foundation.org>;
 Wed,  3 Nov 2021 22:04:37 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by smtp2.osuosl.org (Postfix) with ESMTPS id C5FF9403AC
 for <virtualization@lists.linux-foundation.org>;
 Wed,  3 Nov 2021 22:04:37 +0000 (UTC)
Received: by mail.kernel.org (Postfix) with ESMTPS id 5EE4A610FD;
 Wed,  3 Nov 2021 22:04:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1635977077;
 bh=U252dDDHz3ceWBRZWZCdLxN7k8HFZDRcyZtnZO5anv8=;
 h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
 b=W21gCAY9OeiCvKViVJqMyTBirgsurySJQ2Ebv2gv6xI5OWu53iFNdKpI8CBATUunw
 Z1U3H2xa4LrUmW2o/QT9T9Mq+HON+RUZ5Y5XGZU3njNF3dDcJ/yvTvjhASi+7Y9yxZ
 pRcSaURC36qpqlG9MOHsZtDutSan7SDJZvrmksA8MSvBYYvCWzevDKiSoe0uOqIiDF
 DHT12h/W16CbBkuARKTYwNKYVX5azEjK4WWxrcnTr3UDKpRa8LvllHpfB/I8bHljL+
 zXe/VS+zwU08lLieNvMWEdCF+5N5/F4VuAS4wpXJqWUTlYv7Kej/LB+lozAC/mce4v
 i+a1SO5+2+YkQ==
Subject: Re: [GIT PULL] vhost,virtio,vhost: fixes,features
From: pr-tracker-bot@kernel.org
In-Reply-To: <20211103164332-mutt-send-email-mst@kernel.org>
References: <20211103164332-mutt-send-email-mst@kernel.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20211103164332-mutt-send-email-mst@kernel.org>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/mst/vhost.git tags/for_linus
X-PR-Tracked-Commit-Id: 540061ac79f0302ae91e44e6cd216cbaa3af1757
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 43e1b12927276cde8052122a24ff796649f09d60
Message-Id: <163597707724.8098.177160565800108525.pr-tracker-bot@kernel.org>
Date: Wed, 03 Nov 2021 22:04:37 +0000
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: kvm@vger.kernel.org, mst@redhat.com, peterz@infradead.org,
 viresh.kumar@linaro.org, colin.i.king@googlemail.com,
 linux-kernel@vger.kernel.org, wuzongyong@linux.alibaba.com, elic@nvidia.com,
 lkp@intel.com, corentin.noel@collabora.com, paulmck@kernel.org,
 zealci@zte.com.cn, colin.i.king@gmail.com, lvivier@redhat.com, arnd@arndb.de,
 amit@kernel.org, boqun.feng@gmail.com, pankaj.gupta@ionos.com,
 stefanha@redhat.com, ye.guojin@zte.com.cn, tglx@linutronix.de,
 virtualization@lists.linux-foundation.org, mgurtovoy@nvidia.com,
 pankaj.gupta.linux@gmail.com, netdev@vger.kernel.org, gustavoars@kernel.org,
 pbonzini@redhat.com, Linus Torvalds <torvalds@linux-foundation.org>
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

The pull request you sent on Wed, 3 Nov 2021 16:43:32 -0400:

> https://git.kernel.org/pub/scm/linux/kernel/git/mst/vhost.git tags/for_linus

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/43e1b12927276cde8052122a24ff796649f09d60

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
