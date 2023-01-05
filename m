Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2E81DC54E76
	for <virtualization@archiver.kernel.org>; Thu,  5 Jan 2023 01:22:53 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 8CA8F610F3;
	Thu,  5 Jan 2023 01:22:52 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 8CA8F610F3
Authentication-Results: smtp3.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=gB2WDuUS
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id RuyZiCUQEzXw; Thu,  5 Jan 2023 01:22:51 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 2C4F8610EC;
	Thu,  5 Jan 2023 01:22:51 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 2C4F8610EC
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id ED06DC0033;
	Thu,  5 Jan 2023 01:22:50 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 2789CC002D
 for <virtualization@lists.linux-foundation.org>;
 Thu,  5 Jan 2023 01:22:50 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id E28E940121
 for <virtualization@lists.linux-foundation.org>;
 Thu,  5 Jan 2023 01:22:49 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org E28E940121
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.a=rsa-sha256 header.s=k20201202 header.b=gB2WDuUS
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id ZXeCRgGbKruA
 for <virtualization@lists.linux-foundation.org>;
 Thu,  5 Jan 2023 01:22:47 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 40503400C4
Received: from ams.source.kernel.org (ams.source.kernel.org
 [IPv6:2604:1380:4601:e00::1])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 40503400C4
 for <virtualization@lists.linux-foundation.org>;
 Thu,  5 Jan 2023 01:22:47 +0000 (UTC)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ams.source.kernel.org (Postfix) with ESMTPS id 5094FB81986;
 Thu,  5 Jan 2023 01:22:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 08456C433EF;
 Thu,  5 Jan 2023 01:22:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1672881763;
 bh=ExpxEIguBmVK6mxVxd9YEswT2YfPe7zBo9G4esPP838=;
 h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
 b=gB2WDuUS6KfnjtiNTPNPRUmG7LTic9mE03cppW5NPP7t0t9t+u0GUaulFtbsBOxF5
 5XNUk7b41IY8FT4LCmSZ4RXd4Wb2AAJjc46tBcGlaZ9jY7CNjvyVhwo7u5SFa+Lqub
 l0Evofho7p9aeXb89IXIyVlCwB/+hdM6az/Qdsx81px8S6ON12J+VwJSWK6RzIvQq7
 9bNjQz5Bv8YHpEQNtJoNDD8DAzGWXvU6Q9fcrdoKd3teJuMECR/9VUCJ1IwbroM3yx
 cLuUFfL9KBkwJawIdgpQSJpSpOObUvt+w+zuTVD5Aq/xf/6OqxDzIzGK/fLar6AZ/H
 Qwnjxb/zz8D6g==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org
 (localhost.localdomain [127.0.0.1])
 by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id
 E6A2FE57249; Thu,  5 Jan 2023 01:22:42 +0000 (UTC)
Subject: Re: [GIT PULL v2] virtio,vhost,vdpa: fixes, cleanups
From: pr-tracker-bot@kernel.org
In-Reply-To: <20230103104946-mutt-send-email-mst@kernel.org>
References: <20230103104946-mutt-send-email-mst@kernel.org>
X-PR-Tracked-List-Id: <kvm.vger.kernel.org>
X-PR-Tracked-Message-Id: <20230103104946-mutt-send-email-mst@kernel.org>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/mst/vhost.git tags/for_linus
X-PR-Tracked-Commit-Id: a26116c1e74028914f281851488546c91cbae57d
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 41c03ba9beea760bd2d2ac9250b09a2e192da2dc
Message-Id: <167288176293.29184.569668467593245088.pr-tracker-bot@kernel.org>
Date: Thu, 05 Jan 2023 01:22:42 +0000
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: kvm@vger.kernel.org, mst@redhat.com, dmitry.fomichev@wdc.com,
 yuancan@huawei.com, virtualization@lists.linux-foundation.org,
 shaoqin.huang@intel.com, weiyongjun1@huawei.com, set_pte_at@outlook.com,
 elic@nvidia.com, dave@stgolabs.net, lulu@redhat.com, ruanjinjie@huawei.com,
 sunnanyong@huawei.com, rafaelmendsr@gmail.com, pizhenwei@bytedance.com,
 eperezma@redhat.com, angus.chen@jaguarmicro.com, colin.i.king@gmail.com,
 harshit.m.mogalapalli@oracle.com, wangjianli@cdjrlc.com,
 gautam.dawar@xilinx.com, dengshaomin@cdjrlc.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org,
 Linus Torvalds <torvalds@linux-foundation.org>, wangrong68@huawei.com
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

The pull request you sent on Tue, 3 Jan 2023 10:49:46 -0500:

> https://git.kernel.org/pub/scm/linux/kernel/git/mst/vhost.git tags/for_linus

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/41c03ba9beea760bd2d2ac9250b09a2e192da2dc

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
