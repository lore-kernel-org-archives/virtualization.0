From: Avi Kivity <avi@qumranet.com>
Subject: Re: [kvm-devel] [RFC/PATCH 06/15] kvm-s390: sie intercept handling
Date: Fri, 21 Mar 2008 12:53:25 +0200
Message-ID: <47E393A5.2010602@qumranet.com>
References: <1206028710.6690.21.camel@cotte.boeblingen.de.ibm.com>
	<1206030302.6690.57.camel@cotte.boeblingen.de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1206030302.6690.57.camel@cotte.boeblingen.de.ibm.com>
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
Cc: EHRHARDT@de.ibm.com, arnd@arndb.de, hollisb@us.ibm.com, kvm-devel@lists.sourceforge.net, heiko.carstens@de.ibm.com, jeroney@us.ibm.com, virtualization@lists.linux-foundation.org, borntraeger@de.ibm.com, schwidefsky@de.ibm.com, rvdheij@gmail.com, os@de.ibm.com, jblunck@suse.de, "Zhang,
	Xiantao" <xiantao.zhang@intel.com>
List-Id: virtualization@lists.linuxfoundation.org

Carsten Otte wrote:
>  
>  /* for KVM_RUN, returned by mmap(vcpu_fd, offset=0) */
>  struct kvm_run {
> @@ -138,6 +139,14 @@ struct kvm_run {
>  			__u32 is_write;
>  			__u32 pad;
>  		} tpr_access;
> +		/* KVM_EXIT_S390_SIEIC */
> +		struct {
> +			__u8 icptcode;
> +			__u64 mask; /* psw upper half */
> +			__u64 addr; /* psw lower half */
> +			__u16 ipa;
> +			__u32 ipb;
> +		} s390_sieic;
>  		/* Fix the size of the union. */
>  		char padding[256];
>  	};
>
>   

Do you support 32-bit userspace on 64-bit kernel?  If so, this is likely 
badly aligned.

-- 
Any sufficiently difficult bug is indistinguishable from a feature.
