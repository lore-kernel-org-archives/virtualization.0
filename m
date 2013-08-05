From: Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH RFC V11 15/18] kvm : Paravirtual ticketlocks support for
	linux guests running on KVM hypervisor
Date: Mon, 5 Aug 2013 10:45:16 -0400 (EDT)
Message-ID: <930127352.9647991.1375713916924.JavaMail.root__9378.70376878909$1375713988$gmane$org@redhat.com>
References: <51F0ED31.3040200@linux.vnet.ibm.com>
	<20130802092539.GB28327@gmail.com>
	<20130802095406.GB30072@redhat.com>
	<20130805094603.GA29303@gmail.com>
	<20130805095901.GL2258@redhat.com>
	<20130805135222.GA32429@gmail.com>
	<1952910281.9619371.1375711538505.JavaMail.root@redhat.com>
	<51FFB937.6050003@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <51FFB937.6050003@linux.vnet.ibm.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Raghavendra K T <raghavendra.kt@linux.vnet.ibm.com>
Cc: jeremy@goop.org, linux-doc@vger.kernel.org, peterz@infradead.org, drjones@redhat.com, virtualization@lists.linux-foundation.org, andi@firstfloor.org, hpa@zytor.com, Ingo Molnar <mingo@kernel.org>, stefano stabellini <stefano.stabellini@eu.citrix.com>, xen-devel@lists.xensource.com, kvm@vger.kernel.org, x86@kernel.org, mingo@redhat.com, habanero@linux.vnet.ibm.com, riel@redhat.com, konrad wilk <konrad.wilk@oracle.com>, ouyang@cs.pitt.edu, avi kivity <avi.kivity@gmail.com>, tglx@linutronix.de, chegu vinod <chegu_vinod@hp.com>, gregkh@suse.de, linux-kernel@vger.kernel.org, srivatsa vaddagiri <srivatsa.vaddagiri@gmail.com>, attilio rao <attilio.rao@citrix.com>, torvalds@linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

> Only thing I am thinking is about KVM_FEATURE_PV_UNHALT, and
> KVM_HC_KICK_CPU definition in the below hunk, that is needed by guest
> as well. may be this header file change can be a separate patch so that
> duplicate can be handled easily during merge?

Sure, good idea.

Paolo

> I do testing of all combination after splitting and post.

> diff --git a/arch/x86/include/uapi/asm/kvm_para.h
> b/arch/x86/include/uapi/asm/kvm_para.h
> index 06fdbd9..94dc8ca 100644
> --- a/arch/x86/include/uapi/asm/kvm_para.h
> +++ b/arch/x86/include/uapi/asm/kvm_para.h
> @@ -23,6 +23,7 @@
>   #define KVM_FEATURE_ASYNC_PF           4
>   #define KVM_FEATURE_STEAL_TIME         5
>   #define KVM_FEATURE_PV_EOI             6
> +#define KVM_FEATURE_PV_UNHALT          7
> 
> diff --git a/include/uapi/linux/kvm_para.h b/include/uapi/linux/kvm_para.h
> index cea2c5c..2841f86 100644
> --- a/include/uapi/linux/kvm_para.h
> +++ b/include/uapi/linux/kvm_para.h
> @@ -19,6 +19,7 @@
>   #define KVM_HC_MMU_OP                  2
>   #define KVM_HC_FEATURES                        3
>   #define KVM_HC_PPC_MAP_MAGIC_PAGE      4
> +#define KVM_HC_KICK_CPU                        5
> 
> 
> 
