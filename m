From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH 12/21] Staging: hv: Cleanup irq management
Date: Thu, 10 Mar 2011 23:46:08 +0100 (CET)
Message-ID: <alpine.LFD.2.00.1103102338230.2787@localhost6.localdomain6>
References: <[PATCH 00/21] Staging: hv: Cleanup vmbus driver> <1299794933-1259-1-git-send-email-kys@microsoft.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1299794933-1259-1-git-send-email-kys@microsoft.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "K. Y. Srinivasan" <kys@microsoft.com>
Cc: gregkh@suse.de, linux-kernel@vger.kernel.org, devel@linuxdriverproject.org, virtualization@lists.osdl.org, Haiyang Zhang <haiyangz@microsoft.com>, Mike Sterling <mike.sterling@microsoft.com>, Abhishek Kane <v-abkane@microsoft.com>, Hank Janssen <hjanssen@microsoft.com>
List-Id: virtualization@lists.linuxfoundation.org

On Thu, 10 Mar 2011, K. Y. Srinivasan wrote:
> Now that vmbus_driver is a platform pci driver,
> cleanup the irq allocation mess by using the standard
> irq allocation mechanisms.
> 
> Note that this patch generates an error when the checkpatch
> script is run because of the IRQF_SAMPLE_RANDOM flag used in
> request_irq() function. This interrupt is the only
> external event this VM will get and consequently if this
> flag (IRQF_SAMPLE_RANDOM) is not  specified, experimentally
> we have shown that the entropy in the VM will very very low.

Fair enough. We need to come up with some way to work around
this though.
 
>  	}
> -	vector = VMBUS_IRQ_VECTOR;
>  
> -	DPRINT_INFO(VMBUS_DRV, "irq 0x%x vector 0x%x", vmbus_irq, vector);
> +	vector = IRQ0_VECTOR + pdev->irq;
> +	DPRINT_INFO(VMBUS_DRV, "irq 0x%x vector 0x%x", pdev->irq,
> +			IRQ0_VECTOR + pdev->irq);

Why evaluating vector first and then not using it for that debug print
thingy?

Btw, are you going to replace that DPRINT_* stuff as well ?

Thanks,

	tglx
