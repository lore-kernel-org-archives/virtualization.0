Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A44818A92F
	for <virtualization@lists.linux-foundation.org>; Mon, 29 Jul 2024 20:16:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722284187; cv=none; b=hkwxWN0AdTQ+bx6XV97ElgqZbkhKIiV3Lo8peaRYihuuZ9/CDo33BTD8AkePBGVtu/ZG9GF5xMumZp7aEnYuPIS5wkepkd1m19OoBR494HXoRwJJ96IWBIGg7Ujl0K2g9XgYaTs6jCMVQPhnyHgCHS58sJYY/v1RQafLo/23l3o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722284187; c=relaxed/simple;
	bh=W6KAHewPqBWvTYeXUfCgX1Srngxie2xftkjBbCQbEF4=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=M05HeATkYjKIrjcN+mEAJYy0zpkUswq3Q4vy0OFoE3mxfaSvYrF9c7l308D07IuBYY2JfSOMKWkNnM4EAY80kdjt0nRts0ER/MLXlYb++GgdiAvHItji2PhF1fqrcW/9+XCRbBC1QZuWqbJKERil4CrrphMIxGk62IpIRyJqdrE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=s8noHZtj; arc=none smtp.client-ip=140.211.166.138
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="s8noHZtj"
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 680A080D85
	for <virtualization@lists.linux-foundation.org>; Mon, 29 Jul 2024 20:16:25 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -7.101
X-Spam-Level:
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id VC8DrjD2oF_M for <virtualization@lists.linux-foundation.org>;
 Mon, 29 Jul 2024 20:16:24 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=139.178.84.217; helo=dfw.source.kernel.org; envelope-from=pr-tracker-bot@kernel.org; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org A2FF080D77
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=none dis=none) header.from=kernel.org
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org A2FF080D77
Authentication-Results: smtp1.osuosl.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=s8noHZtj
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
	by smtp1.osuosl.org (Postfix) with ESMTPS id A2FF080D77
	for <virtualization@lists.linux-foundation.org>; Mon, 29 Jul 2024 20:16:24 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 752D560D58;
	Mon, 29 Jul 2024 20:16:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 28276C32786;
	Mon, 29 Jul 2024 20:16:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722284183;
	bh=W6KAHewPqBWvTYeXUfCgX1Srngxie2xftkjBbCQbEF4=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=s8noHZtj4DzASuJ0hCImeSNqJ4oIYIvM0G9Ejy0llG7ik/UwAXt3mYcV5QHSt5SE8
	 /Sd95zOMejXL5aT5L/L4iKdXapONFue2IW1ibFX+cmzNUISmHX/4X/JXXcYaox03zF
	 UJyXyCied2UO7WSFKVmKqm7pb3OC3FXDrJCdjTLP6/7zxIqopmd8i79i/TTxPrBWU4
	 S4if9oFBi1AI9NG+4POLOVsRh6gVF2Hn370ggtmmajmNM2AHmXAZcZgBYZvC+ul9Ka
	 Bg3S537620AAIqWqocYyw2kXvgfGMkxlddleZiMcFSgqubG/yL7vNixdQXwHua8s+u
	 LWkPVuU8soQbQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 1AA73C43445;
	Mon, 29 Jul 2024 20:16:23 +0000 (UTC)
Subject: Re: [GIT PULL] virtio: fixes for rc1
From: pr-tracker-bot@kernel.org
In-Reply-To: <20240728191956-mutt-send-email-mst@kernel.org>
References: <20240728191956-mutt-send-email-mst@kernel.org>
X-PR-Tracked-List-Id: <netdev.vger.kernel.org>
X-PR-Tracked-Message-Id: <20240728191956-mutt-send-email-mst@kernel.org>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/mst/vhost.git tags/for_linus
X-PR-Tracked-Commit-Id: 6d834691da474ed1c648753d3d3a3ef8379fa1c1
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 10826505f52357c7c9e12358db97a3acbe82e958
Message-Id: <172228418309.31709.8455898722757053480.pr-tracker-bot@kernel.org>
Date: Mon, 29 Jul 2024 20:16:23 +0000
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, kvm@vger.kernel.org, virtualization@lists.linux-foundation.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, dan.carpenter@linaro.org, jiri@nvidia.com, jiri@resnulli.us, mst@redhat.com, quic_jjohnson@quicinc.com
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>

The pull request you sent on Sun, 28 Jul 2024 19:19:56 -0400:

> https://git.kernel.org/pub/scm/linux/kernel/git/mst/vhost.git tags/for_linus

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/10826505f52357c7c9e12358db97a3acbe82e958

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
