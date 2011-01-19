From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH 2/3] kvm hypervisor : Add hypercalls to support
	pv-ticketlock
Date: Wed, 19 Jan 2011 18:21:12 +0100
Message-ID: <1295457672.28776.144.camel__29317.5461738885$1295457794$gmane$org@laptop>
References: <cover.1289940821.git.jeremy.fitzhardinge@citrix.com>
	<20110119164432.GA30669@linux.vnet.ibm.com>
	<20110119171239.GB726@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20110119171239.GB726@linux.vnet.ibm.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: vatsa@linux.vnet.ibm.com
Cc: Xen-devel <xen-devel@lists.xensource.com>, Mathieu Desnoyers <mathieu.desnoyers@polymtl.ca>, Nick Piggin <npiggin@kernel.dk>, kvm@vger.kernel.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Jan Beulich <JBeulich@novell.com>, Eric Dumazet <dada1@cosmosbay.com>, Jeremy Fitzhardinge <jeremy.fitzhardinge@citrix.com>, suzuki@in.ibm.com, Avi Kivity <avi@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, =?ISO-8859-1?Q?Am=E9rico?= Wang <xiyou.wangcong@gmail.com>, Linux Virtualization <virtualization@lists.linux-foundation.org>
List-Id: virtualization@lists.linuxfoundation.org

On Wed, 2011-01-19 at 22:42 +0530, Srivatsa Vaddagiri wrote:
> Add two hypercalls to KVM hypervisor to support pv-ticketlocks.
> 
> KVM_HC_WAIT_FOR_KICK blocks the calling vcpu until another vcpu kicks it or it
> is woken up because of an event like interrupt.
> 
> KVM_HC_KICK_CPU allows the calling vcpu to kick another vcpu.
> 
> The presence of these hypercalls is indicated to guest via
> KVM_FEATURE_WAIT_FOR_KICK/KVM_CAP_WAIT_FOR_KICK. Qemu needs a corresponding
> patch to pass up the presence of this feature to guest via cpuid. Patch to qemu
> will be sent separately.


I didn't really read the patch, and I totally forgot everything from
when I looked at the Xen series, but does the Xen/KVM hypercall
interface for this include the vcpu to await the kick from?

My guess is not, since the ticket locks used don't know who the owner
is, which is of course, sad. There are FIFO spinlock implementations
that can do this though.. although I think they all have a bigger memory
footprint.

The reason for wanting this should be clear I guess, it allows PI.
