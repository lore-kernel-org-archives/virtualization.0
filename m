From: Wanlong Gao <gaowanlong@cn.fujitsu.com>
Subject: Re: [PATCH][trivial] virtio-mmio: fix wrong comment about register
	offset
Date: Mon, 28 Jan 2013 12:03:27 +0800
Message-ID: <5105F88F.4030604@cn.fujitsu.com>
References: <1359190446-13677-1-git-send-email-ozaki.ryota@gmail.com>
Reply-To: gaowanlong@cn.fujitsu.com
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
Cc: Jiri Kosina <trivial@kernel.org>, Pawel Moll <pawel.moll@arm.com>, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On 01/26/2013 04:54 PM, Ryota Ozaki wrote:
> The register offset of InterruptACK is 0x064, not 0x060.
> Fix it.
> 
> Signed-off-by: Ryota Ozaki <ozaki.ryota@gmail.com>
> CC: Pawel Moll <pawel.moll@arm.com>
> CC: Rusty Russell <rusty@rustcorp.com.au>
> CC: Jiri Kosina <trivial@kernel.org>

Reviewed-by: Wanlong Gao <gaowanlong@cn.fujitsu.com>

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
> 
