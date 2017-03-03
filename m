From: Jan Dakinevich <jan.dakinevich@gmail.com>
Subject: Re: [PATCH] virtio-console: avoid DMA from stack
Date: Fri, 3 Mar 2017 03:58:53 +0300
Message-ID: <440dcce4-c3df-1ff5-1297-e901311c98a9@gmail.com>
References: <075115ddd99246ffc4228a3e050ba68eb36c6a8c.1485935920.git.osandov@fb.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <075115ddd99246ffc4228a3e050ba68eb36c6a8c.1485935920.git.osandov@fb.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Omar Sandoval <osandov@osandov.com>, Amit Shah <amit.shah@redhat.com>
Cc: kernel-team@fb.com, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

I also faced with the same issue. Could you clarify it for me whether it
is safe to allocate memory inside console driver handler? For example,
what would happen if put_chars was triggered by fail in another memory
allocation?

On 02/01/2017 11:02 AM, Omar Sandoval wrote:
> From: Omar Sandoval <osandov@fb.com>
> 
> put_chars() stuffs the buffer it gets into an sg, but that buffer may be
> on the stack. This breaks with CONFIG_VMAP_STACK=y (for me, it
> manifested as printks getting turned into NUL bytes).
> 
> Signed-off-by: Omar Sandoval <osandov@fb.com>
> ---
> Patch based on v4.10-rc6.
> 
>  drivers/char/virtio_console.c | 12 ++++++++++--
>  1 file changed, 10 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/char/virtio_console.c b/drivers/char/virtio_console.c
> index 17857beb4892..3cbf4c95e446 100644
> --- a/drivers/char/virtio_console.c
> +++ b/drivers/char/virtio_console.c
> @@ -1136,6 +1136,8 @@ static int put_chars(u32 vtermno, const char *buf, int count)
>  {
>  	struct port *port;
>  	struct scatterlist sg[1];
> +	void *data;
> +	int ret;
>  
>  	if (unlikely(early_put_chars))
>  		return early_put_chars(vtermno, buf, count);
> @@ -1144,8 +1146,14 @@ static int put_chars(u32 vtermno, const char *buf, int count)
>  	if (!port)
>  		return -EPIPE;
>  
> -	sg_init_one(sg, buf, count);
> -	return __send_to_port(port, sg, 1, count, (void *)buf, false);
> +	data = kmemdup(buf, count, GFP_ATOMIC);
> +	if (!data)
> +		return -ENOMEM;
> +
> +	sg_init_one(sg, data, count);
> +	ret = __send_to_port(port, sg, 1, count, data, false);
> +	kfree(data);
> +	return ret;
>  }
>  
>  /*
> 

-- 
Best regards,
Jan Dakinevich
