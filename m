Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66AF4883F;
	Tue,  6 Oct 2026 01:53:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791251617; cv=none; b=g44J5MnMTvPcfgwr5tY2jb7+kD3XaLxiLeFD3YH0gNEPH1R+NynMAtSfUuChGe8DsXC7pKrZd3pWuJFU8stV1jvwEk+9sFYCiDx9DYWFygnJwC7mQCjbalrP2Qet0K+RYfZzEfddlQIkvrt0XncOa8Nq4JMs8GHbk8z2USqGViI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791251617; c=relaxed/simple;
	bh=AzQyIcHNd8fG3k5agIF9efZmuC+BqGp5ie+dcPpaPz4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mwXrnjCjEw9S6UGfVKO4Ye8Qa4uR5/o009UnLMzEvo6ES2oC0IN4yCEeVrxPkjMWg22i/uwXEvau0q7je3HYwEBX79eCd4cFWSI8XUCWB7dIPEFY7Ow92Oe9V2eVamwYEy9c8IsVj0qe85ZhJfHKzUpBh4pkBTgWud0ehfVyjjc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gSqn2bvf; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gSqn2bvf"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 985C51F000FF;
	Tue,  6 Oct 2026 01:53:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791251616;
	bh=xMgPxSGMoyA2CWveA4xxkgTpI3T40jtyd4gazW6Ysws=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=gSqn2bvfb4xYBAUmuqSCxfUX4xGQ49uYiO58AlcgPDKzVd9a+59OkhreL7Pu7aXAt
	 VSYFYg//hMaZvtKWPKAm6ygaiZVXEciJLI2d2E5VsVDhkLTMFnkyjRSqVyckWi9RCk
	 MHOpPVTJwwMdNI8XGVDerNM+relaRyaQ55cgCX2mipPN0DdKIxsoYV8cOI+hDAwy+e
	 k+1vX37fTIwDwzj43bDOcsqNAt9I1RnX2Y8pCbl9rSbGkvz7R5aSV8sui/JLaxaDiV
	 l8LANuFGiHJv7ZRCwlJVqhhqylrqp6mir/81tkUse+9wkb7gB8WoA58rZBNQ5TGVp6
	 FxCxSTCzXxV9g==
Date: Mon, 5 Oct 2026 18:53:35 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Jianlin Shi <shijianlin11@foxmail.com>
Cc: netdev@vger.kernel.org, virtualization@lists.linux.dev, mst@redhat.com,
 jasowangio@gmail.com, eperezma@redhat.com, xuanzhuo@linux.alibaba.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 pabeni@redhat.com, talgi@nvidia.com, hengqi@linux.alibaba.com,
 horms@kernel.org
Subject: Re: [PATCH 1/2] dim: clear irq_moder on init failure
Message-ID: <20261005185335.2f8e8b42@kernel.org>
In-Reply-To: <8d6a637142c411f83771fda5b57bb4451651488b.1790751008.git.shijianlin11@foxmail.com>
References: <cover.1790751008.git.shijianlin11@foxmail.com>
	<8d6a637142c411f83771fda5b57bb4451651488b.1790751008.git.shijianlin11@foxmail.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 30 Sep 2026 16:19:51 +0800 Jianlin Shi wrote:
> net_dim_init_irq_moder() publishes the allocated object in
> dev->irq_moder before copying the moderation profiles.  If kmemdup()
> fails, the object is freed but the pointer is left dangling.
> net_dim_free_irq_moder() treats a non-NULL irq_moder as live, so a
> caller unwinding the failure path would use-after-free.
> 
> NULL the pointer after freeing it.  On error the device is left as if
> initialization never happened.


Please add an example sequence of calls in the current source tree
where this is a problem. Dangling pointers are not an issue unless
something tries to deref them.
-- 
pw-bot: cr
