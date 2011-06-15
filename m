From: Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH 1/1] [virt] virtio-blk: Use ida to allocate disk index
Date: Wed, 15 Jun 2011 09:06:38 +0200
Message-ID: <20110615070638.GI8141__35441.95313375$1308121735$gmane$org@htj.dyndns.org>
References: <1306913069-23637-1-git-send-email-dwu@redhat.com>
	<87mxi1xfz0.fsf@rustcorp.com.au> <4DEF744D.9040702@redhat.com>
	<87mxhrgba6.fsf@rustcorp.com.au>
	<20110609091433.GB11773@htj.dyndns.org>
	<4DF0A374.6090504@redhat.com> <87mxhjzogo.fsf@rustcorp.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <87mxhjzogo.fsf@rustcorp.com.au>
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
Cc: Jens Axboe <axboe@kernel.dk>, Mark Wu <dwu@redhat.com>, kvm@vger.kernel.org, "Michael S. Tsirkin" <mst@redhat.com>, Greg Kroah-Hartman <gregkh@suse.de>, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

Hello,

On Wed, Jun 15, 2011 at 02:21:51PM +0930, Rusty Russell wrote:
> > +	if (index_to_minor(index) >= 1 << MINORBITS) {
> > +		err =  -ENOSPC;
> > +		goto out_free_index;
> > +	}
> 
> Is this *really* how this is supposed to be used?
> 
> Tejun, this is your code.  What do you think of something like this?
> (untested)

It's inherited from idr which was designed to have separate
prepare/allocation stages so that allocation can happen inside an
outer spinlock.  It doesn't have too much to do with optimization.
It's mostly to be able to use sleepable context for memory allocation
while allowing atomic id[ra] allocation.

>  /**
> + * ida_simple_get - get a new id.
> + * @ida: the (initialized) ida.
> + * @min_id: the minimum id (inclusive)
> + * @max_id: the maximum id (inclusive)
> + *
> + * Allocates an id in the range min_id <= id <= max_id, or returns -ENOSPC.
> + * On allocation failure, returns -ENOMEM.  This function can sleep.
> + *
> + * Use ida_simple_remove() to get rid of an id.
> + */
> +int ida_simple_get(struct ida *ida, int min_id, int max_id)

Hmmm... new interface different from existing id[ra] style, but yeah
something like the above would have made more sense from the
beginning.  The only thing is that isn't (begin <= range < end) more
conventional form to express ranges?

Thanks.

-- 
tejun
