From: Greg KH <greg@kroah.com>
Subject: Re: [PATCH 12/25] Staging: hv: Cleanup error handling in
 vmbus_child_device_register()
Date: Tue, 26 Apr 2011 15:50:59 -0700
Message-ID: <20110426225059.GA12897@kroah.com>
References: <1303834785-4981-1-git-send-email-kys@microsoft.com>
 <1303834842-5022-1-git-send-email-kys@microsoft.com>
 <1303834842-5022-12-git-send-email-kys@microsoft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1303834842-5022-12-git-send-email-kys@microsoft.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "K. Y. Srinivasan" <kys@microsoft.com>
Cc: gregkh@suse.de, linux-kernel@vger.kernel.org, devel@linuxdriverproject.org, virtualization@lists.osdl.org, Haiyang Zhang <haiyangz@microsoft.com>, Abhishek Kane <v-abkane@microsoft.com>
List-Id: virtualization@lists.linuxfoundation.org

On Tue, Apr 26, 2011 at 09:20:29AM -0700, K. Y. Srinivasan wrote:
> Cleanup error handling in vmbus_child_device_register().
> 
> Signed-off-by: K. Y. Srinivasan <kys@microsoft.com>
> Signed-off-by: Haiyang Zhang <haiyangz@microsoft.com>
> Signed-off-by: Abhishek Kane <v-abkane@microsoft.com>
> Signed-off-by: Hank Janssen <hjanssen@microsoft.com>
> ---
>  drivers/staging/hv/vmbus_drv.c |    7 ++++++-
>  1 files changed, 6 insertions(+), 1 deletions(-)
> 
> diff --git a/drivers/staging/hv/vmbus_drv.c b/drivers/staging/hv/vmbus_drv.c
> index d597dd4..4d569ad 100644
> --- a/drivers/staging/hv/vmbus_drv.c
> +++ b/drivers/staging/hv/vmbus_drv.c
> @@ -720,11 +720,16 @@ int vmbus_child_device_register(struct hv_device *child_device_obj)
>  	 */
>  	ret = device_register(&child_device_obj->device);
>  
> +	if (ret)
> +		return ret;
> +
>  	/* vmbus_probe() error does not get propergate to device_register(). */
>  	ret = child_device_obj->probe_error;

Wait, why not?  Why is the probe_error have to be saved off like this?
That seems like something is wrong here, this patch should not be
needed.

Well, you should check the return value of device_register, that is
needed, but this seems broken somehow.

>  
> -	if (ret)
> +	if (ret) {
>  		pr_err("Unable to register child device\n");
> +		device_unregister(&child_device_obj->device);
> +	}
>  	else

	} else
is the preferred way.

Care to send a fixup patch to remove the probe_error field and fix this
formatting error up?

thanks,

greg k-h
