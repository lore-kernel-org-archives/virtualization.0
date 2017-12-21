From: Andrei Vagin <avagin@virtuozzo.com>
Subject: Re: virtio: make VIRTIO a menuconfig to ease disabling it all
Date: Wed, 20 Dec 2017 22:44:27 -0800
Message-ID: <20171221064426.GA24940__41166.0663703971$1515606482$gmane$org@outlook.office365.com>
References: <20171209152657.4762-1-vincent.legoll@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
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
To: Vincent Legoll <vincent.legoll@gmail.com>
Cc: virtualization@lists.linux-foundation.org, linux-kernel@vger.kernel.org, mst@redhat.com
List-Id: virtualization@lists.linuxfoundation.org

On Sat, Dec 09, 2017 at 04:26:57PM +0100, Vincent Legoll wrote:
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

Hi Vincent,

make localyesconfig and make localmodconfig doesn't work with this
patch.

My scenario looks like this:
* Create a virtual machine with Ubuntu 14.04 in GCE
* git clone git://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git
* cd linux-next
* curl -o .config https://raw.githubusercontent.com/avagin/criu/linux-next/scripts/linux-next-config
* make localyesconfig

Without this patch:

$ cat .config | grep VIRTIO
CONFIG_BLK_MQ_VIRTIO=y
CONFIG_VIRTIO_BLK=y
# CONFIG_VIRTIO_BLK_SCSI is not set
CONFIG_SCSI_VIRTIO=y
CONFIG_VIRTIO_NET=y
CONFIG_VIRTIO_CONSOLE=y
# CONFIG_HW_RANDOM_VIRTIO is not set
CONFIG_VIRTIO=y
CONFIG_VIRTIO_PCI=y
CONFIG_VIRTIO_PCI_LEGACY=y
CONFIG_VIRTIO_BALLOON=y
# CONFIG_VIRTIO_INPUT is not set
CONFIG_VIRTIO_MMIO=y
CONFIG_VIRTIO_MMIO_CMDLINE_DEVICES=y
# CONFIG_RPMSG_VIRTIO is not set
# CONFIG_CRYPTO_DEV_VIRTIO is not set


With this patch:

$ cat .config | grep VIRTIO
CONFIG_BLK_MQ_VIRTIO=y
# CONFIG_VIRTIO_BLK is not set
CONFIG_SCSI_VIRTIO=y
# CONFIG_VIRTIO_NET is not set
CONFIG_CAIF_VIRTIO=y
# CONFIG_VIRTIO_CONSOLE is not set
# CONFIG_HW_RANDOM_VIRTIO is not set
CONFIG_VIRTIO=y
# CONFIG_VIRTIO_MENU is not set
# CONFIG_RPMSG_VIRTIO is not set
# CONFIG_CRYPTO_DEV_VIRTIO is not set


You can see that with this patch CONFIG_VIRTIO_BLK is not set.
It is wrong, and the kernel with this config will not be able to boot.

We can add "default y" to fix this problem.

https://travis-ci.org/avagin/linux/jobs/313348334
https://travis-ci.org/avagin/linux/jobs/318491188

Thanks,
Andrei

> +
> +if VIRTIO_MENU
>  
>  config VIRTIO_PCI
>  	tristate "PCI driver for virtio devices"
> @@ -79,4 +82,4 @@ config VIRTIO_MMIO_CMDLINE_DEVICES
>  
>  	 If unsure, say 'N'.
>  
> -endmenu
> +endif # VIRTIO_MENU
