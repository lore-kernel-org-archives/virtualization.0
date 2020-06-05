From: Alex Shi <alex.shi@linux.alibaba.com>
Subject: Re: [PATCH RFC v4 00/13] virtio-mem: paravirtualized memory
Date: Fri, 5 Jun 2020 16:55:18 +0800
Message-ID: <1cfa9edb-47ea-1495-4e28-4cf391eab44c@linux.alibaba.com>
References: <20191212171137.13872-1-david@redhat.com>
 <9acc5d04-c8e9-ef53-85e4-709030997ca6@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <9acc5d04-c8e9-ef53-85e4-709030997ca6@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
To: David Hildenbrand <david@redhat.com>, linux-kernel@vger.kernel.org
Cc: linux-mm@kvack.org, virtio-dev@lists.oasis-open.org, virtualization@lists.linux-foundation.org, kvm@vger.kernel.org, Michal Hocko <mhocko@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, "Michael S . Tsirkin" <mst@redhat.com>, Sebastien Boeuf <sebastien.boeuf@intel.com>, Samuel Ortiz <samuel.ortiz@intel.com>, Robert Bradford <robert.bradford@intel.com>, Luiz Capitulino <lcapitulino@redhat.com>, Alexander Duyck <alexander.h.duyck@linux.intel.com>, Alexander Potapenko <glider@google.com>, Alexander Viro <viro@zeniv.linux.org.uk>, Anshuman Khandual <anshuman.khandual@arm.com>, Anthony Yznaga <anthony.yznaga@oracle.com>, Dan Williams <dan.j.williams@intel.com>, Dave Young <dyoung@redhat.com>, Igor Mammedov <imammedo@redhat.com>, Jason Wang <jasowa>
List-Id: virtualization@lists.linuxfoundation.org



在 2020/1/9 下午9:48, David Hildenbrand 写道:
> Ping,
> 
> I'd love to get some feedback on
> 
> a) The remaining MM bits from MM folks (especially, patch #6 and #8).
> b) The general virtio infrastructure (esp. uapi in patch #2) from virtio
> folks.
> 
> I'm planning to send a proper v1 (!RFC) once I have all necessary MM
> acks. In the meanwhile, I will do more testing and minor reworks (e.g.,
> fix !CONFIG_NUMA compilation).


Hi David,

Thanks for your work!

I am trying your https://github.com/davidhildenbrand/linux.git virtio-mem-v5
which works fine for me, but just a 'DMA error' happens when a vm start with
less than 2GB memory, Do I missed sth?

Thanks
Alex


(qemu) qom-set vm0 requested-size 1g
(qemu) [   26.560026] virtio_mem virtio0: plugged size: 0x0
[   26.560648] virtio_mem virtio0: requested size: 0x40000000
[   26.561730] systemd-journald[167]: no db file to read /run/udev/data/+virtio:virtio0: No such file or directory
[   26.563138] systemd-journald[167]: no db file to read /run/udev/data/+virtio:virtio0: No such file or directory
[   26.569122] Built 1 zonelists, mobility grouping on.  Total pages: 513141
[   26.570039] Policy zone: Normal

(qemu) [   32.175838] e1000 0000:00:03.0: swiotlb buffer is full (sz: 81 bytes), total 0 (slots), used 0 (slots)
[   32.176922] e1000 0000:00:03.0: TX DMA map failed
[   32.177488] e1000 0000:00:03.0: swiotlb buffer is full (sz: 81 bytes), total 0 (slots), used 0 (slots)
[   32.178535] e1000 0000:00:03.0: TX DMA map failed

my qemu command is like this:
qemu-system-x86_64  --enable-kvm \
	-m 2G,maxmem=16G -kernel /root/linux-next/$1/arch/x86/boot/bzImage \
	-smp 4 \
	-append "earlyprintk=ttyS0 root=/dev/sda1 console=ttyS0 debug psi=1 nokaslr ignore_loglevel" \
	-hda /root/CentOS-7-x86_64-Azure-1703.qcow2 \
	-net user,hostfwd=tcp::2222-:22 -net nic -s \
  -object memory-backend-ram,id=mem0,size=3G \
  -device virtio-mem-pci,id=vm0,memdev=mem0,node=0,requested-size=0M \
	--nographic
