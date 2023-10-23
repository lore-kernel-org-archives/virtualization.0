Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 81072C25B46
	for <virtualization@archiver.kernel.org>; Mon, 23 Oct 2023 18:03:40 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 19F2E612B7;
	Mon, 23 Oct 2023 18:03:40 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 19F2E612B7
Authentication-Results: smtp3.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=CTid+8Kp
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id LV3MUM5elpXQ; Mon, 23 Oct 2023 18:03:39 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 8FEAD60F0A;
	Mon, 23 Oct 2023 18:03:38 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 8FEAD60F0A
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 6D4B8C0071;
	Mon, 23 Oct 2023 18:03:38 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 0C752C0032
 for <virtualization@lists.linux-foundation.org>;
 Mon, 23 Oct 2023 18:03:33 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id DB9E9612B7
 for <virtualization@lists.linux-foundation.org>;
 Mon, 23 Oct 2023 18:03:32 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org DB9E9612B7
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id ln8TrLYzZsD9
 for <virtualization@lists.linux-foundation.org>;
 Mon, 23 Oct 2023 18:03:32 +0000 (UTC)
Received: from ams.source.kernel.org (ams.source.kernel.org
 [IPv6:2604:1380:4601:e00::1])
 by smtp3.osuosl.org (Postfix) with ESMTPS id DCBA660F0A
 for <virtualization@lists.linux-foundation.org>;
 Mon, 23 Oct 2023 18:03:31 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org DCBA660F0A
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by ams.source.kernel.org (Postfix) with ESMTP id 11D1BB81F48;
 Mon, 23 Oct 2023 18:03:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 6A741C433C9;
 Mon, 23 Oct 2023 18:03:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1698084208;
 bh=XO15aQ4OaTTwsEmZcdXBiWanfxRs+POYEmcfVMrr2lw=;
 h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
 b=CTid+8KpEObxYzsmWNTkSTB3TZ7cfgnFSx3Lm3oOYagfFERmHC2k5TA8M1oHTFqHc
 t/1DVjyduRj3cE8NbE/OT/v93W2Z43a3NaO8R/pvXQXN9Fxv9jha0Qm1e7qxExnAsi
 WcuKsYtWoo+9CDWPZ9RWQJk/PD34TRlAr92B4HauLNYikhQpV9EJylX/F+kVfoNWw2
 lzhaXev0drhvOOKvE2nA7SEZwcJwOOaV3R7fgd/1yqWguWdvFAo1HprWMjD1tCl0Iz
 vfE96Zi2U6jYPk5cd2/xVuiKZPlYCqchq6oieryg9XWvNnCSwCvJJsFG7BlFWCDRGe
 WL/id1mV2QNfw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org
 (localhost.localdomain [127.0.0.1])
 by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id
 57A55E4CC11; Mon, 23 Oct 2023 18:03:28 +0000 (UTC)
Subject: Re: [GIT PULL] virtio: last minute fixes
From: pr-tracker-bot@kernel.org
In-Reply-To: <20231023010207-mutt-send-email-mst@kernel.org>
References: <20231023010207-mutt-send-email-mst@kernel.org>
X-PR-Tracked-List-Id: <kvm.vger.kernel.org>
X-PR-Tracked-Message-Id: <20231023010207-mutt-send-email-mst@kernel.org>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/mst/vhost.git tags/for_linus
X-PR-Tracked-Commit-Id: 061b39fdfe7fd98946e67637213bcbb10a318cca
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 7c14564010fc1d0f16ca7d39b0ff948b43344209
Message-Id: <169808420834.25326.6759202324452461756.pr-tracker-bot@kernel.org>
Date: Mon, 23 Oct 2023 18:03:28 +0000
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: xuanzhuo@linux.alibaba.com, pizhenwei@bytedance.com, kvm@vger.kernel.org,
 mst@redhat.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 liming.wu@jaguarmicro.com, virtualization@lists.linux-foundation.org,
 pasic@linux.ibm.com, eric.auger@redhat.com, mheyne@amazon.de,
 catalin.marinas@arm.com, shawn.shao@jaguarmicro.com, zhenyzha@redhat.com,
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

The pull request you sent on Mon, 23 Oct 2023 01:02:07 -0400:

> https://git.kernel.org/pub/scm/linux/kernel/git/mst/vhost.git tags/for_linus

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/7c14564010fc1d0f16ca7d39b0ff948b43344209

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
