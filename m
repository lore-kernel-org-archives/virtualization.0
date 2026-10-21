Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792577408;
	b=X578CKH2cg28+MjF+YRUiWKVI4IaJi4Zp90XfV/E0cnMi2Vzt1YYo7hVoG9Zn/qsLDRK
	 uw1+JwZLdrHoDTpZZUvob2SlW9q7gQQZ74i0CDmv2tEstLb8pGWEwfCEkaIc+D3k2w8hJ
	 529kvYFzAOuUdBTnBcWbZLVZCujdpFzdheOLfbGXBm3yX/dAmKxLXf9JW+RTVrVdAsWsv
	 1ArDH6pYDEP1iy9SUXJH5RTi3b/PVrxYUPFDwrhek/SwqOwYJHxNEbCYPT9ofOawAHJu5
	 cUKEMnOAssqxnXuQ8eWB5sunUxaDiSeOivxvdrve5Cj/hQhaX4kKCWrK8T+SuKZ7+dw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792577408;
	h=Received:DKIM-Signature:Received:Content-Type:MIME-Version:
	 Content-Transfer-Encoding:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc;
	bh=JfIxg5EantTP75kmSrvra2A30CN9rkhMmZdC6xAXjzg=;
	b=DWpg0ex7gDKf+vwgPHiC9M30tznCYF6DVBbeQbksRTbNy6hEYy5FmQELwePEQU8Kx+Oc
	 HQ71iYiKAauEaJEC/yEf/iyc1z/qDYsa7L0ZPdtg320afuREs6DLQEQnbvADxu4Vb9b6V
	 fBXND7gp7k9Av6tkOLj7lwXfwXtFCLy9queZEUNnQSdHnEgiN9ygKnooD5Zky4P+344as
	 38wb/i8zYnxHF/g1ze4SVu9eT+KQnNDFqNO2ubVb94CJYozUZOJ569XEqeB2eEW9c12tu
	 LORlHxTUjtqkHIBc1en/ds6MNcQ0xPY2WE/BRzWDqtE9y9CgR08gpEyrzks+smY/09w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=nMaYmwPx;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AE54606A31A;
	Wed, 21 Oct 2026 10:10:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=nMaYmwPx
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BD6BC1F000C9;
	Wed, 21 Oct 2026 10:10:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792577407;
	bh=JfIxg5EantTP75kmSrvra2A30CN9rkhMmZdC6xAXjzg=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=nMaYmwPxfBO24PoqLfGJoMGTucf63CVjnVOLlmv9GzXYCcGv5AD9tLTBFsD2uY/KU
	 FlahhM9+zRfClKsZOHYYs3QBSDmhmsExMRSG1TUXpmWD1rlAS7dqA3pkp8GzFCOhE3
	 IHkInbhUsbpbjVUA0iV/qZA6uQFkxpJXC/SBy+e4RX8uKbqEZx58s7WLCtXS2kyW8M
	 C2FXPViyS0YdBvm5isd0+bdKqbRjeS7z+rYNoVR0pszS3IN5Pfc6jHG7bcR+6n9j14
	 Io+Fzb/mr3uwYTnWw+ZzVOsj2rpUObcbcQ0nY2w8qTELBDppjzqZQ9aaPQpB7EA6lv
	 tfYkUgnJEwYDA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id B44D93809A24;
	Wed, 21 Oct 2026 10:10:07 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v3 0/3] vsock: SO_INQ for stream sockets
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <179257740653.531562.5707162284579624546.git-patchwork-notify@kernel.org>
Date: Wed, 21 Oct 2026 10:10:06 +0000
References: <20261016132716.272018-1-devnexen@gmail.com>
In-Reply-To: <20261016132716.272018-1-devnexen@gmail.com>
To: David Carlier <devnexen@gmail.com>
Cc: netdev@vger.kernel.org, sgarzare@redhat.com, bobbyeshleman@gmail.com,
 davem@davemloft.net, edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com,
 horms@kernel.org, virtualization@lists.linux.dev,
 linux-kernel@vger.kernel.org

Hello:

This series was applied to netdev/net-next.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Fri, 16 Oct 2026 14:27:13 +0100 you wrote:
> This is the follow-up announced in the receive queue hint series [1]:
> SO_INQ and SCM_INQ for AF_VSOCK stream sockets, as AF_UNIX has.
> 
> Patch 1 moves the SOL_SOCKET option handling to a helper without
> functional change, patch 2 adds SO_INQ and patch 3 covers it in
> vsock_test.
> 
> [...]

Here is the summary with links:
  - [net-next,v3,1/3] vsock: move SOL_SOCKET options to vsock_sol_socket_setsockopt()
    https://git.kernel.org/netdev/net-next/c/a006b921ad32
  - [net-next,v3,2/3] vsock: support SO_INQ on stream sockets
    https://git.kernel.org/netdev/net-next/c/d7bb20b91122
  - [net-next,v3,3/3] vsock/test: cover SO_INQ
    https://git.kernel.org/netdev/net-next/c/3079ee3a8c62

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


