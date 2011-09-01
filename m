From: Greg KH <greg@kroah.com>
Subject: Re: Hyper-V TODO file
Date: Thu, 1 Sep 2011 13:30:31 -0700
Message-ID: <20110901203031.GB15185@kroah.com>
References: <1314829011-28922-1-git-send-email-kys@microsoft.com>
 <20110901202733.GA15185@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20110901202733.GA15185@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "K. Y. Srinivasan" <kys@microsoft.com>
Cc: gregkh@suse.de, linux-kernel@vger.kernel.org, devel@linuxdriverproject.org, virtualization@lists.osdl.org
List-Id: virtualization@lists.linuxfoundation.org

On Thu, Sep 01, 2011 at 01:27:33PM -0700, Greg KH wrote:
> On Wed, Aug 31, 2011 at 03:16:51PM -0700, K. Y. Srinivasan wrote:
> > 2) With your help, we have fixed all of the issues related to these drivers
> > conforming to the Linux Device Driver model. One of the TODO work items is 
> > "audit the vmbus to verify it is working properly with the driver model".
> 
> I have a few comments about this, I'll respond in another email.

Ok, it looks a _lot_ better, but I have a few minor nits, and one larger
one:

- rename the vmbus_child_* functions to vmbus_* as there's no need to
  think of "children" here.

- vmbus_onoffer comment is incorrect.  You handle offers from lots of
  other types.  Or if not, am I reading the code incorrectly?

- the static hv_cb_utils array needs to go away.  In the hv_utils.c
  util_probe() call, properly register the channel callback, and the
  same goes for the util_remove() call, unregister things there.
  Note, you can use the driver_data field to determine exactly which
  callback needs to be registered to make things easy.  Something like
  the following (pseudo code only):

static const struct hv_vmbus_device_id id_table[] = {
	/* Shutdown guid */
	{ VMBUS_DEVICE(0x31, 0x60, 0x0B, 0X0E, 0x13, 0x52, 0x34, 0x49,
		       0x81, 0x8B, 0x38, 0XD9, 0x0C, 0xED, 0x39, 0xDB),
	  .driver_data = &shutdown_onchannelcallback },
	....
};

util_probe(struct hv_device *dev, const struct hv_vmbus_device_id *id)
 [ Yes, you will have to change the probe callback signature, but that's fine. ]
{
	void *fn(void *context);
	u8 *buffer;

	fn = id->driver_data;
	buffer = kmalloc(PAGE_SIZE, GFP_KERNEL);

	/* Hook up callback and buffer with a call to the proper vmbus
	 * function
	 */
	 ...
}

util_remove()
{
	/* undo what you did in util_probe(), unhooking the callback and
	 * freeing the data */
}


Does that make any sense?

thanks,

greg k-h
