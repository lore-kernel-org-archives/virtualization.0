From: Greg KH <greg@kroah.com>
Subject: Re: [PATCH 1/1] hv: Added new hv_utils driver to hyper-v
Date: Wed, 28 Apr 2010 15:28:10 -0700
Message-ID: <20100428222810.GA18247@kroah.com>
References: <8AFC7968D54FB448A30D8F38F259C5621AFEC6F3@TK5EX14MBXC114.redmond.corp.microsoft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <8AFC7968D54FB448A30D8F38F259C5621AFEC6F3@TK5EX14MBXC114.redmond.corp.microsoft.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Hank Janssen <hjanssen@microsoft.com>, Ky Srinivasan <ksrinivasan@novell.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "devel@driverdev.osuosl.org" <devel@driverdev.osuosl.org>, "virtualization@lists.osdl.org" <virtualization@lists.osdl.org>, Haiyang Zhang <haiyangz@microsoft.com>, Greg KH <gregkh@suse.de>
List-Id: virtualization@lists.linuxfoundation.org

On Wed, Apr 28, 2010 at 10:11:02PM +0000, Hank Janssen wrote:
> 
> From: Hank Janssen <hjanssen@microsoft.com>
> 
> Addition of new driver for Hyper-V called hv_utils.
> This driver is intended to support things like KVP, Timesync, Heartbeat etc.

Does this duplicate functionality in KY's clocksource driver?  Or is it
a separate thing?

> This first release has support for graceful shutdown.
> e.g. Select shutdown from the Hyper-V main admin screen and the
> Linux VM will do a graceful shutdown.
> 
> Signed-off-by: Hank Janssen <hjanssen@microsoft.com>
> Signed-off-by: Haiyang Zhang <haiyangz@microsoft.com>
> Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

I did not sign off on this, I've never even seen this patch before, why
would you add my name?  That is not ok at all!

greg k-h
