Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B5A35C433FE
	for <virtualization@archiver.kernel.org>; Tue, 18 Jan 2022 08:29:19 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 48ACA408DA;
	Tue, 18 Jan 2022 08:29:19 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id v0WtNOrjzaCW; Tue, 18 Jan 2022 08:29:18 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id E95A6408DD;
	Tue, 18 Jan 2022 08:29:17 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 91335C0039;
	Tue, 18 Jan 2022 08:29:17 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 65291C002F
 for <virtualization@lists.linux-foundation.org>;
 Tue, 18 Jan 2022 08:29:16 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 4711840438
 for <virtualization@lists.linux-foundation.org>;
 Tue, 18 Jan 2022 08:29:16 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=kernel.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id COU4FtiJODvp
 for <virtualization@lists.linux-foundation.org>;
 Tue, 18 Jan 2022 08:29:15 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from ams.source.kernel.org (ams.source.kernel.org
 [IPv6:2604:1380:4601:e00::1])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 30C5E40286
 for <virtualization@lists.linux-foundation.org>;
 Tue, 18 Jan 2022 08:29:15 +0000 (UTC)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ams.source.kernel.org (Postfix) with ESMTPS id 95B96B812A5;
 Tue, 18 Jan 2022 08:29:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 63F39C340E6;
 Tue, 18 Jan 2022 08:29:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1642494551;
 bh=ngfco9m5RC6ysn8lXvCShk4RMg7ryZFXstNW7rRs70s=;
 h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
 b=nhcZgJJAwlftay688HihdC7itWdxDr1blrDcqAzbPX8/Tf1XL53dPiTw7SG4tEGiq
 xtQ64e+0ILBF2cQkrSFPxdskWGLfLtxblp4HlLrPb8rnYkvyA88XyKevOyx8zVl2CX
 05YezsFNGU6h31ts6oB7zVpNZuAOZf1YA7JA7FAiG/wjznYGkCjh+9Um/wOVhbV+cm
 7G/ulkcgLqx33iBFCWBuxPLwk8HAkgy3GY/frWa62qHTYNy7+vd54qXonLtynKhgwQ
 bkEMvKrquMmQs97IJO1EI4YVhSvyt5rOmUzUPhoRNmNonbnGw64NwvHz/pGLu8Crnb
 JEsI7gXa4NW+Q==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org
 (localhost.localdomain [127.0.0.1])
 by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id
 4F20FF60797; Tue, 18 Jan 2022 08:29:11 +0000 (UTC)
Subject: Re: [GIT PULL v2] virtio,vdpa,qemu_fw_cfg: features, cleanups, fixes
From: pr-tracker-bot@kernel.org
In-Reply-To: <20220114185734-mutt-send-email-mst@kernel.org>
References: <20220114185734-mutt-send-email-mst@kernel.org>
X-PR-Tracked-List-Id: Linux virtualization
 <virtualization.lists.linux-foundation.org>
X-PR-Tracked-Message-Id: <20220114185734-mutt-send-email-mst@kernel.org>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/mst/vhost.git tags/for_linus
X-PR-Tracked-Commit-Id: b03fc43e73877e180c1803a33aea3e7396642367
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 3bf6a9e36e441714928d73a5adbc59562eb7ef19
Message-Id: <164249455131.3500.5357538951870066126.pr-tracker-bot@kernel.org>
Date: Tue, 18 Jan 2022 08:29:11 +0000
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: yun.wang@linux.alibaba.com, kvm@vger.kernel.org, mst@redhat.com,
 trix@redhat.com, flyingpeng@tencent.com,
 virtualization@lists.linux-foundation.org, elic@nvidia.com,
 guanjun@linux.alibaba.com, lkp@intel.com, xianting.tian@linux.alibaba.com,
 eperezma@redhat.com, luolikang@nsfocus.com, wu000273@umn.edu,
 lvivier@redhat.com, keescook@chromium.org, somlo@cmu.edu, jiasheng@iscas.ac.cn,
 johan@kernel.org, christophe.jaillet@wanadoo.fr, flyingpenghao@gmail.com,
 dapeng1.mi@intel.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 labbott@kernel.org, gregkh@linuxfoundation.org, lingshan.zhu@intel.com,
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

The pull request you sent on Fri, 14 Jan 2022 18:57:34 -0500:

> https://git.kernel.org/pub/scm/linux/kernel/git/mst/vhost.git tags/for_linus

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/3bf6a9e36e441714928d73a5adbc59562eb7ef19

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
