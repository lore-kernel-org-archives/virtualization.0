Received: from mx.treblig.org (mx.treblig.org [46.235.229.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 133CB13E028;
	Fri, 19 Jul 2024 16:01:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.229.95
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721404907; cv=none; b=RA/pouPl40XNTNj+U7PzqNDn48h8G8tZ7/jB7UqRDa45X5oYCriCgeFsL03j0hJN66EG6xDKF70S5Im96OQF0D0yoOyLW/fr3dHhue4hf1pzzk0wYvawI8FYTKsUeNUjhV9P2EE52Txpa1hZoEjaxNFoViTFDt4a3iCUdMwsED0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721404907; c=relaxed/simple;
	bh=psli4UncC3WvmggqIhvRFMI0Cs3vf8hV1EnlkaizWyA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VOBuJ50/sPXGR4yJdA6FPzpQzXdMzL01bjHnEZRFtJ3jKKkyUevUdEmedwy3aA3bs4CKJJXjodLzERRMVvCwD0SzsdHZdCG/NVr3w1WB6Nkh/OX6CtF8T79ITFT73HbQcyouCSblbGf5CoTnq2APF+R1e+8tD/3ZHrYoMttrd7k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org; spf=pass smtp.mailfrom=treblig.org; dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b=EtYYieva; arc=none smtp.client-ip=46.235.229.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=treblig.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b="EtYYieva"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=treblig.org
	; s=bytemarkmx; h=Content-Type:MIME-Version:Message-ID:Subject:From:Date:From
	:Subject; bh=uI/ysXcd1nUGjt6va7huqR0znM/Rt3MKLTngWzkAIF8=; b=EtYYievaX9axGU33
	OVWZ9KTVX3mx7AKY5AmhS9gK1V0naGVKpg31+waWH/oGm0DPtyPDHYDXbXLPmnGCVOh0pGEaP8Vxw
	pUZrIEHARMl3Ki1r9e9D6kIV2VJ4RwbiAjSFTlzUMsNd/b6WoT6rverNx4/9A0y7imaweIo1KBhCi
	Zu9cHTX1MDpMfS/sPuT7LKpS4HF8cX7GvnaYQAIddgiGjbjQPJm841NZBp+Ng/3e9uMzBHcLLV129
	WBGpF4Z1Zb22PyfjZmpVHKPmThzR6kuGe2iLpmorxEwXGEQQSjsFZ0Uf82liWe5wzVJlgMvg4hK5B
	u3rqfHe6vfJMXzlXHA==;
Received: from dg by mx.treblig.org with local (Exim 4.96)
	(envelope-from <dg@treblig.org>)
	id 1sUq37-00CSxQ-37;
	Fri, 19 Jul 2024 16:01:37 +0000
Date: Fri, 19 Jul 2024 16:01:37 +0000
From: "Dr. David Alan Gilbert" <linux@treblig.org>
To: "Li, Fei1" <fei1.li@intel.com>, tglx@linutronix.de
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"virtualization@lists.linux.dev" <virtualization@lists.linux.dev>
Subject: Re: [PATCH] virt: acrn: Remove unusted list 'acrn_irqfd_clients'
Message-ID: <ZpqN4ehTSm4f1c46@gallifrey>
References: <20240504174725.93495-1-linux@treblig.org>
 <ZkfyfrDysJ2WnSZq@gallifrey>
 <Zkq183IzBA6cV9FE@louislifei-OptiPlex-7090>
 <ZplUWugKFu37t3PF@gallifrey>
 <SJ1PR11MB615385A66E65F156BE177D20BFAD2@SJ1PR11MB6153.namprd11.prod.outlook.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <SJ1PR11MB615385A66E65F156BE177D20BFAD2@SJ1PR11MB6153.namprd11.prod.outlook.com>
X-Chocolate: 70 percent or better cocoa solids preferably
X-Operating-System: Linux/6.1.0-21-amd64 (x86_64)
X-Uptime: 16:00:52 up 72 days,  3:14,  1 user,  load average: 0.00, 0.00, 0.00
User-Agent: Mutt/2.2.12 (2023-09-09)

* Li, Fei1 (fei1.li@intel.com) wrote:
> > -----Original Message-----
> > From: Dr. David Alan Gilbert <linux@treblig.org>
> > Sent: Friday, July 19, 2024 1:44 AM
> > To: Li, Fei1 <fei1.li@intel.com>
> > Cc: linux-kernel@vger.kernel.org; virtualization@lists.linux.dev
> > Subject: Re: [PATCH] virt: acrn: Remove unusted list 'acrn_irqfd_clients'
> > 
> > * Fei Li (fei1.li@intel.com) wrote:
> > > On 2024-05-18 at 00:12:46 +0000, Dr. David Alan Gilbert wrote:
> > > > * linux@treblig.org (linux@treblig.org) wrote:
> > > > > From: "Dr. David Alan Gilbert" <linux@treblig.org>
> > > > >
> > > > > It doesn't look like this was ever used.
> > > > >
> > > > > Build tested only.
> > > > >
> > > > > Signed-off-by: Dr. David Alan Gilbert <linux@treblig.org>
> > > >
> > > > Ping
> > >
> > > Acked-by: Fei Li <fei1.li@intel.com>
> > 
> > Hi Fei,
> >   Do you know which way this is likely to get picked up?
> > (I don't see it in -next)
> > 
> >  Thanks,
> > 
> > Dave
> > 
> > > Thanks.
> 
> Hi Dave
> 
> For this patch, you could refer to https://lore.kernel.org/all/20210910094708.3430340-1-bigeasy@linutronix.de/ to cc Thomas Gleixner <tglx@linutronix.de> to help review.

OK, I've added Thomas to the To: on this mail;
note he's not listed in Maintainers for drivers/virt/acrn

Dave

> Thanks.
> 
> > >
> > > >
> > > > > ---
> > > > >  drivers/virt/acrn/irqfd.c | 2 --
> > > > >  1 file changed, 2 deletions(-)
> > > > >
> > > > > diff --git a/drivers/virt/acrn/irqfd.c b/drivers/virt/acrn/irqfd.c
> > > > > index d4ad211dce7a3..346cf0be4aac7 100644
> > > > > --- a/drivers/virt/acrn/irqfd.c
> > > > > +++ b/drivers/virt/acrn/irqfd.c
> > > > > @@ -16,8 +16,6 @@
> > > > >
> > > > >  #include "acrn_drv.h"
> > > > >
> > > > > -static LIST_HEAD(acrn_irqfd_clients);
> > > > > -
> > > > >  /**
> > > > >   * struct hsm_irqfd - Properties of HSM irqfd
> > > > >   * @vm:		Associated VM pointer
> > > > > --
> > > > > 2.45.0
> > > > >
> > > > --
> > > >  -----Open up your eyes, open up your mind, open up your code -------
> > > > / Dr. David Alan Gilbert    |       Running GNU/Linux       | Happy  \
> > > > \        dave @ treblig.org |                               | In Hex /
> > > >  \ _________________________|_____ http://www.treblig.org   |_______/
> > > >
> > >
> > --
> >  -----Open up your eyes, open up your mind, open up your code -------
> > / Dr. David Alan Gilbert    |       Running GNU/Linux       | Happy  \
> > \        dave @ treblig.org |                               | In Hex /
> >  \ _________________________|_____ http://www.treblig.org   |_______/
> 
-- 
 -----Open up your eyes, open up your mind, open up your code -------   
/ Dr. David Alan Gilbert    |       Running GNU/Linux       | Happy  \ 
\        dave @ treblig.org |                               | In Hex /
 \ _________________________|_____ http://www.treblig.org   |_______/
