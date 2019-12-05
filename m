From: David Hildenbrand <david@redhat.com>
Subject: Re: [PATCH] virtio-balloon: fix managed page counts when migrating
 pages between zones
Date: Thu, 5 Dec 2019 11:13:11 +0100
Message-ID: <940e5d03-dc20-da0b-17e0-6f11cf480ec6__34306.343917136$1575540815$gmane$org@redhat.com>
References: <20191204204807.8025-1-david@redhat.com>
 <20191205110823.6479c3b2@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20191205110823.6479c3b2@redhat.com>
Content-Language: en-US
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
 <mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
 <mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>
To: Igor Mammedov <imammedo@redhat.com>
Cc: Yumei Huang <yuhuang@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, linux-kernel@vger.kernel.org, stable@vger.kernel.org, virtualization@lists.linux-foundation.org, linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>, Jiang Liu <liuj97@gmail.com>
List-Id: virtualization@lists.linuxfoundation.org

On 05.12.19 11:08, Igor Mammedov wrote:
> On Wed,  4 Dec 2019 21:48:07 +0100
> David Hildenbrand <david@redhat.com> wrote:
> 
>> In case we have to migrate a ballon page to a newpage of another zone, the
>> managed page count of both zones is wrong. Paired with memory offlining
>> (which will adjust the managed page count), we can trigger kernel crashes
>> and all kinds of different symptoms.
>>
>> One way to reproduce:
>> 1. Start a QEMU guest with 4GB, no NUMA
>> 2. Hotplug a 1GB DIMM and only the memory to ZONE_NORMAL
>                             ^^^^
> should it be "online" ?

Very right!
[...]

>>  	mutex_unlock(&vb->balloon_lock);
>>  
>> +	/* fixup the managed page count (esp. of the zone) */
>> +	if (!virtio_has_feature(vb->vdev, VIRTIO_BALLOON_F_DEFLATE_ON_OOM)) {
> what happens when balloon has the feature?

With that feature we don't touch the managed page counts at all (see the
other 2 adjust_managed_page_count() callers in this file).

> 
>> +		adjust_managed_page_count(page, 1);
>> +		adjust_managed_page_count(newpage, -1);
>> +	}
>> +
>>  	put_page(page); /* balloon reference */
>>  
>>  	return MIGRATEPAGE_SUCCESS;
> 

BTW, I posted a v2 just some minutes ago
(https://lkml.kernel.org/r/20191205092420.6934-1-david@redhat.com)

Thanks!

-- 
Thanks,

David / dhildenb
