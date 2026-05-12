Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D4D234B194;
	Tue, 12 May 2026 11:11:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778584263; cv=none; b=grZlS8D2rU/vbJmj91SpCEO4bvf1YcMrdxV72FDyEY3OBgqjPEti+VYOgAHPdDB0C97IhEXvTHGIya45mjcUf8b33Y2Xmg4DI/H4I8y1vXNs3fKJWiYFT0+3fuhg6WDQX9DDANtKoppxcW6rbCDvx7eopdoyCog0kFSsHctL43g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778584263; c=relaxed/simple;
	bh=T5qBBfTlLOCFqM3EzVqvA9J5ENejvnr88f1w2HugSv8=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=D9LyQEIRLhLel5aOr3rR6enbCd40jIQwaHA45wJzBI8OahrmHDmLnhEu8Zo+K8YsicjAWV7n6zN59XQUsw0cjiI5Ta3yV+wGKBmWv/eXtoQLK+F2I5ZhcCm7RHdNODPxe5z31UcDHUPQSMbw2CnE1hJ+pxCfUjrr+4FlNh7ua1E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=r8gdXzFi; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="r8gdXzFi"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CE752C2BCB0;
	Tue, 12 May 2026 11:11:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778584262;
	bh=T5qBBfTlLOCFqM3EzVqvA9J5ENejvnr88f1w2HugSv8=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=r8gdXzFiRgOUfeCa/F7I5vAhU3EG32bEIjQ4+i9Le5kzIz89Q8ooJDbs2chBpO77b
	 G5tDnct67+P/tZWJ+uoUQjWucH8kdj5XZyDX7Li7N8yp21u6Vu3piWHQmO4r1/r9qN
	 AuaXqSmlRtSGHqJam/LBLIY8JpblAwnYn6WX505SfK8b5zFolGqJMjETtOxNtLd9H8
	 QfocJ1GqOKBXaJ0kvV3+horSa1koiXDVlUj7hP7TudAoRREGpMySuCCt2RN8hANG4h
	 51+0cteElfxUJDgsjqPZhompfIDmR5BxYoNds9BofMpxtJrwAAvt4qzXxPBosvnjpD
	 M4KZx/iyv/VBA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 3FDDB380A979;
	Tue, 12 May 2026 11:10:10 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net 0/2] vsock/virtio: fix vsockmon tap skb construction
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177858420905.2807191.16905874591205920315.git-patchwork-notify@kernel.org>
Date: Tue, 12 May 2026 11:10:09 +0000
References: <20260508164411.261440-1-sgarzare@redhat.com>
In-Reply-To: <20260508164411.261440-1-sgarzare@redhat.com>
To: Stefano Garzarella <sgarzare@redhat.com>
Cc: netdev@vger.kernel.org, sunyiqixm@gmail.com, linux-kernel@vger.kernel.org,
 xuanzhuo@linux.alibaba.com, mst@redhat.com, stefanha@redhat.com,
 kvm@vger.kernel.org, horms@kernel.org, bobbyeshleman@meta.com,
 jasowang@redhat.com, kuba@kernel.org, davem@davemloft.net,
 virtualization@lists.linux.dev, edumazet@google.com, pabeni@redhat.com,
 avkrasnov@salutedevices.com, eperezma@redhat.com,
 bobby.eshleman@bytedance.com

Hello:

This series was applied to netdev/net.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Fri,  8 May 2026 18:44:09 +0200 you wrote:
> While reviewing the patch posted by Yiqi Sun [1] to fix an issue in
> virtio_transport_build_skb(), I discovered another issue related to
> the offset and length of the payload to be copied in the new skb.
> This was introduced when we did the skb conversion, and fixed by
> patch 1.
> 
> Patch 2 fixes the issue found by Yiqi Sun in a different way: using
> iov_iter_kvec() to properly initialize all the iov_iter fields and
> removing the linear vs non-linear split like we alredy do in
> vhost-vsock.
> 
> [...]

Here is the summary with links:
  - [net,1/2] vsock/virtio: fix length and offset in tap skb for split packets
    https://git.kernel.org/netdev/net/c/5f344d809e01
  - [net,2/2] vsock/virtio: fix empty payload in tap skb for non-linear buffers
    https://git.kernel.org/netdev/net/c/3a3e3d90cbc7

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


