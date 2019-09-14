From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH] vhost: Fix compile time error
Date: Sat, 14 Sep 2019 15:38:39 -0400
Message-ID: <20190914153325-mutt-send-email-mst__31459.6461526648$1568489943$gmane$org@kernel.org>
References: <1568450697-16775-1-git-send-email-linux@roeck-us.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <1568450697-16775-1-git-send-email-linux@roeck-us.net>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Guenter Roeck <linux@roeck-us.net>
Cc: kvm@vger.kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Linus Torvalds <torvalds@linux-foundation.org>
List-Id: virtualization@lists.linuxfoundation.org

On Sat, Sep 14, 2019 at 01:44:57AM -0700, Guenter Roeck wrote:
> Building vhost on 32-bit targets results in the following error.
> 
> drivers/vhost/vhost.c: In function 'translate_desc':
> include/linux/compiler.h:549:38: error:
> 	call to '__compiletime_assert_1879' declared with attribute error:
> 	BUILD_BUG_ON failed: sizeof(_s) > sizeof(long)
> 
> Fixes: a89db445fbd7 ("vhost: block speculation of translated descriptors")
> Cc: Michael S. Tsirkin <mst@redhat.com>
> Cc: Jason Wang <jasowang@redhat.com>
> Signed-off-by: Guenter Roeck <linux@roeck-us.net>



> ---
>  drivers/vhost/vhost.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/vhost/vhost.c b/drivers/vhost/vhost.c
> index acabf20b069e..102a0c877007 100644
> --- a/drivers/vhost/vhost.c
> +++ b/drivers/vhost/vhost.c
> @@ -2074,7 +2074,7 @@ static int translate_desc(struct vhost_virtqueue *vq, u64 addr, u32 len,
>  		_iov->iov_base = (void __user *)
>  			((unsigned long)node->userspace_addr +
>  			 array_index_nospec((unsigned long)(addr - node->start),
> -					    node->size));
> +					    (unsigned long)node->size));

Unfortunately this does not fix the case where size is actually 64 bit,
e.g. a single node with VA 0, size 2^32 is how
you cover the whole virtual address space.

this is not how qemu uses it, but it's valid.

I think it's best to just revert the patch for now.

>  		s += size;
>  		addr += size;
>  		++ret;
> -- 
> 2.7.4
