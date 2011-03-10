From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH 13/21] [PATCH 13/21] Staging: hv: Rename
	vmbus_driver_context structure
Date: Thu, 10 Mar 2011 23:49:32 +0100 (CET)
Message-ID: <alpine.LFD.2.00.1103102347450.2787@localhost6.localdomain6>
References: <[PATCH 00/21] Staging: hv: Cleanup vmbus driver>
	<1299795131-1335-1-git-send-email-kys@microsoft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <devel-bounces@linuxdriverproject.org>
In-Reply-To: <1299795131-1335-1-git-send-email-kys@microsoft.com>
List-Unsubscribe: <http://driverdev.linuxdriverproject.org/mailman/options/devel>,
	<mailto:devel-request@linuxdriverproject.org?subject=unsubscribe>
List-Archive: <http://driverdev.linuxdriverproject.org/pipermail/devel>
List-Post: <mailto:devel@linuxdriverproject.org>
List-Help: <mailto:devel-request@linuxdriverproject.org?subject=help>
List-Subscribe: <http://driverdev.linuxdriverproject.org/mailman/listinfo/devel>,
	<mailto:devel-request@linuxdriverproject.org?subject=subscribe>
Sender: devel-bounces@linuxdriverproject.org
Errors-To: devel-bounces@linuxdriverproject.org
To: "K. Y. Srinivasan" <kys@microsoft.com>
Cc: Abhishek Kane <v-abkane@microsoft.com>, Haiyang Zhang <haiyangz@microsoft.com>, gregkh@suse.de, linux-kernel@vger.kernel.org, virtualization@lists.osdl.org, Mike Sterling <mike.sterling@microsoft.com>, devel@linuxdriverproject.org
List-Id: virtualization@lists.linuxfoundation.org

On Thu, 10 Mar 2011, K. Y. Srinivasan wrote:
> Now that struct vmbus_driver_context is properly
> cleaned up, rename this structure appropriately and
> cleanup the code.

> @@ -877,10 +873,10 @@ static irqreturn_t vmbus_isr(int irq, void *dev_id)
>  	/* Schedules a dpc if necessary */
>  	if (ret > 0) {
>  		if (test_bit(0, (unsigned long *)&ret))
> -			tasklet_schedule(&vmbus_drv.msg_dpc);
> +			tasklet_schedule(&hv_bus.msg_dpc);
>  
>  		if (test_bit(1, (unsigned long *)&ret))
> -			tasklet_schedule(&vmbus_drv.event_dpc);
> +			tasklet_schedule(&hv_bus.event_dpc);

What's the plan to convert that tasklet/work stuff to threaded irqs ?

Thanks,

	tglx
