Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77AFE8BEC;
	Thu, 30 Jan 2025 03:10:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738206609; cv=none; b=fTRDt/+STzkyb8Z3ffaScLFJ6kIBrOKJtv3mGrcUVGqFzZgNxUfFCUiPjgnPASHM5i65zG2cP1g3mXnpfFhqjhGaqFqNidDA4P/yQ1uztZA3vu3alRPnuA0E252XZfKYU4+4uVYz+AaaBQhZAxfGpkCjhyIMQwXVa76jhzvLpuY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738206609; c=relaxed/simple;
	bh=cHM33JOIaePyjOr0lQLCslZXs7z6evp4xpPia/tmjFw=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=sgbd1c2jtWTaDj5LWiBoFaUqwD4vYWitOQTaGt/D1yt45+qINqPGvzponPgPZSBQ748hJbCnDysbhIOdakyglh7rxnn9oUfcxRRJLltpC+bOOhH6L2CpOA4DAXyO02/vYAI+8uVztfCaq18wD0nBfMZwXJrxTLwlG+JX2/14MbA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=glzvLoYq; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="glzvLoYq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E56ACC4CED1;
	Thu, 30 Jan 2025 03:10:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738206608;
	bh=cHM33JOIaePyjOr0lQLCslZXs7z6evp4xpPia/tmjFw=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=glzvLoYqzCm7aeZwyAcl7EPAoyk2749L8FBh24Hv70gNx4zDzQ/7TYjeqqYS1Bhm4
	 zYmnKhCnrbQuKkgQKcKd9KEEUmSTglE17k4r2eSqo/aeRoPWcLCl+96PLvUtoNfVvI
	 IpX0TUUMN5cWsaxa6LmPjqHXm8NoYSF90VcQn6aOQ3oa9mWL8gvT/rjCdRKoelkKq+
	 1Ze0LvvHyIlbTagCjtja1WxSs8E00pXGSeO4Wr2d1/l9/8OuNrl60HMQWjgkteJOiN
	 Rn2WT1+yxESOb5VEhbPRA/qYPzY4XKv1m/6HBEz5/7nvnBfiQSZyCQcZM3F7OOchFx
	 pgsdwIEqfJguA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 364C1380AA66;
	Thu, 30 Jan 2025 03:10:36 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v3 0/6] vsock: Transport reassignment and error
 handling issues
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <173820663502.510125.11365939467825824354.git-patchwork-notify@kernel.org>
Date: Thu, 30 Jan 2025 03:10:35 +0000
References: <20250128-vsock-transport-vs-autobind-v3-0-1cf57065b770@rbox.co>
In-Reply-To: <20250128-vsock-transport-vs-autobind-v3-0-1cf57065b770@rbox.co>
To: Michal Luczaj <mhal@rbox.co>
Cc: sgarzare@redhat.com, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, netdev@vger.kernel.org,
 virtualization@lists.linux.dev, leonardi@redhat.com

Hello:

This series was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 28 Jan 2025 14:15:26 +0100 you wrote:
> Series deals with two issues:
> - socket reference count imbalance due to an unforgiving transport release
>   (triggered by transport reassignment);
> - unintentional API feature, a failing connect() making the socket
>   impossible to use for any subsequent connect() attempts.
> 
> Luigi, I took the opportunity to comment vsock_bind() (patch 3/6), and I've
> kept your Reviewed-by. Is this okay?
> 
> [...]

Here is the summary with links:
  - [net,v3,1/6] vsock: Keep the binding until socket destruction
    https://git.kernel.org/netdev/net/c/fcdd2242c023
  - [net,v3,2/6] vsock: Allow retrying on connect() failure
    https://git.kernel.org/netdev/net/c/aa388c72113b
  - [net,v3,3/6] vsock/test: Introduce vsock_bind()
    https://git.kernel.org/netdev/net/c/852a00c4281d
  - [net,v3,4/6] vsock/test: Introduce vsock_connect_fd()
    https://git.kernel.org/netdev/net/c/ac12b7e2912d
  - [net,v3,5/6] vsock/test: Add test for UAF due to socket unbinding
    https://git.kernel.org/netdev/net/c/301a62dfb0d0
  - [net,v3,6/6] vsock/test: Add test for connect() retries
    https://git.kernel.org/netdev/net/c/4695f64e028d

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


