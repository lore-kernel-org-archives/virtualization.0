From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [RFC PATCH V2 5/5] vhost: access vq metadata through kernel
	virtual address
Date: Thu, 7 Mar 2019 12:56:45 -0500
Message-ID: <20190307124700-mutt-send-email-mst__29358.3314212569$1551981419$gmane$org@kernel.org>
References: <1551856692-3384-1-git-send-email-jasowang@redhat.com>
	<1551856692-3384-6-git-send-email-jasowang@redhat.com>
	<20190307103503-mutt-send-email-mst@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20190307103503-mutt-send-email-mst@kernel.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Jason Wang <jasowang@redhat.com>
Cc: aarcange@redhat.com, kvm@vger.kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, linux-mm@kvack.org, Jerome Glisse <jglisse@redhat.com>
List-Id: virtualization@lists.linuxfoundation.org

On Thu, Mar 07, 2019 at 10:47:22AM -0500, Michael S. Tsirkin wrote:
> On Wed, Mar 06, 2019 at 02:18:12AM -0500, Jason Wang wrote:
> > +static const struct mmu_notifier_ops vhost_mmu_notifier_ops = {
> > +	.invalidate_range = vhost_invalidate_range,
> > +};
> > +
> >  void vhost_dev_init(struct vhost_dev *dev,
> >  		    struct vhost_virtqueue **vqs, int nvqs, int iov_limit)
> >  {
> 
> I also wonder here: when page is write protected then
> it does not look like .invalidate_range is invoked.
> 
> E.g. mm/ksm.c calls
> 
> mmu_notifier_invalidate_range_start and
> mmu_notifier_invalidate_range_end but not mmu_notifier_invalidate_range.
> 
> Similarly, rmap in page_mkclean_one will not call
> mmu_notifier_invalidate_range.
> 
> If I'm right vhost won't get notified when page is write-protected since you
> didn't install start/end notifiers. Note that end notifier can be called
> with page locked, so it's not as straight-forward as just adding a call.
> Writing into a write-protected page isn't a good idea.
> 
> Note that documentation says:
> 	it is fine to delay the mmu_notifier_invalidate_range
> 	call to mmu_notifier_invalidate_range_end() outside the page table lock.
> implying it's called just later.

OK I missed the fact that _end actually calls
mmu_notifier_invalidate_range internally. So that part is fine but the
fact that you are trying to take page lock under VQ mutex and take same
mutex within notifier probably means it's broken for ksm and rmap at
least since these call invalidate with lock taken.

And generally, Andrea told me offline one can not take mutex under
the notifier callback. I CC'd Andrea for why.

That's a separate issue from set_page_dirty when memory is file backed.

It's because of all these issues that I preferred just accessing
userspace memory and handling faults. Unfortunately there does not
appear to exist an API that whitelists a specific driver along the lines
of "I checked this code for speculative info leaks, don't add barriers
on data path please".


> -- 
> MST
