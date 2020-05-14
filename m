From: David Hildenbrand <david@redhat.com>
Subject: Re: [PATCH v3 00/15] virtio-mem: paravirtualized memory
Date: Thu, 14 May 2020 13:10:40 +0200
Message-ID: <3c82e149-6c42-690e-9d58-bb8e69870fe0@redhat.com>
References: <20200507103119.11219-1-david@redhat.com>
 <7848642F-6AA7-4B5E-AE0E-DB0857C94A93@linux.alibaba.com>
 <31c5d2f9-c104-53e8-d9c8-cb45f7507c85@redhat.com>
 <A3BBAEEE-FBB9-4259-8BED-023CCD530021@linux.alibaba.com>
 <389b6bdc-b196-e4b9-b6be-dcac57524fdf@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <virtio-dev-return-7340-gcvd-virtio-dev=m.gmane-mx.org@lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
In-Reply-To: <389b6bdc-b196-e4b9-b6be-dcac57524fdf@redhat.com>
Content-Language: en-US
To: teawater <teawaterz@linux.alibaba.com>
Cc: LKML <linux-kernel@vger.kernel.org>, Linux MM <linux-mm@kvack.org>, virtio-dev@lists.oasis-open.org, Linux Virtualization <virtualization@lists.linux-foundation.org>, kvm@vger.kernel.org, Michal Hocko <mhocko@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, "Michael S . Tsirkin" <mst@redhat.com>, Sebastien Boeuf <sebastien.boeuf@intel.com>, Samuel Ortiz <samuel.ortiz@intel.com>, Robert Bradford <robert.bradford@intel.com>, Luiz Capitulino <lcapitulino@redhat.com>, Pankaj Gupta <pankaj.gupta.linux@gmail.com>, Igor Mammedov <imammedo@redhat.com>, "Dr . David Alan Gilbert" <dgilbert@redhat.com>, Alexander Duyck <alexander.h.duyck@linux.intel.com>, Alexander Potapenko <glider@google.com>, Anshuman Khandual <anshuman.khandual@arm.com>, Anthony Yznaga <anthony.yznaga@oracle.com>, Dan Williams <dan.j.williams@intel.com>, Dave Young <dyoung@redhat.com>Jason Wang <j>
List-Id: virtualization@lists.linuxfoundation.org

On 14.05.20 12:12, David Hildenbrand wrote:
> On 14.05.20 12:02, teawater wrote:
>>
>>
>>> 2020年5月14日 16:48，David Hildenbrand <david@redhat.com> 写道：
>>>
>>> On 14.05.20 08:44, teawater wrote:
>>>> Hi David,
>>>>
>>>> I got a kernel warning with v2 and v3.
>>>
>>> Hi Hui,
>>>
>>> thanks for playing with the latest versions. Surprisingly, I can
>>> reproduce even by hotplugging a DIMM instead as well - that's good, so
>>> it's not related to virtio-mem, lol. Seems to be some QEMU setup issue
>>> with older machine types.
>>>
>>> Can you switch to a newer qemu machine version, especially
>>> pc-i440fx-5.0? Both, hotplugging DIMMs and virtio-mem works for me with
>>> that QEMU machine just fine.
>>
>> I still could reproduce this issue with pc-i440fx-5.0 or pc.  Did I miss anything?
>>
> 
> Below I don't even see virtio_mem. I had to repair the image (filesystem
> fsck) because it was broken, can you try that as well?
> 
> Also, it would be great if you could test with v4.
> 

Correction, something seems to be broken either in QEMU or the kernel. Once I
define a DIMM so it's added and online during boot, I get these issues:

(I have virtio-mem v4 installed in the guest)

#! /bin/bash
sudo x86_64-softmmu/qemu-system-x86_64 \
    -machine pc-i440fx-5.0,accel=kvm,usb=off \
    -cpu host \
    -no-reboot \
    -nographic \
    -device ide-hd,drive=hd \
    -drive if=none,id=hd,file=/home/dhildenb/git/Fedora-Cloud-Base-31-1.9.x86_64.qcow2,format=qcow2 \
    -m 1g,slots=10,maxmem=2G \
    -smp 1 \
    -object memory-backend-ram,id=mem0,size=256m \
    -device pc-dimm,id=dimm0,memdev=mem0 \
    -s \
    -monitor unix:/var/tmp/monitor,server,nowait


Without the DIMM it seems to work just fine.

-- 
Thanks,

David / dhildenb
