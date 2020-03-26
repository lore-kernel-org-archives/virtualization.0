From: David Hildenbrand <david@redhat.com>
Subject: Re: [RFC for Linux] virtio_balloon: Add VIRTIO_BALLOON_F_THP_ORDER to handle THP spilt issue
Date: Thu, 26 Mar 2020 08:54:04 +0100
Message-ID: <C4C6BAF7-C040-403D-997C-48C7AB5A7D6B@redhat.com>
References: <20200326031817-mutt-send-email-mst@kernel.org>
Mime-Version: 1.0 (1.0)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20200326031817-mutt-send-email-mst@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: David Hildenbrand <david@redhat.com>, Hui Zhu <teawater@gmail.com>, jasowang@redhat.com, akpm@linux-foundation.org, pagupta@redhat.com, mojha@codeaurora.org, namit@vmware.com, virtualization@lists.linux-foundation.org, linux-kernel@vger.kernel.org, qemu-devel@nongnu.org, Hui Zhu <teawaterz@linux.alibaba.com>, Alexander Duyck <alexander.h.duyck@linux.intel.com>
List-Id: virtualization@lists.linuxfoundation.org



> Am 26.03.2020 um 08:21 schrieb Michael S. Tsirkin <mst@redhat.com>:
>=20
> =EF=BB=BFOn Thu, Mar 12, 2020 at 09:51:25AM +0100, David Hildenbrand wrote=
:
>>> On 12.03.20 09:47, Michael S. Tsirkin wrote:
>>> On Thu, Mar 12, 2020 at 09:37:32AM +0100, David Hildenbrand wrote:
>>>> 2. You are essentially stealing THPs in the guest. So the fastest
>>>> mapping (THP in guest and host) is gone. The guest won't be able to mak=
e
>>>> use of THP where it previously was able to. I can imagine this implies a=

>>>> performance degradation for some workloads. This needs a proper
>>>> performance evaluation.
>>>=20
>>> I think the problem is more with the alloc_pages API.
>>> That gives you exactly the given order, and if there's
>>> a larger chunk available, it will split it up.
>>>=20
>>> But for balloon - I suspect lots of other users,
>>> we do not want to stress the system but if a large
>>> chunk is available anyway, then we could handle
>>> that more optimally by getting it all in one go.
>>>=20
>>>=20
>>> So if we want to address this, IMHO this calls for a new API.
>>> Along the lines of
>>>=20
>>>    struct page *alloc_page_range(gfp_t gfp, unsigned int min_order,
>>>                    unsigned int max_order, unsigned int *order)
>>>=20
>>> the idea would then be to return at a number of pages in the given
>>> range.
>>>=20
>>> What do you think? Want to try implementing that?
>>=20
>> You can just start with the highest order and decrement the order until
>> your allocation succeeds using alloc_pages(), which would be enough for
>> a first version. At least I don't see the immediate need for a new
>> kernel API.
>=20
> OK I remember now.  The problem is with reclaim. Unless reclaim is
> completely disabled, any of these calls can sleep. After it wakes up,
> we would like to get the larger order that has become available
> meanwhile.
>=20

Yes, but that=E2=80=98s a pure optimization IMHO.

So I think we should do a trivial implementation first and then see what we g=
ain from a new allocator API. Then we might also be able to justify it using=
 real numbers.

>=20
>> --=20
>> Thanks,
>>=20
>> David / dhildenb
>=20
