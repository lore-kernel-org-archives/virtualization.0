From: Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: [PATCH] virtio: Use pci_enable_msix_range() instead of
	pci_enable_msix()
Date: Thu, 20 Feb 2014 12:14:11 +1030
Message-ID: <87eh2yblsk.fsf__13146.8576066711$1392870308$gmane$org@rustcorp.com.au>
References: <1392804931-30671-9-git-send-email-agordeev@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1392804931-30671-9-git-send-email-agordeev@redhat.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: linux-kernel@vger.kernel.org
Cc: linux-pci@vger.kernel.org, virtio-dev@lists.oasis-open.org, Alexander Gordeev <agordeev@redhat.com>, virtualization@lists.linux-foundation.org, "Michael S. Tsirkin" <mst@redhat.com>
List-Id: virtualization@lists.linuxfoundation.org

Alexander Gordeev <agordeev@redhat.com> writes:
> As result deprecation of MSI-X/MSI enablement functions
> pci_enable_msix() and pci_enable_msi_block() all drivers
> using these two interfaces need to be updated to use the
> new pci_enable_msi_range() and pci_enable_msix_range()
> interfaces.
>
> Signed-off-by: Alexander Gordeev <agordeev@redhat.com>
> Cc: Rusty Russell <rusty@rustcorp.com.au>
> Cc: "Michael S. Tsirkin" <mst@redhat.com>
> Cc: virtio-dev@lists.oasis-open.org
> Cc: virtualization@lists.linux-foundation.org
> Cc: linux-pci@vger.kernel.org
> ---
>  drivers/virtio/virtio_pci.c |    8 +++-----
>  1 files changed, 3 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/virtio/virtio_pci.c b/drivers/virtio/virtio_pci.c
> index a416f9b..dea042c 100644
> --- a/drivers/virtio/virtio_pci.c
> +++ b/drivers/virtio/virtio_pci.c
> @@ -333,11 +333,9 @@ static int vp_request_msix_vectors(struct virtio_device *vdev, int nvectors,
>  	for (i = 0; i < nvectors; ++i)
>  		vp_dev->msix_entries[i].entry = i;
>  
> -	/* pci_enable_msix returns positive if we can't get this many. */
> -	err = pci_enable_msix(vp_dev->pci_dev, vp_dev->msix_entries, nvectors);
> -	if (err > 0)
> -		err = -ENOSPC;
> -	if (err)
> +	err = pci_enable_msix_range(vp_dev->pci_dev,
> +				    vp_dev->msix_entries, nvectors, nvectors);
> +	if (err < 0)
>  		goto error;
>  	vp_dev->msix_enabled = 1;

I've put this in my pending queue, but in case someone else wants to
take it:

Acked-by: Rusty Russell <rusty@rustcorp.com.au>

Cheers,
Rusty.
