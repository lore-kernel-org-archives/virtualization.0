Received: from mx.treblig.org (mx.treblig.org [46.235.229.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 856C6161;
	Sat, 18 May 2024 00:12:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.229.95
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715991172; cv=none; b=I+b6YnJz9g1Ia+8m3VEqT3mAvIAb4io0z02Fa3KYb06GErsLvFPIXjL/zV45KMxCdidOKeu04A0sAfK/ymJKJh/Kw3IrUodksMabs2w23eVJoA1uC+aRWPQpbLZRWqeapRIjETHdofS64V4nXkDWcjgNcG7pHfA6q72uqD01+1Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715991172; c=relaxed/simple;
	bh=7TLWT6pOyAfdF6Ob72G9gaDa40LdM/QxJURewljUkNw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MWBouxjKfOrW/xNmptjYfMymcsbir4+J+NXih4g7iEA2PxLCai3rJLu2PE/lx+KLvt02eTasyLt8iR9L0RhtOkVQvNvA5DyFx7FNFV6IxLIYhuXKoJ/+bI+cPlelYzjuQ18v550KX4Xilz9Nn4yD5zXrOJ0HOK84IUaxFkzbenU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org; spf=pass smtp.mailfrom=treblig.org; dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b=WzRKjaaL; arc=none smtp.client-ip=46.235.229.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=treblig.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b="WzRKjaaL"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=treblig.org
	; s=bytemarkmx; h=Content-Type:MIME-Version:Message-ID:Subject:From:Date:From
	:Subject; bh=R+uYnKaLKm6k56X450lzj0t1LAGhxt/e3ONxm4UC8eg=; b=WzRKjaaLcz3eU45t
	GwcngA24qZafJrerAbsR9r9Gnn+eBeAUU5TPLvtVil0ARRKJzJDjIRkQQXHBPaat+EseU2L09b62y
	EhKwmwjnt8tfiD2GMOOuZF9b7qDtQPErVYDHJZa16N9S2/+/D+AU3x95LGYzdoKgWNXWMXAglRETt
	fm64TTJCeBYz4LfhuqyEaoBlfFiL/Xd9/6Jpfu9f+NhyHjQZcDIakfEQ0Lmt80D6qk+1qruMSk1Tt
	8V4u4CBboMjvpzflmWmUfRKmbU3Ai8uv2nGakIge1nVieQWDrd05OeNjFJv3IWr7jXBdToJe4qZV9
	Mxd7pzePRJes3JNn/g==;
Received: from dg by mx.treblig.org with local (Exim 4.96)
	(envelope-from <dg@treblig.org>)
	id 1s87gt-001U7v-08;
	Sat, 18 May 2024 00:12:47 +0000
Date: Sat, 18 May 2024 00:12:46 +0000
From: "Dr. David Alan Gilbert" <linux@treblig.org>
To: fei1.li@intel.com
Cc: linux-kernel@vger.kernel.org, virtualization@lists.linux.dev
Subject: Re: [PATCH] virt: acrn: Remove unusted list 'acrn_irqfd_clients'
Message-ID: <ZkfyfrDysJ2WnSZq@gallifrey>
References: <20240504174725.93495-1-linux@treblig.org>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <20240504174725.93495-1-linux@treblig.org>
X-Chocolate: 70 percent or better cocoa solids preferably
X-Operating-System: Linux/6.1.0-21-amd64 (x86_64)
X-Uptime: 00:12:36 up 9 days, 11:26,  1 user,  load average: 0.00, 0.02, 0.00
User-Agent: Mutt/2.2.12 (2023-09-09)

* linux@treblig.org (linux@treblig.org) wrote:
> From: "Dr. David Alan Gilbert" <linux@treblig.org>
> 
> It doesn't look like this was ever used.
> 
> Build tested only.
> 
> Signed-off-by: Dr. David Alan Gilbert <linux@treblig.org>

Ping

> ---
>  drivers/virt/acrn/irqfd.c | 2 --
>  1 file changed, 2 deletions(-)
> 
> diff --git a/drivers/virt/acrn/irqfd.c b/drivers/virt/acrn/irqfd.c
> index d4ad211dce7a3..346cf0be4aac7 100644
> --- a/drivers/virt/acrn/irqfd.c
> +++ b/drivers/virt/acrn/irqfd.c
> @@ -16,8 +16,6 @@
>  
>  #include "acrn_drv.h"
>  
> -static LIST_HEAD(acrn_irqfd_clients);
> -
>  /**
>   * struct hsm_irqfd - Properties of HSM irqfd
>   * @vm:		Associated VM pointer
> -- 
> 2.45.0
> 
-- 
 -----Open up your eyes, open up your mind, open up your code -------   
/ Dr. David Alan Gilbert    |       Running GNU/Linux       | Happy  \ 
\        dave @ treblig.org |                               | In Hex /
 \ _________________________|_____ http://www.treblig.org   |_______/
