From: Amit Shah <amit.shah@redhat.com>
Subject: Re: [PATCH 1/2] virtio-pci: add setup_vqs flag in vp_try_to_find_vqs
Date: Wed, 1 Feb 2012 13:44:10 +0530
Message-ID: <20120201081410.GE24943@amit.redhat.com>
References: <1326331207-10339-1-git-send-email-zanghongyong@huawei.com>
	<1326331207-10339-2-git-send-email-zanghongyong@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <1326331207-10339-2-git-send-email-zanghongyong@huawei.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: zanghongyong@huawei.com
Cc: aliguori@us.ibm.com, kvm@vger.kernel.org, wusongwei@huawei.com, hanweidong@huawei.com, Virtualization List <virtualization@lists.linux-foundation.org>, xiaowei.yang@huawei.com, "Michael S. Tsirkin" <mst@redhat.com>, jiangningyu@huawei.com
List-Id: virtualization@lists.linuxfoundation.org

Michael, Rusty, any comments?

On (Thu) 12 Jan 2012 [09:20:06], zanghongyong@huawei.com wrote:
> From: Hongyong Zang <zanghongyong@huawei.com>
> 
> changes in vp_try_to_find_vqs:
> Virtio-serial's probe() calls it to request irqs and setup vqs of port0 and
> controls; add_port() calls it to set up vqs of io_port.
> it will not create virtqueue if the name is null.
> 
> Signed-off-by: Hongyong Zang <zanghongyong@huawei.com>
> ---
>  drivers/virtio/virtio_pci.c |   17 +++++++++++++----
>  1 files changed, 13 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/virtio/virtio_pci.c b/drivers/virtio/virtio_pci.c
> index baabb79..1f98c36 100644
> --- a/drivers/virtio/virtio_pci.c
> +++ b/drivers/virtio/virtio_pci.c
> @@ -492,9 +492,11 @@ static void vp_del_vqs(struct virtio_device *vdev)
>  	list_for_each_entry_safe(vq, n, &vdev->vqs, list) {
>  		info = vq->priv;
>  		if (vp_dev->per_vq_vectors &&
> -			info->msix_vector != VIRTIO_MSI_NO_VECTOR)
> +			info->msix_vector != VIRTIO_MSI_NO_VECTOR) {
>  			free_irq(vp_dev->msix_entries[info->msix_vector].vector,
>  				 vq);
> +			vp_dev->msix_used_vectors--;
> +		}
>  		vp_del_vq(vq);
>  	}
>  	vp_dev->per_vq_vectors = false;
> @@ -511,7 +513,10 @@ static int vp_try_to_find_vqs(struct virtio_device *vdev, unsigned nvqs,
>  {
>  	struct virtio_pci_device *vp_dev = to_vp_device(vdev);
>  	u16 msix_vec;
> -	int i, err, nvectors, allocated_vectors;
> +	int i, err, nvectors;
> +
> +	if (vp_dev->msix_used_vectors)
> +		goto setup_vqs;
>  
>  	if (!use_msix) {
>  		/* Old style: one normal interrupt for change and all vqs. */
> @@ -536,12 +541,16 @@ static int vp_try_to_find_vqs(struct virtio_device *vdev, unsigned nvqs,
>  	}
>  
>  	vp_dev->per_vq_vectors = per_vq_vectors;
> -	allocated_vectors = vp_dev->msix_used_vectors;
> +
> +setup_vqs:
>  	for (i = 0; i < nvqs; ++i) {
> +		if (names[i] == NULL)
> +			continue;
> +
>  		if (!callbacks[i] || !vp_dev->msix_enabled)
>  			msix_vec = VIRTIO_MSI_NO_VECTOR;
>  		else if (vp_dev->per_vq_vectors)
> -			msix_vec = allocated_vectors++;
> +			msix_vec = vp_dev->msix_used_vectors++;
>  		else
>  			msix_vec = VP_MSIX_VQ_VECTOR;
>  		vqs[i] = setup_vq(vdev, i, callbacks[i], names[i], msix_vec);
> -- 
> 1.7.1
> 

		Amit
