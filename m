From: Dor Laor <dor.laor@gmail.com>
Subject: Re: [PATCH] KVM: add KVM_SYNC_SHADOW_WITH_USER ioctl
Date: Wed, 09 Jan 2008 00:56:07 +0200
Message-ID: <4783FF87.3080209__45809.46931751$1199833266$gmane$org@qumranet.com>
References: <20080108153915.GB21726@dmt>
Reply-To: dor.laor@qumranet.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20080108153915.GB21726@dmt>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Marcelo Tosatti <marcelo@kvack.org>
Cc: kvm-devel <kvm-devel@lists.sourceforge.net>, Anthony Liguori <aliguori@us.ibm.com>, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

Marcelo Tosatti wrote:
> The host needs to zap its shadow entries before performing an inflate
> operation to avoid the guest from using stale ones.
>
> So add an ioctl to interface with kvm_mmu_zap_all().
>
> Signed-off-by: Marcelo Tosatti <mtosatti@redhat.com>
>
> Index: kvm.quilt/virt/kvm/kvm_main.c
> ===================================================================
> --- kvm.quilt.orig/virt/kvm/kvm_main.c
> +++ kvm.quilt/virt/kvm/kvm_main.c
> @@ -971,6 +971,11 @@ static long kvm_vm_ioctl(struct file *fi
>  			goto out;
>  		break;
>  	}
> +	case KVM_SYNC_SHADOW_WITH_USER: {
> +		r = 0;
> +		kvm_mmu_zap_all(kvm);
> +		break;
> +	}
>   
It should go into the arch ioctl below since the mmu is under x86
>  	default:
>  		r = kvm_arch_vm_ioctl(filp, ioctl, arg);
>  	}
>
>
>   
