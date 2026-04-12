Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 916AD362149;
	Sun, 12 Apr 2026 18:00:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776016854; cv=none; b=hhUFSTXKc0NyCu4aS1ulL5XcG4nFiDNVJQQjxhQ8U/ob7kD1FnCR742sCg51LRzeSMqSCWDaqTi5nXU/i5qaZVDjbPm4dDI2FYyybPFPLrPTX1vid+DQsLIPIgAVkHAI9uNXnCDmNFDzCpuy7Ygq/KmFpObL5z9DSHttFURByTE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776016854; c=relaxed/simple;
	bh=cpVpThsVDIuWHWEI8MIcs/A+E73RNhy4so7CkwixIXk=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=R6u4pm14O7nlP1JccVvT1Kq8l4oHYHFngSb6GEeczSnhwGTdW7rcYX2mu0ZDAqO2O19OCr8KycyZ4xEKQkvXv9AmmA7ZO4FDd7OHI1uPhMH3sjavBrV+M6zvOjjb9o3YSCkwZZqzU5zfeiuh4PrI7Tt/tmsafIDCgQaP+5YEiqQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OXneZx9l; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OXneZx9l"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 44765C19425;
	Sun, 12 Apr 2026 18:00:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776016854;
	bh=cpVpThsVDIuWHWEI8MIcs/A+E73RNhy4so7CkwixIXk=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=OXneZx9lQtmmmlNJ+/OQ5skGfS9LQPf2utTpMRWxvKjlkaiqkQPegNiwT5Z6Dt2R/
	 zLHBh8G/BbiEKz1lDKcTOWq4HFWcjZQM3sQMhQ0fqwdPDkXkSvyCIy/vPnsS6NYBof
	 fzfZTsCWNUWsQirSomg10TJJ0canEOFL44zehxMYdmuTqmjWAONPEZR3zEyiUsMPKD
	 fgEKEuDMpogCOJnnoqm3QFhqHLeB+B+J/AuMKnIkjQ2piYt4/+e4PQiCQ9t0uhbxgc
	 O7eMh7DJCf2OdUKIcYOSMmhBNQGKuGoGbG92f1E+RYyuptPFFzN9zsMbLNUxqDreUP
	 miNtYrd2uAugg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 02BF53809A8C;
	Sun, 12 Apr 2026 18:00:28 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v2] vsock/virtio: remove unnecessary call to
 `virtio_transport_get_ops`
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177601682654.3359939.6934554682952885882.git-patchwork-notify@kernel.org>
Date: Sun, 12 Apr 2026 18:00:26 +0000
References: <20260408-remove_parameter-v2-1-e00f31cf7a17@redhat.com>
In-Reply-To: <20260408-remove_parameter-v2-1-e00f31cf7a17@redhat.com>
To: Luigi Leonardi <leonardi@redhat.com>
Cc: mst@redhat.com, jasowang@redhat.com, xuanzhuo@linux.alibaba.com,
 eperezma@redhat.com, stefanha@redhat.com, sgarzare@redhat.com,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 horms@kernel.org, avkrasnov@salutedevices.com, kvm@vger.kernel.org,
 virtualization@lists.linux.dev, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 08 Apr 2026 17:21:02 +0200 you wrote:
> `virtio_transport_send_pkt_info` gets all the transport information
> from the parameter `t_ops`. There is no need to call
> `virtio_transport_get_ops()`.
> 
> Remove it.
> 
> Acked-by: Arseniy Krasnov <avkrasnov@salutedevices.com>
> Acked-by: Michael S. Tsirkin <mst@redhat.com>
> Signed-off-by: Luigi Leonardi <leonardi@redhat.com>
> 
> [...]

Here is the summary with links:
  - [net-next,v2] vsock/virtio: remove unnecessary call to `virtio_transport_get_ops`
    https://git.kernel.org/netdev/net-next/c/006679268a29

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


