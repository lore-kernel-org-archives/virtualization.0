Received: from mx.treblig.org (mx.treblig.org [46.235.229.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60AA6144D3E;
	Thu, 18 Jul 2024 18:07:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.229.95
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721326063; cv=none; b=Ve054BZibmrNXV2aZsWoOuE4HHfh3Mz69jCz16E9XA6k7pLtTdZNw5/ouCJQejRB4SsYpHOeK99WkR9sweQqDnyinGvL9uinK9/DvhMW4a1EcRBCP1FsnvQAZzti6DqjxFqZ4TI+8YqkKVQGYE12bugiZ+eMNgpmXXa0Wo6vMyQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721326063; c=relaxed/simple;
	bh=MuGwjsrqOuOL8dcjqF/50eGuFl9GeK4wCccvyIbYNlY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eep/XQ57tzxXUPU0bvcomWpcjlj8h+YTUCkENwqIATWdagrtV6rEFt7ku6RZTSgkPRQFZXSnzTQIl7hXYVJJyrtEIvK9uAatGfrJZrT5ut+zHPxeNb2DPAxgsaKuqdS+Wbhb/Av8gLILOSoM3wZEgUUebkoW150N3UnQO1tPL+U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org; spf=pass smtp.mailfrom=treblig.org; dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b=cVlclxxK; arc=none smtp.client-ip=46.235.229.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=treblig.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b="cVlclxxK"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=treblig.org
	; s=bytemarkmx; h=Content-Type:MIME-Version:Message-ID:Subject:From:Date:From
	:Subject; bh=pNPzX9/f1fflPWhQ0Y4MLIXv5qeY3FjYkS91vi3UiC4=; b=cVlclxxKg//V4BXD
	3EPziRfpL/bM4tIk/uqlVexdaCpPl2dh7VKPKgN0WaZJMyrK7OUBM4wOfmMiinUoXplm8k9R0Lqbu
	CZ4ZEdDmJezjYPdjOaV/5aTngvUvK5lYCZpuec+zfl0GnDiXTjjJ3fhj3cLuXzBmaTRVM+KUyLID9
	ZMOdSnDVDlpug3I8tl1YCbHYet88JE/eJW80uh1dCmOGRJMWYcxFdIa0JoCcrHKWFjubGnWKgohTR
	JDwec4YYl0Ss/P/qsg/lKK7k1XDXOObYWxkQFYO3y6UaPIj0V3+5dUUmgtqXjhZmm/oqE4sTBGzNe
	T1iRYwuKL/MqCXeXug==;
Received: from dg by mx.treblig.org with local (Exim 4.96)
	(envelope-from <dg@treblig.org>)
	id 1sUVAZ-00CLO7-08;
	Thu, 18 Jul 2024 17:43:55 +0000
Date: Thu, 18 Jul 2024 17:43:54 +0000
From: "Dr. David Alan Gilbert" <linux@treblig.org>
To: Fei Li <fei1.li@intel.com>
Cc: linux-kernel@vger.kernel.org, virtualization@lists.linux.dev
Subject: Re: [PATCH] virt: acrn: Remove unusted list 'acrn_irqfd_clients'
Message-ID: <ZplUWugKFu37t3PF@gallifrey>
References: <20240504174725.93495-1-linux@treblig.org>
 <ZkfyfrDysJ2WnSZq@gallifrey>
 <Zkq183IzBA6cV9FE@louislifei-OptiPlex-7090>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <Zkq183IzBA6cV9FE@louislifei-OptiPlex-7090>
X-Chocolate: 70 percent or better cocoa solids preferably
X-Operating-System: Linux/6.1.0-21-amd64 (x86_64)
X-Uptime: 17:43:27 up 71 days,  4:57,  1 user,  load average: 0.00, 0.00, 0.00
User-Agent: Mutt/2.2.12 (2023-09-09)

* Fei Li (fei1.li@intel.com) wrote:
> On 2024-05-18 at 00:12:46 +0000, Dr. David Alan Gilbert wrote:
> > * linux@treblig.org (linux@treblig.org) wrote:
> > > From: "Dr. David Alan Gilbert" <linux@treblig.org>
> > > 
> > > It doesn't look like this was ever used.
> > > 
> > > Build tested only.
> > > 
> > > Signed-off-by: Dr. David Alan Gilbert <linux@treblig.org>
> > 
> > Ping
> 
> Acked-by: Fei Li <fei1.li@intel.com>

Hi Fei,
  Do you know which way this is likely to get picked up?
(I don't see it in -next)

 Thanks,

Dave

> Thanks.
> 
> > 
> > > ---
> > >  drivers/virt/acrn/irqfd.c | 2 --
> > >  1 file changed, 2 deletions(-)
> > > 
> > > diff --git a/drivers/virt/acrn/irqfd.c b/drivers/virt/acrn/irqfd.c
> > > index d4ad211dce7a3..346cf0be4aac7 100644
> > > --- a/drivers/virt/acrn/irqfd.c
> > > +++ b/drivers/virt/acrn/irqfd.c
> > > @@ -16,8 +16,6 @@
> > >  
> > >  #include "acrn_drv.h"
> > >  
> > > -static LIST_HEAD(acrn_irqfd_clients);
> > > -
> > >  /**
> > >   * struct hsm_irqfd - Properties of HSM irqfd
> > >   * @vm:		Associated VM pointer
> > > -- 
> > > 2.45.0
> > > 
> > -- 
> >  -----Open up your eyes, open up your mind, open up your code -------   
> > / Dr. David Alan Gilbert    |       Running GNU/Linux       | Happy  \ 
> > \        dave @ treblig.org |                               | In Hex /
> >  \ _________________________|_____ http://www.treblig.org   |_______/
> > 
> 
-- 
 -----Open up your eyes, open up your mind, open up your code -------   
/ Dr. David Alan Gilbert    |       Running GNU/Linux       | Happy  \ 
\        dave @ treblig.org |                               | In Hex /
 \ _________________________|_____ http://www.treblig.org   |_______/
