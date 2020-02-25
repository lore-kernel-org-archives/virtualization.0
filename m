From: David Hildenbrand <david@redhat.com>
Subject: Re: [PATCH RFC v4 08/13] mm/memory_hotplug: Introduce
 offline_and_remove_memory()
Date: Tue, 25 Feb 2020 15:27:28 +0100
Message-ID: <d1dbb687-7959-f4f1-6a64-33ee039782ef@redhat.com>
References: <20191212171137.13872-1-david@redhat.com>
 <20191212171137.13872-9-david@redhat.com>
 <20200225141134.GU22443@dhcp22.suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <20200225141134.GU22443@dhcp22.suse.cz>
Content-Language: en-US
Sender: kvm-owner@vger.kernel.org
To: Michal Hocko <mhocko@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org, virtio-dev@lists.oasis-open.org, virtualization@lists.linux-foundation.org, kvm@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>, "Michael S . Tsirkin" <mst@redhat.com>, Oscar Salvador <osalvador@suse.com>, Pavel Tatashin <pasha.tatashin@soleen.com>, Wei Yang <richard.weiyang@gmail.com>, Dan Williams <dan.j.williams@intel.com>, Qian Cai <cai@lca.pw>
List-Id: virtualization@lists.linuxfoundation.org

On 25.02.20 15:11, Michal Hocko wrote:
> On Thu 12-12-19 18:11:32, David Hildenbrand wrote:
>> virtio-mem wants to offline and remove a memory block once it unplugge=
d
>> all subblocks (e.g., using alloc_contig_range()). Let's provide
>> an interface to do that from a driver. virtio-mem already supports to
>> offline partially unplugged memory blocks. Offlining a fully unplugged
>> memory block will not require to migrate any pages. All unplugged
>> subblocks are PageOffline() and have a reference count of 0 - so
>> offlining code will simply skip them.
>>
>> All we need an interface to trigger the "offlining" and the removing i=
n a
>> single operation - to make sure the memory block cannot get onlined by
>> user space again before it gets removed.
>=20
> Why does that matter? Is it really likely that the userspace would
> interfere? What would be the scenario?

I guess it's not that relevant after all (I think this comment dates
back to the times where we didn't have try_remove_memory() and could
actually BUG_ON() in remove_memory() if there would have been a race).
Can drop that part.

>=20
> Or is still mostly about not requiring callers to open code this genera=
l
> patter?

From kernel module context, I cannot get access to the actual memory
block device (find_memory_block()) and call the device_unregister().

Especially, also the device hotplug lock is not exported. So this is a
clean helper function to be used from kernel module context. (e.g., also
hyper-v showed interest for using that)

--=20
Thanks,

David / dhildenb
