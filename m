From: Rik van Riel <riel@redhat.com>
Subject: Re: [PATCH 2/3] kvm hypervisor : Add hypercalls to support
	pv-ticketlock
Date: Sat, 22 Jan 2011 09:53:46 -0500
Message-ID: <4D3AEF7A.1050709__18045.0635999025$1295708128$gmane$org@redhat.com>
References: <cover.1289940821.git.jeremy.fitzhardinge@citrix.com>
	<20110119164432.GA30669@linux.vnet.ibm.com>
	<20110119171239.GB726@linux.vnet.ibm.com>
	<1295457672.28776.144.camel@laptop> <4D373340.60608@goop.org>
	<20110120115958.GB11177@linux.vnet.ibm.com>
	<4D38774B.6070704@goop.org>
	<20110121140208.GA13609@linux.vnet.ibm.com>
	<4D399CBD.10506@redhat.com>
	<20110122061417.GA7258@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20110122061417.GA7258@linux.vnet.ibm.com>
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
Cc: Xen-devel <xen-devel@lists.xensource.com>, Mathieu Desnoyers <mathieu.desnoyers@polymtl.ca>, Nick Piggin <npiggin@kernel.dk>, kvm@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Jan Beulich <JBeulich@novell.com>, Eric Dumazet <dada1@cosmosbay.com>, Jeremy Fitzhardinge <jeremy.fitzhardinge@citrix.com>, suzuki@in.ibm.com, Avi Kivity <avi@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, =?UTF-8?B?QW3DqXJpY28g?= =?UTF-8?B?V2FuZw==?= <xiyou.wangcong@gmail.com>, Linux Virtualization <virtualization@lists.linux-foundation.org>
List-Id: virtualization@lists.linuxfoundation.org

On 01/22/2011 01:14 AM, Srivatsa Vaddagiri wrote:

> Also it may be possible for the pv-ticketlocks to track owning vcpu and make use
> of a yield-to interface as further optimization to avoid the
> "others-get-more-time" problem, but Peterz rightly pointed that PI would be a
> better solution there than yield-to. So overall IMO kvm_vcpu_on_spin+yield_to
> could be the best solution for unmodified guests, while paravirtualized
> ticketlocks + some sort of PI would be a better solution where we have the
> luxury of modifying guest sources!

Agreed, for unmodified guests (which is what people will mostly be
running for the next couple of years), we have little choice but
to use PLE + kvm_vcpu_on_spin + yield_to.

The main question that remains is whether the PV ticketlocks are
a large enough improvement to also merge those.  I expect they
will be, and we'll see so in the benchmark numbers.

-- 
All rights reversed
