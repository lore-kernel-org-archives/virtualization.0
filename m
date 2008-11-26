From: Chris Wright <chrisw@sous-sol.org>
Subject: Re: [PATCH 1/2] virtio: block: set max_segment_size and
	max_sectors to infinite.
Date: Wed, 26 Nov 2008 09:42:25 -0800
Message-ID: <20081126174225.GD19881@sequoia.sous-sol.org>
References: <200811141215.33950.rusty@rustcorp.com.au>
	<20081114093023.GQ26778@kernel.dk>
	<200811171722.43792.rusty@rustcorp.com.au>
	<200811171724.15682.rusty@rustcorp.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <200811171724.15682.rusty@rustcorp.com.au>
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
Cc: kvm-devel <kvm-devel@lists.sourceforge.net>, Anthony Liguori <aliguori@us.ibm.com>, virtualization@lists.linux-foundation.org, Jens Axboe <jens.axboe@oracle.com>
List-Id: virtualization@lists.linuxfoundation.org

* Rusty Russell (rusty@rustcorp.com.au) wrote:
> +	/* No real sector limit. */
> +	blk_queue_max_sectors(vblk->disk->queue, -1U);
> +

Is that actually legitimate?  I think it'd still work out, but seems
odd, e.g. all the spots that do:

	q->max_hw_sectors << 9

will just toss the upper bits...

thanks,
-chris
