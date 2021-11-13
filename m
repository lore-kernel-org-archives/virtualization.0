Return-Path: <SRS0=Fazc=QA=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81A44C433F5
	for <virtualization@archiver.kernel.org>; Sat, 13 Nov 2021 21:19:40 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 20FD661106
	for <virtualization@archiver.kernel.org>; Sat, 13 Nov 2021 21:19:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 20FD661106
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id D6A4140170;
	Sat, 13 Nov 2021 21:19:39 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id QhOuEJySCXzA; Sat, 13 Nov 2021 21:19:38 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id C7BF840003;
	Sat, 13 Nov 2021 21:19:37 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 9E28DC002E;
	Sat, 13 Nov 2021 21:19:37 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 47CC0C0012
 for <virtualization@lists.linux-foundation.org>;
 Sat, 13 Nov 2021 21:19:36 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 2463B80D8C
 for <virtualization@lists.linux-foundation.org>;
 Sat, 13 Nov 2021 21:19:36 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=kernel.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id XxDLQif5nkW5
 for <virtualization@lists.linux-foundation.org>;
 Sat, 13 Nov 2021 21:19:35 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 21F2480D54
 for <virtualization@lists.linux-foundation.org>;
 Sat, 13 Nov 2021 21:19:35 +0000 (UTC)
Received: by mail.kernel.org (Postfix) with ESMTPS id AF46560D07;
 Sat, 13 Nov 2021 21:19:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1636838374;
 bh=AdAFjr2E1kgk10DpWSrMO9FTB/U9IdpE79E0Onj7Txk=;
 h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
 b=jcPmXPbeIAHOQnIfWOXnt14kFSGqfmUMzM/6iL29/Kcutjx3hb5h/IrI0HiLIef15
 +mZFks48WM8q7Zt6Iru9OBlfNQL80Fy3I7Buj1qjuUume4m1k08C5J3Kepvri/Oywc
 UK1vi7wbI8hQNcPSffd4rBu3cI76fyQuUUEp2xBdAsWZPTw0ZNi1dqrJKgZbX9wdCj
 TfubwdP72uZMhjw0fHsZD0IsxqrersYQPnDB15zR4+Uh8UguXNwYKB5jwHaqb76Zk1
 uwbUhog4ak13fkUKMZem5AvtggUQroTcXTub58c3no4dm1HZxHmVpMXGNCiPLibwjn
 Rtb/u8Y7U5CEQ==
Subject: Re: [GIT PULL] virtio-mem changes for v5.16
From: pr-tracker-bot@kernel.org
In-Reply-To: <20211110163754.27528-1-david@redhat.com>
References: <20211110163754.27528-1-david@redhat.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20211110163754.27528-1-david@redhat.com>
X-PR-Tracked-Remote: https://github.com/davidhildenbrand/linux.git
 tags/virtio-mem-for-5.16
X-PR-Tracked-Commit-Id: 61082ad6a6e1f999eef7e7e90046486c87933b1e
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: ccfff0a2bd2a30de130b5623d242ddecd0272bc2
Message-Id: <163683837468.5975.7292928272412230367.pr-tracker-bot@kernel.org>
Date: Sat, 13 Nov 2021 21:19:34 +0000
To: David Hildenbrand <david@redhat.com>
Cc: "Michael S . Tsirkin" <mst@redhat.com>,
 Linus Torvalds <torvalds@linux-foundation.org>, linux-kernel@vger.kernel.org,
 virtualization@lists.linux-foundation.org
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

The pull request you sent on Wed, 10 Nov 2021 17:37:54 +0100:

> https://github.com/davidhildenbrand/linux.git tags/virtio-mem-for-5.16

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/ccfff0a2bd2a30de130b5623d242ddecd0272bc2

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
