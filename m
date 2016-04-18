From: Alex Williamson <alex.williamson@redhat.com>
Subject: Re: [PATCH RFC 2/3] vfio: report group noiommu status
Date: Mon, 18 Apr 2016 12:56:58 -0600
Message-ID: <20160418125658.48ffd105__26794.8508765132$1461005836$gmane$org@t450s.home>
References: <1460973374-32719-1-git-send-email-mst@redhat.com>
	<1460973374-32719-3-git-send-email-mst@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1460973374-32719-3-git-send-email-mst@redhat.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Julia Lawall <Julia.Lawall@lip6.fr>, Wei Liu <wei.liu2@citrix.com>, kvm@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>, qemu-devel@nongnu.org, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, Christian Borntraeger <borntraeger@de.ibm.com>, Andy Lutomirski <luto@kernel.org>, Baptiste Reynal <b.reynal@virtualopensystems.com>, David Woodhouse <dwmw2@infradead.org>, Dan Carpenter <dan.carpenter@oracle.com>
List-Id: virtualization@lists.linuxfoundation.org

On Mon, 18 Apr 2016 12:58:20 +0300
"Michael S. Tsirkin" <mst@redhat.com> wrote:

> When using vfio, callers might want to know whether device is added to a
> regular group or an non-iommu group.
> 
> Report this status from vfio_add_group_dev.
> 
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> ---

What about making an interface to query this rather than playing games
with magic return values?

bool vfio_iommu_group_is_noiommu(struct iommu_group *group)
{
    return iommu_group_get_iommudata(group) == &noiommu;
}

>  drivers/vfio/pci/vfio_pci.c                  | 2 +-
>  drivers/vfio/platform/vfio_platform_common.c | 2 +-
>  drivers/vfio/vfio.c                          | 5 ++++-
>  Documentation/vfio.txt                       | 4 +++-
>  4 files changed, 9 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/vfio/pci/vfio_pci.c b/drivers/vfio/pci/vfio_pci.c
> index 712a849..d622a41 100644
> --- a/drivers/vfio/pci/vfio_pci.c
> +++ b/drivers/vfio/pci/vfio_pci.c
> @@ -1119,7 +1119,7 @@ static int vfio_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
>  	spin_lock_init(&vdev->irqlock);
>  
>  	ret = vfio_add_group_dev(&pdev->dev, &vfio_pci_ops, vdev);
> -	if (ret) {
> +	if (ret < 0) {
>  		vfio_iommu_group_put(group, &pdev->dev);
>  		kfree(vdev);
>  		return ret;
> diff --git a/drivers/vfio/platform/vfio_platform_common.c b/drivers/vfio/platform/vfio_platform_common.c
> index e65b142..bf74e21 100644
> --- a/drivers/vfio/platform/vfio_platform_common.c
> +++ b/drivers/vfio/platform/vfio_platform_common.c
> @@ -568,7 +568,7 @@ int vfio_platform_probe_common(struct vfio_platform_device *vdev,
>  	}
>  
>  	ret = vfio_add_group_dev(dev, &vfio_platform_ops, vdev);
> -	if (ret) {
> +	if (ret < 0) {
>  		iommu_group_put(group);
>  		return ret;
>  	}
> diff --git a/drivers/vfio/vfio.c b/drivers/vfio/vfio.c
> index 6fd6fa5..67db231 100644
> --- a/drivers/vfio/vfio.c
> +++ b/drivers/vfio/vfio.c
> @@ -756,6 +756,7 @@ int vfio_add_group_dev(struct device *dev,
>  	struct iommu_group *iommu_group;
>  	struct vfio_group *group;
>  	struct vfio_device *device;
> +	int noiommu;
>  
>  	iommu_group = iommu_group_get(dev);
>  	if (!iommu_group)
> @@ -791,6 +792,8 @@ int vfio_add_group_dev(struct device *dev,
>  		return PTR_ERR(device);
>  	}
>  
> +	noiommu = group->noiommu;
> +
>  	/*
>  	 * Drop all but the vfio_device reference.  The vfio_device holds
>  	 * a reference to the vfio_group, which holds a reference to the
> @@ -798,7 +801,7 @@ int vfio_add_group_dev(struct device *dev,
>  	 */
>  	vfio_group_put(group);
>  
> -	return 0;
> +	return noiommu;
>  }
>  EXPORT_SYMBOL_GPL(vfio_add_group_dev);
>  
> diff --git a/Documentation/vfio.txt b/Documentation/vfio.txt
> index 1dd3fdd..d76be0f 100644
> --- a/Documentation/vfio.txt
> +++ b/Documentation/vfio.txt
> @@ -259,7 +259,9 @@ extern void *vfio_del_group_dev(struct device *dev);
>  
>  vfio_add_group_dev() indicates to the core to begin tracking the
>  specified iommu_group and register the specified dev as owned by
> -a VFIO bus driver.  The driver provides an ops structure for callbacks
> +a VFIO bus driver.  A negative return value indicates failure.
> +A positive return value indicates that an unsafe noiommu mode
> +is in use.  The driver provides an ops structure for callbacks
>  similar to a file operations structure:
>  
>  struct vfio_device_ops {
