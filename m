From: Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: [PATCH 1/2] virtio: block: set max_segment_size and max_sectors
	to infinite.
Date: Thu, 27 Nov 2008 23:30:02 +1030
Message-ID: <200811272330.03308.rusty@rustcorp.com.au>
References: <200811141215.33950.rusty@rustcorp.com.au>
	<200811171724.15682.rusty@rustcorp.com.au>
	<20081126174225.GD19881@sequoia.sous-sol.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20081126174225.GD19881@sequoia.sous-sol.org>
Content-Disposition: inline
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Chris Wright <chrisw@sous-sol.org>
Cc: kvm-devel <kvm-devel@lists.sourceforge.net>, Anthony Liguori <aliguori@us.ibm.com>, virtualization@lists.linux-foundation.org, Jens Axboe <jens.axboe@oracle.com>
List-Id: virtualization@lists.linuxfoundation.org

On Thursday 27 November 2008 04:12:25 Chris Wright wrote:
> * Rusty Russell (rusty@rustcorp.com.au) wrote:
> > +	/* No real sector limit. */
> > +	blk_queue_max_sectors(vblk->disk->queue, -1U);
> > +
>
> Is that actually legitimate?  I think it'd still work out, but seems
> odd, e.g. all the spots that do:
>
> 	q->max_hw_sectors << 9
>
> will just toss the upper bits...

I think this just indicates that *my driver* doesn't have an issue with large 
numbers of sectors.  The block layer may well...

Rusty.


>
> thanks,
> -chris
