From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH]: Staging: hv: Allocate the vmbus irq dynamically
Date: Sat, 19 Feb 2011 11:23:04 +0100 (CET)
Message-ID: <alpine.LFD.2.00.1102191046220.2701@localhost6.localdomain6>
References: <1297799735-25917-1-git-send-email-kys@microsoft.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1297799735-25917-1-git-send-email-kys@microsoft.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "K. Y. Srinivasan" <kys@microsoft.com>
Cc: gregkh@suse.de, linux-kernel@vger.kernel.org, devel@linuxdriverproject.org, virtualization@lists.osdl.org, Haiyang Zhang <haiyangz@microsoft.com>, Hank Janssen <hjanssen@microsoft.com>
List-Id: virtualization@lists.linuxfoundation.org

On Tue, 15 Feb 2011, K. Y. Srinivasan wrote:
> -/* FIXME! We need to do this dynamically for PIC and APIC system */
> -#define VMBUS_IRQ		0x5
> -#define VMBUS_IRQ_VECTOR	IRQ5_VECTOR
> +static int vmbus_irq;
>  
>  /* Main vmbus driver data structure */
>  struct vmbus_driver_context {
> @@ -57,6 +55,27 @@ struct vmbus_driver_context {
>  	struct vm_device device_ctx;
>  };
>  
> +/*
> + * Find an un-used IRQ that the VMBUS can use. If none is available;
> + * return -EBUSY.
> + */
> +static int vmbus_get_irq(void)
> +{
> +	unsigned int avail_irq_mask;
> +	int irq = -EBUSY;
> +
> +	/*
> +	 * Pick the first unused interrupt. HyperV can
> +	 * interrupt us on any interrupt line we specify.
> +	 */
> +
> +	avail_irq_mask = probe_irq_on();
> +	if (avail_irq_mask != 0)
> +		irq = ffs(avail_irq_mask);
> +	probe_irq_off(avail_irq_mask);
> +	return irq;


Please do not use probe_irq_on for dynamic irq allocation. Highjacking
the lower PIC irqs is really not a good idea. Depending on when this
runs, you might grab an irq required by a driver which gets loaded
later. 

Could you please explain what you're trying to do here ?

Thanks,

	tglx
