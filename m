From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH tip/core/rcu 21/21] drivers/vhost: Remove now-redundant
	read_barrier_depends()
Date: Tue, 5 Dec 2017 20:31:20 +0200
Message-ID: <20171205202928-mutt-send-email-mst__45106.3319379047$1512498698$gmane$org@kernel.org>
References: <20171201195053.GA23494@linux.vnet.ibm.com>
	<1512157876-24665-21-git-send-email-paulmck@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <1512157876-24665-21-git-send-email-paulmck@linux.vnet.ibm.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Cc: tglx@linutronix.de, kvm@vger.kernel.org, peterz@infradead.org, fweisbec@gmail.com, jiangshanlai@gmail.com, linux-kernel@vger.kernel.org, rostedt@goodmis.org, josh@joshtriplett.org, dhowells@redhat.com, edumazet@google.com, netdev@vger.kernel.org, mathieu.desnoyers@efficios.com, oleg@redhat.com, dipankar@in.ibm.com, akpm@linux-foundation.org, virtualization@lists.linux-foundation.org, mingo@kernel.org
List-Id: virtualization@lists.linuxfoundation.org

On Fri, Dec 01, 2017 at 11:51:16AM -0800, Paul E. McKenney wrote:
> Because READ_ONCE() now implies read_barrier_depends(), the
> read_barrier_depends() in next_desc() is now redundant.  This commit
> therefore removes it and the related comments.
> 
> Signed-off-by: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
> Cc: "Michael S. Tsirkin" <mst@redhat.com>
> Cc: Jason Wang <jasowang@redhat.com>
> Cc: <kvm@vger.kernel.org>
> Cc: <virtualization@lists.linux-foundation.org>
> Cc: <netdev@vger.kernel.org>

Apropos, READ_ONCE is now asymmetrical with WRITE_ONCE.

I can read a pointer with READ_ONCE and be sure the value
is sane, but only if I also remember to put in smp_wmb before
WRITE_ONCE. Otherwise the pointer is ok but no guarantees
about the data pointed to.

It would be better if the API reflected he assymetry somehow.

> ---
>  drivers/vhost/vhost.c | 7 +------
>  1 file changed, 1 insertion(+), 6 deletions(-)
> 
> diff --git a/drivers/vhost/vhost.c b/drivers/vhost/vhost.c
> index 33ac2b186b85..78b5940a415a 100644
> --- a/drivers/vhost/vhost.c
> +++ b/drivers/vhost/vhost.c
> @@ -1877,12 +1877,7 @@ static unsigned next_desc(struct vhost_virtqueue *vq, struct vring_desc *desc)
>  		return -1U;
>  
>  	/* Check they're not leading us off end of descriptors. */
> -	next = vhost16_to_cpu(vq, desc->next);
> -	/* Make sure compiler knows to grab that: we don't want it changing! */
> -	/* We will use the result as an index in an array, so most
> -	 * architectures only need a compiler barrier here. */
> -	read_barrier_depends();
> -
> +	next = vhost16_to_cpu(vq, READ_ONCE(desc->next));
>  	return next;
>  }
>  
> -- 
> 2.5.2
