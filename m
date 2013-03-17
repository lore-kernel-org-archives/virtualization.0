From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH 1/2] virtio-scsi: Set _DRIVER_OK flag before scsi target
	scanning
Date: Sun, 17 Mar 2013 11:16:21 +0200
Message-ID: <20130317091621.GA30427@redhat.com>
References: <1363311916-23121-1-git-send-email-asias@redhat.com>
	<1363311916-23121-2-git-send-email-asias@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <1363311916-23121-2-git-send-email-asias@redhat.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Asias He <asias@redhat.com>
Cc: target-devel@vger.kernel.org, kvm@vger.kernel.org, seabios@seabios.org, qemu-devel@nongnu.org, virtualization@lists.linux-foundation.org, Kevin O'Connor <kevin@koconnor.net>, Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
List-Id: virtualization@lists.linuxfoundation.org

On Fri, Mar 15, 2013 at 09:45:15AM +0800, Asias He wrote:
> Before we start scsi target scanning, we need to set the
> VIRTIO_CONFIG_S_DRIVER_OK flag so the device can do setup properly.
> 
> This fix a bug when booting tcm_vhost with seabios.
> 
> Signed-off-by: Asias He <asias@redhat.com>
> Acked-by: Paolo Bonzini <pbonzini@redhat.com>

Acked-by: Michael S. Tsirkin <mst@redhat.com>

> ---
>  src/virtio-scsi.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/src/virtio-scsi.c b/src/virtio-scsi.c
> index 879ddfb..4de1255 100644
> --- a/src/virtio-scsi.c
> +++ b/src/virtio-scsi.c
> @@ -147,6 +147,9 @@ init_virtio_scsi(struct pci_device *pci)
>          goto fail;
>      }
>  
> +    vp_set_status(ioaddr, VIRTIO_CONFIG_S_ACKNOWLEDGE |
> +                  VIRTIO_CONFIG_S_DRIVER | VIRTIO_CONFIG_S_DRIVER_OK);
> +
>      int i, tot;
>      for (tot = 0, i = 0; i < 256; i++)
>          tot += virtio_scsi_scan_target(pci, ioaddr, vq, i);
> @@ -154,8 +157,6 @@ init_virtio_scsi(struct pci_device *pci)
>      if (!tot)
>          goto fail;
>  
> -    vp_set_status(ioaddr, VIRTIO_CONFIG_S_ACKNOWLEDGE |
> -                  VIRTIO_CONFIG_S_DRIVER | VIRTIO_CONFIG_S_DRIVER_OK);
>      return;
>  
>  fail:
> -- 
> 1.8.1.4
