Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05F1E2C9A
	for <virtualization@lists.linux-foundation.org>; Wed, 13 Nov 2024 00:59:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731459570; cv=none; b=KkL7gjZ0sc/1ZvrCTN6TK5FzuzjE/dO58VeBZ6gSR9zXhhNuBpE4C4Y6xyCbTdptwXewJ5Rr60b7ai7Lz/BiNgM32YXOVFBbYgRx9bFQVdP43SfUHzCrMNShvVOvK0jJKvhy1K94RVlw6kwKkpatGSQSF+FbLbjIxlo+Jttw4VU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731459570; c=relaxed/simple;
	bh=90uZg7sPcZs6xapZO7Sny+SwArLF0kzm8+56+pmdOao=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=f5U53b4x27a8N5pd+xrBwP1wNSR4m8VY2wGNBG4FoXP+yQBLbS9EuPu7FC91fkbIqlw3kTuUn3pAdp0Ci3XYVb4wv02rS2aVgLgWfki1TAhShi0hzul7LV9PiKg8DxM20FK7dxl/F0e+YSqa5R7/8Vm+eDSeNCYG3NkpltPMndk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cAYGEAns; arc=none smtp.client-ip=140.211.166.136
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cAYGEAns"
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 9F06B607C9
	for <virtualization@lists.linux-foundation.org>; Wed, 13 Nov 2024 00:59:25 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -4.401
X-Spam-Level:
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id u6Y5sgd7PHhY for <virtualization@lists.linux-foundation.org>;
 Wed, 13 Nov 2024 00:59:25 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2604:1380:45d1:ec00::3; helo=nyc.source.kernel.org; envelope-from=pr-tracker-bot@kernel.org; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org DAACA607B8
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org DAACA607B8
Authentication-Results: smtp3.osuosl.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=cAYGEAns
Received: from nyc.source.kernel.org (nyc.source.kernel.org [IPv6:2604:1380:45d1:ec00::3])
	by smtp3.osuosl.org (Postfix) with ESMTPS id DAACA607B8
	for <virtualization@lists.linux-foundation.org>; Wed, 13 Nov 2024 00:59:24 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by nyc.source.kernel.org (Postfix) with ESMTP id 22F57A41F31;
	Wed, 13 Nov 2024 00:57:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F394DC4CED4;
	Wed, 13 Nov 2024 00:59:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731459563;
	bh=90uZg7sPcZs6xapZO7Sny+SwArLF0kzm8+56+pmdOao=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=cAYGEAns0u2GqpWJ1/A4PL1lxYFknXTHAsztjiJKI78i4FdfiaCT/YQO9aBvYCJRH
	 la+s8EWlR28uh33LFPUKeQgFQiAhhuMkTcZevV/VXeBwuotbK4NuNlpTB4hexnXhRF
	 utceMCzgz1XgX2cc2uRW44o3qNZDqULlcG52Vji5UbwIJW57X1uC4xJ7XP6uHi70N/
	 yUD/zglFdH5fZJr1l+uoJKZeG2k74RpP8p2qqdgLIeE1LDW8t9tTzS6lODDHiVpzuP
	 so46tsMUYfCSy7a8Akw01oQLZlZNSr3DmWfTlbPZhP+uRyh8oBUZhEGxfddXk7wmAL
	 WzgJ/+lrkgSmw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 710AF3809A80;
	Wed, 13 Nov 2024 00:59:34 +0000 (UTC)
Subject: Re: [GIT PULL] virtio: bugfix
From: pr-tracker-bot@kernel.org
In-Reply-To: <20241112183037-mutt-send-email-mst@kernel.org>
References: <20241112183037-mutt-send-email-mst@kernel.org>
X-PR-Tracked-List-Id: <netdev.vger.kernel.org>
X-PR-Tracked-Message-Id: <20241112183037-mutt-send-email-mst@kernel.org>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/mst/vhost.git tags/for_linus
X-PR-Tracked-Commit-Id: 29ce8b8a4fa74e841342c8b8f8941848a3c6f29f
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: f1b785f4c7870c42330b35522c2514e39a1e28e7
Message-Id: <173145957292.735839.6511436323242434838.pr-tracker-bot@kernel.org>
Date: Wed, 13 Nov 2024 00:59:32 +0000
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, kvm@vger.kernel.org, virtualization@lists.linux-foundation.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, dtatulea@nvidia.com, jasowang@redhat.com, mst@redhat.com, si-wei.liu@oracle.com
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>

The pull request you sent on Tue, 12 Nov 2024 18:30:37 -0500:

> https://git.kernel.org/pub/scm/linux/kernel/git/mst/vhost.git tags/for_linus

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/f1b785f4c7870c42330b35522c2514e39a1e28e7

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
