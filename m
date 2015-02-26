From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: virtio balloon: do not call blocking ops when !TASK_RUNNING
Date: Thu, 26 Feb 2015 18:08:49 +0100
Message-ID: <20150226170849.GV21418@twins.programming.kicks-ass.net>
References: <20150225111318.0040536b@oc7435384737.ibm.com>
	<87y4nllb85.fsf@rustcorp.com.au>
	<20150226083031.GA24184@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20150226083031.GA24184@redhat.com>
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
Cc: kvm@vger.kernel.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On Thu, Feb 26, 2015 at 09:30:31AM +0100, Michael S. Tsirkin wrote:
> On Thu, Feb 26, 2015 at 11:50:42AM +1030, Rusty Russell wrote:
> > Thomas Huth <thuth@linux.vnet.ibm.com> writes:
> > >  Hi all,
> > >
> > > with the recent kernel 3.19, I get a kernel warning when I start my
> > > KVM guest on s390 with virtio balloon enabled:
> > 
> > The deeper problem is that virtio_ccw_get_config just silently fails on
> > OOM.
> > 
> > Neither get_config nor set_config are expected to fail.
> > 
> > Cornelia, I think ccw and config_area should be allocated inside vcdev.
> > You could either use pointers, or simply allocate vcdev with GDP_DMA.
> > 
> > This would avoid the kmalloc inside these calls.
> > 
> > Thanks,
> > Rusty.
> 
> But it won't solve the problem of nested sleepers
> with ccw: ATM is invokes ccw_io_helper to execute
> commands, and that one calls wait_event
> to wait for an interrupt.
> 
> Might be fixable but I think my patch looks like a safer
> solution for 4.0/3.19, no?

I've no idea what your patch was since I'm not subscribed to any of the
lists this discussion is had on.

But you can annotate the warning away; _however_ with the annotation
needs to be a big comment explaining why its safe to do so. Typically to
involved talking about how its actually rare for the call to sleep.

So occasional sleeps inside a wait_event() are ok-ish, we'll just get to
go around once more. But once you consistently sleep inside a
wait_event() things go a bit funny.

So for instance; if in ccw_io_helper() we expect that wait_event(,
!doing_io()) to be (mostly) true on first go, then we'll never get into
__wait_event() and ->state won't actually be mucked about with.

The thing to avoid is not actually sleeping (much) but setting
TASK_RUNNING and turning the entire thing into a giant poll loop.
