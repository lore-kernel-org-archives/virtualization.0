From: "Li, Liang Z" <liang.z.li@intel.com>
Subject: RE: [Qemu-devel] [RFC qemu 0/4] A PV solution for live migration
	optimization
Date: Wed, 9 Mar 2016 15:27:54 +0000
Message-ID: <F2CBF3009FA73547804AE4C663CAB28E041498BA__2716.37544869936$1457537316$gmane$org@shsmsx102.ccr.corp.intel.com>
References: <F2CBF3009FA73547804AE4C663CAB28E03770E33@SHSMSX101.ccr.corp.intel.com>
	<20160304081411.GD9100@rkaganb.sw.ru>
	<F2CBF3009FA73547804AE4C663CAB28E0377160A@SHSMSX101.ccr.corp.intel.com>
	<20160304102346.GB2479@rkaganb.sw.ru>
	<F2CBF3009FA73547804AE4C663CAB28E0414516C@shsmsx102.ccr.corp.intel.com>
	<20160304163246-mutt-send-email-mst@redhat.com>
	<F2CBF3009FA73547804AE4C663CAB28E041452EA@shsmsx102.ccr.corp.intel.com>
	<20160305214748-mutt-send-email-mst@redhat.com>
	<F2CBF3009FA73547804AE4C663CAB28E04146308@shsmsx102.ccr.corp.intel.com>
	<20160307110852-mutt-send-email-mst@redhat.com>
	<20160309142851.GA9715@rkaganb.sw.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20160309142851.GA9715@rkaganb.sw.ru>
Content-Language: en-US
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Roman Kagan <rkagan@virtuozzo.com>, "Michael S. Tsirkin" <mst@redhat.com>
Cc: "riel@redhat.com" <riel@redhat.com>, "ehabkost@redhat.com" <ehabkost@redhat.com>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-mm@kvack.org" <linux-mm@kvack.org>, "amit.shah@redhat.com" <amit.shah@redhat.com>, "pbonzini@redhat.com" <pbonzini@redhat.com>, "akpm@linux-foundation.org" <akpm@linux-foundation.org>, "virtualization@lists.linux-foundation.org" <virtualization@lists.linux-foundation.org>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, "rth@twiddle.net" <rth@twiddle.net>
List-Id: virtualization@lists.linuxfoundation.org

> On Mon, Mar 07, 2016 at 01:40:06PM +0200, Michael S. Tsirkin wrote:
> > On Mon, Mar 07, 2016 at 06:49:19AM +0000, Li, Liang Z wrote:
> > > > > No. And it's exactly what I mean. The ballooned memory is still
> > > > > processed during live migration without skipping. The live
> > > > > migration code is
> > > > in migration/ram.c.
> > > >
> > > > So if guest acknowledged VIRTIO_BALLOON_F_MUST_TELL_HOST, we
> can
> > > > teach qemu to skip these pages.
> > > > Want to write a patch to do this?
> > > >
> > >
> > > Yes, we really can teach qemu to skip these pages and it's not hard.
> > > The problem is the poor performance, this PV solution
> >
> > Balloon is always PV. And do not call patches solutions please.
> >
> > > is aimed to make it more
> > > efficient and reduce the performance impact on guest.
> >
> > We need to get a bit beyond this.  You are making multiple changes, it
> > seems to make sense to split it all up, and analyse each change
> > separately.
> 
> Couldn't agree more.
> 
> There are three stages in this optimization:
> 
> 1) choosing which pages to skip
> 
> 2) communicating them from guest to host
> 
> 3) skip transferring uninteresting pages to the remote side on migration
> 
> For (3) there seems to be a low-hanging fruit to amend
> migration/ram.c:iz_zero_range() to consult /proc/self/pagemap.  This would
> work for guest RAM that hasn't been touched yet or which has been
> ballooned out.
> 
> For (1) I've been trying to make a point that skipping clean pages is much
> more likely to result in noticable benefit than free pages only.
> 

I am considering to drop the pagecache before getting the free pages. 

> As for (2), we do seem to have a problem with the existing balloon:
> according to your measurements it's very slow; besides, I guess it plays badly

I didn't say communicating is slow. Even this is very slow, my solution use bitmap instead of
PFNs, there is fewer data traffic, so it's faster than the existing balloon which use PFNs.

> with transparent huge pages (as both the guest and the host work with one
> 4k page at a time).  This is a problem for other use cases of balloon (e.g. as a
> facility for resource management); tackling that appears a more natural
> application for optimization efforts.
> 
> Thanks,
> Roman.
