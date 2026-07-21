Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDF152E401;
	Tue, 21 Jul 2026 13:20:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784640038; cv=none; b=CXrDVeeurYk30LgKCxKtu/QVY1BlwFt9ukSXU//hO5tQiXSRuEMUAUGbcNyn8cJH/9liQj6k1k/sfEfJWUuT2C5sRSDcys1TNKk6X9XK1MD/7Hvhr8AkQjIaaIg6vhHkudkTGMYwXZrwzkqiKOVAtstoTHb9+r4XklIC+M8t2mc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784640038; c=relaxed/simple;
	bh=Z/uHeSbQnzDQWMaKbujY8RJncvzRTG5P6n9VoWX7wkY=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Ko7OeGn3hc7j4wFCyAecqkjfv95h4/QTvbOXqOyOeUeWuIdNN+qK0oscCWFnFTktr2Gh/CuUJIBaS9pkAcBnWpuMkMEpcUy4IjMH+yCXd/rdXqFzFTxRhHh1rMi8theqpnXblfAKHRerNXhTm6uhL2gb7xpISMv1BDDZTVDGONg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=T7phW2iQ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="T7phW2iQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6E2C31F000E9;
	Tue, 21 Jul 2026 13:20:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784640037;
	bh=Dm940Cf75lvvda7pO3DcsuCBsfGv/fBYpsSFhHMbOlQ=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=T7phW2iQ0enVI8jZxp1GbGdsa9lr/Bg4Y+srut0GkMA1BVlCR7VYa+duROfYuupox
	 Jh10bUUjj3/+QTDuEC3zi5BvRa3xT5XfalyCvjhp/rYaruHZXfp8eLZ3G51EIh52Ee
	 nn6fM47IlHGePNwnrsnu94/eTGwcaxOz3GMOvi3SfwU+gjKONfLwhhT0QJKMHoCqZa
	 JWO7xVimK/A2GtqZJgS/dpB6ajbbW3IS6VfNJhyTlBkbMMTjhr5bvXfXtylfh1fy1A
	 UXbMJZXLW88B6xDCq0YYI8nOxK/w8dnrOs0a7NuKbh5iLBMpTEx+l5unx44nm91fWK
	 qO3vaidAtPBIA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 56A4C3924FDF;
	Tue, 21 Jul 2026 13:20:08 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] vhost-net: fix TX stall when vhost owns virtio-net
 header
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178464000690.281806.12019184491759783883.git-patchwork-notify@kernel.org>
Date: Tue, 21 Jul 2026 13:20:06 +0000
References: <20260708152242.2268848-1-enrico.zanda@arm.com>
In-Reply-To: <20260708152242.2268848-1-enrico.zanda@arm.com>
To:  <enrico.zanda@arm.com>
Cc: jasowangio@gmail.com, virtualization@lists.linux.dev, mst@redhat.com,
 netdev@vger.kernel.org, kuba@kernel.org, kvm@vger.kernel.org,
 linux-kernel@vger.kernel.org, eperezma@redhat.com, nd@arm.com

Hello:

This patch was applied to netdev/net.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Wed, 8 Jul 2026 16:22:42 +0100 you wrote:
> From: Enrico Zanda <enrico.zanda@arm.com>
> 
> When vhost owns the virtio-net header, i.e. when
> VHOST_NET_F_VIRTIO_NET_HDR is negotiated, sock_hlen is 0,
> meaning that no header will be forwarded to the TAP device.
> 
> In the current vhost_net_build_xdp() implementation,
> when sock_hlen == 0, the gso pointer can point at the start of the
> Ethernet frame instead of a virtio-net header.
> This results in a wrong interpretation of the destination MAC address
> bytes as struct virtio_net_hdr fields.
> 
> [...]

Here is the summary with links:
  - [net] vhost-net: fix TX stall when vhost owns virtio-net header
    https://git.kernel.org/netdev/net/c/3c0d10f233f1

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


