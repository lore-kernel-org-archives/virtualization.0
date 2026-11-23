Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795434606;
	b=RoMRP/scvU1ycCFeuu+U+za+AWEHLFA68NE1809Pg1LdSDlEV6y000BRC39eds+792g5
	 X7hJH9XSpIAHgvC2JNdZ+1qGuuHtNSkvp71hTIFpdeLkqMy5m4vBGcQqYu/mdgtb3ZPHs
	 kp+gUpCxYJeizXe45EkyF8TDYuCn9GkIviP1RgFjviW6JuDjTBr2OILeOBHCFpYNMCk80
	 FUxQr8TtzRxzSQvTR6s+M6VpZVAOFYXRDnBlsBFEchX3zABEMlaJ7jjTgfIeXmVVwuBjV
	 S7+5eP6UZQKB8NsrUaN9HfdlHU0PCc2EbTl9U2S3t9m9466MlKalBHP07elL1vWX3IA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795434606;
	h=Received:DKIM-Signature:Received:Content-Type:MIME-Version:
	 Content-Transfer-Encoding:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc;
	bh=ZuJcgSdqpqCKxNvlfebWKYAlIipyM0Z/cnY85S62i90=;
	b=Ty877PkEoXZzRyTYEA6G+1SggWrj7howRxMWg/cxlvKdIIN9KwdwBbaf36T5G5Nbbvy1
	 PM/j2nBatAWWP0MooQldxEfo7dNq9tC7HnsUtYwVmaq7czsh/kNDkh8bJQ6dqppbpSD0s
	 i5DsrMNJ8wNe+QLnaE0QJUgBG9Ql5PY/zoPN275kaNrQZKfU3LXgezz5YJPHgwVcz0qk4
	 yBMdp9Ux30UWA+SPNfmwOi8uzvQAiCvtB6BLwk/s4MJUWspy7AMd/uXYwXtiriKIDHwl5
	 cGjs5ahyjf+pk8fl8zg+ubvltljuyx7ffrGp4cw5UEEvdASF6GPtR2onI0gSYr5qfjw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=RwawEDJe;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09103606A31A;
	Mon, 23 Nov 2026 11:50:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=RwawEDJe
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BCB521F000C4;
	Mon, 23 Nov 2026 11:50:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795434605;
	bh=ZuJcgSdqpqCKxNvlfebWKYAlIipyM0Z/cnY85S62i90=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=RwawEDJeLLTVq0aLOV92cxBvfS9B9ZdMV+04TVYTZXFileauuOJ14Am9MXJvzjVj2
	 Q4+wyPVkezsnePy8WF579jxQiY//X7b7L39OmWKuuC7nWo/9QeBGm4LvXEdpKPkKt5
	 HXuR/D6hzw1vWXJF2SJUSO8KEiXNRbGr+0uT+7NwdCrLuVs2FtLfkg8dN9ruPK7Nvf
	 E7pA1sQbjOFVRuoIRXOBr7qYW7JWIAhH8BGCYekpymmgYhUw/E2MNpn/uNBAD3EIxy
	 ngOqdXE+42tPtKnF4sDD4H0EjdEJtfPZOD4ESMNCo295o/8txDsQryjfYAjMW9gelj
	 3efTLb8A2Nxgw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id B45BE392ED9E;
	Mon, 23 Nov 2026 11:50:05 +0000 (UTC)
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
Subject: Re: [PATCH net] tun: complete the zerocopy buffer of packets consumed
 by
 XDP
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <179543460453.2338965.1975770060566006606.git-patchwork-notify@kernel.org>
Date: Mon, 23 Nov 2026 11:50:04 +0000
References: <20261113232843.2338734-1-antonio@mandelbit.com>
In-Reply-To: <20261113232843.2338734-1-antonio@mandelbit.com>
To: Antonio Quartulli <antonio@mandelbit.com>
Cc: willemdebruijn.kernel@gmail.com, jasowangio@gmail.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@kernel.org,
 kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, mst@redhat.com,
 eperezma@redhat.com, ast@kernel.org, daniel@iogearbox.net, hawk@kernel.org,
 john.fastabend@gmail.com, sdf@fomichev.me, netdev@vger.kernel.org,
 virtualization@lists.linux.dev, bpf@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Sat, 14 Nov 2026 00:28:41 +0100 you wrote:
> When vhost-net passes a zerocopy buffer that tun_get_user() does not use,
> because the packet spans too many pages, the packet is copied and the
> buffer completed. If the copy goes through build_skb() and native XDP
> consumes the packet (DROP, TX or REDIRECT), tun_get_user() returns
> without completing it: vhost-net never gets the descriptor back, and
> closing the vhost-net device then blocks forever.
> 
> [...]

Here is the summary with links:
  - [net] tun: complete the zerocopy buffer of packets consumed by XDP
    https://git.kernel.org/netdev/net/c/3896ae4adf5f

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


