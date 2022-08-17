Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EF5BAC32771
	for <virtualization@archiver.kernel.org>; Wed, 17 Aug 2022 17:10:16 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 7F77983EE8;
	Wed, 17 Aug 2022 17:10:16 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 7F77983EE8
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=lh2NLK6B
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id yUCe7sVFimE3; Wed, 17 Aug 2022 17:10:15 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 1000E83EE2;
	Wed, 17 Aug 2022 17:10:15 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 1000E83EE2
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id BF840C0033;
	Wed, 17 Aug 2022 17:10:14 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id A8115C002D
 for <virtualization@lists.linux-foundation.org>;
 Wed, 17 Aug 2022 17:10:12 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 87DF483EE4
 for <virtualization@lists.linux-foundation.org>;
 Wed, 17 Aug 2022 17:10:12 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 87DF483EE4
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id EuF33UI2_R8D
 for <virtualization@lists.linux-foundation.org>;
 Wed, 17 Aug 2022 17:10:11 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org C470D83EE2
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
 by smtp1.osuosl.org (Postfix) with ESMTPS id C470D83EE2
 for <virtualization@lists.linux-foundation.org>;
 Wed, 17 Aug 2022 17:10:11 +0000 (UTC)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id 727CC6111F;
 Wed, 17 Aug 2022 17:10:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id D0C8FC433D6;
 Wed, 17 Aug 2022 17:10:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1660756209;
 bh=PRkPy6/BboxVIV4svm9kZjB5MPhqvOyWk7k0yChUSEg=;
 h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
 b=lh2NLK6BXqd3jz9ktIz9fK0BvVEdSVXL/eTMZnDmDa3j4ezjftH9YXoz6VO7jC5tp
 /rdF41HsFHgBaekQrr5/wDLIbtmJ1ZEPQxV7JQcxC0wwEvab955lPIDERfCnGJ5E4b
 V3Sst53simH3O1dfYehQaS6cBmy7LqUVQRCc465srhSNCpE87NHO0kEpsQVPAerG1E
 javztSvqXVHLrGjlvvLxAclEtXrVpgqIJ8YPtRpI5dIkI4UYmhjWcUc2gs6NjFfbBt
 xECBWetJK9BPtiTxtBNQd+TyktaaQN+Fr4W2D/18ZyVdz3vxm9cZ61AIUEfotJrXyu
 LEGh5rutQgjig==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org
 (localhost.localdomain [127.0.0.1])
 by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id
 B5F6DC43142; Wed, 17 Aug 2022 17:10:09 +0000 (UTC)
Subject: Re: [GIT PULL] virtio: fixes
From: pr-tracker-bot@kernel.org
In-Reply-To: <20220817063842-mutt-send-email-mst@kernel.org>
References: <20220817063842-mutt-send-email-mst@kernel.org>
X-PR-Tracked-List-Id: Linux virtualization
 <virtualization.lists.linux-foundation.org>
X-PR-Tracked-Message-Id: <20220817063842-mutt-send-email-mst@kernel.org>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/mst/vhost.git tags/for_linus
X-PR-Tracked-Commit-Id: 5c669c4a4c6aa0489848093c93b8029f5c5c75ec
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 274a2eebf80c60246f9edd6ef8e9a095ad121264
Message-Id: <166075620968.6865.11130017018985824267.pr-tracker-bot@kernel.org>
Date: Wed, 17 Aug 2022 17:10:09 +0000
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: kvm@vger.kernel.org, mst@redhat.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org,
 andres@anarazel.de, Linus Torvalds <torvalds@linux-foundation.org>,
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

The pull request you sent on Wed, 17 Aug 2022 06:38:42 -0400:

> https://git.kernel.org/pub/scm/linux/kernel/git/mst/vhost.git tags/for_linus

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/274a2eebf80c60246f9edd6ef8e9a095ad121264

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
