From: David Hildenbrand <david@redhat.com>
Subject: Re: [PATCH RFC v4 00/13] virtio-mem: paravirtualized memory
Date: Fri, 5 Jun 2020 14:18:28 +0200
Message-ID: <b41dcc92-604e-0c48-92e5-5cb3d78f189e@redhat.com>
References: <20191212171137.13872-1-david@redhat.com>
 <9acc5d04-c8e9-ef53-85e4-709030997ca6@redhat.com>
 <1cfa9edb-47ea-1495-4e28-4cf391eab44c@linux.alibaba.com>
 <d6cd1870-1012-cb3d-7d29-8e5ad2703717@redhat.com>
 <6b4724bf-84b5-9880-5464-1908425d106d@redhat.com>
 <e1643897-ebd7-75f8-d271-44f62318aa66@redhat.com>
 <95c6ef21-23e0-c768-999d-3af7f69d02d3@linux.alibaba.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <95c6ef21-23e0-c768-999d-3af7f69d02d3@linux.alibaba.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Alex Shi <alex.shi@linux.alibaba.com>, linux-kernel@vger.kernel.org
Cc: linux-mm@kvack.org, virtio-dev@lists.oasis-open.org, virtualization@lists.linux-foundation.org, kvm@vger.kernel.org, Michal Hocko <mhocko@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, "Michael S . Tsirkin" <mst@redhat.com>, Sebastien Boeuf <sebastien.boeuf@intel.com>, Samuel Ortiz <samuel.ortiz@intel.com>, Robert Bradford <robert.bradford@intel.com>, Luiz Capitulino <lcapitulino@redhat.com>, Alexander Duyck <alexander.h.duyck@linux.intel.com>, Alexander Potapenko <glider@google.com>, Alexander Viro <viro@zeniv.linux.org.uk>, Anshuman Khandual <anshuman.khandual@arm.com>, Anthony Yznaga <anthony.yznaga@oracle.com>, Dan Williams <dan.j.williams@intel.com>, Dave Young <dyoung@redhat.com>, Igor Mammedov <imammedo@redhat.com>, Jason Wang <jasowa>
List-Id: virtualization@lists.linuxfoundation.org

On 05.06.20 12:46, Alex Shi wrote:
> 
> 
> 在 2020/6/5 下午6:05, David Hildenbrand 写道:
>>> I guess I know what's happening here. In case we only have DMA memory
>>> when booting, we don't reserve swiotlb buffers. Once we hotplug memory
>>> and online ZONE_NORMAL, we don't have any swiotlb DMA bounce buffers to
>>> map such PFNs (total 0 (slots), used 0 (slots)).
>>>
>>> Can you try with "swiotlb=force" on the kernel cmdline?
>> Alternative, looks like you can specify "-m 2G,maxmem=16G,slots=1", to
>> create proper ACPI tables that indicate hotpluggable memory. (I'll have
>> to look into QEMU to figure out to always indicate hotpluggable memory
>> that way).
>>
> 
> 
> That works too. Yes, better resolved in qemu, maybe. :)
> 

You can checkout

git@github.com:davidhildenbrand/qemu.git virtio-mem-v4

(prone to change before officially sent), which will create srat tables
also if no "slots" parameter was defined (and no -numa config was
specified).

Your original example should work with that.

-- 
Thanks,

David / dhildenb
