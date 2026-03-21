Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 615A23271EA;
	Sat, 21 Mar 2026 01:40:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774057230; cv=none; b=B6o4z2mAPUZGfsvBKy7wb5D/hSQ/MAGH0cIuBBQt2LT/fX9eVvnX1F5S9Z8rGfBVegfc3sqLqwmE5E2rNrX9Cs/Heu1gAqAbVwUMcQQDHjmuwrqKrS2bAFj0yc8ZbqdTAPSodrfqLIaT8OXLVM7nOc0jF7YZXlC7JCYkuvcTfgI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774057230; c=relaxed/simple;
	bh=oszz2+luIcotaI3mDHP5rRr89zad9VHBjN4UEAMPzNQ=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Ww06l2qieizEI00Y7OKGHWi9jeek+0LmYHTckT+4a8iCyUsy6VzLX83bntl8lqrnFWU41sqqQIgllGsgE0fq1YpZfy0nCKjjC5HSUoDpNnI1U+EOyafDrOA0pQjuU3bWLJOEBmzl4udPxxifFjJunHJBuhgg8YaKq7DN9SvHl6o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XV1/noDW; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XV1/noDW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 44105C4CEF7;
	Sat, 21 Mar 2026 01:40:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774057230;
	bh=oszz2+luIcotaI3mDHP5rRr89zad9VHBjN4UEAMPzNQ=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=XV1/noDW/goeAfgw/yhJIK3yCt0S3+lkil8nQSb+rlGYQEU7VXcXtj6kt5Rjnb9uy
	 kERCZHtuMkKvxImf1X5H0sl5METevwQSY+Qm/ly8jVOk4R+F6Z7ayx1BgCZCbRmfxX
	 +x5CX7LjM4g8+tWlJIQLkTGUVic7Iq5aetgXu5Xmz/Z50iNJzqWdLbmn1S9LtXh235
	 D8k5byyYhTbWUbkpzt5qqJnbXXqhguGSohc/9+RbYisoWlmaAjrkf6EAT914QBZpem
	 V83BUEzw3wdUODeSsYRpvcFfhPZGe/PK+SphHJw4sUAtTHHMd5sqS2Z13InNGpzfIF
	 6v9jtGCGWW4wQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 7CD6B3808200;
	Sat, 21 Mar 2026 01:40:21 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v2 0/2] selftests/vsock: support nested VM runner
 for vmtest.sh
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177405722003.2718727.10487979147167709266.git-patchwork-notify@kernel.org>
Date: Sat, 21 Mar 2026 01:40:20 +0000
References: <20260317-vsock-vmtest-nested-fixes-v2-0-0b3f53b80a0f@meta.com>
In-Reply-To: <20260317-vsock-vmtest-nested-fixes-v2-0-0b3f53b80a0f@meta.com>
To: Bobby Eshleman <bobbyeshleman@gmail.com>
Cc: sgarzare@redhat.com, shuah@kernel.org, virtualization@lists.linux.dev,
 netdev@vger.kernel.org, linux-kselftest@vger.kernel.org,
 linux-kernel@vger.kernel.org, kuba@kernel.org, bobbyeshleman@meta.com

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 17 Mar 2026 15:09:34 -0700 you wrote:
> This series fixes a few issues trying to launch vmtest.sh in a nested VM
> environment and were discovered when trying to prepare the tests for
> netdev CI/CD.
> 
> When taken together these patches make vmtest.sh work both on bare metal
> and in nested VMs, regardless of the outer VM's user, coincidental path
> overlaps, or filesystem settings.
> 
> [...]

Here is the summary with links:
  - [net-next,v2,1/2] selftests/vsock: fix vmtest.sh for read-only nested VM runners
    https://git.kernel.org/netdev/net-next/c/865926e26e05
  - [net-next,v2,2/2] selftests/vsock: fix vsock_test path shadowing in nested VMs
    https://git.kernel.org/netdev/net-next/c/0c3893d37892

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


