From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH v3 07/19] vhost: Remove redundant use of
 read_barrier_depends() barrier
Date: Mon, 13 Jul 2020 07:27:01 -0400
Message-ID: <20200713072618-mutt-send-email-mst@kernel.org>
References: <20200710165203.31284-1-will@kernel.org>
 <20200710165203.31284-8-will@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20200710165203.31284-8-will@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Will Deacon <will@kernel.org>
Cc: linux-kernel@vger.kernel.org, Joel Fernandes <joelaf@google.com>, Sami Tolvanen <samitolvanen@google.com>, Nick Desaulniers <ndesaulniers@google.com>, Kees Cook <keescook@chromium.org>, Marco Elver <elver@google.com>, "Paul E. McKenney" <paulmck@kernel.org>, Matt Turner <mattst88@gmail.com>, Ivan Kokshaysky <ink@jurassic.park.msu.ru>, Richard Henderson <rth@twiddle.net>, Peter Zijlstra <peterz@infradead.org>, Alan Stern <stern@rowland.harvard.edu>, Jason Wang <jasowang@redhat.com>, Arnd Bergmann <arnd@arndb.de>, Boqun Feng <boqun.feng@gmail.com>, Catalin Marinas <catalin.marinas@arm.com>, Mark Rutland <mark.rutland@arm.com>, linux-arm-kernel@lists.infradead.org, linux-alpha@vger.kernel.org, virtualization@lists.linux-foundation.org, kernel-team@andro
List-Id: virtualization@lists.linuxfoundation.org

On Fri, Jul 10, 2020 at 05:51:51PM +0100, Will Deacon wrote:
> Since commit 76ebbe78f739 ("locking/barriers: Add implicit
> smp_read_barrier_depends() to READ_ONCE()"), there is no need to use
> smp_read_barrier_depends() outside of the Alpha architecture code.
> 
> Unfortunately, there is precisely _one_ user in the vhost code, and
> there isn't an obvious READ_ONCE() access making the barrier
> redundant. However, on closer inspection (thanks, Jason), it appears
> that vring synchronisation between the producer and consumer occurs via
> the 'avail_idx' field, which is followed up by an rmb() in
> vhost_get_vq_desc(), making the read_barrier_depends() redundant on
> Alpha.
> 
> Jason says:
> 
>   | I'm also confused about the barrier here, basically in driver side
>   | we did:
>   |
>   | 1) allocate pages
>   | 2) store pages in indirect->addr
>   | 3) smp_wmb()
>   | 4) increase the avail idx (somehow a tail pointer of vring)
>   |
>   | in vhost we did:
>   |
>   | 1) read avail idx
>   | 2) smp_rmb()
>   | 3) read indirect->addr
>   | 4) read from indirect->addr
>   |
>   | It looks to me even the data dependency barrier is not necessary
>   | since we have rmb() which is sufficient for us to the correct
>   | indirect->addr and driver are not expected to do any writing to
>   | indirect->addr after avail idx is increased
> 
> Remove the redundant barrier invocation.
> 
> Suggested-by: Jason Wang <jasowang@redhat.com>
> Acked-by: Paul E. McKenney <paulmck@kernel.org>
> Signed-off-by: Will Deacon <will@kernel.org>


I agree

Acked-by: Michael S. Tsirkin <mst@redhat.com>

Pls merge with the rest of the patchset.

> ---
>  drivers/vhost/vhost.c | 5 -----
>  1 file changed, 5 deletions(-)
> 
> diff --git a/drivers/vhost/vhost.c b/drivers/vhost/vhost.c
> index d7b8df3edffc..74d135ee7e26 100644
> --- a/drivers/vhost/vhost.c
> +++ b/drivers/vhost/vhost.c
> @@ -2092,11 +2092,6 @@ static int get_indirect(struct vhost_virtqueue *vq,
>  		return ret;
>  	}
>  	iov_iter_init(&from, READ, vq->indirect, ret, len);
> -
> -	/* We will use the result as an address to read from, so most
> -	 * architectures only need a compiler barrier here. */
> -	read_barrier_depends();
> -
>  	count = len / sizeof desc;
>  	/* Buffers are chained via a 16 bit next field, so
>  	 * we can have at most 2^16 of these. */
> -- 
> 2.27.0.383.g050319c2ae-goog
