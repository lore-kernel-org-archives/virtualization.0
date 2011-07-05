From: Greg KH <greg@kroah.com>
Subject: Re: [PATCH 15/77] Staging: hv: blkvsc: Add the appropriate
 MODULE_ALIAS() line
Date: Tue, 5 Jul 2011 09:06:21 -0700
Message-ID: <20110705160621.GC7214@kroah.com>
References: <1308255393-3785-1-git-send-email-kys@microsoft.com>
 <1308255470-3826-1-git-send-email-kys@microsoft.com>
 <1308255470-3826-15-git-send-email-kys@microsoft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1308255470-3826-15-git-send-email-kys@microsoft.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "K. Y. Srinivasan" <kys@microsoft.com>
Cc: gregkh@suse.de, linux-kernel@vger.kernel.org, devel@linuxdriverproject.org, virtualization@lists.osdl.org, Haiyang Zhang <haiyangz@microsoft.com>, Hank Janssen <hjanssen@microsoft.com>
List-Id: virtualization@lists.linuxfoundation.org

On Thu, Jun 16, 2011 at 01:16:48PM -0700, K. Y. Srinivasan wrote:
> Add the appropriate MODULE_ALIAS() line to support auto-loading.
> 
> Signed-off-by: K. Y. Srinivasan <kys@microsoft.com>
> Signed-off-by: Haiyang Zhang <haiyangz@microsoft.com>
> Signed-off-by: Hank Janssen <hjanssen@microsoft.com>
> ---
>  drivers/staging/hv/blkvsc_drv.c |    1 +
>  1 files changed, 1 insertions(+), 0 deletions(-)
> 
> diff --git a/drivers/staging/hv/blkvsc_drv.c b/drivers/staging/hv/blkvsc_drv.c
> index 5842db8..9496abe 100644
> --- a/drivers/staging/hv/blkvsc_drv.c
> +++ b/drivers/staging/hv/blkvsc_drv.c
> @@ -1027,5 +1027,6 @@ static void __exit blkvsc_exit(void)
>  MODULE_LICENSE("GPL");
>  MODULE_VERSION(HV_DRV_VERSION);
>  MODULE_DESCRIPTION("Microsoft Hyper-V virtual block driver");
> +MODULE_ALIAS("vmbus:hv_block");

No, these should be automagically generated with the MODULE_DEVICE_ID()
macro that you use in the module with the GUID there, instead of this.

Don't look at platform drivers as any semblance of how you should ever
do anything (I'm guessing you just copied their way of doing things
here).  You have a real bus here (or at least a half-way version of a
bus) that can autodetect devices and tell userspace that you now have
them.  Use that, don't try to model the code after the old, broken, and
hopefully-someday-in-my-dreams-will-go-away platform code.

greg k-h
