From: Srivatsa Vaddagiri <vatsa@linux.vnet.ibm.com>
Subject: Re: [PATCH 2/3] kvm hypervisor : Add hypercalls to support
	pv-ticketlock
Date: Thu, 20 Jan 2011 20:04:30 +0530
Message-ID: <20110120143430.GA17815__21205.437629442$1295534215$gmane$org@linux.vnet.ibm.com>
References: <cover.1289940821.git.jeremy.fitzhardinge@citrix.com>
	<20110119164432.GA30669@linux.vnet.ibm.com>
	<20110119171239.GB726@linux.vnet.ibm.com>
	<1295457672.28776.144.camel@laptop> <4D373340.60608@goop.org>
	<20110120115958.GB11177@linux.vnet.ibm.com>
	<1295530906.28776.171.camel@laptop>
Reply-To: vatsa@linux.vnet.ibm.com
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <1295530906.28776.171.camel@laptop>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Peter Zijlstra <peterz@infradead.org>
Cc: Xen-devel <xen-devel@lists.xensource.com>, Mathieu Desnoyers <mathieu.desnoyers@polymtl.ca>, Nick Piggin <npiggin@kernel.dk>, kvm@vger.kernel.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Jan Beulich <JBeulich@novell.com>, Eric Dumazet <dada1@cosmosbay.com>, Jeremy Fitzhardinge <jeremy.fitzhardinge@citrix.com>, suzuki@in.ibm.com, Avi Kivity <avi@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, =?iso-8859-1?Q?Am=E9rico?= Wang <xiyou.wangcong@gmail.com>, Linux Virtualization <virtualization@lists.linux-foundation.org>
List-Id: virtualization@lists.linuxfoundation.org

On Thu, Jan 20, 2011 at 02:41:46PM +0100, Peter Zijlstra wrote:
> On Thu, 2011-01-20 at 17:29 +0530, Srivatsa Vaddagiri wrote:
> > 
> > If we had a yield-to [1] sort of interface _and_ information on which vcpu
> > owns a lock, then lock-spinners can yield-to the owning vcpu, 
> 
> and then I'd nak it for being stupid ;-)
> 
> really, yield*() is retarded, never even consider using it. If you've
> got the actual owner you can do full blown PI, which is tons better than
> a 'do-something-random' call.

Yes definitely that would be much better than yield-to.

> The only reason the whole non-virt pause loop filtering muck uses it is
> because it really doesn't know anything, and do-something is pretty much
> all it can do. Its a broken interface.

- vatsa
