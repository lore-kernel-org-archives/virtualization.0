From: Pawel Moll <pawel.moll@arm.com>
Subject: Re: [PATCH][trivial] virtio-mmio: fix wrong comment about register
	offset
Date: Mon, 28 Jan 2013 10:05:21 +0000
Message-ID: <1359367521.8090.10.camel@hornet>
References: <1359190446-13677-1-git-send-email-ozaki.ryota@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1359190446-13677-1-git-send-email-ozaki.ryota@gmail.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Ryota Ozaki <ozaki.ryota@gmail.com>
Cc: Jiri Kosina <trivial@kernel.org>, "virtualization@lists.linux-foundation.org" <virtualization@lists.linux-foundation.org>
List-Id: virtualization@lists.linuxfoundation.org

On Sat, 2013-01-26 at 08:54 +0000, Ryota Ozaki wrote:
> The register offset of InterruptACK is 0x064, not 0x060.
> Fix it.
> 
> Signed-off-by: Ryota Ozaki <ozaki.ryota@gmail.com>
> CC: Pawel Moll <pawel.moll@arm.com>
> CC: Rusty Russell <rusty@rustcorp.com.au>
> CC: Jiri Kosina <trivial@kernel.org>
> ---
>  drivers/virtio/virtio_mmio.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/virtio/virtio_mmio.c b/drivers/virtio/virtio_mmio.c
> index 31f966f..833e6db 100644
> --- a/drivers/virtio/virtio_mmio.c
> +++ b/drivers/virtio/virtio_mmio.c
> @@ -75,7 +75,7 @@
>   *
>   * 0x050  W  QueueNotify      Queue notifier
>   * 0x060  R  InterruptStatus  Interrupt status register
> - * 0x060  W  InterruptACK     Interrupt acknowledge register
> + * 0x064  W  InterruptACK     Interrupt acknowledge register
>   * 0x070  RW Status           Device status register
>   *
>   * 0x100+ RW                  Device-specific configuration space

Acked-by: Pawel Moll <pawel.moll@arm.com>

Thanks!

Pawel
