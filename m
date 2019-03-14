From: Dongli Zhang <dongli.zhang@oracle.com>
Subject: Re: virtio-blk: should num_vqs be limited by num_possible_cpus()?
Date: Thu, 14 Mar 2019 23:36:16 +0800
Message-ID: <7a1e3b7a-1df5-2f4a-3f41-a6342102b882@oracle.com>
References: <e4afe4c5-0262-4500-aeec-60f30734b4fc@default>
	<20190314082926-mutt-send-email-mst@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20190314082926-mutt-send-email-mst@kernel.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: linux-block@vger.kernel.org, axboe@kernel.dk, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org



On 03/14/2019 08:32 PM, Michael S. Tsirkin wrote:
> On Tue, Mar 12, 2019 at 10:22:46AM -0700, Dongli Zhang wrote:
>> I observed that there is one msix vector for config and one shared vector
>> for all queues in below qemu cmdline, when the num-queues for virtio-blk
>> is more than the number of possible cpus:
>>
>> qemu: "-smp 4" while "-device virtio-blk-pci,drive=drive-0,id=virtblk0,num-queues=6"
> 
> So why do this?

I observed this when I was testing virtio-blk and block layer.

I just assign a very large 'num-queues' to virtio-blk and keep changing the
number of vcpu in order to study blk-mq.

The num-queues for nvme (qemu) is by default 64, while it is 1 for virtio-blk.

> 
>> # cat /proc/interrupts 
>>            CPU0       CPU1       CPU2       CPU3
>> ... ...
>>  24:          0          0          0          0   PCI-MSI 65536-edge      virtio0-config
>>  25:          0          0          0         59   PCI-MSI 65537-edge      virtio0-virtqueues
>> ... ...
>>
>>
>> However, when num-queues is the same as number of possible cpus:
>>
>> qemu: "-smp 4" while "-device virtio-blk-pci,drive=drive-0,id=virtblk0,num-queues=4"
>>
>> # cat /proc/interrupts 
>>            CPU0       CPU1       CPU2       CPU3
>> ... ... 
>>  24:          0          0          0          0   PCI-MSI 65536-edge      virtio0-config
>>  25:          2          0          0          0   PCI-MSI 65537-edge      virtio0-req.0
>>  26:          0         35          0          0   PCI-MSI 65538-edge      virtio0-req.1
>>  27:          0          0         32          0   PCI-MSI 65539-edge      virtio0-req.2
>>  28:          0          0          0          0   PCI-MSI 65540-edge      virtio0-req.3
>> ... ...
>>
>> In above case, there is one msix vector per queue.
>>
>>
>> This is because the max number of queues is not limited by the number of
>> possible cpus.
>>
>> By default, nvme (regardless about write_queues and poll_queues) and
>> xen-blkfront limit the number of queues with num_possible_cpus().
>>
>>
>> Is this by design on purpose, or can we fix with below?
>>
>>
>> diff --git a/drivers/block/virtio_blk.c b/drivers/block/virtio_blk.c
>> index 4bc083b..df95ce3 100644
>> --- a/drivers/block/virtio_blk.c
>> +++ b/drivers/block/virtio_blk.c
>> @@ -513,6 +513,8 @@ static int init_vq(struct virtio_blk *vblk)
>>  	if (err)
>>  		num_vqs = 1;
>>  
>> +	num_vqs = min(num_possible_cpus(), num_vqs);
>> +
>>  	vblk->vqs = kmalloc_array(num_vqs, sizeof(*vblk->vqs), GFP_KERNEL);
>>  	if (!vblk->vqs)
>>  		return -ENOMEM;
>> --
>>
>>
>> PS: The same issue is applicable to virtio-scsi as well.
>>
>> Thank you very much!
>>
>> Dongli Zhang
> 
> I don't think this will address the issue if there's vcpu hotplug though.
> Because it's not about num_possible_cpus it's about the # of active VCPUs,
> right? Does block hangle CPU hotplug generally?
> We could maybe address that by switching vq to msi vector mapping in
> a cpu hotplug notifier...
> 

It looks it is about num_possible_cpus/nr_cpu_ids for cpu hotplug.


For instance, below is when only 2 out of 6 cpus are initialized while
virtio-blk has 6 queues.

"-smp 2,maxcpus=6" and "-device
virtio-blk-pci,drive=drive0,id=disk0,num-queues=6,iothread=io1"

# cat /sys/devices/system/cpu/present
0-1
# cat /sys/devices/system/cpu/possible
0-5
# cat /proc/interrupts  | grep virtio
 24:          0          0   PCI-MSI 65536-edge      virtio0-config
 25:       1864          0   PCI-MSI 65537-edge      virtio0-req.0
 26:          0       1069   PCI-MSI 65538-edge      virtio0-req.1
 27:          0          0   PCI-MSI 65539-edge      virtio0-req.2
 28:          0          0   PCI-MSI 65540-edge      virtio0-req.3
 29:          0          0   PCI-MSI 65541-edge      virtio0-req.4
 30:          0          0   PCI-MSI 65542-edge      virtio0-req.5

6 + 1 irqs are assigned even 4 out of 6 cpus are still offline.


Below is about the nvme emulated by qemu. While 2 out of 6 cpus are initial
assigned, nvme has 64 queues by default.

"-smp 2,maxcpus=6" and "-device nvme,drive=drive1,serial=deadbeaf1"

# cat /sys/devices/system/cpu/present
0-1
# cat /sys/devices/system/cpu/possible
0-5
# cat /proc/interrupts | grep nvme
 31:          0         16   PCI-MSI 81920-edge      nvme0q0
 32:         35          0   PCI-MSI 81921-edge      nvme0q1
 33:          0         42   PCI-MSI 81922-edge      nvme0q2
 34:          0          0   PCI-MSI 81923-edge      nvme0q3
 35:          0          0   PCI-MSI 81924-edge      nvme0q4
 36:          0          0   PCI-MSI 81925-edge      nvme0q5
 37:          0          0   PCI-MSI 81926-edge      nvme0q6

6 io queues are assigned with irq, although only 2 cpus are online.


When only 2 out of 48 cpus are online, there are 48 hctx created by block layer.

"-smp 2,maxcpus=48" and "-device
virtio-blk-pci,drive=drive0,id=disk0,num-queues=48,iothread=io1"

# ls /sys/kernel/debug/block/vda/ | grep hctx | wc -l
48


The above indicates the number of hw queues/irq is related to
num_possible_cpus/nr_cpu_ids.

Dongli Zhang
