From: Greg KH <greg@kroah.com>
Subject: Re: [PATCH 1/1] staging: hv: Convert vmbus driver interface
 function pointer table to constant
Date: Tue, 14 Sep 2010 16:26:24 -0700
Message-ID: <20100914232624.GA1350@kroah.com>
References: <1FB5E1D5CA062146B38059374562DF72854C94CE@TK5EX14MBXC130.redmond.corp.microsoft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1FB5E1D5CA062146B38059374562DF72854C94CE@TK5EX14MBXC130.redmond.corp.microsoft.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Haiyang Zhang <haiyangz@microsoft.com>
Cc: Greg KH <gregkh@suse.de>, "'devel@driverdev.osuosl.org'" <devel@driverdev.osuosl.org>, "'virtualization@lists.osdl.org'" <virtualization@lists.osdl.org>, "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
List-Id: virtualization@lists.linuxfoundation.org

On Thu, Sep 09, 2010 at 02:53:03PM +0000, Haiyang Zhang wrote:
> > From: Greg KH [mailto:gregkh@suse.de]
> > Sent: Wednesday, September 08, 2010 6:44 PM
> > > Convert vmbus driver interface function pointer table to constant
> > > The vmbus interface functions are assigned to a constant - vmbus_ops.
> > 
> > You also remove a function pointer in this patch, why?  Please break up
> > the patch into logical parts, one patch, one thing.
> > 
> > This looks like it should be 2 patches, right?
> 
> Because the vmbus interface function pointer table is converted to a
> constant variable -- vmbus_ops, the function GetChannelInterface(),
> VmbusGetChannelInterface() and pointer GetChannelInterface are no longer
> in use. The deprecated function's work is done by the initialization of
> the newly added constant variable vmbus_ops.
> 
> I created the new constant variable vmbus_ops and removed the deprecated
> function pointer GetChannelInterface in one patch.

Great, next time say that in the patch please :)

I'll go edit the wording and apply this...

thanks,

greg k-h
