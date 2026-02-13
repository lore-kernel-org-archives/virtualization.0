Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7516D275AF0;
	Fri, 13 Feb 2026 20:40:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771015216; cv=none; b=DhgH+EQkWYhqIL4HQE4QB+DvTvF1YvXFqT6L7G7uKexvlCOFFNq+mYgEOmd1djzCU7YilHqE17My3GOyGHTKKg/jlv+KHAaUFXmMcztR84yIKRlV0975oDNF8Jsam5eZRslcE/KMyaLeAffVNhYTQDKk8X17bBBmsdJQRaNQO+4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771015216; c=relaxed/simple;
	bh=+eM9ztscJeS/hgVZKrr3HNj/n1uQxBLal7kZ2rOnIlo=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=QGb/NpDU+HiLlfsFs4odweyqyMBS937EVvelsRG/o8pyekUaqY8S6JRBikei7gj6OdoJdULOS64kaaPp09BY6yME0I+InePXuRABJ/mmBZY7D4J2JAPlXg6oAYgbQ+jKobVqnDyyToc/JEC7LCu343CFKgGOEKYmKtgn5gJQxvc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gEOh1qGN; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gEOh1qGN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0AB76C116C6;
	Fri, 13 Feb 2026 20:40:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771015216;
	bh=+eM9ztscJeS/hgVZKrr3HNj/n1uQxBLal7kZ2rOnIlo=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=gEOh1qGNr6XF2ncqXwmihvVfiFz1YEdBj210EJnFQszysje9L8Hqd0oX5x8SaPY5Q
	 rRmu7/u5qOaRggrBgySdvuK6MFSTFeeweVY5cLvVai2rrUoFDkeA9fOik71E9Ad59N
	 KF2taPsDCEngcrhaR3exmZGVT5nVVL7yJXCMuA3aO2ywb3ZnDk4eg1P0w4U6J1z4Vw
	 0eslqozjGKldB8ZO2P59LJfmc2SPbYj3Yq13et5iC8OV5QMFXdXfsJ2b3AOo6x8YKX
	 DncBYuvuRZ69XsYVcA5OsJm4L3sv9oWSAGNGPQ1kVpCR6qf1/8li9ATglQ9TeZHK94
	 plMBtDGg5Qp2g==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 0B20A3811A44;
	Fri, 13 Feb 2026 20:40:11 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net 0/2] vsock: fix child netns mode initialization and
 restriction
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177101520983.2551386.9528402801702490594.git-patchwork-notify@kernel.org>
Date: Fri, 13 Feb 2026 20:40:09 +0000
References: <20260212205916.97533-1-sgarzare@redhat.com>
In-Reply-To: <20260212205916.97533-1-sgarzare@redhat.com>
To: Stefano Garzarella <sgarzare@redhat.com>
Cc: netdev@vger.kernel.org, edumazet@google.com, linux-kernel@vger.kernel.org,
 bobbyeshleman@meta.com, kuba@kernel.org, virtualization@lists.linux.dev,
 pabeni@redhat.com, mst@redhat.com, horms@kernel.org, davem@davemloft.net

Hello:

This series was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 12 Feb 2026 21:59:14 +0100 you wrote:
> This series fixes two issues in the vsock network namespace support
> recently introduced by commit eafb64f40ca4 ("vsock: add netns to vsock
> core").
> 
> Patch 1 fixes `child_ns_mode` being always hardcoded to "global" for new
> namespaces, breaking propagation of the "local" mode through nested
> namespaces.
> 
> [...]

Here is the summary with links:
  - [net,1/2] vsock: fix child netns mode initialization
    https://git.kernel.org/netdev/net/c/9dd391493a72
  - [net,2/2] vsock: prevent child netns mode switch from local to global
    https://git.kernel.org/netdev/net/c/6a997f38bdf8

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


