From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH 2/7] kvm/vfio: detect assigned device via irqbypass manager
Date: Sun, 12 Jul 2020 17:06:27 -0400
Message-ID: <20200712170518-mutt-send-email-mst@kernel.org>
References: <1594565366-3195-1-git-send-email-lingshan.zhu@intel.com>
 <1594565366-3195-2-git-send-email-lingshan.zhu@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1594565366-3195-2-git-send-email-lingshan.zhu@intel.com>
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
To: Zhu Lingshan <lingshan.zhu@intel.com>
Cc: wanpengli@tencent.com, kvm@vger.kernel.org, netdev@vger.kernel.org, sean.j.christopherson@intel.com, virtualization@lists.linux-foundation.org, pbonzini@redhat.com, "./0000-cover-letter.patch"@redhat.com
List-Id: virtualization@lists.linuxfoundation.org

On Sun, Jul 12, 2020 at 10:49:21PM +0800, Zhu Lingshan wrote:
> We used to detect assigned device via VFIO manipulated device
> conters. This is less flexible consider VFIO is not the only
> interface for assigned device. vDPA devices has dedicated
> backed hardware as well. So this patch tries to detect
> the assigned device via irqbypass manager.
> 
> We will increase/decrease the assigned device counter in kvm/x86.
> Both vDPA and VFIO would go through this code path.
> 
> This code path only affect x86 for now.
> 
> Signed-off-by: Zhu Lingshan <lingshan.zhu@intel.com>


I think it's best to leave VFIO alone. Add appropriate APIs for VDPA,
worry about converting existing users later.

> ---
>  arch/x86/kvm/x86.c | 10 ++++++++--
>  virt/kvm/vfio.c    |  2 --
>  2 files changed, 8 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
> index 00c88c2..20c07d3 100644
> --- a/arch/x86/kvm/x86.c
> +++ b/arch/x86/kvm/x86.c
> @@ -10624,11 +10624,17 @@ int kvm_arch_irq_bypass_add_producer(struct irq_bypass_consumer *cons,
>  {
>  	struct kvm_kernel_irqfd *irqfd =
>  		container_of(cons, struct kvm_kernel_irqfd, consumer);
> +	int ret;
>  
>  	irqfd->producer = prod;
> +	kvm_arch_start_assignment(irqfd->kvm);
> +	ret = kvm_x86_ops.update_pi_irte(irqfd->kvm,
> +					 prod->irq, irqfd->gsi, 1);
> +
> +	if (ret)
> +		kvm_arch_end_assignment(irqfd->kvm);
>  
> -	return kvm_x86_ops.update_pi_irte(irqfd->kvm,
> -					   prod->irq, irqfd->gsi, 1);
> +	return ret;
>  }
>  
>  void kvm_arch_irq_bypass_del_producer(struct irq_bypass_consumer *cons,
> diff --git a/virt/kvm/vfio.c b/virt/kvm/vfio.c
> index 8fcbc50..111da52 100644
> --- a/virt/kvm/vfio.c
> +++ b/virt/kvm/vfio.c
> @@ -226,7 +226,6 @@ static int kvm_vfio_set_group(struct kvm_device *dev, long attr, u64 arg)
>  		list_add_tail(&kvg->node, &kv->group_list);
>  		kvg->vfio_group = vfio_group;
>  
> -		kvm_arch_start_assignment(dev->kvm);
>  
>  		mutex_unlock(&kv->lock);
>  
> @@ -254,7 +253,6 @@ static int kvm_vfio_set_group(struct kvm_device *dev, long attr, u64 arg)
>  				continue;
>  
>  			list_del(&kvg->node);
> -			kvm_arch_end_assignment(dev->kvm);
>  #ifdef CONFIG_SPAPR_TCE_IOMMU
>  			kvm_spapr_tce_release_vfio_group(dev->kvm,
>  							 kvg->vfio_group);
> -- 
> 1.8.3.1
