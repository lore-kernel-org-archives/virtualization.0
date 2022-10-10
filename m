Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 03B60C43219
	for <virtualization@archiver.kernel.org>; Mon, 10 Oct 2022 21:23:53 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 7FFA840901;
	Mon, 10 Oct 2022 21:23:53 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 7FFA840901
Authentication-Results: smtp4.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=j5OHXjHs
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id TyZ3yVjDafeI; Mon, 10 Oct 2022 21:23:52 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 9EFFF408EE;
	Mon, 10 Oct 2022 21:23:51 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 9EFFF408EE
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 6B8C1C0032;
	Mon, 10 Oct 2022 21:23:51 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id D471DC002D
 for <virtualization@lists.linux-foundation.org>;
 Mon, 10 Oct 2022 21:23:49 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id B629140533
 for <virtualization@lists.linux-foundation.org>;
 Mon, 10 Oct 2022 21:23:49 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org B629140533
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.a=rsa-sha256 header.s=k20201202 header.b=j5OHXjHs
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id L6r7DaP3zLhL
 for <virtualization@lists.linux-foundation.org>;
 Mon, 10 Oct 2022 21:23:48 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 92D0B40291
Received: from dfw.source.kernel.org (dfw.source.kernel.org
 [IPv6:2604:1380:4641:c500::1])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 92D0B40291
 for <virtualization@lists.linux-foundation.org>;
 Mon, 10 Oct 2022 21:23:48 +0000 (UTC)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id 865C761035;
 Mon, 10 Oct 2022 21:23:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id E47ADC433D7;
 Mon, 10 Oct 2022 21:23:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1665437026;
 bh=LW6qbMwcNGlPWguPr3/tioF4lSPOeC7TNnM9SOAJNC8=;
 h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
 b=j5OHXjHstpAmokFGUNn/YWj1urnovTw1Poen8SZNuKNfbzPjWUNba/atuBvFAmCR+
 LLQGEsvzkDgX/9UGYhGOqCCFlwwMlARKMxFsnBeCzLH6igWRHz6PuUrP/SgzVprE/F
 J7oDAVdu8d7KUgeJAEOl0uNHolOZTcdKTBBlR/msJ37+eqfw/6bsbTm6o45rLno62I
 JZi7QNkjIdukUrd3hLcRUT3QqMdsq1bpurWlyBi93TcECQd8YYSOAFfwdMVcqhDHOD
 amXCndh9xl2LzVWe4guhjjkaLRzC9mQv6mxUVt/2aFGjmgcIpHV6tIEpVYRtMrWt8i
 l4X4Zvazet1zg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org
 (localhost.localdomain [127.0.0.1])
 by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id
 D2C29E2A05F; Mon, 10 Oct 2022 21:23:46 +0000 (UTC)
Subject: Re: [GIT PULL] virtio: fixes, features
From: pr-tracker-bot@kernel.org
In-Reply-To: <20221010132030-mutt-send-email-mst@kernel.org>
References: <20221010132030-mutt-send-email-mst@kernel.org>
X-PR-Tracked-List-Id: <netdev.vger.kernel.org>
X-PR-Tracked-Message-Id: <20221010132030-mutt-send-email-mst@kernel.org>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/mst/vhost.git tags/for_linus
X-PR-Tracked-Commit-Id: 71491c54eafa318fdd24a1f26a1c82b28e1ac21d
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 8aeab132e05fefc3a1a5277878629586bd7a3547
Message-Id: <166543702685.28157.12851164302122498438.pr-tracker-bot@kernel.org>
Date: Mon, 10 Oct 2022 21:23:46 +0000
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: xiujianfeng@huawei.com, kvm@vger.kernel.org, mst@redhat.com,
 netdev@vger.kernel.org, wangdeming@inspur.com, linux-kernel@vger.kernel.org,
 virtualization@lists.linux-foundation.org, angus.chen@jaguarmicro.com,
 lingshan.zhu@intel.com, Linus Torvalds <torvalds@linux-foundation.org>,
 gavinl@nvidia.com
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

The pull request you sent on Mon, 10 Oct 2022 13:20:30 -0400:

> https://git.kernel.org/pub/scm/linux/kernel/git/mst/vhost.git tags/for_linus

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/8aeab132e05fefc3a1a5277878629586bd7a3547

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
