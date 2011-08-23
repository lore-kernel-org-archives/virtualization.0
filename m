From: Greg KH <greg@kroah.com>
Subject: Re: [PATCH 012/117] Staging: hv: blkvsc: Add the
 MODULE_DEVICE_TABLE() line
Date: Tue, 23 Aug 2011 15:46:14 -0700
Message-ID: <20110823224614.GC9641@kroah.com>
References: <1310752024-27854-1-git-send-email-kys@microsoft.com>
 <1310752065-27895-1-git-send-email-kys@microsoft.com>
 <1310752065-27895-12-git-send-email-kys@microsoft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1310752065-27895-12-git-send-email-kys@microsoft.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "K. Y. Srinivasan" <kys@microsoft.com>
Cc: gregkh@suse.de, linux-kernel@vger.kernel.org, devel@linuxdriverproject.org, virtualization@lists.osdl.org, Haiyang Zhang <haiyangz@microsoft.com>
List-Id: virtualization@lists.linuxfoundation.org

On Fri, Jul 15, 2011 at 10:46:00AM -0700, K. Y. Srinivasan wrote:
> Add the MODULE_DEVICE_TABLE() line in blkvsc_drv.c.
> 
> Signed-off-by: K. Y. Srinivasan <kys@microsoft.com>
> Signed-off-by: Haiyang Zhang <haiyangz@microsoft.com>
> ---
>  drivers/staging/hv/blkvsc_drv.c |    1 +
>  1 files changed, 1 insertions(+), 0 deletions(-)
> 
> diff --git a/drivers/staging/hv/blkvsc_drv.c b/drivers/staging/hv/blkvsc_drv.c
> index 38117d96..8e4c206 100644
> --- a/drivers/staging/hv/blkvsc_drv.c
> +++ b/drivers/staging/hv/blkvsc_drv.c
> @@ -818,6 +818,7 @@ static const struct hv_vmbus_device_id id_table[] = {
>  	},
>  };
>  
> +MODULE_DEVICE_TABLE(vmbus, id_table);

Please merge this back into the patch that added the id_table to the
driver, having it separate like this is just ridiculous.

greg k-h
