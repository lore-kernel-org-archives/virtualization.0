From: Greg KH <gregkh@suse.de>
Subject: Re: [PATCH 1/1] staging: hv: Convert vmbus driver interface
	function pointer table to constant
Date: Wed, 8 Sep 2010 15:44:09 -0700
Message-ID: <20100908224409.GB12200@suse.de>
References: <1FB5E1D5CA062146B38059374562DF72854C92E8@TK5EX14MBXC130.redmond.corp.microsoft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1FB5E1D5CA062146B38059374562DF72854C92E8@TK5EX14MBXC130.redmond.corp.microsoft.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Haiyang Zhang <haiyangz@microsoft.com>
Cc: "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>, "'devel@driverdev.osuosl.org'" <devel@driverdev.osuosl.org>, "'virtualization@lists.osdl.org'" <virtualization@lists.osdl.org>, Hank Janssen <hjanssen@microsoft.com>
List-Id: virtualization@lists.linuxfoundation.org

On Wed, Sep 08, 2010 at 08:29:45PM +0000, Haiyang Zhang wrote:
> From: Haiyang Zhang <haiyangz@microsoft.com>
> 
> Convert vmbus driver interface function pointer table to constant
> The vmbus interface functions are assigned to a constant - vmbus_ops.

You also remove a function pointer in this patch, why?  Please break up
the patch into logical parts, one patch, one thing.

This looks like it should be 2 patches, right?

thanks,

greg k-h
