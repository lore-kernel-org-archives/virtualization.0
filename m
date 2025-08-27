Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FDB42D29C4
	for <virtualization@lists.linux-foundation.org>; Wed, 27 Aug 2025 17:24:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756315479; cv=none; b=VgwZEXqFnhrmXc/kuQk5lEXe8Dk3IBbFXkNzMap9DM2PxTdUHHWtGj4SMOiXFOQFWmwOQYdcS6BTaYOCEEKY/zpO5N/MYhXveWfZq54klWWOl57ZhAsE+28PKFPLsS/8Jmle3ZBWnwcMd8H73JrOgev0ONOqq1f1EGbI4rwWHo0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756315479; c=relaxed/simple;
	bh=3eWm1ndCPbeq4+Uwm7c8oAy0V/FmWVSF4NbyqjdoRrA=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=qt5DE+ohXGd+4uyZBhTCG0QFzQ9SNx9ujEUbmdS1jbMjeJmzvzVVlNcJiZhb8Klfowc0a2b1WANde8jx8GiIAJC2Y/JQaZWZc9LXI4YxHWQOrSs7+VNQ21vyLfpSBuEECJW6WOXC5KgKFIJshoG+cjA7yhM1dTt6CcTHJ3yNBYE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mtk9YdDa; arc=none smtp.client-ip=140.211.166.133
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mtk9YdDa"
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id DE04540DD1
	for <virtualization@lists.linux-foundation.org>; Wed, 27 Aug 2025 17:24:37 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -2.101
X-Spam-Level:
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id cO5iwaVdbf-I for <virtualization@lists.linux-foundation.org>;
 Wed, 27 Aug 2025 17:24:35 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=pr-tracker-bot@kernel.org; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org 3D21440EA2
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 3D21440EA2
Authentication-Results: smtp2.osuosl.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=mtk9YdDa
Received: from tor.source.kernel.org (tor.source.kernel.org [IPv6:2600:3c04:e001:324:0:1991:8:25])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 3D21440EA2
	for <virtualization@lists.linux-foundation.org>; Wed, 27 Aug 2025 17:24:13 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id 749D5600AC;
	Wed, 27 Aug 2025 17:24:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 22E5CC4CEEB;
	Wed, 27 Aug 2025 17:24:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756315451;
	bh=3eWm1ndCPbeq4+Uwm7c8oAy0V/FmWVSF4NbyqjdoRrA=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=mtk9YdDaZfjiA5p52xMC5gPa+PC1HAnZ4GTkSKKCt2k1IlsOmsgxNeatDdtsV8tia
	 5sZfHlBdbhrHQxaHs89wA7Z6HCFTcJAHL9Imd2IsM48LQBvvjp8c1cpGh6QEbOUDaE
	 FqvDL/cOQ8mVxc688ufsZoKrb7k31MpPk0QcZczmPmqejhhgmSBisMNe7/7nbrNhEx
	 z/RJB0bvu49ZJS9XSjHgwVLr4AqH1ZfA/AXyLUitFBdO7PnMJrkN/bX+edmaABuVDW
	 qPv3XE5lONron7ScVL6Vy9tz5htFDascGTK7H0khfo6k68jcYPxJE8ebU6wEmLkMo2
	 20cFqV9c45sTQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id AE282383BF76;
	Wed, 27 Aug 2025 17:24:19 +0000 (UTC)
Subject: Re: [GIT PULL] virtio,vhost: fixes
From: pr-tracker-bot@kernel.org
In-Reply-To: <20250827102004-mutt-send-email-mst@kernel.org>
References: <20250827102004-mutt-send-email-mst@kernel.org>
X-PR-Tracked-List-Id: <virtualization.lists.linux.dev>
X-PR-Tracked-Message-Id: <20250827102004-mutt-send-email-mst@kernel.org>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/mst/vhost.git tags/for_linus
X-PR-Tracked-Commit-Id: 45d8ef6322b8a828d3b1e2cfb8893e2ff882cb23
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 39f90c1967215375f7d87b81d14b0f3ed6b40c29
Message-Id: <175631545834.782678.18372880333763945686.pr-tracker-bot@kernel.org>
Date: Wed, 27 Aug 2025 17:24:18 +0000
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, kvm@vger.kernel.org, virtualization@lists.linux-foundation.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, arbn@yandex-team.com, igor.torrente@collabora.com, junnan01.wu@samsung.com, kniv@yandex-team.ru, leiyang@redhat.com, liming.wu@jaguarmicro.com, mst@redhat.com, namhyung@kernel.org, stable@vger.kernel.org, ying01.gao@samsung.com, ying123.xu@samsung.com
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>

The pull request you sent on Wed, 27 Aug 2025 10:20:04 -0400:

> https://git.kernel.org/pub/scm/linux/kernel/git/mst/vhost.git tags/for_linus

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/39f90c1967215375f7d87b81d14b0f3ed6b40c29

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
