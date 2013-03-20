From: Asias He <asias@redhat.com>
Subject: Re: [PATCH 15/22] virtio_rng: use simplified virtqueue accessors.
Date: Wed, 20 Mar 2013 09:18:46 +0800
Message-ID: <20130320011846.GA13649@hj.localdomain>
References: <1363599293-23065-1-git-send-email-rusty@rustcorp.com.au>
	<1363599293-23065-16-git-send-email-rusty@rustcorp.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <1363599293-23065-16-git-send-email-rusty@rustcorp.com.au>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On Mon, Mar 18, 2013 at 08:04:46PM +1030, Rusty Russell wrote:
> We never add buffers with input and output parts, so use the new accessors.
> 
> Signed-off-by: Rusty Russell <rusty@rustcorp.com.au>

Reviewed-by: Asias He <asias@redhat.com>

> ---
>  drivers/char/hw_random/virtio-rng.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/char/hw_random/virtio-rng.c b/drivers/char/hw_random/virtio-rng.c
> index 6bf4d47..ef46a9c 100644
> --- a/drivers/char/hw_random/virtio-rng.c
> +++ b/drivers/char/hw_random/virtio-rng.c
> @@ -47,7 +47,7 @@ static void register_buffer(u8 *buf, size_t size)
>  	sg_init_one(&sg, buf, size);
>  
>  	/* There should always be room for one buffer. */
> -	if (virtqueue_add_buf(vq, &sg, 0, 1, buf, GFP_KERNEL) < 0)
> +	if (virtqueue_add_inbuf(vq, &sg, 1, buf, GFP_KERNEL) < 0)
>  		BUG();
>  
>  	virtqueue_kick(vq);
> -- 
> 1.7.10.4
> 
> _______________________________________________
> Virtualization mailing list
> Virtualization@lists.linux-foundation.org
> https://lists.linuxfoundation.org/mailman/listinfo/virtualization

-- 
Asias
