From: Greg KH <gregkh@suse.de>
Subject: Re: [PATCH 10/21] Staging: hv: Cleanup root device handling
Date: Mon, 14 Mar 2011 12:58:49 -0700
Message-ID: <20110314195849.GA533@suse.de>
References: <1299794886-1200-1-git-send-email-kys@microsoft.com>
 <20110314193333.GA18944@kroah.com>
 <6E21E5352C11B742B20C142EB499E048019582@TK5EX14MBXC128.redmond.corp.microsoft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <6E21E5352C11B742B20C142EB499E048019582@TK5EX14MBXC128.redmond.corp.microsoft.com>
Sender: linux-kernel-owner@vger.kernel.org
To: KY Srinivasan <kys@microsoft.com>
Cc: Greg KH <greg@kroah.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "devel@linuxdriverproject.org" <devel@linuxdriverproject.org>, "virtualization@lists.osdl.org" <virtualization@lists.osdl.org>, Haiyang Zhang <haiyangz@microsoft.com>, Mike Sterling <Mike.Sterling@microsoft.com>, "Abhishek Kane (Mindtree Consulting PVT LTD)" <v-abkane@microsoft.com>
List-Id: virtualization@lists.linuxfoundation.org

On Mon, Mar 14, 2011 at 07:54:29PM +0000, KY Srinivasan wrote:
> 
> 
> > -----Original Message-----
> > From: Greg KH [mailto:greg@kroah.com]
> > Sent: Monday, March 14, 2011 3:34 PM
> > To: KY Srinivasan
> > Cc: gregkh@suse.de; linux-kernel@vger.kernel.org;
> > devel@linuxdriverproject.org; virtualization@lists.osdl.org; Haiyang Zhang; Mike
> > Sterling; Abhishek Kane (Mindtree Consulting PVT LTD)
> > Subject: Re: [PATCH 10/21] Staging: hv: Cleanup root device handling
> > 
> > On Thu, Mar 10, 2011 at 02:08:06PM -0800, K. Y. Srinivasan wrote:
> > > Now we can complete the cleanup of the root device
> > > management. Use the preferred APIs for creating and
> > > managing the root device. As part of this cleanup get rid
> > > of the root device object from vmbus_driver_context.
> > 
> > I don't understand, what is the "root device"?
> 
> This would be the device under /sys/devices that all 
> other hyperv devices would be grouped under. 
> This notion of the root device existed in the existing
> code; however  its creation and management was
> unnecessarily complicated. 

But that is what your new pci device should be, not a separate one.  Why
not use that instead?

Actually, how are things looking then?  You have a pci device, with no
children, yet the root device has the children devices?  That doesn't
really make sense now does it?

thanks,

greg k-h
