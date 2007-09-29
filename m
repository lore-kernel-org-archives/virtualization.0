From: Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: [kvm-devel] [RFC] KVM Source layout Proposal to accommodate
	new CPU architecture
Date: Sat, 29 Sep 2007 23:06:51 +1000
Message-ID: <1191071211.26950.28.camel__20660.1969003261$1191071446$gmane$org@localhost.localdomain>
References: <42DFA526FC41B1429CE7279EF83C6BDC753A4E@pdsmsx415.ccr.corp.intel.com>
	<46FB7566.9030504@qumranet.com>
Mime-Version: 1.0
Content-Type: text/plain
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
To: Avi Kivity <avi@qumranet.com>
Cc: kvm-devel@lists.sourceforge.net, Sam Ravnborg <sam@ravnborg.org>, "Zhang,
	Xiantao" <xiantao.zhang@intel.com>, virtualization <virtualization@lists.linux-foundation.org>
List-Id: virtualization@lists.linuxfoundation.org

On Thu, 2007-09-27 at 11:18 +0200, Avi Kivity wrote:
> The whole drivers/kvm/ thing was just a trick to get merged quickly.  I
> think the new layout should be something like
> 
>   virt/kvm/, include/linux/kvm*.h -> common code
>   virt/lguest/ -> the other hypervisor
>   virt/virtio/ -> shared I/O infrastructure
>   virt/ -> the CONFIG_VIRTIALIZATION menu
>   arch/x86/kvm/, include/asm-x86/ -> x86 specific code
>   arch/ia64/kvm/, include/asm-ia64/ -> ia64 specific code

The problem with this separation is that module source cannot span
directories (at least, not that I could find).

This is why lguest went for "i386_" prefix for arch separation.

Cheers,
Rusty.
