From: Avi Kivity <avi@qumranet.com>
Subject: Re: [kvm-devel] [RFC] KVM Source layout Proposal to accommodate new
 CPU architecture
Date: Fri, 28 Sep 2007 19:03:46 +0200
Message-ID: <46FD33F2.9090506__38522.1739685678$1190998485$gmane$org@qumranet.com>
References: <42DFA526FC41B1429CE7279EF83C6BDC753A4E@pdsmsx415.ccr.corp.intel.com>	<46FB7566.9030504@qumranet.com>	<42DFA526FC41B1429CE7279EF83C6BDC753E73@pdsmsx415.ccr.corp.intel.com>	<46FD1392.1080905@qumranet.com>
	<42DFA526FC41B1429CE7279EF83C6BDC754031@pdsmsx415.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=GB2312
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <42DFA526FC41B1429CE7279EF83C6BDC754031@pdsmsx415.ccr.corp.intel.com>
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

Zhang, Xiantao wrote:
> Hi Avi,
> 	So you mean IA64 can adopt the similar method as well? 

What method do you mean exactly?

> But even so, I am still thinking we have to come out a solution for checking IA64 code into existing KVM upstream tree , because KVM infrastructure in mainline Linux may been a long way to go. Moreover, we also have no method to avoid the abstraction for existing code to support cross-architecture framework before what you pointed gets happen. For example, kvm_main.c is also required to split as common interface for all architectures. So, I think it has no big conflicts between our proposal and the final KVM infrastructure in mainline Linux. How about your ideas? :)
>   

The powerpc people had some patches to make kvm_main arch independent.
We should work on that base.

To avoid a dependency on the x86 merge, we can start by working withing
drivers/kvm/, for example creating drivers/kvm/x86.c and
drivers/kvm/ia64.c. Later patches can move these to arch/*/.

-- 
Do not meddle in the internals of kernels, for they are subtle and quick to panic.
