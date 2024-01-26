Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65EE9522D
	for <virtualization@lists.linux-foundation.org>; Fri, 26 Jan 2024 00:50:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.137
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706230229; cv=none; b=KCGM2JoqtJW3e412VPOOWHqwGy/cZ+LcfISn37XvfSL+kueqSQlm/8f5SW4sqqVnf5CAtk0ZJfBuDIRzXZM9QjxPTbiPRXflm7bbVciIxPZLVrx0XzFVEUvLI21OZhXybILCv5RoubxJVb3Ll4R4HNUE3ytMnDch93NxrU/25tY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706230229; c=relaxed/simple;
	bh=2f0+fGYPXiafkD5YRHJqtQggSgsQRRMUS/0Y3PHqaJE=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=lj5ngjJRnC4eufIiorHoGwWG+vk4RzFAp2qYRVqWK2DcPmBmjr21ETcv6+Jy7QWPXd/JtC/IyngrA2OoF0t3oVtoh4VpJLZxKvKsODrDZ1c/xmiK0/N+9iE9u6UQZqTZtABnbixOo1GbrHaNsb4QJ6FwkEK9xbwZoS+xt6wxo4c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZLbxS+Qq; arc=none smtp.client-ip=140.211.166.137
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZLbxS+Qq"
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id DD2FB483A9
	for <virtualization@lists.linux-foundation.org>; Fri, 26 Jan 2024 00:50:26 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org DD2FB483A9
Authentication-Results: smtp4.osuosl.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=ZLbxS+Qq
X-Virus-Scanned: amavisd-new at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -4.401
X-Spam-Level:
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id XHVm6oC2WeOM
	for <virtualization@lists.linux-foundation.org>;
	Fri, 26 Jan 2024 00:50:26 +0000 (UTC)
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 163CB47F82
	for <virtualization@lists.linux-foundation.org>; Fri, 26 Jan 2024 00:50:25 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 163CB47F82
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id E900462392;
	Fri, 26 Jan 2024 00:50:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 94EC6C433C7;
	Fri, 26 Jan 2024 00:50:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706230224;
	bh=2f0+fGYPXiafkD5YRHJqtQggSgsQRRMUS/0Y3PHqaJE=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=ZLbxS+QqAwJ3MZjsrlR6b7jgfJi5Sb2chYquq+uDsiJrC/+aJY+UIx9N5/Sqv2DVP
	 WpvSAOBj+bPKrHE4rVNTJYkt3ExZw2hoSOUzpOSqjhpcBEE3dZasburGtExxXJJzOw
	 tMgwBbQ1xkYKkwFvsn7oAD0vuryqgXFkUJw4UMAxt3legR2ELv9P5uh8C+pMBG9//K
	 ZuDVZFSYFhG1s96FAowUsExKsyyZD5qdVqQ/fY+Cbe4Vs7X3qdSC/jyTteuut4rY8i
	 gi4lBDNPJBH0nf0UKAa3YXcKPZIl8Z1iX5kDsTBWaEfiO4HlzKS+U3ke5S7NVIopx1
	 OW59UfvjkXB/w==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 70EB6DFF767;
	Fri, 26 Jan 2024 00:50:24 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v1] vsock/test: print type for SOCK_SEQPACKET
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170623022445.19620.11117902716691954284.git-patchwork-notify@kernel.org>
Date: Fri, 26 Jan 2024 00:50:24 +0000
References: <20240124193255.3417803-1-avkrasnov@salutedevices.com>
In-Reply-To: <20240124193255.3417803-1-avkrasnov@salutedevices.com>
To: Arseniy Krasnov <avkrasnov@salutedevices.com>
Cc: stefanha@redhat.com, sgarzare@redhat.com, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, mst@redhat.com,
 jasowang@redhat.com, bobby.eshleman@bytedance.com, kvm@vger.kernel.org,
 virtualization@lists.linux-foundation.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, kernel@sberdevices.ru, oxffffaa@gmail.com

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 24 Jan 2024 22:32:55 +0300 you wrote:
> SOCK_SEQPACKET is supported for virtio transport, so do not interpret
> such type of socket as unknown.
> 
> Signed-off-by: Arseniy Krasnov <avkrasnov@salutedevices.com>
> ---
>  tools/testing/vsock/vsock_diag_test.c | 2 ++
>  1 file changed, 2 insertions(+)

Here is the summary with links:
  - [net-next,v1] vsock/test: print type for SOCK_SEQPACKET
    https://git.kernel.org/netdev/net-next/c/767ec326f985

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


