From: Amit Shah <amit.shah@redhat.com>
Subject: Re: [PATCH] virtio: console: fix error handling in init() function
Date: Mon, 10 Sep 2012 01:49:47 +0530
Message-ID: <20120909201947.GF16985@amit.redhat.com>
References: <1346528977-23066-1-git-send-email-khoroshilov@ispras.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <1346528977-23066-1-git-send-email-khoroshilov@ispras.ru>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Alexey Khoroshilov <khoroshilov@ispras.ru>
Cc: Arnd Bergmann <arnd@arndb.de>, ldv-project@ispras.ru, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

Hi Alexey,

On (Sat) 01 Sep 2012 [23:49:37], Alexey Khoroshilov wrote:
> If register_virtio_driver() fails, virtio-ports class is not destroyed.
> The patch adds error handling of register_virtio_driver().
> 
> Found by Linux Driver Verification project (linuxtesting.org).
> 
> Signed-off-by: Alexey Khoroshilov <khoroshilov@ispras.ru>
> ---
>  drivers/char/virtio_console.c |   12 +++++++++++-
>  1 file changed, 11 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/char/virtio_console.c b/drivers/char/virtio_console.c
> index cdf2f54..060a672 100644
> --- a/drivers/char/virtio_console.c
> +++ b/drivers/char/virtio_console.c
> @@ -1941,7 +1941,17 @@ static int __init init(void)
>  	INIT_LIST_HEAD(&pdrvdata.consoles);
>  	INIT_LIST_HEAD(&pdrvdata.portdevs);
>  
> -	return register_virtio_driver(&virtio_console);
> +	err = register_virtio_driver(&virtio_console);
> +	if (err < 0) {
> +		pr_err("Error %d registering virtio driver\n", err);
> +		goto free;
> +	}
> +	return 0;
> +free:
> +	if (pdrvdata.debugfs_dir)
> +		debugfs_remove_recursive(pdrvdata.debugfs_dir);
> +	class_destroy(pdrvdata.class);
> +	return err;
>  }
>  
>  static void __exit fini(void)

Patch looks good.

Acked-by: Amit Shah <amit.shah@redhat.com>

Rusty, please pick this up.

Thanks,
		Amit
