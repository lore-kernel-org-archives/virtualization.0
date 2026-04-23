Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7DE23793BF;
	Thu, 23 Apr 2026 11:10:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776942644; cv=none; b=Cg/TvswbtyBEv/SxSk0lZdIqGSVxOVSCvDy2NErFNeLoT+aQAk3p/NXxfe8DUhuDiHeEniidCEVkua7I5HmVlhq887I/Vpt65HuGZJy7kszN4p4Ywz3PiM0kgnqX3yY3PPsBD4bq2CpDQKzNx7AMawm1v6vih1uaM62f4ra4ME4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776942644; c=relaxed/simple;
	bh=q/MO0aEEY1J/xinh+nE2w5/ns9zt5bzai2BiTVCHNRk=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=bl1+JGDqNZR5jP8Nb9DlQsi4q6ukYL90AUEYfEH66L/jszl/3atenvFY7T45ON3xesXkdJsZ+WmQydb22SRLUFjCEUplA9V9v+rZvqP0VzmGLP0dMLLxsezYgfLiSeWTslizLg+c47PK4wLqLa1wtrmRR9cCaWZ4TIg87PgLoFg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QMyjkQJz; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QMyjkQJz"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 52A90C2BCAF;
	Thu, 23 Apr 2026 11:10:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776942644;
	bh=q/MO0aEEY1J/xinh+nE2w5/ns9zt5bzai2BiTVCHNRk=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=QMyjkQJzAVrZt5YYbF9d9VV9ejn7clw4Q1M6EFh+4ywWW42HW5fC1Bz31lLH1jW4T
	 4kHkrtWvkCTUnJ6Q2e6Z/HrYGXGCHw9Xt8YtWCYk2Ff1WtgHCrz5SH7SQ9ahFyAR78
	 +a++W+lRZp6DaP77BmybEbbnhjt1qfG3TG/fxQzDi8iJTokjXcpo1jZRw0LaiGRU8S
	 ebJXeCtf9rzY2S5aCCNdJ3f+dWJbYTd+qddQqH234UudNLI+BQTQaf3dLkQO1+8RAk
	 Az3UbNzvaMdb2S3hijjw7UhD8sXaFqpOOJAlO09l4dStJjyvsQCLmQtfGLwYK9BPgO
	 yDsCU7NrNyw2Q==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 3FC79380CFFD;
	Thu, 23 Apr 2026 11:10:07 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] vsock/virtio: fix MSG_ZEROCOPY pinned-pages
 accounting
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177694260605.114344.12041685261933585177.git-patchwork-notify@kernel.org>
Date: Thu, 23 Apr 2026 11:10:06 +0000
References: <20260420132051.217589-1-sgarzare@redhat.com>
In-Reply-To: <20260420132051.217589-1-sgarzare@redhat.com>
To: Stefano Garzarella <sgarzare@redhat.com>
Cc: netdev@vger.kernel.org, edumazet@google.com, horms@kernel.org,
 kvm@vger.kernel.org, avkrasnov@salutedevices.com, davem@davemloft.net,
 pabeni@redhat.com, kuba@kernel.org, mst@redhat.com, jasowang@redhat.com,
 virtualization@lists.linux.dev, linux-kernel@vger.kernel.org,
 eperezma@redhat.com, xuanzhuo@linux.alibaba.com, stefanha@redhat.com,
 yimingqian591@gmail.com

Hello:

This patch was applied to netdev/net.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Mon, 20 Apr 2026 15:20:51 +0200 you wrote:
> From: Stefano Garzarella <sgarzare@redhat.com>
> 
> virtio_transport_init_zcopy_skb() uses iter->count as the size argument
> for msg_zerocopy_realloc(), which in turn passes it to
> mm_account_pinned_pages() for RLIMIT_MEMLOCK accounting. However, this
> function is called after virtio_transport_fill_skb() has already consumed
> the iterator via __zerocopy_sg_from_iter(), so on the last skb, iter->count
> will be 0, skipping the RLIMIT_MEMLOCK enforcement.
> 
> [...]

Here is the summary with links:
  - [net] vsock/virtio: fix MSG_ZEROCOPY pinned-pages accounting
    https://git.kernel.org/netdev/net/c/1cb36e252211

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


