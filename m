From: Dongsu Park <dongsu.park@profitbricks.com>
Subject: Re: kernel BUG at drivers/block/virtio_blk.c:172!
Date: Thu, 13 Nov 2014 12:04:15 +0100
Message-ID: <20141113110415.GB16906@gmail.com>
References: <20141107080416.0837a88c@tlielax.poochiereds.net>
	<87bnofnzop.fsf@rustcorp.com.au> <54614AE7.2080204@kernel.dk>
	<CACVXFVOgRMqCUASOaXQ7ys8yiKZFEH5SA-+mV=H0uvHuGseENQ@mail.gmail.com>
	<20141111154250.GA16906@gmail.com>
	<CACVXFVNXSmw=Gu_9JAtpF3uxupSMr4kN2ge-jnZMxZAMcaHrfw@mail.gmail.com>
	<5463A478.20603@kernel.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <5463A478.20603@kernel.dk>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Jens Axboe <axboe@kernel.dk>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Dave Chinner <david@fromorbit.com>, xfs@oss.sgi.com, Lukas Czerner <lczerner@redhat.com>, Jeff Layton <jlayton@poochiereds.net>, Linux Virtualization <virtualization@lists.linux-foundation.org>, Christoph Hellwig <hch@lst.de>
List-Id: virtualization@lists.linuxfoundation.org

On 12.11.2014 11:18, Jens Axboe wrote:
> On 11/11/2014 09:42 AM, Ming Lei wrote:
> > The attached patch should fix the problem, and hope it is the last one, :-)
> 
> Dongsu and Jeff, any of you test this variant? I think this is the last
> one, at least I hope so as well...

Yes, I've just tested it again with the Ming's patch.
It passed a full cycle of xfstests: No crash, no particular regression.
The code in blk_recount_segments() seems to make sense too.

Thanks! ;-)
Dongsu
