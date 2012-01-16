From: Avi Kivity <avi@redhat.com>
Subject: Re: [PATCH RFC V4 5/5] Documentation/kvm : Add documentation on
	Hypercalls and features used for PV spinlock
Date: Mon, 16 Jan 2012 11:00:41 +0200
Message-ID: <4F13E739.7040300@redhat.com>
References: <20120114182501.8604.68416.sendpatchset@oc5400248562.ibm.com>
	<20120114182710.8604.22277.sendpatchset@oc5400248562.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20120114182710.8604.22277.sendpatchset@oc5400248562.ibm.com>
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
Cc: Jeremy Fitzhardinge <jeremy@goop.org>, linux-doc@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>, Jan Kiszka <jan.kiszka@siemens.com>, Virtualization <virtualization@lists.linux-foundation.org>, Paul Mackerras <paulus@samba.org>, "H. Peter Anvin" <hpa@zytor.com>, Stefano Stabellini <stefano.stabellini@eu.citrix.com>, Xen <xen-devel@lists.xensource.com>, Dave Jiang <dave.jiang@intel.com>, KVM <kvm@vger.kernel.org>, Glauber Costa <glommer@redhat.com>, X86 <x86@kernel.org>, Ingo Molnar <mingo@redhat.com>, Rik van Riel <riel@redhat.com>, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, Srivatsa Vaddagiri <vatsa@linux.vnet.ibm.com>, Sasha Levin <levinsasha928@gmail.com>, Sedat Dilek <sedat.dilek@gmail.com>, Thomas Gleixner <tglx@linutronix.de>, Greg Kroah-Hartman <gregkh@suse.de>, LKML <linux-kernel@vger.kernel.org>, Dave Hansen <dave@linux.vnet.ibm.com>, Suzuki
List-Id: virtualization@lists.linuxfoundation.org

On 01/14/2012 08:27 PM, Raghavendra K T wrote:
> +
> +5. KVM_HC_KICK_CPU
> +------------------------
> +value: 5
> +Architecture: x86
> +Purpose: Hypercall used to wakeup a vcpu from HLT state
> +
> +Usage example : A vcpu of a paravirtualized guest that is busywaiting in guest
> +kernel mode for an event to occur (ex: a spinlock to become available)
> +can execute HLT instruction once it has busy-waited for more than a
> +threshold time-interval. Execution of HLT instruction would cause
> +the hypervisor to put the vcpu to sleep (unless yield_on_hlt=0) until occurence
> +of an appropriate event. Another vcpu of the same guest can wakeup the sleeping
> +vcpu by issuing KVM_HC_KICK_CPU hypercall, specifying APIC ID of the vcpu to be
> +wokenup.

Wait, what happens with yield_on_hlt=0?  Will the hypercall work as
advertised?

> +
> +TODO:
> +1. more information on input and output needed?
> +2. Add more detail to purpose of hypercalls.
>


-- 
error compiling committee.c: too many arguments to function
