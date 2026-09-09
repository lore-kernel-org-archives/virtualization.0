Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D20BC282F0C;
	Wed,  9 Sep 2026 00:41:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788914469; cv=none; b=lrFsiMcCAWbb+9d6NqnL53FAlTJT+Hz6QzD+s0Bosfg1sr2Z1kMOlollVrLphnLD5CkD3r0b2lr19bth9/pfZW+lsgZbisIlNbV3EfFAf4zhxO5AVaq7DjRazBaAf7A5/kz/Oy90miXBww790rHD7YffcAObJbTbpNhE26U6ZNM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788914469; c=relaxed/simple;
	bh=PZg2FYcJoBC2eNT54TWZHaOLjex4nw/b4ThvsmH9000=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=SyDqyphL1DfPg03GVyatTpDyO3yvzLSP+GdtjjLa2LPfwrmc/cubJbElw8h/lSNLIhZTJtzIjFA7I6KkSCd3n1SUIzziHxHkpSUXRst6qFt7I27FvxQrt3R1qBAGulcaLOR9JnMe8qvUnUuV7/a+ud6hWRzZMTmMMRdS6+lOggg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bU/KwIix; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bU/KwIix"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7845F1F00A3A;
	Wed,  9 Sep 2026 00:41:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788914468;
	bh=EvwiRRFV8jjfKcoY6Y07IJn7fDB+cOjJtRJOMpGV2F4=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=bU/KwIix200/Y4tsXaKdpqWiDtsI6efbUf34PD0BOwWVXbQ+4OOXcdwPArjg7aSar
	 eyC4V2zw6fPjMHec1hwsbEl/2euBdQtSp180Qn9FyOBBZr1qunXH8o7y4A0MS6DiJt
	 qNln6G84lrQYx/k4Yh1ImzhZy+UF5SzEVk1OOxb4SHlynqWRj++ZXUEToQYodT7sHY
	 IGsXomOOXir4+yecMQPZ1wyUuCcz7XV/70jxifhvJut6s/4nPfUvxhYSV3fDo1V2sN
	 yMCaOtWAAyqSPdHRIUOOarhNxrffzOL/Rubk7eTimusQdAVPixZTVPO4b5OrEl7wex
	 1ZKuSF9+q+w/Q==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 19CEC380820D;
	Wed,  9 Sep 2026 00:40:08 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] selftests/drivers/net: include lib/sh/*.sh
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178891440661.81609.2843782667713024589.git-patchwork-notify@kernel.org>
Date: Wed, 09 Sep 2026 00:40:06 +0000
References: <20260907-selftest_lib_defer-v1-1-8af94645aaa3@kylinos.cn>
In-Reply-To: <20260907-selftest_lib_defer-v1-1-8af94645aaa3@kylinos.cn>
To: Hangbin Liu <hangbin.liu@linux.dev>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, shuah@kernel.org, jv@jvosburgh.net,
 olteanv@gmail.com, leitao@debian.org, jiri@resnulli.us, mst@redhat.com,
 jasowangio@gmail.com, xuanzhuo@linux.alibaba.com, eperezma@redhat.com,
 petrm@nvidia.com, matttbe@kernel.org, netdev@vger.kernel.org,
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
 virtualization@lists.linux.dev, liuhangbin@kylinos.cn

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 07 Sep 2026 15:28:09 +0800 you wrote:
> From: Hangbin Liu <liuhangbin@kylinos.cn>
> 
> When I tried to install and run bonding selftests via:
> 
>   make INSTALL_PATH=/tmp/kself TARGETS=drivers/net/bonding \
>      -C tools/testing/selftests install
> 
> [...]

Here is the summary with links:
  - [net] selftests/drivers/net: include lib/sh/*.sh
    https://git.kernel.org/netdev/net-next/c/52176ca4e4d0

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


