From: Jason Wang <jasowang@redhat.com>
Subject: Re: [PATCH 6/7] ifcvf: replace irq_request/free with helpers in vDPA
 core.
Date: Mon, 13 Jul 2020 16:33:24 +0800
Message-ID: <c7d4eca1-b65a-b795-dfa6-fe7658716cb1@redhat.com>
References: <1594565366-3195-1-git-send-email-lingshan.zhu@intel.com>
 <1594565366-3195-6-git-send-email-lingshan.zhu@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <1594565366-3195-6-git-send-email-lingshan.zhu@intel.com>
Content-Language: en-US
Sender: kvm-owner@vger.kernel.org
To: Zhu Lingshan <lingshan.zhu@intel.com>, mst@redhat.com, alex.williamson@redhat.com, pbonzini@redhat.com, sean.j.christopherson@intel.com, wanpengli@tencent.com
Cc: virtualization@lists.linux-foundation.org, kvm@vger.kernel.org, netdev@vger.kernel.org, dan.daly@intel.com
List-Id: virtualization@lists.linuxfoundation.org


On 2020/7/12 下午10:49, Zhu Lingshan wrote:
> This commit replaced irq_request/free() with helpers in vDPA
> core, so that it can request/free irq and setup irq offloading
> on order.
>
> Signed-off-by: Zhu Lingshan <lingshan.zhu@intel.com>
> ---
>   drivers/vdpa/ifcvf/ifcvf_main.c | 11 ++++++-----
>   1 file changed, 6 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/vdpa/ifcvf/ifcvf_main.c b/drivers/vdpa/ifcvf/ifcvf_main.c
> index f5a60c1..65b84e1 100644
> --- a/drivers/vdpa/ifcvf/ifcvf_main.c
> +++ b/drivers/vdpa/ifcvf/ifcvf_main.c
> @@ -47,11 +47,12 @@ static void ifcvf_free_irq(struct ifcvf_adapter *adapter, int queues)
>   {
>   	struct pci_dev *pdev = adapter->pdev;
>   	struct ifcvf_hw *vf = &adapter->vf;
> +	struct vdpa_device *vdpa = &adapter->vdpa;
>   	int i;
>   
>   
>   	for (i = 0; i < queues; i++)
> -		devm_free_irq(&pdev->dev, vf->vring[i].irq, &vf->vring[i]);
> +		vdpa_free_vq_irq(&pdev->dev, vdpa, vf->vring[i].irq, i, &vf->vring[i]);
>   
>   	ifcvf_free_irq_vectors(pdev);
>   }
> @@ -60,6 +61,7 @@ static int ifcvf_request_irq(struct ifcvf_adapter *adapter)
>   {
>   	struct pci_dev *pdev = adapter->pdev;
>   	struct ifcvf_hw *vf = &adapter->vf;
> +	struct vdpa_device *vdpa = &adapter->vdpa;
>   	int vector, i, ret, irq;
>   
>   	ret = pci_alloc_irq_vectors(pdev, IFCVF_MAX_INTR,
> @@ -73,6 +75,7 @@ static int ifcvf_request_irq(struct ifcvf_adapter *adapter)
>   		 pci_name(pdev));
>   	vector = 0;
>   	irq = pci_irq_vector(pdev, vector);
> +	/* config interrupt */


Unnecessary changes.

Thanks


>   	ret = devm_request_irq(&pdev->dev, irq,
>   			       ifcvf_config_changed, 0,
>   			       vf->config_msix_name, vf);
> @@ -82,13 +85,11 @@ static int ifcvf_request_irq(struct ifcvf_adapter *adapter)
>   			 pci_name(pdev), i);
>   		vector = i + IFCVF_MSI_QUEUE_OFF;
>   		irq = pci_irq_vector(pdev, vector);
> -		ret = devm_request_irq(&pdev->dev, irq,
> +		ret = vdpa_alloc_vq_irq(&pdev->dev, vdpa, irq,
>   				       ifcvf_intr_handler, 0,
>   				       vf->vring[i].msix_name,
> -				       &vf->vring[i]);
> +				       &vf->vring[i], i);
>   		if (ret) {
> -			IFCVF_ERR(pdev,
> -				  "Failed to request irq for vq %d\n", i);
>   			ifcvf_free_irq(adapter, i);
>   
>   			return ret;
