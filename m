From: Cornelia Huck <cornelia.huck@de.ibm.com>
Subject: Re: virtio balloon: do not call blocking ops when !TASK_RUNNING
Date: Mon, 2 Mar 2015 12:31:06 +0100
Message-ID: <20150302123106.54a71968.cornelia.huck__40120.4434027479$1425295894$gmane$org@de.ibm.com>
References: <20150225111318.0040536b@oc7435384737.ibm.com>
	<87y4nllb85.fsf@rustcorp.com.au>
	<20150226083625.2520ecb6@oc7435384737.ibm.com>
	<8761akl0sh.fsf@rustcorp.com.au> <20150302111358.GA4954@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20150302111358.GA4954@redhat.com>
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
Cc: Peter Zijlstra <peterz@infradead.org>, kvm@vger.kernel.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On Mon, 2 Mar 2015 12:13:58 +0100
"Michael S. Tsirkin" <mst@redhat.com> wrote:

> On Mon, Mar 02, 2015 at 10:37:26AM +1030, Rusty Russell wrote:
> > Thomas Huth <thuth@linux.vnet.ibm.com> writes:
> > > On Thu, 26 Feb 2015 11:50:42 +1030
> > > Rusty Russell <rusty@rustcorp.com.au> wrote:
> > >
> > >> Thomas Huth <thuth@linux.vnet.ibm.com> writes:
> > >> >  Hi all,
> > >> >
> > >> > with the recent kernel 3.19, I get a kernel warning when I start my
> > >> > KVM guest on s390 with virtio balloon enabled:
> > >> 
> > >> The deeper problem is that virtio_ccw_get_config just silently fails on
> > >> OOM.
> > >> 
> > >> Neither get_config nor set_config are expected to fail.
> > >
> > > AFAIK this is currently not a problem. According to
> > > http://lwn.net/Articles/627419/ these kmalloc calls never
> > > fail because they allocate less than a page.
> > 
> > I strongly suggest you unlearn that fact.
> > The fix for this is in two parts:
> > 
> > 1) Annotate using sched_annotate_sleep() and add a comment: we may spin
> >    a few times in low memory situations, but this isn't a high
> >    performance path.
> > 
> > 2) Handle get_config (and other) failure in some more elegant way.

Do you mean we need to enable the caller to deal with get_config
failures (and the transport to relay those failures)? I agree with that.

> > 
> > Cheers,
> > Rusty.
> 
> I agree, but I'd like to point out that even without kmalloc,
> on s390 get_config is blocking - it's waiting
> for a hardware interrupt.
> 
> And it makes sense: config is not data path, I don't think
> we should spin there.
> 
> So I think besides these two parts, we still need my two patches:
>     virtio-balloon: do not call blocking ops when !TASK_RUNNING
>     virtio_console: avoid config access from irq
> in 4.0.
> 
> agree?

I agree that we need those fixes as well.
