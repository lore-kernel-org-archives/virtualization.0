From: David Hildenbrand <david@redhat.com>
Subject: Re: Balloon pressuring page cache
Date: Tue, 4 Feb 2020 09:35:21 +0100
Message-ID: <d69eafb4-ad0d-1617-9248-ea4fc776da58@redhat.com>
References: <CAJuQAmpDUyve2S+oxp9tLUhuRcnddXnNztC5PmYOOCpY6c68xg@mail.gmail.com>
 <91270a68-ff48-88b0-219c-69801f0c252f@redhat.com>
 <CAJuQAmoaK0Swytu2Os_SQRfG5_LqiCPaDa9yatatm9MtfncNTQ@mail.gmail.com>
 <75d4594f-0864-5172-a0f8-f97affedb366@redhat.com>
 <286AC319A985734F985F78AFA26841F73E3F8A02@shsmsx102.ccr.corp.intel.com>
 <CAJuQAmqcayaNuG19fKCuux=YVO3+VcN-qrXvobgKMykogeMkzA@mail.gmail.com>
 <20200203080520-mutt-send-email-mst@kernel.org>
 <5ac131de8e3b7fc1fafd05a61feb5f6889aeb917.camel@linux.intel.com>
 <c836a8d1-c5cc-eb8b-84ed-027070b77bf8@redhat.com>
 <539B606A-A0CA-4AA4-B99A-759C874A1EF8@vmware.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <539B606A-A0CA-4AA4-B99A-759C874A1EF8@vmware.com>
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
To: Nadav Amit <namit@vmware.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, "virtualization@lists.linux-foundation.org" <virtualization@lists.linux-foundation.org>, Tyler Sanderson <tysand@google.com>, "linux-mm@kvack.org" <linux-mm@kvack.org>, David Rientjes <rientjes@google.com>, Alexander Duyck <alexander.h.duyck@linux.intel.com>, Michal Hocko <mhocko@kernel.org>
List-Id: virtualization@lists.linuxfoundation.org

>>> I would say reverting probably makes sense. I'm not sure there is much
>>> value to having a shrinker running deflation when you are actively trying
>>> to increase the balloon. It would make more sense to wait until you are
>>> actually about to start hitting oom.
>>
>> I think the shrinker makes sense for free page hinting feature
>> (everything on free_page_list).
>>
>> So instead of only reverting, I think we should split it up and always
>> register the shrinker for VIRTIO_BALLOON_F_FREE_PAGE_HINT and the OOM
>> notifier (as before) for VIRTIO_BALLOON_F_MUST_TELL_HOST.

s/VIRTIO_BALLOON_F_MUST_TELL_HOST/VIRTIO_BALLOON_F_DEFLATE_ON_OOM/

:)

>>
>> (Of course, adapting what is being done in the shrinker and in the OOM
>> notifier)
> 
> David,
> 
> Please keep me posted. I decided to adapt the same solution as the virtio
> balloon for the VMware balloon. If the verdict is that this is damaging and
> the OOM notifier should be used instead, I will submit patches to move to
> OOM notifier as well.

Will do. It all sounds sub-optimal to me at this point ... but I prefer
the old variant where a simple "drop_slab()" won't deflate the balloon.
That looks broken to me.

-- 
Thanks,

David / dhildenb
