From: David Hildenbrand <david@redhat.com>
Subject: Re: Balloon pressuring page cache
Date: Tue, 4 Feb 2020 17:56:22 +0100
Message-ID: <a94fe61e-e015-49f7-b6c1-3c5aff727996@redhat.com>
References: <75d4594f-0864-5172-a0f8-f97affedb366@redhat.com>
 <286AC319A985734F985F78AFA26841F73E3F8A02@shsmsx102.ccr.corp.intel.com>
 <CAJuQAmqcayaNuG19fKCuux=YVO3+VcN-qrXvobgKMykogeMkzA@mail.gmail.com>
 <20200203080520-mutt-send-email-mst@kernel.org>
 <5ac131de8e3b7fc1fafd05a61feb5f6889aeb917.camel@linux.intel.com>
 <c836a8d1-c5cc-eb8b-84ed-027070b77bf8@redhat.com>
 <539B606A-A0CA-4AA4-B99A-759C874A1EF8@vmware.com>
 <d69eafb4-ad0d-1617-9248-ea4fc776da58@redhat.com>
 <20200204033657-mutt-send-email-mst@kernel.org>
 <ce93331c-0099-dda7-e00f-126bf7826a40@redhat.com>
 <20200204114336-mutt-send-email-mst@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20200204114336-mutt-send-email-mst@kernel.org>
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
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: "virtualization@lists.linux-foundation.org" <virtualization@lists.linux-foundation.org>, Tyler Sanderson <tysand@google.com>, "linux-mm@kvack.org" <linux-mm@kvack.org>, Nadav Amit <namit@vmware.com>, David Rientjes <rientjes@google.com>, Alexander Duyck <alexander.h.duyck@linux.intel.com>, Michal Hocko <mhocko@kernel.org>
List-Id: virtualization@lists.linuxfoundation.org

[...]

>>
>> Issue 2: When called via the shrinker, (but also to fix Issue 1), it could be
>> that we do have VIRTIO_BALLOON_F_MUST_TELL_HOST. I assume this means
>> (-ENOCLUE) that we have to wait until the hypervisor notifies us via the STOP? Or
>> for which event do we have to wait? Because there is no way to *tell host* here
>> that we want to reuse a page. The hypervisor will *tell us* when we can reuse pages.
>> For the shrinker it is simple: Don't use the shrinker with
>> VIRTIO_BALLOON_F_MUST_TELL_HOST :) . But to fix Issue 1, we *would* have to wait
>> until we get a STOP signal. That is not really possible because it might
>> take an infinite amount of time.
>>
>> Michael, any clue on which event we have to wait with
>> VIRTIO_BALLOON_F_MUST_TELL_HOST? IMHO, I don't think
>> VIRTIO_BALLOON_F_MUST_TELL_HOST applies to VIRTIO_BALLOON_F_FREE_PAGE_HINT and
>> we'd better document that. It introduces complexity with no clear benefit.
> 
> I meant that we must wait for host to see the hint. Signalled via using
> the buffer.  But maybe that's too far in the meaning from
> VIRTIO_BALLOON_F_MUST_TELL_HOST and we need a separate new flag for

Yes, that's what I think.

> that. Then current code won't be broken (yay!) but we need to
> document another flag that's pretty similar.

I mean, do we need a flag at all as long as there is no user?
Introducing a flag and documenting it if nobody uses it does not sound
like a work I will enjoy :)

We can simply document "VIRTIO_BALLOON_F_MUST_TELL_HOST does not apply
to FREE_PAGE_HINTING" and "with FREE_PAGE_HINTING, the guest can reuse
pages any time, without waiting for a response/ack from the hypervisor".

Thoughts?

-- 
Thanks,

David / dhildenb
