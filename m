From: Jeremy Fitzhardinge <jeremy@goop.org>
Subject: Re: [02/17][PATCH] Implement smp_call_function_mask for ia64 - V8
Date: Mon, 31 Mar 2008 08:02:22 -0700
Message-ID: <47F0FCFE.5010106__28820.9146274768$1206976217$gmane$org@goop.org>
References: <42DFA526FC41B1429CE7279EF83C6BDC01048240@pdsmsx415.ccr.corp.intel.com>
	<47F0AB18.2010707@sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <47F0AB18.2010707@sgi.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Jes Sorensen <jes@sgi.com>
Cc: Carsten Otte <cotte@de.ibm.com>, "Luck, Tony" <tony.luck@intel.com>, linux-ia64@vger.kernel.org, kvm-ia64-devel@lists.sourceforge.net, kvm-devel@lists.sourceforge.net, virtualization@lists.linux-foundation.org, "Xu,
	Anthony" <anthony.xu@intel.com>, "Zhang, Xiantao" <xiantao.zhang@intel.com>
List-Id: virtualization@lists.linuxfoundation.org

Jes Sorensen wrote:
> I'm a little wary of the performance impact of this change. Doing a
> cpumask compare on all smp_call_function calls seems a little expensive.
> Maybe it's just noise in the big picture compared to the actual cost of
> the IPIs, but I thought I'd bring it up.
>
> Keep in mind that a cpumask can be fairly big these days, max NR_CPUS
> is currently 4096. For those booting a kernel with NR_CPUS at 4096 on
> a dual CPU machine, it would be a bit expensive.
>   

Unless your hardware has remarkably fast IPIs, I think really the cost 
of scanning 512 bytes is going to be in the noise...

This change has been on the x86 side for ages, and not even Ingo made a 
peep about it ;)

> Why not keep smp_call_function() the way it was before, rather than
> implementing it via the call to smp_call_function_mask()?
>   

Because Xen needs a different core implementation (because of its 
different IPI implementation), and it would be better to just have to do 
one of them rather than N.

    J
