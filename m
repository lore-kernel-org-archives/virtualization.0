From: Hollis Blanchard <hollisb@us.ibm.com>
Subject: Re: [RFC/PATCH 05/15] KVM_MAX_VCPUS
Date: Thu, 20 Mar 2008 11:43:03 -0500
Message-ID: <1206031383.6356.13.camel__16440.3581679382$1206031769$gmane$org@basalt>
References: <1206028710.6690.21.camel@cotte.boeblingen.de.ibm.com>
	<1206030298.6690.56.camel@cotte.boeblingen.de.ibm.com>
Reply-To: Hollis Blanchard <hollisb@us.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1206030298.6690.56.camel@cotte.boeblingen.de.ibm.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Carsten Otte <cotte@de.ibm.com>
Cc: aliguori@us.ibm.com, EHRHARDT@de.ibm.com, arnd@arndb.de, kvm-devel@lists.sourceforge.net, heiko.carstens@de.ibm.com, jeroney@us.ibm.com, virtualization@lists.linux-foundation.org, borntraeger@de.ibm.com, schwidefsky@de.ibm.com, rvdheij@gmail.com, os@de.ibm.com, jblunck@suse.de, "Zhang,
	Xiantao" <xiantao.zhang@intel.com>
List-Id: virtualization@lists.linuxfoundation.org

On Thu, 2008-03-20 at 17:24 +0100, Carsten Otte wrote:
> Index: kvm/include/linux/kvm_host.h
> ===================================================================
> --- kvm.orig/include/linux/kvm_host.h
> +++ kvm/include/linux/kvm_host.h
> @@ -24,7 +24,11 @@
> 
>  #include <asm/kvm_host.h>
> 
> +#ifdef CONFIG_S390
> +#define KVM_MAX_VCPUS 64
> +#else
>  #define KVM_MAX_VCPUS 16
> +#endif
>  #define KVM_MEMORY_SLOTS 32
>  /* memory slots that does not exposed to userspace */
>  #define KVM_PRIVATE_MEM_SLOTS 4
> 
Why don't we just define this in <asm/kvm_host.h> ?

-- 
Hollis Blanchard
IBM Linux Technology Center
