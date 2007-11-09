From: Dor Laor <dor.laor-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH 3/3] virtio PCI device
Date: Fri, 09 Nov 2007 02:39:22 +0200
Message-ID: <4733AC3A.20701@qumranet.com>
References: <11944899922822-git-send-email-aliguori@us.ibm.com>	<11944900141678-git-send-email-aliguori@us.ibm.com>	<11944900152750-git-send-email-aliguori@us.ibm.com>
	<11944900163817-git-send-email-aliguori@us.ibm.com>
Reply-To: dor.laor-atKUWr5tajBWk0Htik3J/w@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <kvm-devel-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <11944900163817-git-send-email-aliguori-r/Jw6+rmf7HQT0dZR+AlfA@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/kvm-devel>,
	<mailto:kvm-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=kvm-devel>
List-Post: <mailto:kvm-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:kvm-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/kvm-devel>,
	<mailto:kvm-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Sender: kvm-devel-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: kvm-devel-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
To: Anthony Liguori <aliguori-r/Jw6+rmf7HQT0dZR+AlfA@public.gmane.org>
Cc: Rusty Russell <rusty-PBSTF//UHa40n/F98K4Iww@public.gmane.org>, virtualization-qjLDD68F18O7TbgM5vRIOg@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, kvm-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: virtualization@lists.linuxfoundation.org

Anthony Liguori wrote:
> This is a PCI device that implements a transport for virtio.  It allows virtio
> devices to be used by QEMU based VMMs like KVM or Xen.
>
> ....
>   
While it's a little premature, we can start thinking of irq path 
improvements.
The current patch acks a private isr and afterwards apic eoi will also 
be hit since its
a level trig irq. This means 2 vmexits per irq.
We can start with regular pci irqs and move afterwards to msi.
Some other ugly hack options [we're better use msi]:
    - Read the eoi directly from apic and save the first private isr ack
    - Convert the specific irq line to edge triggered and dont share it
What do you guys think?
> +/* A small wrapper to also acknowledge the interrupt when it's handled.
> + * I really need an EIO hook for the vring so I can ack the interrupt once we
> + * know that we'll be handling the IRQ but before we invoke the callback since
> + * the callback may notify the host which results in the host attempting to
> + * raise an interrupt that we would then mask once we acknowledged the
> + * interrupt. */
> +static irqreturn_t vp_interrupt(int irq, void *opaque)
> +{
> +	struct virtio_pci_device *vp_dev = opaque;
> +	struct virtio_pci_vq_info *info;
> +	irqreturn_t ret = IRQ_NONE;
> +	u8 isr;
> +
> +	/* reading the ISR has the effect of also clearing it so it's very
> +	 * important to save off the value. */
> +	isr = ioread8(vp_dev->ioaddr + VIRTIO_PCI_ISR);
> +
> +	/* It's definitely not us if the ISR was not high */
> +	if (!isr)
> +		return IRQ_NONE;
> +
> +	spin_lock(&vp_dev->lock);
> +	list_for_each_entry(info, &vp_dev->virtqueues, node) {
> +		if (vring_interrupt(irq, info->vq) == IRQ_HANDLED)
> +			ret = IRQ_HANDLED;
> +	}
> +	spin_unlock(&vp_dev->lock);
> +
> +	return ret;
> +}
>   


-------------------------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc.
Still grepping through log files to find problems?  Stop.
Now Search log events and configuration files using AJAX and a browser.
Download your FREE copy of Splunk now >> http://get.splunk.com/
