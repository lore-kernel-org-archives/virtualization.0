Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1707318FC97;
	Tue, 29 Sep 2026 00:31:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790641886; cv=none; b=aYJZPA/LXnfFCywy2FGONB2KTJjcz3ATjqsIiBpD7quw4McyDl8LeaLqNwbHRmHBIrPAsFOmMLOPutee4gOPEj+8aplyLI754f0lgNc929CC3MXu7vNHGV1jDy29m1Hojt9XxtKbXkDZXCiQvO9VJUH1izHwjIRLW2gIVApOvVU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790641886; c=relaxed/simple;
	bh=TwcyW0+tWe74bt/DNx20Z+ReO6DASDoME4G8QFiaKHk=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=NDjzTzESq01MuSJq0Y+MGFQ6v18Ts+nn5plzrIi+bptSvoT6f0d/6M38mb52MlWrQ1W3c9vqynUuQlOL9AIEaXpDjNGVRTib1VdBsXMSFsioE0D5oJ3jxXTS/b1/cv9dzSI9Zz7C9wynzX8MYeBJG8ArsGbDfsk8tOhZYuoQxfk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nd8aF1R2; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nd8aF1R2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B6BF81F000FF;
	Tue, 29 Sep 2026 00:31:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790641884;
	bh=6VlV7dNyyMTnkdVMSqK3ITVfnIN+OzzOiOTj6sRqCaE=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=nd8aF1R2pZg0X1h4Urs6uRZf10QHsDi28h9FAJTxKzHQtdMN8MKbozjq68dcPm3lO
	 IlqIGPFd2mwY0LHxDdBPWW9pBnldfeMxF379ybUh7dvjl1FYlBiq7sJue2PUhgtqaI
	 lz4GL3vfqAxzktjqdjaijTWA2Jxe1ykX2YgW8fvKE3if+JdhAjedt24Q+NXtu2/rDr
	 04aELDYzeNxhVvv9r44E2ILoRIOwFMV9kvBZT/L3ArWc2T9LxPrFNML3gTsYe3Ky+p
	 gYG2QYLZN5kt/kneZHVEqR7sBS1DJJZUt1b55SUvt8c2+6paywB9o4/hDnM5GvSMdq
	 H8tnx9vXHdReg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 5699E3924FE4;
	Tue, 29 Sep 2026 00:30:10 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v2 0/2] vsock: receive queue hint for io_uring
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <179064180888.191583.4189311679177858561.git-patchwork-notify@kernel.org>
Date: Tue, 29 Sep 2026 00:30:08 +0000
References: <20260923184008.153541-1-devnexen@gmail.com>
In-Reply-To: <20260923184008.153541-1-devnexen@gmail.com>
To: David Carlier <devnexen@gmail.com>
Cc: netdev@vger.kernel.org, sgarzare@redhat.com, bobbyeshleman@gmail.com,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 horms@kernel.org, virtualization@lists.linux.dev,
 linux-kernel@vger.kernel.org

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 23 Sep 2026 19:40:06 +0100 you wrote:
> AF_VSOCK stream receives never fill msghdr.msg_inq. io_uring initialises the
> hint to -1 and treats that as "unknown", so it cannot set
> IORING_CQE_F_SOCK_NONEMPTY, and it speculatively retries a multishot receive
> after every completion, including when the queue is already empty.
> 
> Patch 1 fills the hint at the common exit of __vsock_connectible_recvmsg(),
> reusing vsock_stream_has_data(), the transport callback that SIOCINQ already
> uses. Following tcp_inq_hint(), it reports a terminal hint of 1 once the
> connection is finished, so the caller still performs the receive that
> observes EOF. Patch 2 adds selftest coverage.
> 
> [...]

Here is the summary with links:
  - [net-next,v2,1/2] vsock: report pending receive data to io_uring
    https://git.kernel.org/netdev/net-next/c/608e7f84960b
  - [net-next,v2,2/2] vsock/test: cover receive queue hints
    https://git.kernel.org/netdev/net-next/c/c116f78f94a4

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


