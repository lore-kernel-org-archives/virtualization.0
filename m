Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B5D31C433EF
	for <virtualization@archiver.kernel.org>; Tue, 25 Jan 2022 19:43:07 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 5E4FD827DE;
	Tue, 25 Jan 2022 19:43:07 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id kAJKpTb0hqX5; Tue, 25 Jan 2022 19:43:06 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 6965C82865;
	Tue, 25 Jan 2022 19:43:05 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 3C925C0039;
	Tue, 25 Jan 2022 19:43:05 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 4A087C002F
 for <virtualization@lists.linux-foundation.org>;
 Tue, 25 Jan 2022 19:43:04 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 296A840475
 for <virtualization@lists.linux-foundation.org>;
 Tue, 25 Jan 2022 19:43:04 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id xrvrR2uwO5fq
 for <virtualization@lists.linux-foundation.org>;
 Tue, 25 Jan 2022 19:43:03 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id BE94340004
 for <virtualization@lists.linux-foundation.org>;
 Tue, 25 Jan 2022 19:43:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1643139781;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=/CbQhZ/5Q6kk2WRebj7TZprFPKvjfn/uvEP5MmtPAd8=;
 b=WJeC9gWAOr91pt6GLIo0AWjLMUWdNWrt//cPefxWLcxT73DMdC3ypOPlv9zyTIWgqyE9Y1
 vcgulknLf2zJqWiiWAgcmZh4YyUggM16sWxdVaMIJOcS6gsf1rd5VPvj5X5S8fSvmgdqa8
 s4ggwhMh4e0Kb5DwA55p2b1O6GWa8xY=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-115-ZW4AVtt4Md2OKBPvmHQn5A-1; Tue, 25 Jan 2022 14:43:00 -0500
X-MC-Unique: ZW4AVtt4Md2OKBPvmHQn5A-1
Received: by mail-ej1-f70.google.com with SMTP id
 q19-20020a1709064c9300b006b39291ff3eso3878157eju.5
 for <virtualization@lists.linux-foundation.org>;
 Tue, 25 Jan 2022 11:43:00 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=/CbQhZ/5Q6kk2WRebj7TZprFPKvjfn/uvEP5MmtPAd8=;
 b=p4TTTL/ojvMSN4kITUKMAvmIfu1RpVCD47uYKM1hRkQGhbShV4GCnWrekoU7uxiuY0
 sIGH+2yHly360UKLxqnrHKTCxxhuW3KVXKgoNDPuNShmfDhTOfTZ6/bXzq8lhaSU25l1
 LN1YGmlekAntyW5DSKfLAj1Z+rH84biIcjKk0q6zx7uPUD8aTvXVInbXRTvGwVSzsflI
 jsoeDcQY7OGDVWD1BGjkP5W5MwgZ3gewo57ep2UP2RoAixe3jvdeK4H2RX88Hip1fzcB
 NX/QIwtHuR+/2CtgbIMD68wVHXESHI3O13tfWvQvwJSwzC7FWLA+XQWWarxh6cAHBVI6
 MTtg==
X-Gm-Message-State: AOAM532nDddR4j6+WSt/VCWs7veLOFhOWTI2e9kc/S+lnE+xZAT1hwe9
 2FN1rm+qR5NnoBE74bpIsYU0eSoMv66ySbpGKBhbnF8nTSywWq6uWuK8xrC4yYaLawBhD9PU2Ji
 NRE3+f8dmXqZJzQ0Drt1Hmtg893/G0hyBHQwr+chhow==
X-Received: by 2002:a17:906:1585:: with SMTP id
 k5mr17412047ejd.83.1643139778344; 
 Tue, 25 Jan 2022 11:42:58 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwnZgPCV7xN986ZX0Q5muMpqvLE+su6gyUnnMPXCJdYarTJ+PM9ZIhHwcANNLGGbugwWKrsVw==
X-Received: by 2002:a17:906:1585:: with SMTP id
 k5mr17412025ejd.83.1643139777949; 
 Tue, 25 Jan 2022 11:42:57 -0800 (PST)
Received: from redhat.com ([176.12.185.204])
 by smtp.gmail.com with ESMTPSA id e2sm6572490ejr.210.2022.01.25.11.42.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 25 Jan 2022 11:42:57 -0800 (PST)
Date: Tue, 25 Jan 2022 14:42:52 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Zhu Lingshan <lingshan.zhu@intel.com>
Subject: Re: [PATCH V2 4/4] vDPA/ifcvf: implement shared IRQ feature
Message-ID: <20220125143716-mutt-send-email-mst@kernel.org>
References: <20220125091744.115996-1-lingshan.zhu@intel.com>
 <20220125091744.115996-5-lingshan.zhu@intel.com>
MIME-Version: 1.0
In-Reply-To: <20220125091744.115996-5-lingshan.zhu@intel.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: netdev@vger.kernel.org, virtualization@lists.linux-foundation.org
X-BeenThere: virtualization@lists.linux-foundation.org
X-Mailman-Version: 2.1.15
Precedence: list
List-Id: Linux virtualization <virtualization.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>, 
 <mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>, 
 <mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

On Tue, Jan 25, 2022 at 05:17:44PM +0800, Zhu Lingshan wrote:
> On some platforms/devices, there may not be enough MSI vector
> slots allocated for virtqueues and config changes. In such a case,
> the interrupt sources(virtqueues, config changes) must share
> an IRQ/vector, to avoid initialization failures, keep
> the device functional.
> 
> This commit handles three cases:
> (1) number of the allocated vectors == the number of virtqueues + 1
> (config changes), every virtqueue and the config interrupt has
> a separated vector/IRQ, the best and the most likely case.
> (2) number of the allocated vectors is less than the best case, but
> greater than 1. In this case, all virtqueues share a vector/IRQ,
> the config interrupt has a separated vector/IRQ
> (3) only one vector is allocated, in this case, the virtqueues and
> the config interrupt share a vector/IRQ. The worst and most
> unlikely case.
> 
> Otherwise, it needs to fail.
> 
> This commit introduces some helper functions:
> ifcvf_set_vq_vector() and ifcvf_set_config_vector() sets virtqueue
> vector and config vector in the device config space, so that
> the device can send interrupt DMA.
> 
> This commit adds some fields in struct ifcvf_hw and re-placed
> the existed fields to be aligned with the cacheline.
> 
> Signed-off-by: Zhu Lingshan <lingshan.zhu@intel.com>
> ---
>  drivers/vdpa/ifcvf/ifcvf_base.c |  47 +++++--
>  drivers/vdpa/ifcvf/ifcvf_base.h |  23 ++-
>  drivers/vdpa/ifcvf/ifcvf_main.c | 240 +++++++++++++++++++++++++++-----
>  3 files changed, 253 insertions(+), 57 deletions(-)
> 
> diff --git a/drivers/vdpa/ifcvf/ifcvf_base.c b/drivers/vdpa/ifcvf/ifcvf_base.c
> index 397692ae671c..18dcb63ab1e3 100644
> --- a/drivers/vdpa/ifcvf/ifcvf_base.c
> +++ b/drivers/vdpa/ifcvf/ifcvf_base.c
> @@ -15,6 +15,36 @@ struct ifcvf_adapter *vf_to_adapter(struct ifcvf_hw *hw)
>  	return container_of(hw, struct ifcvf_adapter, vf);
>  }
>  
> +int ifcvf_set_vq_vector(struct ifcvf_hw *hw, u16 qid, int vector)
> +{
> +	struct virtio_pci_common_cfg __iomem *cfg = hw->common_cfg;
> +	struct ifcvf_adapter *ifcvf = vf_to_adapter(hw);
> +
> +	ifc_iowrite16(qid, &cfg->queue_select);
> +	ifc_iowrite16(vector, &cfg->queue_msix_vector);
> +	if (ifc_ioread16(&cfg->queue_msix_vector) == VIRTIO_MSI_NO_VECTOR) {
> +		IFCVF_ERR(ifcvf->pdev, "No msix vector for queue %u\n", qid);
> +			return -EINVAL;
> +	}
> +
> +	return 0;
> +}
> +
> +int ifcvf_set_config_vector(struct ifcvf_hw *hw, int vector)
> +{
> +	struct virtio_pci_common_cfg __iomem *cfg = hw->common_cfg;
> +	struct ifcvf_adapter *ifcvf = vf_to_adapter(hw);
> +
> +	cfg = hw->common_cfg;
> +	ifc_iowrite16(vector,  &cfg->msix_config);
> +	if (ifc_ioread16(&cfg->msix_config) == VIRTIO_MSI_NO_VECTOR) {
> +		IFCVF_ERR(ifcvf->pdev, "No msix vector for device config\n");
> +		return -EINVAL;
> +	}
> +
> +	return 0;
> +}
> +
>  static void __iomem *get_cap_addr(struct ifcvf_hw *hw,
>  				  struct virtio_pci_cap *cap)
>  {
> @@ -140,6 +170,8 @@ int ifcvf_init_hw(struct ifcvf_hw *hw, struct pci_dev *pdev)
>  		  hw->common_cfg, hw->notify_base, hw->isr,
>  		  hw->dev_cfg, hw->notify_off_multiplier);
>  
> +	hw->vqs_shared_irq = -EINVAL;
> +

This stuffing of errno values into u32 is not a good idea.


>  	return 0;
>  }
>  
> @@ -321,12 +353,6 @@ static int ifcvf_hw_enable(struct ifcvf_hw *hw)
>  
>  	ifcvf = vf_to_adapter(hw);
>  	cfg = hw->common_cfg;
> -	ifc_iowrite16(IFCVF_MSI_CONFIG_OFF, &cfg->msix_config);
> -
> -	if (ifc_ioread16(&cfg->msix_config) == VIRTIO_MSI_NO_VECTOR) {
> -		IFCVF_ERR(ifcvf->pdev, "No msix vector for device config\n");
> -		return -EINVAL;
> -	}
>  
>  	for (i = 0; i < hw->nr_vring; i++) {
>  		if (!hw->vring[i].ready)
> @@ -340,15 +366,6 @@ static int ifcvf_hw_enable(struct ifcvf_hw *hw)
>  		ifc_iowrite64_twopart(hw->vring[i].used, &cfg->queue_used_lo,
>  				     &cfg->queue_used_hi);
>  		ifc_iowrite16(hw->vring[i].size, &cfg->queue_size);
> -		ifc_iowrite16(i + IFCVF_MSI_QUEUE_OFF, &cfg->queue_msix_vector);
> -
> -		if (ifc_ioread16(&cfg->queue_msix_vector) ==
> -		    VIRTIO_MSI_NO_VECTOR) {
> -			IFCVF_ERR(ifcvf->pdev,
> -				  "No msix vector for queue %u\n", i);
> -			return -EINVAL;
> -		}
> -
>  		ifcvf_set_vq_state(hw, i, hw->vring[i].last_avail_idx);
>  		ifc_iowrite16(1, &cfg->queue_enable);
>  	}
> diff --git a/drivers/vdpa/ifcvf/ifcvf_base.h b/drivers/vdpa/ifcvf/ifcvf_base.h
> index 949b4fb9d554..d2a2a526f0fc 100644
> --- a/drivers/vdpa/ifcvf/ifcvf_base.h
> +++ b/drivers/vdpa/ifcvf/ifcvf_base.h
> @@ -27,8 +27,6 @@
>  
>  #define IFCVF_QUEUE_ALIGNMENT	PAGE_SIZE
>  #define IFCVF_QUEUE_MAX		32768
> -#define IFCVF_MSI_CONFIG_OFF	0
> -#define IFCVF_MSI_QUEUE_OFF	1
>  #define IFCVF_PCI_MAX_RESOURCE	6
>  
>  #define IFCVF_LM_CFG_SIZE		0x40
> @@ -42,6 +40,13 @@
>  #define ifcvf_private_to_vf(adapter) \
>  	(&((struct ifcvf_adapter *)adapter)->vf)
>  
> +/* all vqs and config interrupt has its own vector */
> +#define MSIX_VECTOR_PER_VQ_AND_CONFIG		1
> +/* all vqs share a vector, and config interrupt has a separate vector */
> +#define MSIX_VECTOR_SHARED_VQ_AND_CONFIG	2
> +/* all vqs and config interrupt share a vector */
> +#define MSIX_VECTOR_DEV_SHARED			3
> +
>  static inline u8 ifc_ioread8(u8 __iomem *addr)
>  {
>  	return ioread8(addr);
> @@ -97,25 +102,27 @@ struct ifcvf_hw {
>  	u8 __iomem *isr;
>  	/* Live migration */
>  	u8 __iomem *lm_cfg;
> -	u16 nr_vring;
>  	/* Notification bar number */
>  	u8 notify_bar;
> +	u8 msix_vector_status;
> +	/* virtio-net or virtio-blk device config size */
> +	u32 config_size;
>  	/* Notificaiton bar address */
>  	void __iomem *notify_base;
>  	phys_addr_t notify_base_pa;
>  	u32 notify_off_multiplier;
> +	u32 dev_type;
>  	u64 req_features;
>  	u64 hw_features;
> -	u32 dev_type;
>  	struct virtio_pci_common_cfg __iomem *common_cfg;
>  	void __iomem *dev_cfg;
>  	struct vring_info vring[IFCVF_MAX_QUEUES];
>  	void __iomem * const *base;
>  	char config_msix_name[256];
>  	struct vdpa_callback config_cb;
> -	unsigned int config_irq;
> -	/* virtio-net or virtio-blk device config size */
> -	u32 config_size;
> +	u32 config_irq;
> +	u32 vqs_shared_irq;
> +	u16 nr_vring;
>  };
>  
>  struct ifcvf_adapter {
> @@ -160,4 +167,6 @@ int ifcvf_set_vq_state(struct ifcvf_hw *hw, u16 qid, u16 num);
>  struct ifcvf_adapter *vf_to_adapter(struct ifcvf_hw *hw);
>  int ifcvf_probed_virtio_net(struct ifcvf_hw *hw);
>  u32 ifcvf_get_config_size(struct ifcvf_hw *hw);
> +int ifcvf_set_vq_vector(struct ifcvf_hw *hw, u16 qid, int vector);
> +int ifcvf_set_config_vector(struct ifcvf_hw *hw, int vector);
>  #endif /* _IFCVF_H_ */
> diff --git a/drivers/vdpa/ifcvf/ifcvf_main.c b/drivers/vdpa/ifcvf/ifcvf_main.c
> index 7e2af2d2aaf5..c7070ff01776 100644
> --- a/drivers/vdpa/ifcvf/ifcvf_main.c
> +++ b/drivers/vdpa/ifcvf/ifcvf_main.c
> @@ -17,6 +17,7 @@
>  #define DRIVER_AUTHOR   "Intel Corporation"
>  #define IFCVF_DRIVER_NAME       "ifcvf"
>  
> +/* handles config interrupt */
>  static irqreturn_t ifcvf_config_changed(int irq, void *arg)
>  {
>  	struct ifcvf_hw *vf = arg;
> @@ -27,6 +28,7 @@ static irqreturn_t ifcvf_config_changed(int irq, void *arg)
>  	return IRQ_HANDLED;
>  }
>  
> +/* handles vqs interrupt */
>  static irqreturn_t ifcvf_intr_handler(int irq, void *arg)
>  {
>  	struct vring_info *vring = arg;
> @@ -37,24 +39,77 @@ static irqreturn_t ifcvf_intr_handler(int irq, void *arg)
>  	return IRQ_HANDLED;
>  }
>  
> +/* handls vqs shared interrupt */
> +static irqreturn_t ifcvf_vq_shared_intr_handler(int irq, void *arg)
> +{
> +	struct ifcvf_hw *vf = arg;
> +	struct vring_info *vring;
> +	int i;
> +
> +	for (i = 0; i < vf->nr_vring; i++) {
> +		vring = &vf->vring[i];
> +		if (vring->cb.callback)
> +			vf->vring->cb.callback(vring->cb.private);
> +	}
> +
> +	return IRQ_HANDLED;
> +}
> +
> +/* handles a shared interrupt for vqs and config */
> +static irqreturn_t ifcvf_dev_shared_intr_handler(int irq, void *arg)
> +{
> +	struct ifcvf_hw *vf = arg;
> +	u8 isr;
> +
> +	isr = ifc_ioread8(vf->isr);
> +	if (isr & VIRTIO_PCI_ISR_CONFIG)
> +		ifcvf_config_changed(irq, arg);
> +
> +	return ifcvf_vq_shared_intr_handler(irq, arg);
> +}
> +
>  static void ifcvf_free_irq_vectors(void *data)
>  {
>  	pci_free_irq_vectors(data);
>  }
>  
> -static void ifcvf_free_irq(struct ifcvf_adapter *adapter, int queues)
> +static void ifcvf_free_vq_irq(struct ifcvf_adapter *adapter, int queues)
>  {
>  	struct pci_dev *pdev = adapter->pdev;
>  	struct ifcvf_hw *vf = &adapter->vf;
>  	int i;
>  
> +	if (vf->msix_vector_status == MSIX_VECTOR_PER_VQ_AND_CONFIG)
> +		for (i = 0; i < queues; i++) {
> +			devm_free_irq(&pdev->dev, vf->vring[i].irq, &vf->vring[i]);
> +			vf->vring[i].irq = -EINVAL;
> +		}
> +	else {
> +		devm_free_irq(&pdev->dev, vf->vqs_shared_irq, vf);
> +	}	vf->vqs_shared_irq = -EINVAL;

If you use {} in the else branch, use it on the then branch, too.


> +}
>  
> -	for (i = 0; i < queues; i++) {
> -		devm_free_irq(&pdev->dev, vf->vring[i].irq, &vf->vring[i]);
> -		vf->vring[i].irq = -EINVAL;
> +static void ifcvf_free_config_irq(struct ifcvf_adapter *adapter)
> +{
> +	struct pci_dev *pdev = adapter->pdev;
> +	struct ifcvf_hw *vf = &adapter->vf;
> +
> +	/* If the irq is shared by all vqs and the config interrupt,
> +	 * it is already freed in ifcvf_free_vq_irq, so here only
> +	 * need to free config irq when msix_vector_status != MSIX_VECTOR_DEV_SHARED
> +	 */
> +	if (vf->msix_vector_status != MSIX_VECTOR_DEV_SHARED) {
> +		devm_free_irq(&pdev->dev, vf->config_irq, vf);
> +		vf->config_irq = -EINVAL;
>  	}
> +}
> +
> +static void ifcvf_free_irq(struct ifcvf_adapter *adapter, int queues)
> +{
> +	struct pci_dev *pdev = adapter->pdev;
>  
> -	devm_free_irq(&pdev->dev, vf->config_irq, vf);
> +	ifcvf_free_vq_irq(adapter, queues);
> +	ifcvf_free_config_irq(adapter);
>  	ifcvf_free_irq_vectors(pdev);
>  }
>  
> @@ -81,58 +136,170 @@ static int ifcvf_alloc_vectors(struct ifcvf_adapter *adapter)
>  	return ret;
>  }
>  
> -static int ifcvf_request_irq(struct ifcvf_adapter *adapter)
> +static int ifcvf_request_per_vq_irq(struct ifcvf_adapter *adapter)
>  {
>  	struct pci_dev *pdev = adapter->pdev;
>  	struct ifcvf_hw *vf = &adapter->vf;
> -	int vector, i, ret, irq;
> -	u16 nvectors, max_intr;
> +	int i, vector, ret, irq;
>  
> -	nvectors = ifcvf_alloc_vectors(adapter);
> -	if (!(nvectors > 0))
> -		return nvectors;
> +	for (i = 0; i < vf->nr_vring; i++) {
> +		snprintf(vf->vring[i].msix_name, 256, "ifcvf[%s]-%d\n", pci_name(pdev), i);
> +		vector = i;
> +		irq = pci_irq_vector(pdev, vector);
> +		ret = devm_request_irq(&pdev->dev, irq,
> +				       ifcvf_intr_handler, 0,
> +				       vf->vring[i].msix_name,
> +				       &vf->vring[i]);
> +		if (ret) {
> +			IFCVF_ERR(pdev, "Failed to request irq for vq %d\n", i);
> +			ifcvf_free_vq_irq(adapter, i);
> +		} else {
> +			vf->vring[i].irq = irq;
> +			ifcvf_set_vq_vector(vf, i, vector);
> +		}
> +	}
>  
> -	max_intr = vf->nr_vring + 1;
> +	vf->vqs_shared_irq = -EINVAL;
> +
> +	return 0;
> +}
> +
> +static int ifcvf_request_shared_vq_irq(struct ifcvf_adapter *adapter)
> +{
> +	struct pci_dev *pdev = adapter->pdev;
> +	struct ifcvf_hw *vf = &adapter->vf;
> +	int i, vector, ret, irq;
> +
> +	vector = 0;
> +	irq = pci_irq_vector(pdev, vector);
> +	ret = devm_request_irq(&pdev->dev, irq,
> +			       ifcvf_vq_shared_intr_handler, 0,
> +			       "ifcvf_vq_shared_irq",
> +			       vf);
> +	if (ret) {
> +		IFCVF_ERR(pdev, "Failed to request shared irq for vf\n");
> +
> +		return ret;
> +	}
> +
> +	vf->vqs_shared_irq = irq;
> +	for (i = 0; i < vf->nr_vring; i++) {
> +		vf->vring[i].irq = -EINVAL;
> +		ifcvf_set_vq_vector(vf, i, vector);
> +	}
> +
> +	return 0;
> +
> +}
> +
> +static int ifcvf_request_dev_shared_irq(struct ifcvf_adapter *adapter)
> +{
> +	struct pci_dev *pdev = adapter->pdev;
> +	struct ifcvf_hw *vf = &adapter->vf;
> +	int i, vector, ret, irq;
> +
> +	vector = 0;
> +	irq = pci_irq_vector(pdev, vector);
> +	ret = devm_request_irq(&pdev->dev, irq,
> +			       ifcvf_dev_shared_intr_handler, 0,
> +			       "ifcvf_dev_shared_irq",
> +			       vf);
> +	if (ret) {
> +		IFCVF_ERR(pdev, "Failed to request shared irq for vf\n");
>  
> -	ret = pci_alloc_irq_vectors(pdev, max_intr,
> -				    max_intr, PCI_IRQ_MSIX);
> -	if (ret < 0) {
> -		IFCVF_ERR(pdev, "Failed to alloc IRQ vectors\n");
>  		return ret;
>  	}
>  
> +	vf->vqs_shared_irq = irq;
> +	for (i = 0; i < vf->nr_vring; i++) {
> +		vf->vring[i].irq = -EINVAL;
> +		ifcvf_set_vq_vector(vf, i, vector);
> +	}
> +
> +	vf->config_irq = irq;
> +	ifcvf_set_config_vector(vf, vector);
> +
> +	return 0;
> +
> +}
> +
> +static int ifcvf_request_vq_irq(struct ifcvf_adapter *adapter)
> +{
> +	struct ifcvf_hw *vf = &adapter->vf;
> +	int ret;
> +
> +	if (vf->msix_vector_status == MSIX_VECTOR_PER_VQ_AND_CONFIG)
> +		ret = ifcvf_request_per_vq_irq(adapter);
> +	else
> +		ret = ifcvf_request_shared_vq_irq(adapter);
> +
> +	return ret;
> +}
> +
> +static int ifcvf_request_config_irq(struct ifcvf_adapter *adapter)
> +{
> +	struct pci_dev *pdev = adapter->pdev;
> +	struct ifcvf_hw *vf = &adapter->vf;
> +	int config_vector, ret;
> +
> +	if (vf->msix_vector_status == MSIX_VECTOR_DEV_SHARED)
> +		return 0;
> +
> +	if (vf->msix_vector_status == MSIX_VECTOR_PER_VQ_AND_CONFIG)
> +		/* vector 0 ~ vf->nr_vring for vqs, num vf->nr_vring vector for config interrupt */
> +		config_vector = vf->nr_vring;
> +
> +	if (vf->msix_vector_status ==  MSIX_VECTOR_SHARED_VQ_AND_CONFIG)
> +		/* vector 0 for vqs and 1 for config interrupt */
> +		config_vector = 1;
> +
>  	snprintf(vf->config_msix_name, 256, "ifcvf[%s]-config\n",
>  		 pci_name(pdev));
> -	vector = 0;
> -	vf->config_irq = pci_irq_vector(pdev, vector);
> +	vf->config_irq = pci_irq_vector(pdev, config_vector);
>  	ret = devm_request_irq(&pdev->dev, vf->config_irq,
>  			       ifcvf_config_changed, 0,
>  			       vf->config_msix_name, vf);
>  	if (ret) {
>  		IFCVF_ERR(pdev, "Failed to request config irq\n");
> +		ifcvf_free_vq_irq(adapter, vf->nr_vring);
>  		return ret;
>  	}
> +		ifcvf_set_config_vector(vf, config_vector);
>  
> -	for (i = 0; i < vf->nr_vring; i++) {
> -		snprintf(vf->vring[i].msix_name, 256, "ifcvf[%s]-%d\n",
> -			 pci_name(pdev), i);
> -		vector = i + IFCVF_MSI_QUEUE_OFF;
> -		irq = pci_irq_vector(pdev, vector);
> -		ret = devm_request_irq(&pdev->dev, irq,
> -				       ifcvf_intr_handler, 0,
> -				       vf->vring[i].msix_name,
> -				       &vf->vring[i]);
> -		if (ret) {
> -			IFCVF_ERR(pdev,
> -				  "Failed to request irq for vq %d\n", i);
> -			ifcvf_free_irq(adapter, i);
> +	return 0;
> +}
>  
> -			return ret;
> -		}
> +static int ifcvf_request_irq(struct ifcvf_adapter *adapter)

This function was not moved, was it?

Try --minimal or --histogram maybe. Or just
--anchored=ifcvf_request_irq


> +{
> +	struct ifcvf_hw *vf = &adapter->vf;
> +	u16 nvectors, max_intr;
> +	int ret;
>  
> -		vf->vring[i].irq = irq;
> +	nvectors = ifcvf_alloc_vectors(adapter);
> +	if (!(nvectors > 0))
> +		return nvectors;
> +


> +	vf->msix_vector_status = MSIX_VECTOR_PER_VQ_AND_CONFIG;
> +	max_intr = vf->nr_vring + 1;
> +	if (nvectors < max_intr)
> +		vf->msix_vector_status = MSIX_VECTOR_SHARED_VQ_AND_CONFIG;
> +
> +	if (nvectors == 1) {
> +		vf->msix_vector_status = MSIX_VECTOR_DEV_SHARED;
> +		ret = ifcvf_request_dev_shared_irq(adapter);
> +
> +		return ret;
>  	}
>  
> +	ret = ifcvf_request_vq_irq(adapter);
> +	if (ret)
> +		return ret;
> +
> +	ret = ifcvf_request_config_irq(adapter);
> +
> +	if (ret)
> +		return ret;
> +
>  	return 0;
>  }
>  
> @@ -436,7 +603,10 @@ static int ifcvf_vdpa_get_vq_irq(struct vdpa_device *vdpa_dev,
>  {
>  	struct ifcvf_hw *vf = vdpa_to_vf(vdpa_dev);
>  
> -	return vf->vring[qid].irq;
> +	if (vf->vqs_shared_irq < 0)
> +		return vf->vring[qid].irq;
> +	else
> +		return -EINVAL;
>  }
>  
>  static struct vdpa_notification_area ifcvf_get_vq_notification(struct vdpa_device *vdpa_dev,
> -- 
> 2.27.0

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
