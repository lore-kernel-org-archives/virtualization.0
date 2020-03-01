From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH RESEND] virtio: virtio_pci_legacy: Remove default y from
 Kconfig
Date: Sun, 1 Mar 2020 02:32:30 -0500
Message-ID: <20200301023025-mutt-send-email-mst@kernel.org>
References: <20200228232736.182780-1-rammuthiah@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20200228232736.182780-1-rammuthiah@google.com>
Content-Disposition: inline
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
 <mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
 <mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>
To: Ram Muthiah <rammuthiah@google.com>
Cc: kernel-team@android.com, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On Fri, Feb 28, 2020 at 03:27:36PM -0800, Ram Muthiah wrote:
> The legacy pci driver should no longer be default enabled. QEMU has
> implemented support for Virtio 1 for virtio-pci since June 2015
> on SHA dfb8e184db75.
> 
> Signed-off-by: Ram Muthiah <rammuthiah@google.com>

I see little reason to do this: y is safer and will boot on more
hypervisors, so people that aren't sure should enable it.

> ---
>  drivers/virtio/Kconfig | 6 ------
>  1 file changed, 6 deletions(-)
> 
> diff --git a/drivers/virtio/Kconfig b/drivers/virtio/Kconfig
> index 078615cf2afc..eacd0b90d32b 100644
> --- a/drivers/virtio/Kconfig
> +++ b/drivers/virtio/Kconfig
> @@ -26,7 +26,6 @@ config VIRTIO_PCI
>  
>  config VIRTIO_PCI_LEGACY
>  	bool "Support for legacy virtio draft 0.9.X and older devices"
> -	default y
>  	depends on VIRTIO_PCI
>  	---help---
>            Virtio PCI Card 0.9.X Draft (circa 2014) and older device support.
> @@ -36,11 +35,6 @@ config VIRTIO_PCI_LEGACY
>  	  If disabled, you get a slightly smaller, non-transitional driver,
>  	  with no legacy compatibility.
>  
> -          So look out into your driveway.  Do you have a flying car?  If
> -          so, you can happily disable this option and virtio will not
> -          break.  Otherwise, leave it set.  Unless you're testing what
> -          life will be like in The Future.
> -
>  	  If unsure, say Y.
>  
>  config VIRTIO_PMEM
> -- 
> 2.25.0.265.gbab2e86ba0-goog
