From: Anthony Liguori <aliguori-r/Jw6+rmf7HQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH 3/3] virtio PCI device
Date: Thu, 08 Nov 2007 13:04:38 -0600
Message-ID: <47335DC6.7090603@us.ibm.com>
References: <11944899922822-git-send-email-aliguori@us.ibm.com>
	<11944900152750-git-send-email-aliguori@us.ibm.com>
	<11944900163817-git-send-email-aliguori@us.ibm.com>
	<200711081846.36821.arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <kvm-devel-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <200711081846.36821.arnd-r2nGTMty4D4@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/kvm-devel>,
	<mailto:kvm-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=kvm-devel>
List-Post: <mailto:kvm-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:kvm-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/kvm-devel>,
	<mailto:kvm-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Sender: kvm-devel-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: kvm-devel-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
To: Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>
Cc: kvm-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, virtualization-qjLDD68F18O7TbgM5vRIOg@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: virtualization@lists.linuxfoundation.org

Arnd Bergmann wrote:
> On Thursday 08 November 2007, Anthony Liguori wrote:
>   
>> +/* A PCI device has it's own struct device and so does a virtio device so
>> + * we create a place for the virtio devices to show up in sysfs.  I think it
>> + * would make more sense for virtio to not insist on having it's own device. */
>> +static struct device virtio_pci_root = {
>> +       .parent         = NULL,
>> +       .bus_id         = "virtio-pci",
>> +};
>> +
>> +/* Unique numbering for devices under the kvm root */
>> +static unsigned int dev_index;
>> +
>>     
>
> ...
>
>   
>> +/* the PCI probing function */
>> +static int __devinit virtio_pci_probe(struct pci_dev *pci_dev,
>> +                                     const struct pci_device_id *id)
>> +{
>> +       struct virtio_pci_device *vp_dev;
>> +       int err;
>> +
>> +       /* allocate our structure and fill it out */
>> +       vp_dev = kzalloc(sizeof(struct virtio_pci_device), GFP_KERNEL);
>> +       if (vp_dev == NULL)
>> +               return -ENOMEM;
>> +
>> +       vp_dev->pci_dev = pci_dev;
>> +       vp_dev->vdev.dev.parent = &virtio_pci_root;
>>     
>
> If you use 
>
> 	vp_dev->vdev.dev.parent = &pci_dev->dev;
>
> Then there is no need for the special kvm root device, and the actual
> virtio device shows up in a more logical place, under where it is
> really (virtually) attached.
>   

They already show up underneath of the PCI bus.  The issue is that there 
are two separate 'struct device's for each virtio device.  There's the 
PCI device (that's part of the pci_dev structure) and then there's the 
virtio_device one.  I thought that setting the dev.parent of the 
virtio_device struct device would result in having two separate entries 
under the PCI bus directory which would be pretty confusing :-)

Regards,

Anthony Liguori

> 	Arnd <><
>   


-------------------------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc.
Still grepping through log files to find problems?  Stop.
Now Search log events and configuration files using AJAX and a browser.
Download your FREE copy of Splunk now >> http://get.splunk.com/
