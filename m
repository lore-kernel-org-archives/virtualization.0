From: Greg KH <greg@kroah.com>
Subject: Re: [PATCH 06/59] Staging: hv: blkvsc: Use the newly introduced
 vmbus ID in the blockvsc driver
Date: Thu, 25 Aug 2011 11:46:12 -0700
Message-ID: <20110825184612.GA1891@kroah.com>
References: <1314290866-2644-1-git-send-email-kys@microsoft.com>
 <1314290965-2698-1-git-send-email-kys@microsoft.com>
 <1314290965-2698-6-git-send-email-kys@microsoft.com>
 <20110825173624.GA21334@kroah.com>
 <6E21E5352C11B742B20C142EB499E048081B339F@TK5EX14MBXC126.redmond.corp.microsoft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <6E21E5352C11B742B20C142EB499E048081B339F@TK5EX14MBXC126.redmond.corp.microsoft.com>
Sender: linux-kernel-owner@vger.kernel.org
To: KY Srinivasan <kys@microsoft.com>
Cc: "gregkh@suse.de" <gregkh@suse.de>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "devel@linuxdriverproject.org" <devel@linuxdriverproject.org>, "virtualization@lists.osdl.org" <virtualization@lists.osdl.org>, Haiyang Zhang <haiyangz@microsoft.com>
List-Id: virtualization@lists.linuxfoundation.org

On Thu, Aug 25, 2011 at 05:52:10PM +0000, KY Srinivasan wrote:
> > No need to set the field name to nothing.
> > 
> > Hm, this could all be made even smaller with something like the
> > USB_DEVICE() macro.  How about this instead:
> > 
> > /* IDE guid */
> > static const struct hv_vmbus_device_id id_table[] = {
> > 	{ VMBUS_DEVICE(0x32, 0x26, 0x41, 0x32, 0xcb, 0x86, 0xa2, 0x44,
> > 		       0x9b, 0x5c, 0x50, 0xd1, 0x41, 0x73, 0x54, 0xf5) },
> > 	{ },
> > };
> > 
> > That would be easier to read and understand, right?  Half the number of
> > lines as well, which is always nice.
> > 
> > If so, I'll go make that change here so you don't have to respin these.
> 
> Looks great Greg. So you are going to add the VMBUS_DEVICE() macro?

Yes, I've now done so and pushed out the changes, which you have been
copied on, including a bug fix that I needed to make when I added the
driver_data field to the hv_vmbus_device_id structure.

I'll review the rest of the series after lunch.

thanks,

greg k-h
