From: Jes Sorensen <jes@sgi.com>
Subject: Re: [02/17][PATCH] Implement smp_call_function_mask for ia64 - V8
Date: Mon, 31 Mar 2008 11:12:56 +0200
Message-ID: <47F0AB18.2010707__22921.2882266895$1206974987$gmane$org@sgi.com>
References: <42DFA526FC41B1429CE7279EF83C6BDC01048240@pdsmsx415.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <42DFA526FC41B1429CE7279EF83C6BDC01048240@pdsmsx415.ccr.corp.intel.com>
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
Cc: Carsten Otte <cotte@de.ibm.com>, "Luck, Tony" <tony.luck@intel.com>, linux-ia64@vger.kernel.org, kvm-ia64-devel@lists.sourceforge.net, kvm-devel@lists.sourceforge.net, virtualization@lists.linux-foundation.org, "Xu,
	Anthony" <anthony.xu@intel.com>
List-Id: virtualization@lists.linuxfoundation.org

Zhang, Xiantao wrote:
>>From 697d50286088e98da5ac8653c80aaa96c81abf87 Mon Sep 17 00:00:00 2001
> From: Xiantao Zhang <xiantao.zhang@intel.com>
> Date: Mon, 31 Mar 2008 09:50:24 +0800
> Subject: [PATCH] KVM:IA64: Implement smp_call_function_mask for ia64
> 
> This function provides more flexible interface for smp
> infrastructure.
> Signed-off-by: Xiantao Zhang <xiantao.zhang@intel.com>

Hi Xiantao,

I'm a little wary of the performance impact of this change. Doing a
cpumask compare on all smp_call_function calls seems a little expensive.
Maybe it's just noise in the big picture compared to the actual cost of
the IPIs, but I thought I'd bring it up.

Keep in mind that a cpumask can be fairly big these days, max NR_CPUS
is currently 4096. For those booting a kernel with NR_CPUS at 4096 on
a dual CPU machine, it would be a bit expensive.

Why not keep smp_call_function() the way it was before, rather than
implementing it via the call to smp_call_function_mask()?

Cheers,
Jes
