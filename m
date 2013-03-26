From: Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: [PATCH] drivers: virtio: Use PTR_RET function
Date: Tue, 26 Mar 2013 13:57:09 +1030
Message-ID: <87fvzidenm.fsf@rustcorp.com.au>
References: <1364217936-6284-1-git-send-email-gheorghiuandru@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1364217936-6284-1-git-send-email-gheorghiuandru@gmail.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, Alexandru Gheorghiu <gheorghiuandru@gmail.com>, Uwe =?utf-8?Q?Kleine-K?= =?utf-8?Q?=C3=B6nig?= <u.kleine-koenig@pengutronix.de>, Andrew Morton <akpm@linux-foundation.org>
List-Id: virtualization@lists.linuxfoundation.org

Alexandru Gheorghiu <gheorghiuandru@gmail.com> writes:

> Used PTR_RET function instead of IS_ERR and PTR_ERR.
> Patch found using coccinelle.

WTF is PTR_RET?  PTR_RET doesn't return anything.  Why is it called
that?  It doesn't even make sense.

ZERO_OR_PTR_ERR() maybe.

But what problem are we solving?  Insufficient churn in the tree?  Code
being too readable?  This isn't some hard-to-get right corner case, or a
missed optimization.

Andrew, what am I missing here?

Grumpy,
Rusty.

> Signed-off-by: Alexandru Gheorghiu <gheorghiuandru@gmail.com>
> ---
>  drivers/virtio/virtio_mmio.c |    5 +----
>  1 file changed, 1 insertion(+), 4 deletions(-)
>
> diff --git a/drivers/virtio/virtio_mmio.c b/drivers/virtio/virtio_mmio.c
> index 1ba0d68..d1e664f 100644
> --- a/drivers/virtio/virtio_mmio.c
> +++ b/drivers/virtio/virtio_mmio.c
> @@ -567,10 +567,7 @@ static int vm_cmdline_set(const char *device,
>  	pdev = platform_device_register_resndata(&vm_cmdline_parent,
>  			"virtio-mmio", vm_cmdline_id++,
>  			resources, ARRAY_SIZE(resources), NULL, 0);
> -	if (IS_ERR(pdev))
> -		return PTR_ERR(pdev);
> -
> -	return 0;
> +	return PTR_RET(pdev);
>  }
>  
>  static int vm_cmdline_get_device(struct device *dev, void *data)
> -- 
> 1.7.9.5
