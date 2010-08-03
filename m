From: Greg KH <gregkh@suse.de>
Subject: Re: [PATCH 4/6] staging: hv: Removed TODO for VMBUS, it mirrors
 HYPER-V behavior to closely
Date: Tue, 3 Aug 2010 10:42:43 -0700
Message-ID: <20100803174243.GE1455@suse.de>
References: <8AFC7968D54FB448A30D8F38F259C56223FD1D2F@TK5EX14MBXC114.redmond.corp.microsoft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <8AFC7968D54FB448A30D8F38F259C56223FD1D2F@TK5EX14MBXC114.redmond.corp.microsoft.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Hank Janssen <hjanssen@microsoft.com>
Cc: "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>, "'devel@driverdev.osuosl.org'" <devel@driverdev.osuosl.org>, "'virtualization@lists.osdl.org'" <virtualization@lists.osdl.org>, Haiyang Zhang <haiyangz@microsoft.com>
List-Id: virtualization@lists.linuxfoundation.org

On Tue, Aug 03, 2010 at 05:31:54PM +0000, Hank Janssen wrote:
> From: Hank Janssen <hjanssen@microsoft.com>
> 
> Removed TODO for VMBUS, it mirrors HYPER-V behaviour to closely and does not really share any 
> usable functionality of the Linux kernel facilities. There is not really an easy way to combine functionality.

Are you sure about that?  Right now, the code doesn't look like any
other virtual bus code, but that's because it needs to be fixed up and
work properly (not with the two layers of indirection that was added a
long time ago before the code was opened up.)

I think once the code is cleaned up properly, you might find that it can
be combined much easier than you think...

So no, I'll not allow this TODO item to be removed until after the vbus
code is fixed up, and you can convince me that it really is unique
enough to remain as-is.

Oh, and again, please properly line-wrap your changelog comments.

thanks,

greg k-h
