From: David Hildenbrand <david@redhat.com>
Subject: Re: [PATCH RFC v4 12/13] mm/vmscan: Export drop_slab() and
 drop_slab_node()
Date: Tue, 25 Feb 2020 16:09:29 +0100
Message-ID: <afdf8600-2339-6d74-5e3d-fa1a23384318@redhat.com>
References: <20191212171137.13872-1-david@redhat.com>
 <20191212171137.13872-13-david@redhat.com>
 <20200225145829.GW22443@dhcp22.suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable
Return-path: <virtio-dev-return-6778-gcvd-virtio-dev=m.gmane-mx.org@lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
In-Reply-To: <20200225145829.GW22443@dhcp22.suse.cz>
Content-Language: en-US
To: Michal Hocko <mhocko@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org, virtio-dev@lists.oasis-open.org, virtualization@lists.linux-foundation.org, kvm@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>, "Michael S . Tsirkin" <mst@redhat.com>
List-Id: virtualization@lists.linuxfoundation.org

On 25.02.20 15:58, Michal Hocko wrote:
> On Thu 12-12-19 18:11:36, David Hildenbrand wrote:
>> We already have a way to trigger reclaiming of all reclaimable slab ob=
jects
>> from user space (echo 2 > /proc/sys/vm/drop_caches). Let's allow drive=
rs
>> to also trigger this when they really want to make progress and know w=
hat
>> they are doing.
>=20
> I cannot say I would be fan of this. This is a global action with user
> visible performance impact. I am worried that we will find out that all
> sorts of drivers have a very good idea that dropping slab caches is
> going to help their problem whatever it is. We have seen the same patte=
r
> in the userspace already and that is the reason we are logging the usag=
e
> to the log and count invocations in the counter.

Yeah, I decided to hold back patch 11-13 for the v1 (which I am planning
to post in March after more testing). What we really want is to make
memory offlining an alloc_contig_range() work better with reclaimable
objects.

>=20
>> virtio-mem wants to use these functions when it failed to unplug memor=
y
>> for quite some time (e.g., after 30 minutes). It will then try to
>> free up reclaimable objects by dropping the slab caches every now and
>> then (e.g., every 30 minutes) as long as necessary. There will be a wa=
y to
>> disable this feature and info messages will be logged.
>>
>> In the future, we want to have a drop_slab_range() functionality
>> instead. Memory offlining code has similar demands and also other
>> alloc_contig_range() users (e.g., gigantic pages) could make good use =
of
>> this feature. Adding it, however, requires more work/thought.
>=20
> We already do have a memory_notify(MEM_GOING_OFFLINE) for that purpose
> and slab allocator implements a callback (slab_mem_going_offline_callba=
ck).
> The callback is quite dumb and it doesn't really try to free objects
> from the given memory range or even try to drop active objects which
> might turn out to be hard but this sounds like a more robust way to
> achieve what you want.

Two things:

1. memory_notify(MEM_GOING_OFFLINE) is called after trying to isolate
the page range and checking if we only have movable pages. Won't help
much I guess.

2. alloc_contig_range() won't benefit from that.

Something like drop_slab_range() would be better, and calling it from
the right spots in the core (e.g., set_migratetype_isolate() see below).

Especially, have a look at mm/page_isolation.c:set_migratetype_isolate()

"FIXME: Now, memory hotplug doesn't call shrink_slab() by itself. We
just check MOVABLE pages."

--=20
Thanks,

David / dhildenb
