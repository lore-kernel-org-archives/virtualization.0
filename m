From: Jerome Glisse <jglisse@redhat.com>
Subject: Re: [RFC PATCH V2 5/5] vhost: access vq metadata through kernel
	virtual address
Date: Thu, 7 Mar 2019 14:17:20 -0500
Message-ID: <20190307191720.GF3835__26212.8098214575$1555717362$gmane$org@redhat.com>
References: <1551856692-3384-1-git-send-email-jasowang@redhat.com>
	<1551856692-3384-6-git-send-email-jasowang@redhat.com>
	<20190307103503-mutt-send-email-mst@kernel.org>
	<20190307124700-mutt-send-email-mst@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
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
Cc: aarcange@redhat.com, kvm@vger.kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, linux-mm@kvack.org
List-Id: virtualization@lists.linuxfoundation.org

On Thu, Mar 07, 2019 at 12:56:45PM -0500, Michael S. Tsirkin wrote:
> On Thu, Mar 07, 2019 at 10:47:22AM -0500, Michael S. Tsirkin wrote:
> > On Wed, Mar 06, 2019 at 02:18:12AM -0500, Jason Wang wrote:
> > > +static const struct mmu_notifier_ops vhost_mmu_notifier_ops =3D {
> > > +	.invalidate_range =3D vhost_invalidate_range,
> > > +};
> > > +
> > >  void vhost_dev_init(struct vhost_dev *dev,
> > >  		    struct vhost_virtqueue **vqs, int nvqs, int iov_limit)
> > >  {
> > =

> > I also wonder here: when page is write protected then
> > it does not look like .invalidate_range is invoked.
> > =

> > E.g. mm/ksm.c calls
> > =

> > mmu_notifier_invalidate_range_start and
> > mmu_notifier_invalidate_range_end but not mmu_notifier_invalidate_range.
> > =

> > Similarly, rmap in page_mkclean_one will not call
> > mmu_notifier_invalidate_range.
> > =

> > If I'm right vhost won't get notified when page is write-protected sinc=
e you
> > didn't install start/end notifiers. Note that end notifier can be called
> > with page locked, so it's not as straight-forward as just adding a call.
> > Writing into a write-protected page isn't a good idea.
> > =

> > Note that documentation says:
> > 	it is fine to delay the mmu_notifier_invalidate_range
> > 	call to mmu_notifier_invalidate_range_end() outside the page table loc=
k.
> > implying it's called just later.
> =

> OK I missed the fact that _end actually calls
> mmu_notifier_invalidate_range internally. So that part is fine but the
> fact that you are trying to take page lock under VQ mutex and take same
> mutex within notifier probably means it's broken for ksm and rmap at
> least since these call invalidate with lock taken.
> =

> And generally, Andrea told me offline one can not take mutex under
> the notifier callback. I CC'd Andrea for why.

Correct, you _can not_ take mutex or any sleeping lock from within the
invalidate_range callback as those callback happens under the page table
spinlock. You can however do so under the invalidate_range_start call-
back only if it is a blocking allow callback (there is a flag passdown
with the invalidate_range_start callback if you are not allow to block
then return EBUSY and the invalidation will be aborted).


> =

> That's a separate issue from set_page_dirty when memory is file backed.

If you can access file back page then i suggest using set_page_dirty
from within a special version of vunmap() so that when you vunmap you
set the page dirty without taking page lock. It is safe to do so
always from within an mmu notifier callback if you had the page map
with write permission which means that the page had write permission
in the userspace pte too and thus it having dirty pte is expected
and calling set_page_dirty on the page is allowed without any lock.
Locking will happen once the userspace pte are tear down through the
page table lock.

> It's because of all these issues that I preferred just accessing
> userspace memory and handling faults. Unfortunately there does not
> appear to exist an API that whitelists a specific driver along the lines
> of "I checked this code for speculative info leaks, don't add barriers
> on data path please".

Maybe it would be better to explore adding such helper then remapping
page into kernel address space ?

Cheers,
J=E9r=F4me
