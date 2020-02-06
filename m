From: David Hildenbrand <david@redhat.com>
Subject: Re: [PATCH v1 3/3] virtio-balloon: Switch back to OOM handler for
 VIRTIO_BALLOON_F_DEFLATE_ON_OOM
Date: Thu, 6 Feb 2020 09:42:34 +0100
Message-ID: <51955928-5a4b-c922-ee34-6e94b6cdd385@redhat.com>
References: <20200205163402.42627-1-david@redhat.com>
 <20200205163402.42627-4-david@redhat.com>
 <20200206013724-mutt-send-email-mst@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20200206013724-mutt-send-email-mst@kernel.org>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org, virtualization@lists.linux-foundation.org, Tyler Sanderson <tysand@google.com>, Wei Wang <wei.w.wang@intel.com>, Alexander Duyck <alexander.h.duyck@linux.intel.com>, David Rientjes <rientjes@google.com>, Nadav Amit <namit@vmware.com>, Michal Hocko <mhocko@kernel.org>
List-Id: virtualization@lists.linuxfoundation.org

On 06.02.20 08:40, Michael S. Tsirkin wrote:
> On Wed, Feb 05, 2020 at 05:34:02PM +0100, David Hildenbrand wrote:
>> Commit 71994620bb25 ("virtio_balloon: replace oom notifier with shrink=
er")
>> changed the behavior when deflation happens automatically. Instead of
>> deflating when called by the OOM handler, the shrinker is used.
>>
>> However, the balloon is not simply some slab cache that should be
>> shrunk when under memory pressure. The shrinker does not have a concep=
t of
>> priorities, so this behavior cannot be configured.
>>
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
>> deflated - undesired. While handling it via the OOM handler might not =
be
>> perfect, it keeps existing behavior. If we want a different behavior, =
then
>> we need a new feature bit and document it properly (although, there sh=
ould
>> be a clear use case and the intended effects should be well described)=
.
>>
>> Keep using the shrinker for VIRTIO_BALLOON_F_FREE_PAGE_HINT, because
>> this has no such side effects. Always register the shrinker with
>> VIRTIO_BALLOON_F_FREE_PAGE_HINT now. We are always allowed to reuse fr=
ee
>> pages that are still to be processed by the guest. The hypervisor take=
s
>> care of identifying and resolving possible races between processing a
>> hinting request and the guest reusing a page.
>>
>> In contrast to pre commit 71994620bb25 ("virtio_balloon: replace oom
>> notifier with shrinker"), don't add a moodule parameter to configure t=
he
>> number of pages to deflate on OOM. Can be re-added if really needed.
>=20
> I agree. And to make this case even stronger:
>=20
> The oom_pages module parameter was known to be broken: whatever its
> value, we return at most VIRTIO_BALLOON_ARRAY_PFNS_MAX.  So module
> parameter values > 256 never worked, and it seems highly unlikely that
> freeing 1Mbyte on OOM is too aggressive.
> There was a patch
>  virtio-balloon: deflate up to oom_pages on OOM
> by Wei Wang to try to fix it:
> https://lore.kernel.org/r/1508500466-21165-3-git-send-email-wei.w.wang@=
intel.com
> but this was dropped.

Makes sense. 1MB is usually good enough.

>=20
>> Also, pay attention that leak_balloon() returns the number of 4k pages=
 -
>> convert it properly in virtio_balloon_oom_notify().
>=20
> Oh. So it was returning a wrong value originally (before 71994620bb25).
> However what really matters for notifiers is whether the value is 0 -
> whether we made progress. So it's cosmetic.

Yes, that's also my understanding.

>=20
>> Note1: using the OOM handler is frowned upon, but it really is what we
>>        need for this feature.
>=20
> Quite. However, I went back researching why we dropped the OOM notifier=
,
> and found this:
>=20
> https://lore.kernel.org/r/1508500466-21165-2-git-send-email-wei.w.wang@=
intel.com
>=20
> To quote from there:
>=20
> The balloon_lock was used to synchronize the access demand to elements
> of struct virtio_balloon and its queue operations (please see commit
> e22504296d). This prevents the concurrent run of the leak_balloon and
> fill_balloon functions, thereby resulting in a deadlock issue on OOM:
>=20
> fill_balloon: take balloon_lock and wait for OOM to get some memory;
> oom_notify: release some inflated memory via leak_balloon();
> leak_balloon: wait for balloon_lock to be released by fill_balloon.

fill_balloon does the allocation *before* taking the lock. tell_host()
should not allocate memory AFAIR. So how could this ever happen?

Anyhow, we could simply work around this by doing a trylock in
fill_balloon() and retrying in the caller. That should be easy. But I
want to understand first, how something like that would even be possible.

>> Note2: without VIRTIO_BALLOON_F_MUST_TELL_HOST (iow, always with QEMU)=
 we
>>        could actually skip sending deflation requests to our hyperviso=
r,
>>        making the OOM path *very* simple. Besically freeing pages and
>>        updating the balloon.
>=20
> Well not exactly. !VIRTIO_BALLOON_F_MUST_TELL_HOST does not actually
> mean "never tell host". It means "host will not discard pages in the
> balloon, you can defer host notification until after use".
>=20
> This was the original implementation:
>=20
> +       if (vb->tell_host_first) {
> +               tell_host(vb, vb->deflate_vq);
> +               release_pages_by_pfn(vb->pfns, vb->num_pfns);
> +       } else {
> +               release_pages_by_pfn(vb->pfns, vb->num_pfns);
> +               tell_host(vb, vb->deflate_vq);
> +       }
> +}
>=20
> I don't know whether completely skipping host notifications
> when !VIRTIO_BALLOON_F_MUST_TELL_HOST will break any hosts.

We discussed this already somewhere else, but here is again what I found.

commit bf50e69f63d21091e525185c3ae761412be0ba72
Author: Dave Hansen <dave@linux.vnet.ibm.com>
Date:   Thu Apr 7 10:43:25 2011 -0700

    virtio balloon: kill tell-host-first logic

    The virtio balloon driver has a VIRTIO_BALLOON_F_MUST_TELL_HOST
    feature bit.  Whenever the bit is set, the guest kernel must
    always tell the host before we free pages back to the allocator.
    Without this feature, we might free a page (and have another
    user touch it) while the hypervisor is unprepared for it.

    But, if the bit is _not_ set, we are under no obligation to
    reverse the order; we're under no obligation to do _anything_.
    As of now, qemu-kvm defines the bit, but doesn't set it.

MUST_TELL_HOST really means "no need to deflate, just reuse a page". We
should finally document this somewhere.

--=20
Thanks,

David / dhildenb
