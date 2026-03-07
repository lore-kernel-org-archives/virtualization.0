Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 609B733290F;
	Sat,  7 Mar 2026 01:50:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772848211; cv=none; b=cdJDf1EI44fuqgkyPrRJ6rP8gRL6/f30quU5VuIAQfF6uWOaNsGARmygPVTxjWGkQhLnDnpV9yH/FijRZvIj82JRr06SjqkhvSEj2bV9ZPHJ2GQ9ewxkPpBbB5+w0uiAv/0kuYHBoS40ofzRBVh03YBFb6t4YpamH7ou7v3EqiE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772848211; c=relaxed/simple;
	bh=q+dkVaegM7HQrWVqo1Eiye5rYBXeYQR7vy8Zkngxqkg=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=cxabbncAbq769IczK0qLPpER7UKoMghnuRmnBbJYELL0CniotADZ6yy26v73ZKHqE+2h7no46Of78nyO3MadPl/VOevSrhqKwXv87si7R70zCQR/RNcRn6drXTsj0dm1QWgE3Fv0ra74xxNBEPEshSP7gOaiI4zz0CS4Pqz7738=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rebDNblq; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rebDNblq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B2941C4CEF7;
	Sat,  7 Mar 2026 01:50:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772848210;
	bh=q+dkVaegM7HQrWVqo1Eiye5rYBXeYQR7vy8Zkngxqkg=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=rebDNblqkSpmDqaJrvO/VjQ7jWujgkmK9Jt5O3sQgpctyMpVSUGwkSAJS64x8pyu4
	 Kr9f1NUGrRobNEenzjpC9wTrIRgu+D1UtW2V5I1Rtmw0tS/e01wqMBHbS1/eQ3Pr5N
	 ntzXpJbEKJrl20tpzXrvBqeV5W76ngB8FqbnY9YvmwI7qumIjMJD9HQPZ+4f3arr/7
	 vke9JyIYb3e9xlSaDXC5cPsE1CW5+5Q+vUgbm9nMxFNwRXPC5WfaYIx/R0sz66yoZ8
	 3L5576ewgCOC/lI/N26Yf+DrCIbDbnoqDupe2sub19kdbkIl4I7oRz/Si/c36PTevJ
	 FnqOnakoRYzHw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 02CD03808200;
	Sat,  7 Mar 2026 01:50:11 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v3] virtio-net: xsk: Support wakeup on RX side
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177284820957.121768.10885517697110084054.git-patchwork-notify@kernel.org>
Date: Sat, 07 Mar 2026 01:50:09 +0000
References: <20260304154317.7506-1-minhquangbui99@gmail.com>
In-Reply-To: <20260304154317.7506-1-minhquangbui99@gmail.com>
To: Bui Quang Minh <minhquangbui99@gmail.com>
Cc: netdev@vger.kernel.org, mst@redhat.com, jasowang@redhat.com,
 xuanzhuo@linux.alibaba.com, eperezma@redhat.com, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 virtualization@lists.linux.dev, linux-kernel@vger.kernel.org,
 kerneljasonxing@gmail.com

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed,  4 Mar 2026 22:43:17 +0700 you wrote:
> When XDP_USE_NEED_WAKEUP is used and the fill ring is empty so no buffer
> is allocated on RX side, allow RX NAPI to be descheduled. This avoids
> wasting CPU cycles on polling. Users will be notified and they need to
> make a wakeup call after refilling the ring.
> 
> Reviewed-by: Jason Xing <kerneljasonxing@gmail.com>
> Signed-off-by: Bui Quang Minh <minhquangbui99@gmail.com>
> 
> [...]

Here is the summary with links:
  - [net-next,v3] virtio-net: xsk: Support wakeup on RX side
    https://git.kernel.org/netdev/net-next/c/e3f8800aa243

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


