From: Greg KH <greg@kroah.com>
Subject: Re: Hyper-V TODO file
Date: Fri, 2 Sep 2011 09:09:24 -0700
Message-ID: <20110902160924.GA4784@kroah.com>
References: <1314829011-28922-1-git-send-email-kys@microsoft.com>
 <20110901202733.GA15185@kroah.com>
 <20110901203031.GB15185@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20110901203031.GB15185@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "K. Y. Srinivasan" <kys@microsoft.com>
Cc: gregkh@suse.de, linux-kernel@vger.kernel.org, devel@linuxdriverproject.org, virtualization@lists.osdl.org
List-Id: virtualization@lists.linuxfoundation.org

On Thu, Sep 01, 2011 at 01:30:31PM -0700, Greg KH wrote:
> On Thu, Sep 01, 2011 at 01:27:33PM -0700, Greg KH wrote:
> > On Wed, Aug 31, 2011 at 03:16:51PM -0700, K. Y. Srinivasan wrote:
> > > 2) With your help, we have fixed all of the issues related to these drivers
> > > conforming to the Linux Device Driver model. One of the TODO work items is 
> > > "audit the vmbus to verify it is working properly with the driver model".
> > 
> > I have a few comments about this, I'll respond in another email.
> 
> Ok, it looks a _lot_ better, but I have a few minor nits, and one larger
> one:

Oh, here's another issue I forgot about.  You can get rid of the 'ext'
field of the hv_device structure and use the proper function in the
driver core for this type of thing, just wrap it up in your own function
to make it "sane" looking, like USB and PCI does with their
usb_get_intfdata(), usb_set_intfdata(), pci_get_drvdata(), and
pci_set_drvdata() functions.

thanks,

greg k-h
