From: Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: [PATCH RFC] virtio: use QUEUE_FLAG_CLUSTER in virtio_blk
Date: Mon, 17 Nov 2008 17:22:43 +1030
Message-ID: <200811171722.43792.rusty@rustcorp.com.au>
References: <200811141215.33950.rusty@rustcorp.com.au>
	<20081114093023.GQ26778@kernel.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20081114093023.GQ26778@kernel.dk>
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
To: Jens Axboe <jens.axboe@oracle.com>
Cc: kvm-devel <kvm-devel@lists.sourceforge.net>, Anthony Liguori <aliguori@us.ibm.com>, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On Friday 14 November 2008 20:00:23 Jens Axboe wrote:
> Queue clustering is on by default though when you allocate your queue,
> so I'm surprised you see a difference by doing:
>
> +	/* Gather adjacent buffers to minimize sg length. */
> +	queue_flag_set(QUEUE_FLAG_CLUSTER, vblk->disk->queue);
>
> did test_bit(QUEUE_FLAG_CLUSTER, &vblk->disk->queue->queue_flags) really
> return 0 before?

Apparently not.  My results must be noise :(

However, it made me look harder at the behaviour of the driver.  I have two 
other enhancement patches while I'll send now, but I still only see sgs of 116 
elements.

Thanks for the clue donation,
Rusty.
