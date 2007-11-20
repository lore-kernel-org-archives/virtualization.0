From: Anthony Liguori <aliguori-r/Jw6+rmf7HQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH 3/3] virtio PCI device
Date: Tue, 20 Nov 2007 16:16:43 -0600
Message-ID: <47435CCB.1050506@us.ibm.com>
References: <11944899922822-git-send-email-aliguori@us.ibm.com>	<11944900141678-git-send-email-aliguori@us.ibm.com>	<11944900152750-git-send-email-aliguori@us.ibm.com>	<11944900163817-git-send-email-aliguori@us.ibm.com>	<4742F6B7.20503@qumranet.com>
	<474300AD.4060509@us.ibm.com> <4743076F.8000105@qumranet.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <kvm-devel-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <4743076F.8000105-atKUWr5tajBWk0Htik3J/w@public.gmane.org>
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
Cc: kvm-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, virtualization-qjLDD68F18O7TbgM5vRIOg@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Eric Van Hensbergen <ericvanhensbergen-r/Jw6+rmf7HQT0dZR+AlfA@public.gmane.org>
List-Id: virtualization@lists.linuxfoundation.org

Avi Kivity wrote:
> Anthony Liguori wrote:
>> Avi Kivity wrote:
>>  
>>> Anthony Liguori wrote:
>>>    
>>>> This is a PCI device that implements a transport for virtio.  It 
>>>> allows virtio
>>>> devices to be used by QEMU based VMMs like KVM or Xen.
>>>>
>>>> +
>>>> +/* the notify function used when creating a virt queue */
>>>> +static void vp_notify(struct virtqueue *vq)
>>>> +{
>>>> +    struct virtio_pci_device *vp_dev = to_vp_device(vq->vdev);
>>>> +    struct virtio_pci_vq_info *info = vq->priv;
>>>> +
>>>> +    /* we write the queue's selector into the notification 
>>>> register to
>>>> +     * signal the other end */
>>>> +    iowrite16(info->queue_index, vp_dev->ioaddr + 
>>>> VIRTIO_PCI_QUEUE_NOTIFY);
>>>> +}
>>>>         
>>> This means we can't kick multiple queues with one exit.
>>>     
>>
>> There is no interface in virtio currently to batch multiple queue 
>> notifications so the only way one could do this AFAICT is to use a 
>> timer to delay the notifications.  Were you thinking of something else?
>>
>>   
>
> No.  We can change virtio though, so let's have a flexible ABI.

Well please propose the virtio API first and then I'll adjust the PCI 
ABI.  I don't want to build things into the ABI that we never actually 
end up using in virtio :-)

>>> I'd also like to see a hypercall-capable version of this (but that 
>>> can wait).
>>>     
>>
>> That can be a different device.
>>   
>
> That means the user has to select which device to expose.  With 
> feature bits, the hypervisor advertises both pio and hypercalls, the 
> guest picks whatever it wants.

I was thinking more along the lines that a hypercall-based device would 
certainly be implemented in-kernel whereas the current device is 
naturally implemented in userspace.  We can simply use a different 
device for in-kernel drivers than for userspace drivers.  There's no 
point at all in doing a hypercall based userspace device IMHO.

>> I don't think so.  A vmexit is required to lower the IRQ line.  It 
>> may be possible to do something clever like set a shared memory value 
>> that's checked on every vmexit.  I think it's very unlikely that it's 
>> worth it though.
>>   
>
> Why so unlikely?  Not all workloads will have good batching.

It's pretty invasive.  I think a more paravirt device that expected an 
edge triggered interrupt would be a better solution for those types of 
devices.
 
>>>> +    return ret;
>>>> +}
>>>> +
>>>> +/* the config->find_vq() implementation */
>>>> +static struct virtqueue *vp_find_vq(struct virtio_device *vdev, 
>>>> unsigned index,
>>>> +                    bool (*callback)(struct virtqueue *vq))
>>>> +{
>>>> +    struct virtio_pci_device *vp_dev = to_vp_device(vdev);
>>>> +    struct virtio_pci_vq_info *info;
>>>> +    struct virtqueue *vq;
>>>> +    int err;
>>>> +    u16 num;
>>>> +
>>>> +    /* Select the queue we're interested in */
>>>> +    iowrite16(index, vp_dev->ioaddr + VIRTIO_PCI_QUEUE_SEL);
>>>>         
>>> I would really like to see this implemented as pci config space, 
>>> with no tricks like multiplexing several virtqueues on one register. 
>>> Something like the PCI BARs where you have all the register numbers 
>>> allocated statically to queues.
>>>     
>>
>> My first implementation did that.  I switched to using a selector 
>> because it reduces the amount of PCI config space used and does not 
>> limit the number of queues defined by the ABI as much.
>>   
>
> But... it's tricky, and it's nonstandard.  With pci config, you can do 
> live migration by shipping the pci config space to the other side.  
> With the special iospace, you need to encode/decode it.

None of the PCI devices currently work like that in QEMU.  It would be 
very hard to make a device that worked this way because since the order 
in which values are written matter a whole lot.  For instance, if you 
wrote the status register before the queue information, the driver could 
get into a funky state.

We'll still need save/restore routines for virtio devices.  I don't 
really see this as a problem since we do this for every other device.

> Not much of an argument, I know.
>
>
> wrt. number of queues, 8 queues will consume 32 bytes of pci space if 
> all you store is the ring pfn.

You also at least need a num argument which takes you to 48 or 64 
depending on whether you care about strange formatting.  8 queues may 
not be enough either.  Eric and I have discussed whether the 9p virtio 
device should support multiple mounts per-virtio device and if so, 
whether each one should have it's own queue.  Any devices that supports 
this sort of multiplexing will very quickly start using a lot of queues.

I think most types of hardware have some notion of a selector or mode.  
Take a look at the LSI adapter or even VGA.

Regards,

Anthony Liguori


-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2005.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
