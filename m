From: David Hildenbrand <david@redhat.com>
Subject: Re: [PATCH RFC v4 06/13] mm: Allow to offline unmovable PageOffline()
 pages via MEM_GOING_OFFLINE
Date: Tue, 25 Feb 2020 19:49:21 +0100
Message-ID: <267ea186-aba8-1a93-bd55-ac641f78d07e@redhat.com>
References: <20191212171137.13872-1-david@redhat.com>
 <20191212171137.13872-7-david@redhat.com>
 <6ec496580ddcb629d22589a1cba8cd61cbd53206.camel@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <6ec496580ddcb629d22589a1cba8cd61cbd53206.camel@linux.intel.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Alexander Duyck <alexander.h.duyck@linux.intel.com>, linux-kernel@vger.kernel.org
Cc: linux-mm@kvack.org, virtio-dev@lists.oasis-open.org, virtualization@lists.linux-foundation.org, kvm@vger.kernel.org, Michal Hocko <mhocko@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, "Michael S . Tsirkin" <mst@redhat.com>, Juergen Gross <jgross@suse.com>, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, Pavel Tatashin <pavel.tatashin@microsoft.com>, Vlastimil Babka <vbabka@suse.cz>, Johannes Weiner <hannes@cmpxchg.org>, Anthony Yznaga <anthony.yznaga@oracle.com>, Michal Hocko <mhocko@suse.com>, Oscar Salvador <osalvador@suse.de>, Mel Gorman <mgorman@techsingularity.net>, Mike Rapoport <rppt@linux.ibm.com>, Dan Williams <dan.j.williams@intel.com>, Anshuman Khandual <anshuman.khandual@arm.com>, Qian Cai <cai@lca.pw>, Pingfan Liu <kernelfans@g>
List-Id: virtualization@lists.linuxfoundation.org

>>  /*
>>   * Scan pfn range [start,end) to find movable/migratable pages (LRU p=
ages,
>> - * non-lru movable pages and hugepages). We scan pfn because it's muc=
h
>> - * easier than scanning over linked list. This function returns the p=
fn
>> - * of the first found movable page if it's found, otherwise 0.
>> + * non-lru movable pages and hugepages).
>> + *
>> + * Returns:
>> + *	0 in case a movable page is found and movable_pfn was updated.
>> + *	-ENOENT in case no movable page was found.
>> + *	-EBUSY in case a definetly unmovable page was found.
>>   */
>> -static unsigned long scan_movable_pages(unsigned long start, unsigned=
 long end)
>> +static int scan_movable_pages(unsigned long start, unsigned long end,
>> +			      unsigned long *movable_pfn)
>>  {
>>  	unsigned long pfn;
>> =20
>> @@ -1247,18 +1251,29 @@ static unsigned long scan_movable_pages(unsign=
ed long start, unsigned long end)
>>  			continue;
>>  		page =3D pfn_to_page(pfn);
>>  		if (PageLRU(page))
>> -			return pfn;
>> +			goto found;
>>  		if (__PageMovable(page))
>> -			return pfn;
>> +			goto found;
>> +
>> +		/*
>> +		 * Unmovable PageOffline() pages where somebody still holds
>> +		 * a reference count (after MEM_GOING_OFFLINE) can definetly
>> +		 * not be offlined.
>> +		 */
>> +		if (PageOffline(page) && page_count(page))
>> +			return -EBUSY;
>=20
> So the comment confused me a bit because technically this function isn'=
t
> about offlining memory, it is about finding movable pages. I had to do =
a
> bit of digging to find the only consumer is __offline_pages, but if we =
are
> going to talk about "offlining" instead of "moving" in this function it
> might make sense to rename it.

Well, it's contained in memory_hotplug.c, and the only user of moving
pages around in there is offlining code :) And it's job is to locate
movable pages, skip over some (temporary? unmovable ones) and (now)
indicate definitely unmovable ones.

Any idea for a better name?
scan_movable_pages_and_stop_on_definitely_unmovable() is not so nice :)


>=20
>> =20
>>  		if (!PageHuge(page))
>>  			continue;
>>  		head =3D compound_head(page);
>>  		if (page_huge_active(head))
>> -			return pfn;
>> +			goto found;
>>  		skip =3D compound_nr(head) - (page - head);
>>  		pfn +=3D skip - 1;
>>  	}
>> +	return -ENOENT;
>> +found:
>> +	*movable_pfn =3D pfn;
>>  	return 0;
>>  }
>=20
> So I am looking at this function and it seems like your change complete=
ly
> changes the behavior. The code before would walk the entire range and i=
f
> at least 1 page was available to move you would return the PFN of that
> page. Now what seems to happen is that you will return -EBUSY as soon a=
s
> you encounter an offline page with a page count. I would think that wou=
ld
> slow down the offlining process since you have made the Unmovable
> PageOffline() page a head of line blocker that you have to wait to get
> around.

So, the comment says "Unmovable PageOffline() pages where somebody still
holds a reference count (after MEM_GOING_OFFLINE) can definitely not be
offlined". And the doc "-EBUSY in case a definitely unmovable page was
found."

So why would this make offlining slow? Offlining will be aborted,
because offlining is not possible.

Please note that this is the exact old behavior, where isolating the
page range would have failed directly and offlining would have been
aborted early. The old offlining failure in the case in the offlining
path would have been "failure to isolate range".

Also, note that the users of PageOffline() with unmovable pages are very
rare (only balloon drivers for now).

>=20
> Would it perhaps make more sense to add a return value initialized to
> ENOENT, and if you encounter one of these offline pages you change the
> return value to EBUSY, and then if you walk through the entire list
> without finding a movable page you just return the value?

Did you have a look in  which context this function is used, especially
[1] and [2]?

>=20
> Otherwise you might want to add a comment explaining why the function
> should stall instead of skipping over the unmovable section that will
> hopefully become movable later.

So we have "-EBUSY in case a definitely unmovable page was found.". Do
you have a better suggestion?

>=20
>> @@ -1528,7 +1543,8 @@ static int __ref __offline_pages(unsigned long s=
tart_pfn,
>>  	}
>> =20
>>  	do {
>> -		for (pfn =3D start_pfn; pfn;) {
>> +		pfn =3D start_pfn;
>> +		do {
>>  			if (signal_pending(current)) {
>>  				ret =3D -EINTR;
>>  				reason =3D "signal backoff";
>> @@ -1538,14 +1554,19 @@ static int __ref __offline_pages(unsigned long=
 start_pfn,
>>  			cond_resched();
>>  			lru_add_drain_all();
>> =20
>> -			pfn =3D scan_movable_pages(pfn, end_pfn);
>> -			if (pfn) {
>> +			ret =3D scan_movable_pages(pfn, end_pfn, &pfn);
>> +			if (!ret) {
>>  				/*
>>  				 * TODO: fatal migration failures should bail
>>  				 * out
>>  				 */
>>  				do_migrate_range(pfn, end_pfn);
>>  			}

[1] we detect a definite offlining blocker and

>> +		} while (!ret);
>> +
>> +		if (ret !=3D -ENOENT) {
>> +			reason =3D "unmovable page";

[2] we abort offlining

>> +			goto failed_removal_isolated;
>>  		}
>> =20
>>  		/*
>> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
>> index 5334decc9e06..840c0bbe2d9f 100644
>> --- a/mm/page_alloc.c
>> +++ b/mm/page_alloc.c
>> @@ -8256,6 +8256,19 @@ bool has_unmovable_pages(struct zone *zone, str=
uct page *page, int count,
>>  		if ((flags & MEMORY_OFFLINE) && PageHWPoison(page))
>>  			continue;
>> =20
>> +		/*
>> +		 * We treat all PageOffline() pages as movable when offlining
>> +		 * to give drivers a chance to decrement their reference count
>> +		 * in MEM_GOING_OFFLINE in order to signalize that these pages
>=20
> You can probably just use "signal" or "indicate" instead of "signalize"=
.

Makes sense, "indicate" it is!

Thanks!

--=20
Thanks,

David / dhildenb
