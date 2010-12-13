From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH 2/2] tools/virtio: virtio_test tool
Date: Mon, 13 Dec 2010 19:14:32 +0200
Message-ID: <20101213171432.GB7182@redhat.com>
References: <20101129170431.GA4027@redhat.com>
	<20101129171637.GC4027@redhat.com>
	<201012061523.03108.rusty@rustcorp.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <201012061523.03108.rusty@rustcorp.com.au>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: linux-kernel@vger.kernel.org, kvm@vger.kernel.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On Mon, Dec 06, 2010 at 03:23:02PM +1030, Rusty Russell wrote:
> On Tue, 30 Nov 2010 03:46:37 am Michael S. Tsirkin wrote:
> > This is the userspace part of the tool: it includes a bunch of stubs for
> > linux APIs, somewhat simular to linuxsched. This makes it possible to
> > recompile the ring code in userspace.
> > 
> > A small test example is implemented combining this with vhost_test
> > module.
> > 
> > Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> 
> Hi Michael,
> 
>   I'm not sure what the point is of this work?  You'll still need to
> benchmark on real systems, but it's not low-level enough to measure
> things like cache misses.

The point is to be able to create easy to test workloads:
(just running the single test included here produces a
 result that seems repeatable to a high degree)
while still staying as close as possible to what we might expect in real
life.

I also want to be able to measure just the overhead of the ring,
without involving block or network core in guest and host.

In other words, it's a synthetic benchmark.

> I'm assuming you're thinking of playing with layout to measure cache
> behaviour.

In one example, using this test I saw that different publish
used index layouts don't seem to behave at all differently.

But I also saw that the extra pointer hasing
added by my publish used index patches did add
measureable overhead.

Plan to look into that.

>  I was thinking of a complete userspace implementation

The disadvantage is that any work done there needs to be
redone in real life, though. And implementation details often matter.
What I did let me actually use the virtio/vhost code that we have and see how
it performs.

> where
> either it was run under cachegrind, or each access was wrapped to allow
> tracking of cachelines to give an exact measure of cache movement

perf stat not good enough?

> under
> various scenarios (esp. ring mostly empty, ring in steady state, ring
> mostly full).

Yes, I do want to add tests to stress various scenarios.

> 
> Cheers,
> Rusty.


-- 
MST
