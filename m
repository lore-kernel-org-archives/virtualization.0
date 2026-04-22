Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A50DF33A708;
	Wed, 22 Apr 2026 16:01:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776873689; cv=none; b=HOKY/XOIpMgdo6IDY8xkGtXIp+0MCfqRt4p84u2dzA4RT9M4uE+LnP2cntWcUvw4gMHd+pApYD+4PiuX9bewKZr1eXUnQRoHJOrRt4hNDZGDBM6EYI/F0T8H3Lf+D21KR3bo1F6gDHLSpm1WoRBslHgAAGihvMvja2gXaMvPjLQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776873689; c=relaxed/simple;
	bh=3WO+P61d7G4z4GPvrbp5vMidIhKRIt92ibJ1mQtr2eI=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=NsPAWbbXSLaSAiM3m5NfffMpDbW6RXyYwcpH2C+J31Zy84M8w6FFZzZhplWjS7lu76MLBVQJye/zUlVJdlHI5dIab9F/iLMjPhETjnCqFw9O/lyLgpD/6fjql2GGUbZAEZhYJCdnlLDHj2ERAnn2o27OLxfqc+/KRBKoVM3mbHA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TSjIApqO; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TSjIApqO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4F8B7C19425;
	Wed, 22 Apr 2026 16:01:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776873689;
	bh=3WO+P61d7G4z4GPvrbp5vMidIhKRIt92ibJ1mQtr2eI=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=TSjIApqOOMHmwCcbgUkjqBCbT+hBl8LHSrmxC/HjnFDhfNdgSNWyTyWlFqHAZnYiV
	 NgjtTujWFgVPknOQ3wH/ZXJ9SCQP6XD1aIASsFP6D9nkCG2dvQqu6J/r1Zkil0fdos
	 6HP3DrWpkJTeRaclvNSO5YEesfzi8xTn7bqCtqtqyugL+M0OKG4CvgFQ2Z8gm3QlOn
	 yqQlDOGmz8Wn5HXCk+x8930H9edmgF60sIPWnTpgT/XED+dbwXkPjGZkTFHCgaLx0B
	 Fy3nLhVO4OmHtfBMysc6LcGNL32M8JF5oT6Y/jZDL11YyaCaVY6GcAYfYVJAOsXt1N
	 vHbbld2pANkWQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 02D063930232;
	Wed, 22 Apr 2026 16:00:53 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v3 0/2] Bluetooth: virtio_bt: harden rx against untrusted
 backend
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <177687365180.3814222.6442611187089533400.git-patchwork-notify@kernel.org>
Date: Wed, 22 Apr 2026 16:00:51 +0000
References: <20260421170845.3469513-1-michael.bommarito@gmail.com>
In-Reply-To: <20260421170845.3469513-1-michael.bommarito@gmail.com>
To: Michael Bommarito <michael.bommarito@gmail.com>
Cc: marcel@holtmann.org, luiz.dentz@gmail.com,
 linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
 soenke.huster@eknoes.de, mst@redhat.com, virtualization@lists.linux.dev

Hello:

This series was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Tue, 21 Apr 2026 13:08:43 -0400 you wrote:
> Respin of the virtio_bt rx hardening patch, split per Luiz's
> request on the v2 thread:
> 
>   https://lore.kernel.org/linux-bluetooth/20260421151659.3326690-1-michael.bommarito@gmail.com/
> 
> v2 bundled two independent hazards in one commit and the commit
> message got convoluted trying to explain them together. This v3
> keeps each hazard in its own patch so the rationale for each is
> self-contained.
> 
> [...]

Here is the summary with links:
  - [v3,1/2] Bluetooth: virtio_bt: clamp rx length before skb_put
    https://git.kernel.org/bluetooth/bluetooth-next/c/041f524fb455
  - [v3,2/2] Bluetooth: virtio_bt: validate rx pkt_type header length
    https://git.kernel.org/bluetooth/bluetooth-next/c/d677b827eea1

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


