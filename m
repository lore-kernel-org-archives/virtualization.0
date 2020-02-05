From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: Balloon pressuring page cache
Date: Wed, 5 Feb 2020 04:35:27 -0500
Message-ID: <20200205042655-mutt-send-email-mst@kernel.org>
References: <20200204033657-mutt-send-email-mst@kernel.org>
 <ce93331c-0099-dda7-e00f-126bf7826a40@redhat.com>
 <286AC319A985734F985F78AFA26841F73E41F0F0@shsmsx102.ccr.corp.intel.com>
 <1eff30a0-a38a-cd45-2fc1-80cfd0bf5f04@redhat.com>
 <286AC319A985734F985F78AFA26841F73E41F306@shsmsx102.ccr.corp.intel.com>
 <2b388a78-79cd-f99a-6f87-6446dcb4b819@redhat.com>
 <286AC319A985734F985F78AFA26841F73E41F367@shsmsx102.ccr.corp.intel.com>
 <605bef3e-373f-f39a-4849-930326564b5b@redhat.com>
 <286AC319A985734F985F78AFA26841F73E41F3DE@shsmsx102.ccr.corp.intel.com>
 <bcb69e37-fd84-6397-0ff5-befd99a361dd@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <bcb69e37-fd84-6397-0ff5-befd99a361dd@redhat.com>
Content-Disposition: inline
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
 <mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
 <mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>
To: David Hildenbrand <david@redhat.com>
Cc: "virtualization@lists.linux-foundation.org" <virtualization@lists.linux-foundation.org>, Tyler Sanderson <tysand@google.com>, "linux-mm@kvack.org" <linux-mm@kvack.org>, Nadav Amit <namit@vmware.com>, David Rientjes <rientjes@google.com>, Alexander Duyck <alexander.h.duyck@linux.intel.com>, Michal Hocko <mhocko@kernel.org>
List-Id: virtualization@lists.linuxfoundation.org

On Wed, Feb 05, 2020 at 10:22:34AM +0100, David Hildenbrand wrote:
> >> 1. Guest allocates a page and sends it to the host.
> >> 2. Shrinker gets active and releases that page again.
> >> 3. Some user in the guest allocates and modifies that page. The dirty bit is
> >> set in the hypervisor.
> > 
> > The bit will be set in KVM's bitmap, and will be synced to QEMU's bitmap when the next round starts.
> > 
> >> 4. The host processes the request and clears the bit in the dirty bitmap.
> > 
> > This clears the bit from the QEMU bitmap, and this page will not be sent in this round.
> > 
> >> 5. The guest is stopped and the last set of dirty pages is migrated. The
> >> modified page is not being migrated (because not marked dirty).
> > 
> > When QEMU start the last round, it first syncs the bitmap from KVM, which includes the one set in step 3.
> > Then the modified page gets sent.
> 
> So, if you run a TCG guest and use it with free page reporting, the race
> is possible?

I'd have to look at the implementation but the basic idea is not
kvm specific. The idea is that hypervisor can detect that 3 happened
after 1, by means of creating a copy of the dirty bitmap
when request is sent to the guest.


> So the correctness depends on two dirty bitmaps in the
> hypervisor and how they interact. wow this is fragile.
> 
> Thanks for the info :)

It's pretty fragile, and the annoying part is we do not
actually benefit from this at all since it all only triggers
in the shrinker corner case.

The original idea was that we can send any hint to hypervisor and reuse
the page immediately without waiting for hint to be seen.  That seemed
worth having, as a means to minimize impact of hinting.
Then we dropped that and switched to OOM, and there not having
to wait also seemed like a worthwhile thing.
In the end we switched to shrinker where we can wait
if we like, and many guests never even hit the shrinker so we
have sacrificed robustness for nothing.

If we go back to OOM then at least it's justified ..

> -- 
> Thanks,
> 
> David / dhildenb
