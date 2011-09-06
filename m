From: Greg KH <greg@kroah.com>
Subject: Re: [PATCH 1/1] staging: hv: Add support for >2 TB LUN in storage
 driver.
Date: Tue, 6 Sep 2011 12:06:15 -0700
Message-ID: <20110906190615.GA31897@kroah.com>
References: <1314915069-1796-1-git-send-email-mike.sterling@microsoft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1314915069-1796-1-git-send-email-mike.sterling@microsoft.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Mike Sterling <mike.sterling@microsoft.com>
Cc: haiyangz@microsoft.com, hjanssen@microsoft.com, kys@microsoft.com, gregkh@suse.de, linux-kernel@vger.kernel.org, devel@linuxdriverproject.org, virtualization@lists.osdl.org
List-Id: virtualization@lists.linuxfoundation.org

On Thu, Sep 01, 2011 at 03:11:09PM -0700, Mike Sterling wrote:
> If a LUN larger than 2 TB is attached to a Linux VM on Hyper-V, we currently 
> report a maximum size of 2 TB. This patch resolves the issue in hv_storvsc. 
> Thanks to Robert Scheck <robert.scheck@etes.de> for reporting the issue.
> 
> Reported-by: Robert Scheck <robert.scheck@etes.de>
> Signed-off-by: Mike Sterling <mike.sterling@microsoft.com>
> Signed-off-by: K.Y. Srinivasan <kys@microsoft.com>
> Signed-off-by: Haiyang Zhang <haiyangz@microsoft.com>
> ---
>  drivers/staging/hv/hyperv_storage.h |    1 +

This file is no longer in the latest kernel tree (linux-next or
staging-next).  What tree did you generate this patch against?  And
how come Haiyang and KY didn't catch such a basic mistake in their
review...

I'm guessing that this patch was not even tested :(

Please fix this and resend.

greg k-h
