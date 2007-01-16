From: Mark Williamson <mark.williamson@cl.cam.ac.uk>
Subject: Re: Re: [patch 20/20] XEN-paravirt: Add Xen virtual block
	device driver.
Date: Tue, 16 Jan 2007 02:53:42 +0000
Message-ID: <200701160253.43218.mark.williamson@cl.cam.ac.uk>
References: <20070113014539.408244126@goop.org>
	<20070113014649.256179743@goop.org>
	<1168736848.3123.352.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <xen-devel-bounces@lists.xensource.com>
In-Reply-To: <1168736848.3123.352.camel@laptopd505.fenrus.org>
Content-Disposition: inline
List-Unsubscribe: <http://lists.xensource.com/cgi-bin/mailman/listinfo/xen-devel>,
	<mailto:xen-devel-request@lists.xensource.com?subject=unsubscribe>
List-Post: <mailto:xen-devel@lists.xensource.com>
List-Help: <mailto:xen-devel-request@lists.xensource.com?subject=help>
List-Subscribe: <http://lists.xensource.com/cgi-bin/mailman/listinfo/xen-devel>,
	<mailto:xen-devel-request@lists.xensource.com?subject=subscribe>
Sender: xen-devel-bounces@lists.xensource.com
Errors-To: xen-devel-bounces@lists.xensource.com
To: xen-devel@lists.xensource.com
Cc: Andrew Morton <akpm@osdl.org>, Jeremy Fitzhardinge <jeremy@goop.org>, virtualization@lists.osdl.org, linux-kernel@vger.kernel.org, Chris Wright <chrisw@sous-sol.org>, Ian Pratt <ian.pratt@xensource.com>, Christian Limpach <Christian.Limpach@cl.cam.ac.uk>, Arjan van de Ven <arjan@infradead.org>
List-Id: virtualization@lists.linuxfoundation.org

> > +
> > +	err = xenbus_printf(xbt, dev->nodename,
> > +			    "ring-ref","%u", info->ring_ref);
>
> why do you need your own printf?

xenbus_printf isn't a printf replacement - it is used for writing a formatted 
string into XenStore (which contains  VM configuration data in a 
human-readable form).

Internally it does a vsnprintf into a buffer and writes the resulting string 
to the XenStore.

Cheers,
Mark

> > +static inline int GET_ID_FROM_FREELIST(
>
> does this really need screaming?
>
> > +
> > +int blkif_ioctl(struct inode *inode, struct file *filep,
> > +		unsigned command, unsigned long argument)
> > +{
> > +	int i;
> > +
> > +	DPRINTK_IOCTL("command: 0x%x, argument: 0x%lx, dev: 0x%04x\n",
> > +		      command, (long)argument, inode->i_rdev);
> > +
> > +	switch (command) {
> > +	case CDROMMULTISESSION:
> > +		DPRINTK("FIXME: support multisession CDs later\n");
> > +		for (i = 0; i < sizeof(struct cdrom_multisession); i++)
> > +			if (put_user(0, (char __user *)(argument + i)))
> > +				return -EFAULT;
> > +		return 0;
> > +
> > +	default:
> > +		/*printk(KERN_ALERT "ioctl %08x not supported by Xen blkdev\n",
> > +		  command);*/
> > +		return -EINVAL; /* same return as native Linux */
> > +	}
>
> eh so you implement no ioctls.. why then implement the ioctl method at
> all?

I'm not familiar with this code...  but perhaps the (fake) multisession 
handling is to keep userspace that queries this happy?  I can't really think 
of anywhere this would apply off the top of my head, though.

Cheers,
Mark

> > +static struct xenbus_driver blkfront = {
> > +	.name = "vbd",
> > +	.owner = THIS_MODULE,
> > +	.ids = blkfront_ids,
> > +	.probe = blkfront_probe,
> > +	.remove = blkfront_remove,
> > +	.resume = blkfront_resume,
> > +	.otherend_changed = backend_changed,
> > +};
>
> this can be const
>
> > +
> > +#define DPRINTK(_f, _a...) pr_debug(_f, ## _a)
>
> why this silly abstraction? Just use pr_debug in the code directly
>
>
>
>
> _______________________________________________
> Xen-devel mailing list
> Xen-devel@lists.xensource.com
> http://lists.xensource.com/xen-devel

-- 
Dave: Just a question. What use is a unicyle with no seat?  And no pedals!
Mark: To answer a question with a question: What use is a skateboard?
Dave: Skateboards have wheels.
Mark: My wheel has a wheel!
