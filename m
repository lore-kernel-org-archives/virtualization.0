From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH v7 kernel 3/5] virtio-balloon: implementation of
	VIRTIO_BALLOON_F_CHUNK_TRANSFER
Date: Fri, 10 Mar 2017 17:58:28 +0200
Message-ID: <20170310175349-mutt-send-email-mst__48377.1585663364$1489161534$gmane$org@kernel.org>
References: <1488519630-89058-1-git-send-email-wei.w.wang@intel.com>
	<1488519630-89058-4-git-send-email-wei.w.wang@intel.com>
	<20170309141411.GZ16328@bombadil.infradead.org>
	<58C28FF8.5040403@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <58C28FF8.5040403@intel.com>
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
Cc: Andrea Arcangeli <aarcange@redhat.com>, virtio-dev@lists.oasis-open.org, kvm@vger.kernel.org, Dave Hansen <dave.hansen@intel.com>, qemu-devel@nongnu.org, Amit Shah <amit.shah@redhat.com>, Liang Li <liang.z.li@intel.com>, linux-kernel@vger.kernel.org, Matthew Wilcox <willy@infradead.org>, virtualization@lists.linux-foundation.org, linux-mm@kvack.org, Liang Li <liliang324@gmail.com>, Cornelia Huck <cornelia.huck@de.ibm.com>, Paolo Bonzini <pbonzini@redhat.com>
List-Id: virtualization@lists.linuxfoundation.org

On Fri, Mar 10, 2017 at 07:37:28PM +0800, Wei Wang wrote:
> On 03/09/2017 10:14 PM, Matthew Wilcox wrote:
> > On Fri, Mar 03, 2017 at 01:40:28PM +0800, Wei Wang wrote:
> > > From: Liang Li <liang.z.li@intel.com>
> > > 1) allocating pages (6.5%)
> > > 2) sending PFNs to host (68.3%)
> > > 3) address translation (6.1%)
> > > 4) madvise (19%)
> > > 
> > > This patch optimizes step 2) by transfering pages to the host in
> > > chunks. A chunk consists of guest physically continuous pages, and
> > > it is offered to the host via a base PFN (i.e. the start PFN of
> > > those physically continuous pages) and the size (i.e. the total
> > > number of the pages). A normal chunk is formated as below:
> > > -----------------------------------------------
> > > |  Base (52 bit)               | Size (12 bit)|
> > > -----------------------------------------------
> > > For large size chunks, an extended chunk format is used:
> > > -----------------------------------------------
> > > |                 Base (64 bit)               |
> > > -----------------------------------------------
> > > -----------------------------------------------
> > > |                 Size (64 bit)               |
> > > -----------------------------------------------
> > What's the advantage to extended chunks?  IOW, why is the added complexity
> > of having two chunk formats worth it?  You already reduced the overhead by
> > a factor of 4096 with normal chunks ... how often are extended chunks used
> > and how much more efficient are they than having several normal chunks?
> > 
> 
> Right, chunk_ext may be rarely used, thanks. I will remove chunk_ext if
> there is no objection from others.
> 
> Best,
> Wei

I don't think we can drop this, this isn't an optimization.


One of the issues of current balloon is the 4k page size
assumption. For example if you free a huge page you
have to split it up and pass 4k chunks to host.
Quite often host can't free these 4k chunks at all (e.g.
when it's using huge tlb fs).
It's even sillier for architectures with base page size >4k.

So as long as we are changing things, let's not hard-code
the 12 shift thing everywhere.


Two things to consider:
- host should pass its base page size to guest
  this can be a separate patch and for now we can fall back on 12 bit if not there

- guest should pass full huge pages to host
  this should be done correctly to avoid breaking up huge pages
  I would say yes let's use a single format but drop the "normal chunk"
  and always use the extended one.
  Also, size is in units of 4k, right? Please document that low 12 bit
  are reserved, they will be handy as e.g. flags.
