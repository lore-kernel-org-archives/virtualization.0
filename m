From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH 08/16] virtio_ring: virtqueue_add_outbuf /
	virtqueue_add_inbuf.
Date: Mon, 25 Feb 2013 23:35:04 +0200
Message-ID: <20130225213504.GC18167@redhat.com>
References: <1361260594-601-1-git-send-email-rusty@rustcorp.com.au>
	<1361260594-601-9-git-send-email-rusty@rustcorp.com.au>
	<20130221170902.GA27097@redhat.com>
	<87sj4pfc61.fsf@rustcorp.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <87sj4pfc61.fsf@rustcorp.com.au>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: Paolo Bonzini <pbonzini@redhat.com>, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On Fri, Feb 22, 2013 at 10:32:46AM +1030, Rusty Russell wrote:
> "Michael S. Tsirkin" <mst@redhat.com> writes:
> > On Tue, Feb 19, 2013 at 06:26:26PM +1030, Rusty Russell wrote:
> >> These are specialized versions of virtqueue_add_buf(), which cover
> >> over 50% of cases and are far clearer.
> >> 
> >> In particular, the scatterlists passed to these functions don't have
> >> to be clean (ie. we ignore end markers).
> >> 
> >> FIXME: I'm not sure about the unclean sglist bit.  I had a more
> >> ambitious one which conditionally ignored end markers in the iterator,
> >> but it was ugly and I suspect this is just as fast.  Maybe we should
> >> just fix all the drivers?
> >> 
> >> Signed-off-by: Rusty Russell <rusty@rustcorp.com.au>
> >
> > Looking at code, it seems that most users really have a single sg, in
> > low memory. So how about simply passing void * instead of sg? Whoever
> > has multiple sgs can use the rich interface.
> 
> Good point, let's do that:
> 1) Make virtqueue_add_outbuf()/inbuf() take a void * and len.
> 2) Transfer users across to use that.
> 3) Make everyone else use clean scatterlists with virtqueue_add_sgs[].
> 4) Remove virtqueue_add_bufs().
> 
> > Long term we might optimize this unrolling some loops, I think
> > I saw this giving a small performance gain for -net.
> 
> I *think* we could make virtqueue_add() an inline and implement an
> virtqueue_add_outsg() wrapper and gcc will eliminate the loops for us.
> But not sure it's worth the text bloat...
> 
> Cheers,
> Rusty.

inline is mostly useless nowdays...  We can make it a static function and
let gcc decide.

-- 
MST
