Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74AF435C1AE;
	Fri, 27 Mar 2026 03:20:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774581628; cv=none; b=MfFh3smtz0sAl/lbVuWSAE6czwKzpXT82n1Lgb3FKy0BJbV9iuOeBxJ4PQuK5+qcS5z0PrQJDujsNXoCYsp/9vPrEHzhXosWcaA1DVr+kp4w+RDzLncnby52LQpeLz9BuYE+h3W1NCCDXqO48qr1QBZqPkaHVIQTV9x2wWntP5c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774581628; c=relaxed/simple;
	bh=NMNqDhrPaal3Yltv8RJLavSk/i9ysKkz0fwPnx3hNL8=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=oPH9k4chNlHxH0cOIM1/Sxjlwnpmo+EbXdiJBeTCtigAIcq9D7QqSIZCty51v66t9gy8FDJ8wD+FBa/2DEgre5oogb9wXKU7FsPW/fAgC0ZQnyceM8pb8TSei/qatS5eWC/ANWvkFj0ysdNHeoJr9VzwYwPVH3vQJdFgsPuG9eg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Y2+LoeQW; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Y2+LoeQW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 09145C116C6;
	Fri, 27 Mar 2026 03:20:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774581628;
	bh=NMNqDhrPaal3Yltv8RJLavSk/i9ysKkz0fwPnx3hNL8=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=Y2+LoeQWsCDZA0zXQ7ruhPWgwkMRKNPKXe9mreuJvEQbHpG29Mq9RM43y4GEMC+pq
	 JpdvMSxLpvF5VCr4HRpd8ms+3F4ZgadhTgXUceyi7DHtb8jRwPUExBRXVPT65BDJDR
	 BTdjJTjVxc2mfqnbyvsVYZyc3BRi1tPSuMrPUdS74yhVppFjaP4LOiTqJ0X6qxMxPQ
	 dKffPS/6g4vuAZN9aSoYf7wtKzK0jKq9TL02mHKdvAptSMm6c3Puhc73r0E6SCWTZN
	 3ijD/lmKlo0kUshCo1Rao/T/c/kpyRH6XXszPfEwXZZ0TRiWsGYZGGfx1DNz0sN+bN
	 da8UEhhWHDF/Q==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 7CFEC3809A0B;
	Fri, 27 Mar 2026 03:20:15 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] virtio_net: sync RX buffer before reading the
 header
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177458161428.3283168.99448398733931105.git-patchwork-notify@kernel.org>
Date: Fri, 27 Mar 2026 03:20:14 +0000
References: 
 <f4caa9be9e5addae7851c012cab0a733be7f0974.1774365273.git.mst@redhat.com>
In-Reply-To: 
 <f4caa9be9e5addae7851c012cab0a733be7f0974.1774365273.git.mst@redhat.com>
To: Michael S. Tsirkin <mst@redhat.com>
Cc: linux-kernel@vger.kernel.org, oelghoul@linux.ibm.com, sraithal@amd.com,
 jasowang@redhat.com, xuanzhuo@linux.alibaba.com, eperezma@redhat.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, ast@kernel.org, daniel@iogearbox.net,
 hawk@kernel.org, john.fastabend@gmail.com, sdf@fomichev.me, vishs@meta.com,
 netdev@vger.kernel.org, virtualization@lists.linux.dev, bpf@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 24 Mar 2026 11:15:54 -0400 you wrote:
> receive_buf() reads the virtio header through buf before
> page_pool_dma_sync_for_cpu() runs in receive_small() or
> receive_mergeable(). The header buffer is thus unsynchronized at the
> point where flags and, for mergeable buffers, num_buffers are consumed.
> 
> Omar Elghoul reported that on s390x Secure Execution this showed up as
> greatly reduced virtio-net performance together with "bad gso" and
> "bad csum" messages in dmesg. This is because with SE sync actually
> copies data, so the header is uninitialized.
> 
> [...]

Here is the summary with links:
  - [net-next] virtio_net: sync RX buffer before reading the header
    https://git.kernel.org/netdev/net-next/c/fe3e54253f0b

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


