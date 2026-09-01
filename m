Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB22C2D7DC6;
	Tue,  1 Sep 2026 00:01:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788220870; cv=none; b=c3pBR6zhfGkWFJ1BANBpn1TTHcac/487W/v5Np/k1SwEydTHkldLrLkmpj9cf7+KFfRmWOOX6bLGF3/d4hYnVEGCtS/kFjKpHExf9IJ32f0ocr9fIAQzCwoehcWsN/Vo5iwuUGyZ1u3hN/0SYIBu7gt2hrrLuW42610aO+p/EiQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788220870; c=relaxed/simple;
	bh=TxBoHBmzjXms+2ExTbR2y49kGKuy3NX9DEJYIxgMQrg=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=foEmkIiEALyzKcO8YlRm91SSBSTjjTPIGtPm7HvXA8eqT5bQHEM2/iXUI9ASwZmMhU7rqIIhYW0DpnjP+d11UDARctykb41A/Ey31sG4qmFI5wiyCxEqol8S7OkcouY7363rDvcHoSSsIHb/EzTdWggu9L2LsQ/mptfB7A2yHjU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iAeFn1dp; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iAeFn1dp"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6EA0D1F00A3D;
	Tue,  1 Sep 2026 00:01:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788220869;
	bh=aMHkGXcW+o4pCoVFz76ekLaBwuBKkRIBpyc2q+CcbOw=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=iAeFn1dpYZOUMwEXaeCifdY4SUY2dCCA3Niog0alh/FngLqrcmW7GCXO67sAeimBo
	 Dm+RVb7sZqBgeZ+rgpZtBSea/9NjMHRoaaMasGKuGK3/7GCA7VCS0kpsOfve7jxSpZ
	 BhOhOrEtKPU/mF7pekokY6P6BRxO3wgOtriARLsK/e1JPFNFsaIZCKdgJvtMRtf7Dl
	 yrPll77kp/qXL9Ienq7ic4vB+EaqzAKREhN/oM9WNMyGTmmQIBl/2sTxuZd2PcRndH
	 o/Xd6D3c2PBsgbTlxVUXnGu2y56L7CX6uUniH1rUB5zY/0LlPZyIHN0ThJFJExjxH7
	 70IziiFwyrqxQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 9398E392447E;
	Tue,  1 Sep 2026 00:00:13 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v4 0/2] vsock: validate packet sources after bound
 lookup
 fallback
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178822081213.841883.14927327834085182039.git-patchwork-notify@kernel.org>
Date: Tue, 01 Sep 2026 00:00:12 +0000
References: <20260826003929.966160-1-4ncienth@gmail.com>
In-Reply-To: <20260826003929.966160-1-4ncienth@gmail.com>
To: Daehyeon Ko <4ncienth@gmail.com>
Cc: netdev@vger.kernel.org, sgarzare@redhat.com, stefanha@redhat.com,
 bobbyeshleman@gmail.com, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, mst@redhat.com,
 jasowangio@gmail.com, xuanzhuo@linux.alibaba.com, eperezma@redhat.com,
 bryan-bt.tan@broadcom.com, vishnu.dasa@broadcom.com,
 bcm-kernel-feedback-list@broadcom.com, virtualization@lists.linux.dev,
 kvm@vger.kernel.org, linux-kernel@vger.kernel.org

Hello:

This series was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 26 Aug 2026 09:39:26 +0900 you wrote:
> Both virtio and VMCI look up connected sockets by the full tuple before
> falling back to a destination-only bound lookup. The fallback can select a
> non-listening socket without validating the packet source.
> 
> V2 covered only the virtio path. Following Stefano's review, this series
> moves the source and transport validation into a documented AF_VSOCK helper
> and uses it for both virtio and VMCI. The VMCI patch checks both its
> bottom-half and deferred workqueue receive paths.
> 
> [...]

Here is the summary with links:
  - [net,v4,1/2] vsock/virtio: validate packet source for connected sockets
    https://git.kernel.org/netdev/net/c/dee44f41f206
  - [net,v4,2/2] vsock/vmci: validate packet source for connected sockets
    https://git.kernel.org/netdev/net/c/ad9a7da3fa39

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


