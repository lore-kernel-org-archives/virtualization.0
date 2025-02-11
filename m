Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 733CB1D88C3
	for <virtualization@lists.linux-foundation.org>; Tue, 11 Feb 2025 03:30:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739244617; cv=none; b=ZqPA29mF/whX5UcV8VoWswZZEQBaF8cykTP/Kwcz097MpcuJPWcUgBduCg350SAUzb/btKSqiXcz6e05q/Xb7No6XPy+JoS+zdHBp+rHwaQB1pJO0FPIMdRThTPYtAcfXCl5mE9OfCja9HedynbbUb9Pnkcc7tw5PjuyID30Qg8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739244617; c=relaxed/simple;
	bh=Td1U0MsX4jwP0X608ibiA1txDzrYo+jkLqYHfL6unXc=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=AYLfBECQxCAKbxIGnzYQRr2lPABJWzzC6Ds4xHaV0b47krqJfM+XHFL4FXg1WIBLTYQ+aybDmrXWIe7F2dpQklG/qbyry2K0FK/IhE1BK++8m8B8BRU16qpSca5P7litkadK4NpqaCuGkWtItBluk25mU8rxhSDS/LzzLi3dKT8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gbt18T0R; arc=none smtp.client-ip=140.211.166.136
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gbt18T0R"
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id D117B60E7B
	for <virtualization@lists.linux-foundation.org>; Tue, 11 Feb 2025 03:30:15 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -4.401
X-Spam-Level:
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id gMycsFg5DWz8 for <virtualization@lists.linux-foundation.org>;
 Tue, 11 Feb 2025 03:30:15 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2604:1380:4641:c500::1; helo=dfw.source.kernel.org; envelope-from=patchwork-bot+netdevbpf@kernel.org; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org E92A960E7C
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org E92A960E7C
Authentication-Results: smtp3.osuosl.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=gbt18T0R
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
	by smtp3.osuosl.org (Postfix) with ESMTPS id E92A960E7C
	for <virtualization@lists.linux-foundation.org>; Tue, 11 Feb 2025 03:30:14 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 1C4875C623D;
	Tue, 11 Feb 2025 03:29:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 53A01C4CEEA;
	Tue, 11 Feb 2025 03:30:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739244613;
	bh=Td1U0MsX4jwP0X608ibiA1txDzrYo+jkLqYHfL6unXc=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=gbt18T0RcqqWiwoOTneZSCFnbdT9Fh21yaei243no3AOA6QOtjPweKQuRpUQSF1oP
	 z9Lztst6r2SkNca/uGAtFwlQ2IquVXqAUCAHbPY7tuhm5fMn8ebzZAk7fu4WeD3hnn
	 QOIQSJsL7MRnGD0JSM+yz9/9KmDw4PEuCi9rO5V+2O3lNm4INPGEfZsZba8sYwJVSi
	 vfyPUVCxJ4HjKfZlK4LiJPMIQJEg6dzI5wSYXdlXkcwxf2qqGjKW0lJYwl76oeWDY7
	 M+/QswcMvpB5c4SKp1VT6ExvkdahmqBBGejG54v2Ynq1kJPlPnNaSEO8Gu5gT97iWJ
	 QRNI6EVZuTfVg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33DDF380AA7A;
	Tue, 11 Feb 2025 03:30:43 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v6 0/7] tun: Unify vnet implementation
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <173924464176.3948401.17256177133677367804.git-patchwork-notify@kernel.org>
Date: Tue, 11 Feb 2025 03:30:41 +0000
References: <20250207-tun-v6-0-fb49cf8b103e@daynix.com>
In-Reply-To: <20250207-tun-v6-0-fb49cf8b103e@daynix.com>
To: Akihiko Odaki <akihiko.odaki@daynix.com>
Cc: corbet@lwn.net, willemdebruijn.kernel@gmail.com, jasowang@redhat.com,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 mst@redhat.com, xuanzhuo@linux.alibaba.com, shuah@kernel.org,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 netdev@vger.kernel.org, kvm@vger.kernel.org,
 virtualization@lists.linux-foundation.org, linux-kselftest@vger.kernel.org,
 yuri.benditovich@daynix.com, andrew@daynix.com, stephen@networkplumber.org,
 gur.stavi@huawei.com, devel@daynix.com, willemb@google.com

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri, 07 Feb 2025 15:10:50 +0900 you wrote:
> When I implemented virtio's hash-related features to tun/tap [1],
> I found tun/tap does not fill the entire region reserved for the virtio
> header, leaving some uninitialized hole in the middle of the buffer
> after read()/recvmesg().
> 
> This series fills the uninitialized hole. More concretely, the
> num_buffers field will be initialized with 1, and the other fields will
> be inialized with 0. Setting the num_buffers field to 1 is mandated by
> virtio 1.0 [2].
> 
> [...]

Here is the summary with links:
  - [net-next,v6,1/7] tun: Refactor CONFIG_TUN_VNET_CROSS_LE
    https://git.kernel.org/netdev/net-next/c/5a9c5e5d8a1b
  - [net-next,v6,2/7] tun: Keep hdr_len in tun_get_user()
    https://git.kernel.org/netdev/net-next/c/07e8b3bae2f8
  - [net-next,v6,3/7] tun: Decouple vnet from tun_struct
    https://git.kernel.org/netdev/net-next/c/60df67b94804
  - [net-next,v6,4/7] tun: Decouple vnet handling
    https://git.kernel.org/netdev/net-next/c/2506251e81d1
  - [net-next,v6,5/7] tun: Extract the vnet handling code
    https://git.kernel.org/netdev/net-next/c/1d41e2fa93f7
  - [net-next,v6,6/7] tap: Keep hdr_len in tap_get_user()
    https://git.kernel.org/netdev/net-next/c/74212f20f366
  - [net-next,v6,7/7] tap: Use tun's vnet-related code
    https://git.kernel.org/netdev/net-next/c/6a53fc5a8770

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


