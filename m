From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH 2/3] kvm hypervisor : Add hypercalls to support
	pv-ticketlock
Date: Wed, 19 Jan 2011 18:50:15 +0100
Message-ID: <1295459415.28776.146.camel__46471.7385046699$1295459431$gmane$org@laptop>
References: <cover.1289940821.git.jeremy.fitzhardinge@citrix.com>
	<20110119164432.GA30669@linux.vnet.ibm.com>
	<20110119171239.GB726@linux.vnet.ibm.com>
	<20110119172306.GA2863@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20110119172306.GA2863@linux.vnet.ibm.com>
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

On Wed, 2011-01-19 at 22:53 +0530, Srivatsa Vaddagiri wrote:
> On Wed, Jan 19, 2011 at 10:42:39PM +0530, Srivatsa Vaddagiri wrote:
> > Add two hypercalls to KVM hypervisor to support pv-ticketlocks.
> > 
> > KVM_HC_WAIT_FOR_KICK blocks the calling vcpu until another vcpu kicks it or it
> > is woken up because of an event like interrupt.
> 
> One possibility is to extend this hypercall to do a directed yield as well, 
> which needs some more thought. Another issue that needs to be resolved with
> pv-ticketlocks is the impact on intra-VM fairness. A guest experiencing heavy
> contention can keep yielding cpu, allowing other VMs to get more time than they
> deserve.

No, yield sucks, if you know the owner you can do actual PI.
