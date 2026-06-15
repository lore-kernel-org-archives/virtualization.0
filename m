Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF3B329BDBB;
	Mon, 15 Jun 2026 20:00:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781553621; cv=none; b=bUsn7rTZgn7mcn+Es3LPcKvAm8NWBvw7MbodTtrRWGdCgg9U4/2IL2O7oj8V3w9i2pMb/w90mgHUChnl1N3zpRN4Sg7pIDDYRYmuhJH1hbwZXv9tgS4WISLclKTfPKE8CHdsFx0wvfDpwZz6y6cdZrN1x+FBtHo9XMkQV3WaJDc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781553621; c=relaxed/simple;
	bh=JUbRWvp9mCNkQmiuZPtvnZAI+5bA8g1SRzhoZtnhheY=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=A4KoKi8FnmSYR1EaobkW8b95xchzlEQw05nDDaFOhn2Jx2MlEqTRZIl3HBEIjD4oubgeHRqLPNlQWGbcmUyDcJcf9mSyCvlzN1QjIn3kQZxpj0LoX5BL0oj3u7yk9yu89t9fEU8Yt2d1N71SjYrmY7AqrMah6svfAonQIMoBhgY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=W2i6lVdF; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="W2i6lVdF"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 84F6C1F000E9;
	Mon, 15 Jun 2026 20:00:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781553620;
	bh=vsyX/OiGu7noUPnPlEtDjolBJddDnqDIcGdKM36DljU=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=W2i6lVdFM8yjEsFy8C3V/rKUYvLjyno+v/z1WXbEPSAc20GTDNQkAttwf1Se6mSDy
	 L5ZppoZ+2+61HkaZrblkVwJTxDyeEbIFm8q31dDZx9n6y5HXBeo7qQabHF7xcRJgph
	 c2PeZvMPY8EPJsD8b9vt04clS1pFYRFbXTODT2A+R0EVp8Y+DtkuxPzhW1DzxF3tRp
	 18xVlEwqcgVpXMDQU1WcxCWnuHBfBSsSq7DUI7623RfmSHe7b63/D0VKk/T5rL0QmJ
	 dv8RJjnTDoS0ZMGOqh1Sjbdmpq38D/xibjqJ+oVpwqF3iii+AaLdqausUrLY6ujRx6
	 nePWLYFX1rtYg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id D09853839A06;
	Mon, 15 Jun 2026 20:00:16 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next 0/2] selftests/vsock: improve vng version and
 quirk handling
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178155361538.272818.12192938243650583106.git-patchwork-notify@kernel.org>
Date: Mon, 15 Jun 2026 20:00:15 +0000
References: <20260612-vsock-test-update-v1-0-7d7eeed3ac8f@meta.com>
In-Reply-To: <20260612-vsock-test-update-v1-0-7d7eeed3ac8f@meta.com>
To: Bobby Eshleman <bobbyeshleman@gmail.com>
Cc: sgarzare@redhat.com, shuah@kernel.org, virtualization@lists.linux.dev,
 netdev@vger.kernel.org, linux-kselftest@vger.kernel.org,
 linux-kernel@vger.kernel.org, bobbyeshleman@meta.com

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri, 12 Jun 2026 12:08:40 -0700 you wrote:
> As vng has continued updating, there have been two things in our
> selftests that have been affected. One is that newer versions always
> emit the vng version warning, and two is that we have a workaround that
> is not needed in newer versions.
> 
> This series just updates the version handling to allow all newer
> versions without warning and version-gates the workaround to only those
> versions that don't have the commit that fixed the root cause.
> 
> [...]

Here is the summary with links:
  - [net-next,1/2] selftests/vsock: accept vng 1.33 or >= 1.36
    https://git.kernel.org/netdev/net-next/c/197503d5ac82
  - [net-next,2/2] selftests/vsock: skip vng setsid workaround on >= 1.41
    https://git.kernel.org/netdev/net-next/c/9361bff6bdb7

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


