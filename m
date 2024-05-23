Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D7AE84D06
	for <virtualization@lists.linux-foundation.org>; Thu, 23 May 2024 19:28:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716492487; cv=none; b=L2A6P98tT/wNoI9a3MveyS4uBKdWlMpF5rQYF1DbkS7D6izI1XKaZND3EIViIw1XV3nzytbGLLJICNc30gvCNKmci5Vd2HnLYEwyHABI+YuZGkKD4j4SrofEODe0qsl1iYRHWX/WvFviSGJJ6+PbJbHv365yG4l89sWZ1KhwXO4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716492487; c=relaxed/simple;
	bh=tvcn4t4beKheL9H/x+fSj1XLbpUqByppEr7H5kgRrHU=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=ICObQNvkGPgP6c4jpu+vQ05nWN632O/E5Kt3fIa4hZKNxS7pCoQmS3Y1pawTWa5z3EoqwufsvZ4wzXGU3GXvqugAuM8wxsmVQJVPwNMla6VsAXoOVl85q3SWptzVqiKCShZvC2aWe3HSXESR9OtRARb3SirHyipl0ps6XTgyRsY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ax57mVbZ; arc=none smtp.client-ip=140.211.166.136
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ax57mVbZ"
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id EF2D460ADF
	for <virtualization@lists.linux-foundation.org>; Thu, 23 May 2024 19:28:05 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -4.401
X-Spam-Level:
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id IlionZlmx54y for <virtualization@lists.linux-foundation.org>;
 Thu, 23 May 2024 19:28:05 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2604:1380:4641:c500::1; helo=dfw.source.kernel.org; envelope-from=pr-tracker-bot@kernel.org; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org 1C26C60817
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=none dis=none) header.from=kernel.org
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 1C26C60817
Authentication-Results: smtp3.osuosl.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=ax57mVbZ
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 1C26C60817
	for <virtualization@lists.linux-foundation.org>; Thu, 23 May 2024 19:28:04 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 8A0C862836;
	Thu, 23 May 2024 19:28:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 3AC84C2BD10;
	Thu, 23 May 2024 19:28:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716492483;
	bh=tvcn4t4beKheL9H/x+fSj1XLbpUqByppEr7H5kgRrHU=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=ax57mVbZ01Feg1Y+eRtIEc0Bpwsir089k06Zmh/FcSPpS8nvNs0Im9fHm9hOW/Ixl
	 3LSVrx/zSjsOaK1HCNbcA4CiDEGSRYP5CFRXeuaoj3UlBr9L8i4035q1rvYG33e1Ea
	 1gyM8KBI+TT+xDa8OL9TvJgIOtxEoHdBARgFi7zGGs3SzRQ1/krryGguCiqMPDccHd
	 DNXf9As4IOkVdyA0+HoHnH4Q6BDh4YPD6YhZzQ/sVprEtYsczcIVwlkHSqHrkxzuYm
	 WMjX9U6ccgYQrAEUuEdMZzPHQvi73DuE+htx2gVTu+512Jm5IFSe6wRSn020anRKTb
	 5XUmBuW5vQUTw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 281E9C43617;
	Thu, 23 May 2024 19:28:03 +0000 (UTC)
Subject: Re: [GIT PULL v2] virtio: features, fixes, cleanups
From: pr-tracker-bot@kernel.org
In-Reply-To: <Zk7bX3XlEWtaPbxZ@redhat.com>
References: <Zk7bX3XlEWtaPbxZ@redhat.com>
X-PR-Tracked-List-Id: <netdev.vger.kernel.org>
X-PR-Tracked-Message-Id: <Zk7bX3XlEWtaPbxZ@redhat.com>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/mst/vhost.git tags/for_linus
X-PR-Tracked-Commit-Id: c8fae27d141a32a1624d0d0d5419d94252824498
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 2ef32ad2241340565c35baf77fc95053c84eeeb0
Message-Id: <171649248315.6115.15871807359949037854.pr-tracker-bot@kernel.org>
Date: Thu, 23 May 2024 19:28:03 +0000
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, kvm@vger.kernel.org, virtualization@lists.linux-foundation.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, anton.yakovlev@opensynergy.com, bartosz.golaszewski@linaro.org, christophe.jaillet@wanadoo.fr, dave.jiang@intel.com, david@redhat.com, eperezma@redhat.com, herbert@gondor.apana.org.au, jasowang@redhat.com, jiri@nvidia.com, jiri@resnulli.us, johannes@sipsolutions.net, krzysztof.kozlowski@linaro.org, lingshan.zhu@intel.com, linus.walleij@linaro.org, lizhijian@fujitsu.com, martin.petersen@oracle.com, maxime.coquelin@redhat.com, michael.christie@oracle.com, mst@redhat.com, sgarzare@redhat.com, stevensd@chromium.org, sudeep.holla@arm.com, syzbot+98edc2df894917b3431f@syzkaller.appspotmail.com, u.kleine-koenig@pengutronix.de, viresh.kumar@linaro.org, xuanzhuo@linux.alibaba.com, yuxue.liu@jaguarmicro.com, zhanglikernel@gmail.com, Srujana Challa <schalla@marvell.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>

The pull request you sent on Thu, 23 May 2024 02:00:17 -0400:

> https://git.kernel.org/pub/scm/linux/kernel/git/mst/vhost.git tags/for_linus

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/2ef32ad2241340565c35baf77fc95053c84eeeb0

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
