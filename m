From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH] virtio_ring: use smp_store_mb
Date: Thu, 17 Dec 2015 11:52:38 +0100
Message-ID: <20151217105238.GA6375@twins.programming.kicks-ass.net>
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

This is a different barrier depending on SMP, that seems wrong.

smp_mb(), as (should be) used by smp_store_mb() does not provide a
barrier against IO. mb() otoh does.

Since this is virtIO I would expect you always want mb().
