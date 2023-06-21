Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8245DEB64D8
	for <virtualization@archiver.kernel.org>; Wed, 21 Jun 2023 18:13:06 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id EB97A60FD5;
	Wed, 21 Jun 2023 18:13:05 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org EB97A60FD5
Authentication-Results: smtp3.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=Mpljp096
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id DRam3Ja8vBuv; Wed, 21 Jun 2023 18:13:05 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 8755E60F80;
	Wed, 21 Jun 2023 18:13:04 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 8755E60F80
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 65215C0037;
	Wed, 21 Jun 2023 18:13:04 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id B3BD4C0029
 for <virtualization@lists.linux-foundation.org>;
 Wed, 21 Jun 2023 18:13:02 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 8DC6460FD5
 for <virtualization@lists.linux-foundation.org>;
 Wed, 21 Jun 2023 18:13:02 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 8DC6460FD5
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id vSHfCp5bCePp
 for <virtualization@lists.linux-foundation.org>;
 Wed, 21 Jun 2023 18:13:01 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org BBE2560F80
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
 by smtp3.osuosl.org (Postfix) with ESMTPS id BBE2560F80
 for <virtualization@lists.linux-foundation.org>;
 Wed, 21 Jun 2023 18:13:01 +0000 (UTC)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id A058461658;
 Wed, 21 Jun 2023 18:13:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 12CE9C433C8;
 Wed, 21 Jun 2023 18:13:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1687371180;
 bh=JXqUTk3bAL7lIp/+McuHuC6bhVEpHHo5RmL3WoZgySM=;
 h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
 b=Mpljp096lG/UOs983g+oL+GsTsdc4r3G+2alw0KJjQFaC1WpkF1tNF9oh8FXA+3iZ
 CbO+IfHWL1mWmqttHiY66eRDNTu6E/RcxNbQPwWvVlxAA6zqhf6xkBhxX3UafUWrZk
 BEdzZH4Ccfx7dAwaLx4LVc4yWNZdp8gwtnHMb/ne9DV0EFeD7X/o+3eGJR1u/9IeI0
 mDnc7M+cll5/W+erxd81Fm6AbXfN6GAHeUba6vvjmiRzhGmMa+F6GUXpX2EUJ24GHb
 Wcf40u1O7jeAyDsaQ8z/dPk6WbewiSmgCVrXb11r4rmqvgGXE4Gj4PBVeq+bPRwY5Y
 1ZpwP/63yiIsw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org
 (localhost.localdomain [127.0.0.1])
 by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id
 EF8B3C395C7; Wed, 21 Jun 2023 18:12:59 +0000 (UTC)
Subject: Re: [GIT PULL] virtio: last minute revert
From: pr-tracker-bot@kernel.org
In-Reply-To: <20230621110431-mutt-send-email-mst@kernel.org>
References: <20230621110431-mutt-send-email-mst@kernel.org>
X-PR-Tracked-List-Id: <netdev.vger.kernel.org>
X-PR-Tracked-Message-Id: <20230621110431-mutt-send-email-mst@kernel.org>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/mst/vhost.git tags/for_linus
X-PR-Tracked-Commit-Id: afd384f0dbea2229fd11159efb86a5b41051c4a9
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 007034977130b49b618a5206aad54f634d9f169c
Message-Id: <168737117997.28078.10365893103159189763.pr-tracker-bot@kernel.org>
Date: Wed, 21 Jun 2023 18:12:59 +0000
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: suwan.kim027@gmail.com, lkp@intel.com, kvm@vger.kernel.org, mst@redhat.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 virtualization@lists.linux-foundation.org, martin.roberts@intel.com,
 Linus Torvalds <torvalds@linux-foundation.org>, edliaw@google.com
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

The pull request you sent on Wed, 21 Jun 2023 11:04:31 -0400:

> https://git.kernel.org/pub/scm/linux/kernel/git/mst/vhost.git tags/for_linus

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/007034977130b49b618a5206aad54f634d9f169c

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
