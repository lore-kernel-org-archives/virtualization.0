From: Michael Ellerman <mpe@ellerman.id.au>
Subject: Re: [PATCH] virtio: make VIRTIO a menuconfig to ease disabling it all
Date: Thu, 21 Dec 2017 21:53:44 +1100
Message-ID: <87tvwkfj2f.fsf__23379.596314817$1513853524$gmane$org@concordia.ellerman.id.au>
References: <20171209152657.4762-1-vincent.legoll@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20171209152657.4762-1-vincent.legoll@gmail.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: mst@redhat.com, jasowang@redhat.com, virtualization@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Cc: Vincent Legoll <vincent.legoll@gmail.com>
List-Id: virtualization@lists.linuxfoundation.org

Vincent Legoll <vincent.legoll@gmail.com> writes:

> No need to get into the submenu to disable all VIRTIO-related
> config entries.
>
> This makes it easier to disable all VIRTIO config options
> without entering the submenu. It will also enable one
> to see that en/dis-abled state from the outside menu.
>
> This is only intended to change menuconfig UI, not change
> the config dependencies.
>
> Signed-off-by: Vincent Legoll <vincent.legoll@gmail.com>
> ---
>  drivers/virtio/Kconfig | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/virtio/Kconfig b/drivers/virtio/Kconfig
> index cff773f15b7e..d485a63a8233 100644
> --- a/drivers/virtio/Kconfig
> +++ b/drivers/virtio/Kconfig
> @@ -5,7 +5,10 @@ config VIRTIO
>  	  bus, such as CONFIG_VIRTIO_PCI, CONFIG_VIRTIO_MMIO, CONFIG_RPMSG
>  	  or CONFIG_S390_GUEST.
>  
> -menu "Virtio drivers"
> +menuconfig VIRTIO_MENU
> +	bool "Virtio drivers"
> +
> +if VIRTIO_MENU

This breaks all existing .configs *and* defconfigs that use VIRTIO.

Please don't do that.

If you make it default y then everything will continue to work.

cheers


diff --git a/drivers/virtio/Kconfig b/drivers/virtio/Kconfig
index d485a63a8233..35897649c24f 100644
--- a/drivers/virtio/Kconfig
+++ b/drivers/virtio/Kconfig
@@ -7,6 +7,7 @@ config VIRTIO
 
 menuconfig VIRTIO_MENU
 	bool "Virtio drivers"
+	default y
 
 if VIRTIO_MENU
