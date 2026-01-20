Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C69BD4657CA;
	Tue, 20 Jan 2026 15:50:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768924209; cv=none; b=ASfrxL0YkflfcQ0CoPOR+oZgqTD+qRXff9NQLaSi3gaxkP1xV5DiCVtCp9jcIrD+luZ0xZARVDSe4h8ScqGtG7Ls8r61/o1dewPtuUMhp/BlCLOGD0yRMCcPmiN5eJ8ydUbcTjTUmIIsODYoABdZbzBkcH/twuMiCbi4eDlU9gs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768924209; c=relaxed/simple;
	bh=ZZjyt8cua4ZkqKAaWQbTM7HPeZDV7dBhN5cbqpQholY=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=WN5fo00GkNM0qxNKt3XLsibf7IM6NhqmWPrazW33c/ityIYb+I35YKKEMfr+P4ebB2rwVP7lwWS3YOtWdYvWvGsAR+5fmu/ngP+tvyfPuW/Gbjdf4e6kyjB3wlfAyNnyiIkvbDq+YOIm1JiR+cO6gZmu+chWeWVviOwjD2ooPF0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kFeeKXF3; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kFeeKXF3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4017CC19422;
	Tue, 20 Jan 2026 15:50:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768924207;
	bh=ZZjyt8cua4ZkqKAaWQbTM7HPeZDV7dBhN5cbqpQholY=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=kFeeKXF3fgZQVa3KD1dAlMJEgbMat9ZsH3Rpv6SZWKznGxAmGTAdeGfpATJA2AYOW
	 1CnTwDrIiUj5KZTFzWBlrB8oFnQENbCuja+6eJOcyKFjPapj3En8xcq6rVJmR2BNpR
	 UiW4kZ4FkCc5WSuzaKgpeu0XYZcRZ0zqbisATHfYduCT9wpRI/SE9g2ZeHcu3zd8Yu
	 2ssRgTiTs+81ZIdjpki977rR6LBNunVSBgjBOmRsya2lzYxiBBV70ITJC6B8Q1ShG9
	 rLfaKStzZUzGOig3L/iMQNLCrweWdFdJ02uy/b7+sNwINJoPnkfn6XfED3vyW2KMQv
	 eBB+EEn/BTCHA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 11A193806671;
	Tue, 20 Jan 2026 15:50:06 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] vsock/test: Do not filter kallsyms by symbol type
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <176892420460.101865.5448435086952120781.git-patchwork-notify@kernel.org>
Date: Tue, 20 Jan 2026 15:50:04 +0000
References: <20260116-vsock_test-kallsyms-grep-v1-1-3320bc3346f2@rbox.co>
In-Reply-To: <20260116-vsock_test-kallsyms-grep-v1-1-3320bc3346f2@rbox.co>
To: Michal Luczaj <mhal@rbox.co>
Cc: sgarzare@redhat.com, leonardi@redhat.com, kuba@kernel.org,
 virtualization@lists.linux.dev, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Fri, 16 Jan 2026 09:52:36 +0100 you wrote:
> Blamed commit implemented logic to discover available vsock transports by
> grepping /proc/kallsyms for known symbols. It incorrectly filtered entries
> by type 'd'.
> 
> For some kernel configs having
> 
>     CONFIG_VIRTIO_VSOCKETS=m
>     CONFIG_VSOCKETS_LOOPBACK=y
> 
> [...]

Here is the summary with links:
  - [net] vsock/test: Do not filter kallsyms by symbol type
    https://git.kernel.org/netdev/net/c/5d54aa40c7b7

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


