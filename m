Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C577613665C
	for <virtualization@lists.linux-foundation.org>; Sun, 14 Apr 2024 17:12:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.137
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713114776; cv=none; b=pcm2M7aEXUz84ziGy/ZuyLWkZnIWZ9DX2hIvK9Vq0GMlPm/VBLLKYKcpgHUpJobCzUf1pTnnuxXEmde88rp88PQ/5nlsj0I4Am1gyyqYKFmQ9AGUyuqbEPUaVdU3Q8avxJvBr7WOeWufdQc1Cor7UWIFhsawKq6RB7OpYWmkwGo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713114776; c=relaxed/simple;
	bh=DBvYJh2YC3326OOwmiISNvaZ8uqYe/EkC4jNLmlnPVI=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=NyYRCVqbEqJJT1EhkAJgFLWzn8WXvYPIIias+Xh2l3dbw85kzMIlD6R9Jlz/ok/Vkrl28j26P77wLKh3spQARdpjFdS5vZXVMENI3d99FmI1FD0uo45f4eUVYc89qF7uUm/DiKuxTNtVvMHhZZz4idtrQ7FmN+qFo0phA0VG4+U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=a3g9x0CZ; arc=none smtp.client-ip=140.211.166.137
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="a3g9x0CZ"
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 60AA14070F
	for <virtualization@lists.linux-foundation.org>; Sun, 14 Apr 2024 17:12:55 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -7.101
X-Spam-Level:
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id OAuuZVN6BFyb for <virtualization@lists.linux-foundation.org>;
 Sun, 14 Apr 2024 17:12:54 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=139.178.84.217; helo=dfw.source.kernel.org; envelope-from=pr-tracker-bot@kernel.org; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org 57BD14070C
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=none dis=none) header.from=kernel.org
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 57BD14070C
Authentication-Results: smtp4.osuosl.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=a3g9x0CZ
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 57BD14070C
	for <virtualization@lists.linux-foundation.org>; Sun, 14 Apr 2024 17:12:54 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 1E0D160B2D;
	Sun, 14 Apr 2024 17:12:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id B13C6C3277B;
	Sun, 14 Apr 2024 17:12:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713114772;
	bh=DBvYJh2YC3326OOwmiISNvaZ8uqYe/EkC4jNLmlnPVI=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=a3g9x0CZdfnd9JDdkd5ZXrgwaM6nmRB89VNlv2qMfHpl8eC1Tdgcn0MXmGbpk237F
	 YY20SlVwLz6fdX8S7etIgSCYxBIAn2F3j2+aK2sFWRvXbSUI6KRAPXsoHtQaUWK7rP
	 rijctqXn50ePDWhywgmITLglmQFB89AdFFofPLCk2iQauuJ7EVnYZ12NfWZQSe3GGE
	 Hqhmh4hFzRY+NPhkOXBdy7tnc9zH5/FPzbD65q69X7VDKZDZUNlU213x5fA2x2anPK
	 /c1KpNFGInHThlA0acJ6b4QoZwCUfQlRMLMXaYTQ3MYZ5ZRDZ/ueibdpqHLVNdEa3+
	 RVhmZ3NlTrYuw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id A5D04C43140;
	Sun, 14 Apr 2024 17:12:52 +0000 (UTC)
Subject: Re: [GIT PULL] virtio: bugfixes
From: pr-tracker-bot@kernel.org
In-Reply-To: <20240414042047-mutt-send-email-mst@kernel.org>
References: <20240414042047-mutt-send-email-mst@kernel.org>
X-PR-Tracked-List-Id: <netdev.vger.kernel.org>
X-PR-Tracked-Message-Id: <20240414042047-mutt-send-email-mst@kernel.org>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/mst/vhost.git tags/for_linus
X-PR-Tracked-Commit-Id: 76f408535aab39c33e0a1dcada9fba5631c65595
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 399f4dae683a719eeeca8f30d3871577b53ffcca
Message-Id: <171311477267.23099.5771272291946432817.pr-tracker-bot@kernel.org>
Date: Sun, 14 Apr 2024 17:12:52 +0000
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, kvm@vger.kernel.org, virtualization@lists.linux-foundation.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, acme@kernel.org, gshan@redhat.com, jasowang@redhat.com, jie.deng@intel.com, krzysztof.kozlowski@linaro.org, lingshan.zhu@intel.com, mst@redhat.com, namhyung@kernel.org, stable@kernel.org, xianting.tian@linux.alibaba.com, yihyu@redhat.com
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>

The pull request you sent on Sun, 14 Apr 2024 04:20:47 -0400:

> https://git.kernel.org/pub/scm/linux/kernel/git/mst/vhost.git tags/for_linus

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/399f4dae683a719eeeca8f30d3871577b53ffcca

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
