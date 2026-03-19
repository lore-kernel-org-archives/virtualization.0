Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 706C23876A9;
	Thu, 19 Mar 2026 03:10:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773889823; cv=none; b=DJ/fIdw5Y0wbS0/itXfi7WyOllvG5Pu+Lw6P/wT79kUIPgn12XRoUJK1Gm1/U3P7njeU7nJr2HAnRe9VBHMe8+GvEPR5ugj542YMxiO5O86MZe5MOcb8WZ9h0EYVO61yMhee+7sYIfY/38YX5ZvPfX3TU1pzFQCvj7iXwtqd6+I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773889823; c=relaxed/simple;
	bh=uuPFUGmJLa6ZmtGZh44sRVLRMdtLRmTdH3xVrTkZI1w=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=ipokHxQNeL6Ly61FuPuywXwbVvCP2dsry8dgOIityH+sI1JYLFtTb6y80otVpzw/oTLyRsz5wK9Mxl4brt8Lo9Vylcc9ZTYZh6GK8c4YY/zJ0s16uZ9OTX0u6ARtV+HOOalMLGeYVpk4RuHKsFqWwXINZ4MJWd2ciPofjD6e6B8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LyAow0al; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LyAow0al"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E838EC19421;
	Thu, 19 Mar 2026 03:10:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773889823;
	bh=uuPFUGmJLa6ZmtGZh44sRVLRMdtLRmTdH3xVrTkZI1w=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=LyAow0algRLBdBjTJQljI+gJheTwYE5jNoYxmPWEOTVFzpz44AR5tskoiAu/nQ1xa
	 FiLiwVFEj20+CotM5D80F401NKNuayw+C3lCHf5w6d/mjcqQFgsAtdEZ/3i4YLPxOX
	 dsY/MeC0tV5/JUt56Es9bb7+c8Fn+2F9244hMznw5zcHS/jYCMH3qRJGhIXDWB5gT+
	 2xdqCfjr+sIDD1o/9pZpZTeaudNH+3cV0qJiqRhsq/wepqemgHs0JazUUb+XbDUfGk
	 oVC21ey/C2pVt5/k1Nbv56lJC93HBIcToDwjPZyckNTp09N/wqPBrhqFQNrEskZVNK
	 9Jry52qV11p1Q==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 7CED43808200;
	Thu, 19 Mar 2026 03:10:15 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v2] selftests/vsock: auto-detect kernel for guest
 VMs
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177388981428.1008325.4813735802050665740.git-patchwork-notify@kernel.org>
Date: Thu, 19 Mar 2026 03:10:14 +0000
References: 
 <20260316-vsock-vmtest-autodetect-kernel-v2-1-5eec7b4831f8@meta.com>
In-Reply-To: 
 <20260316-vsock-vmtest-autodetect-kernel-v2-1-5eec7b4831f8@meta.com>
To: Bobby Eshleman <bobbyeshleman@gmail.com>
Cc: sgarzare@redhat.com, shuah@kernel.org, virtualization@lists.linux.dev,
 netdev@vger.kernel.org, linux-kselftest@vger.kernel.org,
 linux-kernel@vger.kernel.org, kuba@kernel.org, bobbyeshleman@meta.com

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 16 Mar 2026 17:56:15 -0700 you wrote:
> From: Bobby Eshleman <bobbyeshleman@meta.com>
> 
> When running vmtest.sh inside a nested VM the running kernel may not be
> installed on the filesystem at the standard /boot/ or /usr/lib/modules/
> paths.
> 
> Previously, this would cause vng to fail with "does not exist" since it
> could not find the kernel image. Instead, this patch uses --dry-run to
> detect if the kernel is available. If not, then we fall back to the
> kernel in the kernel source tree. If that fails, then we die.
> 
> [...]

Here is the summary with links:
  - [net-next,v2] selftests/vsock: auto-detect kernel for guest VMs
    https://git.kernel.org/netdev/net-next/c/3883c2b50910

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


