From: Andrea Arcangeli <aarcange@redhat.com>
Subject: Re: [RFC PATCH V2 5/5] vhost: access vq metadata through kernel
	virtual address
Date: Thu, 7 Mar 2019 14:16:22 -0500
Message-ID: <20190307191622.GP23850__27404.9319721357$1551986200$gmane$org@redhat.com>
References: <1551856692-3384-1-git-send-email-jasowang@redhat.com>
	<1551856692-3384-6-git-send-email-jasowang@redhat.com>
	<20190307103503-mutt-send-email-mst@kernel.org>
	<20190307124700-mutt-send-email-mst@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20190307124700-mutt-send-email-mst@kernel.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: kvm@vger.kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, linux-mm@kvack.org, Jerome Glisse <jglisse@redhat.com>
List-Id: virtualization@lists.linuxfoundation.org

On Thu, Mar 07, 2019 at 12:56:45PM -0500, Michael S. Tsirkin wrote:
> On Thu, Mar 07, 2019 at 10:47:22AM -0500, Michael S. Tsirkin wrote:
> > On Wed, Mar 06, 2019 at 02:18:12AM -0500, Jason Wang wrote:
> > > +static const struct mmu_notifier_ops vhost_mmu_notifier_ops = {
> > > +	.invalidate_range = vhost_invalidate_range,
> > > +};
> > > +
> > >  void vhost_dev_init(struct vhost_dev *dev,
> > >  		    struct vhost_virtqueue **vqs, int nvqs, int iov_limit)
> > >  {
> > 
> > I also wonder here: when page is write protected then
> > it does not look like .invalidate_range is invoked.
> > 
> > E.g. mm/ksm.c calls
> > 
> > mmu_notifier_invalidate_range_start and
> > mmu_notifier_invalidate_range_end but not mmu_notifier_invalidate_range.
> > 
> > Similarly, rmap in page_mkclean_one will not call
> > mmu_notifier_invalidate_range.
> > 
> > If I'm right vhost won't get notified when page is write-protected since you
> > didn't install start/end notifiers. Note that end notifier can be called
> > with page locked, so it's not as straight-forward as just adding a call.
> > Writing into a write-protected page isn't a good idea.
> > 
> > Note that documentation says:
> > 	it is fine to delay the mmu_notifier_invalidate_range
> > 	call to mmu_notifier_invalidate_range_end() outside the page table lock.
> > implying it's called just later.
> 
> OK I missed the fact that _end actually calls
> mmu_notifier_invalidate_range internally. So that part is fine but the
> fact that you are trying to take page lock under VQ mutex and take same
> mutex within notifier probably means it's broken for ksm and rmap at
> least since these call invalidate with lock taken.

Yes this lock inversion needs more thoughts.

> And generally, Andrea told me offline one can not take mutex under
> the notifier callback. I CC'd Andrea for why.

Yes, the problem then is the ->invalidate_page is called then under PT
lock so it cannot take mutex, you also cannot take the page_lock, it
can at most take a spinlock or trylock_page.

So it must switch back to the _start/_end methods unless you rewrite
the locking.

The difference with _start/_end, is that ->invalidate_range avoids the
_start callback basically, but to avoid the _start callback safely, it
has to be called in between the ptep_clear_flush and the set_pte_at
whenever the pfn changes like during a COW. So it cannot be coalesced
in a single TLB flush that invalidates all sptes in a range like we
prefer for performance reasons for example in KVM. It also cannot
sleep.

In short ->invalidate_range must be really fast (it shouldn't require
to send IPI to all other CPUs like KVM may require during an
invalidate_range_start) and it must not sleep, in order to prefer it
to _start/_end.

I.e. the invalidate of the secondary MMU that walks the linux
pagetables in hardware (in vhost case with GUP in software) has to
happen while the linux pagetable is zero, otherwise a concurrent
hardware pagetable lookup could re-instantiate a mapping to the old
page in between the set_pte_at and the invalidate_range_end (which
internally calls ->invalidate_range). Jerome documented it nicely in
Documentation/vm/mmu_notifier.rst .

Now you don't really walk the pagetable in hardware in vhost, but if
you use gup_fast after usemm() it's similar.

For vhost the invalidate would be really fast, there are no IPI to
deliver at all, the problem is just the mutex.

> That's a separate issue from set_page_dirty when memory is file backed.

Yes. I don't yet know why the ext4 internal __writepage cannot
re-create the bh if they've been freed by the VM and why such race
where the bh are freed for a pinned VM_SHARED ext4 page doesn't even
exist for transient pins like O_DIRECT (does it work by luck?), but
with mmu notifiers there are no long term pins anyway, so this works
normally and it's like the memory isn't pinned. In any case I think
that's a kernel bug in either __writepage or try_to_free_buffers, so I
would ignore it considering qemu will only use anon memory or tmpfs or
hugetlbfs as backing store for the virtio ring. It wouldn't make sense
for qemu to risk triggering I/O on a VM_SHARED ext4, so we shouldn't
be even exposed to what seems to be an orthogonal kernel bug.

I suppose whatever solution will fix the set_page_dirty_lock on
VM_SHARED ext4 for the other places that don't or can't use mmu
notifiers, will then work for vhost too which uses mmu notifiers and
will be less affected from the start if something.

Reading the lwn link about the discussion about the long term GUP pin
from Jan vs set_page_dirty_lock: I can only agree with the last part
where Jerome correctly pointed out at the end that mellanox RDMA got
it right by avoiding completely long term pins by using mmu notifier
and in general mmu notifier is the standard solution to avoid long
term pins. Nothing should ever take long term GUP pins, if it does it
means software is bad or the hardware lacks features to support on
demand paging. Still I don't get why transient pins like O_DIRECT
where mmu notifier would be prohibitive to use (registering into mmu
notifier cannot be done at high frequency, the locking to do so is
massive) cannot end up into the same ext4 _writepage crash as long
term pins: long term or short term transient is a subjective measure
from VM standpoint, the VM won't know the difference, luck will
instead.

> It's because of all these issues that I preferred just accessing
> userspace memory and handling faults. Unfortunately there does not
> appear to exist an API that whitelists a specific driver along the lines
> of "I checked this code for speculative info leaks, don't add barriers
> on data path please".

Yes that's unfortunate, __uaccess_begin_nospec() is now making
prohibitive to frequently access userland code.

I doubt we can do like access_ok() and only check it once. access_ok
checks the virtual address, and if the virtual address is ok doesn't
wrap around and it points to userland in a safe range, it's always
ok. There's no need to run access_ok again if we keep hitting on the
very same address.

__uaccess_begin_nospec() instead is about runtime stuff that can
change the moment copy-user has completed even before returning to
userland, so there's no easy way to do it just once.

On top of skipping the __uaccess_begin_nospec(), the mmu notifier soft
vhost design will further boost the performance by guaranteeing the
use of gigapages TLBs when available (or 2M TLBs worst case) even if
QEMU runs on smaller pages.

Thanks,
Andrea
