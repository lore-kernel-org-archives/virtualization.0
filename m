From: Greg KH <greg@kroah.com>
Subject: Re: [PATCH 04/12] Staging: hv: Rename vmbus_driver_context structure
Date: Mon, 4 Apr 2011 21:22:30 -0700
Message-ID: <20110405042230.GC8090@kroah.com>
References: <1300226527-26933-1-git-send-email-kys@microsoft.com>
 <1300226624-27004-1-git-send-email-kys@microsoft.com>
 <1300226624-27004-2-git-send-email-kys@microsoft.com>
 <1300226624-27004-3-git-send-email-kys@microsoft.com>
 <1300226624-27004-4-git-send-email-kys@microsoft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1300226624-27004-4-git-send-email-kys@microsoft.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "K. Y. Srinivasan" <kys@microsoft.com>
Cc: gregkh@suse.de, linux-kernel@vger.kernel.org, devel@linuxdriverproject.org, virtualization@lists.osdl.org, Haiyang Zhang <haiyangz@microsoft.com>, Mike Sterling <mike.sterling@microsoft.com>, Abhishek Kane <v-abkane@microsoft.com>
List-Id: virtualization@lists.linuxfoundation.org

On Tue, Mar 15, 2011 at 03:03:35PM -0700, K. Y. Srinivasan wrote:
> Now that struct vmbus_driver_context is properly
> cleaned up, rename this structure appropriately and
> cleanup the code.
> 
> Signed-off-by: K. Y. Srinivasan <kys@microsoft.com>
> Signed-off-by: Haiyang Zhang <haiyangz@microsoft.com>
> Signed-off-by: Mike Sterling <mike.sterling@microsoft.com>
> Signed-off-by: Abhishek Kane <v-abkane@microsoft.com>
> Signed-off-by: Hank Janssen <hjanssen@microsoft.com>
> ---
>  drivers/staging/hv/vmbus_drv.c |   32 +++++++++++++++-----------------
>  1 files changed, 15 insertions(+), 17 deletions(-)
> 
> diff --git a/drivers/staging/hv/vmbus_drv.c b/drivers/staging/hv/vmbus_drv.c
> index 239b91c..f292b03 100644
> --- a/drivers/staging/hv/vmbus_drv.c
> +++ b/drivers/staging/hv/vmbus_drv.c
> @@ -41,7 +41,7 @@
>  struct pci_dev *hv_pci_dev;
>  
>  /* Main vmbus driver data structure */
> -struct vmbus_driver_context {
> +struct hv_bus {
>  	struct bus_type bus;
>  	struct tasklet_struct msg_dpc;
>  	struct tasklet_struct event_dpc;
> @@ -99,7 +99,7 @@ static struct device_attribute vmbus_device_attrs[] = {
>  };
>  
>  /* The one and only one */
> -static struct vmbus_driver_context vmbus_drv = {
> +static struct hv_bus  hv_bus = {

2 spaces?


>  	.bus.name =		"vmbus",
>  	.bus.match =		vmbus_match,
>  	.bus.shutdown =		vmbus_shutdown,

Wait, why is a bus_type embedded within another structure?  That
is going to get pulled out later, right?

thanks,

greg k-h
