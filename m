Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFC1FDF59
	for <virtualization@lists.linux-foundation.org>; Fri, 19 Jan 2024 01:08:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705626533; cv=none; b=BpLS39rEKLVO6xkWMLUSwx8qYfgu63C5T59lJJajZ/2u3RbS2F6brC5w+Y47V58fScf0ZoJQwONV6wMgGHhGA5lVzGDfscEmb0kTaDKbrYE8tVfXfuH9nCfrjJ3CQR+JwmHetbsm588O5jnXqT0NXPz7/tizcTvdWHw8LrpRz48=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705626533; c=relaxed/simple;
	bh=XDfbcGHP/y28g2YdfPBjeNCJEWD8ii8iInMWhyU8HZc=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=EFvTjJOMuquRV5wibWqGy0X7Iy6MjSmNj7hbYJRFtHbzeh1/aXuyoy/XsIq/r6Gnem1Ac5aBm6Oh1KAfR/xz1T7x0gx/+peb+R5Q6OyCQ6mYYuREPtk2YhmC76JqEpaxVW/NTqTuJMn0sRgf8Kv3eqy7hy73k/crsdxYMnn5WwY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YmDOijC+; arc=none smtp.client-ip=140.211.166.136
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YmDOijC+"
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 90C556F71A
	for <virtualization@lists.linux-foundation.org>; Fri, 19 Jan 2024 01:08:51 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 90C556F71A
Authentication-Results: smtp3.osuosl.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=YmDOijC+
X-Virus-Scanned: amavisd-new at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -4.401
X-Spam-Level:
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id qyk-zmY3Gzfd
	for <virtualization@lists.linux-foundation.org>;
	Fri, 19 Jan 2024 01:08:50 +0000 (UTC)
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
	by smtp3.osuosl.org (Postfix) with ESMTPS id A5BBC6F716
	for <virtualization@lists.linux-foundation.org>; Fri, 19 Jan 2024 01:08:50 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org A5BBC6F716
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sin.source.kernel.org (Postfix) with ESMTP id B9C2BCE217A;
	Fri, 19 Jan 2024 01:08:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id F33B4C433C7;
	Fri, 19 Jan 2024 01:08:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705626526;
	bh=XDfbcGHP/y28g2YdfPBjeNCJEWD8ii8iInMWhyU8HZc=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=YmDOijC+fVw7SSodJcAPm23HxgXWdH/M2iMzUXbO1c60MZL33ALJJFtBQgrquF4Hj
	 M24tFVXqmSJPR7gXs+CNwo6JWsHZB8QlyX7jfxsb6p0b8MBNXVU69pxHiu2ID6pyW2
	 ousje6HK8REuNA/ZDFUToxfyt7gSUUnaewmBfgjSoOhEAQ0BTBllplk74N7/Cd4F7v
	 TBi+gB1PvcUSKI+3fc6Vv7w3XEnFu7R6hcgHW6RCd+WpYF5pFfRuRd83gwayI0JrAc
	 G82VGceqWDGiG+W6AqEBNfQqY9yad9n0afCqz1Jzv3UBayupAV7WxXzIgRgEzTa0lW
	 plIHams2MI+gg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id E1110D8C970;
	Fri, 19 Jan 2024 01:08:45 +0000 (UTC)
Subject: Re: [GIT PULL] virtio: features, fixes
From: pr-tracker-bot@kernel.org
In-Reply-To: <20240116112828-mutt-send-email-mst@kernel.org>
References: <20240116112828-mutt-send-email-mst@kernel.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20240116112828-mutt-send-email-mst@kernel.org>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/mst/vhost.git tags/for_linus
X-PR-Tracked-Commit-Id: f16d65124380ac6de8055c4a8e5373a1043bb09b
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 0b7359ccddaaa844044c62000734f0cb92ab6310
Message-Id: <170562652591.16604.2931669549259177440.pr-tracker-bot@kernel.org>
Date: Fri, 19 Jan 2024 01:08:45 +0000
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, kvm@vger.kernel.org, virtualization@lists.linux-foundation.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, changyuanl@google.com, christophe.jaillet@wanadoo.fr, dtatulea@nvidia.com, eperezma@redhat.com, jasowang@redhat.com, michael.christie@oracle.com, mst@redhat.com, pasha.tatashin@soleen.com, rientjes@google.com, stevensd@chromium.org, tytso@mit.edu, xuanzhuo@linux.alibaba.com
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>

The pull request you sent on Tue, 16 Jan 2024 11:28:28 -0500:

> https://git.kernel.org/pub/scm/linux/kernel/git/mst/vhost.git tags/for_linus

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/0b7359ccddaaa844044c62000734f0cb92ab6310

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
