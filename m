From: Amit Shah <amit@kernel.org>
Subject: Re: [PATCH] virtio: virtio_console: add missing
 MODULE_DEVICE_TABLE() for rproc serial
Date: Wed, 11 Mar 2020 15:53:56 +0100
Message-ID: <f09bacf3029edfc7f90097f7fc6e41176ddd4873.camel@kernel.org>
References: <20200310110538.19254-1-alobakin@dlink.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <stable-owner@vger.kernel.org>
In-Reply-To: <20200310110538.19254-1-alobakin@dlink.ru>
Sender: stable-owner@vger.kernel.org
To: Alexander Lobakin <alobakin@dlink.ru>
Cc: Arnd Bergmann <arnd@arndb.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Sjur Brandeland <sjur.brandeland@stericsson.com>, Rusty Russell <rusty@rustcorp.com.au>, virtualization@lists.linux-foundation.org, stable@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: virtualization@lists.linuxfoundation.org

On Tue, 2020-03-10 at 14:05 +0300, Alexander Lobakin wrote:
> rproc_serial_id_table lacks an exposure to module devicetable, so
> when remoteproc firmware requests VIRTIO_ID_RPROC_SERIAL, no uevent
> is generated and no module autoloading occurs.
> Add missing MODULE_DEVICE_TABLE() annotation and move the existing
> one for VIRTIO_ID_CONSOLE right to the table itself.
> 
> Fixes: 1b6370463e88 ("virtio_console: Add support for remoteproc
> serial")
> Cc: <stable@vger.kernel.org> # v3.8+
> Signed-off-by: Alexander Lobakin <alobakin@dlink.ru>

Reviewed-by: Amit Shah <amit@kernel.org>

Thanks,

> ---
>  drivers/char/virtio_console.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/char/virtio_console.c
> b/drivers/char/virtio_console.c
> index 4df9b40d6342..7e1bc0f580a2 100644
> --- a/drivers/char/virtio_console.c
> +++ b/drivers/char/virtio_console.c
> @@ -2116,6 +2116,7 @@ static struct virtio_device_id id_table[] = {
>  	{ VIRTIO_ID_CONSOLE, VIRTIO_DEV_ANY_ID },
>  	{ 0 },
>  };
> +MODULE_DEVICE_TABLE(virtio, id_table);
>  
>  static unsigned int features[] = {
>  	VIRTIO_CONSOLE_F_SIZE,
> @@ -2128,6 +2129,7 @@ static struct virtio_device_id
> rproc_serial_id_table[] = {
>  #endif
>  	{ 0 },
>  };
> +MODULE_DEVICE_TABLE(virtio, rproc_serial_id_table);
>  
>  static unsigned int rproc_serial_features[] = {
>  };
> @@ -2280,6 +2282,5 @@ static void __exit fini(void)
>  module_init(init);
>  module_exit(fini);
>  
> -MODULE_DEVICE_TABLE(virtio, id_table);
>  MODULE_DESCRIPTION("Virtio console driver");
>  MODULE_LICENSE("GPL");
