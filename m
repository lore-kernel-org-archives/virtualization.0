Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADCB73932D9;
	Thu, 23 Apr 2026 19:11:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776971460; cv=none; b=f2ZE5Qt9eB2zKB3Nlmb3ZZaR2YipJsciYOn4m7RbndNWX9tkwt3pWGm7+laOQZle8F4hxD1YEKKMVu7S6KUz9O017pCpC+A+PRRtVDpRf62Z4/YyOdA0QU9ZTuO9KdQIWKt32V4JmwEAsbp9KSzvmuS9/IqAQwobitaIgp5FJWw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776971460; c=relaxed/simple;
	bh=6fXFVzVLbO+le2xnbpDfOwGsLrZsaVz1BbEPkHM1XGk=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=tE1tyITTDyvKUiPqnDlPx7KyWTE+/WocVGsqz0U0HOZVYUJ9GqUk0OOxtu+RsZog8uyJDDmHQ9Ylsac00GV/PShO2V7zo54K2WXYH6WHWxxshHYGkkO/owwFxr33MBrsR6fI8ncgQDMS9gpRMg8aZFsKRFHIChP+QOxNhnZihOk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QXmtLoQH; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QXmtLoQH"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 686B7C2BCAF;
	Thu, 23 Apr 2026 19:11:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776971460;
	bh=6fXFVzVLbO+le2xnbpDfOwGsLrZsaVz1BbEPkHM1XGk=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=QXmtLoQHowaSzCICVVemCDvrfShx0bSVGmxwoMMJDYc/jEN1edhGRlRAQVEkBjrRv
	 wgk1S6ABCsApVxgnoV8OQlToXsPetlS6j2EMb6lYdR+4irMJbC1hCSKKBnIZX3yzgC
	 hod/fjZgqThPvDo9BtgxFF2PCURSxSpDA9M808s73808TKVfWc+8nqlnu14ekqOlPi
	 V32iIHpAv3xjSfq3d2RZH5uH/eQXB3kmiNy8Q+vzm5dwD45pE6YvU71SVzuT8IBBZR
	 ZhxEgjKwFAJtDbNN/65EMfIeBHm3T+HZZg05y17CKMNHpPw20xX1AsfAYJr7bYS9x3
	 UPbfb5mtKHw3w==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 0393D3809A90;
	Thu, 23 Apr 2026 19:10:23 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v1] vhost_net: fix sleeping with preempt-disabled in
 vhost_net_busy_poll()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177697142179.724716.10034716707752793588.git-patchwork-notify@kernel.org>
Date: Thu, 23 Apr 2026 19:10:21 +0000
References: <20260422023026.81960-1-kohei@enjuk.jp>
In-Reply-To: <20260422023026.81960-1-kohei@enjuk.jp>
To: Kohei Enju <kohei@enjuk.jp>
Cc: mst@redhat.com, jasowang@redhat.com, eperezma@redhat.com,
 kvm@vger.kernel.org, virtualization@lists.linux.dev, netdev@vger.kernel.org,
 syzbot+6985cb8e543ea90ba8ee@syzkaller.appspotmail.com

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 22 Apr 2026 02:30:24 +0000 you wrote:
> syzbot reported "sleeping function called from invalid context" in
> vhost_net_busy_poll().
> 
> Commit 030881372460 ("vhost_net: basic polling support") introduced a
> busy-poll loop and preempt_{disable,enable}() around it, where each
> iteration calls a sleepable function inside the loop.
> 
> [...]

Here is the summary with links:
  - [net,v1] vhost_net: fix sleeping with preempt-disabled in vhost_net_busy_poll()
    https://git.kernel.org/netdev/net/c/e08a9fac5cf8

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


