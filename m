Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F3283BBA09;
	Thu, 21 May 2026 11:29:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779363000; cv=none; b=FGBz7hLnIZLgojgyBPQjJ4ZnuDfVpJlfGccUJadMBakMTug+WOirC0j4DKVhPZu6WpJdhk2uXEZVMwRAY6uWzesOlBaLMVvXjB+KZLJu/UF+uojicVvC7zMX3NjkV5o48c/2ruhGbm6Wwjq8qY1vBsXs2ylNx/D2Va6IU7cu28U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779363000; c=relaxed/simple;
	bh=CrIXAK34/P6ZhcqwMGPKjl0qLQoKNsbsyAPMi5EOzgs=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=WZaVPUsFrXAvUoq8W4+SmNt+nNI1iB5RWQepnCaWSflMZFT2VYqaOHx1PuJjwE4ap7qj9eSmYh42VZ5ZiEudaAPhS2kfEzVZ1AGp4IY+vKnhBdyRvnFYRhNeBiZXf6tIgRnqx1kq6TypwdfyhEFnioBhmwFH9j0vm/i276nFpEs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hrfXfemN; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hrfXfemN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2A2401F000E9;
	Thu, 21 May 2026 11:29:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779362999;
	bh=vYmeltNiMiuGkyHSLFUJASOXqy4p76IQNAxo5cdtG84=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=hrfXfemNJmUo/mgbAUqoAe0JvZqoj0POr2LTaI/ovPNnOJfjhASQsmZmLSMKyZa+W
	 TDxYB9AGLRpCMJP+FpPrwPQZBQ3Ut8bhZucyH2fXY0xIkVjzcG01ztqU49fk5e/fgh
	 fmyyCPbZDnUQUYaQNnqx1YlvRxc6QIGC5v7Ukew10WUmMzoudpMj+GH5k4r6YDXy2f
	 hFiE2idaW2VeJm1jwB7Km18QzyQ1xSkgvUk1bRoWSubBPNgO1wruVk8pQ5WBXB3+Ly
	 gBOIQxE1yflsEIx1rzLvIQ7KeknMd4B2AAWzXu5M/hNACpG2UbrpK7oepgWokyIcDh
	 8rwnZRRutVLdA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 569283930D6A;
	Thu, 21 May 2026 11:30:10 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v4 0/2] vsock/virtio: fix skb overhead accounting to
 preserve full buf_alloc
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177936300889.4039621.15393886703145143814.git-patchwork-notify@kernel.org>
Date: Thu, 21 May 2026 11:30:08 +0000
References: <20260518090656.134588-1-sgarzare@redhat.com>
In-Reply-To: <20260518090656.134588-1-sgarzare@redhat.com>
To: Stefano Garzarella <sgarzare@redhat.com>
Cc: netdev@vger.kernel.org, horms@kernel.org, kuba@kernel.org, mst@redhat.com,
 pabeni@redhat.com, jasowang@redhat.com, davem@davemloft.net,
 kvm@vger.kernel.org, stefanha@redhat.com, linux-kernel@vger.kernel.org,
 edumazet@google.com, xuanzhuo@linux.alibaba.com,
 virtualization@lists.linux.dev, eperezma@redhat.com

Hello:

This series was applied to netdev/net.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Mon, 18 May 2026 11:06:54 +0200 you wrote:
> Patch 1 resets the connection when we can no longer queue packets,
> this prevents silent data loss, and both peers are notified.
> 
> Patch 2 increases the total budget to `buf_alloc * 2` for payload
> plus skb overhead similar to how SO_RCVBUF is doubled to reserve
> space for sk_buff metadata. This preserves the full buf_alloc for
> payload under normal operation, while still bounding the skb queue
> growth.
> 
> [...]

Here is the summary with links:
  - [net,v4,1/2] vsock/virtio: reset connection on receiving queue overflow
    https://git.kernel.org/netdev/net/c/a4f0b001782b
  - [net,v4,2/2] vsock/virtio: fix skb overhead accounting to preserve full buf_alloc
    https://git.kernel.org/netdev/net/c/c6087c5aaad6

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


