From: Arjan van de Ven <arjan@infradead.org>
Subject: Re: [patch 20/20] XEN-paravirt: Add Xen virtual block device
	driver.
Date: Sat, 13 Jan 2007 17:07:28 -0800
Message-ID: <1168736848.3123.352.camel@laptopd505.fenrus.org>
References: <20070113014539.408244126@goop.org>
	 <20070113014649.256179743@goop.org>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1750956AbXANBHu@vger.kernel.org>
In-Reply-To: <20070113014649.256179743@goop.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Jeremy Fitzhardinge <jeremy@goop.org>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org, virtualization@lists.osdl.org, xen-devel@lists.xensource.com, Ian Pratt <ian.pratt@xensource.com>, Christian Limpach <Christian.Limpach@cl.cam.ac.uk>, Chris Wright <chrisw@sous-sol.org>
List-Id: virtualization@lists.linuxfoundation.org

> +#include "../../../arch/i386/paravirt-xen/events.h"
> +#include "../../../arch/i386/paravirt-xen/xen-page.h"

this shows the headers are clearly in the wrong place...
> +
> +	err = xenbus_printf(xbt, dev->nodename,
> +			    "ring-ref","%u", info->ring_ref);

why do you need your own printf?

> +static inline int GET_ID_FROM_FREELIST(

does this really need screaming?


> +
> +int blkif_ioctl(struct inode *inode, struct file *filep,
> +		unsigned command, unsigned long argument)
> +{
> +	int i;
> +
> +	DPRINTK_IOCTL("command: 0x%x, argument: 0x%lx, dev: 0x%04x\n",
> +		      command, (long)argument, inode->i_rdev);
> +
> +	switch (command) {
> +	case CDROMMULTISESSION:
> +		DPRINTK("FIXME: support multisession CDs later\n");
> +		for (i = 0; i < sizeof(struct cdrom_multisession); i++)
> +			if (put_user(0, (char __user *)(argument + i)))
> +				return -EFAULT;
> +		return 0;
> +
> +	default:
> +		/*printk(KERN_ALERT "ioctl %08x not supported by Xen blkdev\n",
> +		  command);*/
> +		return -EINVAL; /* same return as native Linux */
> +	}

eh so you implement no ioctls.. why then implement the ioctl method at
all?


> +static struct xenbus_driver blkfront = {
> +	.name = "vbd",
> +	.owner = THIS_MODULE,
> +	.ids = blkfront_ids,
> +	.probe = blkfront_probe,
> +	.remove = blkfront_remove,
> +	.resume = blkfront_resume,
> +	.otherend_changed = backend_changed,
> +};

this can be const

> +
> +#define DPRINTK(_f, _a...) pr_debug(_f, ## _a)

why this silly abstraction? Just use pr_debug in the code directly
