Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795435806;
	b=gLCip39tkvDO/+6GSIrUxz3zkzshPv6ioGttzXwPWies9bYe3BGmEgQ2vST6tSyfy56C
	 8zMo3jtLsIiw0iBrBB321umwQrI6VteXYy5+VASHkqOHwm/n9v98HcaFXUb7AOXYdO5rn
	 PsWQougUF55I9XegLEHR1bZX/PE3UwsJUhAFJROK1n/6yjRWbJihaTMawWluXjXTqdgax
	 vsFaDhBaANbmqwt6O956qBcPknS37qot4RB8DEy7Ebi0Q/l7mbyTuXPH65IBPILPyaHWK
	 PAlSV2XlMFukBuoiHQI7y2I9dTDbcpCWciYDWkXZsrF9JQuqIVaVKoXQ2nSA1UAwDpQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795435806;
	h=Received:DKIM-Signature:Received:Content-Type:MIME-Version:
	 Content-Transfer-Encoding:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc;
	bh=4VuFSntfCljx51xVr7ZgTt4+piYTB/31ijcvK7Rfmk4=;
	b=JHmwauPas6Bi28nZVvXQTJ6RJuVWwwpMchya3g/B+VK1cnmYiDDqUPeogGbqXqI+NKRB
	 rS6rWyX/V4uPJ51O2dxg5BbvGmQfCb0dvzPVYh/jeh/ecj7Soae4KvQ6WfOnLYQE9H9uX
	 JBB7X4z/MzOpuGWsVRUyMFpo65Ej80FNlpcHads0BBtEuxVMqK8LAVmvm7WwIIRtkIEfr
	 G3dwZS9Jkp639p6BRcW8kWea75sKYTNFpjrtTq51VPpmvMs9Gx4OhUqbiMolCljo1wuag
	 EsI7iqP30D5NyS6OIeLKjQ7UyfvGaX4lSQisSbRqa8vfu/W+NFwER6/Rq06GAwq6Sig==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=VLkdNyIL;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0634F606A31A;
	Mon, 23 Nov 2026 12:10:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=VLkdNyIL
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 81DE91F000CA;
	Mon, 23 Nov 2026 12:10:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795435805;
	bh=4VuFSntfCljx51xVr7ZgTt4+piYTB/31ijcvK7Rfmk4=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=VLkdNyIL0Ywxj+kTsBAUxrA/lkMe3ezbWSOkn26RnyYgMCVwFQBpeOyzjJBQ1pEq6
	 88HYhhZmYQp5d23WpcUpCrXxXbkwPXgVQsUJUR0jVE/vRtLxPNzgKliENy6dunzrbJ
	 3EPKQz7bc+iPXKxl9zwZwemIptdLivSK5FmAaaPX+bQJerpfcafoC2w6vaNYP3rmf4
	 l2qSaOMJsR86qaGwIWQex0+Lir73rohTmfd1l44bsGCiV+fY+eXUcd0F8AMJJDaTlw
	 d6rYvxpgY21UAO8oKlUl2CPT1d0JfzOkOVNnNRFgTkRbXGGAZtQXD/p9sWeV6O/lJv
	 gTrIp92CIwU0w==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 7744B392ED9E;
	Mon, 23 Nov 2026 12:10:05 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] vsock: only deliver taps to namespaces that can reach
 the device
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <179543580428.2348707.16200731284263459418.git-patchwork-notify@kernel.org>
Date: Mon, 23 Nov 2026 12:10:04 +0000
References: <20261116-vsock-tap-net-v1-1-7e24f45adad3@meta.com>
In-Reply-To: <20261116-vsock-tap-net-v1-1-7e24f45adad3@meta.com>
To: Bobby Eshleman <bobbyeshleman@meta.com>
Cc: stefanha@redhat.com, sgarzare@redhat.com, mst@redhat.com,
 jasowangio@gmail.com, eperezma@redhat.com, xuanzhuo@linux.alibaba.com,
 davem@davemloft.net, edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com,
 horms@kernel.org, kvm@vger.kernel.org, virtualization@lists.linux.dev,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Mon, 16 Nov 2026 15:46:49 -0800 you wrote:
> vsock_deliver_tap() clones every packet to every vsockmon device on the
> system. Creating one needs only CAP_NET_ADMIN in the owning user
> namespace, so an unprivileged user can capture the traffic of local mode
> namespaces.
> 
> Pass the packet's netns to vsock_deliver_tap() and only deliver to
> devices that pass vsock_net_check_mode(), the same rule socket lookups
> use. vhost passes the vhost_vsock netns, loopback the sending socket's
> netns, and virtio-vsock NULL (global mode).
> 
> [...]

Here is the summary with links:
  - [net] vsock: only deliver taps to namespaces that can reach the device
    https://git.kernel.org/netdev/net-next/c/2388bb763e32

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


