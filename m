Return-Path: <SRS0=ofWe=BV=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19809C433E1
	for <virtualization@archiver.kernel.org>; Tue, 11 Aug 2020 21:59:13 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D45432078B
	for <virtualization@archiver.kernel.org>; Tue, 11 Aug 2020 21:59:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="GthU30VI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D45432078B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id A4BC687D41;
	Tue, 11 Aug 2020 21:59:12 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ZePeOFyZZlSa; Tue, 11 Aug 2020 21:59:12 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id 3175087904;
	Tue, 11 Aug 2020 21:59:12 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 13974C013C;
	Tue, 11 Aug 2020 21:59:12 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 8FA4BC004D
 for <virtualization@lists.linux-foundation.org>;
 Tue, 11 Aug 2020 21:59:11 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id 8B40785EA5
 for <virtualization@lists.linux-foundation.org>;
 Tue, 11 Aug 2020 21:59:11 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id YPWpLoQ3MoVh
 for <virtualization@lists.linux-foundation.org>;
 Tue, 11 Aug 2020 21:59:11 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id F2F2485065
 for <virtualization@lists.linux-foundation.org>;
 Tue, 11 Aug 2020 21:59:10 +0000 (UTC)
Subject: Re: [GIT PULL] virtio: features, fixes
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1597183150;
 bh=pduJdQOsaqltANr9l0iuMb/P8XQ2p94DV73pB5O3e3U=;
 h=From:In-Reply-To:References:Date:To:Cc:From;
 b=GthU30VIz6XaDDYj0LD8oG30goU0vf67f57r+Wl0jVapX3S60ZQ0lEtunpVsEZIdC
 2cUiR5/E6sy6zJbOlvN2b4ah+sxk3UAqCPKrGP/hv9VmRZ4J7DgP1XO6pCLDUdIeV+
 NrwmGYHf5kDH9jSY8ViGXW2i3EgZKJYynkcDyXuY=
From: pr-tracker-bot@kernel.org
In-Reply-To: <20200811045613-mutt-send-email-mst@kernel.org>
References: <20200811045613-mutt-send-email-mst@kernel.org>
X-PR-Tracked-List-Id: <kvm.vger.kernel.org>
X-PR-Tracked-Message-Id: <20200811045613-mutt-send-email-mst@kernel.org>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/mst/vhost.git tags/for_linus
X-PR-Tracked-Commit-Id: 8a7c3213db068135e816a6a517157de6443290d6
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 57b077939287835b9396a1c3b40d35609cf2fcb8
Message-Id: <159718315071.19600.5549149981954786665.pr-tracker-bot@kernel.org>
Date: Tue, 11 Aug 2020 21:59:10 +0000
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: kvm@vger.kernel.org, michaelgur@mellanox.com, linux-kernel@vger.kernel.org,
 meirl@mellanox.com, eli@mellanox.com, maxg@mellanox.com, elic@nvidia.com,
 maorg@mellanox.com, liao.pingfang@zte.com.cn, lkp@intel.com, lulu@redhat.com,
 rong.a.chen@intel.com, mst@redhat.com, saeedm@mellanox.com,
 andy.shevchenko@gmail.com, dan.carpenter@oracle.com, wang.yi59@zte.com.cn,
 parav@mellanox.com, leonro@mellanox.com, wenan.mao@linux.alibaba.com,
 alex.dewar@gmx.co.uk, virtualization@lists.linux-foundation.org,
 netdev@vger.kernel.org, cohuck@redhat.com, gustavoars@kernel.org,
 stable@vger.kernel.org, vgoyal@redhat.com, colin.king@canonical.com,
 lingshan.zhu@intel.com, Linus Torvalds <torvalds@linux-foundation.org>,
 tariqt@mellanox.com
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

The pull request you sent on Tue, 11 Aug 2020 04:56:13 -0400:

> https://git.kernel.org/pub/scm/linux/kernel/git/mst/vhost.git tags/for_linus

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/57b077939287835b9396a1c3b40d35609cf2fcb8

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
