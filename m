Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBF1419046E;
	Tue, 18 Aug 2026 13:01:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787058104; cv=none; b=Y8MP0JPJKXAvKIoRohDgTlo7IydBknaCW2aZObc5l25g6WAsU0cKoh2kVxYSjXgn5YoHHl28R0dk7ZEIGg8LoZiz9YWsH3+J52f+tTeZ8m5ptbM8hYB95JsGq400TviYVGaBqAr5RjvOJ8glWOmifptatAMAlIRovpP0xgGVtt4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787058104; c=relaxed/simple;
	bh=qPf0L/zcpkllaObsPOSTHmFdzqvK8eYTGpixcTGcHNc=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=ajLOrJlV8k5SJjKJn5Vtp8DXsPc5zyqybexmP9saZaWQNEZZrffVvCA9UojJlUucSoMeNFjYXRzjrvFafoXRxNCOr2qoGucPeBfl1zD9pjUdcPRVnvX+bL9cB0HjvJJNX19hAbRcSy3jUt/Px963ZQ5yy5YKILyJUDfAymbEyBs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BecyXK5B; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BecyXK5B"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6AE841F000E9;
	Tue, 18 Aug 2026 13:01:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787058103;
	bh=gdUf+JvPTrd9D/HoyORD69Di0LvdQ3GcxLEooZloo5o=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=BecyXK5BtjfDIxFMRwKYL1pcxo5Z6VbqTLLAzeLzECD+sTpGIAwZAQOaNf/Jq2KLC
	 c+6jBJ5y+5EV1uCSdXy0aGPpZYiGBDi6qJIbn6vVFbb5CTha/htnoXfUHi9HaMQpHB
	 2UZNJUEIhsrzpv0QoOTabpj4FoM8WEYP3MnxoqJGxk+imFUmvrGnJB02VPNQ9WacYC
	 EGWMgD17xZHbvHbbSh5R43Bo6JkpHB1Cczy1KpYCs/Do26lXqM58s358iuqIT6hOFm
	 urz834k794ibPP/7EpmpH5ZsjUH9U37JuFKEPey3q5k7Me2xbwBCYDMJwHzEjqOG/b
	 aJhO70CrRXrpw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 5690B3926661;
	Tue, 18 Aug 2026 13:00:56 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v6 0/3]  vsock: fix stale sk_err handling after a failed
 connect
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178705805497.2073627.6439611667147974216.git-patchwork-notify@kernel.org>
Date: Tue, 18 Aug 2026 13:00:54 +0000
References: <20260813173024.2362935-1-phind.uet@gmail.com>
In-Reply-To: <20260813173024.2362935-1-phind.uet@gmail.com>
To: Nguyen Dinh Phi <phind.uet@gmail.com>
Cc: sgarzare@redhat.com, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, dtor@vmware.com,
 acking@vmware.com, georgezhang@vmware.com, virtualization@lists.linux.dev,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org

Hello:

This series was applied to netdev/net.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Fri, 14 Aug 2026 01:30:17 +0800 you wrote:
> A socket whose connect() failed keeps sk_err set. If that socket is
> later reused as a listener, vsock_accept() rejects an unrelated
> incoming connection, and on virtio/hyperv the resulting child socket
> is leaked.
> 
> Patch 1 removes the listener's sk_err check from vsock_accept(), since
> no vsock transport ever sets sk_err on a TCP_LISTEN socket. This will
> fix what the syzbot reported.
> 
> [...]

Here is the summary with links:
  - [v6,1/3] vsock: don't check the listener's sk_err in vsock_accept()
    https://git.kernel.org/netdev/net/c/b8c899cf5e7b
  - [v6,2/3] vsock: remove the now-unused rejected flag
    https://git.kernel.org/netdev/net/c/81fc0f369637
  - [v6,3/3] vsock: use sock_error() to consume sk_err after a failed connect
    https://git.kernel.org/netdev/net/c/96cbf8999309

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


