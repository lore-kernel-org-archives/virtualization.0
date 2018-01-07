From: Randy Dunlap <rdunlap@infradead.org>
Subject: Re: [PATCH] [PATCH] virtio: make VIRTIO a menuconfig to ease
	disabling it all
Date: Sat, 6 Jan 2018 19:25:25 -0800
Message-ID: <459e2097-f20a-18f8-17d9-2d9ed011211d__5182.10254745117$1515295442$gmane$org@infradead.org>
References: <871sj7dgvr.fsf@concordia.ellerman.id.au>
	<20180103094918.6106-1-vincent.legoll@gmail.com>
	<20180103094918.6106-2-vincent.legoll@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20180103094918.6106-2-vincent.legoll@gmail.com>
Content-Language: en-US
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Vincent Legoll <vincent.legoll@gmail.com>, mst@redhat.com, jasowang@redhat.com, virtualization@lists.linux-foundation.org, linux-kernel@vger.kernel.org
List-Id: virtualization@lists.linuxfoundation.org

On 01/03/18 01:49, Vincent Legoll wrote:
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
> v2: add "default y" to avoid breaking existing configs
> 
> Signed-off-by: Vincent Legoll <vincent.legoll@gmail.com>

For a single patch (not 2 or more in a series), please just use one
email with the patch description etc. in it.  No need for a cover letter.

> ---
>  drivers/virtio/Kconfig | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/virtio/Kconfig b/drivers/virtio/Kconfig
> index cff773f15b7e..290a1875e1d3 100644
> --- a/drivers/virtio/Kconfig
> +++ b/drivers/virtio/Kconfig
> @@ -5,7 +5,11 @@ config VIRTIO
>  	  bus, such as CONFIG_VIRTIO_PCI, CONFIG_VIRTIO_MMIO, CONFIG_RPMSG
>  	  or CONFIG_S390_GUEST.
>  
> -menu "Virtio drivers"
> +menuconfig VIRTIO_MENU
> +	  bool "Virtio drivers"
> +	  default y

The 2 lines above should be indented only with 1 tab.  They should not line up
with the help text above (help text is indented more than other Kconfig lines).

After that little style thing is fixed, you can add:

Reviewed-by: Randy Dunlap <rdunlap@infradead.org>
Tested-by: Randy Dunlap <rdunlap@infradead.org> # works for me

and even though this will disable the drivers that are listed immediately
inside this if/endif block, there are several other drivers that select VIRTIO,
so it can be slightly tricky to figure out what is causing CONFIG_VIRTIO
to be enabled after having disabled CONFIG_VIRTIO_MENU.

Thanks.

> +
> +if VIRTIO_MENU
>  
>  config VIRTIO_PCI
>  	tristate "PCI driver for virtio devices"
> @@ -79,4 +83,4 @@ config VIRTIO_MMIO_CMDLINE_DEVICES
>  
>  	 If unsure, say 'N'.
>  
> -endmenu
> +endif # VIRTIO_MENU
> 


-- 
~Randy
