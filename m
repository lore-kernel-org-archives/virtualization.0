From: David Hildenbrand <david@redhat.com>
Subject: Re: [PATCH RFC v4 00/13] virtio-mem: paravirtualized memory
Date: Fri, 5 Jun 2020 11:08:43 +0200
Message-ID: <d6cd1870-1012-cb3d-7d29-8e5ad2703717@redhat.com>
References: <20191212171137.13872-1-david@redhat.com>
 <9acc5d04-c8e9-ef53-85e4-709030997ca6@redhat.com>
 <1cfa9edb-47ea-1495-4e28-4cf391eab44c@linux.alibaba.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <virtio-dev-return-7440-gcvd-virtio-dev=m.gmane-mx.org@lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
In-Reply-To: <1cfa9edb-47ea-1495-4e28-4cf391eab44c@linux.alibaba.com>
Content-Language: en-US
To: Alex Shi <alex.shi@linux.alibaba.com>, linux-kernel@vger.kernel.org
Cc: linux-mm@kvack.org, virtio-dev@lists.oasis-open.org, virtualization@lists.linux-foundation.org, kvm@vger.kernel.org, Michal Hocko <mhocko@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, "Michael S . Tsirkin" <mst@redhat.com>, Sebastien Boeuf <sebastien.boeuf@intel.com>, Samuel Ortiz <samuel.ortiz@intel.com>, Robert Bradford <robert.bradford@intel.com>, Luiz Capitulino <lcapitulino@redhat.com>, Alexander Duyck <alexander.h.duyck@linux.intel.com>, Alexander Potapenko <glider@google.com>, Alexander Viro <viro@zeniv.linux.org.uk>, Anshuman Khandual <anshuman.khandual@arm.com>, Anthony Yznaga <anthony.yznaga@oracle.com>, Dan Williams <dan.j.williams@intel.com>, Dave Young <dyoung@redhat.com>, Igor Mammedov <imammedo@redhat.com>, Jason Wang <jasowang@redhat.com>, Johannes Weiner <hannes@cmpxchg.org>, Juergen Gross <jgross@suse.com>, Konrad Rzeszutek Wilk <konrad.wil>
List-Id: virtualization@lists.linuxfoundation.org

On 05.06.20 10:55, Alex Shi wrote:
> 
> 
> 在 2020/1/9 下午9:48, David Hildenbrand 写道:
>> Ping,
>>
>> I'd love to get some feedback on
>>
>> a) The remaining MM bits from MM folks (especially, patch #6 and #8).
>> b) The general virtio infrastructure (esp. uapi in patch #2) from virtio
>> folks.
>>
>> I'm planning to send a proper v1 (!RFC) once I have all necessary MM
>> acks. In the meanwhile, I will do more testing and minor reworks (e.g.,
>> fix !CONFIG_NUMA compilation).
> 
> 
> Hi David,
> 
> Thanks for your work!
> 
> I am trying your https://github.com/davidhildenbrand/linux.git virtio-mem-v5
> which works fine for me, but just a 'DMA error' happens when a vm start with
> less than 2GB memory, Do I missed sth?

Please use the virtio-mem-v4 branch for now, v5 is still under
construction (and might be scrapped completely if v4 goes upstream as is).

Looks like a DMA issue. Your're hotplugging 1GB, which should not really
eat too much memory. There was a similar issue reported by Hui in [1],
which boiled down to wrong usage of the swiotlb parameter.

In such cases you should always try to reproduce with hotplug of a
sam-sized DIMM. E.g., hotplugging a 1GB DIMM should result in the same
issue.

What does your .config specify for CONFIG_MEMORY_HOTPLUG_DEFAULT_ONLINE?

I'll try to reproduce with v4 briefly.

[1]
https://lkml.kernel.org/r/9708F43A-9BD2-4377-8EE8-7FB1D95C6F69@linux.alibaba.com

> 
> Thanks
> Alex
> 
> 
> (qemu) qom-set vm0 requested-size 1g
> (qemu) [   26.560026] virtio_mem virtio0: plugged size: 0x0
> [   26.560648] virtio_mem virtio0: requested size: 0x40000000
> [   26.561730] systemd-journald[167]: no db file to read /run/udev/data/+virtio:virtio0: No such file or directory
> [   26.563138] systemd-journald[167]: no db file to read /run/udev/data/+virtio:virtio0: No such file or directory
> [   26.569122] Built 1 zonelists, mobility grouping on.  Total pages: 513141
> [   26.570039] Policy zone: Normal
> 
> (qemu) [   32.175838] e1000 0000:00:03.0: swiotlb buffer is full (sz: 81 bytes), total 0 (slots), used 0 (slots)
> [   32.176922] e1000 0000:00:03.0: TX DMA map failed
> [   32.177488] e1000 0000:00:03.0: swiotlb buffer is full (sz: 81 bytes), total 0 (slots), used 0 (slots)
> [   32.178535] e1000 0000:00:03.0: TX DMA map failed
> 
> my qemu command is like this:
> qemu-system-x86_64  --enable-kvm \
> 	-m 2G,maxmem=16G -kernel /root/linux-next/$1/arch/x86/boot/bzImage \
> 	-smp 4 \
> 	-append "earlyprintk=ttyS0 root=/dev/sda1 console=ttyS0 debug psi=1 nokaslr ignore_loglevel" \
> 	-hda /root/CentOS-7-x86_64-Azure-1703.qcow2 \
> 	-net user,hostfwd=tcp::2222-:22 -net nic -s \
>   -object memory-backend-ram,id=mem0,size=3G \
>   -device virtio-mem-pci,id=vm0,memdev=mem0,node=0,requested-size=0M \
> 	--nographic
> 
> 


-- 
Thanks,

David / dhildenb
