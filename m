From: Mark Rutland <mark.rutland@arm.com>
Subject: Re: [PATCH 0/3] virtio/vringh: kill off ACCESS_ONCE()
Date: Fri, 25 Nov 2016 17:43:00 +0000
Message-ID: <20161125174259.GB30811__37167.5253184096$1480112170$gmane$org@leverpostej>
References: <20161125112203.GA26611@leverpostej>
	<32dfca07-59f3-b75a-3154-cf6b6c8538f0@de.ibm.com>
	<20161125122356.GB26611@leverpostej>
	<20161125124044.GN3092@twins.programming.kicks-ass.net>
	<20161125124404.GI3174@twins.programming.kicks-ass.net>
	<20161125145512.GA4014@Boquns-MacBook-Pro.local>
	<CACT4Y+ZpzFhmSqOG+dG7QHSNObWatLOjPjNK2BznnRLeRQpF8A@mail.gmail.com>
	<20161125161004.GA30181@leverpostej>
	<20161125161709.GQ3092@twins.programming.kicks-ass.net>
	<CACT4Y+YJUUjU_FCR1FOcF2DmkkcjiRFpnU7Q4=yzbgvKv0VhyQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <CACT4Y+YJUUjU_FCR1FOcF2DmkkcjiRFpnU7Q4=yzbgvKv0VhyQ@mail.gmail.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Dmitry Vyukov <dvyukov@google.com>
Cc: Davidlohr Bueso <dave@stgolabs.net>, KVM list <kvm@vger.kernel.org>, "Michael S. Tsirkin" <mst@redhat.com>, Peter Zijlstra <peterz@infradead.org>, netdev <netdev@vger.kernel.org>, Boqun Feng <boqun.feng@gmail.com>, dbueso@suse.de, LKML <linux-kernel@vger.kernel.org>, virtualization@lists.linux-foundation.org, Paul McKenney <paulmck@linux.vnet.ibm.com>, Linus Torvalds <torvalds@linux-foundation.org>
List-Id: virtualization@lists.linuxfoundation.org

On Fri, Nov 25, 2016 at 06:28:53PM +0100, Dmitry Vyukov wrote:
> On Fri, Nov 25, 2016 at 5:17 PM, Peter Zijlstra <peterz@infradead.org> wrote:
> >> > What are use cases for such primitive that won't be OK with "read once
> >> > _and_ atomically"?
> >>
> >> I have none to hand.
> >
> > Whatever triggers the __builtin_memcpy() paths, and even the size==8
> > paths on 32bit.
> >
> > You could put a WARN in there to easily find them.
> >
> > The advantage of introducing the SINGLE_{LOAD,STORE}() helpers is that
> > they compiletime validate this the size is 'right' and can runtime check
> > alignment constraints.
> >
> > IE, they are strictly stronger than {READ,WRITE}_ONCE().
> 
> Uh, so, READ/WRITE_ONCE are non-atomic now. I missed that.

Yes, but *only* for types larger than word size. That has *always* been
the case.

It's still assumed that *_ONCE are single-copy-atomic for word size (or
smaller). Some architectures may also provide that guarnatee for
accesses larger than word size (e.g. 32-bit ARM w/ LPAE).

... It's just that as things stand we can't put checks in *_ONCE() for
the access size, since they're *also* used for larger accesses that
don't need atomicity.

> If READ/WRITE_ONCE are non-atomic, half of kernel is broken. All these
> loads of flags, ringbuffer positions, pointers, etc are broken.

Most of these will be fine, as above.

> What about restoring READ/WRITE_ONCE as atomic, and introducing
> separate primitives for _non_ atomic loads/stores?

Having a separate *_ONCE_TEARABLE() would certainly limit the number of
things we have to fix up, and would also make it clear that atomicity is
not expected.

... but we might have to go with SINGLE_*() if we can't convince Linus.

Thanks,
Mark.
