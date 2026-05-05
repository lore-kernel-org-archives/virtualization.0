Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1808336F43E;
	Tue,  5 May 2026 02:20:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777947656; cv=none; b=e3SawtHXgL+eC4ylfOIyN0ZpBnx5g+o9fx2m+D/nxkmC3Ax7Xx3gb7nHZn+3lMLAKkXN1fM9J9XXj/69hed8K9vlXmCzQVcmcOM3ky+AZ3DS/9ypKNu3j9iZzadKqLr8blDdFLWwfLA+rPDdOZrgzrURDmxozTNVxx9RDAavTPE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777947656; c=relaxed/simple;
	bh=dl8IxoXyqBKSnmIR/5RHeIyxyC3GJ6oPPNEUS2xiSrM=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=JFHhXPiRpxYSQP3vShRZgMRpZPj8b+xF33+W13t8iAXcFR8K8ZtpUjul1NCQQIsSuPnTQkPyOUcBzE6OqDgYA8A0uo2ONEt1UJaogaPyur+FQLHEfgZR6e0jxENwKLNEBjXSigP+qOkEpHIpk4TOdqmTFB9XKVTAxBBKeqomYik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YBwPcBey; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YBwPcBey"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B4871C2BCB8;
	Tue,  5 May 2026 02:20:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777947655;
	bh=dl8IxoXyqBKSnmIR/5RHeIyxyC3GJ6oPPNEUS2xiSrM=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=YBwPcBeyKguNK4XwK6M3C93C4ZZ/tzDCziJZF6b6Hwd1RiNcbU6PTuv9fdm9MAJZ+
	 +907+nXQ8l42MfVIEtWiee2NnT81LDHaUlIYy86zTdg1gXRYCR+pvXjHrPjChW2Qtn
	 f0Kcfp9UPPyYhpXAtasyRiAWQdpoyd0z+bJJMN8UmsOi5xnSWati4DvgbVBJxlHgOd
	 DYFGb6lrlBbRTMGWwFXZr7aBXZKIP1PvKa1f3tmlgJanCAwdJPjuZWERHGohjgHZJd
	 mYz8xtpgJJuyqGCkNB7vy+kwM84fk7s/JFz97CC3ZyV0qof+OtzjPBUn8Au5WOjIJX
	 Oele1ySggeqFA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id B9E1B39301A2;
	Tue,  5 May 2026 02:20:07 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] vsock/virtio: fix potential unbounded skb queue
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177794760655.1391894.17424925613483370509.git-patchwork-notify@kernel.org>
Date: Tue, 05 May 2026 02:20:06 +0000
References: <20260430122653.554058-1-edumazet@google.com>
In-Reply-To: <20260430122653.554058-1-edumazet@google.com>
To: Eric Dumazet <edumazet@google.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 netdev@vger.kernel.org, eric.dumazet@gmail.com, AVKrasnov@sberdevices.ru,
 stefanha@redhat.com, sgarzare@redhat.com, mst@redhat.com,
 jasowang@redhat.com, xuanzhuo@linux.alibaba.com, eperezma@redhat.com,
 kvm@vger.kernel.org, virtualization@lists.linux.dev

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 30 Apr 2026 12:26:52 +0000 you wrote:
> virtio_transport_inc_rx_pkt() checks vvs->rx_bytes + len > vvs->buf_alloc.
> 
> virtio_transport_recv_enqueue() skips coalescing for packets
> with VIRTIO_VSOCK_SEQ_EOM.
> 
> If fed with packets with len == 0 and VIRTIO_VSOCK_SEQ_EOM,
> a very large number of packets can be queued
> because vvs->rx_bytes stays at 0.
> 
> [...]

Here is the summary with links:
  - [net] vsock/virtio: fix potential unbounded skb queue
    https://git.kernel.org/netdev/net/c/059b7dbd20a6

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


