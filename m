From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH v34 2/4] virtio-balloon: VIRTIO_BALLOON_F_FREE_PAGE_HINT
Date: Tue, 26 Jun 2018 16:34:27 +0300
Message-ID: <20180626163139-mutt-send-email-mst__31202.3307233632$1530019956$gmane$org@kernel.org>
References: <1529928312-30500-1-git-send-email-wei.w.wang@intel.com>
	<1529928312-30500-3-git-send-email-wei.w.wang@intel.com>
	<20180626002822-mutt-send-email-mst@kernel.org>
	<5B31B71B.6080709@intel.com>
	<20180626064338-mutt-send-email-mst@kernel.org>
	<5B323140.1000306@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <5B323140.1000306@intel.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Wei Wang <wei.w.wang@intel.com>
Cc: yang.zhang.wz@gmail.com, virtio-dev@lists.oasis-open.org, riel@redhat.com, quan.xu0@gmail.com, kvm@vger.kernel.org, nilal@redhat.com, liliang.opensource@gmail.com, linux-kernel@vger.kernel.org, mhocko@kernel.org, linux-mm@kvack.org, pbonzini@redhat.com, akpm@linux-foundation.org, virtualization@lists.linux-foundation.org, torvalds@linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On Tue, Jun 26, 2018 at 08:27:44PM +0800, Wei Wang wrote:
> On 06/26/2018 11:56 AM, Michael S. Tsirkin wrote:
> > On Tue, Jun 26, 2018 at 11:46:35AM +0800, Wei Wang wrote:
> > 
> 
> > > 
> > > > 
> > > > > +	if (!arrays)
> > > > > +		return NULL;
> > > > > +
> > > > > +	for (i = 0; i < max_array_num; i++) {
> > > > So we are getting a ton of memory here just to free it up a bit later.
> > > > Why doesn't get_from_free_page_list get the pages from free list for us?
> > > > We could also avoid the 1st allocation then - just build a list
> > > > of these.
> > > That wouldn't be a good choice for us. If we check how the regular
> > > allocation works, there are many many things we need to consider when pages
> > > are allocated to users.
> > > For example, we need to take care of the nr_free
> > > counter, we need to check the watermark and perform the related actions.
> > > Also the folks working on arch_alloc_page to monitor page allocation
> > > activities would get a surprise..if page allocation is allowed to work in
> > > this way.
> > > 
> > mm/ code is well positioned to handle all this correctly.
> 
> I'm afraid that would be a re-implementation of the alloc functions,

A re-factoring - you can share code. The main difference is locking.

> and
> that would be much more complex than what we have. I think your idea of
> passing a list of pages is better.
> 
> Best,
> Wei

How much memory is this allocating anyway?

-- 
MST
