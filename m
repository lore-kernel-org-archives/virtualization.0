From: Matthew Wilcox <willy@infradead.org>
Subject: Re: [PATCH v9 0/5] Extend virtio-balloon for fast (de)inflating &
	fast live migration
Date: Fri, 14 Apr 2017 02:47:40 -0700
Message-ID: <20170414094740.GN784__2582.36573213271$1492163277$gmane$org@bombadil.infradead.org>
References: <1492076108-117229-1-git-send-email-wei.w.wang@intel.com>
	<20170413204411.GJ784@bombadil.infradead.org>
	<20170414044515-mutt-send-email-mst@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20170414044515-mutt-send-email-mst@kernel.org>
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
Cc: aarcange@redhat.com, virtio-dev@lists.oasis-open.org, kvm@vger.kernel.org, qemu-devel@nongnu.org, amit.shah@redhat.com, liliang.opensource@gmail.com, dave.hansen@intel.com, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, linux-mm@kvack.org, cornelia.huck@de.ibm.com, pbonzini@redhat.com, akpm@linux-foundation.org, mgorman@techsingularity.net
List-Id: virtualization@lists.linuxfoundation.org

On Fri, Apr 14, 2017 at 04:50:48AM +0300, Michael S. Tsirkin wrote:
> On Thu, Apr 13, 2017 at 01:44:11PM -0700, Matthew Wilcox wrote:
> > On Thu, Apr 13, 2017 at 05:35:03PM +0800, Wei Wang wrote:
> > > 2) transfer the guest unused pages to the host so that they
> > > can be skipped to migrate in live migration.
> > 
> > I don't understand this second bit.  You leave the pages on the free list,
> > and tell the host they're free.  What's preventing somebody else from
> > allocating them and using them for something?  Is the guest semi-frozen
> > at this point with just enough of it running to ask the balloon driver
> > to do things?
> 
> There's missing documentation here.
> 
> The way things actually work is host sends to guest
> a request for unused pages and then write-protects all memory.

... hopefully you mean "write protects all memory, then sends a request
for unused pages", otherwise there's a race condition.

And I see the utility of this, but does this functionality belong in
the balloon driver?  It seems like it's something you might want even
if you don't have the balloon driver loaded.  Or something you might
not want if you do have the balloon driver loaded.
