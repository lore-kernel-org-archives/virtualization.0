Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7CF86C77B73
	for <virtualization@archiver.kernel.org>; Fri, 28 Apr 2023 00:31:32 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id EF362613C0;
	Fri, 28 Apr 2023 00:31:31 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org EF362613C0
Authentication-Results: smtp3.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=H5yOeknI
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id cl2c6QNciTKY; Fri, 28 Apr 2023 00:31:31 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 8A07861114;
	Fri, 28 Apr 2023 00:31:30 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 8A07861114
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 61EADC0037;
	Fri, 28 Apr 2023 00:31:30 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 48BBFC002A
 for <virtualization@lists.linux-foundation.org>;
 Fri, 28 Apr 2023 00:31:29 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 1F45141E02
 for <virtualization@lists.linux-foundation.org>;
 Fri, 28 Apr 2023 00:31:29 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 1F45141E02
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.a=rsa-sha256 header.s=k20201202 header.b=H5yOeknI
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 3Z63sxW4JWrW
 for <virtualization@lists.linux-foundation.org>;
 Fri, 28 Apr 2023 00:31:28 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 5D8E840176
Received: from dfw.source.kernel.org (dfw.source.kernel.org
 [IPv6:2604:1380:4641:c500::1])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 5D8E840176
 for <virtualization@lists.linux-foundation.org>;
 Fri, 28 Apr 2023 00:31:28 +0000 (UTC)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id 1C62064094;
 Fri, 28 Apr 2023 00:31:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 772CCC433EF;
 Fri, 28 Apr 2023 00:31:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1682641886;
 bh=Zi4kwNpK3pmjKReSeLMI8z1sNRFh0A4YXwF2UGLX3h0=;
 h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
 b=H5yOeknIL76bDURzilnRvk4gAZsh5tiT1EUeR6IBS5s+J5DVcytRjLAmPoI/uEVkD
 aSd3QE6FCJg1P5QLtXSWX1bOuLI3v/Um2a8+cD86zzGaSN/+2HHuekDim9CHt9GbOI
 vxgTtBMrJxK2O/4tUQJOCyrXitdVJdasPFnIb8S6PtJ1tHRwIK8SSEm2L74LEJVGL5
 83UCOm5WisTVWmlsDUEWoSmJodoqscrT26pRUWN0Q4KcHq2qFSYkcL5PUqFJNu6W3J
 5LtjHEKzMLaalQQs4+LCgwgzaF2EHOHOwJkEi6PUpszTnetChdMwp+Dk6V7w7kAIVa
 FUMkzbvg0ldHQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org
 (localhost.localdomain [127.0.0.1])
 by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id
 60F52E5FFC8; Fri, 28 Apr 2023 00:31:26 +0000 (UTC)
Subject: Re: [GIT PULL] virtio,vhost,vdpa: features, fixes, cleanups
From: pr-tracker-bot@kernel.org
In-Reply-To: <20230424174842-mutt-send-email-mst@kernel.org>
References: <20230424174842-mutt-send-email-mst@kernel.org>
X-PR-Tracked-List-Id: <kvm.vger.kernel.org>
X-PR-Tracked-Message-Id: <20230424174842-mutt-send-email-mst@kernel.org>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/mst/vhost.git tags/for_linus
X-PR-Tracked-Commit-Id: c82729e06644f4e087f5ff0f91b8fb15e03b8890
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 8ccd54fe45713cd458015b5b08d6098545e70543
Message-Id: <168264188639.7031.14210946422047570698.pr-tracker-bot@kernel.org>
Date: Fri, 28 Apr 2023 00:31:26 +0000
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: kvm@vger.kernel.org, mst@redhat.com, huangjie.albert@bytedance.com,
 simon.horman@corigine.com, virtualization@lists.linux-foundation.org,
 rongtao@cestc.cn, rtoax@foxmail.com, elic@nvidia.com,
 xuanzhuo@linux.alibaba.com, lulu@redhat.com, eperezma@redhat.com,
 viktor@daynix.com, jacob.e.keller@intel.com, fmdefrancesco@gmail.com,
 christophe.jaillet@wanadoo.fr, peter@n8pjl.ca, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org, xieyongji@bytedance.com,
 mie@igel.co.jp, horms@kernel.org,
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

The pull request you sent on Mon, 24 Apr 2023 17:48:42 -0400:

> https://git.kernel.org/pub/scm/linux/kernel/git/mst/vhost.git tags/for_linus

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/8ccd54fe45713cd458015b5b08d6098545e70543

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
