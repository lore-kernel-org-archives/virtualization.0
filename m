From: David Hildenbrand <david@redhat.com>
Subject: Re: Balloon pressuring page cache
Date: Wed, 5 Feb 2020 10:05:42 +0100
Message-ID: <605bef3e-373f-f39a-4849-930326564b5b@redhat.com>
References: <91270a68-ff48-88b0-219c-69801f0c252f@redhat.com>
 <CAJuQAmoaK0Swytu2Os_SQRfG5_LqiCPaDa9yatatm9MtfncNTQ@mail.gmail.com>
 <75d4594f-0864-5172-a0f8-f97affedb366@redhat.com>
 <286AC319A985734F985F78AFA26841F73E3F8A02@shsmsx102.ccr.corp.intel.com>
 <CAJuQAmqcayaNuG19fKCuux=YVO3+VcN-qrXvobgKMykogeMkzA@mail.gmail.com>
 <20200203080520-mutt-send-email-mst@kernel.org>
 <5ac131de8e3b7fc1fafd05a61feb5f6889aeb917.camel@linux.intel.com>
 <c836a8d1-c5cc-eb8b-84ed-027070b77bf8@redhat.com>
 <539B606A-A0CA-4AA4-B99A-759C874A1EF8@vmware.com>
 <d69eafb4-ad0d-1617-9248-ea4fc776da58@redhat.com>
 <20200204033657-mutt-send-email-mst@kernel.org>
 <ce93331c-0099-dda7-e00f-126bf7826a40@redhat.com>
 <286AC319A985734F985F78AFA26841F73E41F0F0@shsmsx102.ccr.corp.intel.com>
 <1eff30a0-a38a-cd45-2fc1-80cfd0bf5f04@redhat.com>
 <286AC319A985734F985F78AFA26841F73E41F306@shsmsx102.ccr.corp.intel.com>
 <2b388a78-79cd-f99a-6f87-6446dcb4b819@redhat.com>
 <286AC319A985734F985F78AFA26841F73E41F367@shsmsx102.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <286AC319A985734F985F78AFA26841F73E41F367@shsmsx102.ccr.corp.intel.com>
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
To: "Wang, Wei W" <wei.w.wang@intel.com>, "Michael S. Tsirkin" <mst@redhat.com>
Cc: "virtualization@lists.linux-foundation.org" <virtualization@lists.linux-foundation.org>, Tyler Sanderson <tysand@google.com>, "linux-mm@kvack.org" <linux-mm@kvack.org>, Nadav Amit <namit@vmware.com>, David Rientjes <rientjes@google.com>, Alexander Duyck <alexander.h.duyck@linux.intel.com>, Michal Hocko <mhocko@kernel.org>
List-Id: virtualization@lists.linuxfoundation.org

On 05.02.20 10:00, Wang, Wei W wrote:
> On Wednesday, February 5, 2020 4:57 PM, David Hildenbrand wrote:
>>>> Yes, I agree with you. Yet, I am thinking about one
>>>> (unlikely?impossible?) scenario. Can you refresh my brain why that
>>>> cannot happen (IOW, why we don't have to wait for the host to process
>>>> the request)?
>>>>
>>>> 1. Guest allocates a page and sends it to the host.
>>>> 2. Shrinker gets active and releases that page again.
>>>> 3. Some user in the guest allocates and modifies that page. After
>>>> that, it is done using that page for the next hour.
>>>> 4. The host processes the request and clears the bit in the dirty bitmap.
>>>> 5. The guest is being migrated by the host. The modified page is not
>>>> being migrated.
>>>
>>> Whenever the guest modifies a page during migration, it will be
>>> captured by the dirty logging and the hypervisor will send the dirtied the
>> page in the following round.
>>
>> Please explain why the steps I outlined don't apply esp. in the last round.
>> Your general statement does not explain why this race can't happen.
>>
> 
> The guest is stopped in the last round, thus no page will be modified at that time.

No, that does not answer my question. Because then, obviously the guest
can't do any hinting in the last round. I think I am missing something
important :)

1. Guest allocates a page and sends it to the host.
2. Shrinker gets active and releases that page again.
3. Some user in the guest allocates and modifies that page. The dirty
bit is set in the hypervisor.
4. The host processes the request and clears the bit in the dirty bitmap.
5. The guest is stopped and the last set of dirty pages is migrated. The
modified page is not being migrated (because not marked dirty).

Something between 3. and 4. has to guarantee that the page will still be
migrated, what guarantees that?

-- 
Thanks,

David / dhildenb
