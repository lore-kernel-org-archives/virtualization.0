From: Carsten Otte <cotte@de.ibm.com>
Subject: Re: [kvm-devel] [RFC] KVM Source layout Proposal to accommodate new
 CPU architecture
Date: Fri, 28 Sep 2007 10:20:36 +0200
Message-ID: <46FCB954.50005__43234.9268383861$1190992860$gmane$org@de.ibm.com>
References: <42DFA526FC41B1429CE7279EF83C6BDC753A4E@pdsmsx415.ccr.corp.intel.com>
	<46FB7566.9030504@qumranet.com>
Reply-To: carsteno@de.ibm.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <46FB7566.9030504@qumranet.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: "Zhang, Xiantao" <xiantao.zhang@intel.com>
Cc: kvm-devel@lists.sourceforge.net, virtualization <virtualization@lists.linux-foundation.org>
List-Id: virtualization@lists.linuxfoundation.org

> Zhang, Xiantao wrote:
> 	We are working on enabling KVM support on IA64 platform, and now
> Linux, Windows guests get stable run and achieve reasonable performance
> on KVM with Open GFW. But you know, the current KVM only considers x86
> platform, and is short of cross-architecture framework. Currently, we
> have a proposal for KVM source layout to accommodate new CPU
> architectures.
That's great. I agree that general restructure of current x86 code is 
needed to fit different archs proper. I do strongly appreciate your 
efforts towards this.

> 1. Add subdirectories, such as x86 and ia64 to hold arch-specific code.
I would prefer Avis move to /virt prior to that. But then we'll need 
arch specific subdirectories. I think they should go to 
/arch/<arch>/kvm. That would involve the architecure maintainers, 
which gives us more peer review.

> 2. Split kvm_main.c to two parts. One is still called kvm_main.c, just
> contains KVM common interfaces with user space, and basic KVM
> infrastructure. The other one is named as kvm_arch.c under sub-directory
> (eg. X86, ia64 etc), which includes arch-specific code to supplement the
> functionality of kvm_main.c
I disagree with the split you've made. I think we should try to keep 
as much as possible common, rather then just duplicating the efforts 
for each architecture we have. Thus, I do prefer to refine a clean 
architecutre backend interface based on the current vmx/svm split. We 
just need to move x86 specifics to a "kvm-x86" library, on which 
kvm-intel, kvm-amd and maybe kvm-rusty do depend. Interfacing to there 
needs to go via the same function vector we use for svm/vmx today.

> 3. Add an "include" directory in drivers/kvm. Due to possibly complex
> code logic in KVM source, maybe many header files need to maintain for
> some architectures. If we put them under top-level include/asm-arch
> directory, it may introduce much more maintain effort. So, we put it
> under "drivers/kvm", and let it be effective when kernel configuration
> time.
To me, they clearly belong to include/arch.

so long,
Carsten
