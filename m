From: Andi Kleen <ak@suse.de>
Subject: Re: [patch] paravirt: VDSO page is essential
Date: Mon, 5 Mar 2007 21:16:42 +0100
Message-ID: <200703052116.42807.ak@suse.de>
References: <20070305120631.GA14105@elte.hu> <20070305143437.GF22829@bingen.suse.de> <45EC796D.5050705@vmware.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1752850AbXCEURz@vger.kernel.org>
In-Reply-To: <45EC796D.5050705@vmware.com>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: Zachary Amsden <zach@vmware.com>
Cc: Rusty Russell <rusty@rustcorp.com.au>, Ingo Molnar <mingo@elte.hu>, Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org, Roland McGrath <roland@redhat.com>, virtualization <virtualization@lists.osdl.org>
List-Id: virtualization@lists.linuxfoundation.org

 We are not concerned so much 
> with supporting legacy user land deployments,

I am concerned about that. I won't merge any patches that break compatibility
by default.

> > What would probably work is to somehow decide at runtime if a hypervisor
> > is there or not and then set vdso default based on that. I guess that
> > detection would be hypervisor specific though and probably would
> > need paravirt ops extensions.
> >   
> 
> What we really need to do is to be able to detect an old user land and 
> drop VDSO support when that is found.  

Rusty implemented that, but it was widely considered too ugly
(and it was not 100% reliable e.g. with chroots) 

> But since we can't do that, the  
> next best thing is to allow the hypervisor to choose whatever workaround 
> it wants when it moves the fixmap and compat_vdso was enabled.  In our 
> case, the workaround we will want is a boot option to disable VDSO for 
> old user land,

The boot option is already there, but boot options for is not my
idea of user friendly binary compatibility.

> and a printk warning if you take #GPs and kill the init  
> proc, because for us, this is not an expected support scenario.  We 
> would much rather support the VDSO by default in paravirt kernels even 
> with COMPAT_VDSO turned on.

But you can't have it at the compatible fixed address, right?

-Andi
