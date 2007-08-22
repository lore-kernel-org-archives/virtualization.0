From: Andi Kleen <ak@suse.de>
Subject: Re: [PATCH] Add I/O hypercalls for i386 paravirt
Date: Wed, 22 Aug 2007 13:23:52 +0200
Message-ID: <20070822112352.GQ32640@bingen.suse.de>
References: <46CBC842.4070100@vmware.com> <46CBCADF.2070400@qumranet.com> <1187763956.6174.48.camel@localhost.localdomain> <20070822103545.GG2642@bingen.suse.de> <46CC0719.2080103@qumranet.com> <20070822110810.GO32640@bingen.suse.de> <46CC0EAF.3000805@qumranet.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1761096AbXHVKaU@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <46CC0EAF.3000805@qumranet.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Avi Kivity <avi@qumranet.com>
Cc: Andi Kleen <ak@suse.de>, Rusty Russell <rusty@rustcorp.com.au>, Andrew Morton <akpm@osdl.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Chris Wright <chrisw@sous-sol.org>, Virtualization Mailing List <virtualization@lists.osdl.org>
List-Id: virtualization@lists.linuxfoundation.org

On Wed, Aug 22, 2007 at 01:23:43PM +0300, Avi Kivity wrote:
> Andi Kleen wrote:
> >>I don't see why it's intrusive -- they all use the APIs, right?
> >>    
> >
> >Yes, but it still changes them. It might have a larger impact
> >on code size for example. 
> >  
> 
> Only if CONFIG_PARAVIRT is defined.  

Which eventually distribution kernels will do.

> And even then, all the performance 
> sensitive stuff uses mmio, no?

Not worried about performance, but just impact on code size etc.

-Andi
