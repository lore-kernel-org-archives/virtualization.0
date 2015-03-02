From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: virtio balloon: do not call blocking ops when !TASK_RUNNING
Date: Mon, 2 Mar 2015 21:39:05 +0100
Message-ID: <20150302203905.GA4942__1844.83027919686$1425328797$gmane$org@redhat.com>
References: <20150225111318.0040536b@oc7435384737.ibm.com>
	<87y4nllb85.fsf@rustcorp.com.au>
	<20150226083625.2520ecb6@oc7435384737.ibm.com>
	<8761akl0sh.fsf@rustcorp.com.au> <20150302111358.GA4954@redhat.com>
	<20150302123106.54a71968.cornelia.huck@de.ibm.com>
	<20150302114657.GB12040@redhat.com>
	<20150302131102.2388a582.cornelia.huck@de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20150302131102.2388a582.cornelia.huck@de.ibm.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Cornelia Huck <cornelia.huck@de.ibm.com>
Cc: Peter Zijlstra <peterz@infradead.org>, kvm@vger.kernel.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On Mon, Mar 02, 2015 at 01:11:02PM +0100, Cornelia Huck wrote:
> On Mon, 2 Mar 2015 12:46:57 +0100
> "Michael S. Tsirkin" <mst@redhat.com> wrote:
> 
> > On Mon, Mar 02, 2015 at 12:31:06PM +0100, Cornelia Huck wrote:
> > > On Mon, 2 Mar 2015 12:13:58 +0100
> > > "Michael S. Tsirkin" <mst@redhat.com> wrote:
> > > 
> > > > On Mon, Mar 02, 2015 at 10:37:26AM +1030, Rusty Russell wrote:
> > > > > Thomas Huth <thuth@linux.vnet.ibm.com> writes:
> > > > > > On Thu, 26 Feb 2015 11:50:42 +1030
> > > > > > Rusty Russell <rusty@rustcorp.com.au> wrote:
> > > > > >
> > > > > >> Thomas Huth <thuth@linux.vnet.ibm.com> writes:
> > > > > >> >  Hi all,
> > > > > >> >
> > > > > >> > with the recent kernel 3.19, I get a kernel warning when I start my
> > > > > >> > KVM guest on s390 with virtio balloon enabled:
> > > > > >> 
> > > > > >> The deeper problem is that virtio_ccw_get_config just silently fails on
> > > > > >> OOM.
> > > > > >> 
> > > > > >> Neither get_config nor set_config are expected to fail.
> > > > > >
> > > > > > AFAIK this is currently not a problem. According to
> > > > > > http://lwn.net/Articles/627419/ these kmalloc calls never
> > > > > > fail because they allocate less than a page.
> > > > > 
> > > > > I strongly suggest you unlearn that fact.
> > > > > The fix for this is in two parts:
> > > > > 
> > > > > 1) Annotate using sched_annotate_sleep() and add a comment: we may spin
> > > > >    a few times in low memory situations, but this isn't a high
> > > > >    performance path.
> > > > > 
> > > > > 2) Handle get_config (and other) failure in some more elegant way.
> > > 
> > > Do you mean we need to enable the caller to deal with get_config
> > > failures (and the transport to relay those failures)? I agree with that.
> > 
> > We can certainly tweak code to bypass need to kmalloc
> > on get_config.
> > 
> > Why is it doing these allocs? What's wrong with using
> > vcdev->config directly?
> 
> We'd need to make sure that vcdev->config is allocated with GFP_DMA, as
> we need it to be under 2G.

I see - and that's expensive when there are many devices?
One simple solution is to have a global buffer that everyone
reuses. It'll need a lock, naturally.

> And we need to be more careful wrt
> serialization,

Why does passing in vcdev->config mean we need to be more careful
than when we allocate a buffer and then memcpy into vcdev->config?

> especially if we want to reuse the ccw structure as
> well, for example. Nothing complicated, I'd just need some free time to
> do it :)
> 
> The more likely reason for get_config to fail is a device hotunplug,
> however. We'll get a seperate notification about that (via machine
> check + channel report), but it would be nice if we could stop poking
> the device immediately, as there's no use trying to do something with
> it anymore.

-- 
MST
