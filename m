Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED636242D72
	for <virtualization@lists.linux-foundation.org>; Fri, 21 Aug 2026 00:11:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787271083; cv=none; b=b67o1RTaYgSw9r14krRrxphKDtFhbdl1ooLmucQMB6vQngnHgzoGPBCJ+Cf40Lf6aYgi6Vyb46jEkfbOWUt11hiv2VLUZmBdL0kGE/DRD1wFIlxgakrse4vekH/fBrATYZ4hs/N1iGJ8TA/EtbrauCf3AbQfFW41VOmW7jix1Tg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787271083; c=relaxed/simple;
	bh=9hUgGEreFwFPuEvjfCDr8xlZlYy4DYhbfja55WfQixc=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=rIDjVUFuMy6/bnC+4WwMhIIibIhRsop5p7f0dtMuj0O1+gdVk/6/iVqTQjvu7FSRSwJuyD0Nc5WSybSn8AZ87/bj7+xRYTJ8jbWNdUUdDkERgP2JgMMG9+NFT0o9Ou3S61GiWoB/BEOE15wY/ldUM5dhpAPXgNsWGk0WiWniDCs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=diptitNN; arc=none smtp.client-ip=140.211.166.133
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="diptitNN"
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 730C14006B
	for <virtualization@lists.linux-foundation.org>; Fri, 21 Aug 2026 00:11:18 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -2.101
X-Spam-Level:
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id YDTp2iBN2zIQ for <virtualization@lists.linux-foundation.org>;
 Fri, 21 Aug 2026 00:11:17 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=pr-tracker-bot@kernel.org; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: smtp2.osuosl.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=diptitNN
Received: from tor.source.kernel.org (tor.source.kernel.org [IPv6:2600:3c04:e001:324:0:1991:8:25])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 970D740079
	for <virtualization@lists.linux-foundation.org>; Fri, 21 Aug 2026 00:11:16 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 1ECAD60A61;
	Fri, 21 Aug 2026 00:11:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C67121F000E9;
	Fri, 21 Aug 2026 00:11:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787271074;
	bh=VtxMgH/D+tWPzdttlkyqh6KK71n6PeivsVR/hRZbqW8=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc;
	b=diptitNN/DlAgctSQNCIBr2mujhI/Q8q1Z6uLvKiLC1+NbC1YEQZNBUi2dY3ZqXhn
	 SK1UcPBEZKYdOY5T/twVkxvF6XM8cfcYwqq7DRFeApRGQps5WxvS2Gj+R7DkPNOcjm
	 JwpNgDYXFTICsLhkwwKHQmgayuY0qQ8kjeLYUHjh1FoPpf8EbPdcAto1RdKd3XKglU
	 rKuZ8DOpw1NBmuDrO0kI6p9iAn8wi9oCHVYh11yU+MJWyFWdn4gi+ClIQqSi5ewnug
	 nE3DNm9GTYQtpmtOdo7OMg1sGKhYi9ACGTvKfbDBzAs2dahptUjd4DyRAsQuW/pEJ8
	 nLeubaw1kVj3A==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 19DB93924472;
	Fri, 21 Aug 2026 00:10:26 +0000 (UTC)
Subject: Re: [GIT PULL] vhost,vdpa,virtio: fixes, features
From: pr-tracker-bot@kernel.org
In-Reply-To: <20260819124604-mutt-send-email-mst@kernel.org>
References: <20260819124604-mutt-send-email-mst@kernel.org>
X-PR-Tracked-List-Id: <stable.vger.kernel.org>
X-PR-Tracked-Message-Id: <20260819124604-mutt-send-email-mst@kernel.org>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/mst/vhost.git tags/for_linus
X-PR-Tracked-Commit-Id: b282418bc366194677eafd1dad180d92254586ac
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 7f063b2f17eaba2a35e251aa53627f2a70d536e2
Message-Id: <178727102496.546823.16524833429188272058.pr-tracker-bot@kernel.org>
Date: Fri, 21 Aug 2026 00:10:24 +0000
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, kvm@vger.kernel.org, virtualization@lists.linux-foundation.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, aesteve@redhat.com, ben.dooks@codethink.co.uk, chenyichong@uniontech.com, david@kernel.org, den@openvz.org, eperezma@redhat.com, gsomlo@gmail.com, hexlabsecurity@proton.me, linfeng.sun.dev@gamil.com, lirongqing@baidu.com, me@linux.beauty, mst@redhat.com, panchuang@vivo.com, pankaj.gupta.linux@gmail.com, pengpeng@iscas.ac.cn, peter.hilber@oss.qualcomm.com, sgarzare@redhat.com, stable@vger.kernel.org, syzbot+28e5f3d207b14bae122a@syzkaller.appspotmail.com, tavip@google.com, wangyufeng@kylinos.cn, xiongweimin@kylinos.cn, xiongwm2026@163.com, yangjinqian1@huawei.com, zhaoguohan@kylinos.cn
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>

The pull request you sent on Wed, 19 Aug 2026 12:46:04 -0400:

> https://git.kernel.org/pub/scm/linux/kernel/git/mst/vhost.git tags/for_linus

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/7f063b2f17eaba2a35e251aa53627f2a70d536e2

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
