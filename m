Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90D8D2D877B;
	Sun, 12 Apr 2026 21:40:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776030032; cv=none; b=jFxOraFszeN9xTJr3dMVWAGa56oEeC3tWtkuBWCOudtWZHnIBCXcEA3M/CklQa9ktjMYBFDGhKOnctHjNRu9D+x+qn2v4qJJRGmiAWEDAKzZzQU4E75IkAmwG1QGXZJmWzF3pISFBjcaHA4D4ryyY+8Utq9UTPVos48r/Cj/RRM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776030032; c=relaxed/simple;
	bh=dk8SMi0d6I2ZxoqFk/c6rqZX3J92eEr0bmC9wAtgvfY=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=kNNKyphSPHgSAN+nfFbUW+0DPp7SEPuqZMpL10uIWrcsAxZwMrMzPzefN6pDQqJeZUSRWo2b7lbcdb49lqi3Vr5eyGCAID2c9mXJfrTrfOIYA0SCJW0BNLA/rWjuqePafKcaAvW+4wHGibT8wCeqVncArLR+Pca9xLr/rFxUuoQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fFbxdNm7; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fFbxdNm7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 36F98C19424;
	Sun, 12 Apr 2026 21:40:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776030032;
	bh=dk8SMi0d6I2ZxoqFk/c6rqZX3J92eEr0bmC9wAtgvfY=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=fFbxdNm79OSni5Hbs+a3O+Ws6BT/Kt9EXm8iszNTrqZvGXE3E9lmkOvm5IlYlCfsb
	 O/lDufDgYg1Y6Nz+r0t6kCOxHFlEGCaJekX1B+IQFsnq3NJ43d96C0VohL2Hhx2UNy
	 wQaDSjXV5DvY7hnxFtIIozI3730vA9m77agRXLNqqxVzOGcqbTggH2i2XIAZCzJ46c
	 V4csqQmzDkryzcDAps8nHTo2679lgaHfvOXVuBksaBoQjD+a3yNc2z5VP/Ym/jIiZt
	 4FDVwMyrO2Gkjwgf94PI9ia7kWDSB5jPbgjof6YyKLM7wn4xTfTdD7FY7Tbp+ssVPA
	 izWvbhSXa8vBA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id B9E413809A8C;
	Sun, 12 Apr 2026 21:40:05 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v3 net] vsock: fix buffer size clamping order
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177603000455.3830830.9281764062768430447.git-patchwork-notify@kernel.org>
Date: Sun, 12 Apr 2026 21:40:04 +0000
References: <180118C5-8BCF-4A63-A305-4EE53A34AB9C@doyensec.com>
In-Reply-To: <180118C5-8BCF-4A63-A305-4EE53A34AB9C@doyensec.com>
To: Norbert Szetei <norbert@doyensec.com>
Cc: sgarzare@redhat.com, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 virtualization@lists.linux.dev, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 9 Apr 2026 18:34:12 +0200 you wrote:
> In vsock_update_buffer_size(), the buffer size was being clamped to the
> maximum first, and then to the minimum. If a user sets a minimum buffer
> size larger than the maximum, the minimum check overrides the maximum
> check, inverting the constraint.
> 
> This breaks the intended socket memory boundaries by allowing the
> vsk->buffer_size to grow beyond the configured vsk->buffer_max_size.
> 
> [...]

Here is the summary with links:
  - [v3,net] vsock: fix buffer size clamping order
    https://git.kernel.org/netdev/net/c/d114bfdc9b76

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


