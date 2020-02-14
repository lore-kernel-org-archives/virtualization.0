From: David Hildenbrand <david@redhat.com>
Subject: Re: [PATCH v1 3/3] virtio-balloon: Switch back to OOM handler for
 VIRTIO_BALLOON_F_DEFLATE_ON_OOM
Date: Fri, 14 Feb 2020 15:18:55 +0100
Message-ID: <802f93b1-1588-bd2c-8238-c12ec7f7ae9e@redhat.com>
References: <20200205163402.42627-1-david@redhat.com>
 <20200205163402.42627-4-david@redhat.com>
 <20200214140641.GB31689@dhcp22.suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20200214140641.GB31689@dhcp22.suse.cz>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Michal Hocko <mhocko@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org, virtualization@lists.linux-foundation.org, Tyler Sanderson <tysand@google.com>, "Michael S . Tsirkin" <mst@redhat.com>, Wei Wang <wei.w.wang@intel.com>, Alexander Duyck <alexander.h.duyck@linux.intel.com>, David Rientjes <rientjes@google.com>, Nadav Amit <namit@vmware.com>
List-Id: virtualization@lists.linuxfoundation.org

>> There was a report that this results in undesired side effects when
>> inflating the balloon to shrink the page cache. [1]
>> 	"When inflating the balloon against page cache (i.e. no free memory
>> 	 remains) vmscan.c will both shrink page cache, but also invoke the
>> 	 shrinkers -- including the balloon's shrinker. So the balloon
>> 	 driver allocates memory which requires reclaim, vmscan gets this
>> 	 memory by shrinking the balloon, and then the driver adds the
>> 	 memory back to the balloon. Basically a busy no-op."
>>
>> The name "deflate on OOM" makes it pretty clear when deflation should
>> happen - after other approaches to reclaim memory failed, not while
>> reclaiming. This allows to minimize the footprint of a guest - memory
>> will only be taken out of the balloon when really needed.
>>
>> Especially, a drop_slab() will result in the whole balloon getting
>> deflated - undesired.
>=20
> Could you explain why some more? drop_caches shouldn't be really used i=
n
> any production workloads and if somebody really wants all the cache to
> be dropped then why is balloon any different?
>=20

Deflation should happen when the guest is out of memory, not when
somebody thinks it's time to reclaim some memory. That's what the
feature promised from the beginning: Only give the guest more memory in
case it *really* needs more memory.

Deflate on oom, not deflate on reclaim/memory pressure. (that's what the
report was all about)

A priority for shrinkers might be a step into the right direction.

--=20
Thanks,

David / dhildenb
