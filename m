From: Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: virtio balloon: do not call blocking ops when !TASK_RUNNING
Date: Tue, 10 Mar 2015 11:56:27 +1030
Message-ID: <87oao1k5h8.fsf@rustcorp.com.au>
References: <20150225111318.0040536b@oc7435384737.ibm.com>
	<87y4nllb85.fsf@rustcorp.com.au>
	<20150226083625.2520ecb6@oc7435384737.ibm.com>
	<8761akl0sh.fsf@rustcorp.com.au> <20150302111358.GA4954@redhat.com>
	<87d24pjnkx.fsf@rustcorp.com.au>
	<20150304102556.GC26213@redhat.com>
	<20150306125616.64e9f317.cornelia.huck@de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20150306125616.64e9f317.cornelia.huck@de.ibm.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Cornelia Huck <cornelia.huck@de.ibm.com>, "Michael S. Tsirkin" <mst@redhat.com>
Cc: Peter Zijlstra <peterz@infradead.org>, kvm@vger.kernel.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

Cornelia Huck <cornelia.huck@de.ibm.com> writes:
> On Wed, 4 Mar 2015 11:25:56 +0100
> "Michael S. Tsirkin" <mst@redhat.com> wrote:
>
>> On Wed, Mar 04, 2015 at 04:44:54PM +1030, Rusty Russell wrote:
>> > "Michael S. Tsirkin" <mst@redhat.com> writes:
>> > > On Mon, Mar 02, 2015 at 10:37:26AM +1030, Rusty Russell wrote:
>> > >> Thomas Huth <thuth@linux.vnet.ibm.com> writes:
>> > >> > On Thu, 26 Feb 2015 11:50:42 +1030
>> > >> > Rusty Russell <rusty@rustcorp.com.au> wrote:
>> > >> >
>> > >> >> Thomas Huth <thuth@linux.vnet.ibm.com> writes:
>> > >> >> >  Hi all,
>> > >> >> >
>> > >> >> > with the recent kernel 3.19, I get a kernel warning when I start my
>> > >> >> > KVM guest on s390 with virtio balloon enabled:
>> > >> >> 
>> > >> >> The deeper problem is that virtio_ccw_get_config just silently fails on
>> > >> >> OOM.
>> > >> >> 
>> > >> >> Neither get_config nor set_config are expected to fail.
>> > >> >
>> > >> > AFAIK this is currently not a problem. According to
>> > >> > http://lwn.net/Articles/627419/ these kmalloc calls never
>> > >> > fail because they allocate less than a page.
>> > >> 
>> > >> I strongly suggest you unlearn that fact.
>> > >> The fix for this is in two parts:
>> > >> 
>> > >> 1) Annotate using sched_annotate_sleep() and add a comment: we may spin
>> > >>    a few times in low memory situations, but this isn't a high
>> > >>    performance path.
>> > >> 
>> > >> 2) Handle get_config (and other) failure in some more elegant way.
>> > >> 
>> > >> Cheers,
>> > >> Rusty.
>> > >
>> > > I agree, but I'd like to point out that even without kmalloc,
>> > > on s390 get_config is blocking - it's waiting
>> > > for a hardware interrupt.
>> > >
>> > > And it makes sense: config is not data path, I don't think
>> > > we should spin there.
>> > >
>> > > So I think besides these two parts, we still need my two patches:
>> > >     virtio-balloon: do not call blocking ops when !TASK_RUNNING
>> > 
>> > I prefer to annotate, over trying to fix this.
>> > 
>> > Because it's not important.  We might spin a few times, but it's very
>> > unlikely, and it's certainly not performance critical.
>> > 
>> > Thanks,
>> > Rusty.
>> > 
>> > Subject: virtio_balloon: annotate possible sleep waiting for event.
>> > 
>> > CCW (s390) does this.
>> > 
>> > Reported-by: Thomas Huth <thuth@linux.vnet.ibm.com>
>> > Signed-off-by: Rusty Russell <rusty@rustcorp.com.au>
>> > 
>> > diff --git a/drivers/virtio/virtio_balloon.c b/drivers/virtio/virtio_balloon.c
>> > index 0413157f3b49..3f4d5acdbde0 100644
>> > --- a/drivers/virtio/virtio_balloon.c
>> > +++ b/drivers/virtio/virtio_balloon.c
>> > @@ -340,6 +340,15 @@ static int balloon(void *_vballoon)
>> >  		s64 diff;
>> >  
>> >  		try_to_freeze();
>> > +
>> > +		/*
>> > +		 * Reading the config on the ccw backend involves an
>> > +		 * allocation, so we may actually sleep and have an
>> > +		 * extra iteration.  It's extremely unlikely,
>> 
>> Hmm, this part of the comment seems wrong to me.
>> Reading the config on the ccw backend always sleeps
>> because it's interrupt driven.
>
> (...)
>
>> So I suspect
>> http://mid.gmane.org/1424874878-17155-1-git-send-email-mst@redhat.com
>> is better.
>> 
>> What do you think?
>
> I'd prefer to fix this as well. While the I/O request completes
> instantly on current qemu (the ssch backend handles the start function
> immediately, not asynchronously as on real hardware), this (a) is an
> implementation detail that may change and (b) doesn't account for the
> need to deliver the interrupt to the guest - which might take non-zero
> time.

Ah, I see.  My mistake.

I've thrown out my patch, applied that one.

Thanks,
Rusty.
