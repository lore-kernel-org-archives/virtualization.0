From: Greg KH <gregkh@suse.de>
Subject: Re: [PATCH 2/6] staging: hv: Fixed lockup problem with
 bounce_buffer scatter list
Date: Wed, 4 Aug 2010 10:05:03 -0700
Message-ID: <20100804170503.GB28217@suse.de>
References: <8AFC7968D54FB448A30D8F38F259C56223FD1D29@TK5EX14MBXC114.redmond.corp.microsoft.com>
 <20100803173857.GB1455@suse.de>
 <8AFC7968D54FB448A30D8F38F259C56223FE7AF6@TK5EX14MBXC114.redmond.corp.microsoft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <8AFC7968D54FB448A30D8F38F259C56223FE7AF6@TK5EX14MBXC114.redmond.corp.microsoft.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Hank Janssen <hjanssen@microsoft.com>
Cc: "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>, "'devel@driverdev.osuosl.org'" <devel@driverdev.osuosl.org>, "'virtualization@lists.osdl.org'" <virtualization@lists.osdl.org>, Haiyang Zhang <haiyangz@microsoft.com>
List-Id: virtualization@lists.linuxfoundation.org

On Wed, Aug 04, 2010 at 04:32:17AM +0000, Hank Janssen wrote:
> And then Greg spoke:
> >> On Tue, Aug 03, 2010 at 05:31:53PM +0000, Hank Janssen wrote:
> >> From: Hank Janssen <hjanssen@microsoft.com>
> > >
> > >Fixed lockup problem with bounce_buffer scatter list which caused crashes in heavy loads.
> >
> >Same questions for you as patch 1/6.
> >
> >Also, please wrap your changelog comments at 72 columns.
>  
> Under heavy loads with many clients we this problem appears, it causes a kernel 
> Panic.

Great, please provide this info.

> Yes, this should be backported to all stable kernel releases that have the 
> Hyper-V drivers In them.  

Again, add a cc: stable <stable@kernel.org> to the patch please.

> >> Signed-off-by:Hank Janssen <hjanssen@microsoft.com> 
> >> Signed-off-by:Haiyang Zhang <haiyangz@microsoft.com>
> >
> >What's with the trailing space?
> 
> Same problem as wrapping my comments at 72  chars, I just upgraded to the latest
> Evil outlook 2010, and my settings in office 2007 did not transfer so I have to 
> Set up all the stuff that fixes these problems :(
> 
> Do you want me to re-submit with correct wrapping?

Yes.  But you also have trailing spaces in some of these patches as
well, which need to be addressed.

thanks,

greg k-h
