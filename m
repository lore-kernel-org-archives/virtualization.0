From: David Hildenbrand <david@redhat.com>
Subject: Re: Balloon pressuring page cache
Date: Wed, 5 Feb 2020 10:22:34 +0100
Message-ID: <bcb69e37-fd84-6397-0ff5-befd99a361dd@redhat.com>
References: <91270a68-ff48-88b0-219c-69801f0c252f@redhat.com>
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
 <605bef3e-373f-f39a-4849-930326564b5b@redhat.com>
 <286AC319A985734F985F78AFA26841F73E41F3DE@shsmsx102.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <286AC319A985734F985F78AFA26841F73E41F3DE@shsmsx102.ccr.corp.intel.com>
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

>> 1. Guest allocates a page and sends it to the host.
>> 2. Shrinker gets active and releases that page again.
>> 3. Some user in the guest allocates and modifies that page. The dirty bit is
>> set in the hypervisor.
> 
> The bit will be set in KVM's bitmap, and will be synced to QEMU's bitmap when the next round starts.
> 
>> 4. The host processes the request and clears the bit in the dirty bitmap.
> 
> This clears the bit from the QEMU bitmap, and this page will not be sent in this round.
> 
>> 5. The guest is stopped and the last set of dirty pages is migrated. The
>> modified page is not being migrated (because not marked dirty).
> 
> When QEMU start the last round, it first syncs the bitmap from KVM, which includes the one set in step 3.
> Then the modified page gets sent.

So, if you run a TCG guest and use it with free page reporting, the race
is possible? So the correctness depends on two dirty bitmaps in the
hypervisor and how they interact. wow this is fragile.

Thanks for the info :)

-- 
Thanks,

David / dhildenb
