Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2D54CC4332F
	for <virtualization@archiver.kernel.org>; Sun,  5 Nov 2023 19:11:25 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id AF44F82095;
	Sun,  5 Nov 2023 19:11:24 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org AF44F82095
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=FyVuPQXT
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Gz7GmDmdUlgP; Sun,  5 Nov 2023 19:11:24 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 3CDAB82085;
	Sun,  5 Nov 2023 19:11:23 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 3CDAB82085
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 0CB57C0071;
	Sun,  5 Nov 2023 19:11:23 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 49C60C0032
 for <virtualization@lists.linux-foundation.org>;
 Sun,  5 Nov 2023 19:11:22 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 20723408EF
 for <virtualization@lists.linux-foundation.org>;
 Sun,  5 Nov 2023 19:11:22 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 20723408EF
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.a=rsa-sha256 header.s=k20201202 header.b=FyVuPQXT
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id TV0DtlFCZHuO
 for <virtualization@lists.linux-foundation.org>;
 Sun,  5 Nov 2023 19:11:21 +0000 (UTC)
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 22510400D6
 for <virtualization@lists.linux-foundation.org>;
 Sun,  5 Nov 2023 19:11:21 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 22510400D6
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by ams.source.kernel.org (Postfix) with ESMTP id 2F0CFB80B02;
 Sun,  5 Nov 2023 19:11:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 6F1D9C433C7;
 Sun,  5 Nov 2023 19:11:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1699211477;
 bh=fj+FVGAWPpO8O4n2zH2qGswvpwohotxhcBOI/kdauVY=;
 h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
 b=FyVuPQXTNhrbM6b1buXlqxjijt0f3WQu4hDFcnkGkk6C95speJxRgwIVZvadxu7eu
 pFHOYDTMnm6pwwL8Uw76DtzjVF9ecKGQ8Hb08qc0F+xpZ9l+nmME+wwxr7aW1DNkwN
 MYP/uubV6iV5/oQoYRRr7CDTUKR9IUsLmtxV6edyE4lR/wdwkuBT0wFrCWr/neh1ci
 zppVp8hFNVXLFakiCgEtfaN95w0dJbXn4U97119lF92QaLfmgMVRjwJ9F5zisHvUvx
 D+fR5pXZ/0NGnah6TmaXTBtO54db+qnenYKyIybqoFQFExaM8RDV+XU39QVoQ/H9ca
 1vcGqKszp2adw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org
 (localhost.localdomain [127.0.0.1])
 by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id
 5B186C395FC; Sun,  5 Nov 2023 19:11:17 +0000 (UTC)
Subject: Re: [GIT PULL] vhost,virtio,vdpa: features, fixes, cleanups
From: pr-tracker-bot@kernel.org
In-Reply-To: <20231105105806-mutt-send-email-mst@kernel.org>
References: <20231105105806-mutt-send-email-mst@kernel.org>
X-PR-Tracked-List-Id: Linux virtualization
 <virtualization.lists.linux-foundation.org>
X-PR-Tracked-Message-Id: <20231105105806-mutt-send-email-mst@kernel.org>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/mst/vhost.git tags/for_linus
X-PR-Tracked-Commit-Id: 86f6c224c97911b4392cb7b402e6a4ed323a449e
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 77fa2fbe87fc605c4bfa87dff87be9bfded0e9a3
Message-Id: <169921147736.31662.3355128222514557498.pr-tracker-bot@kernel.org>
Date: Sun, 05 Nov 2023 19:11:17 +0000
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: xuanzhuo@linux.alibaba.com, geert+renesas@glider.be, kvm@vger.kernel.org,
 mst@redhat.com, simon.horman@corigine.com,
 virtualization@lists.linux-foundation.org, xueshi.hu@smartx.com,
 pizhenwei@bytedance.com, linux-kernel@vger.kernel.org, xieyongji@bytedance.com,
 gregkh@linuxfoundation.org, leiyang@redhat.com, netdev@vger.kernel.org,
 shawn.shao@jaguarmicro.com, eperezma@redhat.com,
 Linus Torvalds <torvalds@linux-foundation.org>, leon@kernel.org
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

The pull request you sent on Sun, 5 Nov 2023 10:58:06 -0500:

> https://git.kernel.org/pub/scm/linux/kernel/git/mst/vhost.git tags/for_linus

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/77fa2fbe87fc605c4bfa87dff87be9bfded0e9a3

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
