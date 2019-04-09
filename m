From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH net] vhost: flush dcache page when logging dirty pages
Date: Tue, 9 Apr 2019 09:14:16 -0400
Message-ID: <20190409085607-mutt-send-email-mst__2843.75176286034$1554815674$gmane$org@kernel.org>
References: <20190409041647.21269-1-jasowang@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20190409041647.21269-1-jasowang@redhat.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Jason Wang <jasowang@redhat.com>
Cc: Andrea Arcangeli <aarcange@redhat.com>, James Bottomley <James.Bottomley@hansenpartnership.com>, kvm@vger.kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, Christoph Hellwig <hch@infradead.org>
List-Id: virtualization@lists.linuxfoundation.org

On Tue, Apr 09, 2019 at 12:16:47PM +0800, Jason Wang wrote:
> We set dirty bit through setting up kmaps and access them through
> kernel virtual address, this may result alias in virtually tagged
> caches that require a dcache flush afterwards.
> 
> Cc: Christoph Hellwig <hch@infradead.org>
> Cc: James Bottomley <James.Bottomley@HansenPartnership.com>
> Cc: Andrea Arcangeli <aarcange@redhat.com>
> Fixes: 3a4d5c94e9593 ("vhost_net: a kernel-level virtio server")

This is like saying "everyone with vhost needs this".
In practice only might affect some architectures.
Which ones? You want to Cc the relevant maintainers
who understand this...

> Signed-off-by: Jason Wang <jasowang@redhat.com>

I am not sure this is a good idea.
The region in question is supposed to be accessed
by userspace at the same time, through atomic operations.

How do we know userspace didn't access it just before?

Is that an issue at all given we use
atomics for access? Documentation/core-api/cachetlb.rst does
not mention atomics.
Which architectures are affected?
Assuming atomics actually do need a flush, then don't we need
a flush in the other direction too? How are atomics
supposed to work at all?


I really think we need new APIs along the lines of
set_bit_to_user.

> ---
>  drivers/vhost/vhost.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/vhost/vhost.c b/drivers/vhost/vhost.c
> index 351af88231ad..34a1cedbc5ba 100644
> --- a/drivers/vhost/vhost.c
> +++ b/drivers/vhost/vhost.c
> @@ -1711,6 +1711,7 @@ static int set_bit_to_user(int nr, void __user *addr)
>  	base = kmap_atomic(page);
>  	set_bit(bit, base);
>  	kunmap_atomic(base);
> +	flush_dcache_page(page);
>  	set_page_dirty_lock(page);
>  	put_page(page);
>  	return 0;

Ignoring the question of whether this actually helps, I doubt
flush_dcache_page is appropriate here.  Pls take a look at
Documentation/core-api/cachetlb.rst as well as the actual
implementation.

I think you meant flush_kernel_dcache_page, and IIUC it must happen
before kunmap, not after (which you still have the va locked).

> -- 
> 2.19.1
