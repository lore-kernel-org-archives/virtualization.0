Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A70A5301719;
	Fri, 12 Jun 2026 23:50:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781308213; cv=none; b=I9vxGarW0i7NcWj1Cc9D13k/gJ6m8gT9z8KGsMJpO2985qTv1LjTedNkZtolocJAua3NmbEnua0BFBf3Sloxwwa16cLuPFNMwDIKHEdxU41mlRYxY2B/k+w6GzV82P+57/J1ein0T2p0EGeSpZ3//ZNZPRuoTULfl2LpvIXK16I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781308213; c=relaxed/simple;
	bh=cT2bba7hA669/5rneFxXHLEA7soszRhZlQftku+F7Kk=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=dBEoO4TYJTI41YcczKkstuJ1WJucjUIeusezEMfJGe05qebggP0IAzdOyB4ml2vyYk3Mp6vG7fP5X7YnbHWjOaseDqxAS4Ul8MNxq83kL0NkdLyyL5VwS+1EkDkRhK1LQK9W8zAj1UodNdDTtOfdT0vikicy6r+d7MBi4dd25gA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cI+MbVzs; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cI+MbVzs"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3DB661F000E9;
	Fri, 12 Jun 2026 23:50:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781308212;
	bh=GeQiU5lJzSA7sxR6Y50Gt+TLkWrbSjN8RcoHFYutCa8=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=cI+MbVzsBaNNXfByyg2QRsQnbujnzz9NMfhls1P/65NSOAb0fPadiZ4gXfrUp76Qr
	 ts23HZILuU3tUSiumZoQR9RKUIttjKp4mYnwYJapsd1a2OMWXITyIXvvnSjbt0O0UU
	 fvR0uOiwwFG2qqhizFRjQQTHJDbtBtn6mcRH+QzCdRlVjKoEKvSCJFYoce+ds0DM9j
	 hUV2Qjt+yAGOI20w8vLmyLl59agjhWwaOAXfycUwoi06hVkkddGaDVRa7XOLmpKyjt
	 WuUEuaYPRRMdAQMkbFhlFIp0wXqYlJmq9FIeouCbTcqOnvrHDsjaobPkf4ocTUz4QH
	 XAQ6ZibkT9axg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 1980739E9602;
	Fri, 12 Jun 2026 23:50:10 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2 net] virtio_net: do not allow tunnel csum offload for
 non
 GSO packets
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178130820864.1294761.17379581600716494206.git-patchwork-notify@kernel.org>
Date: Fri, 12 Jun 2026 23:50:08 +0000
References: 
 <6c3b6c47fb05c100f384630dc48f3975cf37b67a.1781195144.git.pabeni@redhat.com>
In-Reply-To: 
 <6c3b6c47fb05c100f384630dc48f3975cf37b67a.1781195144.git.pabeni@redhat.com>
To: Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, mst@redhat.com, jasowang@redhat.com,
 xuanzhuo@linux.alibaba.com, eperezma@redhat.com, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 virtualization@lists.linux.dev, g.goller@proxmox.com, f.ebner@proxmox.com

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 11 Jun 2026 18:36:48 +0200 you wrote:
> Fiona reports broken connectivity for virtio net setup using UDP tunnel
> inside the guest and NIC with not UDP tunnel TSO support in the host.
> 
> Currently the virtio_net driver exposes csum offload for UDP-tunneled,
> TCP non GSO packets. Such packet reach the host as CSUM_PARTIAL ones
> with the 'encapsulation' flag cleared, as the virtio specification do
> not support this specific kind of offload.
> 
> [...]

Here is the summary with links:
  - [v2,net] virtio_net: do not allow tunnel csum offload for non GSO packets
    https://git.kernel.org/netdev/net/c/86c51f0f2313

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


