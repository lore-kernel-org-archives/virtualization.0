From: Anthony Liguori <aliguori-r/Jw6+rmf7HQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH 3/3] virtio PCI device
Date: Thu, 08 Nov 2007 09:06:19 -0600
Message-ID: <473325EB.5090907@us.ibm.com>
References: <11944899922822-git-send-email-aliguori@us.ibm.com>	<11944900141678-git-send-email-aliguori@us.ibm.com>	<11944900152750-git-send-email-aliguori@us.ibm.com>
	<11944900163817-git-send-email-aliguori@us.ibm.com>
	<4732A8E5.6090307@qumranet.com> <47331531.8070709@us.ibm.com>
	<47331F47.70304@qumranet.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <kvm-devel-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <47331F47.70304-atKUWr5tajBWk0Htik3J/w@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/kvm-devel>,
	<mailto:kvm-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=kvm-devel>
List-Post: <mailto:kvm-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:kvm-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/kvm-devel>,
	<mailto:kvm-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Sender: kvm-devel-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: kvm-devel-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
To: Avi Kivity <avi-atKUWr5tajBWk0Htik3J/w@public.gmane.org>
Cc: Rusty Russell <rusty-PBSTF//UHa40n/F98K4Iww@public.gmane.org>, virtualization-qjLDD68F18O7TbgM5vRIOg@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, kvm-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: virtualization@lists.linuxfoundation.org

Avi Kivity wrote:
> If a pci device is capable of dma (or issuing interrupts), it will be 
> useless with pv pci.

Hrm, I think we may be talking about different things.  Are you thinking 
that the driver I posted allows you to do PCI pass-through over virtio?  
That's not what it is.

The driver I posted is a virtio implementation that uses a PCI device.  
This lets you use virtio-blk and virtio-net under KVM.  The alternative 
to this virtio PCI device would be a virtio transport built with 
hypercalls like lguest has.  I choose a PCI device because it ensured 
that each virtio device showed up like a normal PCI device.

Am I misunderstanding what you're asking about?

Regards,

Anthony Liguori

>
>>>  I think that with Amit's pvdma patches you
>>> can support dma-capable devices as well without too much fuss.
>>>   
>>
>> What is the use case you're thinking of?  A semi-paravirt driver that 
>> does dma directly to a device?
>
> No, an unmodified driver that, by using clever tricks with dma_ops, 
> can do dma directly to guest memory.  See Amit's patches.
>
> In fact, why do a virtio transport at all?  It can be done either with 
> trap'n'emulate, or by directly mapping the device mmio space into the 
> guest.
>
>
> (what use case are you considering? devices without interrupts and 
> dma? pci door stoppers?)
>


-------------------------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc.
Still grepping through log files to find problems?  Stop.
Now Search log events and configuration files using AJAX and a browser.
Download your FREE copy of Splunk now >> http://get.splunk.com/
