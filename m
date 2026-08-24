Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 768BB49364D;
	Mon, 24 Aug 2026 18:20:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787595652; cv=none; b=OoEJZrRfJl+d/BCauK/9xVoon4InIvLl//wFOTVDTZY4lBoab0Tv7PQEx3ECKCnEMRIl5jxS+3UUV+aLr+lgl1d4QMsV+giwZs/XlzRqMQjg/Lml6P8Bn4Ejw9LgQKztqxB205Y1p/zhSnzSpyjjfDL8Vd/5UNDpiGxQsVXbUDY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787595652; c=relaxed/simple;
	bh=7b+fhXmUQx8z+moXUjhYiRNVjn/xZQKUEu/O9kRZh1A=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mluPwU4wDzkvzrv/q/2ItQGJjdVx59eQy2MsorwKD4JaWFMd6zTORJNG9fvO59Y6X3OzoS5ddQ9t81NnAt7jcN6DgpgPQEuZwKrERpyhqMjRhI2CSjLJvAI02JI/wnKSTmDJDKybK+q7thafvTb1sltiWLQeS/xgH/WIJC7bitc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=elRgIkTt; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="elRgIkTt"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E60AE1F000E9;
	Mon, 24 Aug 2026 18:20:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787595651;
	bh=3isUyXXQD/Jf2j+fZpm7iICb0zMnOAe7v7MVoPtb7XA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=elRgIkTt8X7Os1VBISLOez/tsPfckXHG8ax8GTfFuoWtkOyWd0F2b/posZgzhjxi0
	 kS0ffJkF31vCQsxW4NeY5eocN7JLbQ996ODYX12PofJTc+JZDk/rWujNFTOX16HwVB
	 TSjhhYk2KKXvyDJ5jy2tb9NSPuiSjDmykZDi+N2OwR4aNGnP1QMAzPqXrS22IToUUM
	 8jzcT81sGdNjYMhifAvJ5XlpInL/Gg191AbwD3PsdvlqDyQHjwej6mm8yJGOwvczQi
	 cdM0/7BqAGWIpwLy4yOueOtrYYd0hCKRT/Xx/O/u90aV900P1jELijc+GY5Xu0crm7
	 Rm0vGcybjybjQ==
Date: Mon, 24 Aug 2026 11:20:50 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Longjun Tang <lange_tang@163.com>
Cc: mst@redhat.com, jasowangio@gmail.com, xuanzhuo@linux.alibaba.com,
 virtualization@lists.linux.dev, netdev@vger.kernel.org,
 tanglongjun@kylinos.cn
Subject: Re: [PATCH v2] virtio_net: add rx-alloc-fail counter
Message-ID: <20260824112050.02623327@kernel.org>
In-Reply-To: <20260820060929.69576-1-lange_tang@163.com>
References: <20260820060929.69576-1-lange_tang@163.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 20 Aug 2026 14:09:29 +0800 Longjun Tang wrote:
> Count the cases where the driver fails to allocate a buffer or an skb,
> such as when try_fill_recv() fails with ENOMEM, and report them via the
> rx-alloc-fail qstat.
> 
> Plumb alloc-fail into virtnet_get_base_stats() to keep this new stat
> reported consistently at both queue and device scope, matching how
> packets, bytes, stop and wake are handled.

The stats handling in virtio_net is super convoluted but AFAICT
your patch is good. Unfortunately, net-next is closed right now
(merge window) to you will have to repost next week.

Maybe you can try to cover more allocation failures per:
https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260820060929.69576-1-lange_tang@163.com
Or add a sentence or two to the commit message that we do not intend
to cover 100% of cases where packet is dropped.
