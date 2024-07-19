Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B83D148312
	for <virtualization@lists.linux-foundation.org>; Fri, 19 Jul 2024 19:38:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721417910; cv=none; b=c3FF3a+AqN0snLW59adpIyNjZX6hBRQ6y01kdxmm+Xqz02oVPt/F6Bw6cRbIVc0fdguXNwjoyZJtNpmEzCmxm2mSKODBnl4l7LcEsFecmL5k3qBnmOiFu7LXgmwvp6/xrawJbQvHxTQSYHJSQV6HSDaSNTvhmBLmwWdfahkan68=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721417910; c=relaxed/simple;
	bh=NWxD6l+tF/NnFkaZBW9wWD7Mbr238N1lcgMrmU841ac=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=f7E6tQ/0MvDuodPtK1KFW8/vBs9V1NZr4L7EfWo6vxlvXGdbYWLZ+Uve4fnL0SSHWvXE6SZSaDeAG0iWPYxqjSNSzBaoQnaSg6gQbO7j8PwS1MH1Txkt89Ru5Sy2qSyZgs6xqNkSuhRciSLES+BxRiv3FzSFbRDwhqqNCLMQ2+0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=S1Oj05aE; arc=none smtp.client-ip=140.211.166.136
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="S1Oj05aE"
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id B454360804
	for <virtualization@lists.linux-foundation.org>; Fri, 19 Jul 2024 19:38:28 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -4.401
X-Spam-Level:
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id bAO-JPMRdgdQ for <virtualization@lists.linux-foundation.org>;
 Fri, 19 Jul 2024 19:38:28 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2604:1380:40e1:4800::1; helo=sin.source.kernel.org; envelope-from=pr-tracker-bot@kernel.org; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org ADD22605F5
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=none dis=none) header.from=kernel.org
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org ADD22605F5
Authentication-Results: smtp3.osuosl.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=S1Oj05aE
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
	by smtp3.osuosl.org (Postfix) with ESMTPS id ADD22605F5
	for <virtualization@lists.linux-foundation.org>; Fri, 19 Jul 2024 19:38:27 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sin.source.kernel.org (Postfix) with ESMTP id 972D3CE08D5;
	Fri, 19 Jul 2024 19:38:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id D53CEC4AF0A;
	Fri, 19 Jul 2024 19:38:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721417902;
	bh=NWxD6l+tF/NnFkaZBW9wWD7Mbr238N1lcgMrmU841ac=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=S1Oj05aEkv1Rq7+5YWuTNb+c31C6T7n7dlmWIk0GI46m1Ifi+jb67QW1POoLQe9yp
	 vrMQjFMtCnxOUNezVTJ/l3MBSGsUT1/CBSYKiUpiBN9c1RMeI6/x4ohp2ouRENfKzy
	 aVDrX7StH3MufZwvUVietRcChvbQ7UJCH00xN6qxZt8VChmKeB6+oH/4DIOzVS2m38
	 kD6osb6RFRvAszTEHhQITeGPKYI0biZ1cte/+6QZ4RL9f/6vitGSwtjDfLaE9oE0fe
	 Ddtwf2eTmg7I9Yhr85dV8yEoTwr+HwOxqmdd5Xbk7PArAjr4iQb8LgcXV3bNohsDng
	 09iiFV5rTS5qA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id C8C62C4332D;
	Fri, 19 Jul 2024 19:38:22 +0000 (UTC)
Subject: Re: [GIT PULL] virtio: features, fixes, cleanups
From: pr-tracker-bot@kernel.org
In-Reply-To: <20240717053034-mutt-send-email-mst@kernel.org>
References: <20240717053034-mutt-send-email-mst@kernel.org>
X-PR-Tracked-List-Id: <netdev.vger.kernel.org>
X-PR-Tracked-Message-Id: <20240717053034-mutt-send-email-mst@kernel.org>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/mst/vhost.git tags/for_linus
X-PR-Tracked-Commit-Id: 6c85d6b653caeba2ef982925703cbb4f2b3b3163
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: f4f92db4391285ef3a688cdad25d5c76db200a30
Message-Id: <172141790281.26000.2833728574962008166.pr-tracker-bot@kernel.org>
Date: Fri, 19 Jul 2024 19:38:22 +0000
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, kvm@vger.kernel.org, virtualization@lists.linux-foundation.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, aha310510@gmail.com, arefev@swemel.ru, arseny.krasnov@kaspersky.com, davem@davemloft.net, dtatulea@nvidia.com, eperezma@redhat.com, glider@google.com, iii@linux.ibm.com, jasowang@redhat.com, jiri@nvidia.com, jiri@resnulli.us, kuba@kernel.org, lingshan.zhu@intel.com, mst@redhat.com, ndabilpuram@marvell.com, pgootzen@nvidia.com, pizhenwei@bytedance.com, quic_jjohnson@quicinc.com, schalla@marvell.com, stefanha@redhat.com, sthotton@marvell.com, syzbot+6c21aeb59d0e82eb2782@syzkaller.appspotmail.com, vattunuru@marvell.com, will@kernel.org, xuanzhuo@linux.alibaba.com, yskelg@gmail.com
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>

The pull request you sent on Wed, 17 Jul 2024 05:30:34 -0400:

> https://git.kernel.org/pub/scm/linux/kernel/git/mst/vhost.git tags/for_linus

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/f4f92db4391285ef3a688cdad25d5c76db200a30

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
