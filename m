Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 616E13815D1;
	Thu, 26 Feb 2026 03:10:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772075411; cv=none; b=UqqQfZWa5Kv2YNkFX0ANJc0rb9V/+VptN074XPXXdVdDt2Kg8LTJRUJaU/uoHbvTgeVWSsffiPDc4OSy59dXaZ+O476TNfidbUUiOlMRSMZfKpf0SuSoGWQSzLM/fbicPN+gRx3d70CcqCL7QS6oi1wToUFOpzEMFJFSmzIGlfY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772075411; c=relaxed/simple;
	bh=9y2X9NVB2pzNbHqipUSWuvBc3Db8CLsGCSON2WIFajY=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=rRys8hJk5TCSsCHttzHvdq2Eqo/SGuZQg4qyS2x4G8hg2d9yFP4bGpkZTGztbWcG9taB3qLuoqtyhKjQ1W87kjwf2OqWlDd5k18EOPfYhpz7THjTTW3QPLkQY6Qnm5FAB7NSNrfkh5k9cC+utp9wCfhgoM6h3BWqS20AFNozmHE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=E1o9nfNY; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="E1o9nfNY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 44A1BC116D0;
	Thu, 26 Feb 2026 03:10:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772075411;
	bh=9y2X9NVB2pzNbHqipUSWuvBc3Db8CLsGCSON2WIFajY=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=E1o9nfNY/PTQpqpoatO6E+pJhQtgGIQLyuATHXq3LkNjNlriGSRosF9go3QgxGZgm
	 KvrlEQu1zZ1jkV2cLLE8uV1PbQ7ebnh2Snu8xC5kHPn+GqcRt5Wi0qipLZOZwC7PeJ
	 X28k5oMgTmoHKoPPRSeE57f3q+FsegUaB7QbyN9UpBbOHwFFSHMWroKp8wVV9rSR4i
	 6a+H0kwrASdxM81xO6kErhIoia/Rmolkuyk/tSixPMx71mQFocquXIpVrhA8RFF8Za
	 e38Zt0LeFkOhMJfFegSttE/AvdXMOSwtXJEnPFXvCkZBJDnCBzwF1JLICyr08igRyn
	 JUzg83WemC0JQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 3FEC0380A94B;
	Thu, 26 Feb 2026 03:10:17 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] vsock: Use container_of() to get net namespace in
 sysctl
 handlers
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177207541604.1014739.11994521335982441841.git-patchwork-notify@kernel.org>
Date: Thu, 26 Feb 2026 03:10:16 +0000
References: <2026022318-rearview-gallery-ae13@gregkh>
In-Reply-To: <2026022318-rearview-gallery-ae13@gregkh>
To: Greg KH <gregkh@linuxfoundation.org>
Cc: virtualization@lists.linux.dev, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, sgarzare@redhat.com, stable@kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 23 Feb 2026 18:32:18 +0100 you wrote:
> current->nsproxy is should not be accessed directly as syzbot has found
> that it could be NULL at times, causing crashes.  Fix up the af_vsock
> sysctl handlers to use container_of() to deal with the current net
> namespace instead of attempting to rely on current.
> 
> This is the same type of change done in commit 7f5611cbc487 ("rds:
> sysctl: rds_tcp_{rcv,snd}buf: avoid using current->nsproxy")
> 
> [...]

Here is the summary with links:
  - [net] vsock: Use container_of() to get net namespace in sysctl handlers
    https://git.kernel.org/netdev/net/c/5cc619583c7e

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


