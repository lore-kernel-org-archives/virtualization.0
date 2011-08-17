From: Sasha Levin <levinsasha928@gmail.com>
Subject: Re: [PATCH 2/8] Staging: hv: vmbus: Invoke vmbus_on_msg_dpc() directly
Date: Wed, 17 Aug 2011 15:47:47 +0300
Message-ID: <1313585267.15004.3.camel@lappy>
References: <1313446210-10611-1-git-send-email-kys@microsoft.com>
	<1313446327-10650-1-git-send-email-kys@microsoft.com>
	<1313446327-10650-2-git-send-email-kys@microsoft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <devel-bounces@linuxdriverproject.org>
In-Reply-To: <1313446327-10650-2-git-send-email-kys@microsoft.com>
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

On Mon, 2011-08-15 at 15:12 -0700, K. Y. Srinivasan wrote:
> The message processing function needs to execute on the same CPU where
> the interrupt was taken. tasklets cannot gurantee this; so, invoke the 
> function directly.
> 
> Signed-off-by: K. Y. Srinivasan <kys@microsoft.com>
> Signed-off-by: Haiyang Zhang <haiyangz@microsoft.com>
> ---

tasklets are guaranteed to run on the same CPU as the function that
scheduled them.

Unless I'm missing something?

>  drivers/staging/hv/vmbus_drv.c |    4 +---
>  1 files changed, 1 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/staging/hv/vmbus_drv.c b/drivers/staging/hv/vmbus_drv.c
> index bb25c5b..1d4e878 100644
> --- a/drivers/staging/hv/vmbus_drv.c
> +++ b/drivers/staging/hv/vmbus_drv.c
> @@ -39,7 +39,6 @@
>  
>  static struct acpi_device  *hv_acpi_dev;
>  
> -static struct tasklet_struct msg_dpc;
>  static struct tasklet_struct event_dpc;
>  
>  unsigned int vmbus_loglevel = (ALL_MODULES << 16 | INFO_LVL);
> @@ -425,7 +424,7 @@ static irqreturn_t vmbus_isr(int irq, void *dev_id)
>  	/* Check if there are actual msgs to be process */
>  	if (msg->header.message_type != HVMSG_NONE) {
>  		handled = true;
> -		tasklet_schedule(&msg_dpc);
> +		vmbus_on_msg_dpc(0);
>  	}
>  
>  	page_addr = hv_context.synic_event_page[cpu];
> @@ -465,7 +464,6 @@ static int vmbus_bus_init(int irq)
>  	}
>  
>  	/* Initialize the bus context */
> -	tasklet_init(&msg_dpc, vmbus_on_msg_dpc, 0);
>  	tasklet_init(&event_dpc, vmbus_on_event, 0);
>  
>  	/* Now, register the bus  with LDM */

-- 

Sasha.
