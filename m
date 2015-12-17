From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH] virtio_ring: use smp_store_mb
Date: Thu, 17 Dec 2015 12:22:22 +0100
Message-ID: <20151217112222.GC6375__10815.8308816657$1450351367$gmane$org@twins.programming.kicks-ass.net>
References: <1450347932-16325-1-git-send-email-mst@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <1450347932-16325-1-git-send-email-mst@redhat.com>
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
Cc: qemu-devel@nongnu.org, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On Thu, Dec 17, 2015 at 12:32:53PM +0200, Michael S. Tsirkin wrote:
> Seems to give a speedup on my box but I'm less sure about this one.  E.g. as
> xchng faster than mfence on all/most intel CPUs? Anyone has an opinion?

Would help if you Cc people who would actually know this :-)

Yes, we've recently established that xchg is indeed faster than mfence
on at least recent machines, see:

  lkml.kernel.org/r/CA+55aFynbkeuUGs9s-q+fLY6MeRBA6MjEyWWbbe7A5AaqsAknw@mail.gmail.com

> +static inline void virtio_store_mb(bool weak_barriers,
> +				   __virtio16 *p, __virtio16 v)
> +{
> +#ifdef CONFIG_SMP
> +	if (weak_barriers)
> +		smp_store_mb(*p, v);
> +	else
> +#endif
> +	{
> +		WRITE_ONCE(*p, v);
> +		mb();
> +	}
> +}

Note that virtio_mb() is weirdly inconsistent with virtio_[rw]mb() in
that they use dma_* ops for weak_barriers, while virtio_mb() uses
smp_mb().

As previously stated, smp_mb() does not cover the same memory domains as
dma_mb() would.
