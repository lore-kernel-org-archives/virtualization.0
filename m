From: Greg KH <greg@kroah.com>
Subject: Re: [PATCH 00/21] Staging: hv: Cleanup vmbus driver
Date: Mon, 14 Mar 2011 12:37:16 -0700
Message-ID: <20110314193716.GA22131@kroah.com>
References: <1299794382-709-1-git-send-email-kys@microsoft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1299794382-709-1-git-send-email-kys@microsoft.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "K. Y. Srinivasan" <kys@microsoft.com>
Cc: gregkh@suse.de, linux-kernel@vger.kernel.org, devel@linuxdriverproject.org, virtualization@lists.osdl.org
List-Id: virtualization@lists.linuxfoundation.org

On Thu, Mar 10, 2011 at 01:59:42PM -0800, K. Y. Srinivasan wrote:
> This patch-set fixes the following issues in the vmbus driver (vmbus_drv.c):
> 
> Cleanup root device management: (patches 1/21 through 10/21)
> 	1) Get rid of the hv_driver code from the vmbus abstraction
> 	2) Get rid of unnecessary call sequences and functions
> 	3) Cleanup the management of the root device by using the 
> 	   standard mechanism for grouping devices under /sys/devices

I've applied the first 9 patches, as I had questions on 10 and 11, and
the others after that don't apply without those two applied.

So, care to resend the rest of the series when we've figured out the
root device stuff?

thanks,

greg k-h
