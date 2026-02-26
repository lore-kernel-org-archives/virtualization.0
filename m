Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF33C2F7478;
	Thu, 26 Feb 2026 10:20:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772101205; cv=none; b=YVlKsTNKVKTTewOdguGgb0BT/mCoavnIRULs3y4sKiUvsJsN/pQL6bgLgNr79tsIcwnUoP/621Z1qVela2JRkvHyBFBuyayhRANPAX/tmJnxeCgMk9eNTOgeEhbFNKYx+lLUwcP7MQXIuUy7+zfam6qK5lDlYraCrFgCrYDq5Jk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772101205; c=relaxed/simple;
	bh=iDz13LP7DM09M9k+zfKiRb2KkCIRF1a2FJtg0xagvGA=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Qdwlrwc0FU5jFo4l7Y6Y9LvGLTF3B5TBdTJBFvVkH8dcrD2ZLB5cDcj97iEb1LIPkHxWNp6je4qLwkzM17rjXoEoenzri6T07WzQh3mjlIgHWmRoawI9hFjXhcYTQMIKBlKP1yVvT2bXVcao1/XXcbG6PG3bk3ubI+OcabKLQYI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CNRIJI30; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CNRIJI30"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3CC3AC19422;
	Thu, 26 Feb 2026 10:20:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772101205;
	bh=iDz13LP7DM09M9k+zfKiRb2KkCIRF1a2FJtg0xagvGA=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=CNRIJI30lsQB4xeaSUvGaxr4KLIjfIZVtplWLfcxFOVhjPtfTRWHI5hu9LSX0XCv3
	 s3oZykZpuNo01/g48sqS3KcifW+TYhuVr7RNHCiKg6oIVcFD0RxMN+sq0CorBxeunJ
	 /AAJyuj0w1x0OobhFl5RnUAj2kWG5vg5wD5aq/isXVtgR5DmrXpcsMZT0H+yoHzB1g
	 n+/kEjtjnpyDrR9bgxxzG5XLi+BGh80yKhYkSiutldWvwAWnnmgqCiT6Im8LoZPeTA
	 Qh/LOc2Wtv05dziIF6hdLl2uCMC+yg1a2onwitoOS7aj0ZcQLJHhuoeAaWFjXyfbpf
	 bspmJ/T1tFkdQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 02D60380A977;
	Thu, 26 Feb 2026 10:20:11 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v3 0/3] vsock: add write-once semantics to
 child_ns_mode
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177210120979.1146836.15985214642756769564.git-patchwork-notify@kernel.org>
Date: Thu, 26 Feb 2026 10:20:09 +0000
References: <20260223-vsock-ns-write-once-v3-0-c0cde6959923@meta.com>
In-Reply-To: <20260223-vsock-ns-write-once-v3-0-c0cde6959923@meta.com>
To: Bobby Eshleman <bobbyeshleman@gmail.com>
Cc: sgarzare@redhat.com, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, stefanha@redhat.com,
 shuah@kernel.org, bobbyeshleman@meta.com, mst@redhat.com, corbet@lwn.net,
 skhan@linuxfoundation.org, virtualization@lists.linux.dev,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
 linux-kselftest@vger.kernel.org, linux-doc@vger.kernel.org,
 kuniyu@google.com, ncardwell@google.com, daan.j.demeyer@gmail.com

Hello:

This series was applied to netdev/net.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Mon, 23 Feb 2026 14:38:31 -0800 you wrote:
> Two administrator processes may race when setting child_ns_mode: one
> sets it to "local" and creates a namespace, but another changes it to
> "global" in between. The first process ends up with a namespace in the
> wrong mode. Make child_ns_mode write-once so that a namespace manager
> can set it once, check the value, and be guaranteed it won't change
> before creating its namespaces. Writing a different value after the
> first write returns -EBUSY.
> 
> [...]

Here is the summary with links:
  - [net,v3,1/3] selftests/vsock: change tests to respect write-once child ns mode
    https://git.kernel.org/netdev/net/c/a382a34276cb
  - [net,v3,2/3] vsock: lock down child_ns_mode as write-once
    https://git.kernel.org/netdev/net/c/102eab95f025
  - [net,v3,3/3] vsock: document write-once behavior of the child_ns_mode sysctl
    https://git.kernel.org/netdev/net/c/b6302e057fdc

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


