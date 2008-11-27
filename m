From: Jens Axboe <jens.axboe@oracle.com>
Subject: Re: [PATCH 1/2] virtio: block: set max_segment_size and max_sectors
	to infinite.
Date: Thu, 27 Nov 2008 14:04:10 +0100
Message-ID: <20081127130410.GD22752@kernel.dk>
References: <200811141215.33950.rusty@rustcorp.com.au>
	<200811171724.15682.rusty@rustcorp.com.au>
	<20081126174225.GD19881@sequoia.sous-sol.org>
	<200811272330.03308.rusty@rustcorp.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <200811272330.03308.rusty@rustcorp.com.au>
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
Cc: Chris Wright <chrisw@sous-sol.org>, kvm-devel <kvm-devel@lists.sourceforge.net>, Anthony Liguori <aliguori@us.ibm.com>, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On Thu, Nov 27 2008, Rusty Russell wrote:
> On Thursday 27 November 2008 04:12:25 Chris Wright wrote:
> > * Rusty Russell (rusty@rustcorp.com.au) wrote:
> > > +	/* No real sector limit. */
> > > +	blk_queue_max_sectors(vblk->disk->queue, -1U);
> > > +
> >
> > Is that actually legitimate?  I think it'd still work out, but seems
> > odd, e.g. all the spots that do:
> >
> > 	q->max_hw_sectors << 9
> >
> > will just toss the upper bits...
> 
> I think this just indicates that *my driver* doesn't have an issue
> with large numbers of sectors.  The block layer may well...

We should probably just truncate insanely large values like -1 to
something sane. For the above case we already do trunc it to 1MB, as
it's the soft IO size. The segment size is already in bytes, so in fact
everything already looks fine.

-- 
Jens Axboe
