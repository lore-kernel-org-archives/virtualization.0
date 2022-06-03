Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A9D72C43334
	for <virtualization@archiver.kernel.org>; Fri,  3 Jun 2022 18:50:17 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id A8C2E41BA2;
	Fri,  3 Jun 2022 18:50:16 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id W_AgTnGFEgJR; Fri,  3 Jun 2022 18:50:15 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 688E541B9F;
	Fri,  3 Jun 2022 18:50:14 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 2B0EBC0032;
	Fri,  3 Jun 2022 18:50:14 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id A6EC4C002D
 for <virtualization@lists.linux-foundation.org>;
 Fri,  3 Jun 2022 18:50:12 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 8DA99610C9
 for <virtualization@lists.linux-foundation.org>;
 Fri,  3 Jun 2022 18:50:12 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=kernel.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id x8RjVCMTSGYY
 for <virtualization@lists.linux-foundation.org>;
 Fri,  3 Jun 2022 18:50:11 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
 by smtp3.osuosl.org (Postfix) with ESMTPS id D70F1610C8
 for <virtualization@lists.linux-foundation.org>;
 Fri,  3 Jun 2022 18:50:11 +0000 (UTC)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id A4773619C5;
 Fri,  3 Jun 2022 18:50:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 030BCC385B8;
 Fri,  3 Jun 2022 18:50:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1654282210;
 bh=bOriYyJek/0gWTzeUpshNdx4hLR6hEcL+erxtFQ1q6Q=;
 h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
 b=Evqa9V+gShN4CKTki1Qc95yc8OQ6s9PLcauHwWuQWN/qHkuUNZ3Ib2o0b29gwpynZ
 FRgXrSMXOhDap47vgkuQWBTzhhSlqdXRt/x0Mm2Q7px6ynj/GTJtEY2YI8lCMm0foC
 tCzxlmZLw9mQEMDl6Ck+F4hfp9+VRvbgfh+AG/b1ERk5aKSf0lA34orC2kL0heSbP1
 KSyyYSWbqd8GlD1k7CqRTvyLLEhZbKDqDUFqCXaJU3Zqven3aHo0fD3BqHSRRQ0IbI
 Wvb9n5mPF5ea0BrsoYqVv8cJ4usD9SvY/gvd0zrWD7kgkOyV3Ja5WW7Y3ZE+OzLFsv
 SHtKdUIA0I91g==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org
 (localhost.localdomain [127.0.0.1])
 by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id
 E093BF03953; Fri,  3 Jun 2022 18:50:09 +0000 (UTC)
Subject: Re: [GIT PULL] vhost,virtio,vdpa: features, fixes, cleanups
From: pr-tracker-bot@kernel.org
In-Reply-To: <20220602161124-mutt-send-email-mst@kernel.org>
References: <20220602161124-mutt-send-email-mst@kernel.org>
X-PR-Tracked-List-Id: <netdev.vger.kernel.org>
X-PR-Tracked-Message-Id: <20220602161124-mutt-send-email-mst@kernel.org>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/mst/vhost.git tags/for_linus
X-PR-Tracked-Commit-Id: bd8bb9aed56b1814784a975e2dfea12a9adcee92
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 6e5f6a86915d65210e90acac0402e6f37e21fc7b
Message-Id: <165428220991.10974.157104839485276628.pr-tracker-bot@kernel.org>
Date: Fri, 03 Jun 2022 18:50:09 +0000
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: kvm@vger.kernel.org, mst@redhat.com, peterz@infradead.org,
 virtualization@lists.linux-foundation.org, vneethv@linux.ibm.com,
 elic@nvidia.com, tglx@linutronix.de, linux-s390@vger.kernel.org,
 helei.sig11@bytedance.com, lulu@redhat.com, xianting.tian@linux.alibaba.com,
 maz@kernel.org, zheyuma97@gmail.com, pizhenwei@bytedance.com,
 pasic@linux.ibm.com, eperezma@redhat.com, muriloo@linux.ibm.com,
 solomonbstoner@protonmail.ch, dan.carpenter@oracle.com, paulmck@kernel.org,
 liuke94@huawei.com, arbn@yandex-team.com, gdawar@xilinx.com,
 christophe.jaillet@wanadoo.fr, gautam.dawar@xilinx.com, suwan.kim027@gmail.com,
 lkp@intel.com, oberpar@linux.ibm.com, netdev@vger.kernel.org,
 cohuck@redhat.com, linux-kernel@vger.kernel.org, stable@vger.kernel.org,
 dinechin@redhat.com, lingshan.zhu@intel.com,
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

The pull request you sent on Thu, 2 Jun 2022 16:11:24 -0400:

> https://git.kernel.org/pub/scm/linux/kernel/git/mst/vhost.git tags/for_linus

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/6e5f6a86915d65210e90acac0402e6f37e21fc7b

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
