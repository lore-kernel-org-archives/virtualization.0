From: Roman Kagan <rkagan@virtuozzo.com>
Subject: Re: [Qemu-devel] [RFC qemu 0/4] A PV solution for live migration
	optimization
Date: Thu, 10 Mar 2016 13:21:30 +0300
Message-ID: <20160310102129.GB14065@rkaganb.sw.ru>
References: <F2CBF3009FA73547804AE4C663CAB28E0414516C@shsmsx102.ccr.corp.intel.com>
	<20160304163246-mutt-send-email-mst@redhat.com>
	<F2CBF3009FA73547804AE4C663CAB28E041452EA@shsmsx102.ccr.corp.intel.com>
	<20160305214748-mutt-send-email-mst@redhat.com>
	<F2CBF3009FA73547804AE4C663CAB28E04146308@shsmsx102.ccr.corp.intel.com>
	<20160307110852-mutt-send-email-mst@redhat.com>
	<20160309142851.GA9715@rkaganb.sw.ru>
	<20160309173017-mutt-send-email-mst@redhat.com>
	<20160309170438.GB9715@rkaganb.sw.ru>
	<20160309193137-mutt-send-email-mst@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20160309193137-mutt-send-email-mst@redhat.com>
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
Cc: riel@redhat.com, "ehabkost@redhat.com" <ehabkost@redhat.com>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "Li,
	Liang Z" <liang.z.li@intel.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, "linux-mm@kvack.org" <linux-mm@kvack.org>, "amit.shah@redhat.com" <amit.shah@redhat.com>, "pbonzini@redhat.com" <pbonzini@redhat.com>, "akpm@linux-foundation.org" <akpm@linux-foundation.org>, "virtualization@lists.linux-foundation.org" <virtualization@lists.linux-foundation.org>, "rth@twiddle.net" <rth@twiddle.net>
List-Id: virtualization@lists.linuxfoundation.org

On Wed, Mar 09, 2016 at 07:39:18PM +0200, Michael S. Tsirkin wrote:
> On Wed, Mar 09, 2016 at 08:04:39PM +0300, Roman Kagan wrote:
> > On Wed, Mar 09, 2016 at 05:41:39PM +0200, Michael S. Tsirkin wrote:
> > > On Wed, Mar 09, 2016 at 05:28:54PM +0300, Roman Kagan wrote:
> > > > For (1) I've been trying to make a point that skipping clean pages is
> > > > much more likely to result in noticable benefit than free pages only.
> > > 
> > > I guess when you say clean you mean zero?
> > 
> > No I meant clean, i.e. those that could be evicted from RAM without
> > causing I/O.
> 
> They must be migrated unless guest actually evicts them.

If the balloon is inflated the guest will.

> It's not at all clear to me that it's always preferable
> to drop all clean pages from pagecache. It is clearly is
> going to slow the guest down significantly.

That's a matter for optimization.  The current value for
/proc/meminfo:MemAvailable (which is being proposed as a member of
balloon stats, too) is a conservative estimate which will probably cover
a good deal of cases.

> > I must be missing something obvious, but how is that different from
> > inflating and then immediately deflating the balloon?
> 
> It's exactly the same except
> - we do not initiate this from host - it's guest doing
>   things for its own reasons
> - a bit less guest/host interaction this way

I don't quite understand why you need to deflate the balloon until the
VM is on the destination host.  deflate_on_oom will do it if the guest
is really tight on memory; otherwise there appears to be no reason for
it.  But then inflation followed immediately by deflation doubles the
guest/host interactions rather than reduces them, no?

> > it's just the granularity that makes things slow and
> > stands in the way.
> 
> So we could request a specific page size/alignment from guest.
> Send guest request to give us memory in aligned units of 2Mbytes,
> and then host can treat each of these as a single huge page.

I'd guess just coalescing contiguous pages would already speed things
up.  I'll try to find some time to experiment with it.

Roman.
