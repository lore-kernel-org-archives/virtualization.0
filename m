From: Wei Wang <wei.w.wang@intel.com>
Subject: Re: [PATCH v12 6/8] mm: support reporting free page blocks
Date: Wed, 26 Jul 2017 19:44:23 +0800
Message-ID: <59788097.6010402@intel.com>
References: <20170719081311.GC26779@dhcp22.suse.cz>
	<596F4A0E.4010507@intel.com>
	<20170724090042.GF25221@dhcp22.suse.cz>
	<59771010.6080108@intel.com>
	<20170725112513.GD26723@dhcp22.suse.cz>
	<597731E8.9040803@intel.com>
	<20170725124141.GF26723@dhcp22.suse.cz>
	<286AC319A985734F985F78AFA26841F739283F62@shsmsx102.ccr.corp.intel.com>
	<20170725145333.GK26723@dhcp22.suse.cz>
	<5977FCDF.7040606@intel.com> <20170726102458.GH2981@dhcp22.suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20170726102458.GH2981@dhcp22.suse.cz>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Michal Hocko <mhocko@kernel.org>
Cc: "aarcange@redhat.com" <aarcange@redhat.com>, "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>, "amit.shah@redhat.com" <amit.shah@redhat.com>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>, "Michael S. Tsirkin" <mst@redhat.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "liliang.opensource@gmail.com" <liliang.opensource@gmail.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "virtualization@lists.linux-foundation.org" <virtualization@lists.linux-foundation.org>, "linux-mm@kvack.org" <linux-mm@kvack.org>, "yang.zhang.wz@gmail.com" <yang.zhang.wz@gmail.com>, "quan.xu@aliyun.com" <quan.xu@aliyun.com>, "cornelia.huck@de.ibm.com" <cornelia.huck@de.ibm.com>, "pbonzini@redhat.com" <pbonzini@redhat.com>, "akpm@linux-foundation.org" <akpm@linux-foundation.org>, "mgorman@techsingularity.net" <mgorman@techsingularity.net>
List-Id: virtualization@lists.linuxfoundation.org

On 07/26/2017 06:24 PM, Michal Hocko wrote:
> On Wed 26-07-17 10:22:23, Wei Wang wrote:
>> On 07/25/2017 10:53 PM, Michal Hocko wrote:
>>> On Tue 25-07-17 14:47:16, Wang, Wei W wrote:
>>>> On Tuesday, July 25, 2017 8:42 PM, hal Hocko wrote:
>>>>> On Tue 25-07-17 19:56:24, Wei Wang wrote:
>>>>>> On 07/25/2017 07:25 PM, Michal Hocko wrote:
>>>>>>> On Tue 25-07-17 17:32:00, Wei Wang wrote:
>>>>>>>> On 07/24/2017 05:00 PM, Michal Hocko wrote:
>>>>>>>>> On Wed 19-07-17 20:01:18, Wei Wang wrote:
>>>>>>>>>> On 07/19/2017 04:13 PM, Michal Hocko wrote:
>>>>>>>>> [...
>>>>>> We don't need to do the pfn walk in the guest kernel. When the API
>>>>>> reports, for example, a 2MB free page block, the API caller offers to
>>>>>> the hypervisor the base address of the page block, and size=2MB, to
>>>>>> the hypervisor.
>>>>> So you want to skip pfn walks by regularly calling into the page allocator to
>>>>> update your bitmap. If that is the case then would an API that would allow you
>>>>> to update your bitmap via a callback be s sufficient? Something like
>>>>> 	void walk_free_mem(int node, int min_order,
>>>>> 			void (*visit)(unsigned long pfn, unsigned long nr_pages))
>>>>>
>>>>> The function will call the given callback for each free memory block on the given
>>>>> node starting from the given min_order. The callback will be strictly an atomic
>>>>> and very light context. You can update your bitmap from there.
>>>> I would need to introduce more about the background here:
>>>> The hypervisor and the guest live in their own address space. The hypervisor's bitmap
>>>> isn't seen by the guest. I think we also wouldn't be able to give a callback function
>>> >from the hypervisor to the guest in this case.
>>> How did you plan to use your original API which export struct page array
>>> then?
>>
>> That's where the virtio-balloon driver comes in. It uses a shared ring
>> mechanism to
>> send the guest memory info to the hypervisor.
>>
>> We didn't expose the struct page array from the guest to the hypervisor. For
>> example, when
>> a 2MB free page block is reported from the free page list, the info put on
>> the ring is just
>> (base address of the 2MB continuous memory, size=2M).
> So what exactly prevents virtio-balloon from using the above proposed
> callback mechanism and export what is needed to the hypervisor?

I thought about it more. Probably we can use the callback function with 
a little change like this:

void walk_free_mem(void *opaque1, void (*visit)(void *opaque2, unsigned 
long pfn,
            unsigned long nr_pages))
{
     ...
     for_each_populated_zone(zone) {
                    for_each_migratetype_order(order, type) {
                         report_unused_page_block(zone, order, type, 
&page); // from patch 6
                         pfn = page_to_pfn(page);
                         visit(opaque1, pfn, 1 << order);
                     }
     }
}

The above function scans all the free list and directly sends each free 
page block to the
hypervisor via the virtio_balloon callback below. No need to implement a 
bitmap.

In virtio-balloon, we have the callback:
void *virtio_balloon_report_unused_pages(void *opaque,  unsigned long pfn,
unsigned long nr_pages)
{
     struct virtio_balloon *vb = (struct virtio_balloon *)opaque;
     ...put the free page block to the the ring of vb;
}


What do you think?


Best,
Wei
