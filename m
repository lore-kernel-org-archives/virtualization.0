From: Greg KH <greg@kroah.com>
Subject: Re: [PATCH 41/46] Staging: hv: vmbus: Fix a bug in error handling in
	vmbus_bus_init()
Date: Mon, 29 Aug 2011 11:08:42 -0700
Message-ID: <20110829180842.GA23618@kroah.com>
References: <1314469874-7017-1-git-send-email-kys@microsoft.com>
	<1314469905-7058-1-git-send-email-kys@microsoft.com>
	<1314469905-7058-41-git-send-email-kys@microsoft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <devel-bounces@linuxdriverproject.org>
Content-Disposition: inline
In-Reply-To: <1314469905-7058-41-git-send-email-kys@microsoft.com>
List-Unsubscribe: <http://driverdev.linuxdriverproject.org/mailman/options/devel>,
	<mailto:devel-request@linuxdriverproject.org?subject=unsubscribe>
List-Archive: <http://driverdev.linuxdriverproject.org/pipermail/devel>
List-Post: <mailto:devel@linuxdriverproject.org>
List-Help: <mailto:devel-request@linuxdriverproject.org?subject=help>
List-Subscribe: <http://driverdev.linuxdriverproject.org/mailman/listinfo/devel>,
	<mailto:devel-request@linuxdriverproject.org?subject=subscribe>
Errors-To: devel-bounces@linuxdriverproject.org
Sender: devel-bounces@linuxdriverproject.org
To: "K. Y. Srinivasan" <kys@microsoft.com>
Cc: devel@linuxdriverproject.org, Haiyang Zhang <haiyangz@microsoft.com>, gregkh@suse.de, linux-kernel@vger.kernel.org, virtualization@lists.osdl.org
List-Id: virtualization@lists.linuxfoundation.org

On Sat, Aug 27, 2011 at 11:31:40AM -0700, K. Y. Srinivasan wrote:
> Fix a bug in error handling in vmbus_bus_init().
> 
> Signed-off-by: K. Y. Srinivasan <kys@microsoft.com>
> Signed-off-by: Haiyang Zhang <haiyangz@microsoft.com>
> ---
>  drivers/staging/hv/vmbus_drv.c |   21 ++++++++++-----------
>  1 files changed, 10 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/staging/hv/vmbus_drv.c b/drivers/staging/hv/vmbus_drv.c
> index 02edb11..4d1b123 100644
> --- a/drivers/staging/hv/vmbus_drv.c
> +++ b/drivers/staging/hv/vmbus_drv.c
> @@ -492,7 +492,7 @@ static int vmbus_bus_init(int irq)
>  
>  	ret = bus_register(&hv_bus);
>  	if (ret)
> -		return ret;
> +		goto err1;
>  
>  	ret = request_irq(irq, vmbus_isr, IRQF_SAMPLE_RANDOM,
>  			driver_name, hv_acpi_dev);
> @@ -500,10 +500,7 @@ static int vmbus_bus_init(int irq)
>  	if (ret != 0) {
>  		pr_err("Unable to request IRQ %d\n",
>  			   irq);
> -
> -		bus_unregister(&hv_bus);
> -
> -		return ret;
> +		goto err2;
>  	}
>  
>  	vector = IRQ0_VECTOR + irq;
> @@ -514,16 +511,18 @@ static int vmbus_bus_init(int irq)
>  	 */
>  	on_each_cpu(hv_synic_init, (void *)&vector, 1);
>  	ret = vmbus_connect();
> -	if (ret) {
> -		free_irq(irq, hv_acpi_dev);
> -		bus_unregister(&hv_bus);
> -		return ret;
> -	}
> -
> +	if (ret)
> +		goto err3;
>  
>  	vmbus_request_offers();
>  
>  	return 0;
> +
> +err3:	free_irq(irq, hv_acpi_dev);
> +err2:	bus_unregister(&hv_bus);
> +err1:	hv_cleanup();

The traditional way to write this is:

err3:
	free_irq(irq, hv_acpi_dev);
err2:
	bus_unregister(&hv_bus);
err1:
	hv_cleanup();

Care to fix this up and resend it?

thanks,

greg k-h
