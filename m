From: Stefan Hajnoczi <stefanha@linux.vnet.ibm.com>
Subject: Re: [RFC] virtio: Support releasing lock during kick
Date: Fri, 25 Jun 2010 17:05:51 +0100
Message-ID: <20100625160550.GA30610__14597.288988489$1277482087$gmane$org@stefan-thinkpad.transitives.com>
References: <1277328242-10685-1-git-send-email-stefanha@linux.vnet.ibm.com>
	<4C2286BE.40808@codemonkey.ws>
	<AANLkTim6CH_NruBFqK6fIkMkKpAuCIef50mHfldMtNH9@mail.gmail.com>
	<201006251239.23224.rusty@rustcorp.com.au>
	<20100625104317.GC16321@redhat.com>
	<20100625153143.GA12784@stefan-thinkpad.transitives.com>
	<20100625153220.GB17911@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20100625153220.GB17911@redhat.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: kvm@vger.kernel.org, Anthony Liguori <anthony@codemonkey.ws>, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On Fri, Jun 25, 2010 at 06:32:20PM +0300, Michael S. Tsirkin wrote:
> On Fri, Jun 25, 2010 at 04:31:44PM +0100, Stefan Hajnoczi wrote:
> > On Fri, Jun 25, 2010 at 01:43:17PM +0300, Michael S. Tsirkin wrote:
> > > On Fri, Jun 25, 2010 at 12:39:21PM +0930, Rusty Russell wrote:
> > > > On Thu, 24 Jun 2010 03:00:30 pm Stefan Hajnoczi wrote:
> > > > > On Wed, Jun 23, 2010 at 11:12 PM, Anthony Liguori <anthony@codemonkey.ws> wrote:
> > > > > > Shouldn't it be possible to just drop the lock before invoking
> > > > > > virtqueue_kick() and reacquire it afterwards?  There's nothing in that
> > > > > > virtqueue_kick() path that the lock is protecting AFAICT.
> > > > > 
> > > > > No, that would lead to a race condition because vq->num_added is
> > > > > modified by both virtqueue_add_buf_gfp() and virtqueue_kick().
> > > > > Without a lock held during virtqueue_kick() another vcpu could add
> > > > > bufs while vq->num_added is used and cleared by virtqueue_kick():
> > > > 
> > > > Right, this dovetails with another proposed change (was it Michael?)
> > > > where we would update the avail idx inside add_buf, rather than waiting
> > > > until kick.  This means a barrier inside add_buf, but that's probably
> > > > fine.
> > > > 
> > > > If we do that, then we don't need a lock on virtqueue_kick.
> > > > 
> > > > Michael, thoughts?
> > > 
> > > Maybe not even that: I think we could just do virtio_wmb()
> > > in add, and keep the mb() in kick.
> > > 
> > > What I'm a bit worried about is contention on the cacheline
> > > including index and flags: the more we write to that line,
> > > the worse it gets.
> > > 
> > > So need to test performance impact of this change:
> > > I didn't find time to do this yet, as I am trying
> > > to finalize the used index publishing patches.
> > > Any takers?
> > > 
> > > Do we see performance improvement after making kick lockless?
> > 
> > There was no guest CPU reduction or I/O throughput increase with my
> > patch when running 4 dd iflag=direct bs=4k if=/dev/vdb of=/dev/null
> > processes.  However, the lock_stat numbers above show clear improvement
> > of the lock hold/wait times.
> > 
> > I was hoping to see guest CPU utilization go down and I/O throughput go
> > up, so there is still investigation to do with my patch in isolation.
> > Although I'd like to try it later, putting my patch on top of your avail
> > idx work is too early because it will be harder to reason about the
> > performance with both patches present at the same time.
> > 
> > Stefan
> 
> What about host CPU utilization?

There is data available for host CPU utilization, I need to dig it up.

> Also, are you using PARAVIRT_SPINLOCKS?

No.  I haven't found much documentation on paravirt spinlocks other than
the commit that introduced them:

  commit 8efcbab674de2bee45a2e4cdf97de16b8e609ac8
  Author: Jeremy Fitzhardinge <jeremy@goop.org>
  Date:   Mon Jul 7 12:07:51 2008 -0700

      paravirt: introduce a "lock-byte" spinlock implementation

PARAVIRT_SPINLOCKS is not set in the config I use, probably because of
the associated performance issue that causes distros to build without
them:

  commit b4ecc126991b30fe5f9a59dfacda046aeac124b2
  Author: Jeremy Fitzhardinge <jeremy@goop.org>
  Date:   Wed May 13 17:16:55 2009 -0700

      x86: Fix performance regression caused by paravirt_ops on native
      kernels

I would expect performance results to be smoother with
PARAVIRT_SPINLOCKS for the guest kernel.  I will add it for future runs,
thanks for pointing it out.

Stefan
