From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCHv8 3/3] vhost_net: a kernel-level virtio server
Date: Mon, 9 Nov 2009 13:55:48 +0200
Message-ID: <20091109115548.GA2368__9323.16090115837$1257768029$gmane$org@redhat.com>
References: <cover.1257349249.git.mst@redhat.com>
	<200911061529.17500.rusty@rustcorp.com.au>
	<20091108113516.GA19016@redhat.com>
	<200911091647.29655.rusty@rustcorp.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <200911091647.29655.rusty@rustcorp.com.au>
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
Cc: Eric Dumazet <eric.dumazet@gmail.com>, kvm@vger.kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, linux-mm@kvack.org, s.hetze@linux-ag.com, hpa@zytor.com, Daniel Walker <dwalker@fifo99.com>, mingo@elte.hu, akpm@linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On Mon, Nov 09, 2009 at 04:47:29PM +1030, Rusty Russell wrote:
> Actually, this looks wrong to me:
> 
> +	case VHOST_SET_VRING_BASE:
> ...
> +		vq->avail_idx = vq->last_avail_idx = s.num;
> 
> The last_avail_idx is part of the state of the driver.  It needs to be saved
> and restored over susp/resume.  The only reason it's not in the ring itself
> is because I figured the other side doesn't need to see it (which is true, but
> missed debugging opportunities as well as man-in-the-middle issues like this
> one).  I had a patch which put this field at the end of the ring, I might
> resurrect it to avoid this problem.  This is backwards compatible with all
> implementations.  See patch at end.
> 
> I would drop avail_idx altogether: get_user is basically free, and simplifies
> a lot.  As most state is in the ring, all you need is an ioctl to save/restore
> the last_avail_idx.

I remembered another reason for caching head in avail_idx.  Basically,
avail index could change between when I poll for descriptors and when I
want to notify guest.

So we could have:
	- poll descriptors until empty
	- notify
		detects not empty so does not notify

And the way to solve it would be to return flag from
notify telling us to restart the polling loop.

But, this will be more code, on data path, than
what happens today where I simply keep state
from descriptor polling and use that to notify.

I also suspect that somehow this race in practice can not create
deadlocks ... but I prefer to avoid it, these things are very tricky: if
I see an empty ring, and stop processing descriptors, I want to trigger
notify on empty.

So if we want to avoid keeping "empty" state, IMO the best way would be
to pass a flag to vhost_signal that tells it that ring is empty.
Makes sense?

-- 
MST
